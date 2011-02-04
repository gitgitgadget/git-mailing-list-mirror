From: Jeff King <peff@peff.net>
Subject: Re: moving to a git-backed wiki
Date: Fri, 4 Feb 2011 01:03:06 -0500
Message-ID: <20110204060306.GA2455@sigill.intra.peff.net>
References: <7vzkqg4x2h.fsf_-_@alter.siamese.dyndns.org>
 <20110131225529.GC14419@sigill.intra.peff.net>
 <AANLkTimHCp_JKUw1keJoA4zD_q7Sci+rOwPeAs_T=7xH@mail.gmail.com>
 <20110201201144.GA16003@sigill.intra.peff.net>
 <AANLkTikfzzELUaN3B+20rh9D51St8mUYs4p-WYjp8JVV@mail.gmail.com>
 <4D488DCD.3080305@eaglescrag.net>
 <4D4929F4.3020805@snarc.org>
 <4D4A11D7.4040103@eaglescrag.net>
 <20110203174518.GA14871@sigill.intra.peff.net>
 <AANLkTikshY8qHoFvghSu8q21j5Unp==Hf583OE2tkNrS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "J.H." <warthog19@eaglescrag.net>, Vincent Hanquez <tab@snarc.org>,
	Jay Soffian <jaysoffian@gmail.com>,
	Scott Chacon <schacon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 04 07:03:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlElP-0003yH-2Y
	for gcvg-git-2@lo.gmane.org; Fri, 04 Feb 2011 07:03:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752073Ab1BDGDP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Feb 2011 01:03:15 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:44797 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751195Ab1BDGDO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Feb 2011 01:03:14 -0500
Received: (qmail 5660 invoked by uid 111); 4 Feb 2011 06:03:10 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 04 Feb 2011 06:03:10 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Feb 2011 01:03:06 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTikshY8qHoFvghSu8q21j5Unp==Hf583OE2tkNrS@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166022>

On Thu, Feb 03, 2011 at 08:06:34PM +0100, Sverre Rabbelier wrote:

> On Thu, Feb 3, 2011 at 18:45, Jeff King <peff@peff.net> wrote:
> > Most of us don't really care if git is the ultimate storage mechanism. I
> > could even build the git interface as a purely client thing on top of
> > the CGI interface; the problem is that scraping the wiki pages for new
> > versions over the net would be horribly inefficient.
> 
> Note that MediaWiki has a stable API that you could use instead :).

The initial import is still pretty painful over the network, but at
least I know I am getting accurate data from the API now. And I can
share the git repository, and just use the RecentChanges API to get
updates.

The result is at:

  https://github.com/peff/wikitest/wiki

You can see an example of the full history:

  https://github.com/peff/wikitest/wiki/_history

or a page history:

  https://github.com/peff/wikitest/wiki/GitFaq/_history

Or download the repository for yourself:

  git://github.com/peff/wikitest.wiki.git

The whole git wiki is about a 4M git repository (and at least some of
that is spam that's deleted but still in the history).

This is has been a cute exercise, but I'm not sure mirroring it in a
gollum wiki really makes sense. It's cool that gollum understands
MediaWiki enough to actually render the pages at all, but there are
obviously lots of corner cases that it just doesn't get (formatting
issues, missing images, some redirect naming issues).

Still, it's useful as a local repo doing diffs. I just wrote the initial
importer (which I'm happy to share if somebody wants to see some ugly
code), but to act as a useful client, it still needs:

  1. Incremental updating from the RecentChanges API.

  2. Push support (or more likely something similar to "git svn
     dcommit") to push edits back.

-Peff

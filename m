From: Jeff King <peff@peff.net>
Subject: Re: [HELP] Adding git awareness to the darning patch management
 system.
Date: Thu, 1 Dec 2011 18:40:42 -0500
Message-ID: <20111201234042.GA7294@sigill.intra.peff.net>
References: <4ED59232.3000807@users.sourceforge.net>
 <20111130072248.GG5317@sigill.intra.peff.net>
 <4ED6D0DB.3060800@users.sourceforge.net>
 <20111201062733.GB22141@sigill.intra.peff.net>
 <4ED80EA2.80805@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Peter Williams <peter_ono@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Fri Dec 02 00:40:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWGFK-0002ZM-FK
	for gcvg-git-2@lo.gmane.org; Fri, 02 Dec 2011 00:40:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755585Ab1LAXkr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Dec 2011 18:40:47 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59360
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755365Ab1LAXko (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Dec 2011 18:40:44 -0500
Received: (qmail 21891 invoked by uid 107); 1 Dec 2011 23:47:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 01 Dec 2011 18:47:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Dec 2011 18:40:42 -0500
Content-Disposition: inline
In-Reply-To: <4ED80EA2.80805@users.sourceforge.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186198>

On Fri, Dec 02, 2011 at 09:32:50AM +1000, Peter Williams wrote:

> Yes, I think your right.  For most of my purposes, I think that it's
> irrelevant whether a change is staged or not and the choices that I
> offer allow the user to do what he thinks is right for a file with
> changes that are staged but uncommitted.  For me to automatically do
> something based on whether the file was staged for a commit would be
> a mistake as I would be reducing the user's options.
> 
> However, the distinction might be worth making in the file tree
> display to remind the user what's staged and what's not?

I'd personally start with ignoring the distinction, and then wait for
some enterprising user to suggest how it would be marked. That takes the
burden off of you for guessing what representation would be best.

> As an aside, I found it easier to delve into git's innards to find
> out how to implement git binary patches than I did finding out how to
> do things from the CLI :-).

Heh. I think that is because the CLI is written by people (myself
included) who want it to give them access to git's innards. ;)

> >In your case, I think "status" is the most convenient level of
> >abstraction for you, because you are interesting in looking at
> >differences to both the index and HEAD (i.e., the prior commit). But if
> >you find as you implement that want more flexibility, you can switch to
> >using the lower-level commands yourself.
> 
> I'll investigate this approach.  How easy is it to distinguish low
> level commands from high level commands?

git(1) has a list of "porcelain" and "plumbing" commands. If you are
scripting, you generally want to stick with plumbing commands,
lower-level whose output and behavior remains stable across releases.

However, some porcelain commands offer a "plumbing" mode (despite the
name, the "--porcelain" flag to some commands is what you want; it is
about offering parseable output that a custom porcelain could use. In
git lingo, your interface is one such porcelain).

-Peff

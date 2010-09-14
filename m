From: Jeff King <peff@peff.net>
Subject: Re: Coping with the pull-before-you-push model
Date: Tue, 14 Sep 2010 01:24:51 -0400
Message-ID: <20100914052451.GA15839@sigill.intra.peff.net>
References: <4C8866F9.1040705@workspacewhiz.com>
 <AANLkTikY55ZJvSTqyFKLqwABqnJZuODz3yrc7CFvQf0K@mail.gmail.com>
 <4C88F2A9.2080306@workspacewhiz.com>
 <AANLkTikdV3W1d7uNokKRRiT4FeznL1uM=Y9SQLDqgAic@mail.gmail.com>
 <20100910141527.GA6936@sigill.intra.peff.net>
 <4C8EFE62.7080908@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jon Seymour <jon.seymour@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Tue Sep 14 07:24:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvO0j-000669-P2
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 07:24:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752094Ab0INFYs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Sep 2010 01:24:48 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:44410 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751286Ab0INFYr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Sep 2010 01:24:47 -0400
Received: (qmail 12307 invoked by uid 111); 14 Sep 2010 05:24:45 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 14 Sep 2010 05:24:45 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Sep 2010 01:24:51 -0400
Content-Disposition: inline
In-Reply-To: <4C8EFE62.7080908@workspacewhiz.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156161>

On Mon, Sep 13, 2010 at 10:47:30PM -0600, Joshua Jensen wrote:

> >Bear in mind that you can still shift to a maintainer model, but keep
> >the maintainer automated. That is, you can queue up "to-pull" heads, and
> >then have an automated process pull them one by one and do some basic QA
> >(does it merge, does it build, does it pass automated tests, etc). Which
> >is not that different from what many shops do in the non-maintainer
> >model, except that when you break the build, the maintainer process
> >notices _before_ publishing the merged tip, so everybody won't try to
> >build on your broken crap.
> >
> Do you know of any existing software that does this?  This may be
> ideal in the short term.

I think that Avery Pennarun's gitbuilder may do what you want:

  http://github.com/apenwarr/gitbuilder/

but I've never used it.

I seem to recall from one of Shawn's presentations on Gerrit Code Review
that it does something like this, too, but I can't seem to find any docs
about it in my brief search:

  http://code.google.com/p/gerrit/

It may be that Gerrit doesn't handle building itself, but that the
Android project is running something alongside it. Shawn may be able to
say more.

Basically, what we are talking about is continuous integration, with the
slight twist that instead of developers pushing commits to a mainline
branch which is built and tested, we would build and test their commits
and then merge them to the mainline branch.

Systems like Hudson that do continuous integration and support git may
handle a workflow like this, but I don't know (I've only ever used
Hudson in the everything-goes-to-svn-trunk model).

There is also a small continuous integration system that lives in the
contrib/continuous directory of git.git itself. It's quite old at this
point, but I wouldn't be surprised if its descendant is what Gerrit
uses.

-Peff

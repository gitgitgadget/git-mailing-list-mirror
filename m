From: Alan Mackenzie <acm@muc.de>
Subject: Re: "git stash pop" is doing an unwanted "git add" when there are
	conflicts.
Date: Tue, 29 Dec 2015 21:20:38 +0000
Message-ID: <20151229212038.GD1884@acm.fritz.box>
References: <20151221142953.GA12764@acm.fritz.box>
	<1450772258.7937.9.camel@kaarsemaker.net>
	<20151222093032.GA5173@sigill.intra.peff.net>
	<20151224092038.GA2397@acm.fritz.box>
	<20151229075329.GA9254@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dennis Kaarsemaker <dennis@kaarsemaker.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 29 22:19:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aE1fc-0001IJ-1j
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 22:19:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753718AbbL2VS2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2015 16:18:28 -0500
Received: from mail.muc.de ([193.149.48.3]:17199 "EHLO mail.muc.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753613AbbL2VS0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 16:18:26 -0500
Received: (qmail 66603 invoked by uid 3782); 29 Dec 2015 21:18:22 -0000
Received: from acm.muc.de (p579E804C.dip0.t-ipconnect.de [87.158.128.76]) by
	colin.muc.de (tmda-ofmipd) with ESMTP;
	Tue, 29 Dec 2015 22:18:20 +0100
Received: (qmail 20423 invoked by uid 1000); 29 Dec 2015 21:20:38 -0000
Content-Disposition: inline
In-Reply-To: <20151229075329.GA9254@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Delivery-Agent: TMDA/1.1.12 (Macallan)
X-Primary-Address: acm@muc.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283148>

Hello, Jeff.

On Tue, Dec 29, 2015 at 02:53:30AM -0500, Jeff King wrote:
> On Thu, Dec 24, 2015 at 09:20:38AM +0000, Alan Mackenzie wrote:

> > > It seems to be a side effect of merge-recursive to stage the results,
> > > and in the no-conflict path we explicitly reset the index. For the
> > > conflicting case, it's trickier, because we would want to retain the
> > > unmerged entries.

> > > So I agree it's kind of weird, but the conflicting case is inherently
> > > going to touch the index, and you'd generally have to `git add` to mark
> > > the resolutions (but if you really want to just touch the working tree,
> > > you'd need to `git reset`).

> > From the point of view of a user, this is suboptimal.  git stash is an
> > abstraction: the preservation of uncomitted changes for later.  Staging
> > previously unstaged changes with git stash pop severely damages this
> > abstraction.

> Yeah, I think I agree. But keep in mind that we have to mention the
> conflicts _somewhere_, so we're going to touch the index regardless (and
> the user is going to have to erase the conflicts in the index
> eventually, either with `git add` or `git reset`).

When the stash consists entirely of changes in the working directory,
and "git stash pop" has conflicts, why can't these conflicts simply be
marked by "<<<<<<<<" (etc.) in the working directory, leaving the index
unchanged?  The index is left unchanged when there are no conlicts.

> > Are there any prospects of this getting fixed?

> Somebody needs to write a patch. I am not 100% convinced that it
> _should_ be fixed, but I am leaning that way. But I am not planning to
> work on it myself anytime soon. The best way to get more discussion
> going is to post a patch. :)

Hmm.  I would very much prefer to remain just a user of git.

> -Peff

-- 
Alan Mackenzie (Nuremberg, Germany).

From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Adds 'stash.index' configuration option
Date: Thu, 12 May 2011 04:22:10 -0400
Message-ID: <20110512082210.GA16813@sigill.intra.peff.net>
References: <D80C1130-8DE6-457E-B203-FCF25B8ED72C@gmail.com>
 <4DCB88C1.20105@drmicha.warpmail.net>
 <20110512080425.GA11870@sigill.intra.peff.net>
 <4DCB96F9.2020700@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Pisoni <dpisoni@gmail.com>,
	GIt Mailing List <git@vger.kernel.org>,
	Git Maintainer <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu May 12 10:22:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKRAF-0001Z9-KD
	for gcvg-git-2@lo.gmane.org; Thu, 12 May 2011 10:22:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754223Ab1ELIWP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2011 04:22:15 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33216
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751475Ab1ELIWL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2011 04:22:11 -0400
Received: (qmail 11186 invoked by uid 107); 12 May 2011 08:24:09 -0000
Received: from sigill-wired.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.8)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 12 May 2011 04:24:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 May 2011 04:22:10 -0400
Content-Disposition: inline
In-Reply-To: <4DCB96F9.2020700@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173449>

On Thu, May 12, 2011 at 10:14:49AM +0200, Michael J Gruber wrote:

> > I would love to see something like this, but have we yet figured out all
> > of the issues, like:
> > 
> >   1. How do scripts wanting to call git programs suppress expansion of
> >      uiopts when they want predictable behavior?
> > 
> >   2. Depending on the solution to (1), how do scripts specify that they
> >      _do_ want to allow uiopts (e.g., because they know they are
> >      presenting the output to the user) for certain commands?
> > 
> >   3. Depending on (1) and (2), how do scripts differentiate when some
> >      options are OK in uiopts, but others are not? For example, it may
> >      be desirable for an invocation of diff-tree to have renames turned
> >      on by the user, but not for them to change the output format.
> > 
> 
> We haven't figured that out, but was the consensus: "Whatever, let's
> just keep adding single options." ?

I don't know. But short of coming up with a more global solution, what
do you want to do in the meantime? Forbid new config options of this
sort? I didn't see any consensus on that, either.

I'm not trying to be hostile, btw. I don't know what the right solution
is.

> > As much as it sucks to have a config option for each individual option,
> > there is at least some oversight of which options will not cause too
> > much of a problem when triggered automatically.
> 
> I just think we have too many commands which are ui and are used in
> scripts (e.g. log, commit, stash, just to name a few) for being able to
> decide that ourselves. Are we saying that people using "git stash" in a
> script have to deal themselves with a breakage caused by "--index" being
> a default for some users now?

I intentionally withheld any judgement on whether "stash --index" is a
safe option to add or not. I think that is a separate issue from whether
one should add such options, if they are considered safe.

> With a generic approach, we could protect all git-sh-setup using scripts
> right from the start, for example, while still allowing to override some
> options or to protect only a few (based on the explicit wishes of a
> uiopts-aware script).

Absolutely a solution like that would be better. Do you have a
particular proposal in mind? I know we've discussed it before, but I
didn't remember ever reaching any consensus on the right solution.

-Peff

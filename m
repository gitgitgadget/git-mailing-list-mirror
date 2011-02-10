From: Jeff King <peff@peff.net>
Subject: Re: git fetch,git merge and git rebase
Date: Thu, 10 Feb 2011 18:03:38 -0500
Message-ID: <20110210230337.GB21335@sigill.intra.peff.net>
References: <1297315789338-6010561.post@n2.nabble.com>
 <4D5464E7.2010407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 11 00:03:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnfY8-0002uQ-5s
	for gcvg-git-2@lo.gmane.org; Fri, 11 Feb 2011 00:03:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757272Ab1BJXDj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Feb 2011 18:03:39 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:46308 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755794Ab1BJXDi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Feb 2011 18:03:38 -0500
Received: (qmail 22308 invoked by uid 111); 10 Feb 2011 23:03:37 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 10 Feb 2011 23:03:37 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Feb 2011 18:03:38 -0500
Content-Disposition: inline
In-Reply-To: <4D5464E7.2010407@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166513>

On Thu, Feb 10, 2011 at 04:21:27PM -0600, Neal Kreitzinger wrote:

> another definition of git-rebase:
> 
> git-rebase:  the MOST DANGEROUS command in git.  you can easily
> DESTROY your repo if you don't know what you're doing!  Until you get
> the hang of it, always make a copy of the before-image of the branch
> your rebasing (mybranch) by doing a "git checkout mybranch" and then
> "git branch copy-of-mybranch".  Then if you destroy mybranch you can
> recover it from copy-of-mybranch.

I won't claim that rebase isn't easy to shoot yourself in the foot with,
but I think this advice is a little over-the-top. Rather than backing up
branches, you would do better to learn about reflogs, as the reflog of
mybranch will contain the original version. As will the reflog of HEAD,
though if you have screwed up too badly, the reflog of mybranch will
probably be a lot simpler to read.

You can see it with "git reflog show mybranch"; when you see the commit
that you want to restore to, you can:

  git branch -f mybranch mybranch@{whatever}

to restore it there. That provides more-or-less the same safety as a
backup branch (reflogs do expire, but something like three months
later), plus it helps you in all the cases where you forgot to make a
backup before screwing things up. :)

-Peff

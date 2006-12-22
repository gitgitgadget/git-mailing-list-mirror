From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 3/3] Don't crash during repack of a reflog with pruned commits.
Date: Thu, 21 Dec 2006 19:56:06 -0500
Message-ID: <20061222005606.GA14773@spearce.org>
References: <be6b1443171482e1930bd7744a0218db0c03d611.1166748450.git.spearce@spearce.org> <20061222004906.GC14789@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 01:56:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxYhr-0003tt-2A
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 01:56:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423171AbWLVA4L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 19:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423147AbWLVA4L
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 19:56:11 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:58001 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423171AbWLVA4J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 19:56:09 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GxYha-0005iI-3U; Thu, 21 Dec 2006 19:55:58 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 74E1820FB65; Thu, 21 Dec 2006 19:56:06 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20061222004906.GC14789@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35107>

"Shawn O. Pearce" <spearce@spearce.org> wrote:
> If the user has been using reflog for a long time (e.g. since its
> introduction) then it is very likely that an existing branch's
> reflog may still mention commits which have long since been pruned
> out of the repository.
> 
> Rather than aborting with a very useless error message during
> git-repack, pack as many valid commits as we can get from the
> reflog and let the user know that the branch's reflog contains
> already pruned commits.  A future 'git reflog expire' (or whatever
> it finally winds up being called) can then be performed to expunge
> those reflog entries.

If its not obvious from the patch, this doesn't entirely fix the
problem.

Just because the commit has not been pruned does not mean that a blob
or tree referenced by that commit has not been pruned.  Right now
I am missing 1 blob and cannot repack because of it.

At least with this series of 3 patches the error message resulting
from this one missing blob is clearer.

-- 
Shawn.

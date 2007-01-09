From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Recovering from an aborted git-rebase?
Date: Tue, 9 Jan 2007 18:29:49 -0500
Message-ID: <20070109232949.GB30023@spearce.org>
References: <45A42341.8040304@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 10 00:30:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4QPl-0002AW-GK
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 00:29:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932524AbXAIX3y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 18:29:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932527AbXAIX3y
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 18:29:54 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:34394 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932524AbXAIX3x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 18:29:53 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H4QPW-0005Id-0e; Tue, 09 Jan 2007 18:29:42 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0A2B520FBAE; Tue,  9 Jan 2007 18:29:49 -0500 (EST)
To: Steven Grimm <koreth@midwinter.com>
Content-Disposition: inline
In-Reply-To: <45A42341.8040304@midwinter.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36422>

Steven Grimm <koreth@midwinter.com> wrote:
> Got this from one of the other people here who's using git. Luckily he 
> was able to restore his repo from a filesystem snapshot, so no permanent 
> harm done, but what's the pure-git way to recover from this? Are the 
> revisions in question really gone?

Try `git lost-found` before you use `git prune` (or also now `git gc`).

Also, if you have relogs enabled on your work branches (and I hope
you do, as its now the default) you can look at the branch from
earlier, e.g.:

	git log HEAD@{5.minutes.ago}
or
	git log HEAD@{1}

to look at HEAD was just before `git rebase` did the reset.  Which
would be the commit you lost, but want back.


Unfortunately we don't really have a reflog viewing utility yet so
you just have to sort of guess around with the @{...} syntax to find
what you are looking for.  But if you can locate the correct SHA1
for the last commit you want back you can do a `git reset --hard $sha1`
to restore your working branch, then do the rebase the way you meant to.
 
-- 
Shawn.

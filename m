From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Merge non-first refs that match first refspec
Date: Fri, 28 Sep 2007 00:48:24 -0400
Message-ID: <20070928044824.GV3099@spearce.org>
References: <Pine.LNX.4.64.0709272351010.5926@iabervon.org> <20070928041509.GU3099@spearce.org> <Pine.LNX.4.64.0709280026240.5926@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Sep 28 06:48:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ib7mI-0008I7-1N
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 06:48:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755411AbXI1Esa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2007 00:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755491AbXI1Es3
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 00:48:29 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:46416 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755014AbXI1Es3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2007 00:48:29 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Ib7mm-0005Vu-2L; Fri, 28 Sep 2007 00:49:08 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A83C520FBAE; Fri, 28 Sep 2007 00:48:24 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0709280026240.5926@iabervon.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59360>

Daniel Barkalow <barkalow@iabervon.org> wrote:
> Beats me; Junio, what's your test case?

If I understood him correctly it is this:

	mkdir foo; cd foo; git init
	git config remote.origin.url git://repo.or.cz/alt-git.git
	git config remote.origin.fetch refs/heads/master:refs/remotes/origin/master
	git config --add remote.origin.fetch refs/heads/maint:refs/remotes/origin/maint
	git pull

We should see "master" listed in .git/FETCH_HEAD as a "for-merge"
and "maint" listed as a "not-for-merge"...

But if that remote.origin.fetch was a wildcard spec this shouldn't
happen as the results are unpredictable.  But above the user
explicitly put master first, so it should be defaulted to.

-- 
Shawn.

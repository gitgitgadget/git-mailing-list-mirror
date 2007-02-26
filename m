From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: autoCRLF, git status, git-gui, what is the desired behavior?
Date: Sun, 25 Feb 2007 21:06:57 -0500
Message-ID: <20070226020657.GA1884@spearce.org>
References: <45E1E47C.5090908@verizon.net> <7vlkimrp1f.fsf@assigned-by-dhcp.cox.net> <45E1F6B5.8030907@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Mark Levedahl <mlevedahl@verizon.net>,
	Git Mailing List <git@vger.kernel.org>
To: Mark Levedahl <mdl123@verizon.net>
X-From: git-owner@vger.kernel.org Mon Feb 26 03:07:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLVGf-000074-1c
	for gcvg-git@gmane.org; Mon, 26 Feb 2007 03:07:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbXBZCHF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Feb 2007 21:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751050AbXBZCHF
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Feb 2007 21:07:05 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:38612 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751042AbXBZCHE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Feb 2007 21:07:04 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HLVGL-0006O4-Jt; Sun, 25 Feb 2007 21:06:49 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 63C0020FBAE; Sun, 25 Feb 2007 21:06:58 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <45E1F6B5.8030907@verizon.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40603>

Mark Levedahl <mdl123@verizon.net> wrote:
> Also, if I invoke git-gui on the above repository showing foo as modified...
> 
> 1) foo shows up in the "Changed But Not Updated" list.
> 2) Clicking on foo gives message box with "No differences detected. ...
>    Clicking the "ok" button invokes a rescan, back to step 1.
> 3) Adding foo to the commit list in git-gui works.
> 4) Committing the above from git-gui gives a commit with no
>    changes (commit is made, shows up in git log, but has no
>    changes associated).
> 
> --- I don't think git-gui should make create an empty commit in the 
> above case.

Hmm.  Probably not.  In pg I used to compare HEAD^{tree} to the
tree output by git-write-tree and refuse to make the commit if
they had the same value.  git-gui just blindly assumes that if a
file is staged for committing then it won't make an empty commit;
this is also the behavior in git-commit.sh.

Yet in the case of a merge you may want the same tree and not even
realize it.  Like if I merge a commit from a coworker, get a merge
conflict, pick my version, but that just modified the tree to match
mine, effectively doing an `-s ours` style merge.  Of course here
we have MERGE_HEAD and know we are merging...

-- 
Shawn.

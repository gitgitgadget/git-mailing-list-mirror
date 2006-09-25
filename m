From: Shawn Pearce <spearce@spearce.org>
Subject: Re: fsck objects and timestamp ordering
Date: Mon, 25 Sep 2006 12:40:04 -0400
Message-ID: <20060925164004.GB27043@spearce.org>
References: <9e4733910609250932r146fea7alaaf858a18a8b50b0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 25 18:40:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRtVB-00051b-AA
	for gcvg-git@gmane.org; Mon, 25 Sep 2006 18:40:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbWIYQkK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Sep 2006 12:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbWIYQkK
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Sep 2006 12:40:10 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:27297 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751250AbWIYQkJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Sep 2006 12:40:09 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GRtUu-0003SJ-8v; Mon, 25 Sep 2006 12:40:00 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id AAD8E20FB28; Mon, 25 Sep 2006 12:40:04 -0400 (EDT)
To: Jon Smirl <jonsmirl@gmail.com>
Content-Disposition: inline
In-Reply-To: <9e4733910609250932r146fea7alaaf858a18a8b50b0@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27743>

Jon Smirl <jonsmirl@gmail.com> wrote:
> When running fsck objects, does it verify that timestamps are ordered
> in the same order as the dependency chains?

No and it can't.  Clock skew between systems could be several
minutes to several hours which means you may have earlier commits
building onto later commits.

The better place to check this (although we don't today) is in
git-commit-tree.  If the new commit's committer timestamp is older
than any of its parent's committer timestamps git-commit-tree
should probably at least issue a warning that there's a possible
timestamp problem on either this system or the system that created
one of those parent commits.

If the committer has a problem with that timestamp issue they could
address it and ammend the commit before the error propagates.
 
> I am having trouble with a CVS repository where the timestamp ordering
> and dependency order are in conflict. It would be best if git didn't
> experience the same problem.

It would be best if Git didn't experience a lot of the weird stuff
people were able to do to their CVS repositories.  Fortunately the
friendly folks on this mailing list have put the better part of a
year and a half into doing just that.  :)

-- 
Shawn.

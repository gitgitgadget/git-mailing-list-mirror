From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [RFC] git commit --branch
Date: Mon, 29 May 2006 17:35:43 -0400
Message-ID: <20060529213543.GA29054@spearce.org>
References: <20060529202851.GE14325@admingilde.org> <20060529204158.GC28538@spearce.org> <20060529212249.GF14325@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 29 23:36:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkpPX-00080w-SG
	for gcvg-git@gmane.org; Mon, 29 May 2006 23:36:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbWE2VgF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 17:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751394AbWE2VgB
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 17:36:01 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:62180 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751352AbWE2Vfr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 May 2006 17:35:47 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FkpOj-0007Va-2F; Mon, 29 May 2006 17:35:37 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C7C4120E445; Mon, 29 May 2006 17:35:43 -0400 (EDT)
To: Martin Waitz <tali@admingilde.org>
Content-Disposition: inline
In-Reply-To: <20060529212249.GF14325@admingilde.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20977>

Martin Waitz <tali@admingilde.org> wrote:
> On Mon, May 29, 2006 at 04:41:58PM -0400, Shawn Pearce wrote:
> > Interesting.  I have been kicking around doing the very same
> > thing myself but just have not gotten around to it.  Its complex,
> > especially if the current HEAD isn't strictly the merge commit
> > between the topic branch and the previous value of HEAD; in that
> > case you may want to replay the commits which are on HEAD but are
> > post the merge commit using a form of git-rebase.  Except you would
> > want to preserve any merges which happened by remerging them rather
> > than simply exporting a massive patch and reapplying it.
> 
> Perhaps something like merge-recursive makes sense, except that
> I have no clue how it works ;-)

merge-recursive isn't the right tool here. Its job is to perform a
3 way merge "quickly" by dealing with file adds, deletes, renames
and patch application when a file was modified by both parents.

Now that diff+apply is probably faster than a 3 way merge in
read-tree precisely because it doesn't need to run merge-recursive
I'm starting to look at how we can use apply to do partial
application of a patch and use RCS' diff3 or just drop a reject
file out when a hunk doesn't apply cleanly.
 
> But then an operation as important as commit has to be bullet-proof
> and I don't like to do anything complex in there.

I agree.  But I'd like to see some sort of functionality to
automatically handle some common topic branche cases in commit.
Of course I consider the current commit tool to already be too
complex (like being able to pull the commit message from any
random commit).

-- 
Shawn.

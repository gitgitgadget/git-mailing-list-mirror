X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Trim hint printed when gecos is empty.
Date: Tue, 28 Nov 2006 10:31:44 -0500
Message-ID: <20061128153144.GB28337@spearce.org>
References: <ekh2uh$nk2$1@sea.gmane.org> <200611281403.36370.andyparkins@gmail.com> <Pine.LNX.4.63.0611281536230.30004@wbgn013.biozentrum.uni-wuerzburg.de> <200611281506.53518.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 28 Nov 2006 15:32:11 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200611281506.53518.andyparkins@gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32537>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gp4w4-00082l-5N for gcvg-git@gmane.org; Tue, 28 Nov
 2006 16:31:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758683AbWK1Pbs (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 10:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758690AbWK1Pbs
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 10:31:48 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:8321 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1758683AbWK1Pbs
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 10:31:48 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Gp4vs-0005K9-Po; Tue, 28 Nov 2006 10:31:40 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 DC91020FB7F; Tue, 28 Nov 2006 10:31:44 -0500 (EST)
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins <andyparkins@gmail.com> wrote:
> > So I will never need something like you suggest. Having said that, if you
> > think it is best for you to mark every commit as signed-off-by you, just
> > add an alias:
> >
> > 	git repo-config --global alias.c "commit -s"
> 
> That requires that I introduce a new command; I want the existing command to 
> do The Right Thing.  Also; I certainly wouldn't want it global, as I said in 
> my original message - this is a per-project choice.  Some projects don't have 
> Signed-Off lines, so there is no point there.
> 
> Ideally, I'd be able to do
>         git repo-config alias.commit "commit -s"
> Just as I can with shell commands.

Long ago we decided that aliasing over shipped commands was a baaaad
idea, as it might get a shell script into trouble when all of a
sudden the "-s" option is being given to every commit invocation.

But you can install a commit-msg hook (.git/hooks/commit-msg)
in any project you want to ensure a Signed-off-by line is in the
commit message for.  Its handed the COMMIT_EDITMSG file, which is
what the message will be generated from.  Looking at the code for
git-commit.sh its perfectly OK if the hook edits the file too.

Further the hook could be interactive, prompting the user "are
you sure you don't want to sign this commit?" or can be skipped by
handing --no-verify to commit.


I just learned about commit-msg hook the other day when I was reading
through git-commit.sh and noticed I didn't implement invoking that
particular hook in git-gui...

-- 

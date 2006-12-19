X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Only warn about missing branch.<n>.merge in pull.
Date: Tue, 19 Dec 2006 01:54:07 -0500
Message-ID: <20061219065407.GB2511@spearce.org>
References: <7virg9xcvw.fsf@assigned-by-dhcp.cox.net> <20061218202803.GB28925@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 19 Dec 2006 06:54:23 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061218202803.GB28925@mellanox.co.il>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34791>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GwYrh-0005g4-MO for gcvg-git@gmane.org; Tue, 19 Dec
 2006 07:54:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752963AbWLSGyO (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 01:54:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753027AbWLSGyO
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 01:54:14 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:55062 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1752963AbWLSGyN (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006
 01:54:13 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GwYrY-0001dv-JG; Tue, 19 Dec 2006 01:54:08 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 9753120FB65; Tue, 19 Dec 2006 01:54:07 -0500 (EST)
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Sender: git-owner@vger.kernel.org

"Michael S. Tsirkin" <mst@mellanox.co.il> wrote:
> > Quoting r. Junio C Hamano <junkio@cox.net>:
> > I can see a few possibilities:
> > 
> >  (1) people do not interact with multiple remote repositories
> >      regularly, so this is not a problem in practice.
> > 
> >  (2) people do, but "the first branch listed" rule is good
> >      enough in practice.  Because they would always say "git
> >      pull second which-branch" instead if they want something
> >      different, this is a non-issue.
> > 
> >  (3) branch.$current.merge was a mistake.  It should have been
> >      branch.$current.merge.$remote.  In other words, the
> >      configuration should have been about the current branch and
> >      the remote repository pair.
> > 
> >  (4) the current configuration mechanism is fine, but the code
> >      is not.  We should forbid "the first branch listed" rule
> >      from being applied for "git pull second", and require the
> >      users to explicitly say which branch(es) to merge.
> > 
> > I am inclined to say that (1) is possible, (2) is implausible
> > (otherwise we would not have done 62b339a5 for the same reason),
> > (3) is confused, and probably (4) is what we need.
> 
> As a person who tracks multiple remotes in one repository,
> I would say (4) best matches what I do.
> 
> So I currently always do git fetch <remote> to download changes,
> and always use git pull . <branch> to merge a specific branch.

Agreed; #4 best matches what I (and those I work with on that ugly
repository of mine) do.

My git.git repository currently just fetches all of Junio's branches
right into my local refs/heads.  I fetch every day or so, but never
merge from next into any branch.  Though I create branches off next,
master, or some select commit based on whatever topic I'm hacking.

In my other repositories I tend to fetch before merging, for a
number of reasons:

 a) Its distributed backup; if I fetch the branch that's one more copy.

 b) I can easily view a branch's recent changes, but not affect my
    own topics until I'm ready to take them in.  People often ask
	me to look at their changes, or wonder why something is suddenly
	acting odd - looking at the commits in gitk usually tells me
	quite quickly who did what.  :-)

 c) I can easily start a new topic off any recent change.

 d) I can easily merge topics once they are local and reviewed.

a,b,d are not quite as necessary in an email-patch based group such
as git itself, as the mailing list offers most of the reasons I
fetch first.  b and c are just convience there.

-- 

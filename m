X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [RFC] Submodules in GIT
Date: Tue, 21 Nov 2006 02:21:37 -0500
Message-ID: <20061121072137.GC3332@spearce.org>
References: <20061120215116.GA20736@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 21 Nov 2006 07:21:59 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061120215116.GA20736@admingilde.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31975>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmPx5-0004s7-9B for gcvg-git@gmane.org; Tue, 21 Nov
 2006 08:21:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934223AbWKUHVv (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 02:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934337AbWKUHVv
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 02:21:51 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:60634 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S934223AbWKUHVv
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 02:21:51 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GmPwv-0007pO-R9; Tue, 21 Nov 2006 02:21:45 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 2694B20FB09; Tue, 21 Nov 2006 02:21:38 -0500 (EST)
To: Martin Waitz <tali@admingilde.org>
Sender: git-owner@vger.kernel.org

Martin Waitz <tali@admingilde.org> wrote:
> I am currently working on adding submodule support to GIT.
> Here I am presenting some prototyping work to show how submodules could
> be implemented in GIT.

Aside from a GUI for Git that I can give to a non-technical
user and have them be productive with (and without getting "this
sucks!" complaints from them), submodule support is the next highest
priority feature for me in Git.  So as soon as I can get git-gui
to that point I'll probably redirect as much of my "Git time"
as I can to testing your submodule implementation.
 
> When a merge in the parent has to resolve changes in the submodule,
> then it does exactly the same as for files: at first it is tried to resolve
> it in the index and if this is not possible it will have store stages 1-3
> in the index and tries a content merge.  The only difference with submodules
> is that the content merge is not possible with a simple diff3 call, but
> that the GIT merge machinery has to recurse into the submodule.

Right.  And what's really cool about that is many times a subproject
merge will be trivial, so top level project merges will be still be
trivial in index merges.  But what's complicated about that is you
need to make sure the subproject working directory is fast-forwarded
to the new commit.  :)
 
> The most important next step is to commit to some object database format
> for submodules.  So please, do give feedback about the proposed changes
> to the tree object.

I think the S_IFSOCK approach is the right way to go here, and thus
I'm reasonably happy with this repository format.  But Linus and
Junio do tend to be better at this than I... :-)

-- 

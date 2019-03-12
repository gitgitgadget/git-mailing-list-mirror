Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PLING_QUERY,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB06620248
	for <e@80x24.org>; Tue, 12 Mar 2019 17:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729324AbfCLRW6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 13:22:58 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:45112 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728966AbfCLRW4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 13:22:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=IjxUT/ht9YWrf51/vZZEGDL/8EANxHGbXwM/H5+HJgA=; b=lgD/gEbBBa870DQ2fcvRSpNd/T
        N45iKkV6fmbVP912ses6u7drQ7l0t5u7+ti3h6O3rAsYf/5RagAi1mVvDI8AF5ArjBCd5tS7teBHt
        EgWJU1SSZZrca4FokKxHuKSBf+J+I5rWRkFRDVqiP2+XzP/rMCAs1o6qTSAdgPp7/4s4XJ1MKL54S
        nVmTBESPYMAhJ70WxCWOzFETmI0sn9P/4XmV3lbMuNB7mGFtiicSqAQd/OWQ9fYycbD9Ej/RO0mt+
        Zh7zNUH/O8/l3Xvri9Nmm+I8IL6jagnNaREcXyGQ9eV0cLRELuvZbszz0He+WAH7Ng+xFokjU7/Nw
        P8sX4bCQ==;
Received: from cpef81d0f814063-cmf81d0f814060.cpe.net.cable.rogers.com ([174.114.57.56]:56626 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1h3l77-00BPhU-0Z
        for git@vger.kernel.org; Tue, 12 Mar 2019 13:22:54 -0400
Date:   Tue, 12 Mar 2019 13:22:51 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: why does "git revert" commit even if i try to bail with ":q!"?
Message-ID: <alpine.LFD.2.21.1903121317020.16391@localhost.localdomain>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-OutGoing-Spam-Status: No, score=0.1
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel4.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel4.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel4.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


  never noticed this before ... when i do a regular "git commit" and
enter my "vi" edit session and change my mind, i can bail with ":q!",
regardless of what i've set up as a commit message, and i'll see:

  Aborting commit due to empty commit message.

however, i was just playing with "git revert" and, after i ran:

  $ git revert <commit SHA>

i was dumped into another vi edit session:

Revert "HTTP->HTTPS"

This reverts commit 2965b41fd84a1a76f56984ecdf6c123d1992730f.

# Please enter the commit message for your changes. Lines starting
# with '#' will be ignored, and an empty message aborts the commit.
#
# On branch master
# Your branch is up to date with 'rpjday/master'.
#
# Changes to be committed:
#       modified:   book/01-introduction/sections/installing.asc
#

  again, simulating that i changed my mind, i just typed ":q!", but
the revert went ahead, anyway. i tried again, this time completely
deleting all the lines from the commit msg (as the template
suggested), but the revert *still* completed after typing ":q!".

  it was only after deleting all the lines and using ":wq" that the
revert was cancelled:

  Aborting commit due to empty commit message.

that seems ... inconsistent. am i misunderstanding something?

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================

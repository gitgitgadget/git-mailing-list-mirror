Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A0F81F51C
	for <e@80x24.org>; Thu, 24 May 2018 11:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969259AbeEXLrv (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 07:47:51 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:43196 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967135AbeEXLrs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 07:47:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0qjr+sJ39URCtN40IUsbU5gCjLOYSmtblhEJfVMlkWM=; b=E7RetfGo0SPWHJLOZMFArZ6koQ
        an9mQl31kjuj6ozA0ebb96fs0Cmmk264Oj8WCnPPjAe+gczxyGc4dmvhkkU1jeHPDo5zt/fx8kOmW
        18qOOgNpEPKIIwwFSfDLhCtFVsU6v6NNtURkPlwhie05z7H9huEHhfDY96tKg4dWvsPI0LfUc61vi
        BSa4y/1RAOH54ImWICLRy2HZLYCCn+8Nc/PLiG/cPFkoozsbGeDllXK4cOzotKAfNzsb5Izu+QgXc
        bU6GcGfDG1Dume7iZWub5DedzBQYHHLskUDVG3lSKpdNoBcwjFYHYk/xeCL21voIyouLt5v/vHKsY
        +JlDVZHw==;
Received: from cpeac202e043973-cmac202e043970.cpe.net.cable.rogers.com ([174.112.22.87]:19649 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1fLoif-00GNsB-39
        for git@vger.kernel.org; Thu, 24 May 2018 07:47:46 -0400
Date:   Thu, 24 May 2018 07:45:50 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: is the standard "[<options>]", and not "[options]" or other?
Message-ID: <alpine.LFD.2.21.1805240738260.6091@localhost.localdomain>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-OutGoing-Spam-Status: No, score=-0.2
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


  more pedantry -- was digging through "man git-diff" and noticed the
inconsistency in how options are represented. first, in the synopsis,
you see "[options]":

  SYNOPSIS
    git diff [options] [<commit>] [--] [<path>...]
    git diff [options] --cached [<commit>] [--] [<path>...]
    git diff [options] <commit> <commit> [--] [<path>...]
    git diff [options] <blob> <blob>
    git diff [options] [--no-index] [--] <path> <path>

while just below that in DESCRIPTION, it's all "[--options]":

  git diff [--options] [--] [<path>...]
           ^^^^^^^^^^^

a further search produced this from RelNotes/2.7.0.txt:

  "A couple of commands still showed "[options]" in their usage string
   to note where options should come on their command line, but we
   spell that "[<options>]" in most places these days."

so, "git diff -h" does in fact use the allegedly encouraged syntax:

  $ git diff -h
  usage: git diff [<options>] [<commit> [<commit>]] [--] [<path>...]
  $

but should the man pages be updated similarly? i can whip up a patch
for that unless someone wants to comment on this further.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================

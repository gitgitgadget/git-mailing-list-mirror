Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5770620248
	for <e@80x24.org>; Fri, 22 Feb 2019 13:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfBVNWQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 08:22:16 -0500
Received: from cpanel4.indieserve.net ([199.212.143.9]:58198 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfBVNWQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 08:22:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=BLRUUUB7lI06e/aPNzmSkp+LKSKD7NNXiH/1lD833VM=; b=MIsexhow4DzdAIgGTbsjBkdiTp
        FgfOK6Bub2jza7qU1QTzwUUrhZJQ681c1gYweQwgeA7nI4jfUaEF6Jpo+YRQxb3obV8PTz6O3Jlfy
        72fXnQYLHtK33Zbpj1QrI2D5mFc+AeeV5LtNgLojXhZ3WfdpuaISgHLSmVMQq6ughVLlSBZ2v9IGF
        W1fbb74mBiBE/P9l6bkbVR+LYqH+Lp7qdrOaqILvcstE6mhAOyvWXRksNfH76gntb37EuFYXp5cd1
        +Tp6QS/7euFX+d7RCfs1+0vhBx+EDW9OMfM9QPC2XHJMPleEs1XadSCGh/r24alE7tRGswW4g257G
        dRJ61n6g==;
Received: from cpeac202e043973-cmac202e043970.cpe.net.cable.rogers.com ([174.112.22.87]:38044 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1gxAmL-00BLBg-V9
        for git@vger.kernel.org; Fri, 22 Feb 2019 08:22:14 -0500
Date:   Fri, 22 Feb 2019 08:22:12 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: how does one interpret "git diff <commit> ^<commit>"
Message-ID: <alpine.LFD.2.21.1902220816010.6353@localhost.localdomain>
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


  was perusing the git FAQ and ran across this:

  How do I obtain a list of files which have changed in a given commit?

     $ git diff --name-only <commit>^!


after playing with "git rev-parse", i figured out that the above was
equivalent to (using kernel "v4.19" tag as an example):

$ git diff v4.19 ^v4.19^
diff --git a/Makefile b/Makefile
index bf3786e4ffec..69fa5c0310d8 100644
--- a/Makefile
+++ b/Makefile
@@ -2,8 +2,8 @@
 VERSION = 4
 PATCHLEVEL = 19
 SUBLEVEL = 0
-EXTRAVERSION = -rc8
-NAME = Merciless Moray
+EXTRAVERSION =
+NAME = "People's Front"

 # *DOCUMENTATION*
 # To see a list of typical targets execute "make help"
$

  but i get exactly the same output if i reverse the arguments:

$ git diff ^v4.19^ v4.19
diff --git a/Makefile b/Makefile
index bf3786e4ffec..69fa5c0310d8 100644
--- a/Makefile
+++ b/Makefile
@@ -2,8 +2,8 @@
 VERSION = 4
 PATCHLEVEL = 19
 SUBLEVEL = 0
-EXTRAVERSION = -rc8
-NAME = Merciless Moray
+EXTRAVERSION =
+NAME = "People's Front"

 # *DOCUMENTATION*
 # To see a list of typical targets execute "make help"

  so i'm confused as to how to "git diff" interprets and processes
those two arguments, as "v4.19" is, of course, a reference to a
specific commit, but "^v4.19^" appears to define all those commits not
reachable from "v4.19^". how should one read this?

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================

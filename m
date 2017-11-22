Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E199C20954
	for <e@80x24.org>; Wed, 22 Nov 2017 12:33:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752544AbdKVMdj (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 07:33:39 -0500
Received: from cpanel2.indieserve.net ([199.212.143.6]:52884 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752325AbdKVMdj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 07:33:39 -0500
Received: from 69-196-158-250.dsl.teksavvy.com ([69.196.158.250]:36898 helo=DESKTOP-1GPMCEJ)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1eHUDi-0007sn-DM
        for git@vger.kernel.org; Wed, 22 Nov 2017 07:33:38 -0500
Date:   Wed, 22 Nov 2017 07:32:14 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@DESKTOP-1GPMCEJ
To:     Git Mailing list <git@vger.kernel.org>
Subject: [PATCH v2] doc: clarify that "git bisect" accepts one or more good
 commits
Message-ID: <alpine.LFD.2.21.1711220729230.13545@DESKTOP-1GPMCEJ>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel2.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel2.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel2.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reword the man page for "git bisect" to emphasize that, in the general
case, this command can take more than one good commit to define the
initial range of commits to examine.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index 4a1417bdc..2afbd9562 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -30,10 +30,10 @@ on the subcommand:
  git bisect help

 This command uses a binary search algorithm to find which commit in
-your project's history introduced a bug. You use it by first telling
-it a "bad" commit that is known to contain the bug, and a "good"
-commit that is known to be before the bug was introduced. Then `git
-bisect` picks a commit between those two endpoints and asks you
+your project's history introduced a bug. You use it by first telling it
+a "bad" commit that is known to contain the bug, and one or more "good"
+commits that are known to be before the bug was introduced. Then `git
+bisect` picks a commit somewhere in between those commits and asks you
 whether the selected commit is "good" or "bad". It continues narrowing
 down the range until it finds the exact commit that introduced the
 change.
@@ -58,7 +58,7 @@ $ git bisect bad                 # Current version is bad
 $ git bisect good v2.6.13-rc2    # v2.6.13-rc2 is known to be good
 ------------------------------------------------

-Once you have specified at least one bad and one good commit, `git
+Once you have specified one bad and one or more good commits, `git
 bisect` selects a commit in the middle of that range of history,
 checks it out, and outputs something similar to the following:

@@ -137,7 +137,7 @@ respectively, in place of "good" and "bad". (But note that you cannot
 mix "good" and "bad" with "old" and "new" in a single session.)

 In this more general usage, you provide `git bisect` with a "new"
-commit that has some property and an "old" commit that doesn't have that
+commit with some property and some "old" commits that don't have that
 property. Each time `git bisect` checks out a commit, you test if that
 commit has the property. If it does, mark the commit as "new";
 otherwise, mark it as "old". When the bisection is done, `git bisect`
@@ -145,19 +145,19 @@ will report which commit introduced the property.

 To use "old" and "new" instead of "good" and bad, you must run `git
 bisect start` without commits as argument and then run the following
-commands to add the commits:
+commands to identify the commits:

 ------------------------------------------------
-git bisect old [<rev>]
+git bisect old [<rev>...]
 ------------------------------------------------

-to indicate that a commit was before the sought change, or
+to identify one or more commits before the sought change, or

 ------------------------------------------------
-git bisect new [<rev>...]
+git bisect new [<rev>]
 ------------------------------------------------

-to indicate that it was after.
+to indicate a single commit after that change.

 To get a reminder of the currently used terms, use


-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================

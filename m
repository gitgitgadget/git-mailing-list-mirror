Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C85E820179
	for <e@80x24.org>; Fri, 17 Jun 2016 15:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933474AbcFQPk5 (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 11:40:57 -0400
Received: from mx2.freebsd.org ([8.8.178.116]:21254 "EHLO mx2.freebsd.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932139AbcFQPk4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 11:40:56 -0400
X-Greylist: delayed 435 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Jun 2016 11:40:56 EDT
Received: from mx1.freebsd.org (mx1.freebsd.org [8.8.178.115])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.freebsd.org (Postfix) with ESMTPS id BCA2A69ACF
	for <git@vger.kernel.org>; Fri, 17 Jun 2016 15:33:40 +0000 (UTC)
	(envelope-from emaste@freebsd.org)
Received: from freefall.freebsd.org (freefall.freebsd.org [IPv6:2001:1900:2254:206c::16:87])
	by mx1.freebsd.org (Postfix) with ESMTP id B23982603
	for <git@vger.kernel.org>; Fri, 17 Jun 2016 15:33:40 +0000 (UTC)
	(envelope-from emaste@freebsd.org)
Received: from freebsd.org (localhost [IPv6:::1])
	by freefall.freebsd.org (Postfix) with ESMTP id 4F2EF15B3
	for <git@vger.kernel.org>; Fri, 17 Jun 2016 15:33:40 +0000 (UTC)
	(envelope-from emaste@freebsd.org)
Received: from emaste (uid 1001)
	(envelope-from emaste@freebsd.org)
	id 9cc0e
	by freebsd.org (DragonFly Mail Agent v0.10);
	Fri, 17 Jun 2016 11:33:39 -0400
From:	Ed Maste <emaste@freebsd.org>
To:	git@vger.kernel.org
Cc:	mackyle@gmail.com, Ed Maste <emaste@freebsd.org>
Subject: [PATCH] rebase: update comment about FreeBSD /bin/sh
Date:	Fri, 17 Jun 2016 11:33:29 -0400
Message-Id: <1466177609-33185-1-git-send-email-emaste@freebsd.org>
X-Mailer: git-send-email 2.8.1
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Commit 9f50d32 introduced a fix for FreeBSD /bin/sh misbehaviour
when dot-sourcing a file containing "return" statements outside of
any function, from a function in another shell script. That issue
affects FreeBSD 9.x, and is not present in the /bin/sh in FreeBSD
10.3 and later. Update the comment to clarify this.

The example from 9f50d32's commit message produces the expected output
on FreeBSD 10.3 and -CURRENT (the upcoming 11.0):

% sh script1.sh
only this line should show
%

Signed-off-by: Ed Maste <emaste@freebsd.org>
---
 git-rebase--am.sh          | 4 ++--
 git-rebase--interactive.sh | 4 ++--
 git-rebase--merge.sh       | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/git-rebase--am.sh b/git-rebase--am.sh
index 9ae898b..3752393 100644
--- a/git-rebase--am.sh
+++ b/git-rebase--am.sh
@@ -9,8 +9,8 @@
 # below were not inside any function, and expected to return
 # to the function that dot-sourced us.
 #
-# However, FreeBSD /bin/sh misbehaves on such a construct and
-# continues to run the statements that follow such a "return".
+# However, older (9.x) versions of FreeBSD /bin/sh misbehave on such a
+# construct and continue to run the statements that follow such a "return".
 # As a work-around, we introduce an extra layer of a function
 # here, and immediately call it after defining it.
 git_rebase__am () {
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 6e96abc..05f22e4 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -1038,8 +1038,8 @@ check_todo_list () {
 # below were not inside any function, and expected to return
 # to the function that dot-sourced us.
 #
-# However, FreeBSD /bin/sh misbehaves on such a construct and
-# continues to run the statements that follow such a "return".
+# However, older (9.x) versions of FreeBSD /bin/sh misbehave on such a
+# construct and continue to run the statements that follow such a "return".
 # As a work-around, we introduce an extra layer of a function
 # here, and immediately call it after defining it.
 git_rebase__interactive () {
diff --git a/git-rebase--merge.sh b/git-rebase--merge.sh
index 8d43db9..06a4723 100644
--- a/git-rebase--merge.sh
+++ b/git-rebase--merge.sh
@@ -107,8 +107,8 @@ finish_rb_merge () {
 # below were not inside any function, and expected to return
 # to the function that dot-sourced us.
 #
-# However, FreeBSD /bin/sh misbehaves on such a construct and
-# continues to run the statements that follow such a "return".
+# However, older (9.x) versions of FreeBSD /bin/sh misbehave on such a
+# construct and continue to run the statements that follow such a "return".
 # As a work-around, we introduce an extra layer of a function
 # here, and immediately call it after defining it.
 git_rebase__merge () {
-- 
2.8.1


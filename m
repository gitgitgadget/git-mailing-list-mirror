Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 775D1207D6
	for <e@80x24.org>; Thu, 27 Apr 2017 20:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422971AbdD0U7h (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 16:59:37 -0400
Received: from [192.252.130.194] ([192.252.130.194]:60548 "EHLO
        cubert.xiplink.com" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S968934AbdD0U7a (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2017 16:59:30 -0400
Received: from xiplink.com (rincewind.xiplink.com [10.10.1.32])
        by cubert.xiplink.com (Postfix) with ESMTP id 665DC61893;
        Thu, 27 Apr 2017 16:50:37 -0400 (EDT)
From:   Marc Branchaud <marcnarc@xiplink.com>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>
Subject: [PATCH 2/2] Have the diff-* builtins configure diff before initializing revisions.
Date:   Thu, 27 Apr 2017 16:50:37 -0400
Message-Id: <20170427205037.1787-3-marcnarc@xiplink.com>
X-Mailer: git-send-email 2.13.0.rc1.15.g7dbea34e1.dirty
In-Reply-To: <20170427205037.1787-1-marcnarc@xiplink.com>
References: <20170427205037.1787-1-marcnarc@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes the commands respect diff configuration options, such as
indentHeuristic.

Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
---
 builtin/diff-files.c | 2 +-
 builtin/diff-index.c | 2 +-
 builtin/diff-tree.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index 15c61fd8d..a572da9d5 100644
--- a/builtin/diff-files.c
+++ b/builtin/diff-files.c
@@ -20,9 +20,9 @@ int cmd_diff_files(int argc, const char **argv, const char *prefix)
 	int result;
 	unsigned options = 0;
 
+	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
 	init_revisions(&rev, prefix);
 	gitmodules_config();
-	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
 	rev.abbrev = 0;
 	precompose_argv(argc, argv);
 
diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index 1af373d00..f084826a2 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -17,9 +17,9 @@ int cmd_diff_index(int argc, const char **argv, const char *prefix)
 	int i;
 	int result;
 
+	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
 	init_revisions(&rev, prefix);
 	gitmodules_config();
-	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
 	rev.abbrev = 0;
 	precompose_argv(argc, argv);
 
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 326f88b65..36a3a1976 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -105,9 +105,9 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 	struct setup_revision_opt s_r_opt;
 	int read_stdin = 0;
 
+	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
 	init_revisions(opt, prefix);
 	gitmodules_config();
-	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
 	opt->abbrev = 0;
 	opt->diff = 1;
 	opt->disable_stdin = 1;
-- 
2.13.0.rc1.15.g7dbea34e1.dirty


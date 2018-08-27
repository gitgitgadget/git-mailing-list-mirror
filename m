Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD8F41F404
	for <e@80x24.org>; Mon, 27 Aug 2018 20:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbeH1A3m (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Aug 2018 20:29:42 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41832 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbeH1A3l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Aug 2018 20:29:41 -0400
Received: by mail-pg1-f194.google.com with SMTP id s15-v6so114227pgv.8
        for <git@vger.kernel.org>; Mon, 27 Aug 2018 13:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9jmte8tmbZun/qi/vHhNPTpqCxlYbPOQ6azvQGdYcZk=;
        b=cLoeVEnLMyn26mDPMtms9dKPXjZHGa8S/rpVnqonHeHe1au63kugbsZP7DRtKem5Ms
         THELweUhucFn+cpqKAJpQCsvffSX8kA6l5mIWoj87oTESsolMir0I+HlD4g6+id+OJNp
         hnCnLtoTzbK8YY3xHvM5qd2MtMTFHayeFCBK8yhPED+8eojbqE5UCG61ibb0l27TOJLQ
         +q+cqzJCuHYA9aiAeC/zPo9sCHGBXnGWIhq17xcqusvS/iwfdfqH5c3gnTP9DOwN1Hky
         kKzoERfCD9IE9+265rzz3Lu+BAUoLAVwvCzmbEISBdDxZXXm/T1KzZ6rpR24hrrRw/w8
         55KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9jmte8tmbZun/qi/vHhNPTpqCxlYbPOQ6azvQGdYcZk=;
        b=LmMIRzrb05FQGYDBMI9eEaXaRp1WhFxP8oeTqhLU/boIuZtpwXagKmhhA348dypCIr
         Z0sXLKVN9DTusjNMpLKHJtB6UoI2wHCeekHCD0G4nnL/M70kUa93XsTVxCZCoSiewOyN
         1RxGp8rj5C5C5NRdzL3dq3QWPAho6cz2fbfLk/x6u/CxFGGhTFssgRtp3PuVMx8arOfi
         Epm1RpoVAfmiK95TVpboPUD4trTY38PfG2KyuErc1ysGp5EH9mvoKBhXMaKYJtSFUg3y
         cv/RA1JGEWrYz+8yOKYR9AC9IgSy8ed+4uO4/yC0n5MCDFlE/Rock1K7ptkTVCSF9Wn3
         GDmg==
X-Gm-Message-State: APzg51AytXlBk3O+iIDa++SQLch2AIDcxXmRFgVE1O5IuPu7LaBqpRmf
        qZ9jjgHJ5OrTnBQl/MRlNdiAON1O
X-Google-Smtp-Source: ANB0VdYrChIpPgNHx/uEVDR/WN6QMediUrQlFN5lAEuya0zT8ifuZEPGW1OTJUVSPcmqQrDb2doR4w==
X-Received: by 2002:a65:52cc:: with SMTP id z12-v6mr13626621pgp.69.1535402487880;
        Mon, 27 Aug 2018 13:41:27 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id 82-v6sm178687pfw.159.2018.08.27.13.41.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 13:41:27 -0700 (PDT)
Date:   Mon, 27 Aug 2018 13:41:27 -0700 (PDT)
X-Google-Original-Date: Mon, 27 Aug 2018 20:41:17 GMT
Message-Id: <908442417d9d0e0d861fa7ac47a97eca63294596.1535402479.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.25.git.gitgitgadget@gmail.com>
References: <pull.25.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 4/6] revision.c: begin refactoring --topo-order logic
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When running 'git rev-list --topo-order' and its kin, the topo_order
setting in struct rev_info implies the limited setting. This means
that the following things happen during prepare_revision_walk():

* revs->limited implies we run limit_list() to walk the entire
  reachable set. There are some short-cuts here, such as if we
  perform a range query like 'git rev-list COMPARE..HEAD' and we
  can stop limit_list() when all queued commits are uninteresting.

* revs->topo_order implies we run sort_in_topological_order(). See
  the implementation of that method in commit.c. It implies that
  the full set of commits to order is in the given commit_list.

These two methods imply that a 'git rev-list --topo-order HEAD'
command must walk the entire reachable set of commits _twice_ before
returning a single result.

If we have a commit-graph file with generation numbers computed, then
there is a better way. This patch introduces some necessary logic
redirection when we are in this situation.

In v2.18.0, the commit-graph file contains zero-valued bytes in the
positions where the generation number is stored in v2.19.0 and later.
Thus, we use generation_numbers_enabled() to check if the commit-graph
is available and has non-zero generation numbers.

When setting revs->limited only because revs->topo_order is true,
only do so if generation numbers are not available. There is no
reason to use the new logic as it will behave similarly when all
generation numbers are INFINITY or ZERO.

In prepare_revision_walk(), if we have revs->topo_order but not
revs->limited, then we trigger the new logic. It breaks the logic
into three pieces, to fit with the existing framework:

1. init_topo_walk() fills a new struct topo_walk_info in the rev_info
   struct. We use the presence of this struct as a signal to use the
   new methods during our walk. In this patch, this method simply
   calls limit_list() and sort_in_topological_order(). In the future,
   this method will set up a new data structure to perform that logic
   in-line.

2. next_topo_commit() provides get_revision_1() with the next topo-
   ordered commit in the list. Currently, this simply pops the commit
   from revs->commits.

3. expand_topo_walk() provides get_revision_1() with a way to signal
   walking beyond the latest commit. Currently, this calls
   add_parents_to_list() exactly like the old logic.

While this commit presents method redirection for performing the
exact same logic as before, it allows the next commit to focus only
on the new logic.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 revision.c | 42 ++++++++++++++++++++++++++++++++++++++----
 revision.h |  4 ++++
 2 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/revision.c b/revision.c
index 3205a3947a..1db70dc951 100644
--- a/revision.c
+++ b/revision.c
@@ -25,6 +25,7 @@
 #include "worktree.h"
 #include "argv-array.h"
 #include "commit-reach.h"
+#include "commit-graph.h"
 
 volatile show_early_output_fn_t show_early_output;
 
@@ -2451,7 +2452,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	if (revs->diffopt.objfind)
 		revs->simplify_history = 0;
 
-	if (revs->topo_order)
+	if (revs->topo_order && !generation_numbers_enabled(the_repository))
 		revs->limited = 1;
 
 	if (revs->prune_data.nr) {
@@ -2889,6 +2890,33 @@ static int mark_uninteresting(const struct object_id *oid,
 	return 0;
 }
 
+struct topo_walk_info {};
+
+static void init_topo_walk(struct rev_info *revs)
+{
+	struct topo_walk_info *info;
+	revs->topo_walk_info = xmalloc(sizeof(struct topo_walk_info));
+	info = revs->topo_walk_info;
+	memset(info, 0, sizeof(struct topo_walk_info));
+
+	limit_list(revs);
+	sort_in_topological_order(&revs->commits, revs->sort_order);
+}
+
+static struct commit *next_topo_commit(struct rev_info *revs)
+{
+	return pop_commit(&revs->commits);
+}
+
+static void expand_topo_walk(struct rev_info *revs, struct commit *commit)
+{
+	if (add_parents_to_list(revs, commit, &revs->commits, NULL) < 0) {
+		if (!revs->ignore_missing_links)
+			die("Failed to traverse parents of commit %s",
+			    oid_to_hex(&commit->object.oid));
+	}
+}
+
 int prepare_revision_walk(struct rev_info *revs)
 {
 	int i;
@@ -2925,11 +2953,13 @@ int prepare_revision_walk(struct rev_info *revs)
 		commit_list_sort_by_date(&revs->commits);
 	if (revs->no_walk)
 		return 0;
-	if (revs->limited)
+	if (revs->limited) {
 		if (limit_list(revs) < 0)
 			return -1;
-	if (revs->topo_order)
-		sort_in_topological_order(&revs->commits, revs->sort_order);
+		if (revs->topo_order)
+			sort_in_topological_order(&revs->commits, revs->sort_order);
+	} else if (revs->topo_order)
+		init_topo_walk(revs);
 	if (revs->line_level_traverse)
 		line_log_filter(revs);
 	if (revs->simplify_merges)
@@ -3254,6 +3284,8 @@ static struct commit *get_revision_1(struct rev_info *revs)
 
 		if (revs->reflog_info)
 			commit = next_reflog_entry(revs->reflog_info);
+		else if (revs->topo_walk_info)
+			commit = next_topo_commit(revs);
 		else
 			commit = pop_commit(&revs->commits);
 
@@ -3275,6 +3307,8 @@ static struct commit *get_revision_1(struct rev_info *revs)
 
 			if (revs->reflog_info)
 				try_to_simplify_commit(revs, commit);
+			else if (revs->topo_walk_info)
+				expand_topo_walk(revs, commit);
 			else if (add_parents_to_list(revs, commit, &revs->commits, NULL) < 0) {
 				if (!revs->ignore_missing_links)
 					die("Failed to traverse parents of commit %s",
diff --git a/revision.h b/revision.h
index bf2239f876..e48181673d 100644
--- a/revision.h
+++ b/revision.h
@@ -54,6 +54,8 @@ struct rev_cmdline_info {
 #define REVISION_WALK_NO_WALK_SORTED 1
 #define REVISION_WALK_NO_WALK_UNSORTED 2
 
+struct topo_walk_info;
+
 struct rev_info {
 	/* Starting list */
 	struct commit_list *commits;
@@ -227,6 +229,8 @@ struct rev_info {
 	const char *break_bar;
 
 	struct revision_sources *sources;
+
+	struct topo_walk_info *topo_walk_info;
 };
 
 extern int ref_excluded(struct string_list *, const char *path);
-- 
gitgitgadget


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 195F41F461
	for <e@80x24.org>; Sat, 17 Aug 2019 18:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfHQSmM (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Aug 2019 14:42:12 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42662 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfHQSmL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Aug 2019 14:42:11 -0400
Received: by mail-pl1-f195.google.com with SMTP id y1so3809131plp.9
        for <git@vger.kernel.org>; Sat, 17 Aug 2019 11:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hyZuF/HKfohsTUwMDEAUBg5jUagV96LrohKlEzQFMU8=;
        b=KHvEVhtDKVYN0Vzvp58Ltt25RJKx2fKqW/tbyslmwAIy2yX+kOXy8LW+xRy0vrPHfT
         0f8yQoq97x8egoppqnitSgYEGmXm6mqfe4gNzAaCYUjkyLYmIxXWLPQbCeRafJ7+geLB
         hZzZs1vv9JZv3mSOp3CdIt/IeAzTwa5ZZgywRBzPYJZlXtANMmKU/Wp0bp1BHjO3jG3+
         m8REOAzn28XEFznoxSuOCv3KHCfTlz9FvFRgOiKKeLa8qzWEcdNe4YKelx3KyYYwvCAz
         SQ/Y0EbICSpSnTfbGnUPsdVIxxHwh/QC7dIFH2k7rZwc7IeV2q8dNFgt2Wk2SH+UyI6s
         We3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hyZuF/HKfohsTUwMDEAUBg5jUagV96LrohKlEzQFMU8=;
        b=JjbJ3WOXODi8QuEKw13xtpWOlE+x1u+CSQONo0kC99/HgZ0XOieqaiIoqyv1bSwQqL
         NBjUCLlJkNU1CoprooTGMFgNSaIV+eglAszYepv1gQAZUWCPNHRGePz842XXwCjKFpZP
         set304gaDjv822wlBOjPkmqrmHrSyGTd/n8Hv0jkaCgdivLfRsCifYB5M4CJDeT15741
         7aMDXowvn+19Sqd9wsPy6UKDvVn01/ZzpukBS7QI1laK5R4VRMPQGK73xBgs6sWIsGPQ
         NEhhJYye8Ou6n9NnVKGw0WMmB0Q+GJ9mgPc+HFMoOE4VwrtNWc/u1qVEUQKCGFWouEYp
         y9tQ==
X-Gm-Message-State: APjAAAXBYjb56QLDVadhb/MMRZZJrOfw1K1U4sOcuxdqxrkiiQfWjAan
        J2pRJFvRjTDpWHdQhUl5TYqpHz9e
X-Google-Smtp-Source: APXvYqyqopeRjz2jOTnd/TsQLF0yT+PZea9+ni3BqvYaK2MVNxt3fwO83pSDXE/XEigTqDPlJe0hkA==
X-Received: by 2002:a17:902:900a:: with SMTP id a10mr15432817plp.281.1566067329900;
        Sat, 17 Aug 2019 11:42:09 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id j15sm9990422pfr.146.2019.08.17.11.42.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 17 Aug 2019 11:42:09 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 10/24] merge-recursive: remove useless parameter in merge_trees()
Date:   Sat, 17 Aug 2019 11:41:30 -0700
Message-Id: <20190817184144.32179-11-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2.28.g5f89f15d7b.dirty
In-Reply-To: <20190817184144.32179-1-newren@gmail.com>
References: <20190815214053.16594-1-newren@gmail.com>
 <20190817184144.32179-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

merge_trees() took a results parameter that would only be written when
opt->call_depth was positive, which is never the case now that
merge_trees_internal() has been split from merge_trees().  Remove the
misleading and unused parameter from merge_trees().

While at it, add some comments explaining how the output of
merge_trees() and merge_recursive() differ.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/checkout.c |  4 +---
 merge-recursive.c  |  6 +++---
 merge-recursive.h  | 20 ++++++++++++++++----
 sequencer.c        |  4 ++--
 4 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index d5b946dc3a..90e0eaf25e 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -708,7 +708,6 @@ static int merge_working_tree(const struct checkout_opts *opts,
 			 * give up or do a real merge, depending on
 			 * whether the merge flag was used.
 			 */
-			struct tree *result;
 			struct tree *work;
 			struct tree *old_tree;
 			struct merge_options o;
@@ -780,8 +779,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 			ret = merge_trees(&o,
 					  new_tree,
 					  work,
-					  old_tree,
-					  &result);
+					  old_tree);
 			if (ret < 0)
 				exit(128);
 			ret = reset_tree(new_tree,
diff --git a/merge-recursive.c b/merge-recursive.c
index 2a254d5563..4ce783dbfa 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3623,16 +3623,16 @@ static void merge_finalize(struct merge_options *opt)
 int merge_trees(struct merge_options *opt,
 		struct tree *head,
 		struct tree *merge,
-		struct tree *common,
-		struct tree **result)
+		struct tree *common)
 {
 	int clean;
+	struct tree *ignored;
 
 	assert(opt->ancestor != NULL);
 
 	if (merge_start(opt, head))
 		return -1;
-	clean = merge_trees_internal(opt, head, merge, common, result);
+	clean = merge_trees_internal(opt, head, merge, common, &ignored);
 	merge_finalize(opt);
 
 	return clean;
diff --git a/merge-recursive.h b/merge-recursive.h
index f1b6ef38ae..18012fff9d 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -74,19 +74,31 @@ static inline int merge_detect_rename(struct merge_options *o)
 		o->diff_detect_rename >= 0 ? o->diff_detect_rename : 1;
 }
 
-/* merge_trees() but with recursive ancestor consolidation */
+/*
+ * merge_recursive is like merge_trees() but with recursive ancestor
+ * consolidation, and when successful, it creates an actual commit
+ * and writes its address to *result.
+ *
+ * NOTE: empirically, about a decade ago it was determined that with more
+ *       than two merge bases, optimal behavior was found when the
+ *       ancestors were passed in the order of oldest merge base to newest
+ *       one.  Also, ancestors will be consumed (emptied) so make a copy if
+ *       you need it.
+ */
 int merge_recursive(struct merge_options *o,
 		    struct commit *h1,
 		    struct commit *h2,
 		    struct commit_list *ancestors,
 		    struct commit **result);
 
-/* rename-detecting three-way merge, no recursion */
+/*
+ * rename-detecting three-way merge, no recursion; result of merge is written
+ * to opt->repo->index.
+ */
 int merge_trees(struct merge_options *o,
 		struct tree *head,
 		struct tree *merge,
-		struct tree *common,
-		struct tree **result);
+		struct tree *common);
 
 /*
  * "git-merge-recursive" can be fed trees; wrap them into
diff --git a/sequencer.c b/sequencer.c
index 34ebf8ed94..c4ed30f1b4 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -586,7 +586,7 @@ static int do_recursive_merge(struct repository *r,
 			      struct replay_opts *opts)
 {
 	struct merge_options o;
-	struct tree *result, *next_tree, *base_tree, *head_tree;
+	struct tree *next_tree, *base_tree, *head_tree;
 	int clean;
 	char **xopt;
 	struct lock_file index_lock = LOCK_INIT;
@@ -613,7 +613,7 @@ static int do_recursive_merge(struct repository *r,
 
 	clean = merge_trees(&o,
 			    head_tree,
-			    next_tree, base_tree, &result);
+			    next_tree, base_tree);
 	if (is_rebase_i(opts) && clean <= 0)
 		fputs(o.obuf.buf, stdout);
 	strbuf_release(&o.obuf);
-- 
2.23.0.rc2.28.g5f89f15d7b.dirty


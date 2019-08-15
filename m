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
	by dcvr.yhbt.net (Postfix) with ESMTP id A11AF1F45A
	for <e@80x24.org>; Thu, 15 Aug 2019 21:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732901AbfHOVl0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Aug 2019 17:41:26 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45131 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732744AbfHOVlZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Aug 2019 17:41:25 -0400
Received: by mail-pf1-f194.google.com with SMTP id w26so1959979pfq.12
        for <git@vger.kernel.org>; Thu, 15 Aug 2019 14:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5RL+a5cbRltO8w02hc5FUnq6CzEvcgdU5XWnyebP4e8=;
        b=muBvS8bbJbHEfIfQxKN2d1WMA/bJgSZYriZ65ThUZN8PHHU+7wgzubmcR0WGN12BjQ
         8PD24pQYARVmLsVOz3Gom8qcgZyCjLmdg08gUhYzBdZQ/lmaz8P4VqGU6IdkVXjZdX/s
         V/OZ5joWVuN0ICewamLeGYASMFyoJX8lcbufjEHZ5zEBhvY8TPTwh25x9zwbOJzSPWpt
         GuEQk7PqSNdrh5rP9pGYLImf6VPMyGZNsfNBVeqV++Osd1k7mEKGR9SI9PDGIoUyOAmm
         H/68iT/gL2XK4cUxJKg35/FqiL0uEiRoM/O4hEzhi0/2EqF3Sxll0nLbmf+iGfbNTh81
         aaVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5RL+a5cbRltO8w02hc5FUnq6CzEvcgdU5XWnyebP4e8=;
        b=HD+GuvhSVkePQ8by9bLob0/Jm8FL5NdMJJF7JzdGR8SCkZeEmCqSCMXO2XTVgPVbox
         QMXFY6cfeUQr5MurOmisyggIJdDq6ja/eQgNRTi7SJ8BkjefuvUWjh7Hl+i7YpSU23u8
         PTPzp79F9GnR95EVeS35q0RamkzTDwYjvMd4GaZe6p16jawtURhBM/IcGoKKS9vmZH/Y
         lJNr09p6ECBvgP7B5mVP3eKI5tLogOeQ1/4EZjI8yf04ZJtOnp2jhm28sEULClamzKdh
         jLFqts4rIIHaVyXezFcDtn7vrmsKdoT3hG9ogf4r5HlU9SXBzU2SUWfeKCEo538kghTV
         Z5hg==
X-Gm-Message-State: APjAAAWjDRZB6z7E6n5foGS80Y9GAwL6K7cGR7MlmjV9Rxa15FnmSGnl
        vAcfEzCDzccGFa7tWr+enD9Z3DOa
X-Google-Smtp-Source: APXvYqzHMP/HzuhM9WCwTElUeX01Fkvy+r2CiSFF57gF7VTI7K0/rTa6FzOMgGS0FMGcrVL2wDQn/A==
X-Received: by 2002:a63:de4f:: with SMTP id y15mr5209655pgi.239.1565905284262;
        Thu, 15 Aug 2019 14:41:24 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id i124sm4131966pfe.61.2019.08.15.14.41.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Aug 2019 14:41:23 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 10/24] merge-recursive: remove useless parameter in merge_trees()
Date:   Thu, 15 Aug 2019 14:40:39 -0700
Message-Id: <20190815214053.16594-11-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2.32.g2123e9e4e4
In-Reply-To: <20190815214053.16594-1-newren@gmail.com>
References: <20190726155258.28561-1-newren@gmail.com>
 <20190815214053.16594-1-newren@gmail.com>
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
index ded2e1bcfb..89e9a7518c 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3628,16 +3628,16 @@ static void merge_finalize(struct merge_options *opt)
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
2.23.0.rc2.32.g2123e9e4e4


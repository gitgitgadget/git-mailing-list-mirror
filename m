Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB5C31F462
	for <e@80x24.org>; Fri, 26 Jul 2019 15:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbfGZPxM (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 11:53:12 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46297 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387519AbfGZPxL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 11:53:11 -0400
Received: by mail-pl1-f196.google.com with SMTP id c2so24889422plz.13
        for <git@vger.kernel.org>; Fri, 26 Jul 2019 08:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NODzgMqxao3TCJOa+1mG/Bja6y8OnVzOyvIszUVJcAA=;
        b=TjBAuwqm0N/WMRpEcPce+/9isjd04pSRihszZAVTwVRlxIqhqwaGWsJRhpDuTihfEx
         9GnFDyjQEhytfi6LeI2qrJEzDp19YGE+NNg9q10LG9Hp4nXJar6LHJSBnMenWak1s2wu
         tRPJ7eWhUmhP764qfH+wbNKsnmE/WbHjVg3nromx6bvLX1hPsLq1WcIelxYSof5PUUWD
         XxLEqjgTOL0l0KRB/lQtKgN47/9j+2hiahN2dO/arPtJXdda/ghm+qNpwOqVyuO8XstH
         jsV2ll8HhWL/erqXLlW9dmdDjscqywoP/NwS48pC9STYBWfEnGGwT5RtCJ5jjhf29VUi
         u1Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NODzgMqxao3TCJOa+1mG/Bja6y8OnVzOyvIszUVJcAA=;
        b=FVYKMPu/8tfZtMzRbA67SxPGu/1J85HNFvlsO+ouu2qlGKmx2gJ5iw08SRzEV1lgI0
         bufguYQiaO5+CN2G0LYzA3KNlRY4PLIRybHXB5i5Y5veBkHqdRbNSqtWZa7QK743uDHg
         T5pEsL8l9bTWYmXatJetKx4gBBYgzZXGG/3wgIj9/H4K3Ls+sACwQ/mgjGrjBDPmYJ8x
         BTCQhase0FOCXHFmP8eHyZ6UiTfy0D40MRnIbUu+VPNEFeW5qaBD4+sXfIlwK/lI40Ih
         l3//dQ7QrtWeYhohJbobbMjOh5sj0Zk1XiXhMJWr/CNFZp+RnrTfv1JhvXdOCYXPWchq
         H70A==
X-Gm-Message-State: APjAAAU+HCDMgfMh4czVlZCcd4VIVjcxNpnziPzJDBuMujqlhRJzvEco
        8QBrNvzT/BDKZet+kU3YHLPwF9jv
X-Google-Smtp-Source: APXvYqznHoylGM34myFc3zUY07MNoj1jeoK4dIBa70fNh4qFQ1dG3aRaW1B2bIOjscifZuZm+qDLhQ==
X-Received: by 2002:a17:902:b70c:: with SMTP id d12mr93244520pls.314.1564156390229;
        Fri, 26 Jul 2019 08:53:10 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id f27sm36669638pgm.60.2019.07.26.08.53.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Jul 2019 08:53:09 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 05/20] merge-recursive: remove useless parameter in merge_trees()
Date:   Fri, 26 Jul 2019 08:52:43 -0700
Message-Id: <20190726155258.28561-6-newren@gmail.com>
X-Mailer: git-send-email 2.22.0.550.g71c37a0928.dirty
In-Reply-To: <20190726155258.28561-1-newren@gmail.com>
References: <20190725174611.14802-1-newren@gmail.com>
 <20190726155258.28561-1-newren@gmail.com>
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
index 91f8509f85..20e38c5edc 100644
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
@@ -773,8 +772,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
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
index f5cf21e2e0..4a481c3929 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3613,14 +3613,14 @@ static void merge_finalize(struct merge_options *opt)
 int merge_trees(struct merge_options *opt,
 		struct tree *head,
 		struct tree *merge,
-		struct tree *common,
-		struct tree **result)
+		struct tree *common)
 {
 	int clean;
+	struct tree *ignored;
 
 	if (merge_start(opt, head))
 		return -1;
-	clean = merge_trees_internal(opt, head, merge, common, result);
+	clean = merge_trees_internal(opt, head, merge, common, &ignored);
 	merge_finalize(opt);
 
 	return clean;
diff --git a/merge-recursive.h b/merge-recursive.h
index c2b7bb65c6..812c456f1b 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -70,19 +70,31 @@ static inline int merge_detect_rename(struct merge_options *o)
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
2.22.0.550.g71c37a0928.dirty


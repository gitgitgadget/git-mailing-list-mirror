Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B301207EC
	for <e@80x24.org>; Wed, 28 Sep 2016 11:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753397AbcI1LoK (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Sep 2016 07:44:10 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:35840 "EHLO
        mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753389AbcI1LoI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2016 07:44:08 -0400
Received: by mail-pa0-f67.google.com with SMTP id cd13so157300pac.3
        for <git@vger.kernel.org>; Wed, 28 Sep 2016 04:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K0C+JeuA3i1ceP1TjFmHKir4beH2K32eaKO8+UMqMu4=;
        b=utcBvzdhZswqhs0CGaSPQPzSj1ShKfJDxzQoDiTMbLJS/7nb9G3EvlMlEVFCamHkaJ
         Uy9plNtBiF+lLdMQHf2qutcBXnXpD88FpxqdnH4y0OFTqIO6ppySbJkY+BNCg0Q6xj87
         TLWes6SVyiKwKPLMX7mt25xSZfKECvBOGu3yFSEwnZOujX77UfaszuocXneefve8p07F
         99hMpnp+fqWKvJ3RXTv8K8AaiNwuQf4s//IqoytBr1BnyBLlIl865BIrbvwLUTTR98+z
         NvKjYPXKWtamqbe4Pq6+1hbAR7B3qEWhctLuLB0fPFNo/mnCYTdkF85sUdaqmciSU182
         oV5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K0C+JeuA3i1ceP1TjFmHKir4beH2K32eaKO8+UMqMu4=;
        b=JosBEalA1bnipthjBQYzSF/Ab+nFrz6WwpTE6TOfo/A3lCU/w9q39E0ZV+dEpm3f5i
         blKb2Eby45ZNizpFWwLUNF+Te+mRIGGTd1WXqtrViCQsGR/WScAVdW1mi1IyLyl+dMsS
         RjzM4uN4rfe6+qQfeJfOqseTuZZXKlCrbAD/+moySTImBQMJE5PQhoeRMszsMOJj5aFD
         Qoez3SPv4F/LBFTdJolnGRlrm3Th/otnOvN6IsKCC2Il5fVYyduFP9vLGd5W6rZmUvo6
         0/FW7VbS9xxCR/cU6cn0lYyDejCjY0Z4Fr4O3ByNgmo0K01fVjMMe10cGxa7igUIaIg6
         4IUg==
X-Gm-Message-State: AA6/9Rl8UVhzyp0WqssB/NhsKf3asmuuTe1ayyotjnSGaIP8S/V19/v8S/f0QV3FHmNMqw==
X-Received: by 10.66.183.81 with SMTP id ek17mr1837623pac.153.1475063047656;
        Wed, 28 Sep 2016 04:44:07 -0700 (PDT)
Received: from ash ([115.76.130.63])
        by smtp.gmail.com with ESMTPSA id i62sm12021327pfg.89.2016.09.28.04.44.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Sep 2016 04:44:07 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 28 Sep 2016 18:44:03 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 1/3] Resurrect "diff-lib.c: adjust position of i-t-a entries in diff"
Date:   Wed, 28 Sep 2016 18:43:46 +0700
Message-Id: <20160928114348.1470-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160928114348.1470-1-pclouds@gmail.com>
References: <20160928114348.1470-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The original commit d95d728aba06a34394d15466045cbdabdada58a2 was
reverted in commit 78cc1a540ba127b13f2f3fd531777b57f3a9cd46 because we
were (and still are) not ready for a new world order. A lot more
investigation must be done to see what is impacted. See the 78cc1a5 for
details.

This patch takes a smaller and safer step. The new behavior is
controlled by shift_ita flag. We can gradually move more diff users to
the new behavior after we are sure it's safe to do so. This flag is
exposed to outside temporarily as "--shift-ita" for people who prefer
"git diff [--cached] --stat" to "git status"

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/diff-options.txt |  7 +++++++
 diff-lib.c                     | 12 ++++++++++++
 diff.c                         |  2 ++
 diff.h                         |  1 +
 t/t2203-add-intent.sh          | 20 ++++++++++++++++++--
 t/t7064-wtstatus-pv2.sh        |  4 ++--
 wt-status.c                    |  7 ++++++-
 7 files changed, 48 insertions(+), 5 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 7805a0c..e63285c 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -575,5 +575,12 @@ endif::git-format-patch[]
 --line-prefix=<prefix>::
 	Prepend an additional prefix to every line of output.
 
+--shift-ita::
+	By default entries added by "git add -N" appear as an existing
+	empty file in "git diff" and a new file in "git diff --cached".
+	This option makes the entry appear as a new file in "git diff"
+	and non-existent in "git diff --cached". Experimental option,
+	could be removed in future.
+
 For more detailed explanation on these common options, see also
 linkgit:gitdiffcore[7].
diff --git a/diff-lib.c b/diff-lib.c
index 3007c85..62d67c8 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -214,6 +214,11 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 					       !is_null_oid(&ce->oid),
 					       ce->name, 0);
 				continue;
+			} else if (revs->diffopt.shift_ita && ce_intent_to_add(ce)) {
+				diff_addremove(&revs->diffopt, '+', ce->ce_mode,
+					       EMPTY_BLOB_SHA1_BIN, 0,
+					       ce->name, 0);
+				continue;
 			}
 
 			changed = match_stat_with_submodule(&revs->diffopt, ce, &st,
@@ -379,6 +384,13 @@ static void do_oneway_diff(struct unpack_trees_options *o,
 	struct rev_info *revs = o->unpack_data;
 	int match_missing, cached;
 
+	/* i-t-a entries do not actually exist in the index */
+	if (revs->diffopt.shift_ita && idx && ce_intent_to_add(idx)) {
+		idx = NULL;
+		if (!tree)
+			return;	/* nothing to diff.. */
+	}
+
 	/* if the entry is not checked out, don't examine work tree */
 	cached = o->index_only ||
 		(idx && ((idx->ce_flags & CE_VALID) || ce_skip_worktree(idx)));
diff --git a/diff.c b/diff.c
index c6da383..4178689 100644
--- a/diff.c
+++ b/diff.c
@@ -3923,6 +3923,8 @@ int diff_opt_parse(struct diff_options *options,
 		return parse_submodule_opt(options, arg);
 	else if (skip_prefix(arg, "--ws-error-highlight=", &arg))
 		return parse_ws_error_highlight(options, arg);
+	else if (!strcmp(arg, "--shift-ita"))
+		options->shift_ita = 1;
 
 	/* misc options */
 	else if (!strcmp(arg, "-z"))
diff --git a/diff.h b/diff.h
index ec76a90..5dd4f9c 100644
--- a/diff.h
+++ b/diff.h
@@ -146,6 +146,7 @@ struct diff_options {
 	int dirstat_permille;
 	int setup;
 	int abbrev;
+	int shift_ita;
 /* white-space error highlighting */
 #define WSEH_NEW 1
 #define WSEH_CONTEXT 2
diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index 8f22c43..c6a4648 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -5,10 +5,24 @@ test_description='Intent to add'
 . ./test-lib.sh
 
 test_expect_success 'intent to add' '
+	test_commit 1 &&
+	git rm 1.t &&
+	echo hello >1.t &&
 	echo hello >file &&
 	echo hello >elif &&
 	git add -N file &&
-	git add elif
+	git add elif &&
+	git add -N 1.t
+'
+
+test_expect_success 'git status' '
+	git status --porcelain | grep -v actual >actual &&
+	cat >expect <<-\EOF &&
+	DA 1.t
+	A  elif
+	 A file
+	EOF
+	test_cmp expect actual
 '
 
 test_expect_success 'check result of "add -N"' '
@@ -43,7 +57,9 @@ test_expect_success 'i-t-a entry is simply ignored' '
 	git add -N nitfol &&
 	git commit -m second &&
 	test $(git ls-tree HEAD -- nitfol | wc -l) = 0 &&
-	test $(git diff --name-only HEAD -- nitfol | wc -l) = 1
+	test $(git diff --name-only HEAD -- nitfol | wc -l) = 1 &&
+	test $(git diff --name-only --shift-ita HEAD -- nitfol | wc -l) = 0 &&
+	test $(git diff --name-only --shift-ita -- nitfol | wc -l) = 1
 '
 
 test_expect_success 'can commit with an unrelated i-t-a entry in index' '
diff --git a/t/t7064-wtstatus-pv2.sh b/t/t7064-wtstatus-pv2.sh
index 3012a4d..e319fa2 100755
--- a/t/t7064-wtstatus-pv2.sh
+++ b/t/t7064-wtstatus-pv2.sh
@@ -246,8 +246,8 @@ test_expect_success 'verify --intent-to-add output' '
 	git add --intent-to-add intent1.add intent2.add &&
 
 	cat >expect <<-EOF &&
-	1 AM N... 000000 100644 100644 $_z40 $EMPTY_BLOB intent1.add
-	1 AM N... 000000 100644 100644 $_z40 $EMPTY_BLOB intent2.add
+	1 .A N... 000000 000000 100644 $_z40 $_z40 intent1.add
+	1 .A N... 000000 000000 100644 $_z40 $_z40 intent2.add
 	EOF
 
 	git status --porcelain=v2 >actual &&
diff --git a/wt-status.c b/wt-status.c
index 9a14658..5f9b1cd 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -437,7 +437,7 @@ static void wt_status_collect_changed_cb(struct diff_queue_struct *q,
 
 		switch (p->status) {
 		case DIFF_STATUS_ADDED:
-			die("BUG: worktree status add???");
+			d->mode_worktree = p->two->mode;
 			break;
 
 		case DIFF_STATUS_DELETED:
@@ -547,6 +547,7 @@ static void wt_status_collect_changes_worktree(struct wt_status *s)
 	setup_revisions(0, NULL, &rev, NULL);
 	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
 	DIFF_OPT_SET(&rev.diffopt, DIRTY_SUBMODULES);
+	rev.diffopt.shift_ita = 1;
 	if (!s->show_untracked_files)
 		DIFF_OPT_SET(&rev.diffopt, IGNORE_UNTRACKED_IN_SUBMODULES);
 	if (s->ignore_submodule_arg) {
@@ -570,6 +571,7 @@ static void wt_status_collect_changes_index(struct wt_status *s)
 	setup_revisions(0, NULL, &rev, &opt);
 
 	DIFF_OPT_SET(&rev.diffopt, OVERRIDE_SUBMODULE_CONFIG);
+	rev.diffopt.shift_ita = 1;
 	if (s->ignore_submodule_arg) {
 		handle_ignore_submodules_arg(&rev.diffopt, s->ignore_submodule_arg);
 	} else {
@@ -605,6 +607,8 @@ static void wt_status_collect_changes_initial(struct wt_status *s)
 
 		if (!ce_path_match(ce, &s->pathspec, NULL))
 			continue;
+		if (ce_intent_to_add(ce))
+			continue;
 		it = string_list_insert(&s->change, ce->name);
 		d = it->util;
 		if (!d) {
@@ -911,6 +915,7 @@ static void wt_longstatus_print_verbose(struct wt_status *s)
 
 	init_revisions(&rev, NULL);
 	DIFF_OPT_SET(&rev.diffopt, ALLOW_TEXTCONV);
+	rev.diffopt.shift_ita = 1;
 
 	memset(&opt, 0, sizeof(opt));
 	opt.def = s->is_initial ? EMPTY_TREE_SHA1_HEX : s->reference;
-- 
2.8.2.524.g6ff3d78


From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/4] Resurrect "diff-lib.c: adjust position of i-t-a entries in diff"
Date: Mon,  6 Jun 2016 18:16:41 +0700
Message-ID: <20160606111643.7122-3-pclouds@gmail.com>
References: <20160606111643.7122-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: thomas.braun@virtuell-zuhause.de,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 13:17:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9sWr-00089Z-0y
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 13:17:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbcFFLRD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Jun 2016 07:17:03 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35804 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751297AbcFFLRC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2016 07:17:02 -0400
Received: by mail-pf0-f193.google.com with SMTP id z187so3455874pfz.2
        for <git@vger.kernel.org>; Mon, 06 Jun 2016 04:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1+7Eb5VdPvzd1ObKb37vxzPBnZNNFvQNILHfETEpy4c=;
        b=zEjlLBrFdpXZVBqwxM6oPoJtN8h39JQxaFijFlBU339E3TE+s27M7uvbaUegNhoSik
         umnx5WDTPRfLeoE1BZK/9lS7Z6tWm9oRvi6J0luvucWgQMLMkdONo6asrNzST2Z9TVbq
         qc3ToLdPnb1XyBPfL8G+U+ZBulASpa7LDQ+RSI5YX8csDMJmSLLySRRydy8iAps6SJdv
         CRnOdsNGLRwlAeXtlG6fuVVZgo91XKw/8//KAGEz56vuz9m6eXdAzqPESd9Y81DilrXs
         IQUF8i8wAnZO038rgnaHvlTFHgCUohrJY/rBX0nqCwYVHAaFQqjWsoUi0Zw/77T5apDq
         gVqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1+7Eb5VdPvzd1ObKb37vxzPBnZNNFvQNILHfETEpy4c=;
        b=f8OJIM/vbD6wOTPljqzt/KJzDyBcoazPBvboBQf3PzTqZ+yUc7Zks9bzWq8meTnmBd
         LCTq6yjhAla0X1SNIPE18qsct8esWALccoqj+Ba9m+VTNc6xenXv80GvsEH3qAfZp8Qz
         J5D3zyVuJ7nbCvrMGu/zz3bboQ589urUPBzijrqoHktW856EZrz4fENKoDq0anUs+vmY
         XatA7rcD1+NQkEftpy/DRNy/k+48X9Z6JcdQBjMvvc1KE5EpeGqcj+qnzFhH66OfkiIq
         toqKEnbKAtB2cDNwR4qgG8fkyoFmCS+KSmuswM0t0MezeCyWI5lnUkuAAI4+AzHJ+T3e
         5IWw==
X-Gm-Message-State: ALyK8tL1ZWkFqSLd9K3awt3ubLNyPArFgTkR737MgEN+sBtztvaetbbFbO0giecKFZumpw==
X-Received: by 10.98.192.83 with SMTP id x80mr24800264pff.88.1465211820642;
        Mon, 06 Jun 2016 04:17:00 -0700 (PDT)
Received: from ash ([115.76.150.26])
        by smtp.gmail.com with ESMTPSA id m1sm18247760pab.46.2016.06.06.04.16.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jun 2016 04:17:00 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Mon, 06 Jun 2016 18:16:55 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160606111643.7122-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296500>

The original commit d95d728aba06a34394d15466045cbdabdada58a2 was
reverted in commit 78cc1a540ba127b13f2f3fd531777b57f3a9cd46 because we
were (and still are) not ready for a new world order. A lot more
investigation must be done to see what is impacted. See the 78cc1a5 for
details.

This patch takes a smaller and safer step. The new behavior is
controlled by SHIFT_INTENT_TO_ADD flag. We can gradually move more diff
users to the new behavior after we are sure it's safe to do so. This
flag is exposed to outside as "--shift-ita".

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/diff-options.txt |  6 ++++++
 diff-lib.c                     | 14 ++++++++++++++
 diff.c                         |  2 ++
 diff.h                         |  1 +
 t/t2203-add-intent.sh          | 20 ++++++++++++++++++--
 wt-status.c                    |  5 +++++
 6 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-option=
s.txt
index 3cb3015..904438b 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -559,5 +559,11 @@ endif::git-format-patch[]
 --no-prefix::
 	Do not show any source or destination prefix.
=20
+--shift-ita::
+	By default entries added by "git add -N" appear as an existing
+	empty file in "git diff" and a new file in "git diff --cached".
+	This option makes the entry appear as a new file in "git diff"
+	and non-existent in "git diff --cached".
+
 For more detailed explanation on these common options, see also
 linkgit:gitdiffcore[7].
diff --git a/diff-lib.c b/diff-lib.c
index 27887d0..1248970 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -212,6 +212,12 @@ int run_diff_files(struct rev_info *revs, unsigned=
 int option)
 					       ce->sha1, !is_null_sha1(ce->sha1),
 					       ce->name, 0);
 				continue;
+			} else if (DIFF_OPT_TST(&revs->diffopt, SHIFT_INTENT_TO_ADD) &&
+				   ce_intent_to_add(ce)) {
+				diff_addremove(&revs->diffopt, '+', ce->ce_mode,
+					       EMPTY_BLOB_SHA1_BIN, 0,
+					       ce->name, 0);
+				continue;
 			}
=20
 			changed =3D match_stat_with_submodule(&revs->diffopt, ce, &st,
@@ -376,6 +382,14 @@ static void do_oneway_diff(struct unpack_trees_opt=
ions *o,
 	struct rev_info *revs =3D o->unpack_data;
 	int match_missing, cached;
=20
+	/* i-t-a entries do not actually exist in the index */
+	if (DIFF_OPT_TST(&revs->diffopt, SHIFT_INTENT_TO_ADD) &&
+	    idx && ce_intent_to_add(idx)) {
+		idx =3D NULL;
+		if (!tree)
+			return;	/* nothing to diff.. */
+	}
+
 	/* if the entry is not checked out, don't examine work tree */
 	cached =3D o->index_only ||
 		(idx && ((idx->ce_flags & CE_VALID) || ce_skip_worktree(idx)));
diff --git a/diff.c b/diff.c
index f70425f..b624e64 100644
--- a/diff.c
+++ b/diff.c
@@ -3910,6 +3910,8 @@ int diff_opt_parse(struct diff_options *options,
 		return parse_submodule_opt(options, arg);
 	else if (skip_prefix(arg, "--ws-error-highlight=3D", &arg))
 		return parse_ws_error_highlight(options, arg);
+	else if (!strcmp(arg, "--shift-ita"))
+		DIFF_OPT_SET(options, SHIFT_INTENT_TO_ADD);
=20
 	/* misc options */
 	else if (!strcmp(arg, "-z"))
diff --git a/diff.h b/diff.h
index b497078..9e42556 100644
--- a/diff.h
+++ b/diff.h
@@ -92,6 +92,7 @@ typedef struct strbuf *(*diff_prefix_fn_t)(struct dif=
f_options *opt, void *data)
 #define DIFF_OPT_FUNCCONTEXT         (1 << 29)
 #define DIFF_OPT_PICKAXE_IGNORE_CASE (1 << 30)
 #define DIFF_OPT_DEFAULT_FOLLOW_RENAMES (1U << 31)
+#define DIFF_OPT_SHIFT_INTENT_TO_ADD (1UL << 32)
=20
 #define DIFF_OPT_TST(opts, flag)    ((opts)->flags & DIFF_OPT_##flag)
 #define DIFF_OPT_TOUCHED(opts, flag)    ((opts)->touched_flags & DIFF_=
OPT_##flag)
diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index 2a4a749..4ae98f4 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -5,10 +5,24 @@ test_description=3D'Intent to add'
 . ./test-lib.sh
=20
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
=20
 test_expect_success 'check result of "add -N"' '
@@ -43,7 +57,9 @@ test_expect_success 'i-t-a entry is simply ignored' '
 	git add -N nitfol &&
 	git commit -m second &&
 	test $(git ls-tree HEAD -- nitfol | wc -l) =3D 0 &&
-	test $(git diff --name-only HEAD -- nitfol | wc -l) =3D 1
+	test $(git diff --name-only HEAD -- nitfol | wc -l) =3D 1 &&
+	test $(git diff --name-only --shift-ita HEAD -- nitfol | wc -l) =3D 0=
 &&
+	test $(git diff --name-only --shift-ita -- nitfol | wc -l) =3D 1
 '
=20
 test_expect_success 'can commit with an unrelated i-t-a entry in index=
' '
diff --git a/wt-status.c b/wt-status.c
index 4f27bd6..cb89005 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -497,6 +497,7 @@ static void wt_status_collect_changes_worktree(stru=
ct wt_status *s)
 	setup_revisions(0, NULL, &rev, NULL);
 	rev.diffopt.output_format |=3D DIFF_FORMAT_CALLBACK;
 	DIFF_OPT_SET(&rev.diffopt, DIRTY_SUBMODULES);
+	DIFF_OPT_SET(&rev.diffopt, SHIFT_INTENT_TO_ADD);
 	if (!s->show_untracked_files)
 		DIFF_OPT_SET(&rev.diffopt, IGNORE_UNTRACKED_IN_SUBMODULES);
 	if (s->ignore_submodule_arg) {
@@ -520,6 +521,7 @@ static void wt_status_collect_changes_index(struct =
wt_status *s)
 	setup_revisions(0, NULL, &rev, &opt);
=20
 	DIFF_OPT_SET(&rev.diffopt, OVERRIDE_SUBMODULE_CONFIG);
+	DIFF_OPT_SET(&rev.diffopt, SHIFT_INTENT_TO_ADD);
 	if (s->ignore_submodule_arg) {
 		handle_ignore_submodules_arg(&rev.diffopt, s->ignore_submodule_arg);
 	} else {
@@ -555,6 +557,8 @@ static void wt_status_collect_changes_initial(struc=
t wt_status *s)
=20
 		if (!ce_path_match(ce, &s->pathspec, NULL))
 			continue;
+		if (ce_intent_to_add(ce))
+			continue;
 		it =3D string_list_insert(&s->change, ce->name);
 		d =3D it->util;
 		if (!d) {
@@ -853,6 +857,7 @@ static void wt_status_print_verbose(struct wt_statu=
s *s)
=20
 	init_revisions(&rev, NULL);
 	DIFF_OPT_SET(&rev.diffopt, ALLOW_TEXTCONV);
+	DIFF_OPT_SET(&rev.diffopt, SHIFT_INTENT_TO_ADD);
=20
 	memset(&opt, 0, sizeof(opt));
 	opt.def =3D s->is_initial ? EMPTY_TREE_SHA1_HEX : s->reference;
--=20
2.8.2.524.g6ff3d78

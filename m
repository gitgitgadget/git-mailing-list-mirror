Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129AAC04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 21:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232947AbiG1VMj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 17:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbiG1VMi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 17:12:38 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A879F743D3
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 14:12:36 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id ot17-20020a17090b3b5100b001f2c064b8b0so3635859pjb.1
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 14:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc;
        bh=KRnAD4+xJNPctWcqCe0SdpYHuD98swdOdGWgWs1y4nc=;
        b=m8IJSIbwXFtAGLRe2BaD8Tsi23xFAR/G/PD0Aj6iElSB8jHByJAangvfO+avsoDgN9
         igWOcRbdvgQk766jcDIhyQS75KeHo2Iem6fG5QslKQYdui1/mRe2K1X8bWHiN9W3NXFw
         8/eBsnLfVwzv1EW2IzjfI1DI564E4kW/eiBlYBZfWaENg0b48qcMj//hLGThDHaA/wZ1
         G0iWi3D2ZmL2VEo2/9fQtq4O6ZDasngsSX5v/6QVJZi+lNvNKjmwHDdfHmrVmdgE6tjQ
         L8nGdAF4Ze0Sg7N7zaBbHNL7E7I0jcfbaVVFaZA/R8JB8om8fMcSjeZSLOd9FZ0TmMHq
         zd4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc;
        bh=KRnAD4+xJNPctWcqCe0SdpYHuD98swdOdGWgWs1y4nc=;
        b=S1osUl/d+t/rPhURfaInn9e9P8HWKdwZ+seIX4kHWyGpP8EWi3L1T0b3qCMYdHatB/
         ynx/TSboJlXMj1CQSZwK5H7P74luQD4eV4LqOF8x/hoxBxZlnH+V4TXEzPd5+/XjzOYl
         ujHFjDYUsx+xowmGHUy7hxcUaeQDgDRw0AcGdveGIOGoAKarAyEGJVIEGZiKQtlKNhM7
         n9e8RIC3mZMHWmmDLG2alGIgRbOOmLBSt1TU2joC4weGXwU5C7yGijwRLyeKKX152PKb
         OnuMk1ws/I0XsMVj/0viFVmkZ8tCNEq1KBZxyCgFY5S3C7x8YkLM5Upm/ucVb3oiQOdJ
         sVlQ==
X-Gm-Message-State: ACgBeo3ibADaFQIXCshhAAvH+waGpl5GfwBdv5Giji81Iw76mYQNBNFA
        fm1NXdJ9GIKPjyxZv9HKfgy6Jf5AxFaS9yd8db/JeAC6mwmWrRqEm2g6/bOddrR8w/W6Tn0j2yt
        Z2BzLsIDEdqDjVUC6ci63B2v2SnkZMobpCxo7u9W5B6KwcrDcWhpCAzh71Amu+OCHSA==
X-Google-Smtp-Source: AA6agR4vdYgnEIQ48tN0hx9oEjfuacfkse+u4KqADaPs8VRS2Htxp/tDEZQ5uDRQz/Nvm4j20+ny6KcqFpgkyMc=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:903:11c5:b0:16c:ece7:f687 with SMTP
 id q5-20020a17090311c500b0016cece7f687mr732274plh.165.1659042756070; Thu, 28
 Jul 2022 14:12:36 -0700 (PDT)
Date:   Thu, 28 Jul 2022 21:12:21 +0000
In-Reply-To: <20220726210020.3397249-1-calvinwan@google.com>
Message-Id: <20220728211221.2913928-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20220726210020.3397249-1-calvinwan@google.com>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH v7] submodule merge: update conflict error message
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, gitster@pobox.com,
        newren@gmail.com, Johannes.Schindelin@gmx.de, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When attempting to merge in a superproject with conflicting submodule
pointers that cannot be fast-forwarded or trivially resolved, the merge
fails and Git prints an error message that accurately describes the
failure, but does not provide steps for the user to resolve the error.

Git is left in a conflicted state, which requires the user to:
 1. merge submodules or update submodules to an already existing
	commit that reflects the merge
 2. add submodules changes to the superproject
 3. finish merging superproject
These steps are non-obvious for newer submodule users to figure out
based on the error message and neither `git submodule status` nor `git
status` provide any useful pointers.

Update error message to provide steps to resolve submodule merge
conflict. Future work could involve adding an advice flag to the
message. Although the message is long, it also has the id of the=20
submodule commit that needs to be merged, which could be useful
information for the user.

Additionally, 4 merge failures that resulted in an early return have
been updated to reflect the status of the merge.
1. Null merge base (null o): CONFLICT_SUBMODULE_NULL_MERGE_BASE added
   as a new conflict type and will print updated error message.
2. Null merge side a (null a): BUG(). See [1] for discussion
3. Null merge side b (null b): BUG(). See [1] for discussion
4. Submodule not checked out: Still returns early, but added a
   NEEDSWORK bit since current error message does not reflect the
   correct resolution

[1] https://lore.kernel.org/git/CABPp-BE0qGwUy80dmVszkJQ+tcpfLRW0OZyErymzhZ=
9+HWY1mw@mail.gmail.com/

Signed-off-by: Calvin Wan <calvinwan@google.com>
---

For Elijah: Cleaned up the small nits and updated resolutions for
those 4 cases we discussed.

For =C3=86var: Apologies for misunderstanding your suggestions to make
my messages easier for translators to work with. I have reformatted
all of the messages to separate text vs formatting translations. Let
me know if this is what you were expecting.

 merge-ort.c                 | 112 ++++++++++++++++++++++++++++++++++--
 t/t6437-submodule-merge.sh  |  78 +++++++++++++++++++++++--
 t/t7402-submodule-rebase.sh |   9 ++-
 3 files changed, 185 insertions(+), 14 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 01f150ef3b..4302e900ee 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -387,6 +387,9 @@ struct merge_options_internal {
=20
 	/* call_depth: recursion level counter for merging merge bases */
 	int call_depth;
+
+	/* field that holds submodule conflict information */
+	struct string_list conflicted_submodules;
 };
=20
 struct version_info {
@@ -517,6 +520,7 @@ enum conflict_and_info_types {
 	CONFLICT_SUBMODULE_NOT_INITIALIZED,
 	CONFLICT_SUBMODULE_HISTORY_NOT_AVAILABLE,
 	CONFLICT_SUBMODULE_MAY_HAVE_REWINDS,
+	CONFLICT_SUBMODULE_NULL_MERGE_BASE,
=20
 	/* Keep this entry _last_ in the list */
 	NB_CONFLICT_TYPES,
@@ -570,6 +574,8 @@ static const char *type_short_descriptions[] =3D {
 		"CONFLICT (submodule history not available)",
 	[CONFLICT_SUBMODULE_MAY_HAVE_REWINDS] =3D
 		"CONFLICT (submodule may have rewinds)",
+	[CONFLICT_SUBMODULE_NULL_MERGE_BASE] =3D
+		"CONFLICT (submodule no merge base)"
 };
=20
 struct logical_conflict_info {
@@ -686,6 +692,8 @@ static void clear_or_reinit_internal_opts(struct merge_=
options_internal *opti,
=20
 	mem_pool_discard(&opti->pool, 0);
=20
+	string_list_clear(&opti->conflicted_submodules, 1);
+
 	/* Clean out callback_data as well. */
 	FREE_AND_NULL(renames->callback_data);
 	renames->callback_data_nr =3D renames->callback_data_alloc =3D 0;
@@ -1744,26 +1752,40 @@ static int merge_submodule(struct merge_options *op=
t,
=20
 	int i;
 	int search =3D !opt->priv->call_depth;
+	int sub_initialized =3D 1;
=20
 	/* store fallback answer in result in case we fail */
 	oidcpy(result, opt->priv->call_depth ? o : a);
=20
 	/* we can not handle deletion conflicts */
-	if (is_null_oid(o))
-		return 0;
 	if (is_null_oid(a))
-		return 0;
+		BUG("submodule deleted on one side; this should be handled outside of me=
rge_submodule()");=20
 	if (is_null_oid(b))
-		return 0;
+		BUG("submodule deleted on one side; this should be handled outside of me=
rge_submodule()");
=20
-	if (repo_submodule_init(&subrepo, opt->repo, path, null_oid())) {
+	if ((sub_initialized =3D repo_submodule_init(&subrepo,
+									opt->repo, path, null_oid()))) {
 		path_msg(opt, CONFLICT_SUBMODULE_NOT_INITIALIZED, 0,
 			 path, NULL, NULL, NULL,
 			 _("Failed to merge submodule %s (not checked out)"),
 			 path);
+		/*
+		 * NEEDSWORK: Since the steps to resolve this error are
+		 * more involved than what is currently in=20
+		 * print_submodule_conflict_suggestion(), we return
+		 * immediately rather than generating an error message
+		 */
 		return 0;
 	}
=20
+	if (is_null_oid(o)) {
+		path_msg(opt, CONFLICT_SUBMODULE_NULL_MERGE_BASE, 0,
+			 path, NULL, NULL, NULL,
+			 _("Failed to merge submodule %s (no merge base)"),
+			 path);
+		goto cleanup;
+	}
+
 	if (!(commit_o =3D lookup_commit_reference(&subrepo, o)) ||
 	    !(commit_a =3D lookup_commit_reference(&subrepo, a)) ||
 	    !(commit_b =3D lookup_commit_reference(&subrepo, b))) {
@@ -1849,7 +1871,15 @@ static int merge_submodule(struct merge_options *opt=
,
=20
 	object_array_clear(&merges);
 cleanup:
-	repo_clear(&subrepo);
+	if (!opt->priv->call_depth && !ret) {
+		struct string_list *csub =3D &opt->priv->conflicted_submodules;
+
+		string_list_append(csub, path)->util =3D
+				xstrdup(repo_find_unique_abbrev(&subrepo, b, DEFAULT_ABBREV));
+	}
+
+	if (!sub_initialized)
+		repo_clear(&subrepo);
 	return ret;
 }
=20
@@ -4412,6 +4442,73 @@ static int record_conflicted_index_entries(struct me=
rge_options *opt)
 	return errs;
 }
=20
+static void print_submodule_conflict_suggestion(struct string_list *csub) =
{
+	if (csub->nr > 0) {
+		struct string_list_item *item;
+		struct strbuf msg =3D STRBUF_INIT;
+		struct strbuf tmp =3D STRBUF_INIT;
+
+		strbuf_addf(&tmp, _("Recursive merging with submodules currently only su=
pports trivial cases."));
+		strbuf_addf(&msg, "%s\n", tmp.buf);
+		strbuf_release(&tmp);
+
+		strbuf_addf(&tmp, _("Please manually handle the merging of each conflict=
ed submodule."));
+		strbuf_addf(&msg, "%s\n", tmp.buf);
+		strbuf_release(&tmp);
+
+		strbuf_addf(&tmp, _("This can be accomplished with the following steps:"=
));
+		strbuf_addf(&msg, "%s\n", tmp.buf);
+		strbuf_release(&tmp);
+
+		for_each_string_list_item(item, csub) {
+			const char *abbrev=3D item->util;
+			/*
+			 * TRANSLATORS: This is a line of advice to resolve a merge conflict
+			 * in a submodule. The second argument is the abbreviated id of the
+			 * commit that needs to be merged.
+			 * E.g. - go to submodule (sub), and either merge commit abc1234"
+			 */
+			strbuf_addf(&tmp, _("go to submodule (%s), and either merge commit %s")=
,
+													item->string, abbrev);
+			strbuf_addf(&msg, _(" - %s"), tmp.buf);
+			strbuf_addf(&msg, "\n");
+			strbuf_release(&tmp);
+			strbuf_addf(&tmp, _("or update to an existing commit which has merged t=
hose changes"));
+			strbuf_addf(&msg, _("   %s"), tmp.buf);
+			strbuf_addf(&msg, "\n");
+			strbuf_release(&tmp);
+		}
+		strbuf_addf(&tmp, _("come back to superproject and run:"));
+		strbuf_addf(&msg, _(" - %s"), tmp.buf);
+		strbuf_addf(&msg, "\n\n");
+		strbuf_release(&tmp);
+
+		strbuf_addf(&tmp, "git add ");
+		strbuf_add_separated_string_list(&tmp, " ", csub);
+		strbuf_addf(&msg, _("       %s"), tmp.buf);
+		strbuf_addf(&msg, "\n\n");
+		strbuf_release(&tmp);
+
+		strbuf_addf(&tmp, _("to record the above merge or update"));
+		strbuf_addf(&msg, _("   %s"), tmp.buf);
+		strbuf_addf(&msg, "\n");
+		strbuf_release(&tmp);
+
+		strbuf_addf(&tmp, _("resolve any other conflicts in the superproject"));
+		strbuf_addf(&msg, _(" - %s"), tmp.buf);
+		strbuf_addf(&msg, "\n");
+		strbuf_release(&tmp);
+
+		strbuf_addf(&tmp, _("commit the resulting index in the superproject"));
+		strbuf_addf(&msg, _(" - %s"), tmp.buf);
+		strbuf_addf(&msg, "\n");
+		strbuf_release(&tmp);
+
+		printf("%s", msg.buf);
+		strbuf_release(&msg);
+	}
+}
+
 void merge_display_update_messages(struct merge_options *opt,
 				   int detailed,
 				   struct merge_result *result)
@@ -4461,6 +4558,8 @@ void merge_display_update_messages(struct merge_optio=
ns *opt,
 	}
 	string_list_clear(&olist, 0);
=20
+	print_submodule_conflict_suggestion(&opti->conflicted_submodules);
+
 	/* Also include needed rename limit adjustment now */
 	diff_warn_rename_limit("merge.renamelimit",
 			       opti->renames.needed_limit, 0);
@@ -4657,6 +4756,7 @@ static void merge_start(struct merge_options *opt, st=
ruct merge_result *result)
 	trace2_region_enter("merge", "allocate/init", opt->repo);
 	if (opt->priv) {
 		clear_or_reinit_internal_opts(opt->priv, 1);
+		string_list_init_nodup(&opt->priv->conflicted_submodules);
 		trace2_region_leave("merge", "allocate/init", opt->repo);
 		return;
 	}
diff --git a/t/t6437-submodule-merge.sh b/t/t6437-submodule-merge.sh
index c253bf759a..414597a420 100755
--- a/t/t6437-submodule-merge.sh
+++ b/t/t6437-submodule-merge.sh
@@ -103,8 +103,25 @@ test_expect_success 'setup for merge search' '
 	 echo "file-c" > file-c &&
 	 git add file-c &&
 	 git commit -m "sub-c") &&
-	git commit -a -m "c" &&
+	git commit -a -m "c")
+'
=20
+test_expect_success 'merging should conflict for non fast-forward' '
+	test_when_finished "git -C merge-search reset --hard" &&
+	(cd merge-search &&
+	 git checkout -b test-nonforward-a b &&
+	  if test "$GIT_TEST_MERGE_ALGORITHM" =3D ort
+	  then
+		test_must_fail git merge c >actual &&
+		sub_expect=3D"go to submodule (sub), and either merge commit $(git -C su=
b rev-parse --short sub-c)" &&
+	 	grep "$sub_expect" actual
+	  else
+		test_must_fail git merge c 2> actual
+	  fi)
+'
+
+test_expect_success 'finish setup for merge-search' '
+	(cd merge-search &&
 	git checkout -b d a &&
 	(cd sub &&
 	 git checkout -b sub-d sub-b &&
@@ -129,14 +146,16 @@ test_expect_success 'merge with one side as a fast-fo=
rward of the other' '
 	 test_cmp expect actual)
 '
=20
-test_expect_success 'merging should conflict for non fast-forward' '
+test_expect_success 'merging should conflict for non fast-forward (resolut=
ion exists)' '
 	(cd merge-search &&
-	 git checkout -b test-nonforward b &&
+	 git checkout -b test-nonforward-b b &&
 	 (cd sub &&
 	  git rev-parse --short sub-d > ../expect) &&
 	  if test "$GIT_TEST_MERGE_ALGORITHM" =3D ort
 	  then
-		test_must_fail git merge c >actual
+		test_must_fail git merge c >actual &&
+		sub_expect=3D"go to submodule (sub), and either merge commit $(git -C su=
b rev-parse --short sub-c)" &&
+	 	grep "$sub_expect" actual
 	  else
 		test_must_fail git merge c 2> actual
 	  fi &&
@@ -161,7 +180,9 @@ test_expect_success 'merging should fail for ambiguous =
common parent' '
 	 ) &&
 	 if test "$GIT_TEST_MERGE_ALGORITHM" =3D ort
 	 then
-		test_must_fail git merge c >actual
+		test_must_fail git merge c >actual &&
+		sub_expect=3D"go to submodule (sub), and either merge commit $(git -C su=
b rev-parse --short sub-c)" &&
+		grep "$sub_expect" actual
 	 else
 		test_must_fail git merge c 2> actual
 	 fi &&
@@ -205,7 +226,12 @@ test_expect_success 'merging should fail for changes t=
hat are backwards' '
 	git commit -a -m "f" &&
=20
 	git checkout -b test-backward e &&
-	test_must_fail git merge f)
+	test_must_fail git merge f >actual &&
+	if test "$GIT_TEST_MERGE_ALGORITHM" =3D ort
+    then
+		sub_expect=3D"go to submodule (sub), and either merge commit $(git -C su=
b rev-parse --short sub-d)" &&
+		grep "$sub_expect" actual
+	fi)
 '
=20
=20
@@ -476,4 +502,44 @@ test_expect_failure 'directory/submodule conflict; mer=
ge --abort works afterward
 	)
 '
=20
+# Setup:
+#   - Submodule has 2 commits: a and b
+#   - Superproject branch 'a' adds and commits submodule pointing to 'comm=
it a'
+#   - Superproject branch 'b' adds and commits submodule pointing to 'comm=
it b'
+# If these two branches are now merged, there is no merge base
+test_expect_success 'setup for null merge base' '
+	mkdir no-merge-base &&
+	(cd no-merge-base &&
+	git init &&
+	mkdir sub &&
+	(cd sub &&
+	 git init &&
+	 echo "file-a" > file-a &&
+	 git add file-a &&
+	 git commit -m "commit a") &&
+	git commit --allow-empty -m init &&
+	git branch init &&
+	git checkout -b a init &&
+	git add sub &&
+	git commit -m "a" &&
+	git switch main &&
+	(cd sub &&
+	 echo "file-b" > file-b &&
+	 git add file-b &&
+	 git commit -m "commit b"))
+'
+
+test_expect_success 'merging should fail with no merge base' '
+	(cd no-merge-base &&
+	git checkout -b b init &&
+	git add sub &&
+	git commit -m "b" &&
+	test_must_fail git merge a >actual &&
+	if test "$GIT_TEST_MERGE_ALGORITHM" =3D ort
+    then
+		sub_expect=3D"go to submodule (sub), and either merge commit $(git -C su=
b rev-parse --short HEAD^1)" &&
+		grep "$sub_expect" actual
+	fi)
+'
+
 test_done
diff --git a/t/t7402-submodule-rebase.sh b/t/t7402-submodule-rebase.sh
index 8e32f19007..ebeca12a71 100755
--- a/t/t7402-submodule-rebase.sh
+++ b/t/t7402-submodule-rebase.sh
@@ -104,7 +104,7 @@ test_expect_success 'rebasing submodule that should con=
flict' '
 	test_tick &&
 	git commit -m fourth &&
=20
-	test_must_fail git rebase --onto HEAD^^ HEAD^ HEAD^0 &&
+	test_must_fail git rebase --onto HEAD^^ HEAD^ HEAD^0 >actual_output &&
 	git ls-files -s submodule >actual &&
 	(
 		cd submodule &&
@@ -112,7 +112,12 @@ test_expect_success 'rebasing submodule that should co=
nflict' '
 		echo "160000 $(git rev-parse HEAD^^) 2	submodule" &&
 		echo "160000 $(git rev-parse HEAD) 3	submodule"
 	) >expect &&
-	test_cmp expect actual
+	test_cmp expect actual &&
+	if test "$GIT_TEST_MERGE_ALGORITHM" =3D ort
+    then
+		sub_expect=3D"go to submodule (submodule), and either merge commit $(git=
 -C submodule rev-parse --short HEAD^0)" &&
+		grep "$sub_expect" actual_output
+	fi
 '
=20
 test_done

base-commit: 9dd64cb4d310986dd7b8ca7fff92f9b61e0bd21a
--=20
2.37.1.455.g008518b4e5-goog


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D59FC00144
	for <git@archiver.kernel.org>; Tue, 26 Jul 2022 21:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbiGZVAe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jul 2022 17:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbiGZVAc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jul 2022 17:00:32 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48EFEB7D2
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 14:00:31 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id o21-20020a17090a9f9500b001f0574225faso46472pjp.6
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 14:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=8JGRLIKuanuMCdxx20ALRRcL7xKezxGdjjXszAJ0XVY=;
        b=HWIlfeFEB/aBE1mLnGdWQW48az+GGGaJKwT4A7BPIpag7/zozRbgZQOVW37QgWTsqo
         o/0NfSGeuBYxA7wK9NvccigSEyPw2hLF4xp0LqPp/fZXwbg1nRKV6Oa9RuNmAzKYWfKy
         ETlCdfXBf208uuLKmOQ3RIPqDwKVrG6tK5xbjlDaXT+e8Cnnqxgy3M47+uBmWwYlYVas
         YrDlVlMs7uM4e6QOR3jJYNPQtsUKwNHgoMQecH1ACx2pTarr/frDMS+mB4gUIpBh4lZp
         qshV144BHQbusbtD9ZybtFJ+zc8CTJLwwNYUrkgP11tuNGD0hjISDRxP+rfjprQXmTcU
         2JcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=8JGRLIKuanuMCdxx20ALRRcL7xKezxGdjjXszAJ0XVY=;
        b=sPRUqQV3t+KWs/2e9INgl1SDg+9QtwkOP42rGwktp4mAgHaIM8Uh7yw8F0i7BTMa1j
         rQVZSKRbL6Ixk3eBnMkXqIRKaoGZWCZBof4mBaLRMZO3yv8KIJjgHM5YkT2h7+R9BHdB
         5PWNn+jx4wyXSvQGd7MHP/98gN40wLNntqjysO3jLiNdWci2fn/GawwIuL6IwRch4pTy
         6q2gBQBK+sxrAco7livf5I37f/nWw9nN9HHO5upY7UUgfZoT3jR6QKgG8ROS5TCe6Wbx
         sNTBElgvFUeza2N6DtyO8UjM0a9831zz0hd3ZVLTbb/jXcYaNz5xNNg7kQGPwn60GtNt
         DI/w==
X-Gm-Message-State: AJIora8+u5/LxTmkxHjUUkL+U2C7x0fULZQlOHGk1mHgPUtW0hKMMfOh
        nnvUBYCr8ycwbCiCCf+CzYEZYDYMG3Hw96sjqAORWGVSk1mGkD6e8knSsYEIFUdDobLaWyDP71m
        utvQhwlMM3URPpLFozn9vRheZgojHHj5xqXn0XDFMLUuD+/8xyBCh4C24JLg8Kpgs8w==
X-Google-Smtp-Source: AGRyM1t962SLL0x5voLPwplXayC6oXB1ZlHY5p4yflfZkcEDVmLYg+Jtg/nTYluLfKUFyQGnRCymV6BFgmiAFK0=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:90b:4ac7:b0:1f2:8413:1b02 with SMTP
 id mh7-20020a17090b4ac700b001f284131b02mr934441pjb.142.1658869230606; Tue, 26
 Jul 2022 14:00:30 -0700 (PDT)
Date:   Tue, 26 Jul 2022 21:00:20 +0000
In-Reply-To: <20220718214349.3379328-1-calvinwan@google.com>
Message-Id: <20220726210020.3397249-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20220718214349.3379328-1-calvinwan@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v6] submodule merge: update conflict error message
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
fails and git prints an error message that accurately describes the
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
commit that needs to be merged, which could be useful information
for the user.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---

I'm a little unsure on the code style for the `git add` section of
the error message. It works, but is tricky for a code reviewer
to decipher the formatting. I don't think it should affect
translation since the text is only a git command and folder names.

Changes since v5:
 - Fixed memory leak reported by =C3=86var
 - Fixed error message formatting and addded TRANSLATOR tags
 - Removed "resolution exists"

 merge-ort.c                 | 61 +++++++++++++++++++++++++++++++++++++
 t/t6437-submodule-merge.sh  | 38 +++++++++++++++++++----
 t/t7402-submodule-rebase.sh |  9 ++++--
 3 files changed, 100 insertions(+), 8 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 01f150ef3b..147be0ce31 100644
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
@@ -686,6 +689,8 @@ static void clear_or_reinit_internal_opts(struct merge_=
options_internal *opti,
=20
 	mem_pool_discard(&opti->pool, 0);
=20
+	string_list_clear(&opti->conflicted_submodules, 1);
+
 	/* Clean out callback_data as well. */
 	FREE_AND_NULL(renames->callback_data);
 	renames->callback_data_nr =3D renames->callback_data_alloc =3D 0;
@@ -1849,6 +1854,17 @@ static int merge_submodule(struct merge_options *opt=
,
=20
 	object_array_clear(&merges);
 cleanup:
+	if (!ret) {
+		struct string_list *csub =3D &opt->priv->conflicted_submodules;
+		char *util;
+		const char *abbrev;
+
+		abbrev =3D repo_find_unique_abbrev(&subrepo, b, DEFAULT_ABBREV);
+		util =3D xstrdup(abbrev);
+
+		string_list_append(csub, path)->util =3D util;
+	}
+
 	repo_clear(&subrepo);
 	return ret;
 }
@@ -4412,6 +4428,47 @@ static int record_conflicted_index_entries(struct me=
rge_options *opt)
 	return errs;
 }
=20
+static void print_submodule_conflict_suggestion(struct string_list *csub) =
{
+	int first =3D 1;
+	if (csub->nr > 0) {
+		struct string_list_item *item;
+		printf(_("Recursive merging with submodules currently only supports triv=
ial cases.\n"
+			"Please manually handle the merging of each conflicted submodule.\n"
+			"This can be accomplished with the following steps:\n"));
+
+		for_each_string_list_item(item, csub) {
+            const char *abbrev=3D item->util;
+			/*
+			 * TRANSLATORS: This is a line of advice to resolve a merge conflict
+			 * in a submodule. The second argument is the abbreviated id of the
+			 * commit that needs to be merged.
+			 * E.g. - go to submodule (sub), and either merge commit abc1234"
+			 */
+			printf(_(" - go to submodule (%s), and either merge commit %s\n"
+				    "   or update to an existing commit which has merged those changes=
\n"),
+					item->string, abbrev);
+		}
+		printf(_(" - come back to superproject and run:\n\n"));
+		for_each_string_list_item(item, csub)
+			/*
+			 * TRANSLATORS: This is a line of a recommended `git add` command
+			 * with multiple lines of submodule folders.
+			 * E.g.:     git add sub \
+			 *                   sub2 \
+			 *                   sub3
+			 */
+			if (first) {
+				printf("       git add %s", item->string);
+				first =3D 0;
+			} else {
+ 				printf(" \\\n               %s", item->string);
+			}
+		printf(_("\n\n   to record the above merge or update\n"
+			" - resolve any other conflicts in the superproject\n"
+			" - commit the resulting index in the superproject\n"));
+	}
+}
+
 void merge_display_update_messages(struct merge_options *opt,
 				   int detailed,
 				   struct merge_result *result)
@@ -4461,6 +4518,9 @@ void merge_display_update_messages(struct merge_optio=
ns *opt,
 	}
 	string_list_clear(&olist, 0);
=20
+	print_submodule_conflict_suggestion(&opti->conflicted_submodules);
+	string_list_clear(&opti->conflicted_submodules, 1);
+
 	/* Also include needed rename limit adjustment now */
 	diff_warn_rename_limit("merge.renamelimit",
 			       opti->renames.needed_limit, 0);
@@ -4657,6 +4717,7 @@ static void merge_start(struct merge_options *opt, st=
ruct merge_result *result)
 	trace2_region_enter("merge", "allocate/init", opt->repo);
 	if (opt->priv) {
 		clear_or_reinit_internal_opts(opt->priv, 1);
+		string_list_init_dup(&opt->priv->conflicted_submodules);
 		trace2_region_leave("merge", "allocate/init", opt->repo);
 		return;
 	}
diff --git a/t/t6437-submodule-merge.sh b/t/t6437-submodule-merge.sh
index c253bf759a..84913525cf 100755
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
2.37.1.359.gd136c6c3e2-goog


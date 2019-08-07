Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BD451F731
	for <e@80x24.org>; Wed,  7 Aug 2019 18:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389427AbfHGS5b (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Aug 2019 14:57:31 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:37700 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388849AbfHGS5a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Aug 2019 14:57:30 -0400
Received: by mail-pl1-f202.google.com with SMTP id n4so53057215plp.4
        for <git@vger.kernel.org>; Wed, 07 Aug 2019 11:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=tg7/n0F05+e3DGZh+6SpWaJFccmjnkwj17Aa/5mkLz8=;
        b=UTUB5p+r9aKDznAsnk4gMeTyA2ib0bw3+LD0GGcbY0N3so8LbLOdVw7z70UlqtEE9k
         y9aNyffYjSgtY3OAWZbbyjjeC0uTbyJm5ZqzHR9jYGXEXKJNTt6K2teSNtYKQIAkP7kW
         AQbx6ZbT+mxdTkiX9ZpbbG0HJ6aDH/wGD53LpCc4cXAgFxlJCqP7YFzvEiebOgZI22og
         zutLsY/YSZ57IKEnnFfR4v66uzzKwKVbAe7ZYtGWvCIMhikf17/9WJ5HldlQ1xoX3zF9
         iU4RcX7uwMWDiTS9w5UF7Y1Qmj4eWHjQGfHh23Gl9jhz5oKuV14SKFuX1/Oa7IfxLl9f
         LaXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=tg7/n0F05+e3DGZh+6SpWaJFccmjnkwj17Aa/5mkLz8=;
        b=Z3genxVcSmsJOn6NseH4zW4ejlbkNpTid0am58cE5PbhJvAt9tzE7XtaAjXn3sgwkn
         Vf6I+Qe55LJR6KGaxz77ktlUAhlXCqx+dR2DSgTw4sG3ZhEX5Pi+NOshohxwcAUEFO7V
         ynzRTc98AWfeJ9a2Zj5v35P4Spj/vtCa3FGgTuW+yg89UWDhnIuUosp61vFr6+wf/URk
         xn54qNgze8ne9CiVM6aciiJl+VfC8SdrQfU+no3VUJsnC++/o8yuMUBUab8wEleP/YXP
         3W+nArTy+IMfcHH3/k/yg/SQzFgUyGzYAV3XvBBfhSfveOpBsh94SX094LTKld2JP2QM
         njug==
X-Gm-Message-State: APjAAAVRUoKOdKun3Ir2qhUactAWh5pDKwhebX562yPA6kVMlq1Ny0P2
        6YOalF9BWYB2WUaF1YIc2x2jRo9JouI+Bt/PdZEf9C3S9O4aNq5THSPums5I8CvonPXsnj574eL
        H0zDuqVNwTtYGosm/nAYse/i3rIDs/xSPIfWoMTyNRjxIgXBg7iIOMRKD/H2hlGA=
X-Google-Smtp-Source: APXvYqxGRvjfeTBlPjfKnZVogRRV7J4Fk69W+boSXnmj1KYKOQ9tXvy/suoxoFKw0PlJsdIjAbXTxd/M5gDoJg==
X-Received: by 2002:a63:d84e:: with SMTP id k14mr9006182pgj.234.1565204249776;
 Wed, 07 Aug 2019 11:57:29 -0700 (PDT)
Date:   Wed,  7 Aug 2019 11:57:08 -0700
In-Reply-To: <cover.1565203880.git.steadmon@google.com>
Message-Id: <7b81e2717f739a92dea10eaf570407c742d30533.1565203880.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1565044345.git.steadmon@google.com> <cover.1565203880.git.steadmon@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH v5 4/4] merge: --no-verify to bypass pre-merge-commit hook
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, git@grubix.eu, martin.agren@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Michael J Gruber <git@drmicha.warpmail.net>

Analogous to commit, introduce a '--no-verify' option which bypasses the
pre-merge-commit hook. The shorthand '-n' is taken by '--no-stat'
already.

[js: * reworded commit message to reflect current state of --no-stat flag
       and new hook name
     * fixed flag documentation to reflect new hook name
     * cleaned up trailing whitespace
     * squashed test changes from the original series' patch 4/4
     * modified tests to follow pattern from this series' patch 1/4
     * added a test case for --no-verify with non-executable hook
     * when testing that the merge hook did not run, make sure we
       actually have a merge to perform (by resetting the "side" branch
       to its original state).

]

Improved-by: Martin =C3=85gren <martin.agren@gmail.com>
Signed-off-by: Michael J Gruber <git@grubix.eu>
Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 Documentation/githooks.txt                    |  3 +-
 builtin/merge.c                               |  4 +-
 ...3-pre-commit-and-pre-merge-commit-hooks.sh | 39 +++++++++++++++++++
 3 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index d9da474fb0..57d6e2b98d 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -106,7 +106,8 @@ the use of non-ASCII filenames.
 pre-merge-commit
 ~~~~~~~~~~~~~~~~
=20
-This hook is invoked by linkgit:git-merge[1]. It takes no parameters, and =
is
+This hook is invoked by linkgit:git-merge[1], and can be bypassed
+with the `--no-verify` option.  It takes no parameters, and is
 invoked after the merge has been carried out successfully and before
 obtaining the proposed commit log message to
 make a commit.  Exiting with a non-zero status from this script
diff --git a/builtin/merge.c b/builtin/merge.c
index bf0ae68c40..c9746e37b8 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -287,7 +287,7 @@ static struct option builtin_merge_options[] =3D {
 	  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
 	OPT_BOOL(0, "overwrite-ignore", &overwrite_ignore, N_("update ignored fil=
es (default)")),
 	OPT_BOOL(0, "signoff", &signoff, N_("add Signed-off-by:")),
-	OPT_BOOL(0, "no-verify", &no_verify, N_("bypass commit-msg hook")),
+	OPT_BOOL(0, "no-verify", &no_verify, N_("bypass pre-merge-commit and comm=
it-msg hooks")),
 	OPT_END()
 };
=20
@@ -818,7 +818,7 @@ static void prepare_to_commit(struct commit_list *remot=
eheads)
 	struct strbuf msg =3D STRBUF_INIT;
 	const char *index_file =3D get_index_file();
=20
-	if (run_commit_hook(0 < option_edit, index_file, "pre-merge-commit", NULL=
))
+	if (!no_verify && run_commit_hook(0 < option_edit, index_file, "pre-merge=
-commit", NULL))
 		abort_commit(remoteheads, NULL);
 	/*
 	 * Re-read the index as pre-merge-commit hook could have updated it,
diff --git a/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh b/t/t7503-pre=
-commit-and-pre-merge-commit-hooks.sh
index 7a5434c7ab..b3485450a2 100755
--- a/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
+++ b/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
@@ -84,6 +84,15 @@ test_expect_success '--no-verify with no hook' '
 	test_path_is_missing actual_hooks
 '
=20
+test_expect_success '--no-verify with no hook (merge)' '
+	test_when_finished "rm -f actual_hooks" &&
+	git branch -f side side-orig &&
+	git checkout side &&
+	git merge --no-verify -m "merge master" master &&
+	git checkout master &&
+	test_path_is_missing actual_hooks
+'
+
 test_expect_success 'with succeeding hook' '
 	test_when_finished "rm -f \"$PRECOMMIT\" expected_hooks actual_hooks" &&
 	cp "$HOOKDIR/success.sample" "$PRECOMMIT" &&
@@ -131,6 +140,16 @@ test_expect_success '--no-verify with succeeding hook'=
 '
 	test_path_is_missing actual_hooks
 '
=20
+test_expect_success '--no-verify with succeeding hook (merge)' '
+	test_when_finished "rm -f \"$PREMERGE\" actual_hooks" &&
+	cp "$HOOKDIR/success.sample" "$PREMERGE" &&
+	git branch -f side side-orig &&
+	git checkout side &&
+	git merge --no-verify -m "merge master" master &&
+	git checkout master &&
+	test_path_is_missing actual_hooks
+'
+
 test_expect_success 'with failing hook' '
 	test_when_finished "rm -f \"$PRECOMMIT\" expected_hooks actual_hooks" &&
 	cp "$HOOKDIR/fail.sample" "$PRECOMMIT" &&
@@ -160,6 +179,16 @@ test_expect_success 'with failing hook (merge)' '
 	test_cmp expected_hooks actual_hooks
 '
=20
+test_expect_success '--no-verify with failing hook (merge)' '
+	test_when_finished "rm -f \"$PREMERGE\" actual_hooks" &&
+	cp "$HOOKDIR/fail.sample" "$PREMERGE" &&
+	git branch -f side side-orig &&
+	git checkout side &&
+	git merge --no-verify -m "merge master" master &&
+	git checkout master &&
+	test_path_is_missing actual_hooks
+'
+
 test_expect_success POSIXPERM 'with non-executable hook' '
 	test_when_finished "rm -f \"$PRECOMMIT\" actual_hooks" &&
 	cp "$HOOKDIR/non-exec.sample" "$PRECOMMIT" &&
@@ -188,6 +217,16 @@ test_expect_success POSIXPERM 'with non-executable hoo=
k (merge)' '
 	test_path_is_missing actual_hooks
 '
=20
+test_expect_success POSIXPERM '--no-verify with non-executable hook (merge=
)' '
+	test_when_finished "rm -f \"$PREMERGE\" actual_hooks" &&
+	cp "$HOOKDIR/non-exec.sample" "$PREMERGE" &&
+	git branch -f side side-orig &&
+	git checkout side &&
+	git merge --no-verify -m "merge master" master &&
+	git checkout master &&
+	test_path_is_missing actual_hooks
+'
+
 test_expect_success 'with hook requiring GIT_PREFIX' '
 	test_when_finished "rm -rf \"$PRECOMMIT\" expected_hooks actual_hooks suc=
cess" &&
 	cp "$HOOKDIR/require-prefix.sample" "$PRECOMMIT" &&
--=20
2.22.0.770.g0f2c4a37fd-goog


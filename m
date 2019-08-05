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
	by dcvr.yhbt.net (Postfix) with ESMTP id F13561F731
	for <e@80x24.org>; Mon,  5 Aug 2019 22:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730909AbfHEWny (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Aug 2019 18:43:54 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:34898 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728870AbfHEWny (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Aug 2019 18:43:54 -0400
Received: by mail-pg1-f202.google.com with SMTP id w12so11316553pgo.2
        for <git@vger.kernel.org>; Mon, 05 Aug 2019 15:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=ck8Q+Dx5rRcKIcbzYUuy8QgvTj3f9B7xELvz0ItUU/E=;
        b=tSV9pY+tPU2OkOsOPKXQD4oIQSWDx6AtDYgbfdXcHTtZEkE+kVmJYlHFuBuANuWJP4
         h6AeFLnGlsoS0cgaILlIq27kFuBc7JLkVaU0rtxrKFdK/BnwmXwftLUgMn0E9WleZDK9
         /0R+dByDbbXOjMxQeadxrZ8Wyl6l18TUhntvvpSO4KXp8jqDeM0YVrlgjXhlJLk3GlRP
         ywQuhARcXKVfk90c4chbZJafanpKaMO9YEucJVLFLCEN0H5ffO0/8jpVSVntx4+64mnh
         DvUw/YZ5kn3AMCfbe0Yl2TYyNN+4NZjsoXPbn/6I/C/DW1smOuMM7P75ER7ls5Anbtzk
         tCaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=ck8Q+Dx5rRcKIcbzYUuy8QgvTj3f9B7xELvz0ItUU/E=;
        b=akbx89Sl44LhAmxaCUEJI7JEoc8e+SWCkOa5ZOKTR7gkbu4FIzuTdMyIdEc0kRwXoP
         m6CP0W11+LH1TjvilhokFkmr0e5GTxuBRCUndDc/3oO2FkMpCbnvZq+WGldkVVPeJ3+F
         CbzabrX/SkZ0skkQVVRefl2Rqoh5Pvq+O0UzuwOdv68zASjIbrgVmr2k8hvsh7KrD/FD
         ecZale2udzebh0B4UsCOw5a6Oh45QGtab82jqq7ghZpeXSv0fVQOuI297hRTuaqAvzDG
         kexJf+zoAY9LWYp6+ifZ0/qj6K+gxM/QsUsP6EH+9LXrRIA73kHq+3l/InMoj2qvxBfk
         jgNA==
X-Gm-Message-State: APjAAAUAgxwv8u2K/0QmfBqZK/8fPA22Mo9Yy57cUNX4abJJd7l/drD7
        cXJ1ibM82RrpW/zyS1lJVenOK52gOHqxVfwINIoVqmgZ0dKXdmdcR/B1ZKBX//bYWE4nH8Ko73k
        OddScIgSPbwS3eyuhIAN1ZELUy2ccJfTsSwd4npNoKOjg+fFMp6CrFD+SnHOXYUQ=
X-Google-Smtp-Source: APXvYqx3w5iFksShXN6/sND3NBLk3u2/ISdNLbOUNLgdeBfNwZJLb69azLH7RoMs5yKq1fI24BcmUUiRU6Rg9w==
X-Received: by 2002:a63:9e56:: with SMTP id r22mr164753pgo.221.1565045032385;
 Mon, 05 Aug 2019 15:43:52 -0700 (PDT)
Date:   Mon,  5 Aug 2019 15:43:39 -0700
In-Reply-To: <cover.1565044345.git.steadmon@google.com>
Message-Id: <96c54883d3adbe314461c4bf70e7edc9d2ee52d3.1565044345.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1564695892.git.steadmon@google.com> <cover.1565044345.git.steadmon@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH v4 4/4] merge: --no-verify to bypass pre-merge-commit hook
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
index 0700604f03..d900c3a696 100755
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
 	ln -s "success.sample" "$PRECOMMIT" &&
@@ -131,6 +140,16 @@ test_expect_success '--no-verify with succeeding hook'=
 '
 	test_path_is_missing actual_hooks
 '
=20
+test_expect_success '--no-verify with succeeding hook (merge)' '
+	test_when_finished "rm -f \"$PREMERGE\" actual_hooks" &&
+	ln -s "success.sample" "$PREMERGE" &&
+	git branch -f side side-orig &&
+	git checkout side &&
+	git merge --no-verify -m "merge master" master &&
+	git checkout master &&
+	test_path_is_missing actual_hooks
+'
+
 test_expect_success 'with failing hook' '
 	test_when_finished "rm -f \"$PRECOMMIT\" expected_hooks actual_hooks" &&
 	ln -s "fail.sample" "$PRECOMMIT" &&
@@ -160,6 +179,16 @@ test_expect_success 'with failing hook (merge)' '
 	test_cmp expected_hooks actual_hooks
 '
=20
+test_expect_success '--no-verify with failing hook (merge)' '
+	test_when_finished "rm -f \"$PREMERGE\" actual_hooks" &&
+	ln -s "fail.sample" "$PREMERGE" &&
+	git branch -f side side-orig &&
+	git checkout side &&
+	git merge --no-verify -m "merge master" master &&
+	git checkout master &&
+	test_path_is_missing actual_hooks
+'
+
 test_expect_success POSIXPERM 'with non-executable hook' '
 	test_when_finished "rm -f \"$PRECOMMIT\" actual_hooks" &&
 	ln -s "non-exec.sample" "$PRECOMMIT" &&
@@ -188,6 +217,16 @@ test_expect_success POSIXPERM 'with non-executable hoo=
k (merge)' '
 	test_path_is_missing actual_hooks
 '
=20
+test_expect_success POSIXPERM '--no-verify with non-executable hook (merge=
)' '
+	test_when_finished "rm -f \"$PREMERGE\" actual_hooks" &&
+	ln -s "non-exec.sample" "$PREMERGE" &&
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
 	ln -s "require-prefix.sample" "$PRECOMMIT" &&
--=20
2.22.0.770.g0f2c4a37fd-goog


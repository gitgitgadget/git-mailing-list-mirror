Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA4EC433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 05:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35CAC60FBF
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 05:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238178AbhKPF5P (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 00:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238612AbhKPF4U (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 00:56:20 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF853C048F04
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 21:18:12 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id u18so35078274wrg.5
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 21:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RbYRmsxD0FXDK6VmNj1/iQb/hIyu0ZiOmMePLvpC8Xs=;
        b=cW50hUmLsPKG82O/KLzMJG6RL85FpqDjjYGsAniimcB37wEr0VoSF4BO+KsJtkAWWM
         8ID/2//ZpnOLgjYovDdOpE47uRDjELqBIfS+LVanX/TtaJaE/nB9B7ssMJUSPUTKTPMa
         9xFl2SQTH2rnH3c68FTuOuZB6wQn0mDKuz5Pp5CpYLGcNejFLIwNsjrPZPFY0uANVU5j
         HetQZOQ5Ny6M+KIPMmQ+Xr6R+dyk2y+0mMXmh1iuqNtBqk4NkOcvGyhZZMXStKjK3a8H
         9AfGW6pmpPBnHIoQhGiGeBHO4vLKP3X2QUGTUycdlIdtWSZnw4c2inRjYrmbVwmNqVLy
         48bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RbYRmsxD0FXDK6VmNj1/iQb/hIyu0ZiOmMePLvpC8Xs=;
        b=MVvV3fuI0B27kOT6Dsa/dOnRxsQyVJMTIBb9qbtfJ6W4WQjS2xB/BE64d1JCynmWvb
         nBFSnT27xLENCpxrk+EgH8MhFEUsearL1CUmA9VBAgWRwkjh8mji84XK7nP6T0cjvk04
         tqVjMVcea5VNt6HGY8yzxLY8YwmOwnCAh2jnMhUZTmOtH0UpBhRqkXvqW4apLs/WGmpj
         U8e8O15b8CV6oLfdMQ6nY03jMr/h9rVFul7UHOPFRaA77IaovdsS57p9ShIyCYPAs2n0
         /o6uzPNIso8+RZ13p1Nqu+pXT1KDmHXy6L8uit0RpOCBPfHKXLs1nHJrI37Hf4A6TboQ
         fSkQ==
X-Gm-Message-State: AOAM533ZRZtP9M6sJbw6PQQYeG/W7P4hANXf95v7PRkki+gJIoOPYmD3
        d2VbH8J7cCtBx84pVrPvgLHjA/hgpoI=
X-Google-Smtp-Source: ABdhPJzK3XVv2DHKU+XNHwDwe0wrOInxIEbo7wc9tXVDdxlJeXJYwTuWk7HHY3os5ALpavjA7MrTew==
X-Received: by 2002:a5d:6691:: with SMTP id l17mr5890746wru.227.1637039891343;
        Mon, 15 Nov 2021 21:18:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f7sm1484024wmg.6.2021.11.15.21.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 21:18:10 -0800 (PST)
Message-Id: <b7e30c9b7abecdc871ddc38122ca042e940cb190.1637039888.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v4.git.1637039888.gitgitgadget@gmail.com>
References: <pull.1076.v3.git.1636972769.gitgitgadget@gmail.com>
        <pull.1076.v4.git.1637039888.gitgitgadget@gmail.com>
From:   "Aleen via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Nov 2021 05:18:08 +0000
Subject: [PATCH v4 2/2] am: support --empty-commit option to handle empty
 patches
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Aleen =?UTF-8?Q?=E5=BE=90=E6=B2=9B=E6=96=87?= <pwxu@coremail.cn>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Aleen <aleen42@vip.qq.com>, Aleen <aleen42@vip.qq.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Aleen <aleen42@vip.qq.com>

Signed-off-by: Aleen <aleen42@vip.qq.com>
---
 Documentation/git-am.txt |  9 +++++
 builtin/am.c             | 48 +++++++++++++++++++++++---
 t/t4150-am.sh            | 73 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 125 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 0a4a984dfde..d8d3bf202d7 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -16,6 +16,7 @@ SYNOPSIS
 	 [--exclude=<path>] [--include=<path>] [--reject] [-q | --quiet]
 	 [--[no-]scissors] [-S[<keyid>]] [--patch-format=<format>]
 	 [--quoted-cr=<action>]
+	 [--empty-commit=(die|skip|asis)]
 	 [(<mbox> | <Maildir>)...]
 'git am' (--continue | --skip | --abort | --quit | --show-current-patch[=(diff|raw)])
 
@@ -63,6 +64,14 @@ OPTIONS
 --quoted-cr=<action>::
 	This flag will be passed down to 'git mailinfo' (see linkgit:git-mailinfo[1]).
 
+--empty-commit=(die|skip|asis)::
+	The command usually errors out when seeing an input e-mail
+	message that lacks a patch. When this option is set to
+	'skip', skip such an e-mail message without outputting error.
+	When this option is set to 'asis', create an empty commit,
+	recording the contents of the e-mail message as its log.
+	'die' is specified by default.
+
 -m::
 --message-id::
 	Pass the `-m` flag to 'git mailinfo' (see linkgit:git-mailinfo[1]),
diff --git a/builtin/am.c b/builtin/am.c
index 8677ea2348a..e7755c1377e 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -87,6 +87,12 @@ enum show_patch_type {
 	SHOW_PATCH_DIFF = 1,
 };
 
+enum empty_commit_action {
+	DIE_EMPTY_COMMIT = 0,  /* output errors */
+	SKIP_EMPTY_COMMIT,     /* skip without outputting errors */
+	ASIS_EMPTY_COMMIT      /* keep recording as empty commits */
+};
+
 struct am_state {
 	/* state directory path */
 	char *dir;
@@ -118,6 +124,7 @@ struct am_state {
 	int message_id;
 	int scissors; /* enum scissors_type */
 	int quoted_cr; /* enum quoted_cr_action */
+	int empty_commit; /* enum empty_commit_action */
 	struct strvec git_apply_opts;
 	const char *resolvemsg;
 	int committer_date_is_author_date;
@@ -178,6 +185,23 @@ static int am_option_parse_quoted_cr(const struct option *opt,
 	return 0;
 }
 
+static int am_option_parse_empty_commit(const struct option *opt,
+				     const char *arg, int unset)
+{
+	int *opt_value = opt->value;
+
+	if (unset || !strcmp(arg, "die"))
+		*opt_value = DIE_EMPTY_COMMIT;
+	else if (!strcmp(arg, "skip"))
+		*opt_value = SKIP_EMPTY_COMMIT;
+	else if (!strcmp(arg, "asis"))
+		*opt_value = ASIS_EMPTY_COMMIT;
+	else
+		return error(_("Invalid value for --empty-commit: %s"), arg);
+
+	return 0;
+}
+
 /**
  * Returns path relative to the am_state directory.
  */
@@ -1248,11 +1272,6 @@ static int parse_mail(struct am_state *state, const char *mail)
 		goto finish;
 	}
 
-	if (is_empty_or_missing_file(am_path(state, "patch"))) {
-		printf_ln(_("Patch is empty."));
-		die_user_resolve(state);
-	}
-
 	strbuf_addstr(&msg, "\n\n");
 	strbuf_addbuf(&msg, &mi.log_message);
 	strbuf_stripspace(&msg, 0);
@@ -1792,6 +1811,20 @@ static void am_run(struct am_state *state, int resume)
 		if (state->interactive && do_interactive(state))
 			goto next;
 
+		if (is_empty_or_missing_file(am_path(state, "patch"))) {
+			if (state->empty_commit == SKIP_EMPTY_COMMIT)
+				goto next;
+			else if (state->empty_commit == ASIS_EMPTY_COMMIT) {
+				if (run_applypatch_msg_hook(state))
+					exit(1);
+				else
+					goto commit;
+			} else if (state->empty_commit == DIE_EMPTY_COMMIT) {
+				printf_ln(_("Patch is empty."));
+				die_user_resolve(state);
+			}
+		}
+
 		if (run_applypatch_msg_hook(state))
 			exit(1);
 
@@ -1827,6 +1860,7 @@ static void am_run(struct am_state *state, int resume)
 			die_user_resolve(state);
 		}
 
+commit:
 		do_commit(state);
 
 next:
@@ -2357,6 +2391,10 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		{ OPTION_STRING, 'S', "gpg-sign", &state.sign_commit, N_("key-id"),
 		  N_("GPG-sign commits"),
 		  PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
+		{ OPTION_CALLBACK, 0, "empty-commit", &state.empty_commit,
+		  "(die|skip|asis)",
+		  N_("specify how to handle empty patches"),
+		  PARSE_OPT_OPTARG, am_option_parse_empty_commit },
 		OPT_HIDDEN_BOOL(0, "rebasing", &state.rebasing,
 			N_("(internal use for git-rebase)")),
 		OPT_END()
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 2aaaa0d7ded..e657180c201 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -196,6 +196,13 @@ test_expect_success setup '
 
 	git format-patch -M --stdout lorem^ >rename-add.patch &&
 
+	git checkout -b empty-commit &&
+	git commit -m "empty commit" --allow-empty &&
+
+	git format-patch --stdout empty-commit^ >empty.patch &&
+	git format-patch --stdout --cover-letter empty-commit^ >cover-letter.patch &&
+	git format-patch --always --stdout empty-commit^ >empty-commit.patch &&
+
 	# reset time
 	sane_unset test_tick &&
 	test_tick
@@ -1152,4 +1159,70 @@ test_expect_success 'apply binary blob in partial clone' '
 	git -C client am ../patch
 '
 
+test_expect_success 'still output error with --empty-commit when meeting empty files' '
+	test_must_fail git am --empty-commit=skip empty.patch 2>actual &&
+	echo Patch format detection failed. >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'error when meeting e-mail message that lacks a patch by default' '
+	git checkout empty-commit^ &&
+	test_must_fail git am empty-commit.patch >err &&
+	test_path_is_dir .git/rebase-apply &&
+	test_i18ngrep "Patch is empty." err &&
+	rm -fr .git/rebase-apply &&
+
+	test_must_fail git am --empty-commit=die empty-commit.patch >err &&
+	test_path_is_dir .git/rebase-apply &&
+	test_i18ngrep "Patch is empty." err &&
+	rm -fr .git/rebase-apply &&
+
+	test_must_fail git am --empty-commit=die cover-letter.patch >err &&
+	test_path_is_dir .git/rebase-apply &&
+	test_i18ngrep "Patch is empty." err &&
+	rm -fr .git/rebase-apply
+'
+
+test_expect_success 'skip without error when meeting e-mail message that lacks a patch' '
+	git am --empty-commit=skip empty-commit.patch >err &&
+	test_path_is_missing .git/rebase-apply &&
+	git rev-parse empty-commit^ >expected &&
+	git rev-parse HEAD >actual &&
+	test_cmp expected actual &&
+
+	git am --empty-commit=skip cover-letter.patch >err &&
+	test_path_is_missing .git/rebase-apply &&
+	test_cmp_rev empty-commit^ HEAD
+'
+
+test_expect_success 'record as an empty commit when meeting e-mail message that lacks a patch' '
+	git am --empty-commit=asis empty-commit.patch &&
+	test_path_is_missing .git/rebase-apply &&
+	{
+		git show empty-commit --format="%B" &&
+		echo "--" &&
+		git version | sed -e "s/^git version //" &&
+		echo
+	} >expected &&
+	git show HEAD --format="%B" >actual &&
+	test_cmp actual expected &&
+
+	git am --empty-commit=asis cover-letter.patch &&
+	test_path_is_missing .git/rebase-apply &&
+	{
+		echo "*** SUBJECT HERE ***" &&
+		echo &&
+		echo "*** BLURB HERE ***" &&
+		echo &&
+		echo "A U Thor (1):" &&
+		printf "  " &&
+		git show empty-commit --format="%B" &&
+		echo "--" &&
+		git version | sed -e "s/^git version //" &&
+		echo
+	} >expected &&
+	git show HEAD --format="%B" >actual &&
+	test_cmp actual expected
+'
+
 test_done
-- 
gitgitgadget

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487E0C433EF
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 06:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbhKVGuH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 01:50:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbhKVGuD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 01:50:03 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3ACC061574
        for <git@vger.kernel.org>; Sun, 21 Nov 2021 22:46:56 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id g191-20020a1c9dc8000000b0032fbf912885so12672308wme.4
        for <git@vger.kernel.org>; Sun, 21 Nov 2021 22:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=ByUKLPkkauS/7/+68kyrRGmIjZdFLj9T0MaScBktirQ=;
        b=Y+ylNdgpDisOPk8VSiVsBB5OFViphLx5WM23WZrDAcnlurKkGO8/0LYoDi/qLM6Awz
         DnxReyyZUFdbJEzF2kOVuRYG+EXDwfd0vEgBXss+oRcksad4fh7TR/wDwP88MZNxSlm7
         c/zj4y2Gu+dMksj1GeNx4Cp68ZOQ3ZC/IgPPqu0RukT/ednkjbrOQ289SEomYrGRkuvP
         unSRsj5Rv2yxHR+VsKm6ng8uTETEWsAcbET6+9RabRTcXaA7GMIdUe4qZqNLqgyTvTfg
         XJ5qYfw25aj0TJgG2lU37CYtBP7KxxZKL6ru047ikSEHh7cFcl9C7p52RytumaM4A8KF
         NZ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=ByUKLPkkauS/7/+68kyrRGmIjZdFLj9T0MaScBktirQ=;
        b=jlum/X/nFifRAFXxjiwSGHUcsLUDVQ+RimIdO1k20hKal41Qq1shCBTl3wzLcO/69y
         YkL6zO1E+rv1vyfwNj3YIdk7IKSz3x/GRvgzD928cuiNNhX42Rdj+Is33DOn4RpMi2J2
         UIDhUY9fG6wRVjzrF8pr66lGqfb2wrs/aunqU6lz+tiHDMUeD4wRTfb1lS7ZaYqV2ukp
         qxupZ4+EBRkGhYWx3oBRmBjCvYAEjkXKP4cRu76pOsu/JjjpB3ehj5t87L0Fn5ojdpQ/
         He8x9l24arVqLy0yHOw28Io2gYIL0/skAW7YrDlltpwbeqXeg2vctkyrLGqP8Six7tWu
         tbIA==
X-Gm-Message-State: AOAM533lL1o/DMr71jST6SKBSE1U7K7fVhRRD1OX5HPLgw/mQuqUMT8p
        GxnXbQfpTV/NbMo9idc2rJ0lWvBkgZM=
X-Google-Smtp-Source: ABdhPJz9GGfQbgYn8HvDP0JruDLooBYIWux9ripeEPyqY2nl33dIBJ/bbdlKqPQMvNsk+LfCgMCWtw==
X-Received: by 2002:a05:600c:2f10:: with SMTP id r16mr26940989wmn.141.1637563614554;
        Sun, 21 Nov 2021 22:46:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e12sm9386200wrq.20.2021.11.21.22.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Nov 2021 22:46:54 -0800 (PST)
Message-Id: <3ff18e16a7a24fdd8c57b40960e0d6b95c2490e6.1637563611.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v8.git.1637563611.gitgitgadget@gmail.com>
References: <pull.1076.v7.git.1637298298.gitgitgadget@gmail.com>
        <pull.1076.v8.git.1637563611.gitgitgadget@gmail.com>
From:   "Aleen via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 22 Nov 2021 06:46:51 +0000
Subject: [PATCH v8 2/2] am: support --empty=<option> to handle empty patches
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Aleen =?UTF-8?Q?=E5=BE=90=E6=B2=9B=E6=96=87?= <pwxu@coremail.cn>,
        Aleen <aleen42@vip.qq.com>, Aleen <aleen42@vip.qq.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Aleen <aleen42@vip.qq.com>

Since that the command 'git-format-patch' can include patches of
commits that emit no changes, the 'git-am' command should also
support an option, named as '--empty', to specify how to handle
those empty patches. In this commit, we have implemented three
valid options ('die', 'drop' and 'keep').

Signed-off-by: Aleen 徐沛文 <aleen42@vip.qq.com>
---
 Documentation/git-am.txt |  8 ++++++
 builtin/am.c             | 55 ++++++++++++++++++++++++++++++++++++----
 t/t4150-am.sh            | 49 +++++++++++++++++++++++++++++++++++
 3 files changed, 107 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 0a4a984dfde..ba17063f621 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -16,6 +16,7 @@ SYNOPSIS
 	 [--exclude=<path>] [--include=<path>] [--reject] [-q | --quiet]
 	 [--[no-]scissors] [-S[<keyid>]] [--patch-format=<format>]
 	 [--quoted-cr=<action>]
+	 [--empty=(die|drop|keep)]
 	 [(<mbox> | <Maildir>)...]
 'git am' (--continue | --skip | --abort | --quit | --show-current-patch[=(diff|raw)])
 
@@ -63,6 +64,13 @@ OPTIONS
 --quoted-cr=<action>::
 	This flag will be passed down to 'git mailinfo' (see linkgit:git-mailinfo[1]).
 
+--empty=(die|drop|keep)::
+	By default, or when the option is set to 'die', the command
+	errors out on an input e-mail message that lacks a patch. When
+	this option is set to 'drop', skip such an e-mail message instead.
+	When this option is set to 'keep', create an empty commit,
+	recording the contents of the e-mail message as its log.
+
 -m::
 --message-id::
 	Pass the `-m` flag to 'git mailinfo' (see linkgit:git-mailinfo[1]),
diff --git a/builtin/am.c b/builtin/am.c
index 8677ea2348a..cc6512275aa 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -87,6 +87,12 @@ enum show_patch_type {
 	SHOW_PATCH_DIFF = 1,
 };
 
+enum empty_action {
+	DIE_EMPTY_COMMIT = 0,  /* output errors */
+	DROP_EMPTY_COMMIT,     /* skip with a notice message, unless "--quiet" has been passed */
+	KEEP_EMPTY_COMMIT      /* keep recording as empty commits */
+};
+
 struct am_state {
 	/* state directory path */
 	char *dir;
@@ -118,6 +124,7 @@ struct am_state {
 	int message_id;
 	int scissors; /* enum scissors_type */
 	int quoted_cr; /* enum quoted_cr_action */
+	int empty_type; /* enum empty_action */
 	struct strvec git_apply_opts;
 	const char *resolvemsg;
 	int committer_date_is_author_date;
@@ -178,6 +185,25 @@ static int am_option_parse_quoted_cr(const struct option *opt,
 	return 0;
 }
 
+static int am_option_parse_empty(const struct option *opt,
+				     const char *arg, int unset)
+{
+	int *opt_value = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+
+	if (!strcmp(arg, "die"))
+		*opt_value = DIE_EMPTY_COMMIT;
+	else if (!strcmp(arg, "drop"))
+		*opt_value = DROP_EMPTY_COMMIT;
+	else if (!strcmp(arg, "keep"))
+		*opt_value = KEEP_EMPTY_COMMIT;
+	else
+		return error(_("Invalid value for --empty: %s"), arg);
+
+	return 0;
+}
+
 /**
  * Returns path relative to the am_state directory.
  */
@@ -1248,11 +1274,6 @@ static int parse_mail(struct am_state *state, const char *mail)
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
@@ -1763,6 +1784,7 @@ static void am_run(struct am_state *state, int resume)
 	while (state->cur <= state->last) {
 		const char *mail = am_path(state, msgnum(state));
 		int apply_status;
+		int to_keep;
 
 		reset_ident_date();
 
@@ -1792,8 +1814,27 @@ static void am_run(struct am_state *state, int resume)
 		if (state->interactive && do_interactive(state))
 			goto next;
 
+		to_keep = 0;
+		if (is_empty_or_missing_file(am_path(state, "patch"))) {
+			switch (state->empty_type) {
+			case DROP_EMPTY_COMMIT:
+				say(state, stdout, _("Skipping: %.*s"), linelen(state->msg), state->msg);
+				goto next;
+				break;
+			case KEEP_EMPTY_COMMIT:
+				to_keep = 1;
+				break;
+			case DIE_EMPTY_COMMIT:
+				printf_ln(_("Patch is empty."));
+				die_user_resolve(state);
+				break;
+			}
+		}
+
 		if (run_applypatch_msg_hook(state))
 			exit(1);
+		if (to_keep)
+			goto commit;
 
 		say(state, stdout, _("Applying: %.*s"), linelen(state->msg), state->msg);
 
@@ -1827,6 +1868,7 @@ static void am_run(struct am_state *state, int resume)
 			die_user_resolve(state);
 		}
 
+commit:
 		do_commit(state);
 
 next:
@@ -2357,6 +2399,9 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		{ OPTION_STRING, 'S', "gpg-sign", &state.sign_commit, N_("key-id"),
 		  N_("GPG-sign commits"),
 		  PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
+		OPT_CALLBACK_F(0, "empty", &state.empty_type, "{drop,keep,die}",
+		  N_("how to handle empty patches"),
+		  PARSE_OPT_NONEG, am_option_parse_empty),
 		OPT_HIDDEN_BOOL(0, "rebasing", &state.rebasing,
 			N_("(internal use for git-rebase)")),
 		OPT_END()
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 2aaaa0d7ded..8c8bd4db220 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -196,6 +196,12 @@ test_expect_success setup '
 
 	git format-patch -M --stdout lorem^ >rename-add.patch &&
 
+	git checkout -b empty-commit &&
+	git commit -m "empty commit" --allow-empty &&
+
+	: >empty.patch &&
+	git format-patch --always --stdout empty-commit^ >empty-commit.patch &&
+
 	# reset time
 	sane_unset test_tick &&
 	test_tick
@@ -1152,4 +1158,47 @@ test_expect_success 'apply binary blob in partial clone' '
 	git -C client am ../patch
 '
 
+test_expect_success 'an empty input file is error regardless of --empty option' '
+	test_when_finished "git am --abort || :" &&
+	test_must_fail git am --empty=drop empty.patch 2>actual &&
+	echo "Patch format detection failed." >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'invalid when passing the --empty option alone' '
+	test_when_finished "git am --abort || :" &&
+	git checkout empty-commit^ &&
+	test_must_fail git am --empty empty-commit.patch 2>err &&
+	echo "error: Invalid value for --empty: empty-commit.patch" >expected &&
+	test_cmp expected err
+'
+
+test_expect_success 'a message without a patch is an error (default)' '
+	test_when_finished "git am --abort || :" &&
+	test_must_fail git am empty-commit.patch >err &&
+	grep "Patch is empty" err
+'
+
+test_expect_success 'a message without a patch is an error where an explicit "--empty=die" is given' '
+	test_when_finished "git am --abort || :" &&
+	test_must_fail git am --empty=die empty-commit.patch >err &&
+	grep "Patch is empty." err
+'
+
+test_expect_success 'a message without a patch will be skipped when "--empty=drop" is given' '
+	git am --empty=drop empty-commit.patch >output &&
+	git rev-parse empty-commit^ >expected &&
+	git rev-parse HEAD >actual &&
+	test_cmp expected actual &&
+	grep "Skipping: empty commit" output
+'
+
+test_expect_success 'record as an empty commit when meeting e-mail message that lacks a patch' '
+	git am --empty=keep empty-commit.patch &&
+	test_path_is_missing .git/rebase-apply &&
+	git show empty-commit --format="%s" >expected &&
+	git show HEAD --format="%s" >actual &&
+	test_cmp actual expected
+'
+
 test_done
-- 
gitgitgadget

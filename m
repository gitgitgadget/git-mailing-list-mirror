Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9584C433F5
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 06:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 855F560FE3
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 06:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbhKLG5E (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 01:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232791AbhKLG44 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 01:56:56 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBBAC0613F5
        for <git@vger.kernel.org>; Thu, 11 Nov 2021 22:54:05 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id y84-20020a1c7d57000000b00330cb84834fso9089286wmc.2
        for <git@vger.kernel.org>; Thu, 11 Nov 2021 22:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=foRYNwh7qj6kg7jEHazvILh2AmScyat3xJCorUxOhsY=;
        b=ZJ2nZSFnKWQQUr+VhwxFUt9PJnbNaf3SRHdA6kEoBHHxdwWVUZ7mfPgEvpFiG1pdTu
         +tinHeWtwqmuWswsv9o6FtvE3/EBpkQr7eETzBmVaERidkdJthE1W3KsJumnwDMfmCRm
         zPuBS2P2uBn4THJXqm/pQOpliaNGPgl4BU2eCKh5IPmnXUltKD70y7sgFHXD1YYOzOtd
         t/559crbapw0aNZNNz9M9sqxN8gs4sEyJDafo7z7pYAqKpya5K2/48QwLh/25oEqc3Ah
         EV7HZeTaEauAIv3J260AmP3zsR1CjEI3ZWzEz52Ot5LFtM74eeCgMQX1dQGLBbSonzFJ
         6QGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=foRYNwh7qj6kg7jEHazvILh2AmScyat3xJCorUxOhsY=;
        b=4OPJ5IQMwNg3Tse9OlCRqq2DPE5nbiM8tCwU44CWgjdnjMsG/HljHw4nXv7ZpxPxGE
         LIVjNW8jFb1KWSSH0GGJeMkHvFP7jRgCCtkxo2fKSu2C6hooeZbFnYblwNOeGHbAnulZ
         hMa1FA5jdLiOL+WJqDBs7UrQsLIVsaeRNbemxYRoDNCM1A+Qt1IOhgySr5m6FMEPX9pN
         NnXdwhZYDV/XZW9UkHyuR+RoqqluDGFVaDbh/PUUrDb+n2WbNb8fC5M89aaP179Bz9/l
         9vNA9JZnt2G7+a/XcHwPdksDj52cF0oD/k0eJPPFz5qxdj5rt2HH4prdFZW60pT9jO3e
         wniQ==
X-Gm-Message-State: AOAM532MBpttmX8zouy0c80Sqal/bCxo6JEuI+jRk5z4R1CAvuPQbQba
        2BLJtmXG20ytf9Lz+lXQA7eGvF5/IAs=
X-Google-Smtp-Source: ABdhPJweYeqvRNlmVbOy4oRJl96tQ/pAYx+iqrJs6gj3NqYEtpNs0qPkY2a5XsPrtbsgiBF9WAdv+g==
X-Received: by 2002:a7b:c005:: with SMTP id c5mr14410165wmb.150.1636700044138;
        Thu, 11 Nov 2021 22:54:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s13sm11374482wmc.47.2021.11.11.22.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 22:54:03 -0800 (PST)
Message-Id: <45e9720f40bbf71ceea72ac464e3343f9b47a04f.1636700040.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v2.git.1636700040.gitgitgadget@gmail.com>
References: <pull.1076.git.1636693095.gitgitgadget@gmail.com>
        <pull.1076.v2.git.1636700040.gitgitgadget@gmail.com>
From:   "Aleen via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 12 Nov 2021 06:54:00 +0000
Subject: [PATCH v2 4/4] chore: am: rename the --always option to --allow-empty
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Aleen <aleen42@vip.qq.com>, Aleen <aleen42@vip.qq.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Aleen <aleen42@vip.qq.com>

Signed-off-by: Aleen <aleen42@vip.qq.com>
---
 Documentation/git-am.txt |  4 ++--
 builtin/am.c             |  8 ++++----
 t/t4150-am.sh            | 10 +++++-----
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index de5d11e404c..6ed844af9c6 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -16,7 +16,7 @@ SYNOPSIS
 	 [--exclude=<path>] [--include=<path>] [--reject] [-q | --quiet]
 	 [--[no-]scissors] [-S[<keyid>]] [--patch-format=<format>]
 	 [--quoted-cr=<action>]
-	 [--always]
+	 [--allow-empty]
 	 [(<mbox> | <Maildir>)...]
 'git am' (--continue | --skip | --abort | --quit | --show-current-patch[=(diff|raw)])
 
@@ -160,7 +160,7 @@ default.   You can use `--no-utf8` to override this.
 	countermand both `commit.gpgSign` configuration variable, and
 	earlier `--gpg-sign`.
 
---always::
+--allow-empty::
 	Apply patches of commits with detailed commit messages,
 	even if they emit no changes. (see linkgit:git-format-patch[1])
 
diff --git a/builtin/am.c b/builtin/am.c
index d11efc16f92..a8661098acf 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -124,7 +124,7 @@ struct am_state {
 	int ignore_date;
 	int allow_rerere_autoupdate;
 	const char *sign_commit;
-	int always;
+	int allow_empty;
 	int empty_commit;
 	int rebasing;
 };
@@ -1251,7 +1251,7 @@ static int parse_mail(struct am_state *state, const char *mail)
 	}
 
 	if (is_empty_or_missing_file(am_path(state, "patch"))) {
-		if (state->always) {
+		if (state->allow_empty) {
 			state->empty_commit = 1;
 		} else {
 			printf_ln(_("Patch is empty."));
@@ -2367,8 +2367,8 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		{ OPTION_STRING, 'S', "gpg-sign", &state.sign_commit, N_("key-id"),
 		  N_("GPG-sign commits"),
 		  PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
-		OPT_BOOL(0, "always", &state.always,
-			N_("always apply patch event if the patch is empty")),
+		OPT_BOOL(0, "allow-empty", &state.allow_empty,
+			N_("allow to apply patches of empty commits")),
 		OPT_HIDDEN_BOOL(0, "empty-commit", &state.empty_commit,
 			N_("(internal use for skipping git-apply to empty commits)")),
 		OPT_HIDDEN_BOOL(0, "rebasing", &state.rebasing,
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 364c61ba198..b47a0fa41e7 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -1158,15 +1158,15 @@ test_expect_success 'apply binary blob in partial clone' '
 	git -C client am ../patch
 '
 
-test_expect_success 'am a real empty patch with the --always option' '
+test_expect_success 'am a real empty patch with the --allow-empty option' '
 	rm -fr .git/rebase-apply &&
 	git reset --hard &&
-	test_must_fail git am --always empty.patch 2>actual &&
+	test_must_fail git am --allow-empty empty.patch 2>actual &&
 	echo Patch format detection failed. >expected &&
 	test_cmp expected actual
 '
 
-test_expect_success 'am a patch of empty commits without the --always option' '
+test_expect_success 'am a patch of empty commits without the --allow-empty option' '
 	grep "empty commit" empty-commit.patch &&
 	rm -fr .git/rebase-apply &&
 	git reset --hard &&
@@ -1176,12 +1176,12 @@ test_expect_success 'am a patch of empty commits without the --always option' '
 	test_i18ngrep "Patch is empty." err
 '
 
-test_expect_success 'am a patch of empty commits with the --always option' '
+test_expect_success 'am a patch of empty commits with the --allow-empty option' '
 	grep "empty commit" empty-commit.patch &&
 	rm -fr .git/rebase-apply &&
 	git reset --hard &&
 	git checkout empty-commit^ &&
-	git am --always empty-commit.patch &&
+	git am --allow-empty empty-commit.patch &&
 	test_path_is_missing .git/rebase-apply &&
 	git cat-file commit HEAD >actual &&
 	test_i18ngrep "empty commit" actual
-- 
gitgitgadget

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14C6C433EF
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 05:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C85C060FBF
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 05:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbhKLFBS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 00:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhKLFBQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 00:01:16 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38157C061766
        for <git@vger.kernel.org>; Thu, 11 Nov 2021 20:58:19 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id d24so13477759wra.0
        for <git@vger.kernel.org>; Thu, 11 Nov 2021 20:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Tlc6JV/TrjB9ixoMdbb5f6Bp7yE84mZMopQIM9ZFbuQ=;
        b=dNv+ZpaRTuenTy3K7ZKuemf4adX5VK61hHMSKglDH5zECLrGbobKC3qsJdBFLXJdnI
         +E6AGkj3AElBivNw+Y9Zymqbz3rCQU3ltDKVaBdQY7yqWY2S+9CZi8s6BHUM/+epImxu
         8AgKEQfnLaQTxaRXA6OUpj5XZYEKeGEjkFcaUDp0vEtrpUpVPnhrZtXWWPh0a9C7vvdr
         4yR1jkG3beS9JPMYyPMdaPj7+yngvgkUNnTqfBFuN6JMn1T7ivo0Y2BKZsg+EPo7HlEO
         rArNSks7oSmr2jDD9VKoh3IppP6zKkGJAmPGwvZNUnbUtxgGy+lxYDjixzuyYDOtTHQp
         vwxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Tlc6JV/TrjB9ixoMdbb5f6Bp7yE84mZMopQIM9ZFbuQ=;
        b=VUa5g4q7/oS4V4iUHcTKAffYz8gfuMr5poKoRw3R4RIjGLqDf4eLrVvRbrKNhnVp/y
         WoRKdW3SCz7fAxohfk1JdY7ptsVYXPDjEA/yKnd527BZNI+O8R8TDg7fH1CTeAVRWxIC
         REaYqP0l4PRBJtBr1KMeC+5IM/pxn6LL05B9NLp8aDV7CaZ6cBg/THwdd45Svo8uzAbv
         UXbhTX2dsRAZPsxxs9qqSBl3RwG5igPRAnVSMh1YYRKssRkLJrUyjWGkpwJWdkI0LdNx
         vI4g+eZTP6f7YGEARqGZLtDMvKgoCLPc9QMTD2QRloxXQFsusgbFrkiRuDskDG6dNIVC
         caGw==
X-Gm-Message-State: AOAM530aDNEZyh9CQwHqcasDAAFUCZzssxoR1EjjMF9nGV41sHshsbMy
        KOIDQeRjug1Rdnb7SdsylSj00OED5j0=
X-Google-Smtp-Source: ABdhPJxMOxVUyP9UmvIkXf2O3jrN5d8MKKS+DLz4niSnGLKD5LrJ0D5TOo3Xp+dKKuQ5tRGPk+XnJQ==
X-Received: by 2002:a5d:6da9:: with SMTP id u9mr16098998wrs.237.1636693097669;
        Thu, 11 Nov 2021 20:58:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o12sm6450987wrc.85.2021.11.11.20.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 20:58:17 -0800 (PST)
Message-Id: <59b1417da3754add11e72692ec11c09e486269e4.1636693095.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.git.1636693095.gitgitgadget@gmail.com>
References: <pull.1076.git.1636693095.gitgitgadget@gmail.com>
From:   "Aleen via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 12 Nov 2021 04:58:15 +0000
Subject: [PATCH 2/2] am: support --always option to am empty commits
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Aleen <aleen42@vip.qq.com>, Aleen <aleen42@vip.qq.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Aleen <aleen42@vip.qq.com>

Signed-off-by: Aleen <aleen42@vip.qq.com>
---
 Documentation/git-am.txt |  5 +++++
 builtin/am.c             | 18 ++++++++++++++++--
 t/t4150-am.sh            | 25 +++++++++++++++++++++++++
 3 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 0a4a984dfde..de5d11e404c 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -16,6 +16,7 @@ SYNOPSIS
 	 [--exclude=<path>] [--include=<path>] [--reject] [-q | --quiet]
 	 [--[no-]scissors] [-S[<keyid>]] [--patch-format=<format>]
 	 [--quoted-cr=<action>]
+	 [--always]
 	 [(<mbox> | <Maildir>)...]
 'git am' (--continue | --skip | --abort | --quit | --show-current-patch[=(diff|raw)])
 
@@ -159,6 +160,10 @@ default.   You can use `--no-utf8` to override this.
 	countermand both `commit.gpgSign` configuration variable, and
 	earlier `--gpg-sign`.
 
+--always::
+	Apply patches of commits with detailed commit messages,
+	even if they emit no changes. (see linkgit:git-format-patch[1])
+
 --continue::
 -r::
 --resolved::
diff --git a/builtin/am.c b/builtin/am.c
index 8677ea2348a..d11efc16f92 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -124,6 +124,8 @@ struct am_state {
 	int ignore_date;
 	int allow_rerere_autoupdate;
 	const char *sign_commit;
+	int always;
+	int empty_commit;
 	int rebasing;
 };
 
@@ -1249,8 +1251,12 @@ static int parse_mail(struct am_state *state, const char *mail)
 	}
 
 	if (is_empty_or_missing_file(am_path(state, "patch"))) {
-		printf_ln(_("Patch is empty."));
-		die_user_resolve(state);
+		if (state->always) {
+			state->empty_commit = 1;
+		} else {
+			printf_ln(_("Patch is empty."));
+			die_user_resolve(state);
+		}
 	}
 
 	strbuf_addstr(&msg, "\n\n");
@@ -1792,6 +1798,9 @@ static void am_run(struct am_state *state, int resume)
 		if (state->interactive && do_interactive(state))
 			goto next;
 
+		if (state->empty_commit)
+			goto commit;
+
 		if (run_applypatch_msg_hook(state))
 			exit(1);
 
@@ -1827,6 +1836,7 @@ static void am_run(struct am_state *state, int resume)
 			die_user_resolve(state);
 		}
 
+commit:
 		do_commit(state);
 
 next:
@@ -2357,6 +2367,10 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		{ OPTION_STRING, 'S', "gpg-sign", &state.sign_commit, N_("key-id"),
 		  N_("GPG-sign commits"),
 		  PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
+		OPT_BOOL(0, "always", &state.always,
+			N_("always apply patch event if the patch is empty")),
+		OPT_HIDDEN_BOOL(0, "empty-commit", &state.empty_commit,
+			N_("(internal use for skipping git-apply to empty commits)")),
 		OPT_HIDDEN_BOOL(0, "rebasing", &state.rebasing,
 			N_("(internal use for git-rebase)")),
 		OPT_END()
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 2aaaa0d7ded..5b3617857a8 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -196,6 +196,12 @@ test_expect_success setup '
 
 	git format-patch -M --stdout lorem^ >rename-add.patch &&
 
+	git checkout -b empty-commit &&
+	git commit -m "empty commit" --allow-empty &&
+
+	git format-patch --stdout empty-commit^ >empty.patch &&
+	git format-patch --always --stdout empty-commit^ >empty-commit.patch &&
+
 	# reset time
 	sane_unset test_tick &&
 	test_tick
@@ -1152,4 +1158,23 @@ test_expect_success 'apply binary blob in partial clone' '
 	git -C client am ../patch
 '
 
+test_expect_success 'am a real empty patch with the --always option' '
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
+	test_must_fail git am --always empty.patch 2>actual &&
+	echo Patch format detection failed. >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'am a patch with empty commits' '
+	grep "empty commit" empty-commit.patch &&
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
+	git checkout empty-commit^ &&
+	git am --always empty-commit.patch &&
+	test_path_is_missing .git/rebase-apply &&
+	git cat-file commit HEAD >actual &&
+	test_i18ngrep "empty commit" actual
+'
+
 test_done
-- 
gitgitgadget

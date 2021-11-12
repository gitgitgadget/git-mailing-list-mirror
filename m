Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC58DC433EF
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 06:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B97C660FE3
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 06:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbhKLG5A (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 01:57:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232688AbhKLG4y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 01:56:54 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D72C061766
        for <git@vger.kernel.org>; Thu, 11 Nov 2021 22:54:04 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id d3so13797959wrh.8
        for <git@vger.kernel.org>; Thu, 11 Nov 2021 22:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Tlc6JV/TrjB9ixoMdbb5f6Bp7yE84mZMopQIM9ZFbuQ=;
        b=PgjFVFaMpvFZrRfgHT0yVnOWq2c2kZ94eEiItDqfgC9PVND0jukZkUdlIi7lN9XrTB
         hAVRYDZfUOcXxMENUaZvgdR3SmfYr74Zka3u61zbi1yXTu1c3HGHgPrg3pq/ExWFlZzz
         vFZuKz4gYHFZxYKF/GJIAMTNBCmabkzKCWo4ihE5t6s3eeEdk5/3eNUKBYcHjfETrLG6
         p4UmlOQY7W2j1xXVVJyzRhb/hnm3rA7D5DwySVGbj4yIBAVG9l0aeCNIC9MyAeXrqqO0
         zQEvMr+gKH6JqQ3dEKipxwGUEXBk6iGDAzj1kgeGQlbD2yYLyYvHjb4PMXyCA1I0VBwq
         UtuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Tlc6JV/TrjB9ixoMdbb5f6Bp7yE84mZMopQIM9ZFbuQ=;
        b=t1LPJSXFgosteaqVpSfI48BF5qxz99tSqOr+/T1OVbErppJKb+e9ybjFSHm5QZXdEZ
         0edD959ImEbSmPMCTxo4EP7J9uue+GvPQU5pgPDmeHlVZKpjmvbbSK+EJaZVFttMNfo4
         VitzD/RjOLKxA/MsTPVH4yBobzaUi5UYOkaTH6XKlcWNhmCV+fWitoydEBoay/9gvLyC
         YjxYJuBs27X3OZLlDF0vlIVA0oUwiGN1bw7MAr0YE6Wvf6ekemECcglV8kN6n3HboXoE
         wU9Gjl1a/nghyV2kyoIfetx6YR4vHxhXsT6VIdmymMg1ZvcTOryIz8U91dOzAJ5OFJDl
         8EnQ==
X-Gm-Message-State: AOAM532ZOE3rHF7uHqdbQIYnLX3eqG8EO4qaZRa3t9XckqVt/VYWRAcZ
        ZUFU4dnQKOJ1EGPapIFj40UbiipNLNI=
X-Google-Smtp-Source: ABdhPJwJ/Efgj/hhlfOtZcdhuRClk4A5CgeKGflYuCtb86V/ZcDv9QYnKyHa7mo3WrE2uiy3YjbOTw==
X-Received: by 2002:adf:eb81:: with SMTP id t1mr15976271wrn.133.1636700042718;
        Thu, 11 Nov 2021 22:54:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n1sm5363350wmq.6.2021.11.11.22.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 22:54:02 -0800 (PST)
Message-Id: <59b1417da3754add11e72692ec11c09e486269e4.1636700040.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v2.git.1636700040.gitgitgadget@gmail.com>
References: <pull.1076.git.1636693095.gitgitgadget@gmail.com>
        <pull.1076.v2.git.1636700040.gitgitgadget@gmail.com>
From:   "Aleen via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 12 Nov 2021 06:53:58 +0000
Subject: [PATCH v2 2/4] am: support --always option to am empty commits
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


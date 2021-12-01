Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C726C433EF
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 06:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346998AbhLAGo2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 01:44:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346979AbhLAGoX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 01:44:23 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF742C061574
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 22:41:02 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id a9so49800508wrr.8
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 22:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gId0stq+Cs9UbYpavsCOFDRFtmCr3l+d/uzb8OQw93g=;
        b=YWO6tZ9EtfMIhRCNQn26TMsIb+fzk7y0IjoWiCDasb24UaVYvaAqKerJfGWcT53fGe
         66UId/PUgwOjvTygZu3xe/4xDB6QVXLrlI+bN7vWba6cyQTi/HHH06Dsye0kGAt0V8bz
         ini7HHd06UeMGxBt2azcZBWa9IOioU3YGCRU74LmEDtLsGyD0XKkIZdVCtm+hkThHMJ8
         TFbPZg7Mf4ftLTj9h5u3HqW2tZH9coPMkQEVKu5ATXi7c85ZazbJEQHDg+HhacF7CBuY
         hRtK29BOgOe0tAZesvkDuJZk+S8J5TVDeHjVjRMUGQTdvbeqTWGVq8DbhvZhmfUDxBhC
         ZaZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gId0stq+Cs9UbYpavsCOFDRFtmCr3l+d/uzb8OQw93g=;
        b=F3VIoVKPDq6aPa79Ttt/mO2+psj6+D1F96bx3vPX4yRsNzSvz4mg/nNYDn3jDUnfOC
         oj1CCYtGRlvna60LPK7P/cwjfWiNyDn0mRoiz/1mOT1czJSoj5DP8JnKLV5CbRMADURg
         6wTl3WSzvn+kiTawtQa6QfooxTpnTs3nafDdqbK1BLNDvfGiZ8yfVk3ZEqvNQVVpzXef
         Ax632Xvd5q0U/sAOgtBGdxKvCSCnmePpBzy7ixm6Dx4JcK8qN9cnWMcbKpCmxZYcumBM
         0Jj93LnMiXWbJhkTN1LS9dQKGeRxx2VB+N59azK6e1/ZlOZYapQnbMa5RWz6ck6q6oIC
         7MeA==
X-Gm-Message-State: AOAM5316aapkRYl3X89pHdX1YHpf7hJgGuSw1r9CbJsrBJdvH9Qb/GBC
        l43V0lOdI+ZzLYvgsLMz78FuEHzWBhw=
X-Google-Smtp-Source: ABdhPJwZlKZAeyMz7Gtd0hVyDiTU2AtPyI1TlkDqTCfnW1R7QxjxSsU/6HtPnLycJut6aRdAQCCPYQ==
X-Received: by 2002:a5d:4e0f:: with SMTP id p15mr4567600wrt.48.1638340861162;
        Tue, 30 Nov 2021 22:41:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e18sm18616993wrs.48.2021.11.30.22.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 22:41:00 -0800 (PST)
Message-Id: <54d059c683ef3639db1acac51e26c9328c9684c5.1638340854.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1140.v5.git.git.1638340854.gitgitgadget@gmail.com>
References: <pull.1140.v4.git.git.1638225434.gitgitgadget@gmail.com>
        <pull.1140.v5.git.git.1638340854.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Dec 2021 06:40:49 +0000
Subject: [PATCH v5 06/11] clean: do not attempt to remove
 startup_info->original_cwd
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Philip Oakley <philipoakley@iee.email>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/clean.c      | 44 +++++++++++++++++++++++++++++++++++---------
 t/t2501-cwd-empty.sh |  5 +++--
 2 files changed, 38 insertions(+), 11 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 98a2860409b..3ff02bbbffe 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -36,6 +36,8 @@ static const char *msg_skip_git_dir = N_("Skipping repository %s\n");
 static const char *msg_would_skip_git_dir = N_("Would skip repository %s\n");
 static const char *msg_warn_remove_failed = N_("failed to remove %s");
 static const char *msg_warn_lstat_failed = N_("could not lstat %s\n");
+static const char *msg_skip_cwd = N_("Refusing to remove current working directory\n");
+static const char *msg_would_skip_cwd = N_("Would refuse to remove current working directory\n");
 
 enum color_clean {
 	CLEAN_COLOR_RESET = 0,
@@ -153,6 +155,8 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
 {
 	DIR *dir;
 	struct strbuf quoted = STRBUF_INIT;
+	struct strbuf realpath = STRBUF_INIT;
+	struct strbuf real_ocwd = STRBUF_INIT;
 	struct dirent *e;
 	int res = 0, ret = 0, gone = 1, original_len = path->len, len;
 	struct string_list dels = STRING_LIST_INIT_DUP;
@@ -231,16 +235,36 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
 	strbuf_setlen(path, original_len);
 
 	if (*dir_gone) {
-		res = dry_run ? 0 : rmdir(path->buf);
-		if (!res)
-			*dir_gone = 1;
-		else {
-			int saved_errno = errno;
-			quote_path(path->buf, prefix, &quoted, 0);
-			errno = saved_errno;
-			warning_errno(_(msg_warn_remove_failed), quoted.buf);
+		/*
+		 * Normalize path components in path->buf, e.g. change '\' to
+		 * '/' on Windows.
+		 */
+		strbuf_realpath(&realpath, path->buf, 1);
+
+		/*
+		 * path and realpath are absolute; for comparison, we would
+		 * like to transform startup_info->original_cwd to an absolute
+		 * path too.
+		 */
+		 if (startup_info->original_cwd)
+			 strbuf_realpath(&real_ocwd,
+					 startup_info->original_cwd, 1);
+
+		if (!strbuf_cmp(&realpath, &real_ocwd)) {
+			printf("%s", dry_run ? _(msg_would_skip_cwd) : _(msg_skip_cwd));
 			*dir_gone = 0;
-			ret = 1;
+		} else {
+			res = dry_run ? 0 : rmdir(path->buf);
+			if (!res)
+				*dir_gone = 1;
+			else {
+				int saved_errno = errno;
+				quote_path(path->buf, prefix, &quoted, 0);
+				errno = saved_errno;
+				warning_errno(_(msg_warn_remove_failed), quoted.buf);
+				*dir_gone = 0;
+				ret = 1;
+			}
 		}
 	}
 
@@ -250,6 +274,8 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
 			printf(dry_run ?  _(msg_would_remove) : _(msg_remove), dels.items[i].string);
 	}
 out:
+	strbuf_release(&realpath);
+	strbuf_release(&real_ocwd);
 	strbuf_release(&quoted);
 	string_list_clear(&dels, 0);
 	return ret;
diff --git a/t/t2501-cwd-empty.sh b/t/t2501-cwd-empty.sh
index e4502d24d57..b1182390ba3 100755
--- a/t/t2501-cwd-empty.sh
+++ b/t/t2501-cwd-empty.sh
@@ -230,8 +230,9 @@ test_incidental_untracked_dir_removal () {
 }
 
 test_expect_success 'clean does not remove cwd incidentally' '
-	test_incidental_untracked_dir_removal failure \
-		git -C .. clean -fd -e warnings . >warnings
+	test_incidental_untracked_dir_removal success \
+		git -C .. clean -fd -e warnings . >warnings &&
+	grep "Refusing to remove current working directory" warnings
 '
 
 test_expect_success 'stash does not remove cwd incidentally' '
-- 
gitgitgadget


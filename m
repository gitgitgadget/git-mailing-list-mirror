Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CADC43219
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 13:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9DCB61503
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 13:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234993AbhJENW6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Oct 2021 09:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234958AbhJENWw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Oct 2021 09:22:52 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECEEC061762
        for <git@vger.kernel.org>; Tue,  5 Oct 2021 06:21:00 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id m42so5834190wms.2
        for <git@vger.kernel.org>; Tue, 05 Oct 2021 06:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0diNHvAg+DnAH3GtSgMzhFnRO7Oz642uheHT03o4VjU=;
        b=I+/3diw1YA+sRfq8YCL47ZnMvd2YghiL+GYCZtZi4fsD0DBjMBLulQsBtSDP/a2jia
         KoQ0ikn+U6zNTYh1TH5QEEGoYKC2vXBooIG7bxO6Y4HMiNDZKyuQiuDugsCE5wzSUSsp
         QDGztkIicLt+5QTKq7nNhCDntyXVQgDLBYtWSVtTaX/U7hIU8o3lyjoe5PyqppLnrdfl
         CvL9hlHvtFQPvR6XdJ/R9fSgxroYA+N4ZDbGBXl8TlEzcFZaRTbxNV74o14N1k0q9J4O
         5GQvxQZRlSN8S7EO0Myo7GsH7x1Yeoyrggj0rK35yGoff7dqx2rkdCNDkLLfqLSlRKLJ
         4mTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0diNHvAg+DnAH3GtSgMzhFnRO7Oz642uheHT03o4VjU=;
        b=AAoOJPfF/RwhFrNktpyb4YhI8DoluMvHmHAS/srwmWcDNEPqaBQri2vExxQ6L1o9ZT
         vtP8gIdOZ9by/aTQCCwCnguO8Vr+/bPU1Nc9UjyUHMo0ePlnCeS3HEEkqtlpJVADhV4I
         E1TLwJPKrwvdRAVLj54Cg2gktTP+IIT3Oe5ZnWGK3ZJW2e+BkYIN/jZwLifUf5GXp2Gc
         aVMWUlyN+TgPZ6PDmKWOfllCfzHePcjk3Jqv3yL8C9WnuuJt2/ufrehDIpUU0FcgeKH8
         WjnYmgM95A8fiyKZq41mKyQJceWOAO/PzlNdiP/hzU0cjfubAoS2aMAT4RqyLbt3U0Pp
         TAYg==
X-Gm-Message-State: AOAM531eQifq2KI4erA8lOGGvr3PxuFefmb7ZK/GIX3BURWS/26BK5ju
        4MJbMH9tGjLRturM71HnzvmGtjEQlNI=
X-Google-Smtp-Source: ABdhPJzag+yZzFz32hFnvRWN/2yqSdxUc+Eyb3wsPlLl3UOUtBLRKUT+d+EzXkqjNGNWMBE0HpAkDw==
X-Received: by 2002:a7b:cd8f:: with SMTP id y15mr3459617wmj.135.1633440059421;
        Tue, 05 Oct 2021 06:20:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y13sm17680003wrm.48.2021.10.05.06.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 06:20:59 -0700 (PDT)
Message-Id: <f7cb9013d46731855c3ed42add62b021c0ad0c73.1633440057.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1048.v2.git.1633440057.gitgitgadget@gmail.com>
References: <pull.1048.git.1633013461.gitgitgadget@gmail.com>
        <pull.1048.v2.git.1633440057.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 05 Oct 2021 13:20:52 +0000
Subject: [PATCH v2 2/7] update-index: add --force-full-index option for
 expand/collapse test
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Add a new `--force-full-index` option to `git update-index`, which skips
explicitly setting `command_requires_full_index`. This lets `git
update-index --force-full-index` run as a command without sparse index
compatibility implemented, even after it receives sparse index compatibility
updates.

By using `git update-index --force-full-index` in the `t1092` test
`sparse-index is expanded and converted back`, commands can continue to
integrate with the sparse index without the need to keep modifying the
command used in the test.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 Documentation/git-update-index.txt       |  5 +++++
 builtin/update-index.c                   | 11 +++++++++++
 t/t1092-sparse-checkout-compatibility.sh |  2 +-
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 2853f168d97..06255e321a3 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -24,6 +24,7 @@ SYNOPSIS
 	     [--[no-]fsmonitor]
 	     [--really-refresh] [--unresolve] [--again | -g]
 	     [--info-only] [--index-info]
+	     [--force-full-index]
 	     [-z] [--stdin] [--index-version <n>]
 	     [--verbose]
 	     [--] [<file>...]
@@ -170,6 +171,10 @@ time. Version 4 is relatively young (first released in 1.8.0 in
 October 2012). Other Git implementations such as JGit and libgit2
 may not support it yet.
 
+--force-full-index::
+	Force the command to operate on a full index, expanding a sparse
+	index if necessary.
+
 -z::
 	Only meaningful with `--stdin` or `--index-info`; paths are
 	separated with NUL character instead of LF.
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 187203e8bb5..32ada3ead77 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -964,6 +964,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 	int split_index = -1;
 	int force_write = 0;
 	int fsmonitor = -1;
+	int use_default_full_index = 0;
 	struct lock_file lock_file = LOCK_INIT;
 	struct parse_opt_ctx_t ctx;
 	strbuf_getline_fn getline_fn;
@@ -1069,6 +1070,8 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		{OPTION_SET_INT, 0, "no-fsmonitor-valid", &mark_fsmonitor_only, NULL,
 			N_("clear fsmonitor valid bit"),
 			PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, UNMARK_FLAG},
+		OPT_SET_INT(0, "force-full-index", &use_default_full_index,
+			N_("run with full index explicitly required"), 1),
 		OPT_END()
 	};
 
@@ -1082,6 +1085,14 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 	if (newfd < 0)
 		lock_error = errno;
 
+	/*
+	 * If --force-full-index is set, the command should skip manually
+	 * setting `command_requires_full_index`.
+	 */
+	prepare_repo_settings(r);
+	if (!use_default_full_index)
+		r->settings.command_requires_full_index = 1;
+
 	entries = read_cache();
 	if (entries < 0)
 		die("cache corrupted");
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index c5977152661..b3c0d3b98ee 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -642,7 +642,7 @@ test_expect_success 'sparse-index is expanded and converted back' '
 	init_repos &&
 
 	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
-		git -C sparse-index -c core.fsmonitor="" reset --hard &&
+		git -C sparse-index -c core.fsmonitor="" update-index --force-full-index &&
 	test_region index convert_to_sparse trace2.txt &&
 	test_region index ensure_full_index trace2.txt
 '
-- 
gitgitgadget


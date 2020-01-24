Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC744C35242
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 21:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B28342072C
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 21:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5XnnbsP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbgAXVTv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 16:19:51 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37796 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgAXVTt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 16:19:49 -0500
Received: by mail-wm1-f67.google.com with SMTP id f129so831811wmf.2
        for <git@vger.kernel.org>; Fri, 24 Jan 2020 13:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pp+putYic/YPhOPXhgtuPLfFxxGHo2lzSEwyNyMGA0M=;
        b=k5XnnbsPkaEYUFSfIBqzdNsGfw49h8gWYoc+wHRmaGLe6TS3Zq+qGP9j+FVsKFARoR
         v+nLBVLVLa2V2NOHTviDmj7mD1rK1UogG8ypj82LVY9QGzPNPyRVH/Btkg42ny0t8ItB
         zrpBH9oUw6srYfKAD5bRIEAA7Haw7UXSzs7RiX7HJMa537SjUIbqWUcoC0H5LqIaxXmx
         gfeTz6jvHpI4be7b8c2LU7U/Tz91WJfn4BbT/oLuDwIIkLl+D7PR9IVca2DOMI3VxsmE
         pnjrfE3PyxsvkwlUoM4sDHNSlebl5ZzTYQBQ/5f4/AzC6Sl3jZIYhtZSJ6GW3GrxlDhi
         UjWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pp+putYic/YPhOPXhgtuPLfFxxGHo2lzSEwyNyMGA0M=;
        b=eq9gkMsS0fXI8A7OVVpJMT8mmp7x3tWDbMafftc3mrzybtKlRloEUmj3i/0MBiCl9Y
         ZXeW2ZUqpAcBfxCCacyNQym2rb0WpjrP+aZT/vwNX9SHPskYIt+tZJ+zmEvIMrgDKqjE
         bvYUpFeUmHfUIDLKBAr6QbAAIRtCVoGHlhxryyX9L6Kb5R+3JeNJNcNRd3c4EbJWoT/B
         4syf8yaR++PkLCDlDoHEQ05HOm7s3J3ydlQGBSupMHUk0aDzigQuQqUqLENroyxvuEho
         yNDAdCGqnmdzKE1iY6w9EIdB5Kh6ipVtMCJYf7ff7QO2907UQz8A/UuQq5sroLFxQgjG
         nuNQ==
X-Gm-Message-State: APjAAAWhiCA2TjLwtp2t+5XoxsMtyoSPySVRh4U76Kmdu6pA7meDPSRd
        83OOpnZbz+kWFdzHM8w0sRkvQ9By
X-Google-Smtp-Source: APXvYqzcutQ4X+bOIPjRTPsTCP2ULxZ5QLm5ja3rVVLWKlHkyo4Lt6Z4ORJr2XxUk/8hvaqQOQupVw==
X-Received: by 2002:a1c:ddc3:: with SMTP id u186mr996824wmg.103.1579900787981;
        Fri, 24 Jan 2020 13:19:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a5sm8083567wmb.37.2020.01.24.13.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 13:19:47 -0800 (PST)
Message-Id: <2ad4d3e467a7e2be679de4084e54f426aa242bd6.1579900782.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.513.v2.git.1579900782.gitgitgadget@gmail.com>
References: <pull.513.git.1579029962.gitgitgadget@gmail.com>
        <pull.513.v2.git.1579900782.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Jan 2020 21:19:36 +0000
Subject: [PATCH v2 06/12] sparse-checkout: cone mode does not recognize "**"
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When core.sparseCheckoutCone is enabled, the 'git sparse-checkout set'
command creates a restricted set of possible patterns that are used
by a custom algorithm to quickly match those patterns.

If a user manually edits the sparse-checkout file, then they could
create patterns that do not match these expectations. The cone-mode
matching algorithm can return incorrect results. The solution is to
detect these incorrect patterns, warn that we do not recognize them,
and revert to the standard algorithm.

Check each pattern for the "**" substring, and revert to the old
logic if seen. While technically a "/<dir>/**" pattern matches
the meaning of "/<dir>/", it is not one that would be written by
the sparse-checkout builtin in cone mode. Attempting to accept that
pattern change complicates the logic and instead we punt and do
not accept any instance of "**".

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 dir.c                              |  7 +++++-
 t/t1091-sparse-checkout-builtin.sh | 34 ++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index 22d08e61c2..40fed73a94 100644
--- a/dir.c
+++ b/dir.c
@@ -651,11 +651,16 @@ static void add_pattern_to_hashsets(struct pattern_list *pl, struct path_pattern
 		return;
 	}
 
+	if (strstr(given->pattern, "**")) {
+		/* Not a cone pattern. */
+		warning(_("unrecognized pattern: '%s'"), given->pattern);
+		goto clear_hashmaps;
+	}
+
 	if (given->patternlen > 2 &&
 	    !strcmp(given->pattern + given->patternlen - 2, "/*")) {
 		if (!(given->flags & PATTERN_FLAG_NEGATIVE)) {
 			/* Not a cone pattern. */
-			pl->use_cone_patterns = 0;
 			warning(_("unrecognized pattern: '%s'"), given->pattern);
 			goto clear_hashmaps;
 		}
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index cf4a595c86..e2e45dc7fd 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -305,4 +305,38 @@ test_expect_success 'different sparse-checkouts with worktrees' '
 	check_files worktree a deep
 '
 
+check_read_tree_errors () {
+	REPO=$1
+	FILES=$2
+	ERRORS=$3
+	git -C $REPO read-tree -mu HEAD 2>err &&
+	if test -z "$ERRORS"
+	then
+		test_must_be_empty err
+	else
+		test_i18ngrep "$ERRORS" err
+	fi &&
+	check_files $REPO $FILES
+}
+
+test_expect_success 'pattern-checks: /A/**' '
+	cat >repo/.git/info/sparse-checkout <<-\EOF &&
+	/*
+	!/*/
+	/folder1/**
+	EOF
+	check_read_tree_errors repo "a folder1" "disabling cone pattern matching"
+'
+
+test_expect_success 'pattern-checks: /A/**/B/' '
+	cat >repo/.git/info/sparse-checkout <<-\EOF &&
+	/*
+	!/*/
+	/deep/**/deepest
+	EOF
+	check_read_tree_errors repo "a deep" "disabling cone pattern matching" &&
+	check_files repo/deep "deeper1" &&
+	check_files repo/deep/deeper1 "deepest"
+'
+
 test_done
-- 
gitgitgadget


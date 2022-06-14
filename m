Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B5AC433EF
	for <git@archiver.kernel.org>; Tue, 14 Jun 2022 21:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344911AbiFNV2A (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 17:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236212AbiFNV14 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 17:27:56 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EBD289AA
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 14:27:55 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id l2-20020a05600c4f0200b0039c55c50482so118691wmq.0
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 14:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+NgjN9UmnSwRfn2y5XHvzFtH+tF1VxB6YhLftcKV2bQ=;
        b=muwW3hU/Z/t595DYtrH0OHPYtdTc6BNjjlo1c5sPI5feX7eBLGjcDH17kF50LXO8x8
         jFZekYTKsj5ls0dlOvWQXLXAI7/sbVvJUMRsF3EiKFo4KdzF9i8XfFm1AXQ/qneLfrc4
         1rjpq9EqoAM6ayUg4KgnjHdJKG/Weh6jljmZQxiqnaO5yUseuor6DEumH/4q4W56kSLn
         I3EGZjtTmdWaVo3UzKJZfAjvufhQ+FX1jz8UMrYrrWo733EV/ZHqz+oXC0Xlsl/ug0j8
         B+PKGWJ4/H8KqF+0vsNBj631LkUL7Pa7hVlKTAqEEh+3jt1gJfTrjhvlOROGQ4VnEVPB
         2N7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+NgjN9UmnSwRfn2y5XHvzFtH+tF1VxB6YhLftcKV2bQ=;
        b=a2CIRvanMP4gX8Et3WIIzZMDGLiO3pFdYAwNPwYQs+ylTQCz+lwvcsCIkGqZwSZKlP
         wvCgfI7zzG+P83qpEDTwwnOg0f0TudWxTtY94v2GJcpGFGxA0xFMM6z64UZTvSm8HHsR
         G/5pWyi7+qiPPBxxX6LiLrR8fxva82JVFNWk9C/ZHRFp/lF0yy0hAQVR1vf/XJfLCrMC
         /WnS1oNSB8u4TimaN0nUI61ZUXxB0yigDHQoxKo+JFS773hIYifDs0093PrLcLbQr6JY
         cuFpay2j8779DV7PNHfUMWwkPbtOKj/qw5ZYNmJq0eloP7+mfa+OKD9gREu91PoxThjz
         i88w==
X-Gm-Message-State: AOAM531UhsK12v5OEA33n8THpoSYG3maCqR9m6ogvrfY1Z9JS83yobs9
        48RmhWPORh7f+aKEqk0zTO+Du+VScUjKNw==
X-Google-Smtp-Source: ABdhPJzzuszhJpMhtZpVtRUzh5+uGe5F0ADsY+zNjTqNPU3lZ729x9CmOMFfwPOKzLumUub9lW7QZw==
X-Received: by 2002:a7b:c413:0:b0:39c:37cc:b0fe with SMTP id k19-20020a7bc413000000b0039c37ccb0femr6054386wmi.11.1655242073564;
        Tue, 14 Jun 2022 14:27:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o20-20020a5d58d4000000b0021a05379fd3sm8460298wrf.30.2022.06.14.14.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 14:27:52 -0700 (PDT)
Message-Id: <c6803df1b6afead99a0a6a383ab9aa563920f464.1655242070.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1261.git.1655242070.gitgitgadget@gmail.com>
References: <pull.1261.git.1655242070.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Jun 2022 21:27:47 +0000
Subject: [PATCH 1/4] t2107: test 'git update-index --verbose'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The '--verbose' option reports what is being added and removed from the
index, but has not been tested up to this point. Augment the tests in
t2107 to check the '--verbose' option in some scenarios.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 t/t2106-update-index-assume-unchanged.sh |  2 +-
 t/t2107-update-index-basic.sh            | 31 +++++++++++++++++++-----
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/t/t2106-update-index-assume-unchanged.sh b/t/t2106-update-index-assume-unchanged.sh
index d943ddf47e0..ad2692a2979 100755
--- a/t/t2106-update-index-assume-unchanged.sh
+++ b/t/t2106-update-index-assume-unchanged.sh
@@ -20,7 +20,7 @@ test_expect_success 'do not switch branches with dirty file' '
 	git reset --hard &&
 	git checkout other &&
 	echo dirt >file &&
-	git update-index --assume-unchanged file &&
+	git update-index --verbose --assume-unchanged file &&
 	test_must_fail git checkout - 2>err &&
 	test_i18ngrep overwritten err
 '
diff --git a/t/t2107-update-index-basic.sh b/t/t2107-update-index-basic.sh
index a30b7ca6bc9..07e6de84e6d 100755
--- a/t/t2107-update-index-basic.sh
+++ b/t/t2107-update-index-basic.sh
@@ -36,9 +36,14 @@ test_expect_success '--cacheinfo does not accept blob null sha1' '
 	echo content >file &&
 	git add file &&
 	git rev-parse :file >expect &&
-	test_must_fail git update-index --cacheinfo 100644 $ZERO_OID file &&
+	test_must_fail git update-index --verbose --cacheinfo 100644 $ZERO_OID file >out &&
 	git rev-parse :file >actual &&
-	test_cmp expect actual
+	test_cmp expect actual &&
+
+	cat >expect <<-\EOF &&
+	add '\''file'\''
+	EOF
+	test_cmp expect out
 '
 
 test_expect_success '--cacheinfo does not accept gitlink null sha1' '
@@ -59,9 +64,14 @@ test_expect_success '--cacheinfo mode,sha1,path (new syntax)' '
 	git rev-parse :file >actual &&
 	test_cmp expect actual &&
 
-	git update-index --add --cacheinfo "100644,$(cat expect),elif" &&
+	git update-index --add --verbose --cacheinfo "100644,$(cat expect),elif" >out &&
 	git rev-parse :elif >actual &&
-	test_cmp expect actual
+	test_cmp expect actual &&
+
+	cat >expect <<-\EOF &&
+	add '\''elif'\''
+	EOF
+	test_cmp expect out
 '
 
 test_expect_success '.lock files cleaned up' '
@@ -74,7 +84,8 @@ test_expect_success '.lock files cleaned up' '
 	git config core.worktree ../../worktree &&
 	# --refresh triggers late setup_work_tree,
 	# active_cache_changed is zero, rollback_lock_file fails
-	git update-index --refresh &&
+	git update-index --refresh --verbose >out &&
+	test_must_be_empty out &&
 	! test -f .git/index.lock
 	)
 '
@@ -83,7 +94,15 @@ test_expect_success '--chmod=+x and chmod=-x in the same argument list' '
 	>A &&
 	>B &&
 	git add A B &&
-	git update-index --chmod=+x A --chmod=-x B &&
+	git update-index --verbose --chmod=+x A --chmod=-x B >out &&
+	cat >expect <<-\EOF &&
+	add '\''A'\''
+	chmod +x '\''A'\''
+	add '\''B'\''
+	chmod -x '\''B'\''
+	EOF
+	test_cmp expect out &&
+
 	cat >expect <<-EOF &&
 	100755 $EMPTY_BLOB 0	A
 	100644 $EMPTY_BLOB 0	B
-- 
gitgitgadget


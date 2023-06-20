Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C561EEB64D8
	for <git@archiver.kernel.org>; Tue, 20 Jun 2023 19:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjFTToN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jun 2023 15:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjFTToF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2023 15:44:05 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A83E1726
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 12:44:03 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f8fb0e7709so48806995e9.2
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 12:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687290241; x=1689882241;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/foe2oVRIyiL/lIaRDpUiJaoYdVMLKS0FrCK0uujDg=;
        b=SND1j+X5KS0THTbb4pPbkaoxFv4/t/Bghi+1iBCLhE1bjCydomMwQti6ahpdkjuChH
         zAcz6mQ3mJenJ2NebFJMC5CssNi9e8uvlXdxizXGcgrDF8M3sdN6dMZc0Tl0qWjoIMPt
         iZ87nh4b5WsuA/Mmqi55WKWHChlbkj1XePVLReYVKKas91Ind5XuRIBYLxAKCSdbp5pv
         cJ1Y7r1Ky1IbXOk1zM2AScrLF6QWaTFfgDI1Y0jL23EN2jiSSW5UjBBYvUNc3/xcCzdv
         gZASKI8YK59NE9Zn/KZyv4PzsoXNc00odvLHDfpZcMqBmOoCqo31lijKhoiEhgq4H98v
         F85g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687290241; x=1689882241;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H/foe2oVRIyiL/lIaRDpUiJaoYdVMLKS0FrCK0uujDg=;
        b=fP9kOEtDebf0RTVCQ/DRs2VT8l76AuUSkVWwubL5kPYfI9My+czEZM9WfpxuQOVPG8
         5Y7Sd/LmVynudZbz6Dfy3U1/Ra1hWwhBsCCYjDs3NUL76jPxMxTgvjc6YOEBzC1BGzBg
         OloAz4mmsedpuI3bng35JPENY/CTJXz3vFRiQGkyKky12s585rSH6RuvWsxnRHr5Kxcu
         ql1KJxXtJDy+JOlKC2ZrGS+OX59FAkIOOJXsS6BXMkPsJqtUCNGvhzJFhy8Qq80JW+6D
         zpzvnlfArvMkNa1V1Yz9uhb7pc22dUi+ZP4hnmz8L1LQp2ihUe583jnJp4zDDx1aak8N
         5TKw==
X-Gm-Message-State: AC+VfDxZIDWmOHrfRfybNdaId7B9jZYAMUPdpEVcTOyHK1lh3esmWiO3
        CELEvBVyVYaPF1fHR7uI8R71HbKQsnA=
X-Google-Smtp-Source: ACHHUZ6O+0BNb7i1QCT7M6XabQ5HdCLi5h2NCmKSpfwP4ugHGeL8GszOn4OSVjKNz/GAaRX9xub/1g==
X-Received: by 2002:a1c:ed08:0:b0:3f6:58ad:ed85 with SMTP id l8-20020a1ced08000000b003f658aded85mr10511332wmh.10.1687290241127;
        Tue, 20 Jun 2023 12:44:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u12-20020a05600c210c00b003f9b0830107sm6755595wml.41.2023.06.20.12.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 12:44:00 -0700 (PDT)
Message-Id: <a2a891a069f46d3d77cafe61f64402c93cffaae4.1687290233.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1497.v3.git.git.1687290231.gitgitgadget@gmail.com>
References: <pull.1497.v2.git.git.1685472132.gitgitgadget@gmail.com>
        <pull.1497.v3.git.git.1687290231.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Jun 2023 19:43:45 +0000
Subject: [PATCH v3 06/12] builtin/config.c: test misuse of format_config()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Emily Shaffer <nasamuffin@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

current_config_*() functions aren't meant to be called outside of
config callbacks because they read state that is only set when iterating
through config. However, several sites in builtin/config.c are
indirectly calling these functions outside of config callbacks thanks to
the format_config() helper. Show the current, bad behavior via tests
so that the fixes in a subsequent commit will be clearer.

The misbehaving cases are:

* "git config --get-urlmatch --show-scope" results in an "unknown"
   scope, where it arguably should show the config file's scope. It's
   clear that this wasn't intended, though: we knew that
   "--get-urlmatch" couldn't show config source metadata, which is why
   "--show-origin" was marked incompatible with "--get-urlmatch" when
   it was introduced [1]. It was most likely a mistake that we allowed
   "--show-scope" to sneak through.

* Similarly, "git config --default" doesn't set config source metadata ,
  so "--show-scope" also results in "unknown", and "--show-origin"
  results in a BUG().

[1] https://lore.kernel.org/git/20160205112001.GA13397@sigill.intra.peff.net/

Signed-off-by: Glen Choo <chooglen@google.com>
---
 t/t1300-config.sh | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 86bfbc2b364..fa6a8df2521 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1668,6 +1668,21 @@ test_expect_success 'urlmatch' '
 	test_cmp expect actual
 '
 
+test_expect_success 'urlmatch with --show-scope' '
+	cat >.git/config <<-\EOF &&
+	[http "https://weak.example.com"]
+		sslVerify = false
+		cookieFile = /tmp/cookie.txt
+	EOF
+
+	cat >expect <<-EOF &&
+	unknown	http.cookiefile /tmp/cookie.txt
+	unknown	http.sslverify false
+	EOF
+	git config --get-urlmatch --show-scope HTTP https://weak.example.com >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'urlmatch favors more specific URLs' '
 	cat >.git/config <<-\EOF &&
 	[http "https://example.com/"]
@@ -2055,6 +2070,10 @@ test_expect_success '--show-origin blob ref' '
 	test_cmp expect output
 '
 
+test_expect_success '--show-origin with --default' '
+	test_must_fail git config --show-origin --default foo some.key
+'
+
 test_expect_success '--show-scope with --list' '
 	cat >expect <<-EOF &&
 	global	user.global=true
@@ -2123,6 +2142,12 @@ test_expect_success '--show-scope with --show-origin' '
 	test_cmp expect output
 '
 
+test_expect_success '--show-scope with --default' '
+	git config --show-scope --default foo some.key >actual &&
+	echo "unknown	foo" >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'override global and system config' '
 	test_when_finished rm -f \"\$HOME\"/.gitconfig &&
 	cat >"$HOME"/.gitconfig <<-EOF &&
-- 
gitgitgadget


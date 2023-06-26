Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6391EB64DC
	for <git@archiver.kernel.org>; Mon, 26 Jun 2023 18:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbjFZSLu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jun 2023 14:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbjFZSLg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2023 14:11:36 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E4E106
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 11:11:35 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fa99742bd1so10887435e9.3
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 11:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687803093; x=1690395093;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/foe2oVRIyiL/lIaRDpUiJaoYdVMLKS0FrCK0uujDg=;
        b=c0OpnTWfS1rU/2tV+z44NbLIaLX6452kCn9uRCZ/gzvfAHuCw5ZIv/wTjZ5X+buCX/
         UPYWJecIwnz8zdlK9yBHxeZAibXOsB5nO519CYAtfUt6t6GYyT8pfqvplHis1veJiMfK
         /NHoDCYayrgaBs4sLE0rzSeec7fI7UG7xUEleWdvCUnFVx3/uNWyWKGFi40pLbJrO+5L
         H9hs0q5iCh0BaW8zD81pfG5cxKTJrxH/RgxxfBUHKc3QeQ6Ofa7sKGLHj52pE9+8PGlp
         B1kjjPsi5U8ltMhA4nPVlHABorY+AsGixuzNaAltZ+mjGB9DqC9c184/Imftp6Li8UCB
         7Ulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687803093; x=1690395093;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H/foe2oVRIyiL/lIaRDpUiJaoYdVMLKS0FrCK0uujDg=;
        b=PGoc81HjNjePF186AnUbwJR2mzDK/z8oJ7GHUerkEAorjDQfYjXs2kRNiLELRovu6Y
         oYJdoHyDkigaZY0zLpxWhElc8IH1vWHL7ltFFzzmQjubAJJQtGcEyic9uVqNMfcEST6R
         G8Mg9NNHdYjtI9axAzPk7gt7Uvst8VhOpdZCq6D11UxjmAgde5+HiJK6WbQmudaapy2I
         sQS0sVV/KoVYenGZMeqYZpwacOWm/I6urBdkKwUVnpNirjlHDplljTqD/1UElsNMGZEl
         nucyyP/MiyIP/GNYgU2sI6n/2Wy15gNn2hxrsv2WMB6DbeCKdasqXaMECMgJzE/bLMh4
         YZyw==
X-Gm-Message-State: AC+VfDxx0ptbIwaDxyHJXiM/ORvCzE4IQvktuTL4eQiYNgSjajj/Pg4K
        iUkjE1fHzt/WsfIiTHEeiTCzwBByChI=
X-Google-Smtp-Source: ACHHUZ7w1c0xErOkrTfr86kAGyNKOiYw5MeT1nYG3KkdfCzSJys4yppLYYKhGYTGQZhUUAOXB5KYXA==
X-Received: by 2002:a7b:c409:0:b0:3fa:934c:8350 with SMTP id k9-20020a7bc409000000b003fa934c8350mr3017159wmi.27.1687803093134;
        Mon, 26 Jun 2023 11:11:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z10-20020a7bc7ca000000b003f8f8fc3c32sm8436512wmk.31.2023.06.26.11.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 11:11:32 -0700 (PDT)
Message-Id: <897bdc759b5a59ff65cf2d555f6007671be22f64.1687803085.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1497.v4.git.git.1687803083.gitgitgadget@gmail.com>
References: <pull.1497.v3.git.git.1687290231.gitgitgadget@gmail.com>
        <pull.1497.v4.git.git.1687803083.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Jun 2023 18:11:17 +0000
Subject: [PATCH v4 06/12] builtin/config.c: test misuse of format_config()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Emily Shaffer <nasamuffin@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Glen Choo <chooglen@google.com>,
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


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB8AC77B7A
	for <git@archiver.kernel.org>; Tue, 30 May 2023 18:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233482AbjE3Sme (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 May 2023 14:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232890AbjE3Sm0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2023 14:42:26 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFC910D
        for <git@vger.kernel.org>; Tue, 30 May 2023 11:42:24 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3090d3e9c92so4789218f8f.2
        for <git@vger.kernel.org>; Tue, 30 May 2023 11:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685472143; x=1688064143;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pIg6+ojWHoHlMlxZS0UeEjxPgzzEe5+2AGTg/jYTUCQ=;
        b=DOYV5DPNdGhkPjWaMQPmbpiKMZ08mSBbpqxmbf7jSlvBtyq4AaLcuk8j85bmlX8FeN
         BKhYQdO2wQxOm5INwzp2rsKGhcZ0MLEw8w8k6QdJnrcmZaHUL5VQ1xQ1EoakclkzYvf8
         w0LmanbkT8Fu/X4xjqCbydoZ0ZniQtGpFT8URszTZJe0Kd8u+4eyVPes8TFH4f01fN6o
         1KW4yCgm+onGS4ZdscvcdgDeEOawIHA/O9MCS+spyPWrFEfTZGwXahhGM/hWmtJYS2Q4
         gK3fiB2ltxmjyI1IrlKQjI4H+FXGDsaWG12vU+vA0viBBsnxRho44yDGSFBkfCwGxWsN
         EfGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685472143; x=1688064143;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pIg6+ojWHoHlMlxZS0UeEjxPgzzEe5+2AGTg/jYTUCQ=;
        b=kxNzKN3oNqosBLld5eHbKgydMkkjVK82FKuDqb3Iv0tAxOrk5DOpXwCchqsG9yfqnA
         e6MokGemG/6+Fx2dJp/Xwkw4hXEWACfDxn3a3E1Xa1WmuD4JZelUXoLTNg72CnoC0B2r
         svu8JxmJdYh+AvxvHP6DQcaPsCRbj5k/kxXEa7E7ClfhUeUSrFjypyL22ZOCclprD819
         y2s6eJ2/WfqlU1/utdE5hJrr5bnBNrNEck0yLzgtaSMjry+r0UkEdBDTulAC2Tzc6nZR
         xklnJ/IlpbuvuTBb7LWB/dcFCTBCaMoPzkvkhROZ4FMJxtiLUXYn2FWs8vb+zAZ2bP9Q
         NY8w==
X-Gm-Message-State: AC+VfDwG2eP0PH0BjG60enTCLn/AFZkmnqWDhYO5h7cl2h+DAopbtAmw
        YZOdE6RKzeTL+7X2XPCa6XOuFKw6JTk=
X-Google-Smtp-Source: ACHHUZ5Nh/l9xqVEJl2L+gDDfU6VaT6WMuAHzh+YRNDXhkVSb11V2IiWoGYihSeaRTolCLaFOkyVng==
X-Received: by 2002:adf:ed48:0:b0:306:35d2:c33a with SMTP id u8-20020adfed48000000b0030635d2c33amr2329336wro.50.1685472143612;
        Tue, 30 May 2023 11:42:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a14-20020adfe5ce000000b003078354f774sm4166954wrn.36.2023.05.30.11.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 11:42:23 -0700 (PDT)
Message-Id: <74f43fc727ebb07874b902b0ec64dd0954ffff30.1685472134.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1497.v2.git.git.1685472132.gitgitgadget@gmail.com>
References: <pull.1497.git.git.1682104398.gitgitgadget@gmail.com>
        <pull.1497.v2.git.git.1685472132.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 30 May 2023 18:42:06 +0000
Subject: [PATCH v2 08/14] builtin/config.c: test misuse of format_config()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Emily Shaffer <nasamuffin@google.com>,
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
index 2575279ab84..57fe250b78f 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1627,6 +1627,21 @@ test_expect_success 'urlmatch' '
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
@@ -2014,6 +2029,10 @@ test_expect_success '--show-origin blob ref' '
 	test_cmp expect output
 '
 
+test_expect_success '--show-origin with --default' '
+	test_must_fail git config --show-origin --default foo some.key
+'
+
 test_expect_success '--show-scope with --list' '
 	cat >expect <<-EOF &&
 	global	user.global=true
@@ -2082,6 +2101,12 @@ test_expect_success '--show-scope with --show-origin' '
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


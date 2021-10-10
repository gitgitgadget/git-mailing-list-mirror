Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FDFC433EF
	for <git@archiver.kernel.org>; Sun, 10 Oct 2021 17:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 999B660F58
	for <git@archiver.kernel.org>; Sun, 10 Oct 2021 17:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbhJJRFO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Oct 2021 13:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbhJJRFJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Oct 2021 13:05:09 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902C6C061570
        for <git@vger.kernel.org>; Sun, 10 Oct 2021 10:03:10 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id m22so47962666wrb.0
        for <git@vger.kernel.org>; Sun, 10 Oct 2021 10:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NWiHaj6BkTEYrLmidKAYbWVxJGxhNIUtxiV1PggnK0k=;
        b=i+09nfann7YY4DYBISPM+y2Ru6YePzd+oyBBh59UeeaTr38AyfnSv7PynyB4EbACbd
         MQONHdcDygTTwGYoE52yq3eqWAnZWLiEcp134DH49EWduQraCMcKLYg1KtNqNw2Bnd1E
         DjihZzn7oXi/FR4OiVyiidFA37eB7zsnsY/4d3806SDzcce0oUSWJwHYrVZ1HJsa/EuU
         AV+27WfNTiU2nlx7hcIxjpZAP0wxQAXC3jiQv3xo2rGusLvJHxVfyupqMouWv+6j2XdU
         Af9ng1SIzDGgVTE6sF/UZsnPkgeKkua5ngxNtyGgz8E7SyTe5VL8Z7YPWHMQ99JN7qTl
         ychQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NWiHaj6BkTEYrLmidKAYbWVxJGxhNIUtxiV1PggnK0k=;
        b=R5ZPXeI2uPMR0rm+urrPjeP9yteUJd1k+qw+2+0kgcm8JXDIuvD7OMYpv+qva4NSYi
         hc3aWw+kzABcLD49t3GbP69MaTGzRTaVgwgIIxG3YscyG0sw+P91mPIJEN6MogGMoiQB
         l4PMz86/NhMCD56R3H12DU+yHBK+wsbpzrM23lyzCaDPdb3Pp7BkOAegzlSuT5aHwND+
         ILuFEV0ZZDfARDf/GSZnXg06YZ1UcaUdIhvoZL7hbTMJW9o8hSphpkuPDKjsI43nKgaF
         gxfS26eTkA+BLp8ECqoPh7g+KV0iAiJMQhT7R78z0I0BYnbuGBu+bVCJx6Suf5yQTEH+
         oTvQ==
X-Gm-Message-State: AOAM532gR3rrmFTqzbf6KR7AwE09ViUwXpSEAQkPRwE+83iYTRCFVbCZ
        WnaBKOqxlc2IIT030PTlzgVlVAG3wh4=
X-Google-Smtp-Source: ABdhPJzj7MWE/LF0bwX1h5K5O2I63MX7ipfs8u9k+cyMLTvEfpfpzLxpnwAvUuumEf5C5xCWCZx4hQ==
X-Received: by 2002:a7b:cb4b:: with SMTP id v11mr16701897wmj.155.1633885389212;
        Sun, 10 Oct 2021 10:03:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a17sm5520355wrx.33.2021.10.10.10.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Oct 2021 10:03:08 -0700 (PDT)
Message-Id: <cc9dc967f10b6e1cb1d97e815496151e32f19af8.1633885384.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1054.v3.git.1633885384.gitgitgadget@gmail.com>
References: <pull.1054.v2.git.1633720197.gitgitgadget@gmail.com>
        <pull.1054.v3.git.1633885384.gitgitgadget@gmail.com>
From:   "Johannes Sixt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 10 Oct 2021 17:03:04 +0000
Subject: [PATCH v3 6/6] userdiff-cpp: learn the C++ spaceship operator
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Johannes Sixt <j6t@kdbg.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Sixt <j6t@kdbg.org>

Since C++20, the language has a generalized comparison operator <=>.
Teach the cpp driver not to separate it into <= and > tokens.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t4034/cpp/expect | 2 +-
 userdiff.c         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t4034/cpp/expect b/t/t4034/cpp/expect
index b90b3f207bf..5ff4ce477b4 100644
--- a/t/t4034/cpp/expect
+++ b/t/t4034/cpp/expect
@@ -25,7 +25,7 @@ str.e+<RED>65<RESET><GREEN>75<RESET>
 a<RED>*<RESET><GREEN>*=<RESET>b c<RED>/<RESET><GREEN>/=<RESET>d e<RED>%<RESET><GREEN>%=<RESET>f
 a<RED>+<RESET><GREEN>++<RESET>b c<RED>-<RESET><GREEN>--<RESET>d
 a<RED><<<RESET><GREEN><<=<RESET>b c<RED>>><RESET><GREEN>>>=<RESET>d
-a<RED><<RESET><GREEN><=<RESET>b c<RED><=<RESET><GREEN><<RESET>d e<RED>><RESET><GREEN>>=<RESET>f g<RED>>=<RESET><GREEN>><RESET>h i<=<GREEN>><RESET>j
+a<RED><<RESET><GREEN><=<RESET>b c<RED><=<RESET><GREEN><<RESET>d e<RED>><RESET><GREEN>>=<RESET>f g<RED>>=<RESET><GREEN>><RESET>h i<RED><=<RESET><GREEN><=><RESET>j
 a<RED>==<RESET><GREEN>!=<RESET>b c<RED>!=<RESET><GREEN>=<RESET>d
 a<RED>^<RESET><GREEN>^=<RESET>b c<RED>|<RESET><GREEN>|=<RESET>d e<RED>&&<RESET><GREEN>&=<RESET>f
 a<RED>||<RESET><GREEN>|<RESET>b
diff --git a/userdiff.c b/userdiff.c
index 5072d12e51e..96adddd6f9a 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -62,7 +62,7 @@ PATTERNS("cpp",
 	 "|0[xXbB][0-9a-fA-F']+[lLuU]*"
 	 /* floatingpoint numbers that begin with a decimal point */
 	 "|\\.[0-9][0-9']*([Ee][-+]?[0-9]+)?[fFlL]?"
-	 "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->\\*?|\\.\\*"),
+	 "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->\\*?|\\.\\*|<=>"),
 PATTERNS("csharp",
 	 /* Keywords */
 	 "!^[ \t]*(do|while|for|if|else|instanceof|new|return|switch|case|throw|catch|using)\n"
-- 
gitgitgadget

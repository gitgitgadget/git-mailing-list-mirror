Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A414C433EF
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 13:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BF096115C
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 13:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbhJ2OBw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 10:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbhJ2OBv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 10:01:51 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5479C061714
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 06:59:22 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id c71-20020a1c9a4a000000b0032cdcc8cbafso4803304wme.3
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 06:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=As5zPCH7OBI2EjZyENdXYBbyh7weut22H3Fe+DIkjnk=;
        b=E2IDw4S4wjOSo2unha1Fyn1cQ3cY2chAwuc0U4ap5z+VvNtJSp3xxxY0+xUtwChhUA
         Y2IxhJ954eGtzW5nPo8C6jc/rJeJW254Hpf0kvgXD5D9mLGazNkJuOT5LiDuDlsWuGfZ
         CYWFFO+v4mNsZQ3cpQA8rv4AsIrcYqfx3avm45ihmfUzGAKeHq/QHpCL5cXp9yysHClh
         CIsfG3MMlFMnYI/aLJFIanF+HaHJ7vDkQn/oLFxFHU80E3/xwSHAMclBehe7NhB+v3Xm
         nS3JyMRl3Yrx8uR7+dhx8M2RgolokV6YCPY0g3BLVBrjStkYRhzFDvMbCORjINBBX+zz
         cKCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=As5zPCH7OBI2EjZyENdXYBbyh7weut22H3Fe+DIkjnk=;
        b=LU45kuSA1576M5frryF2k4IT5bSVh/6l1aSIyWfHDiChSVJfed20CuxP0HXqDlp//U
         Xx8JogFp6fR20dsPT4nmEnStLIpR1wbPllWrxsWtmEypzRM1qYwwJANJLT4IFuf+Ai+E
         2ESSQWyz+Hn0jNmD7+XjWZAED7S1JY58Fz3IpCtQXObO+5Ksfcgoy47EYxemQqfvfTFw
         DWctToMdUa+FeVp2LqCvLXrcvTd7WRpG36nIt24LlSShc7oaFwVwKDLQSmd+C448WDn2
         P4Wj4vXNCSVvquZUwpH1UtUhFiZ5IL9VEWx4YL7Xo5rhdPYrawoYwEMIqpBshgPMPo4Z
         ASbw==
X-Gm-Message-State: AOAM531GIxxGQ4Cb3wnUm45tWuM/sOsjNq7u7ounnADIm3LXYIhKuwaE
        qR3u/I9ehCfcgXlNIK9/gTYvdLGIC9M=
X-Google-Smtp-Source: ABdhPJyTuJJLjvARdIDEDX4q5u9AxP2awNWd7/9RtDulFrrRuPXCeOOjkEGv6klGMKi2OY/gOVWwpA==
X-Received: by 2002:a05:600c:4308:: with SMTP id p8mr11642163wme.159.1635515961338;
        Fri, 29 Oct 2021 06:59:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l11sm4565265wrp.61.2021.10.29.06.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 06:59:21 -0700 (PDT)
Message-Id: <068f897b973b1f8889145f97c42fe6233c272dd5.1635515959.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1068.v3.git.1635515959.gitgitgadget@gmail.com>
References: <pull.1068.v2.git.1635454237.gitgitgadget@gmail.com>
        <pull.1068.v3.git.1635515959.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Fri, 29 Oct 2021 13:59:12 +0000
Subject: [PATCH v3 1/8] test-genzeros: allow more than 2G zeros in Windows
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Carlo Arenas <carenas@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>

d5cfd142ec (tests: teach the test-tool to generate NUL bytes and
use it, 2019-02-14), add a way to generate zeroes in a portable
way without using /dev/zero (needed by HP NonStop), but uses a
long variable that is limited to 2^31 in Windows.

Use instead a (POSIX/C99) intmax_t that is at least 64bit wide
in 64-bit Windows to use in a future test.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/helper/test-genzeros.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/helper/test-genzeros.c b/t/helper/test-genzeros.c
index 9532f5bac97..b1197e91a89 100644
--- a/t/helper/test-genzeros.c
+++ b/t/helper/test-genzeros.c
@@ -3,14 +3,14 @@
 
 int cmd__genzeros(int argc, const char **argv)
 {
-	long count;
+	intmax_t count;
 
 	if (argc > 2) {
 		fprintf(stderr, "usage: %s [<count>]\n", argv[0]);
 		return 1;
 	}
 
-	count = argc > 1 ? strtol(argv[1], NULL, 0) : -1L;
+	count = argc > 1 ? strtoimax(argv[1], NULL, 0) : -1;
 
 	while (count < 0 || count--) {
 		if (putchar(0) == EOF)
-- 
gitgitgadget


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63849C4332F
	for <git@archiver.kernel.org>; Sun, 10 Oct 2021 17:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EF68610C7
	for <git@archiver.kernel.org>; Sun, 10 Oct 2021 17:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbhJJRFN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Oct 2021 13:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbhJJRFI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Oct 2021 13:05:08 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36A0C06161C
        for <git@vger.kernel.org>; Sun, 10 Oct 2021 10:03:09 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id g25so1348692wrb.2
        for <git@vger.kernel.org>; Sun, 10 Oct 2021 10:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=v5JL2AenaR8RqTcWSZSPuR0Nrlr+9pVk/9sW+zxWyI8=;
        b=Dy+F4hmZD0jk+A8vRcQnqdLGIynR0seJ/ycK5iVTEMJsMTW6OTtK1DKv1mhLVTNoiT
         oBeV2vrQcSZSXBEGH2lvEuVyDm4sl7X26S/QZKHhNcf5YB22SriFivlcmRc23426dY7N
         kTcYE5mKUsfRnep8i3qqa7WFPH+V774IvxYwIqtlC1F9ymhFQYJX5houqDla0D+M6c3j
         +D++sRf5kER7G4jlRZn0JbfUeYZvmqxrh2uXfjOjnk40PtaXMRJyAsOzV3q+nmYx/b1D
         WctPaLKz9wTiIhJ0jPCQn05DVvwBoaBcJN/IP+8T8QhqHsthbcLam+A/Hcfp+0gj13Ne
         xPUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=v5JL2AenaR8RqTcWSZSPuR0Nrlr+9pVk/9sW+zxWyI8=;
        b=aJZ6dxxP+A2vtMmDkI27hh9PBnu5mcyEF0W1xOTsXLb4JJAHcsVJv9I/IMlRFuKTSq
         80S2FrDn3ntNT2kTB3aS9UEfd9X2gOFHdu8JOLlyRsVrjM0JYF2u335SFHpZodtVpiDx
         gjAnCsLHWDcD/aUFMTsXzbG/aKO3ZIPmJw3B9tDMYZoJf2eudK2VGMIeJ2T9PgQoLDI9
         yrhgk5bXBlOHb4TIY7aeMhYA4AFVjQGKww6ZhfXkkMEG48vF/YS1ro+FJXvTuWTTfcDa
         j5Nn76K8y7gF8mFRXqdTaPYKn6Di6hCwi1Ydw/PpA8oRjwhhB4x1KJWwX4PLzCDkn3zB
         w5Aw==
X-Gm-Message-State: AOAM5314nTKORYfn/6bdlbFAFaW3qpmVytILlV06NOombpmGM3XnYCmH
        6uNJXtsv6XLwDZRQ5U0FdNAhWaeTAYY=
X-Google-Smtp-Source: ABdhPJzGLPz/TWFVA2SJPthE9FvZjk/TtcnBWdRDgfnLkAW6sJTnF0fVkvvkQzBmj1PvPMzsZfnM8Q==
X-Received: by 2002:a05:600c:19cf:: with SMTP id u15mr16114950wmq.45.1633885388595;
        Sun, 10 Oct 2021 10:03:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g1sm18420376wmk.2.2021.10.10.10.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Oct 2021 10:03:08 -0700 (PDT)
Message-Id: <037c743d9e317ced040bf76bb979c6e17583de8a.1633885384.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1054.v3.git.1633885384.gitgitgadget@gmail.com>
References: <pull.1054.v2.git.1633720197.gitgitgadget@gmail.com>
        <pull.1054.v3.git.1633885384.gitgitgadget@gmail.com>
From:   "Johannes Sixt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 10 Oct 2021 17:03:03 +0000
Subject: [PATCH v3 5/6] userdiff-cpp: permit the digit-separating single-quote
 in numbers
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

Since C++17, the single-quote can be used as digit separator:

   3.141'592'654
   1'000'000
   0xdead'beaf

Make it known to the word regex of the cpp driver, so that numbers are
not split into separate tokens at the single-quotes.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t4034/cpp/expect | 8 ++++----
 userdiff.c         | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t4034/cpp/expect b/t/t4034/cpp/expect
index 3d37ddac42c..b90b3f207bf 100644
--- a/t/t4034/cpp/expect
+++ b/t/t4034/cpp/expect
@@ -7,15 +7,15 @@ Foo() : x(0<RED>&&1<RESET><GREEN>&42<RESET>) { <RED>foo0<RESET><GREEN>bar<RESET>
 cout<<"Hello World<RED>!<RESET><GREEN>?<RESET>\n"<<endl;
 <GREEN>(<RESET>1 <RED>-<RESET><GREEN>+<RESET>1e10 0xabcdef<GREEN>)<RESET> '<RED>x<RESET><GREEN>.<RESET>'
 // long double<RESET>
-3.141'592'<RED>653e-10l<RESET><GREEN>654e+10l<RESET>
+<RED>3.141'592'653e-10l<RESET><GREEN>3.141'592'654e+10l<RESET>
 // float<RESET>
 <RED>120E5f<RESET><GREEN>120E6f<RESET>
 // hex<RESET>
-0xdead'<RED>beaf<RESET><GREEN>Beaf<RESET>+<RED>8ULL<RESET><GREEN>7ULL<RESET>
+<RED>0xdead'beaf<RESET><GREEN>0xdead'Beaf<RESET>+<RED>8ULL<RESET><GREEN>7ULL<RESET>
 // octal<RESET>
-0123'<RED>4567<RESET><GREEN>4560<RESET>
+<RED>0123'4567<RESET><GREEN>0123'4560<RESET>
 // binary<RESET>
-<RED>0b10<RESET><GREEN>0b11<RESET>'00+e1
+<RED>0b10'00<RESET><GREEN>0b11'00<RESET>+e1
 // expression<RESET>
 1.5-e+<RED>2<RESET><GREEN>3<RESET>+f
 // another one<RESET>
diff --git a/userdiff.c b/userdiff.c
index ce2a9230703..5072d12e51e 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -57,11 +57,11 @@ PATTERNS("cpp",
 	 /* identifiers and keywords */
 	 "[a-zA-Z_][a-zA-Z0-9_]*"
 	 /* decimal and octal integers as well as floatingpoint numbers */
-	 "|[0-9][0-9.]*([Ee][-+]?[0-9]+)?[fFlLuU]*"
+	 "|[0-9][0-9.']*([Ee][-+]?[0-9]+)?[fFlLuU]*"
 	 /* hexadecimal and binary integers */
-	 "|0[xXbB][0-9a-fA-F]+[lLuU]*"
+	 "|0[xXbB][0-9a-fA-F']+[lLuU]*"
 	 /* floatingpoint numbers that begin with a decimal point */
-	 "|\\.[0-9]+([Ee][-+]?[0-9]+)?[fFlL]?"
+	 "|\\.[0-9][0-9']*([Ee][-+]?[0-9]+)?[fFlL]?"
 	 "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->\\*?|\\.\\*"),
 PATTERNS("csharp",
 	 /* Keywords */
-- 
gitgitgadget


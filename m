Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E88C433EF
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 19:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C79A260F6E
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 19:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240937AbhJHTMG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 15:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240771AbhJHTL5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 15:11:57 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9B9C061755
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 12:10:01 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id m22so32784633wrb.0
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 12:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TprPzN7R7X3HwMszuUqbxuwew16H0gOGT7C4dUNg7yI=;
        b=VUx4/bKOeCbslG8Yl5evi95/V6lV9BSmGOByTT4OdzuRAadKBoKDs+dR22d486WAma
         bZSF4suvcaeZ5RsQ2FFd1FKr7lR6hOmBRG8T6UW0DuOsVC7Ew0n16f49RHuh9ghCtirq
         tYkKiHPiOk8Xs6hos1rsEH1wsEiiRcirtWRMPmM85jzMKCGcaTy0QcnaBSGHibVK5uZO
         nSLWVIacRALZuxV3LVpII6qfSODFHQ+kbk8rDPW2TKX3qLdXiAp/VUAvtLzigHQpV9UU
         8ttBzDr2IHqjZ/nVjjkmD/IDa1WyLqfGqp3CpRFQGOknKLw80VCBMuSMODbAweJh96HI
         Lrqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TprPzN7R7X3HwMszuUqbxuwew16H0gOGT7C4dUNg7yI=;
        b=Pk3gD6/jyd3+Q6zuinWEiLvUPBnkKwBtj5WjDZtCRPOAMMvnEkIdtRt9nNtGdJ5esE
         zQnNy7vYpJWJ4ST4+mJhXJ86+H3nmmeuQEG0l382bNDLCQQDleJakA+J/phUEviBitb0
         1AMtpFNSvv/NIhTKIB7j091IN6k3RFjNeNqmeDIA5jcwyuhgKc2UT6KsxXwx3BfXvx8M
         oUgFA7lvGaim4pWLRKkv9wQa1Gq2GpWUFqKmfaYPzSM2eafcHm+6opyvtEkr8MZK04ot
         ZE5m3q/+oOqvf1dXwc1wkS80Wsk5BhwqBTAQDKUJ1d39amK0/49h3X6MhQ7aunro3ck7
         Ht3g==
X-Gm-Message-State: AOAM532YBSqTZ/TSUsw3EfLefe+Xq3m1FMIZBHwzML/ueq6ORhuSTLwz
        XpFujIy7us9fUTwWKuqIOoqalrkHrEQ=
X-Google-Smtp-Source: ABdhPJz2spvCIU+0ggddfza6NXeaaMMyuLNHW+SIlk8EWtZyFzIBHCCdPzUgkhVmC+oLQMB0CfQaxw==
X-Received: by 2002:a1c:2c2:: with SMTP id 185mr5406683wmc.85.1633720199985;
        Fri, 08 Oct 2021 12:09:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r27sm163550wrr.70.2021.10.08.12.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 12:09:59 -0700 (PDT)
Message-Id: <dd75d19cee9a911de93d19585c888c57fe8c3aee.1633720197.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1054.v2.git.1633720197.gitgitgadget@gmail.com>
References: <pull.1054.git.1633589461.gitgitgadget@gmail.com>
        <pull.1054.v2.git.1633720197.gitgitgadget@gmail.com>
From:   "Johannes Sixt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 08 Oct 2021 19:09:56 +0000
Subject: [PATCH v2 4/5] userdiff-cpp: permit the digit-separating single-quote
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
 t/t4034/cpp/expect | 10 +++++-----
 t/t4034/cpp/post   |  8 ++++----
 t/t4034/cpp/pre    |  8 ++++----
 userdiff.c         |  6 +++---
 4 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/t/t4034/cpp/expect b/t/t4034/cpp/expect
index 46c9460a968..a3a234f5461 100644
--- a/t/t4034/cpp/expect
+++ b/t/t4034/cpp/expect
@@ -1,5 +1,5 @@
 <BOLD>diff --git a/pre b/post<RESET>
-<BOLD>index 1229cdb..3feae6f 100644<RESET>
+<BOLD>index 60f3640..f6fbf7b 100644<RESET>
 <BOLD>--- a/pre<RESET>
 <BOLD>+++ b/post<RESET>
 <CYAN>@@ -1,30 +1,30 @@<RESET>
@@ -7,15 +7,15 @@ Foo() : x(0<RED>&&1<RESET><GREEN>&42<RESET>) { <RED>foo0<RESET><GREEN>bar<RESET>
 cout<<"Hello World<RED>!<RESET><GREEN>?<RESET>\n"<<endl;
 <GREEN>(<RESET>1 <RED>-<RESET><GREEN>+<RESET>1e10 0xabcdef<GREEN>)<RESET> '<RED>x<RESET><GREEN>y<RESET>'
 // long double<RESET>
-<RED>3.141592653e-10l<RESET><GREEN>3.141592654e+10l<RESET>
+<RED>3.141'592'653e-10l<RESET><GREEN>3.141'592'654e+10l<RESET>
 // float<RESET>
 <RED>120E5f<RESET><GREEN>120E6f<RESET>
 // hex<RESET>
-<RED>0xdeadbeaf<RESET><GREEN>0xdeadBeaf<RESET>+<RED>8ULL<RESET><GREEN>7ULL<RESET>
+<RED>0xdead'beaf<RESET><GREEN>0xdead'Beaf<RESET>+<RED>8ULL<RESET><GREEN>7ULL<RESET>
 // octal<RESET>
-<RED>01234567<RESET><GREEN>01234560<RESET>
+<RED>0123'4567<RESET><GREEN>0123'4560<RESET>
 // binary<RESET>
-<RED>0b1000<RESET><GREEN>0b1100<RESET>+e1
+<RED>0b10'00<RESET><GREEN>0b11'00<RESET>+e1
 // expression<RESET>
 1.5-e+<RED>2<RESET><GREEN>3<RESET>+f
 // another one<RESET>
diff --git a/t/t4034/cpp/post b/t/t4034/cpp/post
index 3feae6f430f..f6fbf7bc04c 100644
--- a/t/t4034/cpp/post
+++ b/t/t4034/cpp/post
@@ -2,15 +2,15 @@ Foo() : x(0&42) { bar(x.Find); }
 cout<<"Hello World?\n"<<endl;
 (1 +1e10 0xabcdef) 'y'
 // long double
-3.141592654e+10l
+3.141'592'654e+10l
 // float
 120E6f
 // hex
-0xdeadBeaf+7ULL
+0xdead'Beaf+7ULL
 // octal
-01234560
+0123'4560
 // binary
-0b1100+e1
+0b11'00+e1
 // expression
 1.5-e+3+f
 // another one
diff --git a/t/t4034/cpp/pre b/t/t4034/cpp/pre
index 1229cdb59d1..60f3640d773 100644
--- a/t/t4034/cpp/pre
+++ b/t/t4034/cpp/pre
@@ -2,15 +2,15 @@ Foo():x(0&&1){ foo0( x.find); }
 cout<<"Hello World!\n"<<endl;
 1 -1e10 0xabcdef 'x'
 // long double
-3.141592653e-10l
+3.141'592'653e-10l
 // float
 120E5f
 // hex
-0xdeadbeaf+8ULL
+0xdead'beaf+8ULL
 // octal
-01234567
+0123'4567
 // binary
-0b1000+e1
+0b10'00+e1
 // expression
 1.5-e+2+f
 // another one
diff --git a/userdiff.c b/userdiff.c
index ce2a9230703..1b640c7df79 100644
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
+	 "|\\.[0-9']+([Ee][-+]?[0-9]+)?[fFlL]?"
 	 "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->\\*?|\\.\\*"),
 PATTERNS("csharp",
 	 /* Keywords */
-- 
gitgitgadget


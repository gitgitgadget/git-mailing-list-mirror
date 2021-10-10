Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F12C4332F
	for <git@archiver.kernel.org>; Sun, 10 Oct 2021 17:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E446C60F58
	for <git@archiver.kernel.org>; Sun, 10 Oct 2021 17:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbhJJRFJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Oct 2021 13:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbhJJRFH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Oct 2021 13:05:07 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CB9C061745
        for <git@vger.kernel.org>; Sun, 10 Oct 2021 10:03:08 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id e3so14266837wrc.11
        for <git@vger.kernel.org>; Sun, 10 Oct 2021 10:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bmuO/jMfblS6AyGnS/YriWnEGzghNWl6SYQCUtVvYAM=;
        b=gP8xOFhZ9/BfRn4RKHF0RA4j9jabYwcJHMqRM5bItXHpXQkl13BWsjKqeHY412ypWW
         57H49D/puResBjsh2qV7UZkLXMf7QFdFrTNrHcp3/EY7VDJFZWOrb8LCkcvICK0Lv4OV
         ogjAZQkqqa2LvgVoUjZi8t5w02kjAMc0/rdzQ+VuXumQkMUjE3y8B0rI1BHdeutM9s69
         u4RM+lSOwlhZvwreUUlu/+uYJVs+Mc2kSibxcu5AYwRHgeIg27tRUCy13AjSLEIz+wTb
         E9d2nhKYegvv3urlDzl7/EKY0dIFXzml0lm2Gfn4Dm3gCnYnWDg5XK3M8E268ZQpvhFd
         Oryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bmuO/jMfblS6AyGnS/YriWnEGzghNWl6SYQCUtVvYAM=;
        b=RPZ/wIromNv8AJASXaKq4tgpoLEUj4lYi4QpiomI0hU4iThM1TmnApq9tXZSK4ajWG
         gN95OZsXIjJmY50aYKYhlu2BNKVNe5M4aHHOdVk8eHyK005yqeuQgBI9BkaAgca2AFek
         hTu7PmTSoREXcMkPCboErCefMxi329Meg1eqP3EgeQZrklTfAq0yK+P5XWeUbaRwMhUy
         SiDwgdeUNjIPWTHXvKa8YRSA3lV+ZMN3l2UnbOu1WV9my0hj9JwgQI93Qbcf25nhyxxn
         eOPxivp+b+OZFmE2m6c/L6xlNL4YMnnWZMaskIbzh7cV4XyKrBp45vN12rvbIUA0rlQ2
         Icqw==
X-Gm-Message-State: AOAM531dWvdLYQiw/FgTu7yfKI+5Im+rhv2kKLjcmli6Ct9T60g8JGre
        pOgpziyXj3/nD0haMRKhwH9s/NiVSKY=
X-Google-Smtp-Source: ABdhPJyh5iBMuJIwzZjf5pJdfyKxgJKb2HBqfJghgrfSpp0rlSbEzcdbjKzJO3++dWs+msJE1mH5fA==
X-Received: by 2002:a1c:a401:: with SMTP id n1mr16469255wme.162.1633885386724;
        Sun, 10 Oct 2021 10:03:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t11sm5345651wrz.65.2021.10.10.10.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Oct 2021 10:03:06 -0700 (PDT)
Message-Id: <5a84fc9cf715aec258d9cda2dd7d2e8eff2dc66c.1633885384.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1054.v3.git.1633885384.gitgitgadget@gmail.com>
References: <pull.1054.v2.git.1633720197.gitgitgadget@gmail.com>
        <pull.1054.v3.git.1633885384.gitgitgadget@gmail.com>
From:   "Johannes Sixt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 10 Oct 2021 17:03:00 +0000
Subject: [PATCH v3 2/6] t4034: add tests showing problematic cpp tokenizations
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

The word regex is too loose and matches long streaks of characters
that should actually be separate tokens.  Add these problematic test
cases. Separate the lines with text that will remain identical in the
pre- and post-image so that the diff algorithm will not lump removals
and additions of consecutive lines together. This makes the expected
output easier to read.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t4034/cpp/expect | 22 ++++++++++++++++++----
 t/t4034/cpp/post   | 18 ++++++++++++++++--
 t/t4034/cpp/pre    | 16 +++++++++++++++-
 3 files changed, 49 insertions(+), 7 deletions(-)

diff --git a/t/t4034/cpp/expect b/t/t4034/cpp/expect
index 41976971b93..63e53a61e62 100644
--- a/t/t4034/cpp/expect
+++ b/t/t4034/cpp/expect
@@ -1,11 +1,25 @@
 <BOLD>diff --git a/pre b/post<RESET>
-<BOLD>index c5672a2..4229868 100644<RESET>
+<BOLD>index 1229cdb..3feae6f 100644<RESET>
 <BOLD>--- a/pre<RESET>
 <BOLD>+++ b/post<RESET>
-<CYAN>@@ -1,16 +1,16 @@<RESET>
-Foo() : x(0<RED>&&1<RESET><GREEN>&42<RESET>) { <GREEN>bar(x);<RESET> }
+<CYAN>@@ -1,30 +1,30 @@<RESET>
+Foo() : x(0<RED>&&1<RESET><GREEN>&42<RESET>) { <RED>foo0<RESET><GREEN>bar<RESET>(x<RED>.f<RESET><GREEN>.F<RESET>ind); }
 cout<<"Hello World<RED>!<RESET><GREEN>?<RESET>\n"<<endl;
-<GREEN>(<RESET>1<GREEN>) (<RESET>-1e10<GREEN>) (<RESET>0xabcdef<GREEN>)<RESET> '<RED>x<RESET><GREEN>y<RESET>'
+<GREEN>(<RESET>1 <RED>-1e10<RESET><GREEN>+1e10<RESET> 0xabcdef<GREEN>)<RESET> '<RED>x<RESET><GREEN>y<RESET>'
+// long double<RESET>
+<RED>3.141592653e-10l<RESET><GREEN>3.141592654e+10l<RESET>
+// float<RESET>
+120<RED>E5f<RESET><GREEN>E6f<RESET>
+// hex<RESET>
+<RED>0xdeadbeaf+8<RESET><GREEN>0xdeadBeaf+7<RESET>ULL
+// octal<RESET>
+<RED>01234567<RESET><GREEN>01234560<RESET>
+// binary<RESET>
+<RED>0b1000<RESET><GREEN>0b1100<RESET>+e1
+// expression<RESET>
+<RED>1.5-e+2+f<RESET><GREEN>1.5-e+3+f<RESET>
+// another one<RESET>
+str<RED>.e+65<RESET><GREEN>.e+75<RESET>
 [a] b<RED>-><RESET><GREEN>->*<RESET>v d<RED>.e<RESET><GREEN>.*e<RESET>
 <GREEN>~<RESET>!a <GREEN>!<RESET>~b c<RED>++<RESET><GREEN>+<RESET> d<RED>--<RESET><GREEN>-<RESET> e*<GREEN>*<RESET>f g<RED>&<RESET><GREEN>&&<RESET>h
 a<RED>*<RESET><GREEN>*=<RESET>b c<RED>/<RESET><GREEN>/=<RESET>d e<RED>%<RESET><GREEN>%=<RESET>f
diff --git a/t/t4034/cpp/post b/t/t4034/cpp/post
index 4229868ae62..3feae6f430f 100644
--- a/t/t4034/cpp/post
+++ b/t/t4034/cpp/post
@@ -1,6 +1,20 @@
-Foo() : x(0&42) { bar(x); }
+Foo() : x(0&42) { bar(x.Find); }
 cout<<"Hello World?\n"<<endl;
-(1) (-1e10) (0xabcdef) 'y'
+(1 +1e10 0xabcdef) 'y'
+// long double
+3.141592654e+10l
+// float
+120E6f
+// hex
+0xdeadBeaf+7ULL
+// octal
+01234560
+// binary
+0b1100+e1
+// expression
+1.5-e+3+f
+// another one
+str.e+75
 [a] b->*v d.*e
 ~!a !~b c+ d- e**f g&&h
 a*=b c/=d e%=f
diff --git a/t/t4034/cpp/pre b/t/t4034/cpp/pre
index c5672a24cfc..1229cdb59d1 100644
--- a/t/t4034/cpp/pre
+++ b/t/t4034/cpp/pre
@@ -1,6 +1,20 @@
-Foo():x(0&&1){}
+Foo():x(0&&1){ foo0( x.find); }
 cout<<"Hello World!\n"<<endl;
 1 -1e10 0xabcdef 'x'
+// long double
+3.141592653e-10l
+// float
+120E5f
+// hex
+0xdeadbeaf+8ULL
+// octal
+01234567
+// binary
+0b1000+e1
+// expression
+1.5-e+2+f
+// another one
+str.e+65
 [a] b->v d.e
 !a ~b c++ d-- e*f g&h
 a*b c/d e%f
-- 
gitgitgadget


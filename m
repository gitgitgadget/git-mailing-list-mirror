Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1608BC433F5
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 19:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1A5960F6E
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 19:10:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240925AbhJHTL5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 15:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbhJHTLz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 15:11:55 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5FCBC061755
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 12:09:59 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id r10so32684030wra.12
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 12:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yYJ/b49QpJ4fkZtCd4pL6lc0TKalwVrQgk6O0OkTjwk=;
        b=EJaMAC4RmuO7BXahBO/W85F7+zUXg04UZrZ1i70fkYVAGlewDeMlOpfpFtKTSCyROn
         T5blLShKALFnHym3LvMLNsc/pc/V2e2Z8ya0vipGmqyb5lGxWQlBI1hxtC83isvSJfbA
         Vh6/ImvqoasNn8uMKDKrrVcwbmd2NEFKayMPQpzYKqkKJrqSm3u2BlwBZOz9U8ulW3su
         RI2bJUBMXqj2ntLC3bCu/JGTDYGhDCbKaiEnt89CmZOHCgwgfePGphlAtDozBLMc0rZ2
         qrTWIPRwQkHC16sISdTn7HXi+oigNrdeo871YtzYQzxjL7jdBAs7TQyMWaInBwJspLvv
         FwSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yYJ/b49QpJ4fkZtCd4pL6lc0TKalwVrQgk6O0OkTjwk=;
        b=YysG6lNs5zFq+fjRak/9eiPh1JdXYgvyqil9LsmxnyGetTsSV5Xockn8ILEYMSGBfD
         k3UmgYYvMoLEsysnpE2Y4LJJEs4xOBze2mV7guPziq25TnIXGu5NWExhWckyyB78pbUC
         PmSXL60/SdJ2CvMi6MsqJjvxxpvn7mNXa9vw/MG/b51WvbRyTJWYb5g3o1WU85Iuit6r
         HYT5WKlVf1T0AOuefs6sm8OASZXZdIeNEBBAvxaK4JmxcVprun0IXd2M2bp+hYxD4Yno
         +BD0ubUS3D1yIcKG23doenzyPVtXSENXp29b2kLAtWwrsqevmXXXithLUArUx4KkRers
         bgFQ==
X-Gm-Message-State: AOAM532yTJ/qHdH9yof937bA8VLFpuxqbvIsQZ52vD5L+A6vUt60lKoC
        d4MWgdK/Ux4FyzE196qp/TjKI5eqBCk=
X-Google-Smtp-Source: ABdhPJwvQCXgjSFHhNqt6UoVMFoJ3OZXrziHxn8PB+jjy5jG3BKluQClLhnF0VjB0xgIQe/5AGBgxA==
X-Received: by 2002:adf:b34c:: with SMTP id k12mr6174947wrd.1.1633720198441;
        Fri, 08 Oct 2021 12:09:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d16sm12076090wmb.2.2021.10.08.12.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 12:09:58 -0700 (PDT)
Message-Id: <dd9f82ba712f54245f19df95926050543d25b769.1633720197.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1054.v2.git.1633720197.gitgitgadget@gmail.com>
References: <pull.1054.git.1633589461.gitgitgadget@gmail.com>
        <pull.1054.v2.git.1633720197.gitgitgadget@gmail.com>
From:   "Johannes Sixt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 08 Oct 2021 19:09:53 +0000
Subject: [PATCH v2 1/5] t4034/cpp: actually test that operator tokens are not
 split
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

8d96e7288f2b (t4034: bulk verify builtin word regex sanity, 2010-12-18)
added many tests with the intent to verify that operators consisting of
more than one symbol are kept together. These are tested by probing a
transition from, e.g., a!=b to x!=y, which results in the word-diff

  [-a-]{+x+}!=[-b-]{+y+}

But that proves only that the letters and operators are separate tokens.
To prove that != is an unseparable token, we have to probe a transition
from, e.g., a=b to a!=b having a word-diff

  a[-=-]{+!=+}b

that proves that the ! is not separate from the =.

In the post-image, add to or remove from operators a character that
turns it into another valid operator.

Change the identifiers used around operators such that the diff
algorithm does not have an incentive to match, e.g., a<b in one spot
in the pre-image with a<b elsewhere in the post-image.

Adjust the expected output to match the new differences. Notice that
there are some undesirable tokenizations around e, ., and -.  This will
be addressed in a later change.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t4034/cpp/expect | 45 +++++++++++++++------------------------------
 t/t4034/cpp/post   | 29 +++++++++++++----------------
 t/t4034/cpp/pre    | 25 +++++++++++--------------
 3 files changed, 39 insertions(+), 60 deletions(-)

diff --git a/t/t4034/cpp/expect b/t/t4034/cpp/expect
index 37d1ea25870..41976971b93 100644
--- a/t/t4034/cpp/expect
+++ b/t/t4034/cpp/expect
@@ -1,36 +1,21 @@
 <BOLD>diff --git a/pre b/post<RESET>
-<BOLD>index 23d5c8a..7e8c026 100644<RESET>
+<BOLD>index c5672a2..4229868 100644<RESET>
 <BOLD>--- a/pre<RESET>
 <BOLD>+++ b/post<RESET>
-<CYAN>@@ -1,19 +1,19 @@<RESET>
+<CYAN>@@ -1,16 +1,16 @@<RESET>
 Foo() : x(0<RED>&&1<RESET><GREEN>&42<RESET>) { <GREEN>bar(x);<RESET> }
 cout<<"Hello World<RED>!<RESET><GREEN>?<RESET>\n"<<endl;
 <GREEN>(<RESET>1<GREEN>) (<RESET>-1e10<GREEN>) (<RESET>0xabcdef<GREEN>)<RESET> '<RED>x<RESET><GREEN>y<RESET>'
-[<RED>a<RESET><GREEN>x<RESET>] <RED>a<RESET><GREEN>x<RESET>-><RED>b a<RESET><GREEN>y x<RESET>.<RED>b<RESET><GREEN>y<RESET>
-!<RED>a<RESET><GREEN>x<RESET> ~<RED>a a<RESET><GREEN>x x<RESET>++ <RED>a<RESET><GREEN>x<RESET>-- <RED>a<RESET><GREEN>x<RESET>*<RED>b a<RESET><GREEN>y x<RESET>&<RED>b<RESET>
-<RED>a<RESET><GREEN>y<RESET>
-<GREEN>x<RESET>*<RED>b a<RESET><GREEN>y x<RESET>/<RED>b a<RESET><GREEN>y x<RESET>%<RED>b<RESET>
-<RED>a<RESET><GREEN>y<RESET>
-<GREEN>x<RESET>+<RED>b a<RESET><GREEN>y x<RESET>-<RED>b<RESET>
-<RED>a<RESET><GREEN>y<RESET>
-<GREEN>x<RESET><<<RED>b a<RESET><GREEN>y x<RESET>>><RED>b<RESET>
-<RED>a<RESET><GREEN>y<RESET>
-<GREEN>x<RESET><<RED>b a<RESET><GREEN>y x<RESET><=<RED>b a<RESET><GREEN>y x<RESET>><RED>b a<RESET><GREEN>y x<RESET>>=<RED>b<RESET>
-<RED>a<RESET><GREEN>y<RESET>
-<GREEN>x<RESET>==<RED>b a<RESET><GREEN>y x<RESET>!=<RED>b<RESET>
-<RED>a<RESET><GREEN>y<RESET>
-<GREEN>x<RESET>&<RED>b<RESET>
-<RED>a<RESET><GREEN>y<RESET>
-<GREEN>x<RESET>^<RED>b<RESET>
-<RED>a<RESET><GREEN>y<RESET>
-<GREEN>x<RESET>|<RED>b<RESET>
-<RED>a<RESET><GREEN>y<RESET>
-<GREEN>x<RESET>&&<RED>b<RESET>
-<RED>a<RESET><GREEN>y<RESET>
-<GREEN>x<RESET>||<RED>b<RESET>
-<RED>a<RESET><GREEN>y<RESET>
-<GREEN>x<RESET>?<RED>b<RESET><GREEN>y<RESET>:z
-<RED>a<RESET><GREEN>x<RESET>=<RED>b a<RESET><GREEN>y x<RESET>+=<RED>b a<RESET><GREEN>y x<RESET>-=<RED>b a<RESET><GREEN>y x<RESET>*=<RED>b a<RESET><GREEN>y x<RESET>/=<RED>b a<RESET><GREEN>y x<RESET>%=<RED>b a<RESET><GREEN>y x<RESET><<=<RED>b a<RESET><GREEN>y x<RESET>>>=<RED>b a<RESET><GREEN>y x<RESET>&=<RED>b a<RESET><GREEN>y x<RESET>^=<RED>b a<RESET><GREEN>y x<RESET>|=<RED>b<RESET>
-<RED>a<RESET><GREEN>y<RESET>
-<GREEN>x<RESET>,y
-<RED>a<RESET><GREEN>x<RESET>::<RED>b<RESET><GREEN>y<RESET>
+[a] b<RED>-><RESET><GREEN>->*<RESET>v d<RED>.e<RESET><GREEN>.*e<RESET>
+<GREEN>~<RESET>!a <GREEN>!<RESET>~b c<RED>++<RESET><GREEN>+<RESET> d<RED>--<RESET><GREEN>-<RESET> e*<GREEN>*<RESET>f g<RED>&<RESET><GREEN>&&<RESET>h
+a<RED>*<RESET><GREEN>*=<RESET>b c<RED>/<RESET><GREEN>/=<RESET>d e<RED>%<RESET><GREEN>%=<RESET>f
+a<RED>+<RESET><GREEN>++<RESET>b c<RED>-<RESET><GREEN>--<RESET>d
+a<RED><<<RESET><GREEN><<=<RESET>b c<RED>>><RESET><GREEN>>>=<RESET>d
+a<RED><<RESET><GREEN><=<RESET>b c<RED><=<RESET><GREEN><<RESET>d e<RED>><RESET><GREEN>>=<RESET>f g<RED>>=<RESET><GREEN>><RESET>h
+a<RED>==<RESET><GREEN>!=<RESET>b c<RED>!=<RESET><GREEN>=<RESET>d
+a<RED>^<RESET><GREEN>^=<RESET>b c<RED>|<RESET><GREEN>|=<RESET>d e<RED>&&<RESET><GREEN>&=<RESET>f
+a<RED>||<RESET><GREEN>|<RESET>b
+a?<GREEN>:<RESET>b
+a<RED>=<RESET><GREEN>==<RESET>b c<RED>+=<RESET><GREEN>+<RESET>d <RED>e-=f<RESET><GREEN>e-f<RESET> g<RED>*=<RESET><GREEN>*<RESET>h i<RED>/=<RESET><GREEN>/<RESET>j k<RED>%=<RESET><GREEN>%<RESET>l m<RED><<=<RESET><GREEN><<<RESET>n o<RED>>>=<RESET><GREEN>>><RESET>p q<RED>&=<RESET><GREEN>&<RESET>r s<RED>^=<RESET><GREEN>^<RESET>t u<RED>|=<RESET><GREEN>|<RESET>v
+a,b<RESET>
+a<RED>::<RESET><GREEN>:<RESET>b
diff --git a/t/t4034/cpp/post b/t/t4034/cpp/post
index 7e8c026cefb..4229868ae62 100644
--- a/t/t4034/cpp/post
+++ b/t/t4034/cpp/post
@@ -1,19 +1,16 @@
 Foo() : x(0&42) { bar(x); }
 cout<<"Hello World?\n"<<endl;
 (1) (-1e10) (0xabcdef) 'y'
-[x] x->y x.y
-!x ~x x++ x-- x*y x&y
-x*y x/y x%y
-x+y x-y
-x<<y x>>y
-x<y x<=y x>y x>=y
-x==y x!=y
-x&y
-x^y
-x|y
-x&&y
-x||y
-x?y:z
-x=y x+=y x-=y x*=y x/=y x%=y x<<=y x>>=y x&=y x^=y x|=y
-x,y
-x::y
+[a] b->*v d.*e
+~!a !~b c+ d- e**f g&&h
+a*=b c/=d e%=f
+a++b c--d
+a<<=b c>>=d
+a<=b c<d e>=f g>h
+a!=b c=d
+a^=b c|=d e&=f
+a|b
+a?:b
+a==b c+d e-f g*h i/j k%l m<<n o>>p q&r s^t u|v
+a,b
+a:b
diff --git a/t/t4034/cpp/pre b/t/t4034/cpp/pre
index 23d5c8adf54..c5672a24cfc 100644
--- a/t/t4034/cpp/pre
+++ b/t/t4034/cpp/pre
@@ -1,19 +1,16 @@
 Foo():x(0&&1){}
 cout<<"Hello World!\n"<<endl;
 1 -1e10 0xabcdef 'x'
-[a] a->b a.b
-!a ~a a++ a-- a*b a&b
-a*b a/b a%b
-a+b a-b
-a<<b a>>b
-a<b a<=b a>b a>=b
-a==b a!=b
-a&b
-a^b
-a|b
-a&&b
+[a] b->v d.e
+!a ~b c++ d-- e*f g&h
+a*b c/d e%f
+a+b c-d
+a<<b c>>d
+a<b c<=d e>f g>=h
+a==b c!=d
+a^b c|d e&&f
 a||b
-a?b:z
-a=b a+=b a-=b a*=b a/=b a%=b a<<=b a>>=b a&=b a^=b a|=b
-a,y
+a?b
+a=b c+=d e-=f g*=h i/=j k%=l m<<=n o>>=p q&=r s^=t u|=v
+a,b
 a::b
-- 
gitgitgadget


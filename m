Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 559381F403
	for <e@80x24.org>; Fri, 15 Jun 2018 02:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936115AbeFOCZx (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 22:25:53 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:51327 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936111AbeFOCZw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 22:25:52 -0400
Received: by mail-it0-f67.google.com with SMTP id n7-v6so918171itn.1
        for <git@vger.kernel.org>; Thu, 14 Jun 2018 19:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=S1tob50tkUqkIj4xkVrEt0bmcMtPS60/biXp6wLmSsQ=;
        b=fwokO9n/z/7pbbnQAP6FCjFSUPMBJmEjParJysb+ZIbVs6wh/uNBwqEL2X1fDWQ719
         TASSE/+Un71zHuDk7XAl/pOzMkAT99ZJdPqgI9uyr+eUfWZwuazTOuNPG0+32m1mPq8H
         c2e+g3jCmejiZTQ05SEFKq3VV+pDw8q6DMVwYYnbN2P2TwREUAVTYfh5s1kYV/YL6xMY
         FkOKv9hQCf+OtMrMpeGtfF1E9GDvESOhKbAZclwIE1Xf9kxSrxtdfWpS+O0uN/OdGxB+
         Ate2L3ezHta7Ov8opHXCSk8Q66Xm+J05bzwciUn0APqflciaojpweJipgNhlvRBGRFhu
         JC1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=S1tob50tkUqkIj4xkVrEt0bmcMtPS60/biXp6wLmSsQ=;
        b=Uu6v/bFwtKyKsLLANZRjkm+hxaq/75lg398SPKIRTvYFmGEnESX+68b6qQ/NJznZbl
         Pg6mYHOuIV7kz+xloGLkjVP4vvlXUhRO22Er/x6bhbbWvWhMYcrR3+XCkGqKEH+aflFt
         Oinm0TVI+9mvrsYcx4d/TYpSwS/B8dUl0hQC9+eQ+i9CDQ33HEWYsnHd0AOkEZ3nnVyr
         Kf0ODn15t8KPRFm6+t2igCRYD5/3Mff5cXlmjfF5MLwPlq3SVDPpQVDMkj3PE3TphzOR
         1VCkSNKrOLokY2ACvlu/KBZWr0QDqVysfQzyaFvJLek+XoAVTelftVq80fs9D/mTHWOP
         RQEg==
X-Gm-Message-State: APt69E1kbTjxoB2QkW4a+u9Si1QiWGj6T510pqPI4ulXJfITWWVZigtA
        xDYRGs1ttlnxgKp/ICYWG+ySIg==
X-Google-Smtp-Source: ADUXVKLgTLvite4JX2IYWLSDCUUDEIE7HCuzojaSDTjyPLjh3cZ9eSO+x2zReGOTL6bAbWyY9Hc8Jw==
X-Received: by 2002:a24:1643:: with SMTP id a64-v6mr119900ita.101.1529029551233;
        Thu, 14 Jun 2018 19:25:51 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id 62-v6sm334166ity.37.2018.06.14.19.25.49
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 14 Jun 2018 19:25:50 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Mahmoud Al-Qudsi <mqudsi@neosmart.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] Makefile: make NO_ICONV really mean "no iconv"
Date:   Thu, 14 Jun 2018 22:25:03 -0400
Message-Id: <20180615022503.34111-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.rc1.256.g331a1db143
In-Reply-To: <CACcTrKePbgyCbXneN5NZ+cS-tiDyYe_dkdwttXpP0CUeEicvHw@mail.gmail.com>
References: <CACcTrKePbgyCbXneN5NZ+cS-tiDyYe_dkdwttXpP0CUeEicvHw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The Makefile tweak NO_ICONV is meant to allow Git to be built without
iconv in case iconv is not installed or is otherwise dysfunctional.
However, NO_ICONV's disabling of iconv is incomplete and can incorrectly
allow "-liconv" to slip into the linker flags when NEEDS_LIBICONV is
defined, which breaks the build when iconv is not installed.

On some platforms, iconv lives directly in libc, whereas, on others it
resides in libiconv. For the latter case, NEEDS_LIBICONV instructs the
Makefile to add "-liconv" to the linker flags. config.mak.uname
automatically defines NEEDS_LIBICONV for platforms which require it.
The adding of "-liconv" is done unconditionally, despite NO_ICONV.

Work around this problem by making NO_ICONV take precedence over
NEEDS_LIBICONV.

Reported by: Mahmoud Al-Qudsi <mqudsi@neosmart.net>
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

This patch is extra noisy due to the indentation change. Viewing it with
"git diff -w" helps. An alternative to re-indenting would have been to
"undefine NEEDS_LIBICONV", however, 'undefine' was added to GNU make in
3.82 but MacOS is stuck on 3.81 (from 2006) so 'undefine' was avoided.

Reported here: https://public-inbox.org/git/CACcTrKePbgyCbXneN5NZ+cS-tiDyYe_dkdwttXpP0CUeEicvHw@mail.gmail.com/T/#u

 Makefile | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/Makefile b/Makefile
index 1d27f36365..e4b503d259 100644
--- a/Makefile
+++ b/Makefile
@@ -1351,17 +1351,19 @@ ifdef APPLE_COMMON_CRYPTO
 	LIB_4_CRYPTO += -framework Security -framework CoreFoundation
 endif
 endif
-ifdef NEEDS_LIBICONV
-	ifdef ICONVDIR
-		BASIC_CFLAGS += -I$(ICONVDIR)/include
-		ICONV_LINK = -L$(ICONVDIR)/$(lib) $(CC_LD_DYNPATH)$(ICONVDIR)/$(lib)
-	else
-		ICONV_LINK =
-	endif
-	ifdef NEEDS_LIBINTL_BEFORE_LIBICONV
-		ICONV_LINK += -lintl
+ifndef NO_ICONV
+	ifdef NEEDS_LIBICONV
+		ifdef ICONVDIR
+			BASIC_CFLAGS += -I$(ICONVDIR)/include
+			ICONV_LINK = -L$(ICONVDIR)/$(lib) $(CC_LD_DYNPATH)$(ICONVDIR)/$(lib)
+		else
+			ICONV_LINK =
+		endif
+		ifdef NEEDS_LIBINTL_BEFORE_LIBICONV
+			ICONV_LINK += -lintl
+		endif
+		EXTLIBS += $(ICONV_LINK) -liconv
 	endif
-	EXTLIBS += $(ICONV_LINK) -liconv
 endif
 ifdef NEEDS_LIBGEN
 	EXTLIBS += -lgen
-- 
2.18.0.rc1.256.g331a1db143


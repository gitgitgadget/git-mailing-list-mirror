Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65FD6C433FE
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 17:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43C0A610D2
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 17:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350181AbhICRED (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Sep 2021 13:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235624AbhICRED (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Sep 2021 13:04:03 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA682C061575
        for <git@vger.kernel.org>; Fri,  3 Sep 2021 10:03:02 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id m7-20020a9d4c87000000b0051875f56b95so7284211otf.6
        for <git@vger.kernel.org>; Fri, 03 Sep 2021 10:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U2RAw6YkrtnMbfxWPEZBfNg02zjo5VLP8wokrre+VEs=;
        b=FRLfiy5Xc0D5gAPoiz+3RO6uV1idlPTKZ/ALVPvJhkg6Vh6AyKjCLXe8tkZ5rhPtP7
         T9J7UHmMmdSMJ+6r1cj1WqGWC2q6R6v/dL02+8NX6bhJEfCy1N2TecDN6koSr+GH9ZAM
         qXC9fKjxpFZ7cXQBmy1etMV0h0OiMO8xAuVLqwmoc16fwmLix5gkI1ZGmmC5ddd5emaK
         u+SmHXfP1cYZjlP4Ut2QUauYd3O+sOffbUSlntgPYubQZbw/FxRGNgCPB6xvNLhgOHd6
         v87sq540mTWCJisH7Ti48KMDh6gh2vPjy4BT/ORKMz6jeQ/IpZTYr2f3fRchLdXu1xYy
         o/2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U2RAw6YkrtnMbfxWPEZBfNg02zjo5VLP8wokrre+VEs=;
        b=LG5bdMQKJk+bwYyRTpRnxmd+vei3UP/cPyBKnmW+G2t3cHHdT68tIu9rG5vt637Yeq
         1SJnE89ffcEyaCi8FNvzc4gEo+idUO7uU5eb4c1N4GPqx37kw/WO4qYKmBmuowrmT0rn
         mIWw+fSfqIcWQ/KqP9Txuny6t65ZZRt6sYdmijAK1+dzbml5GBdkktictyMnaW8P9TLu
         7yxRxCVLG7uXn3LWfLNjrP4m6P12xKGHZYWl6WlW9i6/d8MpkqPxm3DXx5gvZHDYhw3p
         sQy1H8sPlBg7SPPipDIyfoGj6A1mkhzVKlkwI8icPlOL2E7wUNFaf4Ek5mW5jUhPFCU+
         ix9w==
X-Gm-Message-State: AOAM5334JteRbq8RHOdMZy4/xp8OUdfKCz494bNPRAbFyZGlgVfLfM4A
        LT5g7VMwVH4YcdLvBncnYlpDtlsFIzU=
X-Google-Smtp-Source: ABdhPJzU9lvt4XCN7eMMVPQeMjd9MJJkbq9dYQj836cQ3vfLutv5qeQ69oaWwt26Q2kgBQY4tfHTQQ==
X-Received: by 2002:a9d:3ae:: with SMTP id f43mr21859otf.171.1630688581974;
        Fri, 03 Sep 2021 10:03:01 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id bf6sm1124044oib.0.2021.09.03.10.03.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Sep 2021 10:03:01 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, phillip.wood@dunelm.org.uk,
        sunshine@sunshineco.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v3 1/3] gettext: remove optional non-standard parens in N_() definition
Date:   Fri,  3 Sep 2021 10:02:30 -0700
Message-Id: <20210903170232.57646-2-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.481.g26d3bed244
In-Reply-To: <20210903170232.57646-1-carenas@gmail.com>
References: <20210901091941.34886-1-carenas@gmail.com>
 <20210903170232.57646-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

Remove the USE_PARENS_AROUND_GETTEXT_N compile-time option which was
meant to catch an inadvertent mistake which is too obscure to
maintain this facility.

The backstory of how USE_PARENS_AROUND_GETTEXT_N came about is: When I
added the N_() macro in 65784830366 (i18n: add no-op _() and N_()
wrappers, 2011-02-22) it was defined as:

    #define N_(msgid) (msgid)

This is non-standard C, as was noticed and fixed in 642f85faab2 (i18n:
avoid parenthesized string as array initializer, 2011-04-07).
I.e. this needed to be defined as:

    #define N_(msgid) msgid

Then in e62cd35a3e8 (i18n: log: mark parseopt strings for translation,
2012-08-20) when "builtin_log_usage" was marked for translation the
string concatenation for passing to usage() added in 1c370ea4e51
(Show usage string for 'git log -h', 'git show -h' and 'git diff -h',
2009-08-06) was faithfully preserved:

-       "git log [<options>] [<since>..<until>] [[--] <path>...]\n"
-       "   or: git show [options] <object>...",
+       N_("git log [<options>] [<since>..<until>] [[--] <path>...]\n")
+       N_("   or: git show [options] <object>..."),

This was then fixed to be the expected array of usage strings in
e66dc0cc4b1 (log.c: fix translation markings, 2015-01-06) rather than
a string with multiple "\n"-delimited usage strings, and finally in
290c8e7a3fe (gettext.h: add parentheses around N_ expansion if
supported, 2015-01-11) USE_PARENS_AROUND_GETTEXT_N was added to ensure
this mistake didn't happen again.

I think that even if this was a N_()-specific issue this
USE_PARENS_AROUND_GETTEXT_N facility wouldn't be worth it, the issue
would be too rare to worry about.

But I also think that 290c8e7a3fe which introduced
USE_PARENS_AROUND_GETTEXT_N misattributed the problem. The issue
wasn't with the N_() macro added in e62cd35a3e8, but that before the
N_() macro existed in the codebase the initial migration to
parse_options() in 1c370ea4e51 continued passsing in a "\n"-delimited
string, when the new API it was migrating to supported and expected
the passing of an array.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 Makefile          | 20 +-------------------
 config.mak.dev    |  2 --
 gettext.h         | 24 ------------------------
 git-compat-util.h |  4 ----
 4 files changed, 1 insertion(+), 49 deletions(-)

diff --git a/Makefile b/Makefile
index 9573190f1d..4e94073c2a 100644
--- a/Makefile
+++ b/Makefile
@@ -409,15 +409,6 @@ all::
 # Define NEEDS_LIBRT if your platform requires linking with librt (glibc version
 # before 2.17) for clock_gettime and CLOCK_MONOTONIC.
 #
-# Define USE_PARENS_AROUND_GETTEXT_N to "yes" if your compiler happily
-# compiles the following initialization:
-#
-#   static const char s[] = ("FOO");
-#
-# and define it to "no" if you need to remove the parentheses () around the
-# constant.  The default is "auto", which means to use parentheses if your
-# compiler is detected to support it.
-#
 # Define HAVE_BSD_SYSCTL if your platform has a BSD-compatible sysctl function.
 #
 # Define HAVE_GETDELIM if your system has the getdelim() function.
@@ -497,8 +488,7 @@ all::
 #
 #    pedantic:
 #
-#        Enable -pedantic compilation. This also disables
-#        USE_PARENS_AROUND_GETTEXT_N to produce only relevant warnings.
+#        Enable -pedantic compilation.
 
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -1347,14 +1337,6 @@ ifneq (,$(SOCKLEN_T))
 	BASIC_CFLAGS += -Dsocklen_t=$(SOCKLEN_T)
 endif
 
-ifeq (yes,$(USE_PARENS_AROUND_GETTEXT_N))
-	BASIC_CFLAGS += -DUSE_PARENS_AROUND_GETTEXT_N=1
-else
-ifeq (no,$(USE_PARENS_AROUND_GETTEXT_N))
-	BASIC_CFLAGS += -DUSE_PARENS_AROUND_GETTEXT_N=0
-endif
-endif
-
 ifeq ($(uname_S),Darwin)
 	ifndef NO_FINK
 		ifeq ($(shell test -d /sw/lib && echo y),y)
diff --git a/config.mak.dev b/config.mak.dev
index 022fb58218..41d6345bc0 100644
--- a/config.mak.dev
+++ b/config.mak.dev
@@ -4,8 +4,6 @@ SPARSE_FLAGS += -Wsparse-error
 endif
 ifneq ($(filter pedantic,$(DEVOPTS)),)
 DEVELOPER_CFLAGS += -pedantic
-# don't warn for each N_ use
-DEVELOPER_CFLAGS += -DUSE_PARENS_AROUND_GETTEXT_N=0
 endif
 DEVELOPER_CFLAGS += -Wall
 DEVELOPER_CFLAGS += -Wdeclaration-after-statement
diff --git a/gettext.h b/gettext.h
index c8b34fd612..d209911ebb 100644
--- a/gettext.h
+++ b/gettext.h
@@ -55,31 +55,7 @@ const char *Q_(const char *msgid, const char *plu, unsigned long n)
 }
 
 /* Mark msgid for translation but do not translate it. */
-#if !USE_PARENS_AROUND_GETTEXT_N
 #define N_(msgid) msgid
-#else
-/*
- * Strictly speaking, this will lead to invalid C when
- * used this way:
- *	static const char s[] = N_("FOO");
- * which will expand to
- *	static const char s[] = ("FOO");
- * and in valid C, the initializer on the right hand side must
- * be without the parentheses.  But many compilers do accept it
- * as a language extension and it will allow us to catch mistakes
- * like:
- *	static const char *msgs[] = {
- *		N_("one")
- *		N_("two"),
- *		N_("three"),
- *		NULL
- *	};
- * (notice the missing comma on one of the lines) by forcing
- * a compilation error, because parenthesised ("one") ("two")
- * will not get silently turned into ("onetwo").
- */
-#define N_(msgid) (msgid)
-#endif
 
 const char *get_preferred_languages(void);
 int is_utf8_locale(void);
diff --git a/git-compat-util.h b/git-compat-util.h
index b46605300a..ddc65ff61d 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1253,10 +1253,6 @@ int warn_on_fopen_errors(const char *path);
  */
 int open_nofollow(const char *path, int flags);
 
-#if !defined(USE_PARENS_AROUND_GETTEXT_N) && defined(__GNUC__)
-#define USE_PARENS_AROUND_GETTEXT_N 1
-#endif
-
 #ifndef SHELL_PATH
 # define SHELL_PATH "/bin/sh"
 #endif
-- 
2.33.0.481.g26d3bed244


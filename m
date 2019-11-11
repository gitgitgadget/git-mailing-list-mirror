Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12CB71F454
	for <e@80x24.org>; Mon, 11 Nov 2019 06:04:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfKKGEP (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 01:04:15 -0500
Received: from mail-pl1-f170.google.com ([209.85.214.170]:40125 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfKKGEO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 01:04:14 -0500
Received: by mail-pl1-f170.google.com with SMTP id e3so7348268plt.7
        for <git@vger.kernel.org>; Sun, 10 Nov 2019 22:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x/9CxKPMkhl6lFlEZLC/5qUhyhb5TD1zXDD3Y9+mam0=;
        b=iR4ZmyloPtf5GtBE1p5MiKwHW15inaQxWekktVmJiwX1/7udA0y0DYd+pVXlMcVwub
         9QJljuMzy1XM+io/XL5JwfZK4EPb/gD4+ZyMXKriGNyjfZ8vop5X7+tKsYRfY5H0uyue
         IdiHbqu8/3ua614QuQ5ZntozFp22NlrTB9ZuAKnuUjIfkaJCvZT9yOYK4gUMVSt8INSZ
         yd3mbGtgp0ATF0zoI5aS/EsGLIt0+I9hJX9qNE+f5SHYB1a2TYtDNWOFzDc0i+fbiAUZ
         SQerj4FxGe5GhgXKrX/D/Ysd1jmh8WL7V11OxtigpPSS7+/+0zMPyy3X4UcGgjdijxBs
         wLuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x/9CxKPMkhl6lFlEZLC/5qUhyhb5TD1zXDD3Y9+mam0=;
        b=KrorUcF7b58wkOrG8QBHvuYrMa323ns3PmZDwQ3fYFl5EPwzBs8Be/4qKzqAsh3VGt
         Wn8STSijiW42IER1POXIyxv5DecH+biykYAupUzIcjTWuDQ4YhRqntXiAXdtqZYCf5L/
         SnVtYoEOGQTpfELaditC/GmZBH7LtjLDtOP1io7TdqtOkAkmU7nUBCuBOtJDopcPw+TP
         P09tCe4Dvt4MM1YA3IPj9Qch4AyeIjh56svAY7cGQGgMpTqIDePZfVxsbIVWHcNW9sh+
         7kB2tYHm33E1zTI9U61IRRceLUA+qit3Fp6/q8L8vdirpy9zHZ8XNtXoDUIZ+3E8i7ic
         SfFA==
X-Gm-Message-State: APjAAAVUoch9awDPNeH1l9UAf/xA1Sxr/BQqtedwoV73Svf7yZEZi5rQ
        nMweLfvUvN5HbzsF++K0bieuqqVa
X-Google-Smtp-Source: APXvYqxaStJvGSGXqy+8JNF9pa0Zcjqq+tuWC7VhVZ7kFQ1AbR2O2jojjLFyKNbc/V8fSRSXKWNe+A==
X-Received: by 2002:a17:902:b218:: with SMTP id t24mr24357649plr.267.1573452253724;
        Sun, 10 Nov 2019 22:04:13 -0800 (PST)
Received: from localhost.localdomain ([2402:800:6375:16b7:502d:9b82:436:143a])
        by smtp.gmail.com with ESMTPSA id v16sm15112315pje.1.2019.11.10.22.04.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Nov 2019 22:04:13 -0800 (PST)
From:   Doan Tran Cong Danh <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com,
        Doan Tran Cong Danh <congdanhqx@gmail.com>
Subject: [PATCH v6 2/9] configure.ac: define ICONV_OMITS_BOM if necessary
Date:   Mon, 11 Nov 2019 13:03:35 +0700
Message-Id: <a9adb3d061e9c28c08d7fbcea765dcfd44028efd.1573452046.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.24.0.164.g78daf050de.dirty
In-Reply-To: <cover.1573452046.git.congdanhqx@gmail.com>
References: <20191031092618.29073-1-congdanhqx@gmail.com> <cover.1573452046.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From commit 79444c9294, ("utf8: handle systems that don't write BOM for
UTF-16", 2019-02-12), we're supporting those systems with iconv that
omits BOM with:

    make ICONV_OMITS_BOM=Yes

However, configure script wasn't taught to detect those systems.

Teach configure to do so.

Signed-off-by: Doan Tran Cong Danh <congdanhqx@gmail.com>
---
 configure.ac | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/configure.ac b/configure.ac
index a43b476402..ecba7e6e51 100644
--- a/configure.ac
+++ b/configure.ac
@@ -844,12 +844,61 @@ AC_MSG_CHECKING([for old iconv()])
 AC_COMPILE_IFELSE([OLDICONVTEST_SRC],
 	[AC_MSG_RESULT([no])],
 	[AC_MSG_RESULT([yes])
+	AC_DEFINE(HAVE_OLD_ICONV, 1)
 	OLD_ICONV=UnfortunatelyYes])
 
 GIT_UNSTASH_FLAGS($ICONVDIR)
 
 GIT_CONF_SUBST([OLD_ICONV])
 
+#
+# Define ICONV_OMITS_BOM if you are on a system which
+# iconv omits bom for utf-{16,32}
+if test -z "$NO_ICONV"; then
+AC_CACHE_CHECK([whether iconv omits bom for utf-16 and utf-32],
+ [ac_cv_iconv_omits_bom],
+[
+old_LIBS="$LIBS"
+if test -n "$NEEDS_LIBICONV"; then
+	LIBS="$LIBS -liconv"
+fi
+
+AC_RUN_IFELSE(
+	[AC_LANG_PROGRAM([AC_INCLUDES_DEFAULT
+	#include <iconv.h>
+	#ifdef HAVE_OLD_ICONV
+	typedef const char *iconv_ibp;
+	#else
+	typedef char *iconv_ibp;
+	#endif
+	],
+	[[
+	int v;
+	iconv_t conv;
+	char in[] = "a"; iconv_ibp pin = in;
+	char out[20] = ""; char *pout = out;
+	size_t isz = sizeof in;
+	size_t osz = sizeof out;
+
+	conv = iconv_open("UTF-16", "UTF-8");
+	iconv(conv, &pin, &isz, &pout, &osz);
+	iconv_close(conv);
+	v = (unsigned char)(out[0]) + (unsigned char)(out[1]);
+	return v != 0xfe + 0xff;
+	]])],
+	[ac_cv_iconv_omits_bom=no],
+	[ac_cv_iconv_omits_bom=yes])
+
+LIBS="$old_LIBS"
+])
+if test "x$ac_cv_iconv_omits_bom" = xyes; then
+	ICONV_OMITS_BOM=Yes
+else
+	ICONV_OMITS_BOM=
+fi
+GIT_CONF_SUBST([ICONV_OMITS_BOM])
+fi
+
 ## Checks for typedefs, structures, and compiler characteristics.
 AC_MSG_NOTICE([CHECKS for typedefs, structures, and compiler characteristics])
 #
-- 
2.24.0.164.g78daf050de.dirty


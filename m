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
	by dcvr.yhbt.net (Postfix) with ESMTP id 49C391F454
	for <e@80x24.org>; Fri,  1 Nov 2019 08:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730325AbfKAIZd (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Nov 2019 04:25:33 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36721 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730098AbfKAIZd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Nov 2019 04:25:33 -0400
Received: by mail-pg1-f196.google.com with SMTP id j22so6042816pgh.3
        for <git@vger.kernel.org>; Fri, 01 Nov 2019 01:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d7rnjbWDIY6kO3myxSnZo9ZKFXsxPDxv2zjE+QnRhLQ=;
        b=mTaJXpc3VqwPIw0B5mRLvfiD1OEc9Fh3kfB7mjtBIUjeOKwaF710A5Wx76Vl3KWsHK
         CMQaKCQmO2rVdHHxeMtKKlPtM4d4ZXXdT0pxSoq8fRmNfNeiGGU02RqMdJPhnRDCav0r
         WOAvNnYCaVkfZ3CYQKrk8InzFmV2KsJc0YLIllB2F2geUXkJCC/YejzKJ/FbZowrY4G8
         ABujjw1G0M7wHAcFgTIejDRA2s6qpV7+cNNBgMyoU0VeYDJ5aPkoMludBDis9t+l5mL2
         yBm7RgMzfSfZ8wWj3GjB2SgMx4tLLD8HST9oDfgia8tTTqXhfV86cI5k1bQxKg7i8z3t
         iSsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d7rnjbWDIY6kO3myxSnZo9ZKFXsxPDxv2zjE+QnRhLQ=;
        b=dWLBRNNlG/l/XkUMDgYHBb7a1bj2N2AqaPt8EbOZMiz2hF7oSb2h5Uea9lI859/tCD
         TRnCbw/P9fiF37ADM2KvvWxq0QQhvbTUlZHTqRUHys1z0HLKjPKCaOFgR4fGzUwX3QL9
         tOFRm/4URikZh4hNF0psBsmpGmoc7v9pFGewQrpZpUghiAeFcYVlLTgQ1NT4LypgBGLz
         Gg6DK1V/8dKv2XVP9g2a6XEfQqTXfSqsG4OxUDNx7Mvg22Q0Zl0E4DY3jjoTUxbG8hi3
         V4aCIgRBMzVPMECukS/G+9y00tn92xvcqRKdYRouPo83coKfRRrGGfy4tVgYNsEnVMFo
         U3Tw==
X-Gm-Message-State: APjAAAXwYZ0n2aKaWZ55N09gTxtswdUhNhrTMxHzv8rEeH1qpL5LKeub
        4kxe8NqHPXNfdWAFb+0pHqQNBczt
X-Google-Smtp-Source: APXvYqyWXTyrnfZACWZUk33Dekn/5wqKoihk9pWB0hNabGlqTMsAlX+8pr9qUXuZbPU5p4sEp/FmvQ==
X-Received: by 2002:a62:1c82:: with SMTP id c124mr12282004pfc.163.1572596732498;
        Fri, 01 Nov 2019 01:25:32 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:e1c2:8c5a:c959:6fca:fa1a])
        by smtp.gmail.com with ESMTPSA id q13sm17158395pjq.0.2019.11.01.01.25.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Nov 2019 01:25:31 -0700 (PDT)
From:   Doan Tran Cong Danh <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Doan Tran Cong Danh <congdanhqx@gmail.com>
Subject: [PATCH v2 2/3] configure.ac: define ICONV_OMITS_BOM if necessary
Date:   Fri,  1 Nov 2019 15:25:10 +0700
Message-Id: <7c2c6f060393abf3ac831837e4bf8ed366c2fa69.1572596278.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.24.0.rc2.296.geaf699fcc3
In-Reply-To: <cover.1572596278.git.congdanhqx@gmail.com>
References: <20191031092618.29073-1-congdanhqx@gmail.com> <cover.1572596278.git.congdanhqx@gmail.com>
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

However, typing the flag all the time is cumbersome and error-prone.

Add a checking into configure script to detect this flag automatically.

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
2.24.0.rc2.296.geaf699fcc3


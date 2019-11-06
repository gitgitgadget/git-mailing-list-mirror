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
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C2421F454
	for <e@80x24.org>; Wed,  6 Nov 2019 09:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbfKFJUe (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 04:20:34 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46529 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfKFJUe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 04:20:34 -0500
Received: by mail-pf1-f194.google.com with SMTP id 193so17088619pfc.13
        for <git@vger.kernel.org>; Wed, 06 Nov 2019 01:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NhyiG9uPM2iaJgGvYX1RJO8cegBXQTMykQH459SUVDg=;
        b=hKjDc/A/VkMaPlYHsPzQebtEiCSSu/aj9xCB/jTR2Sw8tOgm/4UtK0rbGSLCLFqqWG
         Q/Baa7EByH2f+Y3bsLPPVlrfpccF/wupnii+2bKk5NR7R/n7yXlLFZm+wo5s5EnS3Ryk
         SYDc0d49Ue/VHqOieh5TBY/yX4JzPj9NG2jb+jdMj1yC9tQ+vi+9L2gdocDr1tKc3af7
         tspqxyrRMQLRj8VDxYrfEScgPd++7eiBTP1V833FRrrd6F+PuyslPEnMH/uGA63kYqNK
         fg/DERV5g++hFblqf8z3Ja8klIBTOia+93ldPqLgqb2gCweo0vqIHiDxrpniQy+CPuFZ
         2+hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NhyiG9uPM2iaJgGvYX1RJO8cegBXQTMykQH459SUVDg=;
        b=Z84oFG/gOORwyetoJozcqXdeZz9ivHhHA2GMqy+T6L+1i9LYPUuiEK/EHBrxpK+p2p
         8GvenquHSOPrLbypqRkTjJmez9pQxK7QP5O0edC1a08pe+zcP+qDusky5hTmbg5v0+II
         sFcGT6AEOKawpuqdhx5qLroaLbQOBAazgYG0DbyY63ePG3pc296bvw2hN6J35U16t4LC
         KCZC6tEsH1QJfG2zdJXQvXwWLi0dYqCO9eyUR8ZN1dZ55hEn3GXehabxo0cJ+TXd/jWB
         f5YBCirZg885x4sFQIsg24cjwQA+mDFgLFvrv8+/Xjtr2rfTumxyhND2TIFy+UpdQKNw
         u1xA==
X-Gm-Message-State: APjAAAWPPiNn+RwtB1J7N8bPJ/2rO8s4WdRRbm+F+XCfQHzb1B5WWHzq
        Y3zSZ4ltbOardQLK+gNR6YhjnP49
X-Google-Smtp-Source: APXvYqxTJgoeUWkY/5/9/BS98oYtpVsDY08kKbSkJKuQ69PtX17cVX6DLS2i/b6haNPWrpevtTqfhA==
X-Received: by 2002:aa7:908b:: with SMTP id i11mr2075836pfa.186.1573032033617;
        Wed, 06 Nov 2019 01:20:33 -0800 (PST)
Received: from localhost.localdomain ([2402:800:6375:4ba:cb41:a2ec:2198:454b])
        by smtp.gmail.com with ESMTPSA id c1sm4696984pjc.23.2019.11.06.01.20.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 01:20:33 -0800 (PST)
From:   Doan Tran Cong Danh <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Doan Tran Cong Danh <congdanhqx@gmail.com>
Subject: [PATCH v3 2/8] configure.ac: define ICONV_OMITS_BOM if necessary
Date:   Wed,  6 Nov 2019 16:20:00 +0700
Message-Id: <f07566c60c4421a5b33ef5c74a9a0a58947e7750.1573031848.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.24.0.4.g6a51fdd29c
In-Reply-To: <cover.1573031848.git.congdanhqx@gmail.com>
References: <20191031092618.29073-1-congdanhqx@gmail.com> <cover.1573031848.git.congdanhqx@gmail.com>
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

Add a check into configure script to detect this flag automatically.

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
2.24.0.4.g6a51fdd29c


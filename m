Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 933721F454
	for <e@80x24.org>; Thu,  7 Nov 2019 02:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732916AbfKGC4d (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 21:56:33 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38052 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727924AbfKGC4d (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 21:56:33 -0500
Received: by mail-pl1-f194.google.com with SMTP id w8so425367plq.5
        for <git@vger.kernel.org>; Wed, 06 Nov 2019 18:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=31S61UoSxEEdfGXnCIrbo3WsK/FLt23TJmcMRsVS4bU=;
        b=Tu3p7qSmGUW0VGWR98txXq8IkLKCynRqW/bF1IILgegI8vvgR05WNLF+5dpiVSVvB1
         XQRC9VH3fGvfSfN6khb52EjN0yXQt52WBByJAPcfJuiOXRffu8KnRN5MH1dB34kXt4/2
         KjjUdq7ev2gigF/aCpVCC18BXYiBXKmA/d5eue+pFvY73EOykmxZ1CjrhKz9oRJ5D47t
         FilrK1UtqPhSB1l/XNJB+noKggB8EMvAmcc68BVaGA+f/mtJGKhBKJWH/Gcai0+rrlU9
         DTs+c7x4BQ8uXPD8lPH+m1YsPLegP154R/WWv5qhMawmRd4nE5jGwojoGPxjz527rJDi
         MCbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=31S61UoSxEEdfGXnCIrbo3WsK/FLt23TJmcMRsVS4bU=;
        b=Ouw7pc3Ny7oo43qa8ErceeCKKXrjk8ZZKqEcl6g8I2tz7LXfNPXOslhVrDrUOPQkYj
         /gLHpVNsO8ZBZeSHpIVyVpyRDgi5Zf/JkdCJQG6SB7/+LwzHhjCO3aedjnzs9NiVb/1d
         CjpRbUByBfkLxl/qiAqVe3HNL1oW7fDcNJW14qV4/pB6+2skoMEmTiw0ETj8A/LCFax/
         vPzfkiPgVnBKbmEtFYkoD/NQDpBhiXg5EP+zXB6R52p40nYp/broYv2n/X82sFyXKQj1
         n/C1rW5wvjnAhg4HH6cSO9AkFO6K0WuaAUP4kqHwki9aU5965j/8bUOh3q1fhebCdzXU
         GLCA==
X-Gm-Message-State: APjAAAWl4iD2CWSsC2fNXLCJ7CU3CWtWOBYexlg5x3/RjWz9EkzEH7Kb
        FycU2PJLEJ092x3d+wYmzYglgCCakeA=
X-Google-Smtp-Source: APXvYqx+WnQtmbfNk87T3lEIQx1BkNDfEbWl/RLOL6yQvMljUqepfqrQoCsMYDhHwVJW9H9gAMnptQ==
X-Received: by 2002:a17:902:7887:: with SMTP id q7mr1161826pll.112.1573095391899;
        Wed, 06 Nov 2019 18:56:31 -0800 (PST)
Received: from localhost.localdomain ([2402:800:6375:16b7:502d:9b82:436:143a])
        by smtp.gmail.com with ESMTPSA id n15sm393767pfq.146.2019.11.06.18.56.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 18:56:31 -0800 (PST)
From:   Doan Tran Cong Danh <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Doan Tran Cong Danh <congdanhqx@gmail.com>
Subject: [PATCH v4 2/8] configure.ac: define ICONV_OMITS_BOM if necessary
Date:   Thu,  7 Nov 2019 09:56:13 +0700
Message-Id: <f07566c60c4421a5b33ef5c74a9a0a58947e7750.1573094789.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.24.0.8.g36796e2b67
In-Reply-To: <cover.1573094789.git.congdanhqx@gmail.com>
References: <20191031092618.29073-1-congdanhqx@gmail.com> <cover.1573094789.git.congdanhqx@gmail.com>
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
2.24.0.8.g36796e2b67


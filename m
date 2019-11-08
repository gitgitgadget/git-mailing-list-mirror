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
	by dcvr.yhbt.net (Postfix) with ESMTP id E55E21F4C0
	for <e@80x24.org>; Fri,  8 Nov 2019 09:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731147AbfKHJoF (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Nov 2019 04:44:05 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38522 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730260AbfKHJoE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Nov 2019 04:44:04 -0500
Received: by mail-pf1-f194.google.com with SMTP id c13so4216677pfp.5
        for <git@vger.kernel.org>; Fri, 08 Nov 2019 01:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aSqMjXUIfuiy0J4koP1iJB/SRR3I25ckk5HlB94mrCw=;
        b=jlrnWy2hjIIwzDHAcb7pSoK2lmAJY+oe/tgvrds0iVxURwW363sn7NOI43eV2KyqR5
         VY7HkBSHzzWIi2Q7RqUL28iKnUSL5N7fg3f9SHddxzbz2SXqZ1tQiPbrzCSHBXp0AkQm
         tEQvhFiCAV5jDQ03sD0Yh2coDkjpngA3vAM+28IKHoOuP+tcXfcV9ZTzUoGMCt+6CIhk
         s8D0iZNO+QdVm9cmppnfvnVj4fDRyArdz/JSEY67sIXmqiO36kommCEHP/2sq7AloqlO
         GPetuTPybQNCmvhIHAuv0As+bI/AF7bhbOB02xVqngaypSBQyvQoW4GJqJx4H38pg8AY
         KsbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aSqMjXUIfuiy0J4koP1iJB/SRR3I25ckk5HlB94mrCw=;
        b=JVwznzPC8pRMRLlJfXqupcSIuam5hqHKAeR5mQqJU1/Xoi8Upd6dB65zJCWn8ItcVV
         kvWbCw0YWetmn/PJOQib6lfx821SMxL2Z9UDn6TVEAZpmTJKokmbf9FDSdYhHuQeJnIL
         eLC25rxGGINIQPxRxnXhgumZz0g4vj8Ip9oEOuxE9EpL4Qdi6+bch2VsLp2pftLHWzqO
         c6erbq3iauPu5fncckGWweg9FrdQgg/Sp/Y/5DDS3ER9K92uS+vVV/ylvO78ocI+QdOU
         Wf3e9+uG/t+HeKpeN7uZMbW4vpn0UeJPWE+Yx49d22D7vTtkrL6JNnq9TiAQ36dnsxr9
         87Jw==
X-Gm-Message-State: APjAAAXqbC/ef4fGWUafNFleBcm1d4weHMLBAPfI7CGOJ9S5GuW8jY3g
        YGPA/HPloHZGhpqFA1dfe9RNjUhO
X-Google-Smtp-Source: APXvYqyIJ9frvZuJZ+jgfFns1p+L1g8ALxemxCH5/8LDg+YHhndOz8nbRk/557O6XBnzP52ifh2GMQ==
X-Received: by 2002:a63:ec4b:: with SMTP id r11mr10593525pgj.147.1573206243347;
        Fri, 08 Nov 2019 01:44:03 -0800 (PST)
Received: from localhost.localdomain ([2402:800:6375:16b7:502d:9b82:436:143a])
        by smtp.gmail.com with ESMTPSA id e198sm6995821pfh.83.2019.11.08.01.44.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2019 01:44:02 -0800 (PST)
From:   Doan Tran Cong Danh <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Doan Tran Cong Danh <congdanhqx@gmail.com>
Subject: [PATCH v5 2/9] configure.ac: define ICONV_OMITS_BOM if necessary
Date:   Fri,  8 Nov 2019 16:43:44 +0700
Message-Id: <fe63a6bc4483606048acdf19247574200b4ae8bf.1573205699.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.24.0.8.g2e95ca57d2.dirty
In-Reply-To: <cover.1573205699.git.congdanhqx@gmail.com>
References: <20191031092618.29073-1-congdanhqx@gmail.com> <cover.1573205699.git.congdanhqx@gmail.com>
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
2.24.0.8.g2e95ca57d2.dirty


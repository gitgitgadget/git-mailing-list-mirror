Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7756E207D6
	for <e@80x24.org>; Thu,  4 May 2017 22:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752474AbdEDWB2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 18:01:28 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35153 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752400AbdEDWB0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 18:01:26 -0400
Received: by mail-wr0-f194.google.com with SMTP id g12so2692780wrg.2
        for <git@vger.kernel.org>; Thu, 04 May 2017 15:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LXJuNVbwQCIshuHTodmx1dCN8y4Yyk8hV54jOKrfguU=;
        b=Rw9buDZY2+SwFysjJMQeouICIZklhtO+ISd8KX0aKLY9qid2zpzjHVIVoht9EknTko
         NUHsJTLP1CqoPdOu3u4kcb9Qle4ge25cPlxN5GOEsT3qSRj3Ez0cJJW1Tk773qTfpLcP
         i4BIwaokf/SXjgVt9QE+6qnkAzFkUEvBKLNVOVOsjtaz9c7PI/VTAtng45IL5mJlM8fl
         bWZRmdUCibhZLBPoXA744iIXcUoiaKjXKcxWN9O7z7uvY2nGYzCRRzcTSVX6hZ2MUSLw
         +1h+ZZO97E+AVByJxp5lYPV7mNzVMNgUemuudSGx97yfbRTW7DXIRBpKvgFlN8ABYWKG
         Dz9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LXJuNVbwQCIshuHTodmx1dCN8y4Yyk8hV54jOKrfguU=;
        b=V37rdtoT1fJOlIat9nc96rAYs48jmVNdlCf/wxQUanBXNkYImwm/ICHbCpr3s/LHGB
         pDLDd10JxmdJN1tyIlzgDolqceIMWEP1X4xYCoPGrntSLKS2zJb1caf/ufF/gfrhzBAE
         GTWCXTDiRDv6hcnRGZGDe19NNWgpm/EORRxpLgXaANRpcTgGae6UN+M6xXAe4II+6fbS
         pnHRmhKXr/T2rtgS3lhm+Nas0Ezox/oLJyLu9fsV6ysxTG3qZPyq0/oiVUKGkFI9GaGd
         uaW8Guu3vemQiyjWjE2gnqJbv3NMQed1l3E+KSI/1OgOyGOwUpS26SC3GsLY9ZZecO27
         6vKA==
X-Gm-Message-State: AN3rC/769ZxeWQ9njFJJKAoWg2zMHTtlRkQSYuKbLxwNTIlYYzHzzMkW
        p0eq/KxymGXx8A==
X-Received: by 10.223.148.132 with SMTP id 4mr34188179wrr.119.1493935285056;
        Thu, 04 May 2017 15:01:25 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id w136sm2424680wmd.0.2017.05.04.15.01.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 May 2017 15:01:24 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
        Stefano Lattarini <stefano.lattarini@gmail.com>,
        =?UTF-8?q?Ond=C5=99ej=20B=C3=ADlka?= <neleai@seznam.cz>,
        "Arnold D . Robbins" <arnold@skeeve.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/7] fixup! compat/regex: update the gawk regex engine from upstream
Date:   Thu,  4 May 2017 22:00:40 +0000
Message-Id: <20170504220043.25702-5-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170504220043.25702-1-avarab@gmail.com>
References: <20170504220043.25702-1-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 compat/regex/regex.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/compat/regex/regex.c b/compat/regex/regex.c
index 5cb23e5d59..d6e525e567 100644
--- a/compat/regex/regex.c
+++ b/compat/regex/regex.c
@@ -1,5 +1,12 @@
+/*
+ * This is git.git's copy of gawk.git's regex engine. Please see that
+ * project for the latest version & to submit patches to this code,
+ * and git.git's compat/regex/README for information on how git's copy
+ * of this code is maintained.
+ */
+
 /* Extended regular expression matching and search library.
-   Copyright (C) 2002, 2003, 2005 Free Software Foundation, Inc.
+   Copyright (C) 2002-2016 Free Software Foundation, Inc.
    This file is part of the GNU C Library.
    Contributed by Isamu Hasegawa <isamu@yamato.ibm.com>.
 
@@ -14,15 +21,14 @@
    Lesser General Public License for more details.
 
    You should have received a copy of the GNU Lesser General Public
-   License along with the GNU C Library; if not, write to the Free
-   Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
-   02110-1301 USA.  */
+   License along with the GNU C Library; if not, see
+   <http://www.gnu.org/licenses/>.  */
 
 #ifdef HAVE_CONFIG_H
 #include "config.h"
 #endif
 
-/* Make sure no one compiles this code with a C++ compiler.  */
+/* Make sure noone compiles this code with a C++ compiler.  */
 #ifdef __cplusplus
 # error "This is C code, use a C compiler"
 #endif
@@ -52,15 +58,15 @@
 # include "../locale/localeinfo.h"
 #endif
 
-#if defined (_MSC_VER)
-#include <stdio.h> /* for size_t */
-#endif
-
 /* On some systems, limits.h sets RE_DUP_MAX to a lower value than
    GNU regex allows.  Include it before <regex.h>, which correctly
    #undefs RE_DUP_MAX and sets it to the right value.  */
 #include <limits.h>
-#include <stdint.h>
+
+/* This header defines the MIN and MAX macros.  */
+#ifdef HAVE_SYS_PARAM_H
+#include <sys/param.h>
+#endif /* HAVE_SYS_PARAM_H */
 
 #ifdef GAWK
 #undef alloca
@@ -70,10 +76,8 @@
 #include "regex_internal.h"
 
 #include "regex_internal.c"
-#ifdef GAWK
-#define bool int
-#define true (1)
-#define false (0)
+#ifndef HAVE_STDBOOL_H
+#include "missing_d/gawkbool.h"
 #endif
 #include "regcomp.c"
 #include "regexec.c"
-- 
2.11.0


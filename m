Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF01C433FE
	for <git@archiver.kernel.org>; Sat,  5 Nov 2022 17:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiKERIe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Nov 2022 13:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiKERIS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Nov 2022 13:08:18 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF4011A03
        for <git@vger.kernel.org>; Sat,  5 Nov 2022 10:08:14 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id l2so7528921pld.13
        for <git@vger.kernel.org>; Sat, 05 Nov 2022 10:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xGnVbKSr6sG1SWtivZ1DAE1XsqS62Dit1sTSItgzhd0=;
        b=HNAhuJxMozihvGbQF9TkuGTAEe7IWs7C9GK7Weqp8CeMFXc4KtJsTaiJ2ewsz2IIHb
         ICSEaI0bILYMfISyvWGOigt5t1Nthb1BldkxbuIyId4D3JmHCYOZkzIO0AVMSfdDDTEd
         GiPaECs4c0gz6N65C+n2Blarksn7LVOSL+Ty5dmZymDj239fBLIuiCpDmjULAMjj0JaA
         qRP+hwJ4y5MuS7Rsmz59HXA2dfu8xWk7mK9oLf+msDUJ8EQC+J2sgJ1z1X1ryPUF4hRc
         Z3WZeScf8YMqH37ogWawiJ7DlQHtlr8GO0YBtycriYS5JVFCZu2bvdvw2ZW8j4caBN+8
         srgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xGnVbKSr6sG1SWtivZ1DAE1XsqS62Dit1sTSItgzhd0=;
        b=Y94HinNbNOw+ONmXO+Mhlqaky+IMbs2dLp2cBQrQJOfrP5zvVaoe4fRFHoR5vr3ncM
         rEolY+pZH88SsdedLMowfCxWulojNQwoJXHywrtN+POLzWfLHieKsjHlJmT+8YOrMl8a
         8Rcsi/yUE8vYX3lCZ+lQu4z0OxcYun6p+LRizUS6dizwBZkzRfsV8GklB9oE0CkuZgpy
         h2XknC+tc4OAbk4GxsmBscRh/kHVO9CJ57GGw8xJ6+g6FrrTa55cmQ8UYlUmYGNT1rVb
         xX5vmLgT6Dy7LI375rlwmctrHYy/nGsKTqIdr25fZd1DgwaBnXSYyNoyeZly/+w7jAgu
         FF1A==
X-Gm-Message-State: ACrzQf1c6tEKT1ZXAqvL0szpIhUlvrprt1BGfQs8z6QBI9jh/W52eEuJ
        zmk+B84j1Yo/+etaHdE0l72AkV8UQns=
X-Google-Smtp-Source: AMsMyM7pbMy2N1v/FhXOYZq/80eWyGld7/ytLJOsN0yvEztepVmE1n6uy2LrxZ2R0dUxDEMydk4gvQ==
X-Received: by 2002:a17:90b:1950:b0:212:de19:b3ce with SMTP id nk16-20020a17090b195000b00212de19b3cemr41595613pjb.16.1667668094085;
        Sat, 05 Nov 2022 10:08:14 -0700 (PDT)
Received: from localhost.localdomain ([2001:ee0:500b:6370:da47:cda5:dbd5:6e77])
        by smtp.gmail.com with ESMTPSA id c16-20020a056a00009000b0056299fd2ba2sm1513192pfj.162.2022.11.05.10.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 10:08:13 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 07/13] bisect--helper: pretend we're real bisect when report error
Date:   Sun,  6 Nov 2022 00:07:38 +0700
Message-Id: <f212e6428855f0b0839bf6befd7c4703c505cc66.1667667460.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.38.1.157.gedabe22e0a
In-Reply-To: <cover.1667667460.git.congdanhqx@gmail.com>
References: <cover.1667667058.git.congdanhqx@gmail.com> <cover.1667667460.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a later change, we will convert the bisect--helper to be builtin
bisect. Let's start by pretending it's the real bisect when reporting
error.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 builtin/bisect--helper.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index b99cbb0dbe..6be4d8861e 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1284,7 +1284,8 @@ static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
 static int cmd_bisect__reset(int argc, const char **argv, const char *prefix UNUSED)
 {
 	if (argc > 1)
-		return error(_("--bisect-reset requires either no argument or a commit"));
+		return error(_("'%s' requires either no argument or a commit"),
+			     "git bisect reset");
 	return bisect_reset(argc ? argv[0] : NULL);
 }
 
@@ -1294,7 +1295,8 @@ static int cmd_bisect__terms(int argc, const char **argv, const char *prefix UNU
 	struct bisect_terms terms = { .term_good = NULL, .term_bad = NULL };
 
 	if (argc > 1)
-		return error(_("--bisect-terms requires 0 or 1 argument"));
+		return error(_("'%s' requires 0 or 1 argument"),
+			     "git bisect terms");
 	res = bisect_terms(&terms, argc == 1 ? argv[0] : NULL);
 	free_terms(&terms);
 	return res;
@@ -1317,7 +1319,8 @@ static int cmd_bisect__next(int argc, const char **argv UNUSED, const char *pref
 	struct bisect_terms terms = { .term_good = NULL, .term_bad = NULL };
 
 	if (argc)
-		return error(_("--bisect-next requires 0 arguments"));
+		return error(_("'%s' requires 0 arguments"),
+			     "git bisect next");
 	get_terms(&terms);
 	res = bisect_next(&terms, prefix);
 	free_terms(&terms);
@@ -1339,7 +1342,7 @@ static int cmd_bisect__state(int argc, const char **argv, const char *prefix UNU
 static int cmd_bisect__log(int argc, const char **argv UNUSED, const char *prefix UNUSED)
 {
 	if (argc)
-		return error(_("--bisect-log requires 0 arguments"));
+		return error(_("'%s' requires 0 arguments"), "git bisect log");
 	return bisect_log();
 }
 
@@ -1385,7 +1388,7 @@ static int cmd_bisect__run(int argc, const char **argv, const char *prefix UNUSE
 	struct bisect_terms terms = { .term_good = NULL, .term_bad = NULL };
 
 	if (!argc)
-		return error(_("bisect run failed: no command provided."));
+		return error(_("'%s' failed: no command provided."), "git bisect run");
 	get_terms(&terms);
 	res = bisect_run(&terms, argv, argc);
 	free_terms(&terms);
-- 
2.38.1.157.gedabe22e0a


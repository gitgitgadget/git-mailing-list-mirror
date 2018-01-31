Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD,
	UPPERCASE_50_75 shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4937D1F576
	for <e@80x24.org>; Wed, 31 Jan 2018 11:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753340AbeAaLGM (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 06:06:12 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:43372 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752373AbeAaLGL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 06:06:11 -0500
Received: by mail-pf0-f195.google.com with SMTP id y26so12235285pfi.10
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 03:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GlOzt+S/Pt7N49AwIunqOkfr5Vx/DPUSHdPOozdIK94=;
        b=tx9nYP6muH6JggI+nG8o62iD+7KkUEgUWBLtL5l64dN/06LzUiSVcDPhtvDGbGHcOf
         8Ksp5bqfJ8cI2kTywnSHbzoo+2i73yHwyGmkTA3heO72/gJqCbMQt7NfGeQfqEUs+/7e
         cL5r4BaxFBaF7ikvrVv0rJMJ+afBrvjCuvd8kxJGPHht0qtc+WMm/XNAzsB6I0sQrVcl
         86g61cygC7vqRjGwwRWo0/xhC6BOHwJ2RGvwQGnYkmoGm5ikCenk2ONBPKGBUMndr92b
         suSAXZxiCRd9lB5I60LOmFLK4NlLD5HGn2WLnN7PczVnA4Pl2zvXL1aJkepB18n4MZ6N
         /6kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GlOzt+S/Pt7N49AwIunqOkfr5Vx/DPUSHdPOozdIK94=;
        b=XHxxZ+CGoUgU1zNzWvmux/2Mr/9NXMtHm7BPO5tGkipgyhFvubj41+kA8COpLovEqn
         3JD14i+e2NDJdVh23Hq3ZdyFwUPT3yT1eevyNvDa6Bm+zHAAFJAV6i7nyx2/AdTgKITW
         JTyNOGZZbukFfW3ICYTozX334/+AttMvxgJbWNkUSfyrT/2cIn+yYemLFva/9kTVj+RE
         tfov1cgVf0rCe3xOZZ2Sdeqa2dPP+hKDEzHTNRwl7AJaqJnvqtEHLMkdySfATyMX4Fx0
         xo32LcaZWRLavw1AZbi46a37HmzMzjnO2eYw+J4Ohz6EeSkwhOx2yfd430DtPU6aJ/fR
         gjkw==
X-Gm-Message-State: AKwxytc2RPMgOBGKCmaF4A7sNQVv8J4hMAQU6oQb/z2IZnaYtdwlV1oF
        s4x0u//vmGc/8JNDWZGr9P2Hcg==
X-Google-Smtp-Source: AH8x224+qf2hxsv2ANmS8G3jzykseE3jvg/GTiv1IhzqhsgOQgH6mab9d3uvbxR8CUqxGlSQPilenw==
X-Received: by 2002:a17:902:8545:: with SMTP id d5-v6mr8462158plo.306.1517396770829;
        Wed, 31 Jan 2018 03:06:10 -0800 (PST)
Received: from ash ([171.232.97.171])
        by smtp.gmail.com with ESMTPSA id k13sm40401434pfj.38.2018.01.31.03.06.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jan 2018 03:06:10 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 31 Jan 2018 18:06:06 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 02/41] parse-options: add OPT_xxx_F() variants
Date:   Wed, 31 Jan 2018 18:05:08 +0700
Message-Id: <20180131110547.20577-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.205.g271f633410
In-Reply-To: <20180131110547.20577-1-pclouds@gmail.com>
References: <20180131110547.20577-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These macros allow us to add extra parse-options flag, the main one in
my mind is PARSE_OPT_NOCOMPLETE to hide certain options from
--git-completion-helper.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 parse-options.h | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/parse-options.h b/parse-options.h
index 983de27cf0..bc41b99d3b 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -115,23 +115,30 @@ struct option {
 	intptr_t defval;
 };
 
+#define OPT_BIT_F(s, l, v, h, b, f) { OPTION_BIT, (s), (l), (v), NULL, (h), \
+				      PARSE_OPT_NOARG|(f), NULL, (b) }
+#define OPT_COUNTUP_F(s, l, v, h, f) { OPTION_COUNTUP, (s), (l), (v), NULL, \
+				       (h), PARSE_OPT_NOARG|(f) }
+#define OPT_SET_INT_F(s, l, v, h, i, f) { OPTION_SET_INT, (s), (l), (v), NULL, \
+					  (h), PARSE_OPT_NOARG | (f), NULL, (i) }
+#define OPT_BOOL_F(s, l, v, h, f)   OPT_SET_INT_F(s, l, v, h, 1, f)
+#define OPT_CMDMODE_F(s, l, v, h, i, f) { OPTION_CMDMODE, (s), (l), (v), NULL, \
+					  (h), PARSE_OPT_NOARG|PARSE_OPT_NONEG|(f), \
+					  NULL, (i) }
+
 #define OPT_END()                   { OPTION_END }
 #define OPT_ARGUMENT(l, h)          { OPTION_ARGUMENT, 0, (l), NULL, NULL, \
 				      (h), PARSE_OPT_NOARG}
 #define OPT_GROUP(h)                { OPTION_GROUP, 0, NULL, NULL, NULL, (h) }
-#define OPT_BIT(s, l, v, h, b)      { OPTION_BIT, (s), (l), (v), NULL, (h), \
-				      PARSE_OPT_NOARG, NULL, (b) }
+#define OPT_BIT(s, l, v, h, b)      OPT_BIT_F(s, l, v, h, b, 0)
 #define OPT_NEGBIT(s, l, v, h, b)   { OPTION_NEGBIT, (s), (l), (v), NULL, \
 				      (h), PARSE_OPT_NOARG, NULL, (b) }
-#define OPT_COUNTUP(s, l, v, h)     { OPTION_COUNTUP, (s), (l), (v), NULL, \
-				      (h), PARSE_OPT_NOARG }
-#define OPT_SET_INT(s, l, v, h, i)  { OPTION_SET_INT, (s), (l), (v), NULL, \
-				      (h), PARSE_OPT_NOARG, NULL, (i) }
-#define OPT_BOOL(s, l, v, h)        OPT_SET_INT(s, l, v, h, 1)
+#define OPT_COUNTUP(s, l, v, h)     OPT_COUNTUP_F(s, l, v, h, 0)
+#define OPT_SET_INT(s, l, v, h, i)  OPT_SET_INT_F(s, l, v, h, i, 0)
+#define OPT_BOOL(s, l, v, h)        OPT_BOOL_F(s, l, v, h, 0)
 #define OPT_HIDDEN_BOOL(s, l, v, h) { OPTION_SET_INT, (s), (l), (v), NULL, \
 				      (h), PARSE_OPT_NOARG | PARSE_OPT_HIDDEN, NULL, 1}
-#define OPT_CMDMODE(s, l, v, h, i)  { OPTION_CMDMODE, (s), (l), (v), NULL, \
-				      (h), PARSE_OPT_NOARG|PARSE_OPT_NONEG, NULL, (i) }
+#define OPT_CMDMODE(s, l, v, h, i)  OPT_CMDMODE_F(s, l, v, h, i, 0)
 #define OPT_INTEGER(s, l, v, h)     { OPTION_INTEGER, (s), (l), (v), N_("n"), (h) }
 #define OPT_MAGNITUDE(s, l, v, h)   { OPTION_MAGNITUDE, (s), (l), (v), \
 				      N_("n"), (h), PARSE_OPT_NONEG }
-- 
2.16.1.205.g271f633410


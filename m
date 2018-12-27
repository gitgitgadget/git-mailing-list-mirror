Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04AEF211BB
	for <e@80x24.org>; Thu, 27 Dec 2018 16:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729410AbeL0QZ5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Dec 2018 11:25:57 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40052 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729352AbeL0QZx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Dec 2018 11:25:53 -0500
Received: by mail-lj1-f195.google.com with SMTP id n18-v6so16666098lji.7
        for <git@vger.kernel.org>; Thu, 27 Dec 2018 08:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+pkg30jNu/DUuQUOD3Fis8IRLZoYO4ztcfhZ9gpufWQ=;
        b=hnppQeIFuzK2srmklNsPNaZlNizpB7/20XCVA9+Q09KhHkfu9URNwE7vaD4VoRR32h
         NCLgrfT/bqVxP1m1MrPPeJV3RaUF5FlYwzHvpgBDwRgZL+5f49teM0oaNz9IFFOUbkVJ
         9imKNLps3BJAOmeT2Q9sjnx5b8H3+aTyMO56Cc/BuHD00xCKCyIKHdLscuWEZ9gnUiBJ
         2HZb2bTeaGvtx4YwPkwx9jfhpIp8I/notNN8Q/mD4QXcWMZDrIFISRsmjPLqwYnRx6PQ
         ZuRwfgvjo7B9X2xCVCrybKGFXie+ptyMbsGlBcmXBDK78a8cpHhxTqTTDlJdJ+pSggUw
         t+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+pkg30jNu/DUuQUOD3Fis8IRLZoYO4ztcfhZ9gpufWQ=;
        b=gpc1BqcYC/i/r6JbQvBO1FqBWwoaO7K1tA4u/RqGGWXONnlItwA96pqNn79SCr1zRq
         WZJoKR3/rNqbVJ0+fpuBc4uf7ALN2Ly3GiYFImM2odVvEwVXVdyDYifPUT5Xl+9MPfxn
         Fsyk04lI099ho1XfDk6Vz0cskQMNAujZVZBpJj3ua7WMkPvBWz8qLkZhb6Zz1vN5Z0Ar
         18uydlDkrGiNhOOqCBDQZUqGYOq9QFQDtJoBuA/qncTFlVBZgmuFJ/2s9dNsSkNsntZ9
         TzXFbQMs2Oxw/jGgloLHhQFHI3tOglKqPa/BXCwf03oFEbh9VJvMsBg1EE5Uclf32HxC
         z30Q==
X-Gm-Message-State: AJcUukfKn0XJwUURDGKtXsrSfgo53vyHPF1+ZtFhJbmfTJBe5ro2AH6L
        gpNZwh4ZC89JYqhkEE6bqZcMZXfF
X-Google-Smtp-Source: AFSGD/XuA6VpcqCBVFlVa2oKiXa3BokbluDsCV95RGDmGtAc+3UgUM4/QAlU5c+22vBQiFz9uTYfIg==
X-Received: by 2002:a2e:a289:: with SMTP id k9-v6mr14033814lja.24.1545927951075;
        Thu, 27 Dec 2018 08:25:51 -0800 (PST)
Received: from localhost.localdomain (c80-216-2-165.bredband.comhem.se. [80.216.2.165])
        by smtp.gmail.com with ESMTPSA id a127sm7643106lfe.73.2018.12.27.08.25.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 08:25:50 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 05/75] parse-options: add OPT_BITOP()
Date:   Thu, 27 Dec 2018 17:25:26 +0100
Message-Id: <20181227162536.15895-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.482.g66447595a7
In-Reply-To: <20181227162536.15895-1-pclouds@gmail.com>
References: <20181227162536.15895-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is needed for diff_opt_parse() where we do

   value = (value & ~mask) | some_more;

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 parse-options.c | 7 +++++++
 parse-options.h | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/parse-options.c b/parse-options.c
index 81e66b9374..9e19d64cc9 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -110,6 +110,13 @@ static int get_value(struct parse_opt_ctx_t *p,
 			*(int *)opt->value &= ~opt->defval;
 		return 0;
 
+	case OPTION_BITOP:
+		if (unset)
+			BUG("BITOP can't have unset form");
+		*(int *)opt->value &= ~opt->extra;
+		*(int *)opt->value |= opt->defval;
+		return 0;
+
 	case OPTION_COUNTUP:
 		if (*(int *)opt->value < 0)
 			*(int *)opt->value = 0;
diff --git a/parse-options.h b/parse-options.h
index 043d296ea4..69afd0bce6 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -10,6 +10,7 @@ enum parse_opt_type {
 	/* options with no arguments */
 	OPTION_BIT,
 	OPTION_NEGBIT,
+	OPTION_BITOP,
 	OPTION_COUNTUP,
 	OPTION_SET_INT,
 	OPTION_CMDMODE,
@@ -118,6 +119,7 @@ struct option {
 	int flags;
 	parse_opt_cb *callback;
 	intptr_t defval;
+	intptr_t extra;
 };
 
 #define OPT_BIT_F(s, l, v, h, b, f) { OPTION_BIT, (s), (l), (v), NULL, (h), \
@@ -133,6 +135,9 @@ struct option {
 				      (h), PARSE_OPT_NOARG}
 #define OPT_GROUP(h)                { OPTION_GROUP, 0, NULL, NULL, NULL, (h) }
 #define OPT_BIT(s, l, v, h, b)      OPT_BIT_F(s, l, v, h, b, 0)
+#define OPT_BITOP(s, l, v, h, set, clear) { OPTION_BITOP, (s), (l), (v), NULL, (h), \
+					    PARSE_OPT_NOARG|PARSE_OPT_NONEG, NULL, \
+					    (set), (clear) }
 #define OPT_NEGBIT(s, l, v, h, b)   { OPTION_NEGBIT, (s), (l), (v), NULL, \
 				      (h), PARSE_OPT_NOARG, NULL, (b) }
 #define OPT_COUNTUP(s, l, v, h)     OPT_COUNTUP_F(s, l, v, h, 0)
-- 
2.20.0.482.g66447595a7


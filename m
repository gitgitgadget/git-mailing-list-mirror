Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09AF21F461
	for <e@80x24.org>; Fri, 21 Jun 2019 09:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfFUJUf (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 05:20:35 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43519 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbfFUJUf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 05:20:35 -0400
Received: by mail-pg1-f196.google.com with SMTP id f25so3064129pgv.10
        for <git@vger.kernel.org>; Fri, 21 Jun 2019 02:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fbylS04N0kpHs/7vKPXmotnmDYuGwmyACsWWpHPf3xQ=;
        b=VCDQ/vmCTJF8teKs3Rh2W7APSy3qe6XkWWE8dFSSVWhhcSTkk/WGYGumbsH1IyovvT
         o1u9tio4obNHUkgwLhcqGBZsLj9X5J4WPyX/LFxxP6/VMR7yKLHrqmsS/FPS+f2yTQ3p
         Ne6EG+2yTm9MXACEQDsYpOk7JK70rh9CAy94ys8v1GnlWutHhIU89nieB7MdYFhvkQM4
         no6UVWYCOilSL3HAAJPaUxU7eKcrXc8+1NQ9YMbJb24/eDoNcwl18EmCV0QNIgJucdrf
         DRF31n8CMDIkpEENoJ3fYoGlWJ90dvmNlQBXHFKQnNEJwt0ojUhY+MujxItfxlh1UbHP
         jB5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fbylS04N0kpHs/7vKPXmotnmDYuGwmyACsWWpHPf3xQ=;
        b=ZYTJ6ZP+WO2bufKDttRCAGaym0MQnd7C/HfsOUr+i/WzUNzdTwxK7mvKTzi18AcpHE
         nJwEC3StwGANgbMxFAEIDYPTVepMVU2jFUYVZnX/z/UPKpUJbP2plop1lKtm2HgoQ6kU
         5rnFgUpWDSUnX/eFDC9kLn6hWaPvbuajrR794cr2suPma3bCY0HqUsOMlObgOk7jGRIQ
         5T0E5D1NUDv8fiH5CtVceyCyNJ9ISQH/JdX/Vy+I4Q7XgR2TDnujlzczrAKaSckKR2WF
         rTG6pLSAdbAfHLmS1y9//QUlsgw9Y5ieIQZVjAWnWaCzOkLejp6ZwDREIvmtdI1VOx0P
         ZMGg==
X-Gm-Message-State: APjAAAU+kBEon+a00k7Llo0yPo3z7kjCmKkSPRHwCIMgebCu4exAixb5
        3IiP++JUAWsLHFFPkRh4CLY=
X-Google-Smtp-Source: APXvYqxvw7IeXi8YuArMJ1Ch3IuXBt1LBj2oVajRjd5GgXV9hxclMtWH3VyfvKXDkLmHklFanIDVlA==
X-Received: by 2002:a63:8041:: with SMTP id j62mr5730788pgd.414.1561108834242;
        Fri, 21 Jun 2019 02:20:34 -0700 (PDT)
Received: from ar135.iitr.local ([103.37.200.216])
        by smtp.gmail.com with ESMTPSA id i133sm4380220pfe.75.2019.06.21.02.20.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 02:20:33 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     git@vger.kernel.org, newren@gmail.com, t.gummerer@gmail.com,
        phillip.wood123@gmail.com, gitster@pobox.com, jrnieder@gmail.com,
        martin.agren@gmail.com
Subject: [GSoC][PATCH v6 3/5] sequencer: use argv_array in reset_merge
Date:   Fri, 21 Jun 2019 14:47:58 +0530
Message-Id: <20190621091800.17686-4-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190621091800.17686-1-rohit.ashiwal265@gmail.com>
References: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
 <20190621091800.17686-1-rohit.ashiwal265@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Avoid using magic numbers for array size and index under `reset_merge`
function. Use `argv_array` instead. This will make code shorter and
easier to extend.

Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
---
 sequencer.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 12f2605ded..6762a5f485 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2733,13 +2733,18 @@ static int rollback_is_safe(void)
 
 static int reset_merge(const struct object_id *oid)
 {
-	const char *argv[4];	/* reset --merge <arg> + NULL */
+	int ret;
+	struct argv_array argv = ARGV_ARRAY_INIT;
 
-	argv[0] = "reset";
-	argv[1] = "--merge";
-	argv[2] = oid_to_hex(oid);
-	argv[3] = NULL;
-	return run_command_v_opt(argv, RUN_GIT_CMD);
+	argv_array_pushl(&argv, "reset", "--merge", NULL);
+
+	if (!is_null_oid(oid))
+		argv_array_push(&argv, oid_to_hex(oid));
+
+	ret = run_command_v_opt(argv.argv, RUN_GIT_CMD);
+	argv_array_clear(&argv);
+
+	return ret;
 }
 
 static int rollback_single_pick(struct repository *r)
-- 
2.21.0


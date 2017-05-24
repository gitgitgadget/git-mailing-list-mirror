Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23E6620281
	for <e@80x24.org>; Wed, 24 May 2017 05:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969161AbdEXFQu (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 May 2017 01:16:50 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36249 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969127AbdEXFQZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2017 01:16:25 -0400
Received: by mail-oi0-f66.google.com with SMTP id w138so31033561oiw.3
        for <git@vger.kernel.org>; Tue, 23 May 2017 22:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gs9c0Ds1cfjoGy5MALTzo4lAmVQSkHMYJIGwmtlTUP8=;
        b=gZ3pmM2wMHRxTiMNdgf7JE+7Lfy374mFdMqgLbSlLFQqDUQfDqTgsZfsT5rez0ooqA
         /TVXY6ORg/6d/Uh4BHIXBES9ZxEmjKOciMwCukY1F/Amz76TEmne5pwLBK0aDmatiKdV
         kBVGFqhBAUmnb+35QxzcgrVQGX8ynl3fntidGIKqr7G9zetlskqWyRrU22FvwFq63jsd
         zPDVvZHgVutJMs6roIoeEbqfCxEpRarkzSID3tDRKWFQlwMmZphdGpqD6pKLaWD3rrcD
         rfyIEazEm6Jei82buf4GtGnKhUQEokJf3NZnEmNXq3J9EkChPvB0gdP08GmyXWjIEVjC
         rEtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gs9c0Ds1cfjoGy5MALTzo4lAmVQSkHMYJIGwmtlTUP8=;
        b=lx5gcVCjpaR3lJ2dv6cdIqXWWZWYIaFnmOrlUqvpjyOI7l4ceCGn4xpK6ueCkPKSOG
         UQ0gEECrj9iATFk6+s6as4g5Cs2j5BlIecJZ6gMgoMgdSdUcgrhUMN1ieqcLW3sAiyD4
         3CYbwV+zlOQbs+r18xQLu92WksoO5MqV+BxTfxDl86TQlCfWqwUM9yybN3s86Ay3hnCc
         cBDm6XSMPoHCZxddwX/FHTivKnFvGCCn8i61CHL/2QgpHL7OfGndPkHpSXMzdBXqGOE1
         ytU6r4Yijnd+dRGV/BPoPZ3RgaDDN3JVkp3zMABRnLZCUAaLM4IvM6CGJ/XQi+d+MH0L
         z/vw==
X-Gm-Message-State: AODbwcAkwPQ/z8BzsWu949iBQAlLjG/XGGclr5Aj6yAb/pGWfqVqP0lC
        2IrwrUb+viNJxQ==
X-Received: by 10.157.47.173 with SMTP id r42mr4237905otb.63.1495602985275;
        Tue, 23 May 2017 22:16:25 -0700 (PDT)
Received: from whydoubt.T-mobile.com (ip68-12-240-88.ok.ok.cox.net. [68.12.240.88])
        by smtp.gmail.com with ESMTPSA id f81sm1429917oih.1.2017.05.23.22.16.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 May 2017 22:16:24 -0700 (PDT)
From:   Jeff Smith <whydoubt@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Jeff Smith <whydoubt@gmail.com>
Subject: [PATCH 07/29] blame: rename coalesce function
Date:   Wed, 24 May 2017 00:15:15 -0500
Message-Id: <20170524051537.29978-8-whydoubt@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170524051537.29978-1-whydoubt@gmail.com>
References: <20170524051537.29978-1-whydoubt@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Functions that will be publicly exposed should have names that better
reflect what they are a part of.

Signed-off-by: Jeff Smith <whydoubt@gmail.com>
---
 builtin/blame.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 7854770..7c493d2 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -384,7 +384,7 @@ static void sanity_check_refcnt(struct blame_scoreboard *);
  * contiguous lines in the same origin (i.e. <commit, path> pair),
  * merge them together.
  */
-static void coalesce(struct blame_scoreboard *sb)
+static void blame_coalesce(struct blame_scoreboard *sb)
 {
 	struct blame_entry *ent, *next;
 
@@ -2885,7 +2885,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 
 	sb.ent = blame_sort(sb.ent, compare_blame_final);
 
-	coalesce(&sb);
+	blame_coalesce(&sb);
 
 	if (!(output_option & OUTPUT_PORCELAIN))
 		find_alignment(&sb, &output_option);
-- 
2.9.3


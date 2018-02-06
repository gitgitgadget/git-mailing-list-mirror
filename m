Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC5FC1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752343AbeBFA3G (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:29:06 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:40687 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752125AbeBFA3F (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:29:05 -0500
Received: by mail-pl0-f66.google.com with SMTP id g18so136654plo.7
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6LgZ6pfEn5Tuwmk7xZys2Ihpkk0beaZmNXB4ouETTBc=;
        b=ADH25WqstohBw3sT/yf8AJW1F9Uk6u3JFnAlUyo/G5k6hY1P0u1IuLinGuTz2Fv0i2
         5dw2S8NiB1EQVmkQWecY78L7uNR0ZsLWaZD24wjVcYs1jv8txegvcgRTtVsBe1BXRTlT
         2Uq/q6uBzuDyt4EdlyJlCpIrEZJZdGONpBAt+6plaNzIBC6ewkGuBn7y5jPo20VLmirP
         5+phy9vKA/tn7XUreJ9hmsYqP4qR7OfqaXdTLqdjeKRmUki5IxfqUazMBZxCIJD6761h
         nbfUdq+oRAu7jFhy+dHzSBXibvNYPGR81WNw2Etou1yOOeUJu2vPIDdbELzNTKPkpVqS
         sxSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6LgZ6pfEn5Tuwmk7xZys2Ihpkk0beaZmNXB4ouETTBc=;
        b=R5vxgUEy+f7hBuWnEdr7Gz2WDJ0sQD0k7FkIG93uSjL4SvmIKUsVacELC/w8E0I8Vo
         KdqnJ3vKRm87oBHcDS+83HiakpfgTs9ILBIXySD7dxPwbqRx3Zq4/IiUrqkw6XWgOjTs
         BlbEB4hdSlhucFaDINGNuLZYzUaPT+QlzrB97V73bzyc9vOpH2S11yjVSfS0ENT2djYE
         whgwaGbN067FPdr0Bq/apKFlI6Wz05y4GVa4KtHwbbcrg8rxR3YM9WxOWlJv5p6DI5Sl
         gTWGPm6m0uUu4ckA32Yh7wKI9R6rdU61okDI1lOr5Bkh5HCnKIZk8L93I+McKOb6IAbB
         MmGA==
X-Gm-Message-State: APf1xPAf2daAlA9gIQA0uez6smTIGrjbkPk8b9W/+ARnd24EsPZD352N
        cjhG2Z5uRVQTRArG7StCCriCxeGUaSo=
X-Google-Smtp-Source: AH8x226/PbA1HxoJq7xhNsOGxcf2CAhMtRRkhRWyTrnf5lIB3uVcDCX9lxJwFkCr/ftds/Db8WiKFw==
X-Received: by 2002:a17:902:242:: with SMTP id 60-v6mr580537plc.376.1517876943617;
        Mon, 05 Feb 2018 16:29:03 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id p25sm4848542pgd.19.2018.02.05.16.29.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:29:03 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 169/194] commit: allow remove_redundant to handle arbitrary repositories
Date:   Mon,  5 Feb 2018 16:17:24 -0800
Message-Id: <20180206001749.218943-71-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/commit.c b/commit.c
index 3ed46e7372..a8f964c6f9 100644
--- a/commit.c
+++ b/commit.c
@@ -913,8 +913,7 @@ struct commit_list *get_octopus_merge_bases(struct commit_list *in)
 	return ret;
 }
 
-#define remove_redundant(r, a, c) remove_redundant_##r(a, c)
-static int remove_redundant_the_repository(struct commit **array, int cnt)
+static int remove_redundant(struct repository *r, struct commit **array, int cnt)
 {
 	/*
 	 * Some commit in the array may be an ancestor of
@@ -932,7 +931,7 @@ static int remove_redundant_the_repository(struct commit **array, int cnt)
 	ALLOC_ARRAY(filled_index, cnt - 1);
 
 	for (i = 0; i < cnt; i++)
-		parse_commit(the_repository, array[i]);
+		parse_commit(r, array[i]);
 	for (i = 0; i < cnt; i++) {
 		struct commit_list *common;
 
@@ -944,7 +943,7 @@ static int remove_redundant_the_repository(struct commit **array, int cnt)
 			filled_index[filled] = j;
 			work[filled++] = array[j];
 		}
-		common = paint_down_to_common(the_repository, array[i], filled, work);
+		common = paint_down_to_common(r, array[i], filled, work);
 		if (array[i]->object.flags & PARENT2)
 			redundant[i] = 1;
 		for (j = 0; j < filled; j++)
-- 
2.15.1.433.g936d1b9894.dirty


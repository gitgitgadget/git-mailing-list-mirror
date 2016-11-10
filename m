Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE09A20229
	for <e@80x24.org>; Thu, 10 Nov 2016 20:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965434AbcKJUfG (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 15:35:06 -0500
Received: from mail-pf0-f178.google.com ([209.85.192.178]:35217 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965299AbcKJUfD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 15:35:03 -0500
Received: by mail-pf0-f178.google.com with SMTP id i88so151081480pfk.2
        for <git@vger.kernel.org>; Thu, 10 Nov 2016 12:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cB8rsm3GUv0PI9Yx1Zq5PvwecVhuk8OS36g1ovvv7kQ=;
        b=B8qsRKhEDn1vH4w4anl8NcFAw8rpBizwVc5osVlVPwxV49+lOHw0c7uF1r7vlN52kL
         4wbtiVKKFnA2UZIj4cl46Ak/Y3DCQRMGZ2otWtoCayXOE912gFv6LHxsK8ZmaoKLs+9x
         NsaNapRGyH7/qFRWacxAqhfJqGB40PheIE3CN93GozMxmVlUlC1o6za3FKE3uRHTewbt
         Oqc4bQBC205oTo2XtfxaemLBWOxdwd3n6ldF985vJgfIfPloSsbtwU7hYqFWd5QS8CgM
         2zC5tJWVnCDAaCeWNll/LlRrJwO5XYvJdHUNlXMTTuBa63i12i4rVYqDrwii3VAlWNvs
         BwNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cB8rsm3GUv0PI9Yx1Zq5PvwecVhuk8OS36g1ovvv7kQ=;
        b=GUYYxvySdDKwZu018b9wo1DMdbRgfIp6hniYZ2ywi60pf0AQFHffYXL/r5cnJyqjss
         dP8VF9bOOZRBPFtqo8wYSAr078I0Qzd/e89aB4znTy84j3V4PFRNhzQ6m4xQEsMLRLqX
         QMc9mkpK8NiZLd/11pOx+Ud6Z6b+uLK+tQw/S/9MpgZBVAO1dWT2pxI9tWJc5jE0Gu29
         BVsX+3eN4OsIt+fWhaQYMS5Q6XU0CFOt9F07BMOS/qhdcnXT1jpFk8YYldOvmOmotBrw
         uhTGIADjeI3IuxkFrS1bVOySibLxEvSwc5cVmlAzlwTNcastJwjlGaEkEdWprJ2MktMg
         qNqg==
X-Gm-Message-State: ABUngvcA429WYkOZSE4Qyd94+dxruD7bgoPkzO7vTZSun4dP4IZHWx6gA78NziRzaUBZUZqz
X-Received: by 10.99.232.17 with SMTP id s17mr38468229pgh.127.1478810102220;
        Thu, 10 Nov 2016 12:35:02 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:b504:dcf8:965a:7ab8])
        by smtp.gmail.com with ESMTPSA id p6sm9344469pae.16.2016.11.10.12.35.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 10 Nov 2016 12:35:01 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, bmwill@google.com, pclouds@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 20/35] attr.c: rename a local variable check
Date:   Thu, 10 Nov 2016 12:34:13 -0800
Message-Id: <20161110203428.30512-21-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.469.g00a8914
In-Reply-To: <20161110203428.30512-1-sbeller@google.com>
References: <20161110203428.30512-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

Throughout this series, we are trying to use "check" to name an
instance of "git_attr_check" structure; let's rename a "check" that
refers to an array whose elements are git_attr_check_elem to avoid
confusion.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 attr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/attr.c b/attr.c
index 219ab11..e18098c 100644
--- a/attr.c
+++ b/attr.c
@@ -682,12 +682,12 @@ static int macroexpand_one(int attr_nr, int rem);
 
 static int fill_one(const char *what, struct match_attr *a, int rem)
 {
-	struct git_attr_check_elem *check = check_all_attr;
+	struct git_attr_check_elem *celem = check_all_attr;
 	int i;
 
 	for (i = a->num_attr - 1; 0 < rem && 0 <= i; i--) {
 		struct git_attr *attr = a->state[i].attr;
-		const char **n = &(check[attr->attr_nr].value);
+		const char **n = &(celem[attr->attr_nr].value);
 		const char *v = a->state[i].setto;
 
 		if (*n == ATTR__UNKNOWN) {
-- 
2.10.1.469.g00a8914


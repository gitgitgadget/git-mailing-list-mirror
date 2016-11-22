Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96F021FF30
	for <e@80x24.org>; Tue, 22 Nov 2016 10:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755875AbcKVKBI (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 05:01:08 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35274 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755864AbcKVKBE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 05:01:04 -0500
Received: by mail-pg0-f67.google.com with SMTP id p66so1701619pga.2
        for <git@vger.kernel.org>; Tue, 22 Nov 2016 02:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RQCzQscH7xVJVEYEx/kJ7+qV8/Dspg4l8xgOeRADtG0=;
        b=kCQbxLSPRmT8s4o8D6FGetJR0ZzKHYZQVfg3ubC58hPmGx7g7xjwv7Af0fcOGD4JJK
         NRX5/dqDYvsR29FusMSodechS796yaMMSvuW7YCsiNzxlfMJcNWmAQPfZTkXdLtE46e7
         zKlzqihaamzeHASqfYPs6zEdJnyUrwTi7+CCUkjb407Ck1AOX9u0QtCHhIjnDE19NccW
         YuEVgZ7rhNRBUr3pHf6zIiOvoUFWTI4FL7W0rkZMr/eC2eveZ5Uu5hisCLP+L/T1FUIY
         0kko3PmG/YLqkZNpL0LV4bamZ4qxPCX87gRcacgfzJt7OlcuyZobADBfEbkMefXKymOA
         VkmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RQCzQscH7xVJVEYEx/kJ7+qV8/Dspg4l8xgOeRADtG0=;
        b=iXY4DhBN77iViMpxFC/DL8COpPLowIakgfR29myclLAXiKzMO4C6M44J3JZpauvBh/
         BbBJ5rxIrID+1d49yxfLICRUsQC0lVs+IWcOZIwlxNEeUFww+KhxVWos7Io+1gh9pYbz
         6Gi+46KPIlXz9Zz3e2ATXwnWdUEsp1WU4STqO11db9wetikcAPw91vr+gf0yOTyyQZky
         eFRnV6nimu/pcyNIyVQCJ8TIElU0h3xMsiRYO+0SS3izOHXJaZh5so4nhIgp/Zg0OrPV
         ztG79mfpuaLQ4tgMcUi6dM+j/AbAP3GzQNTgp1voHR85BnFaZsWfn7cb0v7k6K2H0IiR
         8PbQ==
X-Gm-Message-State: AKaTC016dg0t27c+cjzYBvkz8EWbMfQ63g2TWzsJ0ux4TOXMP8uGKwXFzPNT4Kq/3GdR3w==
X-Received: by 10.98.85.198 with SMTP id j189mr9086475pfb.182.1479808863512;
        Tue, 22 Nov 2016 02:01:03 -0800 (PST)
Received: from ash ([115.73.175.91])
        by smtp.gmail.com with ESMTPSA id g22sm25833980pgn.20.2016.11.22.02.01.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Nov 2016 02:01:03 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 22 Nov 2016 17:00:58 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, rappazzo@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 1/3] worktree.c: zero new 'struct worktree' on allocation
Date:   Tue, 22 Nov 2016 17:00:44 +0700
Message-Id: <20161122100046.8341-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20161122100046.8341-1-pclouds@gmail.com>
References: <20161122100046.8341-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This keeps things a bit simpler when we add more fields, knowing that
default values are always zero.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 worktree.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/worktree.c b/worktree.c
index f7869f8..f7c1b5e 100644
--- a/worktree.c
+++ b/worktree.c
@@ -91,16 +91,11 @@ static struct worktree *get_main_worktree(void)
 	if (parse_ref(path.buf, &head_ref, &is_detached) < 0)
 		goto done;
 
-	worktree = xmalloc(sizeof(struct worktree));
+	worktree = xcalloc(1, sizeof(*worktree));
 	worktree->path = strbuf_detach(&worktree_path, NULL);
-	worktree->id = NULL;
 	worktree->is_bare = is_bare;
-	worktree->head_ref = NULL;
 	worktree->is_detached = is_detached;
-	worktree->is_current = 0;
 	add_head_info(&head_ref, worktree);
-	worktree->lock_reason = NULL;
-	worktree->lock_reason_valid = 0;
 
 done:
 	strbuf_release(&path);
@@ -138,16 +133,11 @@ static struct worktree *get_linked_worktree(const char *id)
 	if (parse_ref(path.buf, &head_ref, &is_detached) < 0)
 		goto done;
 
-	worktree = xmalloc(sizeof(struct worktree));
+	worktree = xcalloc(1, sizeof(*worktree));
 	worktree->path = strbuf_detach(&worktree_path, NULL);
 	worktree->id = xstrdup(id);
-	worktree->is_bare = 0;
-	worktree->head_ref = NULL;
 	worktree->is_detached = is_detached;
-	worktree->is_current = 0;
 	add_head_info(&head_ref, worktree);
-	worktree->lock_reason = NULL;
-	worktree->lock_reason_valid = 0;
 
 done:
 	strbuf_release(&path);
-- 
2.8.2.524.g6ff3d78


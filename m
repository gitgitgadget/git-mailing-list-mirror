Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E13E1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752299AbeBFA3E (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:29:04 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:40738 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752125AbeBFA3D (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:29:03 -0500
Received: by mail-pg0-f66.google.com with SMTP id g2so178984pgn.7
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LXH6m336gKgMKY8bBgfRDC9aUaUI0LYSZNPqjf9ZRoE=;
        b=h9yTFhZiDY9gFbJqeV9ET4nv3u1tpj1a71XFvmMt2wnowUBibBZSRewABvUyXo/HOp
         RXAy/as5pPfBUs29pJxvhqrDQxo/I9QodGuDALOlpWxTD77+xlJd8vKf8LSGuCK4bV8i
         xmP/gR3gz/ZMFsGr7WbyZE3f0UqZykvi3+mRgQ5i0PRb7/MoyOisjlCUGkf9gmSt0OI3
         DYeswImRr2uE111tMbXi72s5gIAiTxZn6b5OttO75V/hal3ZjK81kX+3PAOeRdFmeyxn
         xjr4lhXevNwP269LrPR2EU/oUAhVIU/itDXBPvHilU6qfJrrBznaztl2dB1SJpIIMplJ
         WVPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LXH6m336gKgMKY8bBgfRDC9aUaUI0LYSZNPqjf9ZRoE=;
        b=fo7A2DyF7qb1E/GVnqx0df5ujwGTABUgOD6SFpoZacrbA76LImtOOE//PIOKdjZjtJ
         1gWIHOth7mKTmOPeoXucTTFHDC/CQA5aWp73PhaHgFaCw6ODydgrvID0kc71ODTvKko1
         Y+WyXOsrj0pPmsAIw8G2oxUCmRzZVnh/DMikDrpw56LWdNtvGQ/SQqsCyHi3fVz+v7QX
         H+Dpod0Gau6RrO4AtWiHqvgSDcqZXvCf+Wf6OCW6imKnKq9K9ns/LXC/juAtfOjj902V
         jdhs/w2a3ZDUDbK51riwGdsV2cqHzC2YL4jNU/XmEMyynkvScu52aJOvbQJrOE+Q/03m
         KkKw==
X-Gm-Message-State: APf1xPDTUtUycBZQwT9U0ax1n7MaZzaSEgoNXn0UQhQTr/wEeWQuTHcV
        4aKR/JjjDwv8Y0E8zJ4VO2CmjBXDk+g=
X-Google-Smtp-Source: AH8x226m5AKgZgiDgabhl8HZjsxks07ga+DHmJFPDpGGlj/C8PG6rf/HxN53jLqMqAHwbSdXzhUOaQ==
X-Received: by 10.99.61.205 with SMTP id k196mr460970pga.370.1517876942208;
        Mon, 05 Feb 2018 16:29:02 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id b66sm19188935pfd.182.2018.02.05.16.29.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:29:01 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 168/194] commit: add repository argument to remove_redundant
Date:   Mon,  5 Feb 2018 16:17:23 -0800
Message-Id: <20180206001749.218943-70-sbeller@google.com>
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
 commit.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/commit.c b/commit.c
index b01352f54a..3ed46e7372 100644
--- a/commit.c
+++ b/commit.c
@@ -913,7 +913,8 @@ struct commit_list *get_octopus_merge_bases(struct commit_list *in)
 	return ret;
 }
 
-static int remove_redundant(struct commit **array, int cnt)
+#define remove_redundant(r, a, c) remove_redundant_##r(a, c)
+static int remove_redundant_the_repository(struct commit **array, int cnt)
 {
 	/*
 	 * Some commit in the array may be an ancestor of
@@ -1003,7 +1004,7 @@ static struct commit_list *get_merge_bases_many_0_the_repository(struct commit *
 	clear_commit_marks(one, all_flags);
 	clear_commit_marks_many(n, twos, all_flags);
 
-	cnt = remove_redundant(rslt, cnt);
+	cnt = remove_redundant(the_repository, rslt, cnt);
 	result = NULL;
 	for (i = 0; i < cnt; i++)
 		commit_list_insert_by_date(rslt[i], &result);
@@ -1105,7 +1106,7 @@ struct commit_list *reduce_heads(struct commit_list *heads)
 			p->item->object.flags &= ~STALE;
 		}
 	}
-	num_head = remove_redundant(array, num_head);
+	num_head = remove_redundant(the_repository, array, num_head);
 	for (i = 0; i < num_head; i++)
 		tail = &commit_list_insert(array[i], tail)->next;
 	free(array);
-- 
2.15.1.433.g936d1b9894.dirty


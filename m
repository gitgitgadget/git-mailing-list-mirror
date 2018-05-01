Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 755351FADF
	for <e@80x24.org>; Tue,  1 May 2018 21:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751175AbeEAVeZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 17:34:25 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36772 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751245AbeEAVeV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 17:34:21 -0400
Received: by mail-pf0-f195.google.com with SMTP id w129so4547419pfd.3
        for <git@vger.kernel.org>; Tue, 01 May 2018 14:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Aan1N6Ikv7AJZqa2FMPlbukN7yIqKE53YCLfHUCdz5c=;
        b=IelTC0hlR3zKjRbh+96Ot8oZrhkdl43adfHCaomlgh1vO/N0g6A1TiNNV+C4VY3F72
         sWCjxO/KlwkyuNI5lE0zUJBQILGrz4ajT6OsKZVbTtICXvTRHQHnB5Hy1zY//0vVpIXu
         9IILlKl/zYP0tA40a6kkiW7L4kd4NDk7QpRdXO5ssz0HmyB77d/BbiBBvqK6Mj/7HO/g
         HQ+di3d8bApg9SoCzPc+PyJEyQ8RGMspR5w7NxXnO8zo5ikP3Hn6Q8NwcIW9OarYcHPx
         4MiJsZq5MMqswxLGQK33xjWl70WMo12KG0jOClkWjzZelqeY5itJbqNeeq1jnC2SM13d
         2VIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Aan1N6Ikv7AJZqa2FMPlbukN7yIqKE53YCLfHUCdz5c=;
        b=a8GuHUS3XYsh4Z9He7Lm84JXDSRHxxdKSzN6BXPq+Zzo61myv3LKPTIC/qvMSIrVi8
         OpkOFulzSbiue1HWxNyFN4pk3L+ZWTfL8+b7499BkMLGn/Qi74HnIgP29D3B7U8h7WSb
         2WyKrodiCcijG6o5xqY5CIsGi9Bu668mw96mCCF58GY/Oi3dlLSKj6eUNx4fAG99SKdo
         UPonoMcWzgswnIg/OWPvbD3zXGuD4VbJY9KbNJUHOhZaQ/FgHc0I9NnQfeJNm92AjXCg
         YhN83mVqqM+oEiK7K0fCv8amk6ft8At9FYgAdjPbCl0vcpunKlm0Oip6uVbmuriZ/B/C
         khTw==
X-Gm-Message-State: ALQs6tAFHHKFbV7HPNrd9m69/moGjqiBYT9b5fR8plTFpSe4FyB1I/ef
        rpO/dUN7RFBbS/M9VN0mBLoK5/RBHE4=
X-Google-Smtp-Source: AB8JxZrks68ttzEsAJrR18MVdCKoZqFb6A1zjwdPdrnLQsuFGz5fDHtCOQ4k9jiRl8dkGKnIE3iOIw==
X-Received: by 2002:a17:902:6b86:: with SMTP id p6-v6mr17903110plk.32.1525210460747;
        Tue, 01 May 2018 14:34:20 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id y13-v6sm28813875pge.34.2018.05.01.14.34.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 May 2018 14:34:20 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jamill@microsoft.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 09/13] alloc: add repository argument to alloc_report
Date:   Tue,  1 May 2018 14:33:59 -0700
Message-Id: <20180501213403.14643-10-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180501213403.14643-1-sbeller@google.com>
References: <20180501213403.14643-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 alloc.c | 2 +-
 cache.h | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/alloc.c b/alloc.c
index f031ce422d9..28b85b22144 100644
--- a/alloc.c
+++ b/alloc.c
@@ -105,7 +105,7 @@ static void report(const char *name, unsigned int count, size_t size)
 #define REPORT(name, type)	\
     report(#name, name##_state.count, name##_state.count * sizeof(type) >> 10)
 
-void alloc_report(void)
+void alloc_report_the_repository(void)
 {
 	REPORT(blob, struct blob);
 	REPORT(tree, struct tree);
diff --git a/cache.h b/cache.h
index 2d60359a964..01cc207d218 100644
--- a/cache.h
+++ b/cache.h
@@ -1774,7 +1774,8 @@ extern void *alloc_commit_node_the_repository(void);
 extern void *alloc_tag_node_the_repository(void);
 #define alloc_object_node(r) alloc_object_node_##r()
 extern void *alloc_object_node_the_repository(void);
-extern void alloc_report(void);
+#define alloc_report(r) alloc_report_##r()
+extern void alloc_report_the_repository(void);
 extern unsigned int alloc_commit_index(void);
 
 /* pkt-line.c */
-- 
2.17.0.441.gb46fe60e1d-goog


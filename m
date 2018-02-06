Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 878391F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752285AbeBFA2g (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:28:36 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35379 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752171AbeBFA2e (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:28:34 -0500
Received: by mail-pg0-f67.google.com with SMTP id o13so187355pgs.2
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GQfuQdDJymjJ4wQKebSGzfaFtgAYVBzVNAutcZDK0r0=;
        b=PRQvbNuNyD7Qan+0fc9qMFIaRejRjB8z7Z/jD7RowZahoBA7ys7KxAI+oyN+noyKrn
         kWvhF+0+4Z8fxeOdcke6A5UvdqOFVYURGbB1yRxBDjzvpCkXICod4FJ3nYW+lMw1n+P+
         RjY5BDbcXNQp70V/KA5Ry2mQkiwwN48oZ+npBBfPeBs4C7EjoOi3M7F4341+AAvtUjNz
         uHWU5/G3til2+IWRPQw8getugdaUZSoGzRHJLTmtkFgYo1XUDjD8czq2sH/PlyGfj5iu
         Q2loF2DBhW4va8ZbDzY4cM6QqPDDi529wK27y3EJN1njQES0Ey5uGxoOo509WAK5XNUV
         zq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GQfuQdDJymjJ4wQKebSGzfaFtgAYVBzVNAutcZDK0r0=;
        b=OLW/ueclOTFZyXsacZ0fg7z4Fgekx5ye8EFJh/8c12yhP++s32uJOnRvMGPQRmAAdZ
         Kw0fcWNQCFToiwVCzXBC6ZCdHzMoyIDGeCsKq+X0Q9bopCRO2G2BqhufBV7OChPLNuGz
         4SXzFj2s4Awb3oKxlCGpSboPF7vr/FPHz2WzBzzI6bC+ZxQtP6CEF37bsMyvdp2QGSLS
         t3BYy2eFSBeUiwA/YobaZxmVUmXbw8BAPkKhBXs3X9cIkAdNXpj1Uxp2UCHHunRJWWna
         WtrBq1LSQO12vPeqOw3tUSu6wf0uuDftcfpASaz4FCqXwzLVHP7LG8fMuRJP6q9qJI8G
         NvMg==
X-Gm-Message-State: APf1xPBXQBPOiOUNs+iyx3dobiNKRnRSoxbMnCRp5CjaJvwz4Oee56zR
        z4g7061bEXVNtwf/iW8HCYs4skV2Y3o=
X-Google-Smtp-Source: AH8x225y8UyPquzXNMlqMYMNF1IgeAlHBdWUS8dWbGpMWLVwn2sm7WfQFaBM4A7DEfFsK+XW5dCulA==
X-Received: by 10.98.103.83 with SMTP id b80mr587396pfc.12.1517876913671;
        Mon, 05 Feb 2018 16:28:33 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id f79sm20213807pfd.103.2018.02.05.16.28.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:28:33 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 165/194] commit: allow parse_commit to handle arbitrary repositories
Date:   Mon,  5 Feb 2018 16:17:20 -0800
Message-Id: <20180206001749.218943-67-sbeller@google.com>
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
 commit.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/commit.h b/commit.h
index 153f13600b..b60c287e7d 100644
--- a/commit.h
+++ b/commit.h
@@ -66,10 +66,9 @@ struct commit *lookup_commit_or_die(const struct object_id *oid, const char *ref
 
 int parse_commit_buffer(struct repository *r, struct commit *item, const void *buffer, unsigned long size);
 int parse_commit_gently(struct repository *r, struct commit *item, int quiet_on_missing);
-#define parse_commit(r, i) parse_commit_##r(i)
-static inline int parse_commit_the_repository(struct commit *item)
+static inline int parse_commit(struct repository *r, struct commit *item)
 {
-	return parse_commit_gently(the_repository, item, 0);
+	return parse_commit_gently(r, item, 0);
 }
 void parse_commit_or_die(struct commit *item);
 
-- 
2.15.1.433.g936d1b9894.dirty


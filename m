Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1541E1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752177AbeBFAPW (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:15:22 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:46358 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752056AbeBFAPV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:15:21 -0500
Received: by mail-pg0-f68.google.com with SMTP id s9so136360pgq.13
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JZXrGKEMQr9OHptvEAUu36D/W6RygtcH7Nyf8wSdxQs=;
        b=lQ3tF8f7vfqg50Jnoxw/3TYN7rYrUY3xTbs4lP2FWtBqhgVrQPGikSUS6Fm3MDskf7
         SrUz6tvBoZLInuBsl3OKGhZXR6Qdq/XhtYhh1Ie8yMPdE/apSJ6esgKMj6wZhoaSkrSV
         rTMt8n/MIB96Xiuc/DZYrJh+Q6wqtOzGrQIdlJi9QfcVfuN40o6W+3br6+ZapAngOxY2
         SmGspVuHnJxGDy+O7fcAqbWq+oY5LPs0zVOGdA5ACROMgFBzHZuE8Apc6MLki0C9mLZl
         4Ccot4uEKSkfmQA/kxCHbbyUX+3Px8h6DAbCDU1QFn/51TZe1cDX1zgdJUvsrF8f3x5K
         balA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JZXrGKEMQr9OHptvEAUu36D/W6RygtcH7Nyf8wSdxQs=;
        b=KIWUZ7Zd7Pc5NLkvQBgCP2MWv/pD5A3LoBdXlGJZ67ZENA+oIM5DG/fC1eXPfU9uEu
         wheeugSGLJKRzbSeZxE+f/XpEGE5qWYwYgsU0wbfDsg9bxckf8u4tV010+604zSUW5tM
         K4s+hbpg66PgIPKFZ05gO2907XF0+rlIapZ8uo50qjicUNJeWfeInkTtQYZjdKyrfcsp
         gyozAlCB/KR7DQVDvkEksSIPff18DSSvgYge4YSBLIdIrbCB7evDNQBDrcUh+QvSStM1
         9xryNz7iy4LgeQuVzcRjX/EpCYT+ZXa19faLQPlnx647qQQwLm5tgxk8BJqbDMEcexqp
         tjNQ==
X-Gm-Message-State: APf1xPAsYIxAqVzqd4h51y2V0fFMLqsdzv4IcAsqTjEe8vxL768c5wMt
        gMvJRYcZzkNBYbo0hRRvo1CX0HeRvk8=
X-Google-Smtp-Source: AH8x226hpX2CpyUbwdBWKdQYNAo3sleVSr0zLbg5L1auKZbnPhJLrtSL6Eu2GTTetYuf+Q5S1LmnRg==
X-Received: by 10.99.125.78 with SMTP id m14mr416244pgn.383.1517876120348;
        Mon, 05 Feb 2018 16:15:20 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id d8sm18646930pfh.93.2018.02.05.16.15.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:15:19 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 097/194] object: add repository argument to prepare_commit_graft
Date:   Mon,  5 Feb 2018 15:55:58 -0800
Message-Id: <20180205235735.216710-77-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235735.216710-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Nieder <jrnieder@gmail.com>

Add a repository argument to allow the caller of prepare_commit_graft
to be more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/commit.c b/commit.c
index d2c6367f85..fbe27cf436 100644
--- a/commit.c
+++ b/commit.c
@@ -198,7 +198,8 @@ static int read_graft_file_the_repository(const char *graft_file)
 	return 0;
 }
 
-static void prepare_commit_graft(void)
+#define prepare_commit_graft(r) prepare_commit_graft_##r()
+static void prepare_commit_graft_the_repository(void)
 {
 	static int commit_graft_prepared;
 	char *graft_file;
@@ -215,7 +216,7 @@ static void prepare_commit_graft(void)
 struct commit_graft *lookup_commit_graft(const struct object_id *oid)
 {
 	int pos;
-	prepare_commit_graft();
+	prepare_commit_graft(the_repository);
 	pos = commit_graft_pos(the_repository, oid->hash);
 	if (pos < 0)
 		return NULL;
-- 
2.15.1.433.g936d1b9894.dirty


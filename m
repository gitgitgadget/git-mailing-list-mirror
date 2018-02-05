Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F26171F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752240AbeBFAO6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:14:58 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:44748 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750807AbeBFAOz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:14:55 -0500
Received: by mail-pg0-f65.google.com with SMTP id r1so139981pgn.11
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FqM7rln2SkCcJiDw67xj2j8mIM6ehqKTCTmyX2q5Mfw=;
        b=Jqql8rKNpQtAr20gmMxS4Wk7z1n7WFV/PUOG1N3Y8XkpuwH3jseuxcVZ/hd/UrFSta
         IfsdkVDig0/nUouzKunUjwkf0OShOAm4eyEP0v+Xq7MLSU78WRAOQuXaK9GgUMYqIpNL
         Ug2btHDQo13fnhKklQfPCpV9pQUSGEa7rGvIwMS4IMY7BUjjGXvkGe5bONRvc/CrZt7n
         zoa/1luhEWzbGDbJVD0kqKChAZdAefDYTCJe8ns5eTtsfB50Ki4YJge4bCWTPbsAL1IU
         m8I5kjnT07qdhAqsbJrCIoOmdC+x5PeWeIq6tagRmFaCSjbx/DXXgJUT6tJOHeEwbD4X
         X1WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FqM7rln2SkCcJiDw67xj2j8mIM6ehqKTCTmyX2q5Mfw=;
        b=sKwu5JmvszEmIqKAWygpdgOABdgSYr6xUWeMGAsABciKYJN1Ap6R/x2fiPiOUCNVRi
         lFG7LgzKNuRFKnSetolkY2hxaaet3UK//1jer6lgMnoq2eq9ZkTP5dMMd6N5TlOP/D+I
         Fr/ahO8nmzkPBYJVvS3bvm7ZQFAtcGSKYx4EBCKqNHLotrgshnZ6AY6k5bLmd6v23Wg3
         tP4BrZ4D+fQMxnSb6YPeBGVzwQJ3kXpJCFQty1nwYPGUyI/TkW1IJnUpqBzryTIArICA
         EuEhfSMUfxTx2A4vhDXxntp1sriBEAOx7ucyvVogd+Zch/UMvKxUCEWmp7IuSj7NeA5d
         xYOg==
X-Gm-Message-State: APf1xPAidJ75/M7jNVa/hZmRj1AgRzkprvCb1uR8XUQ0bFDoazhLMOEg
        278c5KtyGysoiUXm0CNmxKQ9JMf3LrY=
X-Google-Smtp-Source: AH8x224DGpuJeqeQGJne9vVtX4M6wcN1oWlarkoNKktwnFTRxtyO4usT67kCCOfMzSr5jYe4KG2YVA==
X-Received: by 10.99.126.93 with SMTP id o29mr416825pgn.201.1517876094101;
        Mon, 05 Feb 2018 16:14:54 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id c8sm18847694pfm.130.2018.02.05.16.14.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:14:53 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 096/194] object: add repository argument to read_graft_file
Date:   Mon,  5 Feb 2018 15:55:57 -0800
Message-Id: <20180205235735.216710-76-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235735.216710-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Nieder <jrnieder@gmail.com>

Add a repository argument to allow the caller of read_graft_file to be
more specific about which repository to handle. This is a small
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
index ce18e41e33..d2c6367f85 100644
--- a/commit.c
+++ b/commit.c
@@ -178,7 +178,8 @@ struct commit_graft *read_graft_line(struct strbuf *line)
 	return NULL;
 }
 
-static int read_graft_file(const char *graft_file)
+#define read_graft_file(r, f) read_graft_file_##r(f)
+static int read_graft_file_the_repository(const char *graft_file)
 {
 	FILE *fp = fopen_or_warn(graft_file, "r");
 	struct strbuf buf = STRBUF_INIT;
@@ -205,7 +206,7 @@ static void prepare_commit_graft(void)
 	if (commit_graft_prepared)
 		return;
 	graft_file = get_graft_file();
-	read_graft_file(graft_file);
+	read_graft_file(the_repository, graft_file);
 	/* make sure shallows are read */
 	is_repository_shallow();
 	commit_graft_prepared = 1;
-- 
2.15.1.433.g936d1b9894.dirty


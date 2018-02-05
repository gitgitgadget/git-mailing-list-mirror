Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CAC61F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752230AbeBFAO1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:14:27 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:43367 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752161AbeBFAO0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:14:26 -0500
Received: by mail-pg0-f66.google.com with SMTP id f6so139439pgs.10
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F7V5/+1NVygGr/CrmoZ0ncJlJ58q+SDxbpl65lytgJw=;
        b=vsRvj+7GRO2uwqwY7Hmb3MFowj5ZKPNJm7KBqsPt79vJWpEfTjKKaLLt/LjdMxpq+0
         klmat7VVgUJkTFQHn6lVlT2/WptYLXBvCW7pXOF8nQ6BDKmfFcrmr1rxQXmnkchyZiAh
         M5JEsQhNbhYTnZpfaMQlk9j5xsrZoMOvImCZ3SDeS6WhE/ZD1g84tSbJ7Le4nYx9dHzA
         M6g2Pl89BKWVo9W2FEbwhK8wGmcb+BfYnc8Nw1pCBg2JMi2Icd3VWA201hPI4GWNy8SV
         jhg7Q1mI7RF7L5FEdOc+wvO83Hi1087ThHykwl1/SeergpWj21oHP++MZ4DTlEf6f340
         5kZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F7V5/+1NVygGr/CrmoZ0ncJlJ58q+SDxbpl65lytgJw=;
        b=edUqpdwKm3nsOE78WOSBiyc77akC7z9Iap3PIy7jlJfLRb2aoK3xczuhu5kmN2Kv11
         fAfNID2mPX13IM0VZtX8CW8IFKXSE9E674aQ8akkgk3YAsfV16ET3apttGeqgQ+EAd8+
         VIwPWjIAfVlD2xehXwOH7n6WgFPRW4c5WzTpyc4/wX+w83sLZ3ZYsjaHFirjzemuOUxS
         vvBX+OuodwkAkqKZELOh+mXo1tQxEdnddSUGWqHDMM01x+Pu22XU9Ku8cNDbyvfx2XEw
         bERB1Kwlmsee1bnOrQxw4WmOE/UWW+96vGD4Hq63C3rTX8pZvdvciNCAvxPIRRvCpGH7
         6fEw==
X-Gm-Message-State: APf1xPCYy7O79zeGbIT9gYkc5D7sVNfo4CzFNgG3+U2C4C+ud0lX3QlI
        7NL3+fz0OaSqqv6p0IZU6HFeLkC8R/w=
X-Google-Smtp-Source: AH8x227p3bkV41b/JDe+mSCtoHeOTisD979G6c5uMCIRUu9pyi1XgvS/rCxUT4MaGkTfjUHSry/t0A==
X-Received: by 10.101.98.147 with SMTP id f19mr431315pgv.100.1517876065310;
        Mon, 05 Feb 2018 16:14:25 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id q87sm234130pfk.71.2018.02.05.16.14.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:14:24 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 093/194] object: add repository argument to commit_graft_pos
Date:   Mon,  5 Feb 2018 15:55:54 -0800
Message-Id: <20180205235735.216710-73-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235735.216710-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Nieder <jrnieder@gmail.com>

Add a repository argument to allow callers of commit_graft_pos to be
more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/commit.c b/commit.c
index 2ad5537ed7..a77c05f51c 100644
--- a/commit.c
+++ b/commit.c
@@ -105,7 +105,8 @@ static const unsigned char *commit_graft_sha1_access(size_t index, void *table)
 	return commit_graft_table[index]->oid.hash;
 }
 
-static int commit_graft_pos(const unsigned char *sha1)
+#define commit_graft_pos(r, s) commit_graft_pos_##r(s)
+static int commit_graft_pos_the_repository(const unsigned char *sha1)
 {
 	return sha1_pos(sha1, the_repository->parsed_objects.grafts,
 			the_repository->parsed_objects.grafts_nr,
@@ -114,7 +115,7 @@ static int commit_graft_pos(const unsigned char *sha1)
 
 int register_commit_graft(struct commit_graft *graft, int ignore_dups)
 {
-	int pos = commit_graft_pos(graft->oid.hash);
+	int pos = commit_graft_pos(the_repository, graft->oid.hash);
 
 	if (0 <= pos) {
 		if (ignore_dups)
@@ -214,7 +215,7 @@ struct commit_graft *lookup_commit_graft(const struct object_id *oid)
 {
 	int pos;
 	prepare_commit_graft();
-	pos = commit_graft_pos(oid->hash);
+	pos = commit_graft_pos(the_repository, oid->hash);
 	if (pos < 0)
 		return NULL;
 	return the_repository->parsed_objects.grafts[pos];
@@ -230,7 +231,7 @@ int for_each_commit_graft(each_commit_graft_fn fn, void *cb_data)
 
 int unregister_shallow(const struct object_id *oid)
 {
-	int pos = commit_graft_pos(oid->hash);
+	int pos = commit_graft_pos(the_repository, oid->hash);
 	if (pos < 0)
 		return -1;
 	if (pos + 1 < the_repository->parsed_objects.grafts_nr)
-- 
2.15.1.433.g936d1b9894.dirty


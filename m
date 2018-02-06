Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA9891F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752293AbeBFA1l (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:27:41 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:39051 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752345AbeBFA1j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:27:39 -0500
Received: by mail-pg0-f65.google.com with SMTP id w17so176052pgv.6
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CJWHHSREqEBUFZvDogxF20pE9+RTEr9gkWNDOY0HQig=;
        b=o/m2IwYwAZSIHfD86CYJ6Ri8UDbZYnXklSoqaQs6HnUTFezm9KKfogeczsKya4/UPb
         jgrwVgNV6Cvp90H+ffscSq5OiLpTTIzj7RKX2iD3S2cE5hfexc5TMCgz10r9E6vmHwvT
         SdIFpseOFb/O7Gt8pRaIfKtnAVB14tymVr0qdQiFCPXP42ADlKeMQqW+6CzvpIrjS6OZ
         JVkuSWAJUqw5k12ROqidWE7CazfKi4Mgq3qITz4RutQMyx/PLas7L/RDRAYnpF3l/Yon
         MPami+VR8X2k68HiYcaPEjcq3ms+MABCRh4BvGOCkT3zqHYrrKhf2p3U8HNDIM3gYqK7
         S2PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CJWHHSREqEBUFZvDogxF20pE9+RTEr9gkWNDOY0HQig=;
        b=phIS2z4r8Jjtb5AMA4B/Xo8yR1T8Rwca9bZXWv3MCsLKXtAZNcQ9mtaHRu563JKaqG
         nKE92um70mv69mSO4ADZt7oC1M1xwnEpIjyAfi5z7/p9ouAGdlxzNe+8K3Mv16wcZ2na
         s8zbyqatUR4mRJ303OF+Z8kmaE0Mx2xuVYj0cV5Kuu2W9f9+py9tKAZY4tP2r2ijv1jQ
         gmSWXx4Vl3Vn+tR/bLY0ymcJqZFMyPlOIk70mP6TCe0iNlbbrrMofPZqwrggj1QGjnMd
         ZmHh7EYApoff4G/nJeeDQw8AT4vhHO0gCgJLGZIHhngdGVthZN1FwFGyuYBWkzPPmL5W
         6PFQ==
X-Gm-Message-State: APf1xPASXcbqnc3EFFirY8vBTjBiWJkTItspy+gfLGLGkU1Ewvwq7ZzW
        UTPABuXAltkQ4BUaxZE0ejyqb1IlfGs=
X-Google-Smtp-Source: AH8x226gTzY1e2gQGIqKKbxD70KJy0chzD2Ia+9NOFL8rEWyzxIB+AXw7FRCQo9rxO3d2X88HQOMzA==
X-Received: by 10.98.189.8 with SMTP id a8mr544082pff.125.1517876857748;
        Mon, 05 Feb 2018 16:27:37 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id d82sm5534381pfk.166.2018.02.05.16.27.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:27:37 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 160/194] commit: allow arbitrary repository argument for parse_commit_buffer
Date:   Mon,  5 Feb 2018 16:17:15 -0800
Message-Id: <20180206001749.218943-62-sbeller@google.com>
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
 commit.c | 10 +++++-----
 commit.h |  3 +--
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/commit.c b/commit.c
index a9660f7401..67d329e13c 100644
--- a/commit.c
+++ b/commit.c
@@ -334,7 +334,7 @@ const void *detach_commit_buffer(struct repository *r, struct commit *commit, un
 	return ret;
 }
 
-int parse_commit_buffer_the_repository(struct commit *item, const void *buffer, unsigned long size)
+int parse_commit_buffer(struct repository *r, struct commit *item, const void *buffer, unsigned long size)
 {
 	const char *tail = buffer;
 	const char *bufptr = buffer;
@@ -354,11 +354,11 @@ int parse_commit_buffer_the_repository(struct commit *item, const void *buffer,
 	if (get_sha1_hex(bufptr + 5, parent.hash) < 0)
 		return error("bad tree pointer in commit %s",
 			     oid_to_hex(&item->object.oid));
-	item->tree = lookup_tree(the_repository, &parent);
+	item->tree = lookup_tree(r, &parent);
 	bufptr += tree_entry_len + 1; /* "tree " + "hex sha1" + "\n" */
 	pptr = &item->parents;
 
-	graft = lookup_commit_graft(the_repository, &item->object.oid);
+	graft = lookup_commit_graft(r, &item->object.oid);
 	while (bufptr + parent_entry_len < tail && !memcmp(bufptr, "parent ", 7)) {
 		struct commit *new_parent;
 
@@ -373,7 +373,7 @@ int parse_commit_buffer_the_repository(struct commit *item, const void *buffer,
 		 */
 		if (graft && (graft->nr_parent < 0 || grafts_replace_parents))
 			continue;
-		new_parent = lookup_commit(the_repository, &parent);
+		new_parent = lookup_commit(r, &parent);
 		if (new_parent)
 			pptr = &commit_list_insert(new_parent, pptr)->next;
 	}
@@ -381,7 +381,7 @@ int parse_commit_buffer_the_repository(struct commit *item, const void *buffer,
 		int i;
 		struct commit *new_parent;
 		for (i = 0; i < graft->nr_parent; i++) {
-			new_parent = lookup_commit(the_repository,
+			new_parent = lookup_commit(r,
 						   &graft->parent[i]);
 			if (!new_parent)
 				continue;
diff --git a/commit.h b/commit.h
index b53053400d..8532ddd69c 100644
--- a/commit.h
+++ b/commit.h
@@ -64,8 +64,7 @@ struct commit *lookup_commit_reference_by_name(const char *name);
  */
 struct commit *lookup_commit_or_die(const struct object_id *oid, const char *ref_name);
 
-#define parse_commit_buffer(r, i, b, s) parse_commit_buffer_##r(i, b, s)
-int parse_commit_buffer_the_repository(struct commit *item, const void *buffer, unsigned long size);
+int parse_commit_buffer(struct repository *r, struct commit *item, const void *buffer, unsigned long size);
 #define parse_commit_gently(r, i, q) parse_commit_gently_##r(i, q)
 int parse_commit_gently_the_repository(struct commit *item, int quiet_on_missing);
 #define parse_commit(r, i) parse_commit_##r(i)
-- 
2.15.1.433.g936d1b9894.dirty


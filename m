Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 567631FAEB
	for <e@80x24.org>; Tue,  6 Feb 2018 00:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752065AbeBFAC4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:02:56 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:40185 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752037AbeBFACx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:02:53 -0500
Received: by mail-pg0-f68.google.com with SMTP id g2so124854pgn.7
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8Qo+OEn0uvA5084aVEhcQFtxudlUg/8dTn8SnxnsvYY=;
        b=PnLLb2NFNdXWjI4AUKMpKr9x8INNcUKgDwjogT36bjqSRtNPRohwoQ9q+Hteu8wj0x
         jkdWnEE0hGv7qREL2oceqnQ9yf91NDdETSDc7zY4987r3zVGOC/G4NSS5TJWr4mt93av
         GMR9HKFURsJwNuIIROTrZWvScQ+dn+rE5apaVSqgmxRMNMLSxKleIOD8AK9li01j7sVR
         86Q8i0aUY9/9i56nyhXdnYgtuAoWjtc/Z3y+UkWmBpHGlk+Kq90FkQZKK4oIuppkzCxx
         z5Cdt8vLfMV0aCS8QxLiKG8Zos6V8nHxqE14zGhLxGhPvrvPteb/VzE6thOJlSG+t3xs
         RKug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8Qo+OEn0uvA5084aVEhcQFtxudlUg/8dTn8SnxnsvYY=;
        b=RJs4CtgmsM7UNK9MaeF+KvkS2AgUBWUwah3Xz9wwONK3kdZeODoCxe/D/nVXyOUpNC
         Uririn1iFssy7+OdZdidlLHkl/P5M3z07vnpexrJ+feJtKA5hu9VSLc+AY9QGmKNMfo9
         MU3/Ev7YHtze8bTmVFiBW+XX6Ij3urVTMhiNC/jhqyHJ6FgRFLeNKlHe97Lzq/yd4tfE
         Z6X9nKnIC5b4HLpJzfyhaDvOaBb0oEdCuwEkI0Yb9lMhvFAXbbGyrCG2TMv/s46LEQn5
         2rbWguG0JWhiWPcqTN7oGh7GZaA2xWZRHKh6iax9tu8UmQCDtSn7cGxVMPzBB2U5WHVT
         o8Ow==
X-Gm-Message-State: APf1xPBKw5vqOW/3a1YNq51Vpk6kjMzf+/8vGM0cUNnmCV8guIlW7zKC
        LS5r8bLInr2+hr68hmKWiTznWFsQyZk=
X-Google-Smtp-Source: AH8x224LcRncbijFWzNgiKSLCQAQ7gthVxBHBKeiaqVSYLuCHjTND1gzBybOV/Sv1k6KP+nu6HWAkQ==
X-Received: by 10.99.126.93 with SMTP id o29mr393957pgn.201.1517875371937;
        Mon, 05 Feb 2018 16:02:51 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id t25sm20335143pfk.162.2018.02.05.16.02.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:02:51 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 044/194] pack: move struct pack_window and pack_entry to packfile.h
Date:   Mon,  5 Feb 2018 15:55:05 -0800
Message-Id: <20180205235735.216710-24-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235735.216710-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Nieder <jrnieder@gmail.com>

This should make these functions easier to find and cache.h less
overwhelming to read.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/pack-objects.c |  1 +
 cache.h                | 15 ---------------
 object-store.h         |  1 +
 pack.h                 |  1 +
 packfile.c             |  1 +
 packfile.h             | 19 +++++++++++++++++++
 6 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index b998e139d1..7cb73c29ac 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -10,6 +10,7 @@
 #include "commit.h"
 #include "tag.h"
 #include "tree.h"
+#include "packfile.h"
 #include "delta.h"
 #include "pack.h"
 #include "pack-revindex.h"
diff --git a/cache.h b/cache.h
index 7be9a8ad27..c66e59733d 100644
--- a/cache.h
+++ b/cache.h
@@ -1544,21 +1544,6 @@ extern int has_dirs_only_path(const char *name, int len, int prefix_len);
 extern void schedule_dir_for_removal(const char *name, int len);
 extern void remove_scheduled_dirs(void);
 
-struct pack_window {
-	struct pack_window *next;
-	unsigned char *base;
-	off_t offset;
-	size_t len;
-	unsigned int last_used;
-	unsigned int inuse_cnt;
-};
-
-struct pack_entry {
-	off_t offset;
-	unsigned char sha1[20];
-	struct packed_git *p;
-};
-
 /*
  * Create a temporary file rooted in the object database directory, or
  * die on failure. The filename is taken from "pattern", which should have the
diff --git a/object-store.h b/object-store.h
index 7a372baa79..3475e22021 100644
--- a/object-store.h
+++ b/object-store.h
@@ -5,6 +5,7 @@
 #include "mru.h"
 #include "replace-object.h"
 #include "alternates.h"
+#include "packfile.h"
 
 struct object_store {
 	struct packed_git *packed_git;
diff --git a/pack.h b/pack.h
index 8294341af1..c0ea2b6499 100644
--- a/pack.h
+++ b/pack.h
@@ -2,6 +2,7 @@
 #define PACK_H
 
 #include "object.h"
+#include "packfile.h"
 #include "csum-file.h"
 
 /*
diff --git a/packfile.c b/packfile.c
index a7504debe5..b73814f2ce 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "mru.h"
+#include "packfile.h"
 #include "pack.h"
 #include "repository.h"
 #include "alternates.h"
diff --git a/packfile.h b/packfile.h
index b3138816e7..1163fc7bb4 100644
--- a/packfile.h
+++ b/packfile.h
@@ -1,6 +1,25 @@
 #ifndef PACKFILE_H
 #define PACKFILE_H
 
+/* in cache.h */
+enum object_type;
+struct object_info;
+
+struct pack_window {
+	struct pack_window *next;
+	unsigned char *base;
+	off_t offset;
+	size_t len;
+	unsigned int last_used;
+	unsigned int inuse_cnt;
+};
+
+struct pack_entry {
+	off_t offset;
+	unsigned char sha1[20];
+	struct packed_git *p;
+};
+
 /*
  * Generate the filename to be used for a pack file with checksum "sha1" and
  * extension "ext". The result is written into the strbuf "buf", overwriting
-- 
2.15.1.433.g936d1b9894.dirty


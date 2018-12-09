Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94CE720A1E
	for <e@80x24.org>; Sun,  9 Dec 2018 10:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbeLIKpI (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Dec 2018 05:45:08 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41337 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbeLIKpH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Dec 2018 05:45:07 -0500
Received: by mail-lf1-f65.google.com with SMTP id c16so5940001lfj.8
        for <git@vger.kernel.org>; Sun, 09 Dec 2018 02:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RJt0KsyqdNkXRGQWYjQLw7jIL0+5GLoMJVYwYqqCCwY=;
        b=Qi3fZZg7zGqVWfAwGu8dNIaqyGTAMLqBHD/54QnEpFsKxgmgSGv2PQM3pi7rTqWVsD
         sjMyibDVUaGhQ7Ty2IWkUP/VP1roWn1zDdpUxfkhx7vb6zlG9KBHHHmI8Xh8x+630ILc
         DY+yfzXCxTOMBwNmckzMTZptR7XXhpi+yAlNuCEoDjflsT/qdeVnppgxh98jBtyxvLUK
         xVoFzRcQm/JyYV3Jf8sMn+DWBowDx29qTf59o3+FB2+GZDKEQaxHrdomlXVGV/RACN90
         Ji/qsjsykRjiQMK4ujJEkuNEJH58dnIja2EfPUzV6zW19fNgo03aMwJcJWz9c+H6sJgw
         O77g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RJt0KsyqdNkXRGQWYjQLw7jIL0+5GLoMJVYwYqqCCwY=;
        b=g/yJiRfKN6ucj3AhmyLRWP7BPSiMqjaoQ7IrLRvoyC7ZdafKIBVDrwAnuNiOLKje7J
         4mTMaRmHmyA4iQSpsOuKCUQ3svIymBpiIixe57HSoT8Y1xyBuCBsnAGCmgnN3qv/mQnQ
         5oESM7Q6HtZTtmn1COjxyxXBNBDmZDTCyI/tN4Onb5/jerWjCq0UDamamCUkYuVmD63k
         H8SM4CyBTMYm0Bos85H2ro422mnW+fW2+khP26UElVDXZs/2MA8GHHUCFIRW0ntxDlY7
         y30pmAjyLkMzUiUNMgzfQpsrwMwfTUBxCzkwna+/zetR33Y5vhaSIgtflNNgAIqNnc7f
         6n6w==
X-Gm-Message-State: AA+aEWaTDMErRCJQGgkdNIRfu/rRHdN6WkVWx7sk1vTsJCV/jJf+M4ej
        9OXjol0x+2pMidWS93tz1ZYqGnEq
X-Google-Smtp-Source: AFSGD/WNSw7KNQk3B6RfgV5gUItR+GP+M6NvePEID5xe1hq8FHTbiY5RhjlKZmkxpwXiA0OHt4DCAA==
X-Received: by 2002:a19:d9d6:: with SMTP id s83mr4939739lfi.57.1544352303989;
        Sun, 09 Dec 2018 02:45:03 -0800 (PST)
Received: from localhost.localdomain (c80-216-2-165.bredband.comhem.se. [80.216.2.165])
        by smtp.gmail.com with ESMTPSA id s3-v6sm1564938lje.73.2018.12.09.02.45.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 02:45:02 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 03/24] read-cache.c: new flag for add_index_entry() to write to backup log
Date:   Sun,  9 Dec 2018 11:43:58 +0100
Message-Id: <20181209104419.12639-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.rc2.486.g9832c05c3d
In-Reply-To: <20181209104419.12639-1-pclouds@gmail.com>
References: <20181209104419.12639-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Index update API is updated to write to backup log if requested. The
entry deletion API is not updated because file removal is not
"interesting" from the undo point of view.

Note, we do double locking when writing $GIT_DIR/index now:

- $GIT_DIR/index.lock is created
- then $GIT_DIR/index.bkl.lock is created

Nobody will lock these in reverse order so no chance for dead lock
(yet)

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 cache.h      |  2 ++
 read-cache.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index ca36b44ee0..51ffae7961 100644
--- a/cache.h
+++ b/cache.h
@@ -336,6 +336,7 @@ struct index_state {
 	uint64_t fsmonitor_last_update;
 	struct ewah_bitmap *fsmonitor_dirty;
 	struct mem_pool *ce_mem_pool;
+	struct strbuf *backup_log;
 };
 
 extern struct index_state the_index;
@@ -745,6 +746,7 @@ extern int index_name_pos(const struct index_state *, const char *name, int name
 #define ADD_CACHE_JUST_APPEND 8		/* Append only; tree.c::read_tree() */
 #define ADD_CACHE_NEW_ONLY 16		/* Do not replace existing ones */
 #define ADD_CACHE_KEEP_CACHE_TREE 32	/* Do not invalidate cache-tree */
+#define ADD_CACHE_LOG_UPDATES 64	/* Log changes in $GIT_DIR/index.bkl */
 extern int add_index_entry(struct index_state *, struct cache_entry *ce, int option);
 extern void rename_index_entry_at(struct index_state *, int pos, const char *new_name);
 
diff --git a/read-cache.c b/read-cache.c
index bd45dc3e24..a53cfabc2e 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -25,6 +25,7 @@
 #include "fsmonitor.h"
 #include "thread-utils.h"
 #include "progress.h"
+#include "backup-log.h"
 
 /* Mask for the name length in ce_flags in the on-disk index */
 
@@ -691,6 +692,21 @@ void set_object_name_for_intent_to_add_entry(struct cache_entry *ce)
 	oidcpy(&ce->oid, &oid);
 }
 
+static void update_backup_log(struct index_state *istate,
+			      const struct object_id *prev,
+			      const struct cache_entry *ce)
+{
+	struct strbuf *sb = istate->backup_log;
+
+	if (!sb) {
+		sb = xmalloc(sizeof(*sb));
+		strbuf_init(sb, 0);
+		istate->backup_log = sb;
+	}
+
+	bkl_append(sb, ce->name, prev, &ce->oid);
+}
+
 int add_to_index(struct index_state *istate, const char *path, struct stat *st, int flags)
 {
 	int namelen, was_same;
@@ -765,6 +781,7 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 			discard_cache_entry(ce);
 			return error("unable to index file %s", path);
 		}
+		add_option |= flags & ADD_CACHE_LOG_UPDATES;
 	} else
 		set_object_name_for_intent_to_add_entry(ce);
 
@@ -1257,6 +1274,7 @@ static int add_index_entry_with_check(struct index_state *istate, struct cache_e
 	int ok_to_replace = option & ADD_CACHE_OK_TO_REPLACE;
 	int skip_df_check = option & ADD_CACHE_SKIP_DFCHECK;
 	int new_only = option & ADD_CACHE_NEW_ONLY;
+	struct object_id backup_prev;
 
 	if (!(option & ADD_CACHE_KEEP_CACHE_TREE))
 		cache_tree_invalidate_path(istate, ce->name);
@@ -1273,8 +1291,12 @@ static int add_index_entry_with_check(struct index_state *istate, struct cache_e
 
 	/* existing match? Just replace it. */
 	if (pos >= 0) {
-		if (!new_only)
-			replace_index_entry(istate, pos, ce);
+		if (new_only)
+			return 0;
+
+		if (option & ADD_CACHE_LOG_UPDATES)
+			update_backup_log(istate, &istate->cache[pos]->oid, ce);
+		replace_index_entry(istate, pos, ce);
 		return 0;
 	}
 	pos = -pos-1;
@@ -1282,6 +1304,7 @@ static int add_index_entry_with_check(struct index_state *istate, struct cache_e
 	if (!(option & ADD_CACHE_KEEP_CACHE_TREE))
 		untracked_cache_add_to_index(istate, ce->name);
 
+	oidclr(&backup_prev);
 	/*
 	 * Inserting a merged entry ("stage 0") into the index
 	 * will always replace all non-merged entries..
@@ -1289,6 +1312,8 @@ static int add_index_entry_with_check(struct index_state *istate, struct cache_e
 	if (pos < istate->cache_nr && ce_stage(ce) == 0) {
 		while (ce_same_name(istate->cache[pos], ce)) {
 			ok_to_add = 1;
+			if (ce_stage(ce) == 2)
+				oidcpy(&backup_prev, &istate->cache[pos]->oid);
 			if (!remove_index_entry_at(istate, pos))
 				break;
 		}
@@ -1307,6 +1332,8 @@ static int add_index_entry_with_check(struct index_state *istate, struct cache_e
 		pos = index_name_stage_pos(istate, ce->name, ce_namelen(ce), ce_stage(ce));
 		pos = -pos-1;
 	}
+	if (option & ADD_CACHE_LOG_UPDATES)
+		update_backup_log(istate, &backup_prev, ce);
 	return pos + 1;
 }
 
@@ -2323,6 +2350,10 @@ int discard_index(struct index_state *istate)
 	discard_split_index(istate);
 	free_untracked_cache(istate->untracked);
 	istate->untracked = NULL;
+	if (istate->backup_log) {
+		strbuf_release(istate->backup_log);
+		FREE_AND_NULL(istate->backup_log);
+	}
 
 	if (istate->ce_mem_pool) {
 		mem_pool_discard(istate->ce_mem_pool, should_validate_cache_entries());
@@ -3157,6 +3188,20 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
 	if (istate->fsmonitor_last_update)
 		fill_fsmonitor_bitmap(istate);
 
+	if (istate->backup_log && istate->backup_log->len) {
+		struct strbuf sb = STRBUF_INIT;
+		char *path = get_locked_file_path(lock);
+
+		strbuf_addf(&sb, "%s.bkl", path);
+		free(path);
+		if (bkl_write(sb.buf, istate->backup_log)) {
+			strbuf_release(&sb);
+			return -1;
+		}
+		strbuf_reset(istate->backup_log);
+		strbuf_release(&sb);
+	}
+
 	if (!si || alternate_index_output ||
 	    (istate->cache_changed & ~EXTMASK)) {
 		if (si)
-- 
2.20.0.rc2.486.g9832c05c3d


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D5AA1F404
	for <e@80x24.org>; Mon,  2 Apr 2018 20:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932434AbeDBUev (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 16:34:51 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:36576 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932424AbeDBUeu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 16:34:50 -0400
Received: by mail-qk0-f195.google.com with SMTP id o205so16398902qke.3
        for <git@vger.kernel.org>; Mon, 02 Apr 2018 13:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pU8lZdmtVPIsgOTpqte08YvWbVKyBjlgTaUp37Ly5CY=;
        b=K0LnIU7ZW0LNGMHyXyHu6lII/5ZS6N52K5I3Jf0hyULgyMFYbESZCEW8H7DGFRB495
         eOXxo4j/xPynESLYqheEofxW+8KaB6DJXwG9pPVJuxbBbr0wO71a6paYLSNvdyXKyV/q
         MxoyGIY+PauKhXZxRpf4GroUixqKbaviqEV6BKjmeF0MiMmaAn70NyXTGO6f8BT+GF3L
         Dq2voPcr7jYSIaGIbD1BlTIlnnUht1htmlCylfDYnNgm+6yuxr8i9ktbiiVTUi9Yg53l
         bM0yf3obylvZ4qpRsS5vL3FxibOBWEqOtIcKWo4n1HbX+8W1iJ3XXqiH5N+dmutW99gE
         +2/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pU8lZdmtVPIsgOTpqte08YvWbVKyBjlgTaUp37Ly5CY=;
        b=l/4Dpu55nKUhJ5ElFf0ESOEqzheA22dSIjiiLrk28dYW1/of4LdRP9IO0jQLGyekF1
         90t7VL7QsX3lboejBapNNcaMAngeW73l3N82oeuaxO8TLzwso6UrZiDceH30BBX1noNS
         U5Hzf0UVeKnmVlm4HAo76UJDrLv8OMidZSliVoZA/CBspYac3uDD4u0OCisa4bP2x5GG
         7/D8yb+EFz2YdQLviQByhRRwlwcLyF0TYX8F8jpbNqd1+POfGV1QLzEufu+YNqX1EwfF
         ud0req9c+TVP/XaLPAyPNh/sjDNqPMJ+Zxr+OwwtCoODnbvrvoz0V/SUh8SGUzPZ7FNh
         GWKQ==
X-Gm-Message-State: ALQs6tBNCACYhCCU0yi7DcP7adRxEJmUtOZetNNrhZ9QC+uVmYIKt7cm
        Z/4RjB1FhdOf46Z1cYhwA3FokWtsuLs=
X-Google-Smtp-Source: AIpwx4/UzmqPfJvbmBGVRJ4DU9ssQU2l7ukVEBIMf8pnrBVY8UNqAl3yFjfMzTyyzvz26B7qEIOoDA==
X-Received: by 10.55.27.20 with SMTP id b20mr14747439qkb.253.1522701289358;
        Mon, 02 Apr 2018 13:34:49 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id n30sm998611qtb.93.2018.04.02.13.34.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Apr 2018 13:34:48 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, szeder.dev@gmail.com,
        ramsay@ramsayjones.plus.com, git@jeffhostetler.com, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v7 01/14] csum-file: rename hashclose() to finalize_hashfile()
Date:   Mon,  2 Apr 2018 16:34:14 -0400
Message-Id: <20180402203427.170177-2-dstolee@microsoft.com>
X-Mailer: git-send-email 2.17.0.rc0
In-Reply-To: <20180402203427.170177-1-dstolee@microsoft.com>
References: <20180314192736.70602-1-dstolee@microsoft.com>
 <20180402203427.170177-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The hashclose() method behaves very differently depending on the flags
parameter. In particular, the file descriptor is not always closed.

Perform a simple rename of "hashclose()" to "finalize_hashfile()" in
preparation for functional changes.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/index-pack.c   | 2 +-
 builtin/pack-objects.c | 6 +++---
 bulk-checkin.c         | 4 ++--
 csum-file.c            | 2 +-
 csum-file.h            | 4 ++--
 fast-import.c          | 2 +-
 pack-bitmap-write.c    | 2 +-
 pack-write.c           | 4 ++--
 8 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index bda84a92ef..8bcf280e0b 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1270,7 +1270,7 @@ static void conclude_pack(int fix_thin_pack, const char *curr_pack, unsigned cha
 			    nr_objects - nr_objects_initial);
 		stop_progress_msg(&progress, msg.buf);
 		strbuf_release(&msg);
-		hashclose(f, tail_hash, 0);
+		finalize_hashfile(f, tail_hash, 0);
 		hashcpy(read_hash, pack_hash);
 		fixup_pack_header_footer(output_fd, pack_hash,
 					 curr_pack, nr_objects,
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index e9d3cfb9e3..ab3e80ee49 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -837,11 +837,11 @@ static void write_pack_file(void)
 		 * If so, rewrite it like in fast-import
 		 */
 		if (pack_to_stdout) {
-			hashclose(f, oid.hash, CSUM_CLOSE);
+			finalize_hashfile(f, oid.hash, CSUM_CLOSE);
 		} else if (nr_written == nr_remaining) {
-			hashclose(f, oid.hash, CSUM_FSYNC);
+			finalize_hashfile(f, oid.hash, CSUM_FSYNC);
 		} else {
-			int fd = hashclose(f, oid.hash, 0);
+			int fd = finalize_hashfile(f, oid.hash, 0);
 			fixup_pack_header_footer(fd, oid.hash, pack_tmp_name,
 						 nr_written, oid.hash, offset);
 			close(fd);
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 9d87eac07b..227cc9f3b1 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -35,9 +35,9 @@ static void finish_bulk_checkin(struct bulk_checkin_state *state)
 		unlink(state->pack_tmp_name);
 		goto clear_exit;
 	} else if (state->nr_written == 1) {
-		hashclose(state->f, oid.hash, CSUM_FSYNC);
+		finalize_hashfile(state->f, oid.hash, CSUM_FSYNC);
 	} else {
-		int fd = hashclose(state->f, oid.hash, 0);
+		int fd = finalize_hashfile(state->f, oid.hash, 0);
 		fixup_pack_header_footer(fd, oid.hash, state->pack_tmp_name,
 					 state->nr_written, oid.hash,
 					 state->offset);
diff --git a/csum-file.c b/csum-file.c
index 5eda7fb6af..e6c95a6915 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -53,7 +53,7 @@ void hashflush(struct hashfile *f)
 	}
 }
 
-int hashclose(struct hashfile *f, unsigned char *result, unsigned int flags)
+int finalize_hashfile(struct hashfile *f, unsigned char *result, unsigned int flags)
 {
 	int fd;
 
diff --git a/csum-file.h b/csum-file.h
index 992e5c0141..9ba87f0a6c 100644
--- a/csum-file.h
+++ b/csum-file.h
@@ -26,14 +26,14 @@ struct hashfile_checkpoint {
 extern void hashfile_checkpoint(struct hashfile *, struct hashfile_checkpoint *);
 extern int hashfile_truncate(struct hashfile *, struct hashfile_checkpoint *);
 
-/* hashclose flags */
+/* finalize_hashfile flags */
 #define CSUM_CLOSE	1
 #define CSUM_FSYNC	2
 
 extern struct hashfile *hashfd(int fd, const char *name);
 extern struct hashfile *hashfd_check(const char *name);
 extern struct hashfile *hashfd_throughput(int fd, const char *name, struct progress *tp);
-extern int hashclose(struct hashfile *, unsigned char *, unsigned int);
+extern int finalize_hashfile(struct hashfile *, unsigned char *, unsigned int);
 extern void hashwrite(struct hashfile *, const void *, unsigned int);
 extern void hashflush(struct hashfile *f);
 extern void crc32_begin(struct hashfile *);
diff --git a/fast-import.c b/fast-import.c
index b5db5d20b1..6d96f55d9d 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1016,7 +1016,7 @@ static void end_packfile(void)
 		struct tag *t;
 
 		close_pack_windows(pack_data);
-		hashclose(pack_file, cur_pack_oid.hash, 0);
+		finalize_hashfile(pack_file, cur_pack_oid.hash, 0);
 		fixup_pack_header_footer(pack_data->pack_fd, pack_data->sha1,
 				    pack_data->pack_name, object_count,
 				    cur_pack_oid.hash, pack_size);
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index e01f992884..662b44f97d 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -535,7 +535,7 @@ void bitmap_writer_finish(struct pack_idx_entry **index,
 	if (options & BITMAP_OPT_HASH_CACHE)
 		write_hash_cache(f, index, index_nr);
 
-	hashclose(f, NULL, CSUM_FSYNC);
+	finalize_hashfile(f, NULL, CSUM_FSYNC);
 
 	if (adjust_shared_perm(tmp_file.buf))
 		die_errno("unable to make temporary bitmap file readable");
diff --git a/pack-write.c b/pack-write.c
index d775c7406d..044f427392 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -170,8 +170,8 @@ const char *write_idx_file(const char *index_name, struct pack_idx_entry **objec
 	}
 
 	hashwrite(f, sha1, the_hash_algo->rawsz);
-	hashclose(f, NULL, ((opts->flags & WRITE_IDX_VERIFY)
-			    ? CSUM_CLOSE : CSUM_FSYNC));
+	finalize_hashfile(f, NULL, ((opts->flags & WRITE_IDX_VERIFY)
+				    ? CSUM_CLOSE : CSUM_FSYNC));
 	return index_name;
 }
 
-- 
2.17.0.14.gba1221a8ce


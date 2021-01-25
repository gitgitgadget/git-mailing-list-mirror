Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25180C433DB
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 23:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1A1E229EF
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 23:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732271AbhAYXi0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 18:38:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732875AbhAYXiC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 18:38:02 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C1EC0613D6
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 15:37:21 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id v3so11063676qtw.4
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 15:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=E/+wS2YlSMS+3dDpd4JqMbC8est/am02ZO7KrV7enZw=;
        b=ceYEr1jsHhyCwZynq2PI041JAhBUjrk5t2i/89u9pHvAtfZtvLYPEEdBWG8S0dYGAJ
         Q8+8JALFLcU4pEYUIgrV7r+SPxdmHmCRpMJP3Xweq6YNK0WOeBzXpkmwQWSBOfKnDOhM
         tDjA79+eIJEo4a795eBM2ogFsEN1J8jr+nZGCq38b4aoPfJWTrSdmuklOLU9k4ScGVIF
         qwOjjAz/meMutZzx3RTAN2K5rSp3Xu7ONTtC+AGYaVSi+cQ5u/KMlvVhT5/snsqYSTzd
         CFHqfTtCxo7wLnJ8/cw29Ikhd9JvqFqlWUii/6n0monvD2etdOlstMSOWNb/9FFtrfdU
         gQCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E/+wS2YlSMS+3dDpd4JqMbC8est/am02ZO7KrV7enZw=;
        b=tvRtPcp5EQUDkuOOTBPOMdZ4Cwf++tpkWA6scFoFx0336JZ2gx7VAOmKpUsQu526Sl
         vmE4Tgy5YxuBCdrf4Dmr3oNkMTyOS33pnVixQ1atooA/zkAb0J71bo7hRx3oXTS6bQ4o
         C+ZTp7qZl7Q3c9SUDqK4ZuU6hkqXGYMq4QQ0fecAXi9giRRO2LLwFo8FAwhi4vrt2DM7
         pOpIREXzCKVcep0IlirlRElJF+2zztWarJnlFBfKDQvUcqdqHdgCriHQwtIl8b7w8ynF
         ADwxKZCrTf/ea2dH/aQUbug7YYckEADenF24M9nsw2TXQMkWs8mAthw6QDqXGhsoYvXG
         Wtqg==
X-Gm-Message-State: AOAM5326iIvFQB+CpAE+NqdL5Xi2khWq4wnoEUJPIqzKuIIG7E1JLEiw
        sSOGzoYFQfTesu/nEbWyyQb4k9MSKp62/A==
X-Google-Smtp-Source: ABdhPJzEuN9k3Sr3ALLaWodBeLjmXkMjxlzAkgH/ugXd/ZLz5eLBbPdMbloxK0AgG6GPXOId8C8Snw==
X-Received: by 2002:ac8:dc5:: with SMTP id t5mr2985819qti.246.1611617840778;
        Mon, 25 Jan 2021 15:37:20 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:5e9f:a2e5:e7ac:394d])
        by smtp.gmail.com with ESMTPSA id y25sm12952057qky.14.2021.01.25.15.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 15:37:20 -0800 (PST)
Date:   Mon, 25 Jan 2021 18:37:18 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, jrnieder@gmail.com,
        peff@peff.net
Subject: [PATCH v3 02/10] pack-write.c: prepare to write 'pack-*.rev' files
Message-ID: <5efc87074246b8d2038569b13045dbe506cc24fa.1611617820.git.me@ttaylorr.com>
References: <cover.1610129989.git.me@ttaylorr.com>
 <cover.1611617819.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1611617819.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch prepares for callers to be able to write reverse index files
to disk.

It adds the necessary machinery to write a format-compliant .rev file
from within 'write_rev_file()', which is called from
'finish_tmp_packfile()'.

Similar to the process by which the reverse index is computed in memory,
these new paths also have to sort a list of objects by their offsets
within a packfile. These new paths use a qsort() (as opposed to a radix
sort), since our specialized radix sort requires a full revindex_entry
struct per object, which is more memory than we need to allocate.

The qsort is obviously slower, but the theoretical slowdown would
require a repository with a large amount of objects, likely implying
that the time spent in, say, pack-objects during a repack would dominate
the overall runtime.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-write.c | 120 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 pack.h       |   4 ++
 2 files changed, 123 insertions(+), 1 deletion(-)

diff --git a/pack-write.c b/pack-write.c
index e9bb3fd949..680c36755d 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -167,6 +167,113 @@ const char *write_idx_file(const char *index_name, struct pack_idx_entry **objec
 	return index_name;
 }
 
+static int pack_order_cmp(const void *va, const void *vb, void *ctx)
+{
+	struct pack_idx_entry **objects = ctx;
+
+	off_t oa = objects[*(uint32_t*)va]->offset;
+	off_t ob = objects[*(uint32_t*)vb]->offset;
+
+	if (oa < ob)
+		return -1;
+	if (oa > ob)
+		return 1;
+	return 0;
+}
+
+static void write_rev_header(struct hashfile *f)
+{
+	uint32_t oid_version;
+	switch (hash_algo_by_ptr(the_hash_algo)) {
+	case GIT_HASH_SHA1:
+		oid_version = 1;
+		break;
+	case GIT_HASH_SHA256:
+		oid_version = 2;
+		break;
+	default:
+		die("write_rev_header: unknown hash version");
+	}
+
+	hashwrite_be32(f, RIDX_SIGNATURE);
+	hashwrite_be32(f, RIDX_VERSION);
+	hashwrite_be32(f, oid_version);
+}
+
+static void write_rev_index_positions(struct hashfile *f,
+				      struct pack_idx_entry **objects,
+				      uint32_t nr_objects)
+{
+	uint32_t *pack_order;
+	uint32_t i;
+
+	ALLOC_ARRAY(pack_order, nr_objects);
+	for (i = 0; i < nr_objects; i++)
+		pack_order[i] = i;
+	QSORT_S(pack_order, nr_objects, pack_order_cmp, objects);
+
+	for (i = 0; i < nr_objects; i++)
+		hashwrite_be32(f, pack_order[i]);
+
+	free(pack_order);
+}
+
+static void write_rev_trailer(struct hashfile *f, const unsigned char *hash)
+{
+	hashwrite(f, hash, the_hash_algo->rawsz);
+}
+
+const char *write_rev_file(const char *rev_name,
+			   struct pack_idx_entry **objects,
+			   uint32_t nr_objects,
+			   const unsigned char *hash,
+			   unsigned flags)
+{
+	struct hashfile *f;
+	int fd;
+
+	if ((flags & WRITE_REV) && (flags & WRITE_REV_VERIFY))
+		die(_("cannot both write and verify reverse index"));
+
+	if (flags & WRITE_REV) {
+		if (!rev_name) {
+			struct strbuf tmp_file = STRBUF_INIT;
+			fd = odb_mkstemp(&tmp_file, "pack/tmp_rev_XXXXXX");
+			rev_name = strbuf_detach(&tmp_file, NULL);
+		} else {
+			unlink(rev_name);
+			fd = open(rev_name, O_CREAT|O_EXCL|O_WRONLY, 0600);
+			if (fd < 0)
+				die_errno("unable to create '%s'", rev_name);
+		}
+		f = hashfd(fd, rev_name);
+	} else if (flags & WRITE_REV_VERIFY) {
+		struct stat statbuf;
+		if (stat(rev_name, &statbuf)) {
+			if (errno == ENOENT) {
+				/* .rev files are optional */
+				return NULL;
+			} else
+				die_errno(_("could not stat: %s"), rev_name);
+		}
+		f = hashfd_check(rev_name);
+	} else
+		return NULL;
+
+	write_rev_header(f);
+
+	write_rev_index_positions(f, objects, nr_objects);
+	write_rev_trailer(f, hash);
+
+	if (rev_name && adjust_shared_perm(rev_name) < 0)
+		die(_("failed to make %s readable"), rev_name);
+
+	finalize_hashfile(f, NULL, CSUM_HASH_IN_STREAM | CSUM_CLOSE |
+				    ((flags & WRITE_IDX_VERIFY) ? 0 : CSUM_FSYNC));
+
+	return rev_name;
+}
+
 off_t write_pack_header(struct hashfile *f, uint32_t nr_entries)
 {
 	struct pack_header hdr;
@@ -342,7 +449,7 @@ void finish_tmp_packfile(struct strbuf *name_buffer,
 			 struct pack_idx_option *pack_idx_opts,
 			 unsigned char hash[])
 {
-	const char *idx_tmp_name;
+	const char *idx_tmp_name, *rev_tmp_name = NULL;
 	int basename_len = name_buffer->len;
 
 	if (adjust_shared_perm(pack_tmp_name))
@@ -353,6 +460,9 @@ void finish_tmp_packfile(struct strbuf *name_buffer,
 	if (adjust_shared_perm(idx_tmp_name))
 		die_errno("unable to make temporary index file readable");
 
+	rev_tmp_name = write_rev_file(NULL, written_list, nr_written, hash,
+				      pack_idx_opts->flags);
+
 	strbuf_addf(name_buffer, "%s.pack", hash_to_hex(hash));
 
 	if (rename(pack_tmp_name, name_buffer->buf))
@@ -366,6 +476,14 @@ void finish_tmp_packfile(struct strbuf *name_buffer,
 
 	strbuf_setlen(name_buffer, basename_len);
 
+	if (rev_tmp_name) {
+		strbuf_addf(name_buffer, "%s.rev", hash_to_hex(hash));
+		if (rename(rev_tmp_name, name_buffer->buf))
+			die_errno("unable to rename temporary reverse-index file");
+	}
+
+	strbuf_setlen(name_buffer, basename_len);
+
 	free((void *)idx_tmp_name);
 }
 
diff --git a/pack.h b/pack.h
index 9ae640f417..afdcf8f5c7 100644
--- a/pack.h
+++ b/pack.h
@@ -42,6 +42,8 @@ struct pack_idx_option {
 	/* flag bits */
 #define WRITE_IDX_VERIFY 01 /* verify only, do not write the idx file */
 #define WRITE_IDX_STRICT 02
+#define WRITE_REV 04
+#define WRITE_REV_VERIFY 010
 
 	uint32_t version;
 	uint32_t off32_limit;
@@ -91,6 +93,8 @@ struct ref;
 
 void write_promisor_file(const char *promisor_name, struct ref **sought, int nr_sought);
 
+const char *write_rev_file(const char *rev_name, struct pack_idx_entry **objects, uint32_t nr_objects, const unsigned char *hash, unsigned flags);
+
 /*
  * The "hdr" output buffer should be at least this big, which will handle sizes
  * up to 2^67.
-- 
2.30.0.138.g6d7191ea01


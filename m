Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E540C433E0
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 18:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EF1A23A69
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 18:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbhAHSUc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 13:20:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbhAHSUb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 13:20:31 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7D7C0612FD
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 10:20:06 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id e7so11160434ile.7
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 10:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WRMJaTWVSXgyiGEnGhhwjp1kz6Bn3xbvxoqFvfWwets=;
        b=GW6DR94UdTP0ehJHkyiGnaPqxErHLy4FJwgf+IvpNtQCpT6ZykyWG3Z8RCXXj9zjJq
         jQsHpZVYsrxEpSMEferL15++zLPo0fK18RF+VfduhPsyf6E3oVJnaZIJnvIE5DSIK2AH
         aRLLRkEud8aE5CX9ZWmSJjSb3vU3OKx/gTAtlv0TDA35hlMn/T/cArk7CojeJHd57uRM
         0r9GcTDSwBQRSM9ZeqmYXbHbZ3wlt026tvl/Z6ibH7Aa286aDnisDGMpPwckwBtMNhAv
         YRU3UNtyf8Gy/3dF4K9OiuqIsYfKZJ5yjeT7w/Vnhe8BSfFPMa2ldhojB7Cjj6rYt8O1
         N5RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WRMJaTWVSXgyiGEnGhhwjp1kz6Bn3xbvxoqFvfWwets=;
        b=obOS/Te1MDKGb9/WFjrJi2/KZqAc4PovyQMXBEfjU+P4xZe0iG07k4HgY+OrmXvMmS
         p0ntq+xqd86iHw5QyibosDGviFAplwt6dYiUyCohSpRns5BUDmbCQTJobL87PUDlNMji
         tGvYebOLNMlKwuUgBxSAdjdj1CA+YrrfmEYphBpQcAwkTYuIw9o/W46cvxIqkYzI7LTT
         HFZ2/4gxQn+dHi0U5GS4Vu5KbkTP/fjVdP2iFzvt1iiYavHk6mfmlMw+QGFJMmw7KyWk
         QgCMUUpZJW6ctzZotcYy6xJdWgLt8vJLRp385mNTUJV7heKO6dMqppobHiSHUqS0nkLC
         BsdA==
X-Gm-Message-State: AOAM533c+nIuQvhbpQbeO5cTPyyHvtDoedGiSAVt+mdtSs4HJxWzjT8r
        Grm/Nt0G+L7fkbTMv0lmxAqDnAvrtZzd3A==
X-Google-Smtp-Source: ABdhPJyDtv7khRDjjR9xD81AVCf324+1SfYcIFdWL+cunZIehY35RnRtY7pRoc338GD4T6k+0xoPZA==
X-Received: by 2002:a92:ccce:: with SMTP id u14mr5088041ilq.152.1610130005327;
        Fri, 08 Jan 2021 10:20:05 -0800 (PST)
Received: from localhost ([8.9.92.205])
        by smtp.gmail.com with ESMTPSA id l9sm7462796ilg.51.2021.01.08.10.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 10:20:04 -0800 (PST)
Date:   Fri, 8 Jan 2021 13:20:02 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com
Subject: [PATCH 2/8] pack-write.c: prepare to write 'pack-*.rev' files
Message-ID: <88393e266292b022fba3ff41f6623486cb41f66d.1610129989.git.me@ttaylorr.com>
References: <cover.1610129989.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1610129989.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch prepares for callers to be able to write reverse index files
to disk.

It adds the necessary machinery to write a format-compliant .rev file
from within 'write_rev_file()', which is called from
'finish_tmp_packfile()'.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-write.c | 123 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 pack.h       |   4 ++
 2 files changed, 126 insertions(+), 1 deletion(-)

diff --git a/pack-write.c b/pack-write.c
index 3513665e1e..68db5a9edf 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -166,6 +166,116 @@ const char *write_idx_file(const char *index_name, struct pack_idx_entry **objec
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
+#define RIDX_SIGNATURE 0x52494458 /* "RIDX" */
+#define RIDX_VERSION 1
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
@@ -341,7 +451,7 @@ void finish_tmp_packfile(struct strbuf *name_buffer,
 			 struct pack_idx_option *pack_idx_opts,
 			 unsigned char hash[])
 {
-	const char *idx_tmp_name;
+	const char *idx_tmp_name, *rev_tmp_name = NULL;
 	int basename_len = name_buffer->len;
 
 	if (adjust_shared_perm(pack_tmp_name))
@@ -352,6 +462,9 @@ void finish_tmp_packfile(struct strbuf *name_buffer,
 	if (adjust_shared_perm(idx_tmp_name))
 		die_errno("unable to make temporary index file readable");
 
+	rev_tmp_name = write_rev_file(NULL, written_list, nr_written, hash,
+				      pack_idx_opts->flags);
+
 	strbuf_addf(name_buffer, "%s.pack", hash_to_hex(hash));
 
 	if (rename(pack_tmp_name, name_buffer->buf))
@@ -365,5 +478,13 @@ void finish_tmp_packfile(struct strbuf *name_buffer,
 
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
index 9fc0945ac9..30439e0784 100644
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
@@ -87,6 +89,8 @@ off_t write_pack_header(struct hashfile *f, uint32_t);
 void fixup_pack_header_footer(int, unsigned char *, const char *, uint32_t, unsigned char *, off_t);
 char *index_pack_lockfile(int fd);
 
+const char *write_rev_file(const char *rev_name, struct pack_idx_entry **objects, uint32_t nr_objects, const unsigned char *hash, unsigned flags);
+
 /*
  * The "hdr" output buffer should be at least this big, which will handle sizes
  * up to 2^67.
-- 
2.30.0.138.g6d7191ea01


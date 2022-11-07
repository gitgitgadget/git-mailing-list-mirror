Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577F4C433FE
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 18:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233174AbiKGShV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 13:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233201AbiKGSgo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 13:36:44 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BB92792D
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 10:36:25 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id k8so17611109wrh.1
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 10:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IMAERS2dE0cjI5/b7H9PVha+UALE1ARUL34XOpxkPHU=;
        b=Akng5Ez5gfLPJDyybkYKG3N5cS5PN1aXywZKNxpD2YtrLw5i0VUZY1Gd/Vvkbuws2g
         hCSFJ42bskVFO+pl9LtwpHNmoGb/XcPZ07vn1813JCzhnk4YidwyNa6eSu7/Nv2W9qRC
         +XnV0eo5cDSvOYOKFAM/88prNinNWLR0Xw9t1huiKHWnHRznLGTnuWyHIfADyPG+raxt
         1pmf9+q5Waovsh7TSi54lPMIKQoX5KpkGgz1W7lq57cEdOB5Byz9CdUiAG10F9XgOag6
         ixIgVbd9FFPARLWMHWic5wrPtalqApz+8Fz37bWD/Zh3AH50Lq9B5MrWlAPUxiqnVVUY
         G6WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IMAERS2dE0cjI5/b7H9PVha+UALE1ARUL34XOpxkPHU=;
        b=3J/SVI3sqxO1yJCyIBFGdp+zTg7RLElRD6AJEIyv+VgmRg1p8Bk+7pYqN0VPJfa7ME
         373iQsLmLnGCOeG/wUnEWfJVECk1Lxl+MUVuzWgZbbi1yZzy2IT7BIaZoCvLxgWjKYt0
         uZZwVlfYHRP9nWuWyPacvNzbswOhtU+su8T4xK3UqTYyfahuXby9fzU2cCLAFYt6UtK0
         J+cvOpEOQevm8rT4bhM1mGiDyGqVxoNQ7XDVw2UcNDd5qCdWP+daBaWSt8w7ZPI3slOb
         H8TF7qpMuPK9CUeuh6QHNe1gt9XLwJriqcBbkBC8RZD7axasm3skcfavoJpotZHp3JkQ
         tP7w==
X-Gm-Message-State: ACrzQf0DeCS7sojDhjXw2sPIs5DBa2jR/2Loa92E2n57dC5ZqKtG+A47
        6s2tugp7KBeJU84MTf50jmaEbhWPmkY=
X-Google-Smtp-Source: AMsMyM6TUTGdEnnJ5g7GmJV3lwSArqELz3aiTGYoNva8XFcSBYf5uyAYoFF813RkfcnufU2X9G1BXA==
X-Received: by 2002:adf:f70b:0:b0:236:f367:920f with SMTP id r11-20020adff70b000000b00236f367920fmr18308870wrp.129.1667846184615;
        Mon, 07 Nov 2022 10:36:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y15-20020a1c4b0f000000b003b31c560a0csm8796813wma.12.2022.11.07.10.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 10:36:24 -0800 (PST)
Message-Id: <740c2f6e6d1e628a84dc4e1927fef70b5d8d624c.1667846165.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
References: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Nov 2022 18:35:52 +0000
Subject: [PATCH 18/30] packed-refs: write file format version 2
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

TODO: add writing tests.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 refs/packed-backend.c   |   3 +-
 refs/packed-format-v2.c | 108 ++++++++++++++++++++++++++++++++++++++++
 t/t3212-ref-formats.sh  |   6 ++-
 3 files changed, 115 insertions(+), 2 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 09f7b74584f..3429e63620a 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -790,7 +790,8 @@ static int write_with_updates(struct packed_ref_store *refs,
 		break;
 
 	case 2:
-		ok = write_with_updates_v2(refs, updates, err);
+		/* Convert the normal error codes to ITER_DONE. */
+		ok = write_with_updates_v2(refs, updates, err) ? -2 : ITER_DONE;
 		break;
 
 	default:
diff --git a/refs/packed-format-v2.c b/refs/packed-format-v2.c
index ecf3cc93694..044cc9f629a 100644
--- a/refs/packed-format-v2.c
+++ b/refs/packed-format-v2.c
@@ -6,11 +6,30 @@
 #include "../iterator.h"
 #include "../lockfile.h"
 #include "../chdir-notify.h"
+#include "../chunk-format.h"
+#include "../csum-file.h"
+
+#define OFFSET_IS_PEELED (((uint64_t)1) << 63)
+
+#define PACKED_REFS_SIGNATURE          0x50524546 /* "PREF" */
+#define CHREFS_CHUNKID_OFFSETS         0x524F4646 /* "ROFF" */
+#define CHREFS_CHUNKID_REFS            0x52454653 /* "REFS" */
 
 struct write_packed_refs_v2_context {
 	struct packed_ref_store *refs;
 	struct string_list *updates;
 	struct strbuf *err;
+
+	struct hashfile *f;
+	struct chunkfile *cf;
+
+	/*
+	 * As we stream the ref names to the refs chunk, store these
+	 * values in-memory. These arrays are populated one for every ref.
+	 */
+	uint64_t *offsets;
+	size_t nr;
+	size_t offsets_alloc;
 };
 
 struct write_packed_refs_v2_context *create_v2_context(struct packed_ref_store *refs,
@@ -24,15 +43,104 @@ struct write_packed_refs_v2_context *create_v2_context(struct packed_ref_store *
 	ctx->updates = updates;
 	ctx->err = err;
 
+	if (!fdopen_tempfile(refs->tempfile, "w")) {
+		strbuf_addf(err, "unable to fdopen packed-refs tempfile: %s",
+			    strerror(errno));
+		return ctx;
+	}
+
+	ctx->f = hashfd(refs->tempfile->fd, refs->tempfile->filename.buf);
+	ctx->cf = init_chunkfile(ctx->f);
+
 	return ctx;
 }
 
+static int write_packed_entry_v2(const char *refname,
+				 const struct object_id *oid,
+				 const struct object_id *peeled,
+				 void *write_data)
+{
+	struct write_packed_refs_v2_context *ctx = write_data;
+	size_t reflen = strlen(refname) + 1;
+	size_t i = ctx->nr;
+
+	ALLOC_GROW(ctx->offsets, i + 1, ctx->offsets_alloc);
+
+	/* Write entire ref, including null terminator. */
+	hashwrite(ctx->f, refname, reflen);
+	hashwrite(ctx->f, oid->hash, the_hash_algo->rawsz);
+	if (peeled)
+		hashwrite(ctx->f, peeled->hash, the_hash_algo->rawsz);
+
+	if (i)
+		ctx->offsets[i] = (ctx->offsets[i - 1] & (~OFFSET_IS_PEELED));
+	else
+		ctx->offsets[i] = 0;
+	ctx->offsets[i] += reflen + the_hash_algo->rawsz;
+
+	if (peeled) {
+		ctx->offsets[i] += the_hash_algo->rawsz;
+		ctx->offsets[i] |= OFFSET_IS_PEELED;
+	}
+
+	ctx->nr++;
+	return 0;
+}
+
+static int write_refs_chunk_refs(struct hashfile *f,
+				 void *data)
+{
+	struct write_packed_refs_v2_context *ctx = data;
+	int ok;
+
+	trace2_region_enter("refs", "refs-chunk", the_repository);
+	ok = merge_iterator_and_updates(ctx->refs, ctx->updates, ctx->err,
+					write_packed_entry_v2, ctx);
+	trace2_region_leave("refs", "refs-chunk", the_repository);
+
+	return ok != ITER_DONE;
+}
+
+static int write_refs_chunk_offsets(struct hashfile *f,
+				    void *data)
+{
+	struct write_packed_refs_v2_context *ctx = data;
+	size_t i;
+
+	trace2_region_enter("refs", "offsets", the_repository);
+	for (i = 0; i < ctx->nr; i++)
+		hashwrite_be64(f, ctx->offsets[i]);
+
+	trace2_region_leave("refs", "offsets", the_repository);
+	return 0;
+}
+
 int write_packed_refs_v2(struct write_packed_refs_v2_context *ctx)
 {
+	unsigned char file_hash[GIT_MAX_RAWSZ];
+
+	add_chunk(ctx->cf, CHREFS_CHUNKID_REFS, 0, write_refs_chunk_refs);
+	add_chunk(ctx->cf, CHREFS_CHUNKID_OFFSETS, 0, write_refs_chunk_offsets);
+
+	hashwrite_be32(ctx->f, PACKED_REFS_SIGNATURE);
+	hashwrite_be32(ctx->f, 2);
+	hashwrite_be32(ctx->f, the_hash_algo->format_id);
+
+	if (write_chunkfile(ctx->cf, CHUNKFILE_TRAILING_TOC, ctx))
+		goto failure;
+
+	finalize_hashfile(ctx->f, file_hash, FSYNC_COMPONENT_REFERENCE,
+			  CSUM_HASH_IN_STREAM | CSUM_FSYNC);
+
 	return 0;
+
+failure:
+	return -1;
 }
 
 void free_v2_context(struct write_packed_refs_v2_context *ctx)
 {
+	if (ctx->cf)
+		free_chunkfile(ctx->cf);
 	free(ctx);
 }
diff --git a/t/t3212-ref-formats.sh b/t/t3212-ref-formats.sh
index cd1b399bbb8..03c713ac4f6 100755
--- a/t/t3212-ref-formats.sh
+++ b/t/t3212-ref-formats.sh
@@ -71,7 +71,11 @@ test_expect_success 'extensions.refFormat=files,packed-v2' '
 		# Refuse to parse a v1 packed-refs file.
 		cp ../.git/packed-refs .git/packed-refs &&
 		test_must_fail git rev-parse refs/tags/Q &&
-		rm -f .git/packed-refs
+		rm -f .git/packed-refs &&
+
+		# Create a v2 packed-refs file
+		git pack-refs --all &&
+		test_path_exists .git/packed-refs
 	)
 '
 
-- 
gitgitgadget


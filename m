Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com [209.85.160.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2811EFFB7
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 00:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771978923; cv=none; b=qoQrzUebE+NvVSInDeYAVCoDLXsHsTkswnoNxtDewPYEmm0JQtg22whzK5mUShZcnK/LkFo6D4cw8x1vpc/5lG33OdB5VvYo/GCy84dLNkT7KnITY3gTA7SPQlKGi1ysz+3vZZw0C3xWaYS+Z/04htDTBtVYYsys453vpgCsEDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771978923; c=relaxed/simple;
	bh=j/goW2nzjju8Cjn3L2Q4mWCPGxnZ3ROi0Lh/mKR3oIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s6DRRj0yHzXUWVtRb0M8rs1nzz1+XUXpxaNODk/yk/ETHSDQqa2U8A91hB2HKHr9ErgvhHYkWrHgezUift2iBWqg5PvJVPSQmuj8kMiL1PUOr1gBqkwCfef/CaprdyBrvDBm0JXlBpxlGIlcSM3rmPR7Zfev4BxrMx/jYm9gqhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=NsKZL45r; arc=none smtp.client-ip=209.85.160.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="NsKZL45r"
Received: by mail-qt1-f196.google.com with SMTP id d75a77b69052e-506a93ba42dso67971911cf.1
        for <git@vger.kernel.org>; Tue, 24 Feb 2026 16:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1771978920; x=1772583720; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DCyqeOol+fiQw3idVTdikVAHhmlS/i59TfUY0pK9OsI=;
        b=NsKZL45rSC/87LM7X5XBufhWwLYJ976LKBKXuYxX2Epjx1Q1PpBi5cn7UQVSJF8tVg
         gXu3+L2I0jvM3xa5pI/6fwAy02dJPvOy7x1JM9blMEMT7IaLr/VRhG3B93QuYZ+Oxs7Y
         13mMhqDPPaK++qNDnbOBBh06+jd9VU0X76rhK90olXhSVSoGDHj5085HoC4I6v+O/JDU
         awysAo6lOmEn14mhTwijzTYCYbs/PL4mmzGDGpROIhquynpC1ILZmxqyl7Hca6g8Dmbh
         TVlfBe3Wri2CZrOUT5U7YDRV+ImMirDGvc0xrVryBD9q+shnsREIbSJZaS/oyoXkd+Rq
         bRvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771978920; x=1772583720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DCyqeOol+fiQw3idVTdikVAHhmlS/i59TfUY0pK9OsI=;
        b=RWq2AwuGczkYZ/s7fIaElfQCFgDUmlK4J9PNSperyWYi0PPDWMcrZoUW2t/9BN2HOO
         lTGW+fjLWIJApUhZ6Nv9MQD87DP6BoQyHlTqGHdOMZFcBEmK1hIt3WmMNLeJ89wgGHPo
         QswAobEm/lA2namMZjNfQSdimSdpoku6cFf2SLgDELU7pVX/0NYOy5peg0pECIltqFf3
         Z2M0O65X7vC9rzW97f+Whrty+NuDqUZGI2/dMLA2N4N3ZJvb1Ib5d8YJ3QTRbQx5UCW3
         2EHVaU7ovb5tbaE7Fxa5oYd0ko0oqn6YWz0QA0iUWFw03ffVpPbBCsCUfQKGJM0YUKuP
         svEg==
X-Gm-Message-State: AOJu0YwVdQNHr0aWVQOuV5WKzQJXK65zmZ1KExAXX+UTL4YknbbppbfH
	Y+E5UxVv8u9sK4LLPySAJ6XNE1WtE43ZV1AgPzTvchAkuyAHeZslEGkkjSZYQe3JGxdX9Ierd3a
	1cbYIC7uPCX9n
X-Gm-Gg: AZuq6aK9wzqt5bnwsSSdyq6doxf+RsokH/L1egtSYcIWG0dMoteEOEzSDnyp3c8So2h
	ppaDESDs3fWWD6ZDO2d1dDjKh7KUx9rpfi8q3bNGaf7gzgquJ5FmVZyo67QOhMH0ES5rB4kqqle
	MFRONF2MmYb93XdBHF6GJge0VnTxA+o5SGIsWtcJ9jQ+Pssno+gFGfbnBahM3jPv6mrdu+wQP/A
	IIJr9Txr2FvUcWs/wA5bn0iMkKsz+uNzbamPXgmxH2rkEJMxsRyLzERBZTF1PFZdVdBQNF1e2QY
	u7VR0fMDHLRUfnSv/1s3ogmzZWUfOaqqlFW1sQ2mq/1N8rkDSlOogGgp4neSsWp9tvZApiUPzV4
	WVYvUvDLW16P5Uph6B9XXnlblmjTwCz5mId05ckJz4Isy02uUVi/EPSFNj0QzWbxg/GrLL8QfWt
	byCni9b73BaNEa5I6TDKG7RDPAeCHHW2UM+E5VtZ07VrhuLqHC1pYJN+H5za8/+mEzpHYmWHEi3
	ZWN1g3QPivdTaTItviPV9yt5JiN0w==
X-Received: by 2002:a05:622a:1391:b0:4f1:e989:4592 with SMTP id d75a77b69052e-5073a251f46mr8578401cf.10.1771978920057;
        Tue, 24 Feb 2026 16:22:00 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5072afdef0bsm41565211cf.16.2026.02.24.16.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 16:21:59 -0800 (PST)
Date: Tue, 24 Feb 2026 19:21:57 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH 12/14] repack: implement incremental MIDX repacking
Message-ID: <abcd8d303eab067b83e6b11b7608a27d48ac9227.1771978829.git.me@ttaylorr.com>
References: <cover.1771978829.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1771978829.git.me@ttaylorr.com>

Implement the `write_midx_incremental()` function, which builds and
maintains an incremental MIDX chain as part of the geometric repacking
process.

Unlike the default mode which writes a single flat MIDX, the incremental
mode constructs a compaction plan that determines which MIDX layers to
write, compact, or copy, and then executes each step using `git
multi-pack-index` subcommands with the --checksum-only flag.

The repacking strategy works as follows:

 * Acquire the lock guarding the multi-pack-index-chain.

 * A new MIDX layer is always written containing the newly created
   pack(s). If the tip MIDX layer was rewritten during geometric
   repacking, any surviving packs from that layer are also included.

 * Starting from the new layer, adjacent MIDX layers are merged together
   as long as the accumulated object count exceeds half the object count
   of the next deeper layer (controlled by 'repack.midxSplitFactor').

 * Remaining layers in the chain are evaluated pairwise and either
   compacted or copied as-is, following the same merging condition.

 * Write the contents of the new multi-pack-index chain, atomically move
   it into place, and then release the lock.

 * Delete any now-unused MIDX layers.

After writing the new layer, the strategy is evaluated among the
existing MIDX layers in order from oldest to newest. Each step that
writes a new MIDX layer uses "--checksum-only" to avoid updating the
multi-pack-index-chain file. After all steps are complete, the new chain
file is written and then atomically moved into place.

At present, this functionality is exposed behind a new enum value,
`REPACK_WRITE_MIDX_INCREMENTAL`, but has no external callers. A
subsequent commit will expose this mode via `git repack
--write-midx=incremental`.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 repack-midx.c | 475 +++++++++++++++++++++++++++++++++++++++++++++++++-
 repack.h      |   3 +
 2 files changed, 476 insertions(+), 2 deletions(-)

diff --git a/repack-midx.c b/repack-midx.c
index 6c28d9acef6..ad78a10378b 100644
--- a/repack-midx.c
+++ b/repack-midx.c
@@ -2,9 +2,12 @@
 #include "repack.h"
 #include "hash.h"
 #include "hex.h"
+#include "lockfile.h"
+#include "midx.h"
 #include "odb.h"
 #include "oidset.h"
 #include "pack-bitmap.h"
+#include "path.h"
 #include "refs.h"
 #include "run-command.h"
 #include "tempfile.h"
@@ -301,13 +304,16 @@ static void repack_prepare_midx_command(struct child_process *cmd,
 }
 
 static int repack_fill_midx_stdin_packs(struct child_process *cmd,
-					struct string_list *include)
+					struct string_list *include,
+					struct string_list *out)
 {
 	struct string_list_item *item;
 	FILE *in;
 	int ret;
 
 	cmd->in = -1;
+	if (out)
+		cmd->out = -1;
 
 	strvec_push(&cmd->args, "--stdin-packs");
 
@@ -320,6 +326,17 @@ static int repack_fill_midx_stdin_packs(struct child_process *cmd,
 		fprintf(in, "%s\n", item->string);
 	fclose(in);
 
+	if (out) {
+		struct strbuf buf = STRBUF_INIT;
+		FILE *outf = xfdopen(cmd->out, "r");
+
+		while (strbuf_getline(&buf, outf) != EOF)
+			string_list_append(out, buf.buf);
+		strbuf_release(&buf);
+
+		fclose(outf);
+	}
+
 	return finish_command(cmd);
 }
 
@@ -377,7 +394,7 @@ static int write_midx_included_packs(struct repack_write_midx_opts *opts)
 		strvec_pushf(&cmd.args, "--refs-snapshot=%s",
 			     opts->refs_snapshot);
 
-	ret = repack_fill_midx_stdin_packs(&cmd, &include);
+	ret = repack_fill_midx_stdin_packs(&cmd, &include, NULL);
 done:
 	if (!ret && opts->write_bitmaps)
 		remove_redundant_bitmaps(&include, opts->packdir);
@@ -387,6 +404,458 @@ static int write_midx_included_packs(struct repack_write_midx_opts *opts)
 	return ret;
 }
 
+struct midx_compaction_step {
+	union {
+		struct multi_pack_index *copy;
+		struct string_list write;
+		struct {
+			struct multi_pack_index *from;
+			struct multi_pack_index *to;
+		} compact;
+	} u;
+
+	uint32_t objects_nr;
+	const char *csum;
+
+	enum {
+		MIDX_COMPACTION_STEP_UNKNOWN,
+		MIDX_COMPACTION_STEP_COPY,
+		MIDX_COMPACTION_STEP_WRITE,
+		MIDX_COMPACTION_STEP_COMPACT,
+	} type;
+};
+
+static const char *midx_compaction_step_base(const struct midx_compaction_step *step)
+{
+	switch (step->type) {
+	case MIDX_COMPACTION_STEP_UNKNOWN:
+		BUG("cannot use UNKNOWN step as a base");
+	case MIDX_COMPACTION_STEP_COPY:
+		return midx_get_checksum_hex(step->u.copy);
+	case MIDX_COMPACTION_STEP_WRITE:
+		BUG("cannot use WRITE step as a base");
+	case MIDX_COMPACTION_STEP_COMPACT:
+		return midx_get_checksum_hex(step->u.compact.to);
+	default:
+		BUG("unhandled midx compaction step type %d", step->type);
+	}
+}
+
+static int midx_compaction_step_exec_copy(struct midx_compaction_step *step)
+{
+	step->csum = xstrdup(midx_get_checksum_hex(step->u.copy));
+	return 0;
+}
+
+static int midx_compaction_step_exec_write(struct midx_compaction_step *step,
+					   struct repack_write_midx_opts *opts,
+					   const char *base)
+{
+	struct child_process cmd = CHILD_PROCESS_INIT;
+	struct string_list hash = STRING_LIST_INIT_DUP;
+	struct string_list_item *item;
+	const char *preferred_pack = NULL;
+	int ret = 0;
+
+	if (!step->u.write.nr) {
+		ret = error(_("no packs to write MIDX during compaction"));
+		goto out;
+	}
+
+	for_each_string_list_item(item, &step->u.write) {
+		if (item->util)
+			preferred_pack = item->string;
+	}
+
+	repack_prepare_midx_command(&cmd, opts, "write");
+	strvec_pushl(&cmd.args, "--incremental", "--checksum-only", NULL);
+	strvec_pushf(&cmd.args, "--base=%s", base ? base : "none");
+
+	if (preferred_pack) {
+		struct strbuf buf = STRBUF_INIT;
+
+		strbuf_addstr(&buf, preferred_pack);
+		strbuf_strip_suffix(&buf, ".idx");
+		strbuf_addstr(&buf, ".pack");
+
+		strvec_pushf(&cmd.args, "--preferred-pack=%s", buf.buf);
+
+		strbuf_release(&buf);
+	}
+
+	ret = repack_fill_midx_stdin_packs(&cmd, &step->u.write, &hash);
+	if (hash.nr != 1) {
+		ret = error(_("expected exactly one line during MIDX write, "
+			      "got: %"PRIuMAX),
+			    (uintmax_t)hash.nr);
+		goto out;
+	}
+
+	step->csum = xstrdup(hash.items[0].string);
+
+out:
+	string_list_clear(&hash, 0);
+
+	return ret;
+}
+
+static int midx_compaction_step_exec_compact(struct midx_compaction_step *step,
+					     struct repack_write_midx_opts *opts)
+{
+	struct child_process cmd = CHILD_PROCESS_INIT;
+	struct strbuf buf = STRBUF_INIT;
+	FILE *out = NULL;
+	int ret;
+
+	repack_prepare_midx_command(&cmd, opts, "compact");
+	strvec_pushl(&cmd.args, "--incremental", "--checksum-only",
+		     midx_get_checksum_hex(step->u.compact.from),
+		     midx_get_checksum_hex(step->u.compact.to), NULL);
+
+	cmd.out = -1;
+
+	ret = start_command(&cmd);
+	if (ret)
+		goto out;
+
+	out = xfdopen(cmd.out, "r");
+	while (strbuf_getline_lf(&buf, out) != EOF) {
+		if (step->csum) {
+			ret = error(_("unexpected MIDX output: '%s'"), buf.buf);
+			goto out;
+		}
+		step->csum = strbuf_detach(&buf, NULL);
+	}
+
+	ret = finish_command(&cmd);
+
+out:
+	if (out)
+		fclose(out);
+	strbuf_release(&buf);
+
+	return ret;
+}
+
+static int midx_compaction_step_exec(struct midx_compaction_step *step,
+				     struct repack_write_midx_opts *opts,
+				     const char *base)
+{
+	switch (step->type) {
+	case MIDX_COMPACTION_STEP_UNKNOWN:
+		BUG("cannot execute UNKNOWN midx compaction step");
+	case MIDX_COMPACTION_STEP_COPY:
+		return midx_compaction_step_exec_copy(step);
+	case MIDX_COMPACTION_STEP_WRITE:
+		return midx_compaction_step_exec_write(step, opts, base);
+	case MIDX_COMPACTION_STEP_COMPACT:
+		return midx_compaction_step_exec_compact(step, opts);
+	default:
+		BUG("unhandled midx compaction step type %d", step->type);
+	}
+}
+
+static int repack_make_midx_compaction_plan(struct repack_write_midx_opts *opts,
+					    struct midx_compaction_step **steps_p,
+					    size_t *steps_nr_p)
+{
+	struct multi_pack_index *m;
+	struct midx_compaction_step *steps = NULL;
+	struct midx_compaction_step step = { 0 };
+	struct strbuf buf = STRBUF_INIT;
+	size_t steps_nr = 0, steps_alloc = 0;
+	uint32_t i;
+	int ret = 0;
+
+	odb_reprepare(opts->existing->repo->objects);
+	m = get_multi_pack_index(opts->existing->source);
+
+	for (i = 0; m && i < m->num_packs + m->num_packs_in_base; i++) {
+		if (prepare_midx_pack(m, i)) {
+			ret = error(_("could not load pack %"PRIu32" from MIDX"),
+				    i);
+			goto out;
+		}
+	}
+
+	/*
+	 * The first MIDX in the resulting chain is always going to be
+	 * new.
+	 *
+	 * At a minimum, it will include all of the newly written packs.
+	 * If there is an existing MIDX whose tip layer contain packs
+	 * that were repacked, it will also include any of its pack
+	 * which were *not* rolled up as part of the geometric repack
+	 * (if any), and the previous tip will be replaced.
+	 *
+	 * It may grow to include the packs from zero or more MIDXs from
+	 * the old chain, beginning either at the old tip (if the MIDX
+	 * was *not* rewritten) or the old tip's base MIDX layer
+	 * (otherwise).
+	 */
+
+	step.type = MIDX_COMPACTION_STEP_WRITE;
+	string_list_init_nodup(&step.u.write);
+
+	for (i = 0; i < opts->names->nr; i++) {
+		strbuf_addf(&buf, "pack-%s.idx", opts->names->items[i].string);
+		string_list_append(&step.u.write, strbuf_detach(&buf, NULL));
+	}
+	for (i = 0; i < opts->geometry->split; i++) {
+		struct packed_git *p = opts->geometry->pack[i];
+		if (unsigned_add_overflows(step.objects_nr, p->num_objects)) {
+			ret = error(_("too many objects in MIDX compaction step"));
+			goto out;
+		}
+
+		step.objects_nr += p->num_objects;
+	}
+
+	/*
+	 * Now handle any existing packs which were *not* rewritten.
+	 *
+	 * The list of packs in opts->geometry only contains MIDX'd
+	 * packs from the newest layer when that layer has more than
+	 * 'repack.midxNewLayerThreshold' number of packs.
+	 *
+	 * If the MIDX tip was rewritten (that is, one or more of those
+	 * packs appear below the split line), then add all packs above
+	 * the split line to the new layer, as the old one is no longer
+	 * usable.
+	 *
+	 * If the MIDX tip was not rewritten (that is, all MIDX'd packs
+	 * from the youngest layer appear below the split line, or were
+	 * not included in the geometric repack at all because there
+	 * were too few of them), ignore them since we'll retain the
+	 * existing layer as-is.
+	 */
+	for (i = opts->geometry->split; i < opts->geometry->pack_nr; i++) {
+		struct packed_git *p = opts->geometry->pack[i];
+		struct string_list_item *item;
+
+		strbuf_reset(&buf);
+		strbuf_addstr(&buf, pack_basename(p));
+		strbuf_strip_suffix(&buf, ".pack");
+		strbuf_addstr(&buf, ".idx");
+
+		if (p->multi_pack_index && !opts->geometry->midx_tip_rewritten)
+			continue;
+
+		item = string_list_append(&step.u.write,
+					  strbuf_detach(&buf, NULL));
+		if (p->multi_pack_index || i == opts->geometry->pack_nr - 1)
+			item->util = (void *)1; /* mark as preferred */
+
+		if (unsigned_add_overflows(step.objects_nr, p->num_objects)) {
+			ret = error(_("too many objects in MIDX compaction step"));
+			goto out;
+		}
+		step.objects_nr += p->num_objects;
+	}
+
+	/*
+	 * If the MIDX tip was rewritten, then we no longer consider it
+	 * a candidate for compaction, since it will not exist in the
+	 * MIDX chain being built.
+	 */
+	if (opts->geometry->midx_tip_rewritten)
+		m = m->base_midx;
+
+	/*
+	 * Compact additional MIDX layers into this proposed one until
+	 * the merging condition is violated.
+	 */
+	while (m) {
+		uint32_t preferred_pack_idx;
+
+		if (step.objects_nr < m->num_objects / opts->midx_split_factor) {
+			/*
+			 * Stop compacting MIDX layer as soon as the
+			 * merged size is less than half the size of the
+			 * next layer in the chain.
+			 */
+			break;
+		}
+
+		if (midx_preferred_pack(m, &preferred_pack_idx) < 0) {
+			ret = error(_("could not find preferred pack for MIDX "
+				      "%s"), midx_get_checksum_hex(m));
+			goto out;
+		}
+
+		for (i = 0; i < m->num_packs; i++) {
+			struct string_list_item *item;
+			uint32_t pack_int_id = i + m->num_packs_in_base;
+			struct packed_git *p = nth_midxed_pack(m, pack_int_id);
+
+			strbuf_reset(&buf);
+			strbuf_addstr(&buf, pack_basename(p));
+			strbuf_strip_suffix(&buf, ".pack");
+			strbuf_addstr(&buf, ".idx");
+
+			item = string_list_append(&step.u.write,
+						  strbuf_detach(&buf, NULL));
+			if (pack_int_id == preferred_pack_idx)
+				item->util = (void *)1; /* mark as preferred */
+		}
+
+		if (unsigned_add_overflows(step.objects_nr, m->num_objects)) {
+			ret = error(_("too many objects in MIDX compaction step"));
+			goto out;
+		}
+		step.objects_nr += m->num_objects;
+
+		m = m->base_midx;
+	}
+
+	if (step.u.write.nr > 0) {
+		/*
+		 * As long as there is at least one new pack to write
+		 * (and thus the MIDX is non-empty), add it to the plan.
+		 */
+		ALLOC_GROW(steps, steps_nr + 1, steps_alloc);
+		steps[steps_nr++] = step;
+	}
+
+	/*
+	 * Then start over, repeat, and either compact or keep as-is
+	 * each MIDX layer until we have exhausted the chain.
+	 *
+	 * Finally, evaluate the remainder of the chain (if any) and
+	 * either compact a sequence of adjacent layers, or keep
+	 * individual layers as-is according to the same merging
+	 * condition as above.
+	 */
+	while (m) {
+		struct multi_pack_index *next = m;
+
+		ALLOC_GROW(steps, steps_nr + 1, steps_alloc);
+
+		memset(&step, 0, sizeof(step));
+		step.type = MIDX_COMPACTION_STEP_UNKNOWN;
+
+		while (next) {
+			struct multi_pack_index *base = next->base_midx;
+			uint32_t proposed_objects_nr;
+
+			if (unsigned_add_overflows(step.objects_nr, next->num_objects)) {
+				ret = error(_("too many objects in MIDX compaction step"));
+				goto out;
+			}
+
+			proposed_objects_nr = step.objects_nr + next->num_objects;
+
+			if (!base) {
+				/*
+				 * If we are at the end of the MIDX
+				 * chain, there is nothing to compact,
+				 * so mark it and stop.
+				 */
+				step.objects_nr = proposed_objects_nr;
+				break;
+			}
+
+			if (proposed_objects_nr < base->num_objects / opts->midx_split_factor) {
+				/*
+				 * If there is a MIDX following this
+				 * one, but our accumulated size is less
+				 * than half of its size, compacting
+				 * them would violate the merging
+				 * condition, so stop here.
+				 */
+				break;
+			}
+
+			/*
+			 * Otherwise, it is OK to compact the next layer
+			 * into this one. Do so, and then continue
+			 * through the remainder of the chain.
+			 */
+			step.objects_nr = proposed_objects_nr;
+			next = base;
+		}
+
+		if (m == next) {
+			step.type = MIDX_COMPACTION_STEP_COPY;
+			step.u.copy = m;
+		} else {
+			step.type = MIDX_COMPACTION_STEP_COMPACT;
+			step.u.compact.from = next;
+			step.u.compact.to = m;
+		}
+
+		m = next->base_midx;
+
+		steps[steps_nr++] = step;
+	}
+
+out:
+	*steps_p = steps;
+	*steps_nr_p = steps_nr;
+
+	return ret;
+}
+
+static int write_midx_incremental(struct repack_write_midx_opts *opts)
+{
+	struct midx_compaction_step *steps = NULL;
+	struct strbuf lock_name = STRBUF_INIT;
+	struct lock_file lf;
+	size_t steps_nr = 0;
+	size_t i;
+	int ret = 0;
+
+	get_midx_chain_filename(opts->existing->source, &lock_name);
+	if (safe_create_leading_directories(opts->existing->repo,
+					    lock_name.buf))
+		die_errno(_("unable to create leading directories of %s"),
+			  lock_name.buf);
+	hold_lock_file_for_update(&lf, lock_name.buf, LOCK_DIE_ON_ERROR);
+
+	if (!fdopen_lock_file(&lf, "w")) {
+		ret = error_errno(_("unable to open multi-pack-index chain file"));
+		goto done;
+	}
+
+	if (repack_make_midx_compaction_plan(opts, &steps, &steps_nr) < 0) {
+		ret = error(_("unable to generate compaction plan"));
+		goto done;
+	}
+
+	for (i = 0; i < steps_nr; i++) {
+		struct midx_compaction_step *step = &steps[i];
+		char *base = NULL;
+
+		if (i + 1 < steps_nr)
+			base = xstrdup(midx_compaction_step_base(&steps[i + 1]));
+
+		if (midx_compaction_step_exec(step, opts, base) < 0) {
+			ret = error(_("unable to execute compaction step %"PRIuMAX),
+				    (uintmax_t)i);
+			free(base);
+			goto done;
+		}
+
+		free(base);
+	}
+
+	i = steps_nr;
+	while (i--) {
+		struct midx_compaction_step *step = &steps[i];
+		if (!step->csum)
+			BUG("missing result for compaction step %"PRIuMAX,
+			    (uintmax_t)i);
+		fprintf(get_lock_file_fp(&lf), "%s\n", step->csum);
+	}
+
+	commit_lock_file(&lf);
+
+done:
+	strbuf_release(&lock_name);
+	free(steps);
+	return ret;
+}
+
 int repack_write_midx(struct repack_write_midx_opts *opts)
 {
 	switch (opts->mode) {
@@ -394,6 +863,8 @@ int repack_write_midx(struct repack_write_midx_opts *opts)
 		BUG("write_midx mode is NONE?");
 	case REPACK_WRITE_MIDX_DEFAULT:
 		return write_midx_included_packs(opts);
+	case REPACK_WRITE_MIDX_INCREMENTAL:
+		return write_midx_incremental(opts);
 	default:
 		BUG("unhandled write_midx mode: %d", opts->mode);
 	}
diff --git a/repack.h b/repack.h
index 81907fcce7f..831ccfb1c6c 100644
--- a/repack.h
+++ b/repack.h
@@ -137,6 +137,7 @@ struct tempfile;
 enum repack_write_midx_mode {
 	REPACK_WRITE_MIDX_NONE,
 	REPACK_WRITE_MIDX_DEFAULT,
+	REPACK_WRITE_MIDX_INCREMENTAL,
 };
 
 struct repack_write_midx_opts {
@@ -148,6 +149,8 @@ struct repack_write_midx_opts {
 	int show_progress;
 	int write_bitmaps;
 	int midx_must_contain_cruft;
+	int midx_split_factor;
+	int midx_new_layer_threshold;
 	enum repack_write_midx_mode mode;
 };
 
-- 
2.53.0.185.g29bc4dff628


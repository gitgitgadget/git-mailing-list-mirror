Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394893B8D7E
	for <git@vger.kernel.org>; Sat,  1 Aug 2026 17:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785606127; cv=none; b=MJKgR3/D4wE3rILMpYHLB0KpdQdiosVcyuY4zsJTQELiMFPEdHlB0IGaj7PU6yJEezTY6vXrNXRAmHarwhUkLMuESKTnKIuzyZO8+tPqJLxrJtW2Jk6gI8pkfH/3kuL4iGasa5bVYSUQU/k+FQ9anWbjCuiGuw1Letx0f9Y+4Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785606127; c=relaxed/simple;
	bh=eJWV2ny+fsTRNj21uu1eKSfstJN+yluHSkZeHtUj6YM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NgXjxS/pAKdjmwqeD1X1mdmrjJla+nQ5cpgQrDR8EYpad47qdUty9aXqPuUClk3ZEiEnilHlCD7wRjCCbDOSRDBYKKB8qvpZbpVM08QkGRKU0M2esVN0RH8bWCn5TsmOhWVVnImQUiLnhWNNZ9rsOXTQdHrd+pOnxKfuEUu/G/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cdz0bbrc; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cdz0bbrc"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cacb8416a1so20578335ad.1
        for <git@vger.kernel.org>; Sat, 01 Aug 2026 10:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785606123; x=1786210923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BRCBzjmvPRnDUkC7HTpk878PQl51o717vnLA93um28Q=;
        b=Cdz0bbrcMDh8jPklOLQY+ljg06fJsGbcDGKZD2nIOKlaYd8tT7ulNlgW8IGrdmWwXU
         7AjRud9TZz190P9Dw5CGCHMYVHvR9Q23OEH6+jbFapzMKKERdyGmf6AurIM3WsfHtN57
         Ja3RU5QMTntJNyEmu+pNRV9HfALijXwbFc0zIb++4t7h5eNecHYUF2D9Te6JwHOLNh17
         ciGEyKI5+l9hXkUF6PX5LlW5cAy5TLCrTEuJh8j/JQqtTbjB5w7+uqiq+U67O/GBEMe2
         GJ/nxHm9DywMJqJTdA6Ulu3Tf5ePTV3sHtqCDbMnn6gVeURkSe5YEC6amHFZBLbVksjq
         s18A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785606123; x=1786210923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BRCBzjmvPRnDUkC7HTpk878PQl51o717vnLA93um28Q=;
        b=d9+Ln/NdKIoGHZguH6oJml49kJx0zVYm2epTgIaOOBUlsnw93lnFfgEmrlZAdJgyQD
         +e0uZ3lOXVwUt7DHh+pB8BniJ06s+wKzfnx/DOdox7nDGFm/4A5PxqqECRVLHAmh/VRu
         3oxaD/nCb1L3t0Yr2bYJpUXMvlU2cqxdXmgkVW62nHiAy+8gWPWaNmhIVLB3TnVovomo
         pDoQIJpMJqb5I9UKmodQE+cpoAhgilvOlP12fVrdY3WU4VZEcZsevVe4qwdTcxYADqFd
         GnWiT6HSkyMX24bK8UoH5vvI0KdhVrYtSZYGtCE5NN2F02pG2yQqfHtqniiV3gRtCtSS
         dZoA==
X-Gm-Message-State: AOJu0Yytx8SdCcLUB2lNiRrVZVtoLqNWQKzsMWaSsn1ppmO66Huy8w+h
	DKb95TnNCN49pQiujA9VhwkeBKh+hdCAElOx2+0e4iF4e7rXkdij4HD6J7KQ2w==
X-Gm-Gg: AR+sD115AAdz4g75AFRPH4by/nNMB270p90bhoCpO1Zc69dVwvjYKyqFepVOdyf6EqY
	vCUMZqThqhmOKDMrs5BzYblj2DJvUIrV9fJc83YsC6TL9A1MHzzilDKCaUs2BOXdxYfjGbNIrRT
	BpLdR9WiS0awwivdnOs5GwetAXZps7JEZk9NYz3/12fHp720Fcbx1ZvrYb/uN3xgFcb5HjEmCaD
	3QSu6DuDieqY715g49Gwfz9TEE7tnVE1ja+yjnoRSolphreIN2399BrlS35nRtg8sHUUyNQ8rqQ
	rde/iOzUqCRw1Y9nvo+4YSff01y2nDtnGpAlQBH1qktwEy/lHLIsCOjYQAdPhtVjwW+fyloeyOz
	4SK4JIj//YObDEeBlKfx5epgutWOVCt1P3qykGYvuCpQs+wK2snRcgPHWbTpG3spD8mVzI2ExZE
	hXuD1m3S3ijVNh4eh9UrSZ6pXFh26kFUDWoJkWRx47Gri4cK0sV/jg6dPFvkDBmzlP4Ex8Vn6lJ
	c8lqLta5Nj/KS1yI+Zjs8Lbf4Kvr8jF+PKWDRuwDmsM4fASI1VQajKsRAbk677odMcmLoR2MsAw
	BLneo7o8YqHuyPBpPP0NFkHimVczTd8QIniHn92ErAx3GfY=
X-Received: by 2002:a17:903:11c3:b0:2ca:b48f:3395 with SMTP id d9443c01a7336-2d0523bf980mr40400635ad.34.1785606122919;
        Sat, 01 Aug 2026 10:42:02 -0700 (PDT)
Received: from localhost (192-184-169-91.fiber.dynamic.sonic.net. [192.184.169.91])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e04491dsm26940659eec.16.2026.08.01.10.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 10:42:02 -0700 (PDT)
From: Michael Montalbo <mmontalbo@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [RFC PATCH v7 04/10] diff: record precomputed hunks during stat output
Date: Sat,  1 Aug 2026 10:41:47 -0700
Message-ID: <20260801174156.2998808-5-mmontalbo@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260801174156.2998808-1-mmontalbo@gmail.com>
References: <pull.2120.v6.git.1785091889.gitgitgadget@gmail.com>
 <20260801174156.2998808-1-mmontalbo@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The diff-hunks store has a writer, but nothing fills it.  Teach
builtin_diffstat() to do so: on a warming run (a writer is attached), a
modified pair's stat is produced by collecting the pair's hunk
coordinates instead of emitting text, the counts are summed from those
hunks, and the pair is recorded.  A run without a writer is unchanged,
and nothing reads the store yet; the read side arrives next.

The store records one context-free entry per pair, and only for a
trim-stable pair: one whose zero-context trimmed diff (what blame will
read) and untrimmed diff (whose counts a nonzero-context stat matches)
are identical.  The warming path computes both and hands them to
diff_hunks_writer_record_stable(), new here, which records only when
they agree; a divergent pair is never recorded and every consumer
computes it.  The warming run displays the counts it shows a store-less
run: the trimmed ones, since xdi_diff trims at zero context, while the
untrimmed counts serve only the stability comparison.

Not everything the stat path computes may be recorded.
--ignore-blank-lines is part of the key, but it coalesces hunks
differently between the text-emitting and coordinate-callback paths, so
a recorded entry would not match a store-less run's --stat.  -I
patterns, --anchored, and break detection (-B) shape the diff outside
the key entirely; the guard for those three sits in this consumer for
now and moves into the store's own provider when it registers, next.  A
"log -L" range-scoped stat is not the whole-pair diff the key describes,
so it does not record.  Recording also requires both sides to be valid
regular files whose blobs the key can name: a working-tree side,
textconv output, or a gitlink has no usable id.

"git diff", "git log", "git show", and "git diff-tree" with the --stat,
--numstat, and --shortstat formats attach a writer when writing is
enabled and flush it when the traversal finishes, so a warming run such
as

        GIT_DIFF_HUNKS_WRITE=1 git log --all --stat >/dev/null

fills the cache as a side effect of the diff work the command already
does.  Writing is controlled by diffHunks.write and GIT_DIFF_HUNKS_WRITE.

Add the write half of t4220:

- ordinary commands never create the store, and creation is gated off
  by default, the environment overriding the config;
- a warming run builds a store that verifies, and a second refreshes it
  in place;
- a warming run displays parity at zero context on a trim-divergent
  pair, committed as a fixture (small synthetic pairs cannot diverge:
  minimal diffs add and delete equal counts, and trimming preserves
  that);
- binary and mode-only pairs do not break the writer;
- a corrupt store is discarded at seed;
- verify and clear run against the files a warming run builds.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 builtin/diff-tree.c        |   3 +
 builtin/diff.c             |  10 ++
 builtin/log.c              |   7 +
 diff-hunks.c               |  32 ++++
 diff-hunks.h               |  18 ++-
 diff.c                     | 218 +++++++++++++++++++++----
 diff.h                     |  17 ++
 t/meson.build              |   1 +
 t/t4220-diff-hunks.sh      | 184 +++++++++++++++++++++
 t/t4220/README             |  55 +++++++
 t/t4220/trim-divergent-new | 319 +++++++++++++++++++++++++++++++++++++
 t/t4220/trim-divergent-old | 316 ++++++++++++++++++++++++++++++++++++
 12 files changed, 1150 insertions(+), 30 deletions(-)
 create mode 100755 t/t4220-diff-hunks.sh
 create mode 100644 t/t4220/README
 create mode 100644 t/t4220/trim-divergent-new
 create mode 100644 t/t4220/trim-divergent-old

diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 8b8f8b54e4..296c6a137e 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -170,6 +170,8 @@ int cmd_diff_tree(int argc,
 
 	opt->diffopt.rotate_to_strict = 1;
 
+	diff_hunks_attach(&opt->diffopt);
+
 	/*
 	 * NOTE!  We expect "a..b" to expand to "^a b" but it is
 	 * perfectly valid for revision range parser to yield "b ^a",
@@ -234,5 +236,6 @@ int cmd_diff_tree(int argc,
 		diff_free(&opt->diffopt);
 	}
 
+	diff_hunks_detach(&opt->diffopt);
 	return diff_result_code(opt);
 }
diff --git a/builtin/diff.c b/builtin/diff.c
index 18b1083e98..a2ad63ac8c 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -568,6 +568,15 @@ int cmd_diff(int argc,
 		}
 	}
 
+	/*
+	 * The hunk store is keyed by blob pair, so any diff whose
+	 * file pairs carry known blob object IDs (tree-to-tree,
+	 * index-to-tree) can consult the same entries that
+	 * "git log --stat" and "git blame" use; pairs without known
+	 * blobs bypass it at lookup time.
+	 */
+	diff_hunks_attach(&rev.diffopt);
+
 	symdiff_prepare(&rev, &sdiff);
 	for (i = 0; i < rev.pending.nr; i++) {
 		struct object_array_entry *entry = &rev.pending.objects[i];
@@ -648,6 +657,7 @@ int cmd_diff(int argc,
 	result = diff_result_code(&rev);
 	if (1 < rev.diffopt.skip_stat_unmatch)
 		refresh_index_quietly();
+	diff_hunks_detach(&rev.diffopt);
 	release_revisions(&rev);
 	object_array_clear(&ent);
 	symdiff_release(&sdiff);
diff --git a/builtin/log.c b/builtin/log.c
index 350b35c556..6903bdd5ff 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -693,8 +693,11 @@ int cmd_show(int argc,
 	opt.tweak = show_setup_revisions_tweak;
 	cmd_log_init(argc, argv, prefix, &rev, &opt, &cfg);
 
+	diff_hunks_attach(&rev.diffopt);
+
 	if (!rev.no_walk) {
 		ret = cmd_log_walk(&rev);
+		diff_hunks_detach(&rev.diffopt);
 		release_revisions(&rev);
 		log_config_release(&cfg);
 		return ret;
@@ -767,6 +770,7 @@ int cmd_show(int argc,
 	}
 
 	rev.diffopt.no_free = 0;
+	diff_hunks_detach(&rev.diffopt);
 	diff_free(&rev.diffopt);
 	release_revisions(&rev);
 	log_config_release(&cfg);
@@ -846,8 +850,11 @@ int cmd_log(int argc,
 	opt.tweak = log_setup_revisions_tweak;
 	cmd_log_init(argc, argv, prefix, &rev, &opt, &cfg);
 
+	diff_hunks_attach(&rev.diffopt);
+
 	ret = cmd_log_walk(&rev);
 
+	diff_hunks_detach(&rev.diffopt);
 	release_revisions(&rev);
 	log_config_release(&cfg);
 	return ret;
diff --git a/diff-hunks.c b/diff-hunks.c
index eeaaa2466a..23cefe055b 100644
--- a/diff-hunks.c
+++ b/diff-hunks.c
@@ -651,6 +651,38 @@ int diff_hunks_writer_add(struct diff_hunks_writer *w,
 	return 1;
 }
 
+void diff_hunks_writer_record_stable(struct diff_hunks_writer *w,
+				     const struct object_id *old_oid,
+				     const struct object_id *new_oid,
+				     int xdl_opts,
+				     const struct precomputed_hunk *trimmed,
+				     size_t nr_trimmed,
+				     const struct precomputed_hunk *full,
+				     size_t nr_full)
+{
+	size_t i;
+
+	if (!w)
+		return;
+	/*
+	 * Record only a trim-stable pair, one whose trimmed and
+	 * untrimmed diffs are identical, so the single entry answers
+	 * any consumer at any context (see the top of this file).  A
+	 * pair where the two diffs differ is never recorded and every
+	 * consumer computes it.
+	 */
+	if (nr_trimmed != nr_full)
+		return;
+	for (i = 0; i < nr_trimmed; i++)
+		if (trimmed[i].old_start != full[i].old_start ||
+		    trimmed[i].old_count != full[i].old_count ||
+		    trimmed[i].new_start != full[i].new_start ||
+		    trimmed[i].new_count != full[i].new_count)
+			return;
+	diff_hunks_writer_add(w, old_oid, new_oid, xdl_opts,
+			      trimmed, nr_trimmed);
+}
+
 /*
  * Seed the writer with fname's entries so a rewrite preserves them,
  * setting *pruned when the rewrite will not carry the whole file
diff --git a/diff-hunks.h b/diff-hunks.h
index ef9ee3f417..89e56f4b1b 100644
--- a/diff-hunks.h
+++ b/diff-hunks.h
@@ -94,7 +94,8 @@ struct diff_hunks_writer *diff_hunks_writer_maybe_new(struct repository *r);
  * Record a blob pair's hunks as computed under xdl_opts; a later lookup
  * with a matching key is served these hunks. The caller must have
  * checked that the pair's trimmed and untrimmed diffs are identical
- * (see the top of this file), so the entry answers at any context.
+ * (see the top of this file), so the entry answers at any context;
+ * diff_hunks_writer_record_stable() below performs that check.
  * NULL-safe. Returns 1 when the entry was recorded, 0 when the writer
  * refused it (no hunks, a null object id, or values the on-disk
  * 32-bit fields cannot hold).
@@ -106,6 +107,21 @@ int diff_hunks_writer_add(struct diff_hunks_writer *w,
 			  const struct precomputed_hunk *hunks,
 			  size_t nr_hunks);
 
+/*
+ * Record the pair only if it is trim-stable: the recording caller
+ * hands over both the trimmed (xdi_diff) and untrimmed (xdl_diff)
+ * zero-context hunk sequences it computed, and the entry is added
+ * only when the two are identical. NULL-safe.
+ */
+void diff_hunks_writer_record_stable(struct diff_hunks_writer *w,
+				     const struct object_id *old_oid,
+				     const struct object_id *new_oid,
+				     int xdl_opts,
+				     const struct precomputed_hunk *trimmed,
+				     size_t nr_trimmed,
+				     const struct precomputed_hunk *full,
+				     size_t nr_full);
+
 /* Flush the accumulated entries to the store and free the writer. NULL-safe. */
 void diff_hunks_writer_finish(struct diff_hunks_writer *w);
 
diff --git a/diff.c b/diff.c
index 9ef4328afa..11ec88dc8c 100644
--- a/diff.c
+++ b/diff.c
@@ -16,6 +16,7 @@
 #include "revision.h"
 #include "quote.h"
 #include "diff.h"
+#include "diff-hunks.h"
 #include "diffcore.h"
 #include "delta.h"
 #include "hex.h"
@@ -2929,6 +2930,72 @@ static struct diffstat_file *diffstat_add(struct diffstat_t *diffstat,
 	return x;
 }
 
+struct diffstat_hunk_cb_data {
+	struct precomputed_hunk **h;
+	size_t *nr, *alloc;
+};
+
+/*
+ * Hunk callback that appends each hunk's coordinates to a growable
+ * array, so one xdiff pass can both sum a diffstat and record hunks for
+ * the store.
+ */
+static int diffstat_hunk_cb(long start_a, long count_a,
+			    long start_b, long count_b,
+			    void *cb_data)
+{
+	struct diffstat_hunk_cb_data *d = cb_data;
+
+	ALLOC_GROW(*d->h, *d->nr + 1, *d->alloc);
+	(*d->h)[*d->nr].old_start = start_a;
+	(*d->h)[*d->nr].old_count = count_a;
+	(*d->h)[*d->nr].new_start = start_b;
+	(*d->h)[*d->nr].new_count = count_b;
+	(*d->nr)++;
+	return 0;
+}
+
+/*
+ * Collect the hunks of the two files at zero context. diff_fn chooses
+ * whether trimming runs: xdi_diff applies trim_common_tail, yielding the
+ * zero-context hunks blame reads; xdl_diff does not, yielding the
+ * untrimmed hunks. Both run at zero context, so the untrimmed hunks are
+ * not grouped the way a nonzero context would group them; diffstat only
+ * sums their counts, which grouping does not change. Sets *ph (caller
+ * frees) and *ph_nr.
+ */
+typedef int (*xdiff_fn)(mmfile_t *, mmfile_t *, xpparam_t const *,
+			xdemitconf_t const *, xdemitcb_t *);
+static int collect_hunks(xdiff_fn diff_fn, mmfile_t *mf1, mmfile_t *mf2,
+			       xpparam_t *xpp, struct precomputed_hunk **ph,
+			       size_t *ph_nr)
+{
+	size_t ph_alloc = 0;
+	xdemitcb_t ecb = { 0 };
+	xdemitconf_t xecfg = { 0 };
+	struct diffstat_hunk_cb_data cd = { ph, ph_nr, &ph_alloc };
+
+	*ph = NULL;
+	*ph_nr = 0;
+	xecfg.hunk_func = diffstat_hunk_cb;
+	ecb.priv = &cd;
+	return diff_fn(mf1, mf2, xpp, &xecfg, &ecb);
+}
+
+void diff_hunks_attach(struct diff_options *o)
+{
+	if (!(o->output_format &
+	      (DIFF_FORMAT_DIFFSTAT | DIFF_FORMAT_SHORTSTAT | DIFF_FORMAT_NUMSTAT)))
+		return;
+	o->hunks_writer = diff_hunks_writer_maybe_new(o->repo);
+}
+
+void diff_hunks_detach(struct diff_options *o)
+{
+	diff_hunks_writer_finish(o->hunks_writer);
+	o->hunks_writer = NULL;
+}
+
 static int diffstat_consume(void *priv, char *line, unsigned long len)
 {
 	struct diffstat_t *diffstat = priv;
@@ -4253,6 +4320,87 @@ static const char *get_compact_summary(const struct diff_filepair *p, int is_ren
 	return NULL;
 }
 
+/*
+ * Fill data->added/deleted for a modified pair by collecting its hunk
+ * coordinates, and record them into the store. Runs only on a warming
+ * run; returns 1 when it produced the counts, 0 when the caller must
+ * compute the diffstat itself.
+ *
+ * --ignore-blank-lines is excluded: that flag is part of the store
+ * key, but it coalesces hunks differently between the emit and
+ * hunk-callback paths, so a recorded entry would not match a
+ * store-less run's --stat output. (--inter-hunk-context is not
+ * excluded: it only groups hunks, and diffstat sums their counts,
+ * which grouping does not change.) Recording requires both sides to
+ * be valid regular files whose blobs the key can name.
+ */
+static int diffstat_from_hunks(struct diff_options *o,
+			       struct diff_filespec *one,
+			       struct diff_filespec *two,
+			       struct diffstat_file *data)
+{
+	struct precomputed_hunk *ph_trim, *ph_full, *counts;
+	size_t n_trim, n_full, n_counts, k;
+	mmfile_t mf1, mf2;
+	xpparam_t xpp = { .flags = o->xdl_opts,
+			  .ignore_regex = o->ignore_regex,
+			  .ignore_regex_nr = o->ignore_regex_nr,
+			  .anchors = o->anchors,
+			  .anchors_nr = o->anchors_nr };
+
+	if (o->xdl_opts & XDF_IGNORE_BLANK_LINES)
+		return 0;
+
+	/* Not a warming run: the caller computes the diffstat. */
+	if (!o->hunks_writer)
+		return 0;
+	/*
+	 * -I patterns, --anchored anchors, and break detection (-B)
+	 * shape the diff outside the store key, so what they compute
+	 * must not be recorded under it.
+	 */
+	if (o->ignore_regex_nr || o->anchors_nr || o->break_opt != -1)
+		return 0;
+	/* Recording needs blobs the key can name, on both sides. */
+	if (!one->oid_valid || !two->oid_valid ||
+	    S_ISGITLINK(one->mode) || S_ISGITLINK(two->mode) ||
+	    !DIFF_FILE_VALID(one) || !DIFF_FILE_VALID(two) ||
+	    !S_ISREG(one->mode) || !S_ISREG(two->mode))
+		return 0;
+
+	if (fill_mmfile(o->repo, &mf1, one) < 0 ||
+	    fill_mmfile(o->repo, &mf2, two) < 0)
+		die("unable to read files to diff");
+
+	/*
+	 * Compute the zero-context trimmed diff (what blame reads) and the
+	 * untrimmed diff (whose counts a nonzero-context stat matches).
+	 * xdi_diff runs first: it enforces the size limit, so the xdl_diff
+	 * call is already bounded.
+	 */
+	if (collect_hunks(xdi_diff, &mf1, &mf2, &xpp, &ph_trim, &n_trim) ||
+	    collect_hunks(xdl_diff, &mf1, &mf2, &xpp, &ph_full, &n_full))
+		die("unable to generate diffstat for %s", one->path);
+
+	/*
+	 * Match a store-less run: at zero context xdi_diff trims, so sum the
+	 * trimmed diff; otherwise sum the untrimmed one.
+	 */
+	counts = o->context ? ph_full : ph_trim;
+	n_counts = o->context ? n_full : n_trim;
+	for (k = 0; k < n_counts; k++) {
+		data->added += counts[k].new_count;
+		data->deleted += counts[k].old_count;
+	}
+
+	diff_hunks_writer_record_stable(o->hunks_writer, &one->oid, &two->oid,
+					o->xdl_opts, ph_trim, n_trim,
+					ph_full, n_full);
+	free(ph_trim);
+	free(ph_full);
+	return 1;
+}
+
 static void builtin_diffstat(const char *name_a, const char *name_b,
 			     struct diff_filespec *one,
 			     struct diff_filespec *two,
@@ -4304,38 +4452,50 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
 	}
 
 	else if (may_differ) {
-		/* Crazy xdl interfaces.. */
-		xpparam_t xpp;
-		xdemitconf_t xecfg;
-
-		if (fill_mmfile(o->repo, &mf1, one) < 0 ||
-		    fill_mmfile(o->repo, &mf2, two) < 0)
-			die("unable to read files to diff");
-
-		memset(&xpp, 0, sizeof(xpp));
-		memset(&xecfg, 0, sizeof(xecfg));
-		xpp.flags = o->xdl_opts;
-		xpp.ignore_regex = o->ignore_regex;
-		xpp.ignore_regex_nr = o->ignore_regex_nr;
-		xpp.anchors = o->anchors;
-		xpp.anchors_nr = o->anchors_nr;
-		xecfg.ctxlen = o->context;
-		xecfg.interhunkctxlen = o->interhunkcontext;
-		xecfg.flags = XDL_EMIT_NO_HUNK_HDR;
-
-		if (p->line_ranges) {
-			struct line_range_filter lr_filter;
-
-			line_range_filter_init(&lr_filter, p->line_ranges,
-					       diffstat_consume, diffstat);
+		/*
+		 * Record into the diff-hunks store on a warming run. A
+		 * "log -L" range-scoped stat is not the whole-pair diff
+		 * the store keys, so it does not record. Otherwise diff
+		 * normally.
+		 */
+		if (p->line_ranges || !diffstat_from_hunks(o, one, two, data)) {
+			/* Crazy xdl interfaces.. */
+			xpparam_t xpp;
+			xdemitconf_t xecfg;
+
+			if (fill_mmfile(o->repo, &mf1, one) < 0 ||
+			    fill_mmfile(o->repo, &mf2, two) < 0)
+				die("unable to read files to diff");
+
+			memset(&xpp, 0, sizeof(xpp));
+			memset(&xecfg, 0, sizeof(xecfg));
+			xpp.flags = o->xdl_opts;
+			xpp.ignore_regex = o->ignore_regex;
+			xpp.ignore_regex_nr = o->ignore_regex_nr;
+			xpp.anchors = o->anchors;
+			xpp.anchors_nr = o->anchors_nr;
+			xecfg.ctxlen = o->context;
+			xecfg.interhunkctxlen = o->interhunkcontext;
+			xecfg.flags = XDL_EMIT_NO_HUNK_HDR;
 
-			if (line_range_filter_diff(&lr_filter, &mf1, &mf2,
-						   &xpp, &xecfg))
+			if (p->line_ranges) {
+				struct line_range_filter lr_filter;
+
+				line_range_filter_init(&lr_filter,
+						       p->line_ranges,
+						       diffstat_consume,
+						       diffstat);
+
+				if (line_range_filter_diff(&lr_filter, &mf1,
+							   &mf2, &xpp, &xecfg))
+					die("unable to generate diffstat for %s",
+					    one->path);
+			} else if (xdi_diff_outf(&mf1, &mf2, NULL,
+						 diffstat_consume, diffstat,
+						 &xpp, &xecfg))
 				die("unable to generate diffstat for %s",
 				    one->path);
-		} else if (xdi_diff_outf(&mf1, &mf2, NULL,
-				  diffstat_consume, diffstat, &xpp, &xecfg))
-			die("unable to generate diffstat for %s", one->path);
+		}
 
 		if (DIFF_FILE_VALID(one) && DIFF_FILE_VALID(two)) {
 			struct diffstat_file *file =
diff --git a/diff.h b/diff.h
index bb5cddaf34..3d44de39ff 100644
--- a/diff.h
+++ b/diff.h
@@ -420,6 +420,13 @@ struct diff_options {
 	 */
 	int max_depth;
 	int max_depth_valid;
+
+	/*
+	 * Precomputed diff hunks (see diff-hunks.h). When hunks_writer is
+	 * set (a warming run), diffstat records the hunks it computes;
+	 * the writer is attached only for the stat output formats.
+	 */
+	struct diff_hunks_writer *hunks_writer;
 };
 
 unsigned diff_filter_bit(char status);
@@ -668,6 +675,16 @@ void diffcore_fix_diff_index(void);
 int diff_queue_is_empty(struct diff_options *o);
 void diff_flush(struct diff_options*);
 void diff_free(struct diff_options*);
+
+/*
+ * Attach a diff-hunks writer to a diff producing a stat format, so a
+ * warming run records the hunks it computes; a no-op when writing is off
+ * or for other formats. Pair with diff_hunks_detach() once the diff is
+ * done.
+ */
+void diff_hunks_attach(struct diff_options *o);
+void diff_hunks_detach(struct diff_options *o);
+
 void diff_warn_rename_limit(const char *varname, int needed, int degraded_cc);
 
 /* diff-raw status letters */
diff --git a/t/meson.build b/t/meson.build
index 8ae6ab6c5f..c63c30ba63 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -583,6 +583,7 @@ integration_tests = [
   't4216-log-bloom.sh',
   't4217-log-limit.sh',
   't4219-log-follow-merge.sh',
+  't4220-diff-hunks.sh',
   't4252-am-options.sh',
   't4253-am-keep-cr-dos.sh',
   't4254-am-corrupt.sh',
diff --git a/t/t4220-diff-hunks.sh b/t/t4220-diff-hunks.sh
new file mode 100755
index 0000000000..c677831946
--- /dev/null
+++ b/t/t4220-diff-hunks.sh
@@ -0,0 +1,184 @@
+#!/bin/sh
+
+test_description='precomputed diff hunks store (git diff-hunks)
+
+The store maps an (old blob, new blob, diff settings) key to the hunks of
+diffing the pair. It is a cache: reading is on by default
+(core.diffHunks), while writing is
+off by default and enabled per run by GIT_DIFF_HUNKS_WRITE (or the
+diffHunks.write config), so a diff or log warms the store only when the
+owner opts in. These tests check that a warmed store never changes
+output, that lookups honor the diff settings, and that a corrupt store is
+read as absent while verify reports the corruption.'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+STORE=.git/objects/info/diff-hunks
+
+# Warm the store the way a repository owner would: a stat walk with
+# writing enabled. A --stat walk records one entry per trim-stable blob
+# pair, serving blame and the summary formats alike. Extra arguments
+# (e.g. -c options) are passed to git before "log".
+warm () {
+	GIT_DIFF_HUNKS_WRITE=1 git "$@" log --all --stat >/dev/null
+}
+
+# Run a command with the store disabled, for ground truth.
+no_store () {
+	git -c core.diffhunks=false "$@"
+}
+
+test_expect_success 'setup' '
+	test_commit initial file.txt "line 1" &&
+	test_commit second file.txt "line 1
+line 2" &&
+	test_commit third file.txt "line 1
+line 2
+line 3" &&
+	test_commit fourth file.txt "changed line 1
+line 2
+line 3
+line 4"
+'
+
+test_expect_success 'ordinary commands do not create the store' '
+	git log --stat >/dev/null &&
+	git blame file.txt >/dev/null &&
+	git diff --stat second third >/dev/null &&
+	test_path_is_missing $STORE
+'
+
+test_expect_success 'writing is gated by env and config, env wins' '
+	test_when_finished "git diff-hunks clear" &&
+	# The diffHunks.write config enables writing.
+	git -c diffHunks.write=true log --all --stat >/dev/null &&
+	test_path_is_file $STORE &&
+	git diff-hunks clear &&
+	# GIT_DIFF_HUNKS_WRITE overrides the config: 0 disables it.
+	GIT_DIFF_HUNKS_WRITE=0 git -c diffHunks.write=true log --all --stat >/dev/null &&
+	test_path_is_missing $STORE &&
+	# and enables it without any config.
+	GIT_DIFF_HUNKS_WRITE=1 git log --all --stat >/dev/null &&
+	test_path_is_file $STORE
+'
+
+test_expect_success 'a warm builds a store that verifies' '
+	warm &&
+	test_path_is_file $STORE &&
+	git diff-hunks verify
+'
+
+test_expect_success 'a second warming run refreshes the store in place' '
+	warm &&
+	test_commit fifth file.txt "brand new line" &&
+	warm &&
+	git diff-hunks verify &&
+	no_store log --stat >expect &&
+	git log --stat >actual &&
+	test_cmp expect actual
+'
+
+# A warming run displays the diffstat it computes. At zero context xdi_diff
+# trims, so the displayed counts must be the trimmed ones (what a store-less
+# run shows), not the untrimmed ones the writer compares against when it
+# decides whether the pair is stable enough to record.
+test_expect_success 'warming --stat at zero context matches a store-less run' '
+	git init -q warm-u0 &&
+	(
+		cd warm-u0 &&
+		cp "$TEST_DIRECTORY/t4220/trim-divergent-old" div.sh &&
+		git add div.sh && git commit -q -m old &&
+		cp "$TEST_DIRECTORY/t4220/trim-divergent-new" div.sh &&
+		git add div.sh && git commit -q -m new &&
+		git -c core.diffhunks=false log -1 --format= -U0 --stat -- div.sh >expect &&
+		GIT_DIFF_HUNKS_WRITE=1 git log -1 --format= -U0 --stat -- div.sh >got &&
+		test_cmp expect got
+	)
+'
+
+test_expect_success 'show and diff-tree --stat use the store' '
+	test_when_finished "git diff-hunks clear" &&
+	# diff_hunks_attach() runs for show and diff-tree: a write-enabled
+	# --stat records into the store (without the attach there is no
+	# writer, so nothing is written).
+	git diff-hunks clear &&
+	GIT_DIFF_HUNKS_WRITE=1 git show --stat fourth >/dev/null &&
+	test_path_is_file "$STORE" &&
+	git diff-hunks clear &&
+	GIT_DIFF_HUNKS_WRITE=1 git diff-tree --stat fourth >/dev/null &&
+	test_path_is_file "$STORE" &&
+	# Reading never changes their output.
+	git diff-hunks clear &&
+	no_store show --stat fourth >expect_show &&
+	no_store diff-tree --stat fourth >expect_dt &&
+	warm &&
+	git show --stat fourth >got_show &&
+	git diff-tree --stat fourth >got_dt &&
+	test_cmp expect_show got_show &&
+	test_cmp expect_dt got_dt
+'
+
+# Cover the pair shapes an object walk encounters: binary and
+# mode-only changes produce no text hunks to record.
+test_expect_success 'binary and mode-only changes do not break the writer' '
+	printf "\\000\\001\\002" >bin.dat &&
+	git add bin.dat &&
+	git commit -m binary-1 &&
+	printf "\\000\\001\\003\\004" >bin.dat &&
+	git add bin.dat &&
+	git commit -m binary-2 &&
+	echo "mode content" >mode.txt &&
+	git add mode.txt &&
+	git commit -m mode-1 &&
+	test_chmod +x mode.txt &&
+	git commit -m mode-2 &&
+	no_store log --stat >expect &&
+	warm &&
+	git log --stat >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'verify succeeds on a valid store and on an absent one' '
+	warm &&
+	git diff-hunks verify &&
+	git diff-hunks clear &&
+	test_path_is_missing $STORE &&
+	git diff-hunks verify
+'
+
+test_expect_success 'verify detects a checksum mismatch' '
+	test_when_finished "git diff-hunks clear" &&
+	warm &&
+	fsize=$(test_file_size $STORE) &&
+	mid=$((fsize / 2)) &&
+	printf "\\377" | dd of=$STORE bs=1 seek=$mid count=1 conv=notrunc 2>/dev/null &&
+	test_must_fail git diff-hunks verify
+'
+
+test_expect_success 'a warm discards a corrupt store rather than seeding from it' '
+	test_when_finished "git diff-hunks clear" &&
+	warm &&
+	# Corrupt the checksum: the next warm must not carry the corrupt
+	# entries forward into a fresh checksum-valid file; it discards
+	# them (with a warning) and rewrites a store that verifies.
+	fsize=$(test_file_size $STORE) &&
+	printf "\\377" | dd of=$STORE bs=1 seek=$((fsize / 2)) count=1 conv=notrunc 2>/dev/null &&
+	warm 2>err &&
+	test_grep "failed its checksum" err &&
+	git diff-hunks verify &&
+	no_store log --stat >expect &&
+	git log --stat >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'diff-hunks clear removes the store file' '
+	warm &&
+	test_path_is_file $STORE &&
+	git diff-hunks clear &&
+	test_path_is_missing $STORE
+'
+
+test_done
diff --git a/t/t4220/README b/t/t4220/README
new file mode 100644
index 0000000000..b850fe7c61
--- /dev/null
+++ b/t/t4220/README
@@ -0,0 +1,55 @@
+t4220 diff-hunks test fixtures
+==============================
+
+trim-divergent-old, trim-divergent-new
+--------------------------------------
+
+Two revisions of a single real file, used by t4220-diff-hunks.sh to
+exercise a "trim-divergent" blob pair: one whose diff hunk counts change
+with the amount of context, so the trimmed and untrimmed results
+disagree.
+
+They are two versions of git's own t/t6002-rev-list-bisect.sh, taken from
+git.git history around:
+
+  090af9957c ("t6002: fix use of `expr` with `set -e`",
+  Patrick Steinhardt, 2026-04-21)
+
+which rewrites `$(expr ...)` arithmetic as `$((...))` and reformats a few
+test_expect_success blocks.
+
+  trim-divergent-old = 090af9957c^:t/t6002-rev-list-bisect.sh  (blob daa009c9a1)
+  trim-divergent-new = 090af9957c :t/t6002-rev-list-bisect.sh  (blob f2de40b5ed)
+
+To regenerate them from any git.git checkout:
+
+  git show 090af9957c^:t/t6002-rev-list-bisect.sh >trim-divergent-old
+  git show 090af9957c:t/t6002-rev-list-bisect.sh  >trim-divergent-new
+
+Why this pair
+-------------
+
+The diff-hunks store records only "trim-stable" pairs: those whose hunks
+are identical whether or not xdiff trims the common head and tail (which
+it does at zero context, in trim_common_tail).  This pair is deliberately
+NOT trim-stable:
+
+  diff -U0 reports  9 added / 6 deleted
+  diff -U3 reports 10 added / 7 deleted
+
+Because the counts diverge with context, the writer must refuse to record
+this pair and every command must recompute it from the blobs.  t4220 uses
+it to prove that the displayed counts stay correct at each context, and
+that a divergent pair is never served from the store.  See
+t4220-diff-hunks.sh ("a trim-divergent file is correct at each context"
+and the store-poison test).
+
+Why not a synthesized fixture
+-----------------------------
+
+The divergence needs real content that makes xdiff's common-tail trimming
+shift a hunk boundary while the added/deleted balance stays equal.  A
+minimal hand-written file that reliably triggers the -U0 vs -U3 count
+disagreement has not been found yet; until one is, this real pair is kept
+verbatim.  If you synthesize a smaller equivalent, replace these two files
+and delete this note.
diff --git a/t/t4220/trim-divergent-new b/t/t4220/trim-divergent-new
new file mode 100644
index 0000000000..f2de40b5ed
--- /dev/null
+++ b/t/t4220/trim-divergent-new
@@ -0,0 +1,319 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Jon Seymour
+#
+test_description='Tests git rev-list --bisect functionality'
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-t6000.sh # t6xxx specific functions
+
+# usage: test_bisection max-diff bisect-option head ^prune...
+#
+# e.g. test_bisection 1 --bisect l1 ^l0
+#
+test_bisection_diff()
+{
+	_max_diff=$1
+	_bisect_option=$2
+	shift 2
+	_bisection=$(git rev-list $_bisect_option "$@")
+	_list_size=$(git rev-list "$@" | wc -l)
+        _head=$1
+	shift 1
+	_bisection_size=$(git rev-list $_bisection "$@" | wc -l)
+	[ -n "$_list_size" -a -n "$_bisection_size" ] ||
+	error "test_bisection_diff failed"
+
+	# Test if bisection size is close to half of list size within
+	# tolerance.
+	#
+	_bisect_err=$(($_list_size - $_bisection_size * 2))
+	if test "$_bisect_err" -lt 0
+	then
+		_bisect_err=$((0 - $_bisect_err))
+	fi
+	_bisect_err=$(($_bisect_err / 2)) ; # floor
+
+	test_expect_success "bisection diff $_bisect_option $_head $* <= $_max_diff" '
+		test $_bisect_err -le $_max_diff
+	'
+}
+
+date >path0
+git update-index --add path0
+save_tag tree git write-tree
+on_committer_date "00:00" hide_error save_tag root unique_commit root tree
+on_committer_date "00:01" save_tag l0 unique_commit l0 tree -p root
+on_committer_date "00:02" save_tag l1 unique_commit l1 tree -p l0
+on_committer_date "00:03" save_tag l2 unique_commit l2 tree -p l1
+on_committer_date "00:04" save_tag a0 unique_commit a0 tree -p l2
+on_committer_date "00:05" save_tag a1 unique_commit a1 tree -p a0
+on_committer_date "00:06" save_tag b1 unique_commit b1 tree -p a0
+on_committer_date "00:07" save_tag c1 unique_commit c1 tree -p b1
+on_committer_date "00:08" save_tag b2 unique_commit b2 tree -p b1
+on_committer_date "00:09" save_tag b3 unique_commit b2 tree -p b2
+on_committer_date "00:10" save_tag c2 unique_commit c2 tree -p c1 -p b2
+on_committer_date "00:11" save_tag c3 unique_commit c3 tree -p c2
+on_committer_date "00:12" save_tag a2 unique_commit a2 tree -p a1
+on_committer_date "00:13" save_tag a3 unique_commit a3 tree -p a2
+on_committer_date "00:14" save_tag b4 unique_commit b4 tree -p b3 -p a3
+on_committer_date "00:15" save_tag a4 unique_commit a4 tree -p a3 -p b4 -p c3
+on_committer_date "00:16" save_tag l3 unique_commit l3 tree -p a4
+on_committer_date "00:17" save_tag l4 unique_commit l4 tree -p l3
+on_committer_date "00:18" save_tag l5 unique_commit l5 tree -p l4
+git update-ref HEAD $(tag l5)
+
+
+#     E
+#    / \
+#   e1  |
+#   |   |
+#   e2  |
+#   |   |
+#   e3  |
+#   |   |
+#   e4  |
+#   |   |
+#   |   f1
+#   |   |
+#   |   f2
+#   |   |
+#   |   f3
+#   |   |
+#   |   f4
+#   |   |
+#   e5  |
+#   |   |
+#   e6  |
+#   |   |
+#   e7  |
+#   |   |
+#   e8  |
+#    \ /
+#     F
+
+
+on_committer_date "00:00" hide_error save_tag F unique_commit F tree
+on_committer_date "00:01" save_tag e8 unique_commit e8 tree -p F
+on_committer_date "00:02" save_tag e7 unique_commit e7 tree -p e8
+on_committer_date "00:03" save_tag e6 unique_commit e6 tree -p e7
+on_committer_date "00:04" save_tag e5 unique_commit e5 tree -p e6
+on_committer_date "00:05" save_tag f4 unique_commit f4 tree -p F
+on_committer_date "00:06" save_tag f3 unique_commit f3 tree -p f4
+on_committer_date "00:07" save_tag f2 unique_commit f2 tree -p f3
+on_committer_date "00:08" save_tag f1 unique_commit f1 tree -p f2
+on_committer_date "00:09" save_tag e4 unique_commit e4 tree -p e5
+on_committer_date "00:10" save_tag e3 unique_commit e3 tree -p e4
+on_committer_date "00:11" save_tag e2 unique_commit e2 tree -p e3
+on_committer_date "00:12" save_tag e1 unique_commit e1 tree -p e2
+on_committer_date "00:13" save_tag E unique_commit E tree -p e1 -p f1
+
+on_committer_date "00:00" hide_error save_tag U unique_commit U tree
+on_committer_date "00:01" save_tag u0 unique_commit u0 tree -p U
+on_committer_date "00:01" save_tag u1 unique_commit u1 tree -p u0
+on_committer_date "00:02" save_tag u2 unique_commit u2 tree -p u0
+on_committer_date "00:03" save_tag u3 unique_commit u3 tree -p u0
+on_committer_date "00:04" save_tag u4 unique_commit u4 tree -p u0
+on_committer_date "00:05" save_tag u5 unique_commit u5 tree -p u0
+on_committer_date "00:06" save_tag V unique_commit V tree -p u1 -p u2 -p u3 -p u4 -p u5
+
+test_sequence()
+{
+	_bisect_option=$1
+
+	test_bisection_diff 0 $_bisect_option l0 ^root
+	test_bisection_diff 0 $_bisect_option l1 ^root
+	test_bisection_diff 0 $_bisect_option l2 ^root
+	test_bisection_diff 0 $_bisect_option a0 ^root
+	test_bisection_diff 0 $_bisect_option a1 ^root
+	test_bisection_diff 0 $_bisect_option a2 ^root
+	test_bisection_diff 0 $_bisect_option a3 ^root
+	test_bisection_diff 0 $_bisect_option b1 ^root
+	test_bisection_diff 0 $_bisect_option b2 ^root
+	test_bisection_diff 0 $_bisect_option b3 ^root
+	test_bisection_diff 0 $_bisect_option c1 ^root
+	test_bisection_diff 0 $_bisect_option c2 ^root
+	test_bisection_diff 0 $_bisect_option c3 ^root
+	test_bisection_diff 0 $_bisect_option E ^F
+	test_bisection_diff 0 $_bisect_option e1 ^F
+	test_bisection_diff 0 $_bisect_option e2 ^F
+	test_bisection_diff 0 $_bisect_option e3 ^F
+	test_bisection_diff 0 $_bisect_option e4 ^F
+	test_bisection_diff 0 $_bisect_option e5 ^F
+	test_bisection_diff 0 $_bisect_option e6 ^F
+	test_bisection_diff 0 $_bisect_option e7 ^F
+	test_bisection_diff 0 $_bisect_option f1 ^F
+	test_bisection_diff 0 $_bisect_option f2 ^F
+	test_bisection_diff 0 $_bisect_option f3 ^F
+	test_bisection_diff 0 $_bisect_option f4 ^F
+	test_bisection_diff 0 $_bisect_option E ^F
+
+	test_bisection_diff 1 $_bisect_option V ^U
+	test_bisection_diff 0 $_bisect_option V ^U ^u1 ^u2 ^u3
+	test_bisection_diff 0 $_bisect_option u1 ^U
+	test_bisection_diff 0 $_bisect_option u2 ^U
+	test_bisection_diff 0 $_bisect_option u3 ^U
+	test_bisection_diff 0 $_bisect_option u4 ^U
+	test_bisection_diff 0 $_bisect_option u5 ^U
+
+#
+# the following illustrates Linus' binary bug blatt idea.
+#
+# assume the bug is actually at l3, but you don't know that - all you know is that l3 is broken
+# and it wasn't broken before
+#
+# keep bisecting the list, advancing the "bad" head and accumulating "good" heads until
+# the bisection point is the head - this is the bad point.
+#
+
+test_output_expect_success "$_bisect_option l5 ^root" 'git rev-list $_bisect_option l5 ^root' <<EOF
+c3
+EOF
+
+test_output_expect_success "$_bisect_option l5 ^root ^c3" 'git rev-list $_bisect_option l5 ^root ^c3' <<EOF
+b4
+EOF
+
+test_output_expect_success "$_bisect_option l5 ^root ^c3 ^b4" 'git rev-list $_bisect_option l5 ^c3 ^b4' <<EOF
+l3
+EOF
+
+test_output_expect_success "$_bisect_option l3 ^root ^c3 ^b4" 'git rev-list $_bisect_option l3 ^root ^c3 ^b4' <<EOF
+a4
+EOF
+
+test_output_expect_success "$_bisect_option l5 ^b3 ^a3 ^b4 ^a4" 'git rev-list $_bisect_option l3 ^b3 ^a3 ^a4' <<EOF
+l3
+EOF
+
+#
+# if l3 is bad, then l4 is bad too - so advance the bad pointer by making b4 the known bad head
+#
+
+test_output_expect_success "$_bisect_option l4 ^a2 ^a3 ^b ^a4" 'git rev-list $_bisect_option l4 ^a2 ^a3 ^a4' <<EOF
+l3
+EOF
+
+test_output_expect_success "$_bisect_option l3 ^a2 ^a3 ^b ^a4" 'git rev-list $_bisect_option l3 ^a2 ^a3 ^a4' <<EOF
+l3
+EOF
+
+# found!
+
+#
+# as another example, let's consider a4 to be the bad head, in which case
+#
+
+test_output_expect_success "$_bisect_option a4 ^a2 ^a3 ^b4" 'git rev-list $_bisect_option a4 ^a2 ^a3 ^b4' <<EOF
+c2
+EOF
+
+test_output_expect_success "$_bisect_option a4 ^a2 ^a3 ^b4 ^c2" 'git rev-list $_bisect_option a4 ^a2 ^a3 ^b4 ^c2' <<EOF
+c3
+EOF
+
+test_output_expect_success "$_bisect_option a4 ^a2 ^a3 ^b4 ^c2 ^c3" 'git rev-list $_bisect_option a4 ^a2 ^a3 ^b4 ^c2 ^c3' <<EOF
+a4
+EOF
+
+# found!
+
+#
+# or consider c3 to be the bad head
+#
+
+test_output_expect_success "$_bisect_option a4 ^a2 ^a3 ^b4" 'git rev-list $_bisect_option a4 ^a2 ^a3 ^b4' <<EOF
+c2
+EOF
+
+test_output_expect_success "$_bisect_option c3 ^a2 ^a3 ^b4 ^c2" 'git rev-list $_bisect_option c3 ^a2 ^a3 ^b4 ^c2' <<EOF
+c3
+EOF
+
+# found!
+
+}
+
+test_sequence "--bisect"
+
+#
+#
+
+test_expect_success 'set up fake --bisect refs' '
+	git update-ref refs/bisect/bad c3 &&
+	good=$(git rev-parse b1) &&
+	git update-ref refs/bisect/good-$good $good &&
+	good=$(git rev-parse c1) &&
+	git update-ref refs/bisect/good-$good $good
+'
+
+test_expect_success 'rev-list --bisect can default to good/bad refs' '
+	# the only thing between c3 and c1 is c2
+	git rev-parse c2 >expect &&
+	git rev-list --bisect >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rev-parse --bisect can default to good/bad refs' '
+	git rev-parse c3 ^b1 ^c1 >expect &&
+	git rev-parse --bisect >actual &&
+
+	# output order depends on the refnames, which in turn depends on
+	# the exact sha1s. We just want to make sure we have the same set
+	# of lines in any order.
+	sort <expect >expect.sorted &&
+	sort <actual >actual.sorted &&
+	test_cmp expect.sorted actual.sorted
+'
+
+test_output_expect_success '--bisect --first-parent' 'git rev-list --bisect --first-parent E ^F' <<EOF
+e4
+EOF
+
+test_output_expect_success '--first-parent' 'git rev-list --first-parent E ^F' <<EOF
+E
+e1
+e2
+e3
+e4
+e5
+e6
+e7
+e8
+EOF
+
+test_output_expect_success '--bisect-vars --first-parent' 'git rev-list --bisect-vars --first-parent E ^F' <<EOF
+bisect_rev='e5'
+bisect_nr=4
+bisect_good=4
+bisect_bad=3
+bisect_all=9
+bisect_steps=2
+EOF
+
+test_expect_success '--bisect-all --first-parent' '
+	cat >expect.unsorted <<-EOF &&
+	$(git rev-parse E) (tag: E, dist=0)
+	$(git rev-parse e1) (tag: e1, dist=1)
+	$(git rev-parse e2) (tag: e2, dist=2)
+	$(git rev-parse e3) (tag: e3, dist=3)
+	$(git rev-parse e4) (tag: e4, dist=4)
+	$(git rev-parse e5) (tag: e5, dist=4)
+	$(git rev-parse e6) (tag: e6, dist=3)
+	$(git rev-parse e7) (tag: e7, dist=2)
+	$(git rev-parse e8) (tag: e8, dist=1)
+	EOF
+
+	# expect results to be ordered by distance (descending),
+	# commit hash (ascending)
+	sort -k4,4r -k1,1 expect.unsorted >expect &&
+	git rev-list --bisect-all --first-parent E ^F >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--bisect without any revisions' '
+	git rev-list --bisect HEAD..HEAD >out &&
+	test_must_be_empty out
+'
+
+test_done
diff --git a/t/t4220/trim-divergent-old b/t/t4220/trim-divergent-old
new file mode 100644
index 0000000000..daa009c9a1
--- /dev/null
+++ b/t/t4220/trim-divergent-old
@@ -0,0 +1,316 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Jon Seymour
+#
+test_description='Tests git rev-list --bisect functionality'
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-t6000.sh # t6xxx specific functions
+
+# usage: test_bisection max-diff bisect-option head ^prune...
+#
+# e.g. test_bisection 1 --bisect l1 ^l0
+#
+test_bisection_diff()
+{
+	_max_diff=$1
+	_bisect_option=$2
+	shift 2
+	_bisection=$(git rev-list $_bisect_option "$@")
+	_list_size=$(git rev-list "$@" | wc -l)
+        _head=$1
+	shift 1
+	_bisection_size=$(git rev-list $_bisection "$@" | wc -l)
+	[ -n "$_list_size" -a -n "$_bisection_size" ] ||
+	error "test_bisection_diff failed"
+
+	# Test if bisection size is close to half of list size within
+	# tolerance.
+	#
+	_bisect_err=$(expr $_list_size - $_bisection_size \* 2)
+	test "$_bisect_err" -lt 0 && _bisect_err=$(expr 0 - $_bisect_err)
+	_bisect_err=$(expr $_bisect_err / 2) ; # floor
+
+	test_expect_success \
+	"bisection diff $_bisect_option $_head $* <= $_max_diff" \
+	'test $_bisect_err -le $_max_diff'
+}
+
+date >path0
+git update-index --add path0
+save_tag tree git write-tree
+on_committer_date "00:00" hide_error save_tag root unique_commit root tree
+on_committer_date "00:01" save_tag l0 unique_commit l0 tree -p root
+on_committer_date "00:02" save_tag l1 unique_commit l1 tree -p l0
+on_committer_date "00:03" save_tag l2 unique_commit l2 tree -p l1
+on_committer_date "00:04" save_tag a0 unique_commit a0 tree -p l2
+on_committer_date "00:05" save_tag a1 unique_commit a1 tree -p a0
+on_committer_date "00:06" save_tag b1 unique_commit b1 tree -p a0
+on_committer_date "00:07" save_tag c1 unique_commit c1 tree -p b1
+on_committer_date "00:08" save_tag b2 unique_commit b2 tree -p b1
+on_committer_date "00:09" save_tag b3 unique_commit b2 tree -p b2
+on_committer_date "00:10" save_tag c2 unique_commit c2 tree -p c1 -p b2
+on_committer_date "00:11" save_tag c3 unique_commit c3 tree -p c2
+on_committer_date "00:12" save_tag a2 unique_commit a2 tree -p a1
+on_committer_date "00:13" save_tag a3 unique_commit a3 tree -p a2
+on_committer_date "00:14" save_tag b4 unique_commit b4 tree -p b3 -p a3
+on_committer_date "00:15" save_tag a4 unique_commit a4 tree -p a3 -p b4 -p c3
+on_committer_date "00:16" save_tag l3 unique_commit l3 tree -p a4
+on_committer_date "00:17" save_tag l4 unique_commit l4 tree -p l3
+on_committer_date "00:18" save_tag l5 unique_commit l5 tree -p l4
+git update-ref HEAD $(tag l5)
+
+
+#     E
+#    / \
+#   e1  |
+#   |   |
+#   e2  |
+#   |   |
+#   e3  |
+#   |   |
+#   e4  |
+#   |   |
+#   |   f1
+#   |   |
+#   |   f2
+#   |   |
+#   |   f3
+#   |   |
+#   |   f4
+#   |   |
+#   e5  |
+#   |   |
+#   e6  |
+#   |   |
+#   e7  |
+#   |   |
+#   e8  |
+#    \ /
+#     F
+
+
+on_committer_date "00:00" hide_error save_tag F unique_commit F tree
+on_committer_date "00:01" save_tag e8 unique_commit e8 tree -p F
+on_committer_date "00:02" save_tag e7 unique_commit e7 tree -p e8
+on_committer_date "00:03" save_tag e6 unique_commit e6 tree -p e7
+on_committer_date "00:04" save_tag e5 unique_commit e5 tree -p e6
+on_committer_date "00:05" save_tag f4 unique_commit f4 tree -p F
+on_committer_date "00:06" save_tag f3 unique_commit f3 tree -p f4
+on_committer_date "00:07" save_tag f2 unique_commit f2 tree -p f3
+on_committer_date "00:08" save_tag f1 unique_commit f1 tree -p f2
+on_committer_date "00:09" save_tag e4 unique_commit e4 tree -p e5
+on_committer_date "00:10" save_tag e3 unique_commit e3 tree -p e4
+on_committer_date "00:11" save_tag e2 unique_commit e2 tree -p e3
+on_committer_date "00:12" save_tag e1 unique_commit e1 tree -p e2
+on_committer_date "00:13" save_tag E unique_commit E tree -p e1 -p f1
+
+on_committer_date "00:00" hide_error save_tag U unique_commit U tree
+on_committer_date "00:01" save_tag u0 unique_commit u0 tree -p U
+on_committer_date "00:01" save_tag u1 unique_commit u1 tree -p u0
+on_committer_date "00:02" save_tag u2 unique_commit u2 tree -p u0
+on_committer_date "00:03" save_tag u3 unique_commit u3 tree -p u0
+on_committer_date "00:04" save_tag u4 unique_commit u4 tree -p u0
+on_committer_date "00:05" save_tag u5 unique_commit u5 tree -p u0
+on_committer_date "00:06" save_tag V unique_commit V tree -p u1 -p u2 -p u3 -p u4 -p u5
+
+test_sequence()
+{
+	_bisect_option=$1
+
+	test_bisection_diff 0 $_bisect_option l0 ^root
+	test_bisection_diff 0 $_bisect_option l1 ^root
+	test_bisection_diff 0 $_bisect_option l2 ^root
+	test_bisection_diff 0 $_bisect_option a0 ^root
+	test_bisection_diff 0 $_bisect_option a1 ^root
+	test_bisection_diff 0 $_bisect_option a2 ^root
+	test_bisection_diff 0 $_bisect_option a3 ^root
+	test_bisection_diff 0 $_bisect_option b1 ^root
+	test_bisection_diff 0 $_bisect_option b2 ^root
+	test_bisection_diff 0 $_bisect_option b3 ^root
+	test_bisection_diff 0 $_bisect_option c1 ^root
+	test_bisection_diff 0 $_bisect_option c2 ^root
+	test_bisection_diff 0 $_bisect_option c3 ^root
+	test_bisection_diff 0 $_bisect_option E ^F
+	test_bisection_diff 0 $_bisect_option e1 ^F
+	test_bisection_diff 0 $_bisect_option e2 ^F
+	test_bisection_diff 0 $_bisect_option e3 ^F
+	test_bisection_diff 0 $_bisect_option e4 ^F
+	test_bisection_diff 0 $_bisect_option e5 ^F
+	test_bisection_diff 0 $_bisect_option e6 ^F
+	test_bisection_diff 0 $_bisect_option e7 ^F
+	test_bisection_diff 0 $_bisect_option f1 ^F
+	test_bisection_diff 0 $_bisect_option f2 ^F
+	test_bisection_diff 0 $_bisect_option f3 ^F
+	test_bisection_diff 0 $_bisect_option f4 ^F
+	test_bisection_diff 0 $_bisect_option E ^F
+
+	test_bisection_diff 1 $_bisect_option V ^U
+	test_bisection_diff 0 $_bisect_option V ^U ^u1 ^u2 ^u3
+	test_bisection_diff 0 $_bisect_option u1 ^U
+	test_bisection_diff 0 $_bisect_option u2 ^U
+	test_bisection_diff 0 $_bisect_option u3 ^U
+	test_bisection_diff 0 $_bisect_option u4 ^U
+	test_bisection_diff 0 $_bisect_option u5 ^U
+
+#
+# the following illustrates Linus' binary bug blatt idea.
+#
+# assume the bug is actually at l3, but you don't know that - all you know is that l3 is broken
+# and it wasn't broken before
+#
+# keep bisecting the list, advancing the "bad" head and accumulating "good" heads until
+# the bisection point is the head - this is the bad point.
+#
+
+test_output_expect_success "$_bisect_option l5 ^root" 'git rev-list $_bisect_option l5 ^root' <<EOF
+c3
+EOF
+
+test_output_expect_success "$_bisect_option l5 ^root ^c3" 'git rev-list $_bisect_option l5 ^root ^c3' <<EOF
+b4
+EOF
+
+test_output_expect_success "$_bisect_option l5 ^root ^c3 ^b4" 'git rev-list $_bisect_option l5 ^c3 ^b4' <<EOF
+l3
+EOF
+
+test_output_expect_success "$_bisect_option l3 ^root ^c3 ^b4" 'git rev-list $_bisect_option l3 ^root ^c3 ^b4' <<EOF
+a4
+EOF
+
+test_output_expect_success "$_bisect_option l5 ^b3 ^a3 ^b4 ^a4" 'git rev-list $_bisect_option l3 ^b3 ^a3 ^a4' <<EOF
+l3
+EOF
+
+#
+# if l3 is bad, then l4 is bad too - so advance the bad pointer by making b4 the known bad head
+#
+
+test_output_expect_success "$_bisect_option l4 ^a2 ^a3 ^b ^a4" 'git rev-list $_bisect_option l4 ^a2 ^a3 ^a4' <<EOF
+l3
+EOF
+
+test_output_expect_success "$_bisect_option l3 ^a2 ^a3 ^b ^a4" 'git rev-list $_bisect_option l3 ^a2 ^a3 ^a4' <<EOF
+l3
+EOF
+
+# found!
+
+#
+# as another example, let's consider a4 to be the bad head, in which case
+#
+
+test_output_expect_success "$_bisect_option a4 ^a2 ^a3 ^b4" 'git rev-list $_bisect_option a4 ^a2 ^a3 ^b4' <<EOF
+c2
+EOF
+
+test_output_expect_success "$_bisect_option a4 ^a2 ^a3 ^b4 ^c2" 'git rev-list $_bisect_option a4 ^a2 ^a3 ^b4 ^c2' <<EOF
+c3
+EOF
+
+test_output_expect_success "$_bisect_option a4 ^a2 ^a3 ^b4 ^c2 ^c3" 'git rev-list $_bisect_option a4 ^a2 ^a3 ^b4 ^c2 ^c3' <<EOF
+a4
+EOF
+
+# found!
+
+#
+# or consider c3 to be the bad head
+#
+
+test_output_expect_success "$_bisect_option a4 ^a2 ^a3 ^b4" 'git rev-list $_bisect_option a4 ^a2 ^a3 ^b4' <<EOF
+c2
+EOF
+
+test_output_expect_success "$_bisect_option c3 ^a2 ^a3 ^b4 ^c2" 'git rev-list $_bisect_option c3 ^a2 ^a3 ^b4 ^c2' <<EOF
+c3
+EOF
+
+# found!
+
+}
+
+test_sequence "--bisect"
+
+#
+#
+
+test_expect_success 'set up fake --bisect refs' '
+	git update-ref refs/bisect/bad c3 &&
+	good=$(git rev-parse b1) &&
+	git update-ref refs/bisect/good-$good $good &&
+	good=$(git rev-parse c1) &&
+	git update-ref refs/bisect/good-$good $good
+'
+
+test_expect_success 'rev-list --bisect can default to good/bad refs' '
+	# the only thing between c3 and c1 is c2
+	git rev-parse c2 >expect &&
+	git rev-list --bisect >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rev-parse --bisect can default to good/bad refs' '
+	git rev-parse c3 ^b1 ^c1 >expect &&
+	git rev-parse --bisect >actual &&
+
+	# output order depends on the refnames, which in turn depends on
+	# the exact sha1s. We just want to make sure we have the same set
+	# of lines in any order.
+	sort <expect >expect.sorted &&
+	sort <actual >actual.sorted &&
+	test_cmp expect.sorted actual.sorted
+'
+
+test_output_expect_success '--bisect --first-parent' 'git rev-list --bisect --first-parent E ^F' <<EOF
+e4
+EOF
+
+test_output_expect_success '--first-parent' 'git rev-list --first-parent E ^F' <<EOF
+E
+e1
+e2
+e3
+e4
+e5
+e6
+e7
+e8
+EOF
+
+test_output_expect_success '--bisect-vars --first-parent' 'git rev-list --bisect-vars --first-parent E ^F' <<EOF
+bisect_rev='e5'
+bisect_nr=4
+bisect_good=4
+bisect_bad=3
+bisect_all=9
+bisect_steps=2
+EOF
+
+test_expect_success '--bisect-all --first-parent' '
+	cat >expect.unsorted <<-EOF &&
+	$(git rev-parse E) (tag: E, dist=0)
+	$(git rev-parse e1) (tag: e1, dist=1)
+	$(git rev-parse e2) (tag: e2, dist=2)
+	$(git rev-parse e3) (tag: e3, dist=3)
+	$(git rev-parse e4) (tag: e4, dist=4)
+	$(git rev-parse e5) (tag: e5, dist=4)
+	$(git rev-parse e6) (tag: e6, dist=3)
+	$(git rev-parse e7) (tag: e7, dist=2)
+	$(git rev-parse e8) (tag: e8, dist=1)
+	EOF
+
+	# expect results to be ordered by distance (descending),
+	# commit hash (ascending)
+	sort -k4,4r -k1,1 expect.unsorted >expect &&
+	git rev-list --bisect-all --first-parent E ^F >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--bisect without any revisions' '
+	git rev-list --bisect HEAD..HEAD >out &&
+	test_must_be_empty out
+'
+
+test_done
-- 
2.54.0


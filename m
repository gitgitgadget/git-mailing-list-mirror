Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04803B635A
	for <git@vger.kernel.org>; Sat,  1 Aug 2026 17:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785606128; cv=none; b=iJMcCpFDYOWYR8Pfyqx/wfkjVYzMxXNvulC3cybRYW1VtKMzPBDhkTvhNn5A+GosxOPvvEgrLCBbBeob5pzkpoRJ+naJ5vAge0L4rdFa26Svv7QdWxFeHl3LEj64b/Yh1aK644BqK/7goslk8tk5jq58hAL3VI/Al+39EBSHjCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785606128; c=relaxed/simple;
	bh=BLHV0XoMJZU/mwpLcHZNZxOTw2VsifA5+m9ySEvBNZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OM5CJaqYM2ivSCEhB6dhM0dFxKz6bmsReyZpwj+7+jh68KuqrBttsZYAx9Z+5E7zVWGhgzbBEMAPIjAQNQ4JlDCfyphPAEb6tZoPNkS8MPMZWX41I1RxdFhumQR9lme2dBUcKCdmAizNfOXmKTULXOsvIi6DCGt84S3xitxVCs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lt7VDHdF; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lt7VDHdF"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8485b358552so2313869b3a.2
        for <git@vger.kernel.org>; Sat, 01 Aug 2026 10:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785606125; x=1786210925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fS23djcbMxDns4nxjQESJDPo5UIrgE8TzE3vs0UHblU=;
        b=lt7VDHdFyG+meeD6sqY+VNzbiyvSzjvRK3cmkUF5wkcrl3WKE8jjBQ7RwkL6x45/pG
         G4d09TWHAv5foi8DHp4++aCWwooioZfryxrcb3oLbL6+qeC6IM/xv7bgjPdHw6585iB6
         OLcGOKxPnRMuYZ4HU+6S2QDNmNgWA09S0HLJV3/q6LAyexRdWJhy7YqV1U/CP4c98vKK
         TDK30+uUZfdRyVoCI/02DvN82xh7JkCM1Cja1uUYOOV+vhqWucIZK9zGCzikGlETMXS7
         uRn0YWU3yDvdGulrYe9SRgRxM9AooCyitHYBGr3MhEk/owh/7jgz25CMSGJZcuQnLLsq
         SWpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785606125; x=1786210925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fS23djcbMxDns4nxjQESJDPo5UIrgE8TzE3vs0UHblU=;
        b=sJUDHYS8Q18UuOw6ylu9sHUheX2+GEHT9tanx8D3x/N7FWmB1dsswhCl6uesZSAa+o
         1g1YCCcYmF8qrz9c7LUGmjwF1j6S+qhZiN7T1OT8WvFG973UKQB1fiYfJIEOo5nztRaW
         62Od/wpWb2UpWyBbxCc7EyXT9nU8zYnuOobdeFihWYBfO0VUhWNvHKds9TRHul2dGXx1
         bzOnX2VJKxKbxQ2eTKDl3ZvMErGQNuPnG8iHeJlH4OmW9qFXuJegBY5ly+DzL3/6t2M6
         58Y+WJCaCUjITvBY3jd/0kFgoqT2D4ftedv+yDpofhcMdKP7xEnOIv/eQ62EEKq2dKo0
         TU8Q==
X-Gm-Message-State: AOJu0Yyrl9lUcgXujomWCADnrsVx1cBk7IhgGRF/rDimy26BR+/ZllAW
	VVtQNNWT+LSulgqvspu0H0demBAZ28Xxhhli9EWBspip20h6v+V8ljnZpxr1vw==
X-Gm-Gg: AR+sD12SBZ7THRZqE5LyO7xppJysjMVnA86IWnRRzJK3Qnv2Al6gxRVom1AYsZbeA+h
	abILcy2NusHHwaQJOEOsCFUE1VisHsjJOY5ptAWZ6rDbt9+7a1ZYnuZdJPMe/DRclrESlV4+AqX
	KuQC15KiAPdpaud2PCruNT2Lad/S/zjCetRFAOiGlky2NiB/Du7MS01PhhEtNKFQ9kDtueeF0Mw
	QcYcKVXMyoxNPuabQ5AyeD7RuJdKvxhwYTEpCq9TcfaFMg6s4vPbXegjidsxBpx5Mj0eTdJ8HmQ
	iyQMRAA5YfpIFJk+9+m7xozSO0okkWhPjTVgHGULKEL3ngt2KA8Ol3sMtPvr/IX+jMbY/bodY49
	nCk+xC1+kbZsfKNEf1CrrryTIO3XWbQ7B5TKNqVF/gEbFnQZs6jeNwJ/LbIkdSHdD4QoNWa1WXQ
	9LWaWAKokpmJgcJmgeaqM3Ga+x6FSE2JyzuAoh2nmvqfiQ4rbdlkx6HzHY4FbvvaQ+nLaEOI7PE
	fh3I0jvhJYL6HVjckwpR8Yr7hA2NxshJPNGawmAHJ9zkc+jj/fW7nsymCGd/kBEMclATnO4cFkV
	LpUPM6DE2rGBE6Kx1C3RseEr7z9mw8PjucqruiE2EEymoQ==
X-Received: by 2002:a05:6a20:a123:b0:3c4:1916:9d4a with SMTP id adf61e73a8af0-3c92a82274bmr3432111637.51.1785606124427;
        Sat, 01 Aug 2026 10:42:04 -0700 (PDT)
Received: from localhost (192-184-169-91.fiber.dynamic.sonic.net. [192.184.169.91])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e045022sm18451209eec.18.2026.08.01.10.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 10:42:03 -0700 (PDT)
From: Michael Montalbo <mmontalbo@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [RFC PATCH v7 05/10] diff: read precomputed hunks for stat output
Date: Sat,  1 Aug 2026 10:41:48 -0700
Message-ID: <20260801174156.2998808-6-mmontalbo@gmail.com>
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

Teach builtin_diffstat() to consult the hunk provider interface through
diff_provider_consult(), new here: the consult-only entry that answers
without loading content or computing, so it never returns
DIFF_PROVIDER_ERROR.  On an answer, the summing callback accumulates the
provided counts directly into the diffstat entry; the blobs were already
loaded for the binary check, so an answer saves the diff run, not the
content load (blame, taught next, skips its loads too).  On an
unanswered outcome it computes as before and, with a writer attached,
records what it computed; on unanswered-no-record it computes without
recording.

The provider behind the consult is the diff-hunks store, registered in
front of the terminal builtin computation.  Its consult serves a
recorded pair through diff_hunks_replay(), which validates the sequence
before any hunk reaches the callback, so direct accumulation is safe.
The request gains the pair's object ids and the diff options read by the
exclusions below.  A side whose bytes are not a stored blob, such as a
working-tree file or a gitlink, has a NULL id; the store passes it by and
the terminal provider computes it.  diff_provider_emit_hunks() walks the
same chain, so blame's requests follow these rules the moment blame
supplies identity.  The walk also insists, as a BUG check, that a
request's diff options belong to the repository whose chain it walks.

Each exclusion lives with the provider whose key cannot express it.  -I
patterns and --anchored shape the diff outside the store key, and break
detection (-B) rescores the pair outside it; the store's consult maps
all three to stop-no-record, so such a request is neither served nor
recorded for any consumer.  The consumer-side guard the recording commit
carried for those three comes out here.  The compile-time assert on
xpparam_t's layout sits next to that decision, forcing an explicit
keying decision whenever a diff parameter is added.  The stat consumer
keeps only the exclusion that is not about the key: --ignore-blank-lines
is part of the key but coalesces hunks differently between the
text-emitting and coordinate-callback paths, so the consumer returns
before consulting.  A "log -L" range-scoped stat neither reads nor
records; the line-range filter computes it as before.

"git diff", "git log", "git show", and "git diff-tree" with the --stat,
--numstat, and --shortstat formats consult the interface.  Reading is
controlled by core.diffHunks.

An answer is invisible in the output, so the store counts the pairs it
serves and the consultations it cannot, and diff_hunks_read_stats()
reports both; the stat path emits the hits as a trace2 "read-hits" datum
for tests and tuning.  The counters live on the store because only the
store knows whether a consultation reached it, and none of its exclusion
legs reaches the replay, so none counts as a miss.

Extend t4220 with the read half:

- output parity with and without the store, at several context lengths
  and both directions, and reversed pairs keying apart;
- the consultation made visible through the read-hits datum, and the
  trim-divergent pair correct at every context;
- the settings that must bypass the store doing so in both directions
  (-I, -B, --anchored, --ignore-blank-lines), asserted through the trace
  rather than output parity alone, which a coincidentally equal count
  could satisfy;
- a driver-forced algorithm keying apart rather than bypassing: it is
  part of the key, so a read under it misses the default entries and a
  warm records under its own.

A "log -L" range-scoped stat neither reads nor records.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 builtin/log.c            |   7 +
 diff-hunks.c             |  88 +++++++++++-
 diff-hunks.h             |   8 ++
 diff-provider-internal.h |   7 +
 diff-provider.c          |  62 +++++++--
 diff-provider.h          |  28 +++-
 diff.c                   |  86 ++++++++----
 diff.h                   |  20 ++-
 t/t4220-diff-hunks.sh    | 280 +++++++++++++++++++++++++++++++++++++++
 9 files changed, 539 insertions(+), 47 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 6903bdd5ff..0b72477f56 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -2225,6 +2225,13 @@ int cmd_format_patch(int argc,
 	if (argc > 1)
 		die(_("unrecognized argument: %s"), argv[1]);
 
+	/*
+	 * A patch generated by format-patch carries the builtin diffstat,
+	 * not one served from a local store, so its counts do not depend
+	 * on whether the sender warmed the store.
+	 */
+	rev.diffopt.flags.no_precomputed_hunks = 1;
+
 	if (rev.diffopt.output_format & DIFF_FORMAT_NAME)
 		die(_("--name-only does not make sense"));
 	if (rev.diffopt.output_format & DIFF_FORMAT_NAME_STATUS)
diff --git a/diff-hunks.c b/diff-hunks.c
index 23cefe055b..9830df07fa 100644
--- a/diff-hunks.c
+++ b/diff-hunks.c
@@ -26,6 +26,7 @@
 #include "csum-file.h"
 #include "diff-hunks.h"
 #include "diff-provider-internal.h"
+#include "diff.h"
 #include "gettext.h"
 #include "hash.h"
 #include "hashmap.h"
@@ -140,6 +141,10 @@ struct diff_hunks_store {
 	uint32_t num_entries;
 	const unsigned char *hdat;
 	size_t hdat_size;
+
+	/* Consultation counters; see diff_hunks_read_stats(). */
+	unsigned long read_hits;
+	unsigned long read_misses;
 };
 
 static void free_store(struct diff_hunks_store *s)
@@ -256,6 +261,15 @@ struct diff_hunks_store *repo_diff_hunks_store(struct repository *r)
 	return r->objects->diff_hunks_store;
 }
 
+void diff_hunks_read_stats(struct repository *r,
+			   unsigned long *hits, unsigned long *misses)
+{
+	struct diff_hunks_store *s = repo_diff_hunks_store(r);
+
+	*hits = s ? s->read_hits : 0;
+	*misses = s ? s->read_misses : 0;
+}
+
 void close_diff_hunks_store(struct object_database *o)
 {
 	if (!o->diff_hunks_store)
@@ -413,18 +427,90 @@ int diff_hunks_replay(struct diff_hunks_store *s,
 	struct precomputed_entry e;
 	uint32_t i;
 
+	if (!s)
+		return 0;
 	if (!diff_hunks_store_get(s, old_oid, new_oid, xdl_opts, &e) ||
-	    !replayable_hunks(&e))
+	    !replayable_hunks(&e)) {
+		s->read_misses++;
 		return 0;
+	}
 	for (i = 0; i < e.num_hunks; i++) {
 		struct precomputed_hunk h;
 		nth_precomputed_hunk(&e, i, &h);
 		hunk_func(h.old_start, h.old_count,
 			  h.new_start, h.new_count, cb_data);
 	}
+	s->read_hits++;
 	return 1;
 }
 
+/*
+ * The store's consult implementation.  The store is not
+ * authoritative, so it serves a recorded pair or passes; what the
+ * recording key cannot express, it excludes here with the
+ * stop-no-record disposition.  None of those legs reaches
+ * diff_hunks_replay(), so none of them counts as a miss.
+ */
+static enum diff_provider_disposition
+diff_hunks_store_consult(struct diff_provider *provider UNUSED,
+			 const struct diff_provider_request *req,
+			 diff_provider_fill_fn fill UNUSED,
+			 void *fill_data UNUSED,
+			 xdl_emit_hunk_consume_func_t hunk_cb, void *cb_data)
+{
+	/*
+	 * xpparam_t is the consult's parameter input.  Its flags are
+	 * the store key's xdl_opts; ignore_regex (-I) and anchors
+	 * (--anchored) shape the diff outside the key, so such a
+	 * request is neither served nor recorded.
+	 *
+	 * Adding an xpparam_t field fires this assert (its size no
+	 * longer matches the reference struct).  To clear it: (1) add
+	 * the field to the reference struct below; then (2) decide how
+	 * it affects the key: make it part of the key, or exclude
+	 * diffs that use it here with the disposition below.  The
+	 * assert only tracks size: a same-size reorder or a changed
+	 * field meaning slips past, so re-read the fields when it
+	 * fires.
+	 */
+	(void)BUILD_ASSERT_OR_ZERO(sizeof(xpparam_t) == sizeof(struct {
+		unsigned long flags;
+		regex_t **ignore_regex;
+		size_t ignore_regex_nr;
+		char **anchors;
+		size_t anchors_nr;
+	}));
+	if (req->xpp->ignore_regex_nr || req->xpp->anchors_nr)
+		return DIFF_PROVIDER_DISP_STOP_NO_RECORD;
+	/*
+	 * Break detection (-B) rescores the pair outside xpparam_t, so
+	 * it is outside the key for the same reason.
+	 */
+	if (req->diffopt && req->diffopt->break_opt != -1)
+		return DIFF_PROVIDER_DISP_STOP_NO_RECORD;
+
+	if (!req->old_oid || !req->new_oid)
+		return DIFF_PROVIDER_DISP_PASS;
+	if (diff_hunks_replay(repo_diff_hunks_store(req->repo),
+			      req->old_oid, req->new_oid,
+			      req->xpp->flags, hunk_cb, cb_data))
+		return DIFF_PROVIDER_DISP_ANSWERED;
+	return DIFF_PROVIDER_DISP_PASS;
+}
+
+/*
+ * The provider borrows the repository's store through
+ * repo_diff_hunks_store() per request; the object database owns the
+ * file and tears it down, so there is nothing to release here.
+ */
+struct diff_provider *diff_hunks_store_provider_new(void)
+{
+	struct diff_provider *p = xcalloc(1, sizeof(*p));
+
+	p->consult = diff_hunks_store_consult;
+	return p;
+}
+
 /* Validate one store file. Returns 0 if valid or absent, -1 on any error. */
 static int verify_store_at(struct repository *r, const char *fname)
 {
diff --git a/diff-hunks.h b/diff-hunks.h
index 89e56f4b1b..c58500d05c 100644
--- a/diff-hunks.h
+++ b/diff-hunks.h
@@ -62,6 +62,14 @@ struct diff_hunks_store *repo_diff_hunks_store(struct repository *r);
 /* Free the repository's cached store, at object-database teardown. */
 void close_diff_hunks_store(struct object_database *o);
 
+/*
+ * Consultation counters for the repository's store: pairs the store
+ * served (hits) and pairs it was consulted for but could not serve
+ * (misses). Both zero when reading is disabled or no store exists.
+ */
+void diff_hunks_read_stats(struct repository *r,
+			   unsigned long *hits, unsigned long *misses);
+
 /*
  * Replay the recorded hunks of an (old blob, new blob) pair diffed
  * under xdl_opts through hunk_func. The sequence is validated before
diff --git a/diff-provider-internal.h b/diff-provider-internal.h
index 8dd8e4b0dc..8ad3e481e7 100644
--- a/diff-provider-internal.h
+++ b/diff-provider-internal.h
@@ -88,6 +88,13 @@ struct diff_provider {
 	struct diff_provider *next;
 };
 
+/*
+ * The providers Git ships, besides the builtin computation that
+ * diff-provider.c holds itself.  Each call returns a fresh provider
+ * for one repository's chain.
+ */
+struct diff_provider *diff_hunks_store_provider_new(void);
+
 /*
  * Incremental well-formedness check for a provider-supplied hunk
  * sequence, shared by every provider.  Each coordinate, and each
diff --git a/diff-provider.c b/diff-provider.c
index b69854fb63..66a9909eaa 100644
--- a/diff-provider.c
+++ b/diff-provider.c
@@ -1,5 +1,7 @@
 #include "git-compat-util.h"
+#include "diff.h"
 #include "diff-provider-internal.h"
+#include "replace-object.h"
 #include "repository.h"
 
 /*
@@ -39,10 +41,11 @@ static struct diff_provider *builtin_provider_new(void)
 
 /*
  * The repository's chain, assembled on first walk.  The composition
- * is fixed; the builtin computation is the terminal provider, so the
- * chain always ends in an implementor that can answer.  Nothing is
- * decided per repository here; each provider gates itself per
- * request.
+ * is fixed, and the order is the authority resolution: the store is
+ * consulted before the builtin computation, the terminal provider,
+ * so the chain always ends in an implementor that can answer.
+ * Nothing is decided per repository here; each provider gates itself
+ * per request.
  */
 static struct diff_provider *provider_chain(struct repository *r)
 {
@@ -50,6 +53,8 @@ static struct diff_provider *provider_chain(struct repository *r)
 
 	if (*tail)
 		return *tail;
+	*tail = diff_hunks_store_provider_new();
+	tail = &(*tail)->next;
 	*tail = builtin_provider_new();
 	return r->diff_providers;
 }
@@ -70,16 +75,16 @@ void diff_providers_clear(struct repository *r)
 }
 
 /*
- * The walk behind diff_provider_emit_hunks(): consult the chain in
- * order and map its dispositions onto the outcome set.  The first
- * answer ends the walk.  A stop-no-record disposition
- * (diff-provider-internal.h) is a refusal, not a pass: the provider
- * does not answer, but rules the pair out of identity service and
- * out of recording, so from then on the walk consults only the
- * computing provider, and a walk that ends unanswered carries the
- * no-record verdict.  With a fill callback the terminal provider
- * computes instead of passing, so an emit walk returns only
- * answered or error.
+ * The walk shared by diff_provider_consult() and
+ * diff_provider_emit_hunks(): consult the chain in order and map its
+ * dispositions onto the outcome set.  The first answer ends the
+ * walk.  A stop-no-record disposition (diff-provider-internal.h)
+ * is a refusal, not a pass: the provider does not answer, but rules
+ * the pair out of identity service and out of recording, so from
+ * then on the walk consults only the computing provider, and a walk
+ * that ends unanswered carries the no-record verdict.  With a fill
+ * callback the terminal provider computes instead of passing, so an
+ * emit walk returns only answered or error.
  */
 static enum diff_provider_outcome
 walk_providers(const struct diff_provider_request *req,
@@ -89,6 +94,28 @@ walk_providers(const struct diff_provider_request *req,
 	struct diff_provider *p;
 	int no_record = 0;
 
+	if (req->diffopt && req->diffopt->repo != req->repo)
+		BUG("diff provider request walks one repository's chain "
+		    "with another repository's diff options");
+
+	/*
+	 * An object replacement redirects a blob's content
+	 * (OBJECT_INFO_LOOKUP_REPLACE) while leaving the id that names it
+	 * unchanged, so an answer keyed on the raw id would be the
+	 * pre-replacement diff.  A replacement is therefore a parameter
+	 * outside the recording key: no provider may serve a replaced pair
+	 * from its identity, and a result computed for it must not be
+	 * recorded under the raw id.  Mark the walk no-record so the
+	 * identity providers step aside and the builtin computes from the
+	 * replaced content.  The check is a no-op when the repository has
+	 * no replace refs.
+	 */
+	if ((req->old_oid &&
+	     lookup_replace_object(req->repo, req->old_oid) != req->old_oid) ||
+	    (req->new_oid &&
+	     lookup_replace_object(req->repo, req->new_oid) != req->new_oid))
+		no_record = 1;
+
 	for (p = provider_chain(req->repo); p; p = p->next) {
 		enum diff_provider_disposition disp;
 
@@ -118,6 +145,13 @@ walk_providers(const struct diff_provider_request *req,
 		DIFF_PROVIDER_UNANSWERED;
 }
 
+enum diff_provider_outcome
+diff_provider_consult(const struct diff_provider_request *req,
+		      xdl_emit_hunk_consume_func_t hunk_cb, void *cb_data)
+{
+	return walk_providers(req, NULL, NULL, hunk_cb, cb_data);
+}
+
 enum diff_provider_hunks_error
 diff_provider_check_hunk(struct diff_provider_hunks_check *c,
 			  long old_start, long old_count,
diff --git a/diff-provider.h b/diff-provider.h
index 1a7e4e299c..c5478b5700 100644
--- a/diff-provider.h
+++ b/diff-provider.h
@@ -26,6 +26,8 @@
  * sees it.
  */
 
+struct diff_options;
+struct object_id;
 struct repository;
 
 /*
@@ -89,15 +91,35 @@ enum diff_provider_outcome {
  * A consultation request.  The interface consults providers from
  * these fields alone; no content is loaded before an answer.
  *
- * repo owns the provider chain the request walks.  xpp carries the
- * parameters the diff runs with.  Each provider gates itself on the
- * fields that concern it.
+ * repo owns the provider chain the request walks.  old_oid/new_oid
+ * name the blobs whose bytes are diffed; pass NULL for a side whose
+ * bytes are not a stored blob (a working-tree file, textconv output,
+ * a gitlink), so no provider answers from an id it cannot look up.
+ * diffopt carries the diff settings that live outside xpp; xpp
+ * carries the parameters the diff runs with.  Each provider gates
+ * itself on the fields that concern it.
  */
 struct diff_provider_request {
 	struct repository *repo;
+	const struct object_id *old_oid;
+	const struct object_id *new_oid;
+	struct diff_options *diffopt;
 	const xpparam_t *xpp;
 };
 
+/*
+ * Consult the providers for the request's pair without computing.
+ * On DIFF_PROVIDER_ANSWERED the hunks were emitted through hunk_cb
+ * (0-based emission coordinates, context 0) and were validated
+ * before the first callback ran, so a consumer may accumulate
+ * directly into its result.  Never returns DIFF_PROVIDER_ERROR.
+ * The callback's return value is not consulted: emission of a
+ * validated answer has no error leg, so the callback must return 0.
+ */
+enum diff_provider_outcome
+diff_provider_consult(const struct diff_provider_request *req,
+		      xdl_emit_hunk_consume_func_t hunk_cb, void *cb_data);
+
 /*
  * Load the pair's content.  Called at most once per request, only
  * when the ranges are computed rather than provided.  The buffers
diff --git a/diff.c b/diff.c
index 11ec88dc8c..0d4cb3fcfd 100644
--- a/diff.c
+++ b/diff.c
@@ -17,6 +17,7 @@
 #include "quote.h"
 #include "diff.h"
 #include "diff-hunks.h"
+#include "diff-provider.h"
 #include "diffcore.h"
 #include "delta.h"
 #include "hex.h"
@@ -35,6 +36,7 @@
 #include "tmp-objdir.h"
 #include "graph.h"
 #include "oid-array.h"
+#include "trace2.h"
 #include "packfile.h"
 #include "pager.h"
 #include "parse-options.h"
@@ -2992,6 +2994,11 @@ void diff_hunks_attach(struct diff_options *o)
 
 void diff_hunks_detach(struct diff_options *o)
 {
+	unsigned long hits, misses;
+
+	diff_hunks_read_stats(o->repo, &hits, &misses);
+	if (hits)
+		trace2_data_intmax("diff-hunks", o->repo, "read-hits", hits);
 	diff_hunks_writer_finish(o->hunks_writer);
 	o->hunks_writer = NULL;
 }
@@ -4321,18 +4328,35 @@ static const char *get_compact_summary(const struct diff_filepair *p, int is_ren
 }
 
 /*
- * Fill data->added/deleted for a modified pair by collecting its hunk
- * coordinates, and record them into the store. Runs only on a warming
- * run; returns 1 when it produced the counts, 0 when the caller must
- * compute the diffstat itself.
+ * Hunk callback for the provider interface: sum counts into a
+ * diffstat entry.
+ */
+static int diffstat_sum_hunk_cb(long start_a UNUSED, long count_a,
+				long start_b UNUSED, long count_b,
+				void *cb_data)
+{
+	struct diffstat_file *data = cb_data;
+
+	data->added += count_b;
+	data->deleted += count_a;
+	return 0;
+}
+
+/*
+ * Fill data->added/deleted for a modified pair through the hunk provider
+ * interface: on an answer, sum the provided counts; on a warming run,
+ * compute and record them. Returns 1 when it produced the counts, 0 when
+ * the caller must compute the diffstat itself.
  *
- * --ignore-blank-lines is excluded: that flag is part of the store
- * key, but it coalesces hunks differently between the emit and
- * hunk-callback paths, so a recorded entry would not match a
- * store-less run's --stat output. (--inter-hunk-context is not
- * excluded: it only groups hunks, and diffstat sums their counts,
- * which grouping does not change.) Recording requires both sides to
- * be valid regular files whose blobs the key can name.
+ * The providers own the exclusions the request can express (-B, -I,
+ * and --anchored are outside the store key). This consumer additionally
+ * excludes --ignore-blank-lines before consulting: that flag is part of
+ * the key, but it coalesces hunks differently between the emit and
+ * hunk-callback paths, so a served answer would not match a store-less
+ * run's --stat output. (--inter-hunk-context is not excluded: it only
+ * groups hunks, and diffstat sums their counts, which grouping does not
+ * change.) Recording requires both sides to be valid regular files whose
+ * blobs the key can name.
  */
 static int diffstat_from_hunks(struct diff_options *o,
 			       struct diff_filespec *one,
@@ -4347,23 +4371,37 @@ static int diffstat_from_hunks(struct diff_options *o,
 			  .ignore_regex_nr = o->ignore_regex_nr,
 			  .anchors = o->anchors,
 			  .anchors_nr = o->anchors_nr };
+	struct diff_provider_request req = {
+		.repo = o->repo,
+		.old_oid = (one->oid_valid && !S_ISGITLINK(one->mode)) ?
+			   &one->oid : NULL,
+		.new_oid = (two->oid_valid && !S_ISGITLINK(two->mode)) ?
+			   &two->oid : NULL,
+		.diffopt = o,
+		.xpp = &xpp,
+	};
 
 	if (o->xdl_opts & XDF_IGNORE_BLANK_LINES)
 		return 0;
+	/* format-patch keeps its diffstat off the store (see the flag). */
+	if (o->flags.no_precomputed_hunks)
+		return 0;
 
-	/* Not a warming run: the caller computes the diffstat. */
-	if (!o->hunks_writer)
+	switch (diff_provider_consult(&req, diffstat_sum_hunk_cb, data)) {
+	case DIFF_PROVIDER_ANSWERED:
+		return 1;
+	case DIFF_PROVIDER_UNANSWERED:
+		break;
+	case DIFF_PROVIDER_ERROR: /* not returned by a consult */
+	case DIFF_PROVIDER_UNANSWERED_NO_RECORD:
 		return 0;
-	/*
-	 * -I patterns, --anchored anchors, and break detection (-B)
-	 * shape the diff outside the store key, so what they compute
-	 * must not be recorded under it.
-	 */
-	if (o->ignore_regex_nr || o->anchors_nr || o->break_opt != -1)
+	}
+
+	/* A miss on a read-only run: let the caller compute the diffstat. */
+	if (!o->hunks_writer)
 		return 0;
 	/* Recording needs blobs the key can name, on both sides. */
-	if (!one->oid_valid || !two->oid_valid ||
-	    S_ISGITLINK(one->mode) || S_ISGITLINK(two->mode) ||
+	if (!req.old_oid || !req.new_oid ||
 	    !DIFF_FILE_VALID(one) || !DIFF_FILE_VALID(two) ||
 	    !S_ISREG(one->mode) || !S_ISREG(two->mode))
 		return 0;
@@ -4453,9 +4491,9 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
 
 	else if (may_differ) {
 		/*
-		 * Record into the diff-hunks store on a warming run. A
-		 * "log -L" range-scoped stat is not the whole-pair diff
-		 * the store keys, so it does not record. Otherwise diff
+		 * Serve or record via the diff-hunks store. A "log -L"
+		 * range-scoped stat is not the whole-pair diff the store
+		 * keys, so it neither reads nor records. Otherwise diff
 		 * normally.
 		 */
 		if (p->line_ranges || !diffstat_from_hunks(o, one, two, data)) {
diff --git a/diff.h b/diff.h
index 3d44de39ff..6166598eea 100644
--- a/diff.h
+++ b/diff.h
@@ -206,6 +206,13 @@ struct diff_flags {
 	unsigned suppress_diff_headers;
 	unsigned dual_color_diffed_diffs;
 	unsigned suppress_hunk_header_line_count;
+
+	/*
+	 * Do not serve the diffstat from the precomputed-hunks store.
+	 * Set by format-patch so a generated patch carries the builtin
+	 * counts and does not depend on the sender's local store state.
+	 */
+	unsigned no_precomputed_hunks;
 };
 
 static inline void diff_flags_or(struct diff_flags *a,
@@ -422,9 +429,11 @@ struct diff_options {
 	int max_depth_valid;
 
 	/*
-	 * Precomputed diff hunks (see diff-hunks.h). When hunks_writer is
-	 * set (a warming run), diffstat records the hunks it computes;
-	 * the writer is attached only for the stat output formats.
+	 * Precomputed diff hunks (see diff-hunks.h). diffstat consults the
+	 * hunk provider interface before running xdiff, keyed by each file
+	 * pair's blob object IDs. When hunks_writer is set (a warming run),
+	 * diffstat also records the hunks it computes; the writer is
+	 * attached only for the stat output formats.
 	 */
 	struct diff_hunks_writer *hunks_writer;
 };
@@ -679,8 +688,9 @@ void diff_free(struct diff_options*);
 /*
  * Attach a diff-hunks writer to a diff producing a stat format, so a
  * warming run records the hunks it computes; a no-op when writing is off
- * or for other formats. Pair with diff_hunks_detach() once the diff is
- * done.
+ * or for other formats. (Reading is separate: consumers consult the
+ * providers through diff_provider_consult(); see diff-provider.h.) Pair
+ * with diff_hunks_detach() once the diff is done.
  */
 void diff_hunks_attach(struct diff_options *o);
 void diff_hunks_detach(struct diff_options *o);
diff --git a/t/t4220-diff-hunks.sh b/t/t4220-diff-hunks.sh
index c677831946..62329e1070 100755
--- a/t/t4220-diff-hunks.sh
+++ b/t/t4220-diff-hunks.sh
@@ -81,6 +81,79 @@ test_expect_success 'a second warming run refreshes the store in place' '
 	test_cmp expect actual
 '
 
+test_expect_success 'log --stat matches with and without the store' '
+	no_store log --stat >expect &&
+	warm &&
+	git log --stat >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log --numstat and --shortstat match' '
+	no_store log --numstat >expect_num &&
+	no_store log --shortstat >expect_short &&
+	warm &&
+	git log --numstat >actual_num &&
+	git log --shortstat >actual_short &&
+	test_cmp expect_num actual_num &&
+	test_cmp expect_short actual_short
+'
+
+# A built store must reproduce diffstat output at every context
+# length.  Only trim-stable pairs are recorded, so one entry serves
+# every context; a trim-divergent pair is never recorded and always
+# computed.  Zero context is where trim_common_tail runs, which is
+# what makes the two diffs differ.
+test_expect_success 'diffstat matches at several context lengths' '
+	no_store log --stat >expect_def &&
+	no_store log -U0 --stat >expect_u0 &&
+	no_store log -U7 --stat >expect_u7 &&
+	warm &&
+	git log --stat >got_def &&
+	git log -U0 --stat >got_u0 &&
+	git log -U7 --stat >got_u7 &&
+	test_cmp expect_def got_def &&
+	test_cmp expect_u0 got_u0 &&
+	test_cmp expect_u7 got_u7
+'
+
+test_expect_success 'store built at a nonzero context stays correct at that context' '
+	no_store -c diff.context=5 log --stat >expect &&
+	warm -c diff.context=5 &&
+	git -c diff.context=5 log --stat >actual &&
+	test_cmp expect actual
+'
+
+# This blob pair (a real git test file being modernized) has different
+# valid diffs at different contexts: at zero context, where
+# trim_common_tail runs, "diff -U0" reports 9/6, while "diff -U3"
+# reports 10/7. Such a trim-divergent pair is exactly what the writer
+# must never record, since no single entry could serve both readers.
+# A compact synthetic pair cannot show this count split: on small
+# inputs xdiff produces minimal diffs, minimal diffs of one pair all
+# add and delete the same number of lines, and trimming the common
+# tail preserves minimality, so the counts agree by construction (a
+# search over thousands of synthetic pairs up to 8 lines found no
+# split). The split needs the cost-capping heuristics that only larger
+# inputs trigger, so the pair is shipped as a fixture under t4220/.
+test_expect_success 'a trim-divergent file is correct at each context' '
+	cp "$TEST_DIRECTORY/t4220/trim-divergent-old" div.sh &&
+	git add div.sh &&
+	git commit -m divergent-old &&
+	cp "$TEST_DIRECTORY/t4220/trim-divergent-new" div.sh &&
+	git add div.sh &&
+	git commit -m divergent-new &&
+	no_store log -1 --format= --stat -- div.sh >expect_def &&
+	no_store log -1 --format= -U0 --stat -- div.sh >expect_u0 &&
+	warm &&
+	git log -1 --format= --stat -- div.sh >got_def &&
+	git log -1 --format= -U0 --stat -- div.sh >got_u0 &&
+	test_cmp expect_def got_def &&
+	test_cmp expect_u0 got_u0 &&
+	# The fixture must actually diverge, or the test would pass without
+	# exercising the split; fail loudly if a diff change ever levels it.
+	! test_cmp expect_def expect_u0
+'
+
 # A warming run displays the diffstat it computes. At zero context xdi_diff
 # trims, so the displayed counts must be the trimmed ones (what a store-less
 # run shows), not the untrimmed ones the writer compares against when it
@@ -99,6 +172,16 @@ test_expect_success 'warming --stat at zero context matches a store-less run' '
 	)
 '
 
+test_expect_success 'diff --stat matches with and without the store, both directions' '
+	no_store diff --stat second fourth >expect_fwd &&
+	no_store diff --stat fourth second >expect_rev &&
+	warm &&
+	git diff --stat second fourth >got_fwd &&
+	git diff --stat fourth second >got_rev &&
+	test_cmp expect_fwd got_fwd &&
+	test_cmp expect_rev got_rev
+'
+
 test_expect_success 'show and diff-tree --stat use the store' '
 	test_when_finished "git diff-hunks clear" &&
 	# diff_hunks_attach() runs for show and diff-tree: a write-enabled
@@ -121,6 +204,193 @@ test_expect_success 'show and diff-tree --stat use the store' '
 	test_cmp expect_dt got_dt
 '
 
+test_expect_success 'log -R --stat matches (reversed pairs keyed apart)' '
+	no_store log -R --stat >expect &&
+	warm &&
+	git log -R --stat >actual &&
+	test_cmp expect actual
+'
+
+# The diffstat read path produces identical output on a hit or a miss, so
+# it emits a trace2 "read-hits" count to prove it consulted the store.
+test_expect_success 'diffstat consults the store (trace shows read hits)' '
+	warm &&
+	GIT_TRACE2_EVENT="$PWD/trace_on.json" git log --stat >/dev/null &&
+	test_grep read-hits trace_on.json &&
+	test_env GIT_TRACE2_EVENT="$PWD/trace_off.json" no_store log --stat >/dev/null &&
+	test_grep ! read-hits trace_off.json
+'
+
+# Diff settings that change hunks but are not part of the store key must
+# bypass it in both directions, so output stays byte-identical to a
+# store-less run.
+test_expect_success 'setup ignore fixture' '
+	git init ignore-repo &&
+	(
+		cd ignore-repo &&
+		test_write_lines code keep "# c" >f &&
+		git add f &&
+		git commit -m c1 &&
+		test_write_lines codeCH keep "# cX" >f &&
+		git add f &&
+		git commit -m c2 &&
+		warm
+	)
+'
+
+# Output parity alone cannot prove the guard: served counts can
+# coincide with computed ones, so each bypass below also asserts the
+# consultation itself (no read hit with the option, a hit without it)
+# and that a warming run under the option records nothing.
+test_expect_success '-I bypasses the store in both directions' '
+	(
+		cd ignore-repo &&
+		no_store diff -I"^#" --numstat HEAD~ HEAD >expect &&
+		git diff -I"^#" --numstat HEAD~ HEAD >actual &&
+		test_cmp expect actual &&
+		# -I does not change the key, so only the ignore_regex
+		# guard keeps the warmed entry from serving here.
+		GIT_TRACE2_EVENT="$PWD/trace_i.json" \
+			git diff -I"^#" --numstat HEAD~ HEAD >/dev/null &&
+		test_grep ! read-hits trace_i.json &&
+		GIT_TRACE2_EVENT="$PWD/trace_i_ctl.json" \
+			git diff --numstat HEAD~ HEAD >/dev/null &&
+		test_grep read-hits trace_i_ctl.json &&
+		git diff-hunks clear &&
+		GIT_DIFF_HUNKS_WRITE=1 git diff -I"^#" --numstat HEAD~ HEAD >/dev/null &&
+		test_path_is_missing .git/objects/info/diff-hunks &&
+		# Restore the warmed fixture for the tests below.
+		warm
+	)
+'
+
+test_expect_success '-B bypasses the store in both directions' '
+	git init break-repo &&
+	(
+		cd break-repo &&
+		test_write_lines a b c d e f g h >f &&
+		git add f &&
+		git commit -m orig &&
+		test_write_lines 1 2 3 4 5 6 7 8 >f &&
+		git add f &&
+		git commit -m rewrite &&
+		warm &&
+		no_store diff -B --stat HEAD~ HEAD >expect &&
+		git diff -B --stat HEAD~ HEAD >actual &&
+		test_cmp expect actual &&
+		GIT_TRACE2_EVENT="$PWD/trace_b.json" \
+			git diff -B --stat HEAD~ HEAD >/dev/null &&
+		test_grep ! read-hits trace_b.json &&
+		GIT_TRACE2_EVENT="$PWD/trace_ctl.json" \
+			git diff --stat HEAD~ HEAD >/dev/null &&
+		test_grep read-hits trace_ctl.json &&
+		git diff-hunks clear &&
+		GIT_DIFF_HUNKS_WRITE=1 git diff -B --stat HEAD~ HEAD >/dev/null &&
+		test_path_is_missing .git/objects/info/diff-hunks
+	)
+'
+
+test_expect_success '--anchored bypasses the store in both directions' '
+	(
+		cd ignore-repo &&
+		no_store diff --stat --anchored=keep HEAD~ HEAD >expect &&
+		git diff --stat --anchored=keep HEAD~ HEAD >actual &&
+		test_cmp expect actual &&
+		# Anchors do not change the key, so only the anchors guard
+		# keeps the warmed entry from serving here.
+		GIT_TRACE2_EVENT="$PWD/trace_anchor.json" \
+			git diff --stat --anchored=keep HEAD~ HEAD >/dev/null &&
+		test_grep ! read-hits trace_anchor.json &&
+		GIT_TRACE2_EVENT="$PWD/trace_plain.json" \
+			git diff --stat HEAD~ HEAD >/dev/null &&
+		test_grep read-hits trace_plain.json &&
+		git diff-hunks clear &&
+		GIT_DIFF_HUNKS_WRITE=1 \
+			git diff --stat --anchored=keep HEAD~ HEAD >/dev/null &&
+		test_path_is_missing .git/objects/info/diff-hunks
+	)
+'
+
+test_expect_success '--ignore-blank-lines bypasses the store in both directions' '
+	git init ibl-repo &&
+	(
+		cd ibl-repo &&
+		printf "a\n\nx\ny\nb\n" >f &&
+		git add f &&
+		git commit -m v1 &&
+		printf "a\nx\ny\nB\n" >f &&
+		git add f &&
+		git commit -m v2 &&
+		warm &&
+		no_store diff --stat --ignore-blank-lines HEAD~ HEAD >expect &&
+		git diff --stat --ignore-blank-lines HEAD~ HEAD >actual &&
+		test_cmp expect actual &&
+		# The flag is an xdl_opts bit and thus part of the key; the
+		# stat consumer excludes it before consulting at all.
+		GIT_TRACE2_EVENT="$PWD/trace_ibl.json" \
+			git diff --stat --ignore-blank-lines HEAD~ HEAD >/dev/null &&
+		test_grep ! read-hits trace_ibl.json &&
+		GIT_TRACE2_EVENT="$PWD/trace_plain.json" \
+			git diff --stat HEAD~ HEAD >/dev/null &&
+		test_grep read-hits trace_plain.json &&
+		git diff-hunks clear &&
+		GIT_DIFF_HUNKS_WRITE=1 \
+			git diff --stat --ignore-blank-lines HEAD~ HEAD >/dev/null &&
+		test_path_is_missing .git/objects/info/diff-hunks
+	)
+'
+
+test_expect_success 'a whitespace-ignoring diff is not served default entries' '
+	git init ws-repo &&
+	(
+		cd ws-repo &&
+		test_write_lines alpha beta gamma >f &&
+		git add f &&
+		git commit -m c1 &&
+		test_write_lines "  alpha" beta gamma delta >f &&
+		git add f &&
+		git commit -m c2 &&
+		warm &&
+		no_store diff -w --numstat HEAD~ HEAD >expect &&
+		git diff -w --numstat HEAD~ HEAD >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'a driver algorithm override keeps output correct and keys apart' '
+	git init driver-algo &&
+	(
+		cd driver-algo &&
+		echo "file.foo diff=foo" >.gitattributes &&
+		git add .gitattributes &&
+		git commit -m attributes &&
+		test_write_lines 1 2 3 4 5 >file.foo &&
+		git add file.foo &&
+		git commit -m one &&
+		test_write_lines 1 2 X 4 5 6 >file.foo &&
+		git add file.foo &&
+		git commit -m two &&
+		warm -c diff.foo.algorithm=histogram &&
+		no_store -c diff.foo.algorithm=histogram log --stat >expect &&
+		git -c diff.foo.algorithm=histogram log --stat >actual &&
+		test_cmp expect actual &&
+		# The driver algorithm is an xdl_opts key bit: entries
+		# warmed at the default settings must not serve a
+		# driver-forced histogram read, and output stays correct.
+		git diff-hunks clear &&
+		warm &&
+		no_store -c diff.foo.algorithm=histogram log --stat >expect2 &&
+		git -c diff.foo.algorithm=histogram log --stat >actual2 &&
+		test_cmp expect2 actual2 &&
+		GIT_TRACE2_EVENT="$PWD/trace_algo.json" \
+			git -c diff.foo.algorithm=histogram log --stat >/dev/null &&
+		test_grep ! read-hits trace_algo.json &&
+		GIT_TRACE2_EVENT="$PWD/trace_algo_ctl.json" \
+			git log --stat >/dev/null &&
+		test_grep read-hits trace_algo_ctl.json
+	)
+'
+
 # Cover the pair shapes an object walk encounters: binary and
 # mode-only changes produce no text hunks to record.
 test_expect_success 'binary and mode-only changes do not break the writer' '
@@ -141,6 +411,16 @@ test_expect_success 'binary and mode-only changes do not break the writer' '
 	test_cmp expect actual
 '
 
+test_expect_success 'log -L --stat neither reads nor records' '
+	warm &&
+	GIT_TRACE2_EVENT="$PWD/trace_linelog.json" \
+		git log -L1,1:file.txt --stat >/dev/null &&
+	test_grep ! read-hits trace_linelog.json &&
+	git diff-hunks clear &&
+	GIT_DIFF_HUNKS_WRITE=1 git log -L1,1:file.txt --stat >/dev/null &&
+	test_path_is_missing $STORE
+'
+
 test_expect_success 'verify succeeds on a valid store and on an absent one' '
 	warm &&
 	git diff-hunks verify &&
-- 
2.54.0


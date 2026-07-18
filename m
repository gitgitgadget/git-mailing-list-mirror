Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A61C175A84
	for <git@vger.kernel.org>; Sat, 18 Jul 2026 21:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784409758; cv=none; b=WEoPA3ZKWBbJ3iieVRBINBg91gjmWA25ZaomhMYKHd3y/WMYw7U2Pss8hEbMu7GmP8VhksvT5kP6s/S5dLYoLC1KI6lJh49UYZ/vpmJF6DLiednEa8rA+/dMw4rPeLyIQGBLa68YYSUH7oazkOux/MvJ+h2hfOeo1ONaSfMC/aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784409758; c=relaxed/simple;
	bh=hDIVhwwmA2PkinCHn5wv/J2RCvsfVYiaAN9Gi+hK9EQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pX1uIaoMzHxZzAsqEvB5OoOB/Ccgc1cNdBpgU2W1L/hSp5bcrYjrg9f8W8YcAYpJlhUQelhtbNSKhsuiBLVwMGp32lszmhZnTEPMhOW9EM32NCE9zvgsXK6EJPg17cTUKNF3tNJedQRfvJucEWvgw59/vn8fMhKQD6jxFWs7Q4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=EZu6756E; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="EZu6756E"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7dbcb505578so54935807b3.3
        for <git@vger.kernel.org>; Sat, 18 Jul 2026 14:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1784409755; x=1785014555; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lV36R2+j20W8M1eYrxIxb/8IWK+44PgjC6z4nq0YIQA=;
        b=EZu6756EWrrUaH3X77jGctKkeUnbwOtlbpHJCxsrxq9ldViQsLL+BIKChLLzk4ILwI
         7a4Bsl0nJn9gwyZqEieH9OT9Yh9HxuCM8e8wMAc+AnqTPs4O5CTGeNEq4McCH+5AAUtx
         GHfJTAmIy0syFOZVnPOCPzQk8NM82xAHI25Q4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784409755; x=1785014555;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lV36R2+j20W8M1eYrxIxb/8IWK+44PgjC6z4nq0YIQA=;
        b=Z4nJDO37kQuVYshq1+VfJ+BD+sD8qjZlBJXRJBgG2FYYSsZkvH9uOpt0xf/IwYl5oa
         FGgQgDuGSy6d2RDuMWzv964SFZa5apA2P2/GKzX+00Bxw9mQ8IVv7ERGgqHdTSdIoY9p
         QWP/yPZm3m1wLFeNqfnEM96y2cyxwGGttt6RK8ZPVR+kysrWjW/ZPdYzle7iJtpyptvC
         UsZyn+wqaJIxb0T1o3S7JAKbxn/t5SFD/THOs9WvYrwxzZTOp2/93gFoVEkENBwgFcPG
         HHFXqFSYLjHmlDhptWAB85a6cq19H1b0DULZzYkgns2G30rsPM+lPXJVpKVs0dvG90SZ
         v0Tg==
X-Forwarded-Encrypted: i=1; AHgh+RpGhZqmRTMP7X0ekLCv43YFXoIa9tqUCQ1c88TKbZETQSCOWeR+ZMU3Fbyl7KjvOV8gIkA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2fy+TWUivFm/Am3KYV6SvRIJ93bt/h5US2sA+ch0mDjLvE1Y0
	XkkakDHyHW1dhEEneFK4F5wBuE2BI+QZSgMK7PH+zvDosD1nGJGtNySxtrUhhTLGJM6Ptq3BrzB
	7TPgOz3IIWg==
X-Gm-Gg: AfdE7cngJe2vVYvZ2p1HW2PsOIj4NUVyUbFxoSf62d2g11yxR2SHrLjDKBaLIc+s45S
	Ma+VTDqCH/npHNAmz5Jd8/3nXLUIQZa2hUqw7RnVtLI86RZnBuP2e3LrVmch2xWSK9Rk9FTrZj5
	gcA6XdcpmG/VAh5vz4N+XtsfZQErdkhAc4nBcr5dDFziONokWYae2yodfTLem7Kby8HUJbAP6su
	YcjeMG/vyo+5u3cIPPG5U+67rs3SiqNEdENIh9CweUT88qJFn/Uy5Y4w0b1miIMCmTPdxb+pJMT
	DwHM586RQmJV8Zs/ebmERSA+vuy9/jm/SDgxi4UFEVXu3XPCDh9EStcmZodCiziyXMIxnbGnwgo
	3Zt+st/zTrYdUFAmWKDl0T4DhqOd7YBWMcoR+WNovbgwxi+2xipAWvPEmS6cmWQKyeb4d2u3U0h
	gEvAER+az/gM28t+LUaHkeXOyGLZq5cQFzfr3CbXgl2fx1YYJgayCIAM5Fr7mBoEDSoo6OPw==
X-Received: by 2002:a05:690c:6b06:b0:812:8343:e214 with SMTP id 00721157ae682-81ef260cce4mr28751057b3.57.1784409755345;
        Sat, 18 Jul 2026 14:22:35 -0700 (PDT)
Received: from com-79390 (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81efe45416fsm21078507b3.6.2026.07.18.14.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 14:22:34 -0700 (PDT)
Date: Sat, 18 Jul 2026 16:22:31 -0500
From: Taylor Blau <ttaylorr@openai.com>
To: Jeff King <peff@peff.net>
Cc: Toon Claes <toon@iotcl.com>, git@vger.kernel.org,
	Gusted <gusted@codeberg.org>
Subject: Re: [PATCH 3/4] last-modified: check pathspec against Bloom filter
 first
Message-ID: <alvulw2fk67duo8n@com-79390>
References: <20260717-toon-speed-up-last-modified-v1-0-410418f18614@iotcl.com>
 <20260717-toon-speed-up-last-modified-v1-3-410418f18614@iotcl.com>
 <alq1Q55ezuN9ZI9j@com-79390>
 <20260718083757.GD22588@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260718083757.GD22588@coredump.intra.peff.net>

On Sat, Jul 18, 2026 at 04:37:57AM -0400, Jeff King wrote:
> > I don't think this is safe with '--show-trees'. The original pathspec
> > does not cover every entry in 'lm->paths', since the function
> > 'populate_paths_from_revs()' also adds ancestor tree entries.
>
> Hmm, interesting. I am surprised to learn that "-t" includes "d" when
> the pathspec asked for "d/a". I thought it was mostly about showing
> "d/a" when we recurse to find "d/a/b". But I guess it does not make a
> distinction between the two (probably because it is just telling the
> diff code to show trees, and it does not further apply the pathspec to
> the output).
>
> Does this mean there is also a bug in "git log"? I guess not, because it
> is purely pruning based on the pathspec, and only shows "d/" for those
> commits.

Right.

> > I think that the conditional is otherwise correct, if guarded when we
> > know that 'lm->show_trees' is false, like so:
> >
> >     if (!lm->show_trees &&
> >         !revs_maybe_changed_in_bloom(&lm->rev, filter))
> >             return false;
>
> Hmph. That makes this optimization all but useless, because the intended
> use case of last-modified is almost always going to use "-t" to be able
> to mark the interior trees. And most callers are not going to care about
> seeing "d" here; their purpose was to find out about the things _inside_
> "d".
>
> Would we consider removing "d" from the output for this case? Presumably
> by double-checking the pathspecs again in add_path_from_diff(). That
> gives less surprising output (to me, anyway) and would enable this
> optimization. And the command is still marked as experimental, and I
> think this is exactly the kind of corner case that is meant to cover.

I think that we could feasibly get rid of "d" in the output in this
particular case within last-modified. As you note, the command is marked
EXPERIMENTAL for a reason, after all ;-).

If we wanted to do that, it should be straightforward to do. I think the
following (untested) patch would be sufficient:

--- 8< ---
diff --git a/builtin/last-modified.c b/builtin/last-modified.c
index adc7cd8c74..0f0c1d1d17 100644
--- a/builtin/last-modified.c
+++ b/builtin/last-modified.c
@@ -103,7 +103,7 @@ struct last_modified_callback_data {
 };

 static void add_path_from_diff(struct diff_queue_struct *q,
-			       struct diff_options *opt UNUSED, void *data)
+			       struct diff_options *opt, void *data)
 {
 	struct last_modified *lm = data;

@@ -112,6 +112,11 @@ static void add_path_from_diff(struct diff_queue_struct *q,
 		struct last_modified_entry *ent;
 		const char *path = p->two->path;

+		if (!match_pathspec(opt->repo->index, &opt->pathspec, path,
+				    strlen(path), 0, NULL,
+				    S_ISDIR(p->two->mode)))
+			continue;
+
 		FLEX_ALLOC_STR(ent, path, path);
 		oidcpy(&ent->oid, &p->two->oid);
 		if (lm->rev.bloom_filter_settings)
--- >8 ---

If, on the other hand, we wanted to retain "d" in the output (which I am
inclined to suggest is a bad idea), we could keep a list of paths which
are not covered by the given pathspec.

If you had such a list, you could check only active entries within that
list, removing them as they are resolved. That makes a Bloom query miss
O(U*H) (where U is the uncovered subset of all paths, and H is the
number of hash functions in our Bloom key, which in our case is 7) as
opposed to O(P*H), where P is the number of active paths.

Of course, as U approaches P, the advantage disappears and so too do
the benefits of Toon's optimization.

If you wanted to go that route, you could do something like the
following (lightly tested):

--- 8< ---
diff --git a/builtin/last-modified.c b/builtin/last-modified.c
index adc7cd8c74..e69c7a44b6 100644
--- a/builtin/last-modified.c
+++ b/builtin/last-modified.c
@@ -11,6 +11,7 @@
 #include "ewah/ewok.h"
 #include "hashmap.h"
 #include "hex.h"
+#include "list.h"
 #include "object-name.h"
 #include "object.h"
 #include "parse-options.h"
@@ -25,9 +26,11 @@

 struct last_modified_entry {
 	struct hashmap_entry hashent;
+	struct list_head uncovered;
 	struct object_id oid;
 	struct bloom_key key;
 	size_t diff_idx;
+	bool covered_by_pathspec;
 	const char path[FLEX_ARRAY];
 };

@@ -52,6 +55,7 @@ define_commit_slab(active_paths_for_commit, struct bitmap *);

 struct last_modified {
 	struct hashmap paths;
+	struct list_head uncovered_paths;
 	struct rev_info rev;
 	bool show_trees;
 	bool nul_termination;
@@ -103,7 +107,7 @@ struct last_modified_callback_data {
 };

 static void add_path_from_diff(struct diff_queue_struct *q,
-			       struct diff_options *opt UNUSED, void *data)
+			       struct diff_options *opt, void *data)
 {
 	struct last_modified *lm = data;

@@ -114,6 +118,16 @@ static void add_path_from_diff(struct diff_queue_struct *q,

 		FLEX_ALLOC_STR(ent, path, path);
 		oidcpy(&ent->oid, &p->two->oid);
+
+		if (match_pathspec(opt->repo->index, &opt->pathspec, path,
+				   strlen(path), 0, NULL,
+				   S_ISDIR(p->two->mode))) {
+			ent->covered_by_pathspec = true;
+		} else {
+			list_add_tail(&ent->uncovered, &lm->uncovered_paths);
+			ent->covered_by_pathspec = false;
+		}
+
 		if (lm->rev.bloom_filter_settings)
 			bloom_key_fill(&ent->key, path, strlen(path),
 				       lm->rev.bloom_filter_settings);
@@ -202,6 +216,8 @@ static void mark_path(const char *path, const struct object_id *oid,
 	last_modified_emit(data->lm, path, data->commit);

 	hashmap_remove(&data->lm->paths, &ent->hashent, path);
+	if (!ent->covered_by_pathspec)
+		list_del(&ent->uncovered);
 	bloom_key_clear(&ent->key);
 	free(ent);
 }
@@ -272,8 +288,22 @@ static bool maybe_changed_path(struct last_modified *lm,
 	if (!filter)
 		return true;

-	if (revs_maybe_changed_in_bloom(&lm->rev, filter) == 0)
+	if (revs_maybe_changed_in_bloom(&lm->rev, filter) == 0) {
+		struct list_head *pos;
+
+		list_for_each(pos, &lm->uncovered_paths) {
+			ent = list_entry(pos, struct last_modified_entry,
+					 uncovered);
+			if (active && !bitmap_get(active, ent->diff_idx))
+				continue;
+
+			if (bloom_filter_contains(filter, &ent->key,
+						  lm->rev.bloom_filter_settings))
+				return true;
+		}
+
 		return false;
+	}

 	hashmap_for_each_entry(&lm->paths, &iter, ent, hashent) {
 		if (active && !bitmap_get(active, ent->diff_idx))
@@ -490,6 +520,7 @@ static int last_modified_init(struct last_modified *lm, struct repository *r,
 	struct last_modified_entry *ent;

 	hashmap_init(&lm->paths, last_modified_entry_hashcmp, NULL, 0);
+	INIT_LIST_HEAD(&lm->uncovered_paths);

 	repo_init_revisions(r, &lm->rev, prefix);
 	lm->rev.def = "HEAD";
--- >8 ---

On my machine, in a synthetic repository containing 10,000 commits with
5,001 covered paths and 1 uncovered path, Toon's original patch runs in
~450ms. With the above patch, the timing drops to ~227ms, whereas it
drops further to ~190ms when omitting the uncovered path entirely.

So I'm inclined to suggest that we take advantage of the command's
EXPERIMENTAL nature and avoid printing the uncovered path entirely.

Thanks,
Taylor

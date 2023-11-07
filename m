Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F358D4C7A
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 01:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jiurXTNv"
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE239D47
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 17:26:11 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40906fc54fdso39319435e9.0
        for <git@vger.kernel.org>; Mon, 06 Nov 2023 17:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699320369; x=1699925169; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ratqz1SSNN5lbWRil3GBv2GmJ+ZMuqZyafFdANCs1B0=;
        b=jiurXTNv8/mriFFF+gnoUEasd+QbmcnqkE+gGfaJL0L0suWHMPxGMZwO1g1D5ev6Tu
         t0hPjy2404kAboYeOWNGSJuyAXzV3jx6cUGm22YAjn9tiRsMfixKGvvbaSa5NQS738UJ
         Ajk7FyLVqoi+GtAtAUSr/iJToQ3hyC4BGkPS/kU4TLvVl4WTVj8RPyOgVA3V7TYCo8Ty
         g+e0I8qMXIw7MT7G5fB+adoPwhkLIhFwVHiJWo+Cb32XwKqfZoj2FCz6VoEI+cjh1yhC
         dO3if5SuCtx16J4QvmH55OkTeRp35zOoxw4hYcrJ7SW7Xud1e8GUPxnpafoH5A4XK4Fr
         cgrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699320369; x=1699925169;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ratqz1SSNN5lbWRil3GBv2GmJ+ZMuqZyafFdANCs1B0=;
        b=G9pe5oFH7IXdqBHL+ImRcAObLPl4X6/BZ/cnCZa2qdn9vEqNt9cbNImddR1lVH92dz
         hp+Zgaa9WCA3LZtTGLNZw9dUuy34bFLOOpchRdVgDyADMVC7N+b//yCQ5ZrCiaoS0np/
         TPhqcLBNpeIZ1yfCtD4qiwmS5g8CFmlBkpFyJJ5iGE05rc7215YnNKabotItc6aaOopa
         GQQvYBHUtVThQyLyBNfOKo6q4gZJdKfOnPMZli9ljuRF/YkKR9DSgkSH7jh6AzeQtPs8
         xyYA7/Pz6J5Hf05XouXuEfy2sOEgNwXjV7S3XTrXj7FcbJjO0TrGXk6GjlAS82z/RWVc
         OWpA==
X-Gm-Message-State: AOJu0YycJKZ1+h5LPRG8DPET4w4ta0dc7NviG/1BBbH7mex6JYqtey9K
	JiPCROSgf9wLP8s3mScD8M2I2eViIww=
X-Google-Smtp-Source: AGHT+IGMvPzvSlwnrznD80/USyRr086PSxdjEP6XX8FQQdT7uyX9iCNb3wUCIx1WK5X9+Y+/BkEmyg==
X-Received: by 2002:a05:600c:190f:b0:408:4d0e:68b2 with SMTP id j15-20020a05600c190f00b004084d0e68b2mr1014402wmq.36.1699320369468;
        Mon, 06 Nov 2023 17:26:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h22-20020a05600c351600b004094c5d929asm13784352wmq.10.2023.11.06.17.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 17:26:09 -0800 (PST)
Message-ID: <8c77452e5dd8d5cafd95c68480bf5675d51b4736.1699320362.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1609.git.1699320361.gitgitgadget@gmail.com>
References: <pull.1609.git.1699320361.gitgitgadget@gmail.com>
From: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 07 Nov 2023 01:25:58 +0000
Subject: [PATCH 6/9] ref-filter.c: refactor to create common helper functions
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Victoria Dye <vdye@github.com>,
    Victoria Dye <vdye@github.com>

From: Victoria Dye <vdye@github.com>

Factor out parts of 'ref_array_push()', 'ref_filter_handler()', and
'filter_refs()' into new helper functions ('ref_array_append()',
'apply_ref_filter()', and 'do_filter_refs()' respectively), as well as
rename 'ref_filter_handler()' to 'filter_one()'. In this and later
patches, these helpers will be used by new ref-filter API functions. This
patch does not result in any user-facing behavior changes or changes to
callers outside of 'ref-filter.c'.

The changes are as follows:

* The logic to grow a 'struct ref_array' and append a given 'struct
  ref_array_item *' to it is extracted from 'ref_array_push()' into
  'ref_array_append()'.
* 'ref_filter_handler()' is renamed to 'filter_one()' to more clearly
  distinguish it from other ref filtering callbacks that will be added in
  later patches. The "*_one()" naming convention is common throughout the
  codebase for iteration callbacks.
* The code to filter a given ref by refname & object ID then create a new
  'struct ref_array_item' is moved out of 'filter_one()' and into
  'apply_ref_filter()'. 'apply_ref_filter()' returns either NULL (if the ref
  does not match the given filter) or a 'struct ref_array_item *' created
  with 'new_ref_array_item()'; 'filter_one()' appends that item to
  its ref array with 'ref_array_append()'.
* The filter pre-processing, contains cache creation, and ref iteration of
  'filter_refs()' is extracted into 'do_filter_refs()'. 'do_filter_refs()'
  takes its ref iterator function & callback data as an input from the
  caller, setting it up to be used with additional filtering callbacks in
  later patches.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 ref-filter.c | 115 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 69 insertions(+), 46 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 8992fbf45b1..ff00ab4b8d8 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2716,15 +2716,18 @@ static struct ref_array_item *new_ref_array_item(const char *refname,
 	return ref;
 }
 
+static void ref_array_append(struct ref_array *array, struct ref_array_item *ref)
+{
+	ALLOC_GROW(array->items, array->nr + 1, array->alloc);
+	array->items[array->nr++] = ref;
+}
+
 struct ref_array_item *ref_array_push(struct ref_array *array,
 				      const char *refname,
 				      const struct object_id *oid)
 {
 	struct ref_array_item *ref = new_ref_array_item(refname, oid);
-
-	ALLOC_GROW(array->items, array->nr + 1, array->alloc);
-	array->items[array->nr++] = ref;
-
+	ref_array_append(array, ref);
 	return ref;
 }
 
@@ -2761,46 +2764,36 @@ static int filter_ref_kind(struct ref_filter *filter, const char *refname)
 	return ref_kind_from_refname(refname);
 }
 
-struct ref_filter_cbdata {
-	struct ref_array *array;
-	struct ref_filter *filter;
-};
-
-/*
- * A call-back given to for_each_ref().  Filter refs and keep them for
- * later object processing.
- */
-static int ref_filter_handler(const char *refname, const struct object_id *oid, int flag, void *cb_data)
+static struct ref_array_item *apply_ref_filter(const char *refname, const struct object_id *oid,
+			    int flag, struct ref_filter *filter)
 {
-	struct ref_filter_cbdata *ref_cbdata = cb_data;
-	struct ref_filter *filter = ref_cbdata->filter;
 	struct ref_array_item *ref;
 	struct commit *commit = NULL;
 	unsigned int kind;
 
 	if (flag & REF_BAD_NAME) {
 		warning(_("ignoring ref with broken name %s"), refname);
-		return 0;
+		return NULL;
 	}
 
 	if (flag & REF_ISBROKEN) {
 		warning(_("ignoring broken ref %s"), refname);
-		return 0;
+		return NULL;
 	}
 
 	/* Obtain the current ref kind from filter_ref_kind() and ignore unwanted refs. */
 	kind = filter_ref_kind(filter, refname);
 	if (!(kind & filter->kind))
-		return 0;
+		return NULL;
 
 	if (!filter_pattern_match(filter, refname))
-		return 0;
+		return NULL;
 
 	if (filter_exclude_match(filter, refname))
-		return 0;
+		return NULL;
 
 	if (filter->points_at.nr && !match_points_at(&filter->points_at, oid, refname))
-		return 0;
+		return NULL;
 
 	/*
 	 * A merge filter is applied on refs pointing to commits. Hence
@@ -2811,15 +2804,15 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
 	    filter->with_commit || filter->no_commit || filter->verbose) {
 		commit = lookup_commit_reference_gently(the_repository, oid, 1);
 		if (!commit)
-			return 0;
+			return NULL;
 		/* We perform the filtering for the '--contains' option... */
 		if (filter->with_commit &&
 		    !commit_contains(filter, commit, filter->with_commit, &filter->internal.contains_cache))
-			return 0;
+			return NULL;
 		/* ...or for the `--no-contains' option */
 		if (filter->no_commit &&
 		    commit_contains(filter, commit, filter->no_commit, &filter->internal.no_contains_cache))
-			return 0;
+			return NULL;
 	}
 
 	/*
@@ -2827,11 +2820,32 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
 	 * to do its job and the resulting list may yet to be pruned
 	 * by maxcount logic.
 	 */
-	ref = ref_array_push(ref_cbdata->array, refname, oid);
+	ref = new_ref_array_item(refname, oid);
 	ref->commit = commit;
 	ref->flag = flag;
 	ref->kind = kind;
 
+	return ref;
+}
+
+struct ref_filter_cbdata {
+	struct ref_array *array;
+	struct ref_filter *filter;
+};
+
+/*
+ * A call-back given to for_each_ref().  Filter refs and keep them for
+ * later object processing.
+ */
+static int filter_one(const char *refname, const struct object_id *oid, int flag, void *cb_data)
+{
+	struct ref_filter_cbdata *ref_cbdata = cb_data;
+	struct ref_array_item *ref;
+
+	ref = apply_ref_filter(refname, oid, flag, ref_cbdata->filter);
+	if (ref)
+		ref_array_append(ref_cbdata->array, ref);
+
 	return 0;
 }
 
@@ -2967,26 +2981,12 @@ void filter_ahead_behind(struct repository *r,
 	free(commits);
 }
 
-/*
- * API for filtering a set of refs. Based on the type of refs the user
- * has requested, we iterate through those refs and apply filters
- * as per the given ref_filter structure and finally store the
- * filtered refs in the ref_array structure.
- */
-int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int type)
+static int do_filter_refs(struct ref_filter *filter, unsigned int type, each_ref_fn fn, void *cb_data)
 {
-	struct ref_filter_cbdata ref_cbdata;
-	int save_commit_buffer_orig;
 	int ret = 0;
 
-	ref_cbdata.array = array;
-	ref_cbdata.filter = filter;
-
 	filter->kind = type & FILTER_REFS_KIND_MASK;
 
-	save_commit_buffer_orig = save_commit_buffer;
-	save_commit_buffer = 0;
-
 	init_contains_cache(&filter->internal.contains_cache);
 	init_contains_cache(&filter->internal.no_contains_cache);
 
@@ -3001,20 +3001,43 @@ int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
 		 * of filter_ref_kind().
 		 */
 		if (filter->kind == FILTER_REFS_BRANCHES)
-			ret = for_each_fullref_in("refs/heads/", ref_filter_handler, &ref_cbdata);
+			ret = for_each_fullref_in("refs/heads/", fn, cb_data);
 		else if (filter->kind == FILTER_REFS_REMOTES)
-			ret = for_each_fullref_in("refs/remotes/", ref_filter_handler, &ref_cbdata);
+			ret = for_each_fullref_in("refs/remotes/", fn, cb_data);
 		else if (filter->kind == FILTER_REFS_TAGS)
-			ret = for_each_fullref_in("refs/tags/", ref_filter_handler, &ref_cbdata);
+			ret = for_each_fullref_in("refs/tags/", fn, cb_data);
 		else if (filter->kind & FILTER_REFS_ALL)
-			ret = for_each_fullref_in_pattern(filter, ref_filter_handler, &ref_cbdata);
+			ret = for_each_fullref_in_pattern(filter, fn, cb_data);
 		if (!ret && (filter->kind & FILTER_REFS_DETACHED_HEAD))
-			head_ref(ref_filter_handler, &ref_cbdata);
+			head_ref(fn, cb_data);
 	}
 
 	clear_contains_cache(&filter->internal.contains_cache);
 	clear_contains_cache(&filter->internal.no_contains_cache);
 
+	return ret;
+}
+
+/*
+ * API for filtering a set of refs. Based on the type of refs the user
+ * has requested, we iterate through those refs and apply filters
+ * as per the given ref_filter structure and finally store the
+ * filtered refs in the ref_array structure.
+ */
+int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int type)
+{
+	struct ref_filter_cbdata ref_cbdata;
+	int save_commit_buffer_orig;
+	int ret = 0;
+
+	ref_cbdata.array = array;
+	ref_cbdata.filter = filter;
+
+	save_commit_buffer_orig = save_commit_buffer;
+	save_commit_buffer = 0;
+
+	ret = do_filter_refs(filter, type, filter_one, &ref_cbdata);
+
 	/*  Filters that need revision walking */
 	reach_filter(array, &filter->reachable_from, INCLUDE_REACHED);
 	reach_filter(array, &filter->unreachable_from, EXCLUDE_REACHED);
-- 
gitgitgadget


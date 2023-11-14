Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA892FC3F
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 19:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1T+OmwH"
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFFCEB
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 11:54:14 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-66d24ccc6f2so1291006d6.0
        for <git@vger.kernel.org>; Tue, 14 Nov 2023 11:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699991652; x=1700596452; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ch72ojuVCuaq6f8agFpDhGz2k0gHl0iioyjojQYsJR8=;
        b=B1T+OmwHFnmlkNTs7hVzioR26fqFv/ugF0HgQu7Gg+VvbCw54TO3/OgInfU4Qw6k2H
         02YM5qMFJ9Xwsk4cDOdkdeEHCWFI/WCEo9Dgv2qx2JPyj+RqNwHBhuexMZ2TBlFVXBay
         JEvpqTlIKLwG6nYX4p0cjKhmctCwoahAZ24+qDDvZ/wBeO06IxcahozIYs/Ogylu7vKN
         z6oCtRzlC4qpJWwKlNuEVHfBPm64FnfGXshlUaZK6i8XjGG1y2VHoVj5ydwGAuKUPWWA
         sj4xhiZeZ0i1Qmxv0qWGCcp9PhCQ0qXtqcPAFyGIKPwjw05R7mLE3r9Tq1zbPSHBu4Jm
         AN+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699991652; x=1700596452;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ch72ojuVCuaq6f8agFpDhGz2k0gHl0iioyjojQYsJR8=;
        b=ewku7HmTHIzEWwORcqlgYxxOqopvThwYeK2jVlc72KM3DNfDoLhmJvqjLzAP8nNaZ6
         tk3iCraEqhL8t1gIQu0VyVDmVI91GYi/YmaDNUWlbtTh0RfcpHgjabnyQPr7NAWQngQM
         XpQoymPWboHQZALfJyV/4imOLotrnSo0veutni7KeSR2ibOvgGLMNL42JSDG+aazUJbj
         34B6n82asbU25fnICfCaKnziH7uNNZ+Bgxg0EFR43Jlx+PaLYoSc17cLLJSSJ9Hkn2NV
         SnWYswBoRjWabYfH94107j6LtLgk5EvSwBVe0ZTvQGnx6+kEtZ2gcer8IQeThj/mbTif
         lM4Q==
X-Gm-Message-State: AOJu0YwlfGeuR7Asr9Lm/sYQuuTPZKuvbVyrXSBH6zitmPZATdLa/mN1
	eoWnvT27KBKB2V4172dAw1kD/8VKUcY=
X-Google-Smtp-Source: AGHT+IFSUBG6hQCTuURCXQ9aa6DpilvHtgSFrdG7UlhSAM7sXqhTMuMfhZg3yXpMkqJjG1bp6XsCqQ==
X-Received: by 2002:a05:6214:d06:b0:66d:8752:b6cf with SMTP id 6-20020a0562140d0600b0066d8752b6cfmr5860156qvh.26.1699991652486;
        Tue, 14 Nov 2023 11:54:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c17-20020a0cd611000000b0064f4e0b2089sm3151014qvj.33.2023.11.14.11.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 11:54:12 -0800 (PST)
Message-ID: <633c0c74c2efb42e1491d53809a9825599690301.1699991638.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1609.v2.git.1699991638.gitgitgadget@gmail.com>
References: <pull.1609.git.1699320361.gitgitgadget@gmail.com>
	<pull.1609.v2.git.1699991638.gitgitgadget@gmail.com>
From: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 14 Nov 2023 19:53:54 +0000
Subject: [PATCH v2 06/10] ref-filter.c: refactor to create common helper
 functions
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
Cc: Patrick Steinhardt <ps@pks.im>,
    =?UTF-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
    Kristoffer Haugsbakk <code@khaugsbakk.name>,
    Victoria Dye <vdye@github.com>,
    Victoria Dye <vdye@github.com>

From: Victoria Dye <vdye@github.com>

Factor out parts of 'ref_array_push()', 'ref_filter_handler()', and
'filter_refs()' into new helper functions:

* Extract the code to grow a 'struct ref_array' and append a given 'struct
  ref_array_item *' to it from 'ref_array_push()' into 'ref_array_append()'.
* Extract the code to filter a given ref by refname & object ID then create
  a new 'struct ref_array_item *' from 'filter_one()' into
  'apply_ref_filter()'.
* Extract the code for filter pre-processing, contains cache creation, and
  ref iteration from 'filter_refs()' into 'do_filter_refs()'.

In later patches, these helpers will be used by new ref-filter API
functions. This patch does not result in any user-facing behavior changes or
changes to callers outside of 'ref-filter.c'.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 ref-filter.c | 115 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 69 insertions(+), 46 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 5186ee2687b..ff00ab4b8d8 100644
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
-static int filter_one(const char *refname, const struct object_id *oid, int flag, void *cb_data)
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
@@ -2811,15 +2804,15 @@ static int filter_one(const char *refname, const struct object_id *oid, int flag
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
@@ -2827,11 +2820,32 @@ static int filter_one(const char *refname, const struct object_id *oid, int flag
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
-			ret = for_each_fullref_in("refs/heads/", filter_one, &ref_cbdata);
+			ret = for_each_fullref_in("refs/heads/", fn, cb_data);
 		else if (filter->kind == FILTER_REFS_REMOTES)
-			ret = for_each_fullref_in("refs/remotes/", filter_one, &ref_cbdata);
+			ret = for_each_fullref_in("refs/remotes/", fn, cb_data);
 		else if (filter->kind == FILTER_REFS_TAGS)
-			ret = for_each_fullref_in("refs/tags/", filter_one, &ref_cbdata);
+			ret = for_each_fullref_in("refs/tags/", fn, cb_data);
 		else if (filter->kind & FILTER_REFS_ALL)
-			ret = for_each_fullref_in_pattern(filter, filter_one, &ref_cbdata);
+			ret = for_each_fullref_in_pattern(filter, fn, cb_data);
 		if (!ret && (filter->kind & FILTER_REFS_DETACHED_HEAD))
-			head_ref(filter_one, &ref_cbdata);
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


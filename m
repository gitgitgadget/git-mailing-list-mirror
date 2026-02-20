Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446011E9B12
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 08:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771575910; cv=none; b=lzWC6QoTNwn5LJUx6KS/qIHgfsWUItdqjVQP3Fyypmyj63IAxFXR3dfo+Y3AOlGynRh4Oh/ATqy9TnFjkNvadGGM6ttOAVR74dmAhldrQ5lRHq8ulua3Ktm8qW8iHhI5lPirMPKrTL5xfXyqh6zosmcnTEd8rkXOOmTu/tz5K1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771575910; c=relaxed/simple;
	bh=ufD06MNjqYwKV0MWONSpnDfRa5UAs/7AL6crnqQi7yE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U5kiAh/xpsNd9pNEh91Ws/Gs/nnyZvgKHAlAVHWx+EpARrAZxALJjgH5anLWNFoL5hAkrLE0TYrCmLWHlS6JAwAnxXy3Gpzp6PpfsDVPhmU8Un+jnC0yXmDXLcho3Zi4TZGXfvCC0qG3ggxjl0yrXgDQ2ycKmoyT+s2pq3JTNIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aA6D9HRr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gHM3Cw29; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aA6D9HRr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gHM3Cw29"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2F7327A0011;
	Fri, 20 Feb 2026 03:25:08 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 20 Feb 2026 03:25:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771575908;
	 x=1771662308; bh=9IzjtvKZ9wUGi0ibRdKvntyM/aVpB+SQjm7RSf2/nTY=; b=
	aA6D9HRrmAlfSCX9NxIofFLt0uWO+wrI3LPS8yZ1wjHww5qK+2l8BGXKJ1ywrABb
	LGJDfLBn/Hh0V4+Gaf+wdYjqEnB8cKA/QmiSCl6LwLeVSnY/QXmP9oYwmYyzGeZh
	5hIYB8GCIwe3J+JE8LF35AyGcxRCysE1QrHvef6QSv/su0s8aIf6UBHA+z/7uE/O
	MKuyTWzhVefLL9wHjCu5qBnm0hLojZaDT3wC58g3/5pgHIJfPddi/c4BcglV1rtl
	B4sKgbtCC4hYjc2jcdcNUfaG+9l+uKVAQVlTixlVfNtTsX4rgynZL3JJATUIX7+6
	j6oS17f8+3gsiUXLxd1SHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771575908; x=
	1771662308; bh=9IzjtvKZ9wUGi0ibRdKvntyM/aVpB+SQjm7RSf2/nTY=; b=g
	HM3Cw29th91UYu8zPKwR9zLUCU7iQT6uYXkPQ1hYrPaNDHNE+tdlvOLQF2dA0Sf0
	tVxSpS5kWr+o/WS5Wplus3ju9tjxU2+0gVLeZEbI0rhqIc8dPomgJwKatg9LdVwh
	DY/qsnF6lsb+EcfvCgLRxXP8gfODjY2SG8REue+H6OM70dcK+yvA38bymqCC5IzC
	gLRzFmRviumOLXgYGNnB3+VNW+Dl12DWMyHbNR+FbeCup5wcSjzNG9HV71DNknY1
	3fSofM1mOY4XxQ3GsTWd2RHodm8TsBSm++MGHDcbBZ66l4HXIvrKXz3eCtXx94zM
	QhbPKZmpv60FdQoER4skg==
X-ME-Sender: <xms:YxqYaXQa0oZwBztasBRDIoSILeuJAhIFBUFXvnnEdvVKIg24PRVGKg>
    <xme:YxqYaewavf67N6S1SDdL0c5WRzisLtluxyEH_8RcOVusNz7sk4biG8SgqE7dGq92c
    jAeXMb6NZGZoonP6SaVzQWSw3-rwtDV4ar9Rz2HbcponzmeFrSyow>
X-ME-Received: <xmr:YxqYaad0jQrBXW8ddp_smTws3tRJ9wIlYnbw8AGwNA6v3NuvVieq0EDH9Vhyw-0eqKPVCMoErKvS58Au6is6cmlIBEvDizen_SM1UK9bNCku>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdejleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:YxqYaSL-1hiEYdKUYeEEG0CjH5wDeZAmwD3eZx9ShVpDq_CVdNL0NA>
    <xmx:ZBqYaTE--2hWeOIyA7yTmDMshbOYRPu-554qdOr4guAq-QXEErw_wQ>
    <xmx:ZBqYaUpsnd29lKFObOXpbmBpz_rZoInE98JhRuhAO7SDvy7sy96B4g>
    <xmx:ZBqYaURKHqdG1ioE8268hejye_KnpVZV9FgjgL9W4zLKkp25z4XqwQ>
    <xmx:ZBqYabCcwkXPGr9GQSpO_Ft1Oh5-kK3e0kPiYyM5X1rnD4nvMPF_R8dO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Feb 2026 03:25:07 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id af7ecd25 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Feb 2026 08:25:06 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Feb 2026 09:24:18 +0100
Subject: [PATCH 14/17] refs: replace `refs_for_each_glob_ref_in()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-pks-refs-for-each-unification-v1-14-17170bd99de1@pks.im>
References: <20260220-pks-refs-for-each-unification-v1-0-17170bd99de1@pks.im>
In-Reply-To: <20260220-pks-refs-for-each-unification-v1-0-17170bd99de1@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

Replace calls to `refs_for_each_glob_ref_in()` with the newly introduced
`refs_for_each_ref_ext()` function.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/bisect.c    | 34 ++++++++++++++++++++++++----------
 builtin/rev-parse.c |  9 ++++++---
 refs.c              | 10 ----------
 refs.h              |  3 ---
 revision.c          | 27 ++++++++++++++++++---------
 5 files changed, 48 insertions(+), 35 deletions(-)

diff --git a/builtin/bisect.c b/builtin/bisect.c
index 4cc118fb57..774abb3620 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -422,13 +422,16 @@ static void bisect_status(struct bisect_state *state,
 {
 	char *bad_ref = xstrfmt("refs/bisect/%s", terms->term_bad);
 	char *good_glob = xstrfmt("%s-*", terms->term_good);
+	struct refs_for_each_ref_options opts = {
+		.pattern = good_glob,
+		.prefix = "refs/bisect/",
+	};
 
 	if (refs_ref_exists(get_main_ref_store(the_repository), bad_ref))
 		state->nr_bad = 1;
 
-	refs_for_each_glob_ref_in(get_main_ref_store(the_repository), inc_nr,
-				  good_glob, "refs/bisect/",
-				  (void *) &state->nr_good);
+	refs_for_each_ref_ext(get_main_ref_store(the_repository),
+			      inc_nr, &state->nr_good, &opts);
 
 	free(good_glob);
 	free(bad_ref);
@@ -562,6 +565,9 @@ static int add_bisect_ref(const struct reference *ref, void *cb)
 
 static int prepare_revs(struct bisect_terms *terms, struct rev_info *revs)
 {
+	struct refs_for_each_ref_options opts = {
+		.prefix = "refs/bisect/",
+	};
 	int res = 0;
 	struct add_bisect_ref_data cb = { revs };
 	char *good = xstrfmt("%s-*", terms->term_good);
@@ -581,11 +587,16 @@ static int prepare_revs(struct bisect_terms *terms, struct rev_info *revs)
 	reset_revision_walk();
 	repo_init_revisions(the_repository, revs, NULL);
 	setup_revisions(0, NULL, revs, NULL);
-	refs_for_each_glob_ref_in(get_main_ref_store(the_repository),
-				  add_bisect_ref, bad, "refs/bisect/", &cb);
+
+	opts.pattern = bad;
+	refs_for_each_ref_ext(get_main_ref_store(the_repository),
+			      add_bisect_ref, &cb, &opts);
+
 	cb.object_flags = UNINTERESTING;
-	refs_for_each_glob_ref_in(get_main_ref_store(the_repository),
-				  add_bisect_ref, good, "refs/bisect/", &cb);
+	opts.pattern = good;
+	refs_for_each_ref_ext(get_main_ref_store(the_repository),
+			      add_bisect_ref, &cb, &opts);
+
 	if (prepare_revision_walk(revs))
 		res = error(_("revision walk setup failed"));
 
@@ -1191,10 +1202,13 @@ static int verify_good(const struct bisect_terms *terms, const char *command)
 	char *good_glob = xstrfmt("%s-*", terms->term_good);
 	int no_checkout = refs_ref_exists(get_main_ref_store(the_repository),
 					  "BISECT_HEAD");
+	struct refs_for_each_ref_options opts = {
+		.pattern = good_glob,
+		.prefix = "refs/bisect/",
+	};
 
-	refs_for_each_glob_ref_in(get_main_ref_store(the_repository),
-				  get_first_good, good_glob, "refs/bisect/",
-				  &good_rev);
+	refs_for_each_ref_ext(get_main_ref_store(the_repository),
+			      get_first_good, &good_rev, &opts);
 	free(good_glob);
 
 	if (refs_read_ref(get_main_ref_store(the_repository), no_checkout ? "BISECT_HEAD" : "HEAD", &current_rev))
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 02703f2fb8..206f5bda39 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -614,9 +614,12 @@ static int opt_with_value(const char *arg, const char *opt, const char **value)
 static void handle_ref_opt(const char *pattern, const char *prefix)
 {
 	if (pattern) {
-		refs_for_each_glob_ref_in(get_main_ref_store(the_repository),
-					  show_reference, pattern, prefix,
-					  NULL);
+		struct refs_for_each_ref_options opts = {
+			.pattern = pattern,
+			.prefix = prefix,
+		};
+		refs_for_each_ref_ext(get_main_ref_store(the_repository),
+				      show_reference, NULL, &opts);
 	} else {
 		struct refs_for_each_ref_options opts = {
 			.prefix = prefix,
diff --git a/refs.c b/refs.c
index 454c9dd017..1fa16facb8 100644
--- a/refs.c
+++ b/refs.c
@@ -605,16 +605,6 @@ void normalize_glob_ref(struct string_list_item *item, const char *prefix,
 	strbuf_release(&normalized_pattern);
 }
 
-int refs_for_each_glob_ref_in(struct ref_store *refs, refs_for_each_cb cb,
-			      const char *pattern, const char *prefix, void *cb_data)
-{
-	struct refs_for_each_ref_options opts = {
-		.pattern = pattern,
-		.prefix = prefix,
-	};
-	return refs_for_each_ref_ext(refs, cb, cb_data, &opts);
-}
-
 int refs_for_each_glob_ref(struct ref_store *refs, refs_for_each_cb cb,
 			   const char *pattern, void *cb_data)
 {
diff --git a/refs.h b/refs.h
index 2915ff081a..1d21999ae1 100644
--- a/refs.h
+++ b/refs.h
@@ -530,9 +530,6 @@ int refs_for_each_ref_in_prefixes(struct ref_store *refs,
 int refs_for_each_glob_ref(struct ref_store *refs, refs_for_each_cb fn,
 			   const char *pattern, void *cb_data);
 
-int refs_for_each_glob_ref_in(struct ref_store *refs, refs_for_each_cb fn,
-			      const char *pattern, const char *prefix, void *cb_data);
-
 /*
  * references matching any pattern in "exclude_patterns" are omitted from the
  * result set on a best-effort basis.
diff --git a/revision.c b/revision.c
index 8c206830d5..da7737ce28 100644
--- a/revision.c
+++ b/revision.c
@@ -2827,34 +2827,43 @@ static int handle_revision_pseudo_opt(struct rev_info *revs,
 		exclude_hidden_refs(&revs->ref_excludes, optarg);
 		return argcount;
 	} else if (skip_prefix(arg, "--branches=", &optarg)) {
+		struct refs_for_each_ref_options opts = {
+			.prefix = "refs/heads/",
+			.pattern = optarg,
+		};
 		struct all_refs_cb cb;
 		if (revs->ref_excludes.hidden_refs_configured)
 			return error(_("options '%s' and '%s' cannot be used together"),
 				     "--exclude-hidden", "--branches");
 		init_all_refs_cb(&cb, revs, *flags);
-		refs_for_each_glob_ref_in(get_main_ref_store(the_repository),
-					  handle_one_ref, optarg,
-					  "refs/heads/", &cb);
+		refs_for_each_ref_ext(get_main_ref_store(the_repository),
+				      handle_one_ref, &cb, &opts);
 		clear_ref_exclusions(&revs->ref_excludes);
 	} else if (skip_prefix(arg, "--tags=", &optarg)) {
+		struct refs_for_each_ref_options opts = {
+			.prefix = "refs/tags/",
+			.pattern = optarg,
+		};
 		struct all_refs_cb cb;
 		if (revs->ref_excludes.hidden_refs_configured)
 			return error(_("options '%s' and '%s' cannot be used together"),
 				     "--exclude-hidden", "--tags");
 		init_all_refs_cb(&cb, revs, *flags);
-		refs_for_each_glob_ref_in(get_main_ref_store(the_repository),
-					  handle_one_ref, optarg,
-					  "refs/tags/", &cb);
+		refs_for_each_ref_ext(get_main_ref_store(the_repository),
+				      handle_one_ref, &cb, &opts);
 		clear_ref_exclusions(&revs->ref_excludes);
 	} else if (skip_prefix(arg, "--remotes=", &optarg)) {
+		struct refs_for_each_ref_options opts = {
+			.prefix = "refs/remotes/",
+			.pattern = optarg,
+		};
 		struct all_refs_cb cb;
 		if (revs->ref_excludes.hidden_refs_configured)
 			return error(_("options '%s' and '%s' cannot be used together"),
 				     "--exclude-hidden", "--remotes");
 		init_all_refs_cb(&cb, revs, *flags);
-		refs_for_each_glob_ref_in(get_main_ref_store(the_repository),
-					  handle_one_ref, optarg,
-					  "refs/remotes/", &cb);
+		refs_for_each_ref_ext(get_main_ref_store(the_repository),
+				      handle_one_ref, &cb, &opts);
 		clear_ref_exclusions(&revs->ref_excludes);
 	} else if (!strcmp(arg, "--reflog")) {
 		add_reflogs_to_pending(revs, *flags);

-- 
2.53.0.414.gf7e9f6c205.dirty


Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAC23659EA
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 12:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771848024; cv=none; b=eydx3BaYaO2LmnENobKB7pfovHxZ3VETp5MKsHEFNPyeXDshT3MQx2T8doZgf1exmfuz/egAVl8rFnCs2JXGMuYuNh79n8yBluep5Vr5lzmwJEnA75XzixKrIqTjHiWuMl31A0dLCS7YZsmN/2S4uWNGR/abmFF/XiqsNedDffs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771848024; c=relaxed/simple;
	bh=QcA/ejdFyDbjWCCXQjkOJNhOO8CQ8ShWw9Mwvk80Dl0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u+E9bUa3SVKQntVXJETpXx7ExN81UggLUvp+m8MFr12c/e2z1/WgNMADoN9BupFLSy0aPKQD6lxzlmUP+FfkqvJUgqI9n1DQ1i21gK8A4qN4JOiyHQMCGQXjlMX1COE0UKFDP5phUWTO3PNckpq36chRjs67tk4lepkauhXdZNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HsKu6NCu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OXV2YcY9; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HsKu6NCu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OXV2YcY9"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 03C83EC05BE;
	Mon, 23 Feb 2026 07:00:21 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 23 Feb 2026 07:00:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771848020;
	 x=1771934420; bh=NbRgjucRFMmrqY3kIo2tz87nkvGYi+qgKTlsh3faD5U=; b=
	HsKu6NCuikiLeK7lM2pUjZRL4C9/fbONejMI8cnuFSntOEhynOsUFWYoPkmDatA0
	1HXLxwM5LeRimYUs/ZmpLh4W8nIBugfrnn1vtJBgeCQHJV5map3JKePP/I3tGYWR
	OwWrd0/zA1WEuijBeQ24tep5wz+JxQNq4eAKBh1zZuBaQ1kFHdmwN2YV4xC5RYwL
	VW7LfQ6sne0NjmmJKneJ8SZUe34m2hTiTeEgA6sda/Nhih5B/p0uVqM77K9SaJBA
	ip8+zA/TgqUJcbXJHWvjYevUH4K4WBcbFiDVBcI3Fa4Rad2wXXz2pYrc2djj9h6F
	Olfn7tCAlkfFNcjDICvn6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771848020; x=
	1771934420; bh=NbRgjucRFMmrqY3kIo2tz87nkvGYi+qgKTlsh3faD5U=; b=O
	XV2YcY9OmV1DFkDXeWYxzrkF6ebJZXsFUEWwv1LKoMRfWWWli5bC/BzqOeXYClZ8
	vzy5v3auOjWDha6MK1fVyjocD2L0ZnyY8oY1+o0DRGUvJ9AI1By8Hn7gxVohtkMy
	r1CJ+k/ITcykjxrVQtgo2BUHV6On6lKLRnXSd9IK4z3taEwiGLlIKWICIWabvU+y
	WOiygN2XhsC+3hnZte966HiFrbVx6FTquX5nWcwLDQsD7le/V5gi6/3MKXJr+ymQ
	MVUQzpHGuzZAlsmF+j3TsPIR2zzt14KcumPQ2bvJbB/I2xPvtBpGnPaiEFSLr9Kc
	R71BqP3Yul96VYuyZ8TRQ==
X-ME-Sender: <xms:VEGcaSSBHIb73jTP_YJ2elqusrCMmukhTfdXBBq80g3s9I9WAsfj3Q>
    <xme:VEGcafNLK62P99Onc77q5acKXmom-qMiP1CNMN2RnaWawpti-LRo_DZ16qzTryNtM
    dKtSoI3YyBMkpRh1vGehxl1-jlgqUvnxbGcKA9kbMpnlsxC8rGa>
X-ME-Received: <xmr:VEGcadOwLZTKsa5dlReMTtyjMabQd1kIj5566chMI6oHmV4eDoDRPAXcTA6dp9sxTlar-8vH51JSm7RthqdAVAdRs0oWDNKpSP47yI76pw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehoshifrghlugdrsghuugguvghnhhgrghgvnhesghhmgidruggvpdhrtghpthhtoh
    epkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:VEGcaXtfoAnQiRjPvJeOPqypU0LBeTHTexcy-V2Odr2d6JJDWqdqqw>
    <xmx:VEGcafWk1kiECY1jN_3m-C-DH3vpMgAxMlnDid883pvf-tUwWgyT9w>
    <xmx:VEGcaXvbBW5yamCwHywlfCOq7THqgK3y1PzbNhMO4e5moTI6v_pXfw>
    <xmx:VEGcaTX_5YjvDhSPQL2wTSvtfgzRWs0vk6uJK_1TH8ZTRSLCdgOX0w>
    <xmx:VEGcaftd4EJbYBzMY0LEhQz9AZl1D9yGdr1vCCeQf-4yjbJjz5U535_F>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 07:00:20 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b15d7ffc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Feb 2026 12:00:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 23 Feb 2026 12:59:48 +0100
Subject: [PATCH v2 14/17] refs: replace `refs_for_each_glob_ref_in()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-pks-refs-for-each-unification-v2-14-515d48c8087b@pks.im>
References: <20260223-pks-refs-for-each-unification-v2-0-515d48c8087b@pks.im>
In-Reply-To: <20260223-pks-refs-for-each-unification-v2-0-515d48c8087b@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
X-Mailer: b4 0.14.3

Replace calls to `refs_for_each_glob_ref_in()` with the newly introduced
`refs_for_each_ref_ext()` function.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/bisect.c    | 37 +++++++++++++++++++++++++++----------
 builtin/rev-parse.c | 10 +++++++---
 refs.c              | 11 -----------
 refs.h              |  3 ---
 revision.c          | 30 +++++++++++++++++++++---------
 5 files changed, 55 insertions(+), 36 deletions(-)

diff --git a/builtin/bisect.c b/builtin/bisect.c
index 4cc118fb57..4520e585d0 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -422,13 +422,17 @@ static void bisect_status(struct bisect_state *state,
 {
 	char *bad_ref = xstrfmt("refs/bisect/%s", terms->term_bad);
 	char *good_glob = xstrfmt("%s-*", terms->term_good);
+	struct refs_for_each_ref_options opts = {
+		.pattern = good_glob,
+		.prefix = "refs/bisect/",
+		.trim_prefix = strlen("refs/bisect/"),
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
@@ -562,6 +566,10 @@ static int add_bisect_ref(const struct reference *ref, void *cb)
 
 static int prepare_revs(struct bisect_terms *terms, struct rev_info *revs)
 {
+	struct refs_for_each_ref_options opts = {
+		.prefix = "refs/bisect/",
+		.trim_prefix = strlen("refs/bisect/"),
+	};
 	int res = 0;
 	struct add_bisect_ref_data cb = { revs };
 	char *good = xstrfmt("%s-*", terms->term_good);
@@ -581,11 +589,16 @@ static int prepare_revs(struct bisect_terms *terms, struct rev_info *revs)
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
 
@@ -1191,10 +1204,14 @@ static int verify_good(const struct bisect_terms *terms, const char *command)
 	char *good_glob = xstrfmt("%s-*", terms->term_good);
 	int no_checkout = refs_ref_exists(get_main_ref_store(the_repository),
 					  "BISECT_HEAD");
+	struct refs_for_each_ref_options opts = {
+		.pattern = good_glob,
+		.prefix = "refs/bisect/",
+		.trim_prefix = strlen("refs/bisect/"),
+	};
 
-	refs_for_each_glob_ref_in(get_main_ref_store(the_repository),
-				  get_first_good, good_glob, "refs/bisect/",
-				  &good_rev);
+	refs_for_each_ref_ext(get_main_ref_store(the_repository),
+			      get_first_good, &good_rev, &opts);
 	free(good_glob);
 
 	if (refs_read_ref(get_main_ref_store(the_repository), no_checkout ? "BISECT_HEAD" : "HEAD", &current_rev))
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 02703f2fb8..61a3f0fdb9 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -614,9 +614,13 @@ static int opt_with_value(const char *arg, const char *opt, const char **value)
 static void handle_ref_opt(const char *pattern, const char *prefix)
 {
 	if (pattern) {
-		refs_for_each_glob_ref_in(get_main_ref_store(the_repository),
-					  show_reference, pattern, prefix,
-					  NULL);
+		struct refs_for_each_ref_options opts = {
+			.pattern = pattern,
+			.prefix = prefix,
+			.trim_prefix = prefix ? strlen(prefix) : 0,
+		};
+		refs_for_each_ref_ext(get_main_ref_store(the_repository),
+				      show_reference, NULL, &opts);
 	} else {
 		struct refs_for_each_ref_options opts = {
 			.prefix = prefix,
diff --git a/refs.c b/refs.c
index 172d4cf941..b4ef4ffff0 100644
--- a/refs.c
+++ b/refs.c
@@ -607,17 +607,6 @@ void normalize_glob_ref(struct string_list_item *item, const char *prefix,
 	strbuf_release(&normalized_pattern);
 }
 
-int refs_for_each_glob_ref_in(struct ref_store *refs, refs_for_each_cb cb,
-			      const char *pattern, const char *prefix, void *cb_data)
-{
-	struct refs_for_each_ref_options opts = {
-		.pattern = pattern,
-		.prefix = prefix,
-		.trim_prefix = prefix ? strlen(prefix) : 0,
-	};
-	return refs_for_each_ref_ext(refs, cb, cb_data, &opts);
-}
-
 int refs_for_each_glob_ref(struct ref_store *refs, refs_for_each_cb cb,
 			   const char *pattern, void *cb_data)
 {
diff --git a/refs.h b/refs.h
index 673d4ccce5..3fa2c11c1f 100644
--- a/refs.h
+++ b/refs.h
@@ -531,9 +531,6 @@ int refs_for_each_ref_in_prefixes(struct ref_store *refs,
 int refs_for_each_glob_ref(struct ref_store *refs, refs_for_each_cb fn,
 			   const char *pattern, void *cb_data);
 
-int refs_for_each_glob_ref_in(struct ref_store *refs, refs_for_each_cb fn,
-			      const char *pattern, const char *prefix, void *cb_data);
-
 /*
  * references matching any pattern in "exclude_patterns" are omitted from the
  * result set on a best-effort basis.
diff --git a/revision.c b/revision.c
index 8c206830d5..074a75b859 100644
--- a/revision.c
+++ b/revision.c
@@ -2827,34 +2827,46 @@ static int handle_revision_pseudo_opt(struct rev_info *revs,
 		exclude_hidden_refs(&revs->ref_excludes, optarg);
 		return argcount;
 	} else if (skip_prefix(arg, "--branches=", &optarg)) {
+		struct refs_for_each_ref_options opts = {
+			.prefix = "refs/heads/",
+			.trim_prefix = strlen("refs/heads/"),
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
+			.trim_prefix = strlen("refs/tags/"),
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
+			.trim_prefix = strlen("refs/remotes/"),
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
2.53.0.536.g309c995771.dirty


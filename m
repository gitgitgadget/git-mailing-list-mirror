Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F7C34F261
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 12:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771848030; cv=none; b=LThOEF+K83gLSkuvstNdqxqlpFQCgOoPpqYG8qmiJlhFpfHkwfjlrXAmpozVVAebwdqJzhILKgfjVV6ZMBJXM27qtVlPc8FiHRYmjf8M7nsicpvQswZ4WTViDkL0rOKjkkkHjxOSKHicDv9wKqHocmPbChzeaRuoU6m0UtIvIpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771848030; c=relaxed/simple;
	bh=zhnX03kvEskBnoSE0/5+nYOMMGQtfgiaj9IktRmF0Bw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dAUa5AT9XSy1hPluxINlolm+WuVOzdd9XY0r7CjNs5ZF/evLIQBIHT2MVSd9n6Lq+VokV+ara/ktb8rar773TTRRuJ6+wrpdC3QV6/84Ja1JlfLFzZ1H5HEroxX/+LXQ0W23XjklZ/i0sK/SJS8yjXXY4U+y0/jfa2JThFJUGMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ji6tEGYG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NXCx/0PS; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ji6tEGYG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NXCx/0PS"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DDF7D14001A7;
	Mon, 23 Feb 2026 07:00:28 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 23 Feb 2026 07:00:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771848028;
	 x=1771934428; bh=9QsHk4RDiPAMwiODTMlKhyFHefku604rWzGyOM3yJhU=; b=
	Ji6tEGYGvpOmxVm/FGK3HAPnwwbxiBBjFnazQxTia6dVFb9lak3+uOi4B95itO68
	7T3cCGxLB+GEBuS23+ByX2+S/h5kHIU2L08tM19Luc3pslZfkW7vqm4TS1Dc7o59
	PFHvpyO5I3YrWPyjqXnpm1Y5UavQNArASvPOyFZJVMLhJLTTu0p5tEDWcHm/HA/Y
	TeGYXTyD502Zo4z6wUAEkbPOF0kXOdKyju56EoD2NMm1CDzfiLOGsrS/lD21qH/N
	V+xWNc3IY3zj7jLLKyc7b281FwDoDK2Co/TJtx4qLS5fpibXm7umJorAfHfhn9l1
	Z3RJliCGWr19NLPNDu3F8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771848028; x=
	1771934428; bh=9QsHk4RDiPAMwiODTMlKhyFHefku604rWzGyOM3yJhU=; b=N
	XCx/0PSlXngHB/5mqqFImkGuX4nADRfc3ssw6k15fYI4Ju+2/bjKWalFWYhC0i28
	XMZAaZyEbNcvxXSyeo2l7V2sHIUfp2prl/yqqTmuZNZgwBfzqygForeMEpkoigSX
	w0qvtEupDDII4OvSLq5dSvfIBcMvVcDwQu8VbdduD2jYvlX01JAsWbzIEWr3aU9D
	MMy4Hx62kH/hkBv2BUakzqgKvIoxaSaWter2TEiYeHGa2xThOJimxqFTu3MtyB+n
	8COGonhuHONEts9nmGK0pxYQP2T4/RSQQSE8S2DkJQj76E/06GmTKScatimBKGag
	CRn85RKnkgwNUo3ohf7bg==
X-ME-Sender: <xms:XEGcadqFZQtyDQoubdgyxWNTyECvSkHUswZ42Jz6x78LeoKSaDmBkA>
    <xme:XEGcaXHRRTNFl_uYc93dA1WFrnZO05mY9tBDQjYqbJMx7W9fqijd2bS5JQ4w5RhXS
    iFnPoPk1cfYf2MS5EOVlGyBV8I2AMb96fG5wP_9o5Of1s5AFDVbUvo>
X-ME-Received: <xmr:XEGcaXm7j9XyEbkXyW-zNO8H0KwpTpPLatKFg5zMpl75RtxoQ7i7vwmHTAC-mUoU-ZdvRXMUuvczaOCPaeKVzL8287ouum049qKF4RGgOg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehoshifrghlugdrsghuuggu
    vghnhhgrghgvnhesghhmgidruggv
X-ME-Proxy: <xmx:XEGcaSkM-Lp5SORIFmegDJd6UFmvFgzgjQe29_CghtAq-JTgDGE6Cg>
    <xmx:XEGcaQt_t6Qzx2ymnl680Nq2mKfFAgqH7rU2HrG28ebJupAmh1zc1g>
    <xmx:XEGcadl6-rCoESBhf5HoODczmGzo30doS5xkmsfqZO22fI4lFVb0ow>
    <xmx:XEGcaTtO5EBzLWLgTGNoGRPfMFMGoRQvy3ZVJC9E_XW5lgmJQPhAWA>
    <xmx:XEGcadme9NNBGSy5kDhgiJ3YO_UErA4DpvkNasj93LNdqt9XkDnvLv4u>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 07:00:28 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3f2562f7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Feb 2026 12:00:27 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 23 Feb 2026 12:59:51 +0100
Subject: [PATCH v2 17/17] refs: replace `refs_for_each_fullref_in()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-pks-refs-for-each-unification-v2-17-515d48c8087b@pks.im>
References: <20260223-pks-refs-for-each-unification-v2-0-515d48c8087b@pks.im>
In-Reply-To: <20260223-pks-refs-for-each-unification-v2-0-515d48c8087b@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
X-Mailer: b4 0.14.3

Replace calls to `refs_for_each_fullref_in()` with the newly introduced
`refs_for_each_ref_ext()` function.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 bisect.c                  |  8 +++++---
 builtin/receive-pack.c    |  8 ++++----
 builtin/rev-parse.c       | 15 +++++++--------
 builtin/show-ref.c        | 21 +++++++++++++--------
 refs.c                    | 11 -----------
 refs.h                    |  8 --------
 revision.c                |  4 +++-
 t/helper/test-ref-store.c |  8 +++++---
 8 files changed, 37 insertions(+), 46 deletions(-)

diff --git a/bisect.c b/bisect.c
index 296836c154..ef17a442e5 100644
--- a/bisect.c
+++ b/bisect.c
@@ -1190,13 +1190,15 @@ static int mark_for_removal(const struct reference *ref, void *cb_data)
 
 int bisect_clean_state(void)
 {
+	struct refs_for_each_ref_options opts = {
+		.prefix = "refs/bisect/",
+	};
 	int result = 0;
 
 	/* There may be some refs packed during bisection */
 	struct string_list refs_for_removal = STRING_LIST_INIT_DUP;
-	refs_for_each_fullref_in(get_main_ref_store(the_repository),
-				 "refs/bisect/", NULL, mark_for_removal,
-				 &refs_for_removal);
+	refs_for_each_ref_ext(get_main_ref_store(the_repository),
+			      mark_for_removal, &refs_for_removal, &opts);
 	string_list_append(&refs_for_removal, "BISECT_HEAD");
 	string_list_append(&refs_for_removal, "BISECT_EXPECTED_REV");
 	result = refs_delete_refs(get_main_ref_store(the_repository),
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 4c0112b4bc..8c5ad5b81e 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -343,9 +343,9 @@ static void show_one_alternate_ref(const struct object_id *oid,
 
 static void write_head_info(void)
 {
+	struct refs_for_each_ref_options opts = { 0 };
 	static struct oidset seen = OIDSET_INIT;
 	struct strvec excludes_vector = STRVEC_INIT;
-	const char **exclude_patterns;
 
 	/*
 	 * We need access to the reference names both with and without their
@@ -353,12 +353,12 @@ static void write_head_info(void)
 	 * thus have to adapt exclude patterns to carry the namespace prefix
 	 * ourselves.
 	 */
-	exclude_patterns = get_namespaced_exclude_patterns(
+	opts.exclude_patterns = get_namespaced_exclude_patterns(
 		hidden_refs_to_excludes(&hidden_refs),
 		get_git_namespace(), &excludes_vector);
 
-	refs_for_each_fullref_in(get_main_ref_store(the_repository), "",
-				 exclude_patterns, show_ref_cb, &seen);
+	refs_for_each_ref_ext(get_main_ref_store(the_repository),
+			      show_ref_cb, &seen, &opts);
 	odb_for_each_alternate_ref(the_repository->objects,
 				   show_one_alternate_ref, &seen);
 
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 61a3f0fdb9..01a62800e8 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -940,14 +940,13 @@ int cmd_rev_parse(int argc,
 				continue;
 			}
 			if (!strcmp(arg, "--bisect")) {
-				refs_for_each_fullref_in(get_main_ref_store(the_repository),
-							 "refs/bisect/bad",
-							 NULL, show_reference,
-							 NULL);
-				refs_for_each_fullref_in(get_main_ref_store(the_repository),
-							 "refs/bisect/good",
-							 NULL, anti_reference,
-							 NULL);
+				struct refs_for_each_ref_options opts = { 0 };
+				opts.prefix = "refs/bisect/bad";
+				refs_for_each_ref_ext(get_main_ref_store(the_repository),
+						      show_reference, NULL, &opts);
+				opts.prefix = "refs/bisect/good";
+				refs_for_each_ref_ext(get_main_ref_store(the_repository),
+						      anti_reference, NULL, &opts);
 				continue;
 			}
 			if (opt_with_value(arg, "--branches", &arg)) {
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 4d4984e4e0..5d31acea7c 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -215,14 +215,19 @@ static int cmd_show_ref__patterns(const struct patterns_options *opts,
 		refs_head_ref(get_main_ref_store(the_repository), show_ref,
 			      &show_ref_data);
 	if (opts->branches_only || opts->tags_only) {
-		if (opts->branches_only)
-			refs_for_each_fullref_in(get_main_ref_store(the_repository),
-						 "refs/heads/", NULL,
-						 show_ref, &show_ref_data);
-		if (opts->tags_only)
-			refs_for_each_fullref_in(get_main_ref_store(the_repository),
-						 "refs/tags/", NULL, show_ref,
-						 &show_ref_data);
+		struct refs_for_each_ref_options for_each_ref_opts = { 0 };
+
+		if (opts->branches_only) {
+			for_each_ref_opts.prefix = "refs/heads/";
+			refs_for_each_ref_ext(get_main_ref_store(the_repository),
+					      show_ref, &show_ref_data, &for_each_ref_opts);
+		}
+
+		if (opts->tags_only) {
+			for_each_ref_opts.prefix = "refs/tags/";
+			refs_for_each_ref_ext(get_main_ref_store(the_repository),
+					      show_ref, &show_ref_data, &for_each_ref_opts);
+		}
 	} else {
 		refs_for_each_ref(get_main_ref_store(the_repository),
 				  show_ref, &show_ref_data);
diff --git a/refs.c b/refs.c
index 35a4925ac4..af51a648d5 100644
--- a/refs.c
+++ b/refs.c
@@ -1929,17 +1929,6 @@ int refs_for_each_ref(struct ref_store *refs, refs_for_each_cb cb, void *cb_data
 	return refs_for_each_ref_ext(refs, cb, cb_data, &opts);
 }
 
-int refs_for_each_fullref_in(struct ref_store *refs, const char *prefix,
-			     const char **exclude_patterns,
-			     refs_for_each_cb cb, void *cb_data)
-{
-	struct refs_for_each_ref_options opts = {
-		.prefix = prefix,
-		.exclude_patterns = exclude_patterns,
-	};
-	return refs_for_each_ref_ext(refs, cb, cb_data, &opts);
-}
-
 int refs_for_each_replace_ref(struct ref_store *refs, refs_for_each_cb cb, void *cb_data)
 {
 	const char *git_replace_ref_base = ref_namespace[NAMESPACE_REPLACE].ref;
diff --git a/refs.h b/refs.h
index 1b468c4ffb..9b5d57a9b7 100644
--- a/refs.h
+++ b/refs.h
@@ -510,14 +510,6 @@ int refs_for_each_remote_ref(struct ref_store *refs,
 int refs_for_each_replace_ref(struct ref_store *refs,
 			      refs_for_each_cb fn, void *cb_data);
 
-/*
- * references matching any pattern in "exclude_patterns" are omitted from the
- * result set on a best-effort basis.
- */
-int refs_for_each_fullref_in(struct ref_store *refs, const char *prefix,
-			     const char **exclude_patterns,
-			     refs_for_each_cb fn, void *cb_data);
-
 /**
  * Iterate all refs in "prefixes" by partitioning prefixes into disjoint sets
  * and iterating the longest-common prefix of each set.
diff --git a/revision.c b/revision.c
index 4ddb3370c6..0136ef64f5 100644
--- a/revision.c
+++ b/revision.c
@@ -2731,10 +2731,12 @@ void revision_opts_finish(struct rev_info *revs)
 static int for_each_bisect_ref(struct ref_store *refs, refs_for_each_cb fn,
 			       void *cb_data, const char *term)
 {
+	struct refs_for_each_ref_options opts = { 0 };
 	struct strbuf bisect_refs = STRBUF_INIT;
 	int status;
 	strbuf_addf(&bisect_refs, "refs/bisect/%s", term);
-	status = refs_for_each_fullref_in(refs, bisect_refs.buf, NULL, fn, cb_data);
+	opts.prefix = bisect_refs.buf;
+	status = refs_for_each_ref_ext(refs, fn, cb_data, &opts);
 	strbuf_release(&bisect_refs);
 	return status;
 }
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index a2ef1b6949..74edf2029a 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -173,10 +173,12 @@ static int cmd_for_each_ref(struct ref_store *refs, const char **argv)
 static int cmd_for_each_ref__exclude(struct ref_store *refs, const char **argv)
 {
 	const char *prefix = notnull(*argv++, "prefix");
-	const char **exclude_patterns = argv;
+	struct refs_for_each_ref_options opts = {
+		.prefix = prefix,
+		.exclude_patterns = argv,
+	};
 
-	return refs_for_each_fullref_in(refs, prefix, exclude_patterns, each_ref,
-					NULL);
+	return refs_for_each_ref_ext(refs, each_ref, NULL, &opts);
 }
 
 static int cmd_resolve_ref(struct ref_store *refs, const char **argv)

-- 
2.53.0.536.g309c995771.dirty


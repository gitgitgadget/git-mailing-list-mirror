Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4239E3358CD
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 08:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771575919; cv=none; b=nPuqdz3DCcAREm656NiUCBnmp4otwGhrP4XHaz13NQXSCsfRsLNSxfGVMvAXqxRKS+hRgHrYHlS6S6Yi2SHC8/n61DhC+EIgXWyrkCzdL//jWpSl1DaSnBhFRaB92ehJBs8/CuxlKpLemIm1DuRk9I27lkeemYRxyMmz1p3NVK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771575919; c=relaxed/simple;
	bh=pZUkTBdcaTdNvDs/v6VaH2Jqet3GvGwqsPPI1moZ0Ig=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EXxpVN7iac63FbJn8+vLc54/ndNriFNdoGDKRIh0GED8HZP1mPobD3cCLUIPjJlZhUQFXdBpSRi4cVJN3WJrnVieNCgR2mxWUMfVrtTkX9h12oF8tdA1n3sZGrx1Ea4fmfN78qCzeZvZJCPMy8fwrn5JrNL++AJh/qA4/fYH2Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ETokmiBE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bvXtUWVb; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ETokmiBE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bvXtUWVb"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 4142C1D000DD;
	Fri, 20 Feb 2026 03:25:17 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 20 Feb 2026 03:25:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771575917;
	 x=1771662317; bh=jxWmsKR841lVGULkistKlAlK+DkwdIWXnpm1Owwx8UU=; b=
	ETokmiBEd4nMoDZ/OiUXQGa4iy9Qp3xLdtHirIsegmHK0edQ3lEwQbhTGR1bxnSt
	TW/mQAx2tkae22TohYf6pZ6sOwz6d/ailEws8ILCwTPkTam4F+OO5Iic6ho/5XmX
	tw+76bjc/ndk/Nzb8nlge4MWftds+3AGo/Tg0VmDakDoXVWH6PlJPvOy7vDXIKcz
	GY1nVMDqTc41+NzzSKW526btVES/8x65dovVf2fhWC0WVVGPHCeVRCzF0Ai7FM9n
	M1EtIleCvJKtWxBUEyqxgLqJ/Ftjq1XN2zNn9a7zn/NM+xI7LqOMA/vs8l5t/hHN
	oBk7iRVhs4coWhAcL3cnfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771575917; x=
	1771662317; bh=jxWmsKR841lVGULkistKlAlK+DkwdIWXnpm1Owwx8UU=; b=b
	vXtUWVb5KNmhEbTTgeinJKk5C6K0ic9NyRzKNQx5EN8EsDZB+qx5bDgTvLButDTF
	F7DMZHqIJPyPb46WvvIwsFJqzq8QvCn5YIcOCNVWpzgjN+YRFCfQXyq0574Sf+OB
	MCvJzXbdsBf04OLKLcRDAgowimyyGcsarGTSsopJAktL+cWkYfhWb46bTdZ0bSrI
	83zp8gWtYjK+QNYHBbCdSGk5YXAREZeE1Bf7SuK6xeNscHJHUobeyPm27M8Xs1Td
	b+4p6K4Nvq1jM3v4PpOOoxlHCARMvu/GoXbQrzX5yRV4AFPdxkmcqioST2J4v+AD
	W61j72ddJDXJfQBrBphLg==
X-ME-Sender: <xms:bRqYaZYD9K2kOCcaZz4nmQknt_9goVQu0YueT3f5nzlXV2wadrqelw>
    <xme:bRqYaWbq-Ybxb4QNIUB1E8agixuXqedsLNq3sqXrHr4CPssPqzfnG149cWeBHeuGc
    R3B28LnMubWBolIz4zyU_k6sPoJ3xDhCi9UHyz_SLTL8xWc6duogVI>
X-ME-Received: <xmr:bRqYaZlnUb9ZgPr_BYAetdoZO-ubmK1LdeWaABHxT1lL_MCSNgsoP0PEZpzxfFJlcgiJFh6pVMvqiculYXsMBrOBTE91349kXg7jJ2Sap8z7>
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
X-ME-Proxy: <xmx:bRqYaSzbou_4Kl26J5x4H3GYCxIjsnK1nQoZmEt45uM2PkJUzyGCYQ>
    <xmx:bRqYaXNXl3eRxGu4sPu6AG-z4_fgVJyDyzXPpYaPeiqcOJfIexFldw>
    <xmx:bRqYaWR5ndltmxPOIXDU-T-lb1-n8KI7ac7HKjanmoL4NS_ElA0A9g>
    <xmx:bRqYaVY64Z6pK2M-LqueqaH4PT01r-YRyfvIyi3uCuhvQ7dpVYcDuA>
    <xmx:bRqYafLHNuG0vzKUDYD1I9oX3ZBwEGwIxNDoc7wSmuJDl_QZTPDlxVFL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Feb 2026 03:25:16 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d4b5885c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Feb 2026 08:25:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Feb 2026 09:24:21 +0100
Subject: [PATCH 17/17] refs: replace `refs_for_each_fullref_in()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-pks-refs-for-each-unification-v1-17-17170bd99de1@pks.im>
References: <20260220-pks-refs-for-each-unification-v1-0-17170bd99de1@pks.im>
In-Reply-To: <20260220-pks-refs-for-each-unification-v1-0-17170bd99de1@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
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
index 206f5bda39..6c73631733 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -939,14 +939,13 @@ int cmd_rev_parse(int argc,
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
index 28142fa967..781fe2ed82 100644
--- a/refs.c
+++ b/refs.c
@@ -1920,17 +1920,6 @@ int refs_for_each_ref(struct ref_store *refs, refs_for_each_cb cb, void *cb_data
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
index eae45ce15a..d7332a01f9 100644
--- a/refs.h
+++ b/refs.h
@@ -509,14 +509,6 @@ int refs_for_each_remote_ref(struct ref_store *refs,
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
index 8a6a871b1c..76c170e92d 100644
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
2.53.0.414.gf7e9f6c205.dirty


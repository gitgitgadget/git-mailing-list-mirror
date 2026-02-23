Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E87A365A13
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 12:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771848017; cv=none; b=sCHLLyKVWIecWPN/3XeLLAiIwkUM+jF3HlJgu6QZFqEJr6ZV5YBJLM7m16uiGKBP49z1Ma8fFg/RW5QdRGfzglQB3AIkZxgquwMhhnRxN4pizQ8zcfZnpt7b6WB/hwk2Lw76pR+mN0XLkqFYTpuVR/3cXfE2SADd1pequwfZd1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771848017; c=relaxed/simple;
	bh=qRy01rbtXAnPDC4Yq4tIwQumeqL3ebAMbbNGeLFMwVs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mb1OtpHl5LVJI4NO62rSSM/a7ay4mYoayAGTyZtyggjMpHcxpEDeiRLsDfdQr/HOUDBe2XGE9qzBT41aIjApC9875ge6DxkBOAklj4AwrcOUHn1hmSoP+3pLCAX6YpZqq77FoD1ja90MS3DMFMo6l0M2MHAgFMNtD3gz8SJkqJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Fz1fsoOy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hROqjKVP; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Fz1fsoOy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hROqjKVP"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E4C5C14001AA;
	Mon, 23 Feb 2026 07:00:14 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 23 Feb 2026 07:00:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771848014;
	 x=1771934414; bh=IJc+lFg1RvLdmBmPLx0OpSaBu2d2ul/x7t6E3djzxb8=; b=
	Fz1fsoOyqpHvcR1GxF6NvGMrM99lKh+IQ3J8MHnhvf9VCkxyK9KQD/OQpe4B84dK
	Hb1NoXj2H+mlqiK/OL7iL3JtYsaeCnWpmYA2bj9JCIH5C3k/EHl/bquG99o4P+jM
	O0AGdayBTvU5NSA2OmSEvuegSLg4IQ+7VDeHZi1hxRVtcTx5tw2ISzALhwsYU6Ed
	Iy5OKfJhxonZCTj5yOZE/KaFhS74rDE96Be2UK32uuBq7DmIk1nGg/DBGI3SIGyK
	XxX8RU+hPfWgb/29K1tvDOq2isGEyzuLWa5O37+iKUY8KAy+RuzrPCn0IuvYKPAh
	ubBs3WuoUxNTG3xCQQ0sKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771848014; x=
	1771934414; bh=IJc+lFg1RvLdmBmPLx0OpSaBu2d2ul/x7t6E3djzxb8=; b=h
	ROqjKVP2SdqkNw8QRoF5ANxO0Z05O92b1EqBhL9EoardTBH1+8+YKCcxYAGrtyQK
	YAfjB4MzcB0/ECiVrSXWF0XJYami2oYMTU2i+t2N9B0R1etz1V7zNpjADJl0dM50
	UCTskF+E5pBxvjkGSM24xqtaxB3L/8bHNeVWxNmSguP1tZj8p4gSVxCQoIuGvRqw
	tvH6V+ScLviiKFsFyeD6R7AgejYecdRs9X9RYg+kH0+/LmsOUgJ/mK+AB4DVx2a0
	yIsUCEQD/gZIgKBgi4OkViuK1kXwj2KVPAPSEFWBav/bpkGrydee7uUBVbvvkkcl
	2vyW7wZUk0FCxU2Zr6bGA==
X-ME-Sender: <xms:TkGcaerIdtDqUNOpr8BrAQvKlBUA66EMxGXT2wFE7bYvQdpQHObLfg>
    <xme:TkGcaUG_n1DYo9oHGNmNK_v_YaNV6dzvWNw_T_zx6BbeESyODKE5W0Rq5hTYRvghc
    53PagWO4QWSoWCBIXmMA4f4IYPynfjz_nWIDHeGh8CTHn0n9a4kow>
X-ME-Received: <xmr:TkGcaQndQryynUoigDAl1rsvnXm_wAWcS8xtZ8-R0oUg3Ho9AZahQ8NjR7VjbnbqzGfXQ8ePhrPOciTBWE7U2bigjtXLgSVEsT6xXzJeIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhsfigrlh
    gurdgsuhguuggvnhhhrghgvghnsehgmhigrdguvgdprhgtphhtthhopehkrghrthhhihhk
    rddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:TkGcaXm2JLY-nSOeJ3FzUycQUCIL8xUVyiroAVaelffPdI0sWEKiiw>
    <xmx:TkGcaRvjfxnEnwNyATSh7gv6hd0q01Ccilx5x0x5P8JapAnFLQFBpg>
    <xmx:TkGcaal185J4-Ad1eumFk1qXn8FMWsGaScfvVuXTH4IzCZ4KZaGoKQ>
    <xmx:TkGcacv4_cDkNo-IoJhr8r8PzTE02Pis2i_TCeqYjE9fGR98uuKSgw>
    <xmx:TkGcaak9FSwdDi5_t5mj6fEGiqdBGvgZWWq0OGO4YloRGAUskQaQHWqj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 07:00:14 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6e7211a6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Feb 2026 12:00:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 23 Feb 2026 12:59:46 +0100
Subject: [PATCH v2 12/17] refs: replace `refs_for_each_rawref()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-pks-refs-for-each-unification-v2-12-515d48c8087b@pks.im>
References: <20260223-pks-refs-for-each-unification-v2-0-515d48c8087b@pks.im>
In-Reply-To: <20260223-pks-refs-for-each-unification-v2-0-515d48c8087b@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
X-Mailer: b4 0.14.3

Replace calls to `refs_for_each_rawref()` with the newly introduced
`refs_for_each_ref_ext()` function.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/describe.c   |  7 +++++--
 builtin/fsck.c       |  7 +++++--
 fetch-pack.c         | 15 +++++++++++----
 refs.c               | 10 ++++------
 refs.h               |  1 -
 refs/files-backend.c |  7 +++++--
 6 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index abfe3525a5..bffeed13a3 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -641,6 +641,9 @@ int cmd_describe(int argc,
 		 const char *prefix,
 		 struct repository *repo UNUSED )
 {
+	struct refs_for_each_ref_options for_each_ref_opts = {
+		.flags = REFS_FOR_EACH_INCLUDE_BROKEN,
+	};
 	int contains = 0;
 	struct option options[] = {
 		OPT_BOOL(0, "contains",   &contains, N_("find the tag that comes after the commit")),
@@ -738,8 +741,8 @@ int cmd_describe(int argc,
 	}
 
 	hashmap_init(&names, commit_name_neq, NULL, 0);
-	refs_for_each_rawref(get_main_ref_store(the_repository), get_name,
-			     NULL);
+	refs_for_each_ref_ext(get_main_ref_store(the_repository),
+			      get_name, NULL, &for_each_ref_opts);
 	if (!hashmap_get_size(&names) && !always)
 		die(_("No names found, cannot describe anything."));
 
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 0512f78a87..24cdb657f5 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -598,6 +598,9 @@ static int fsck_handle_ref(const struct reference *ref, void *cb_data UNUSED)
 
 static void snapshot_refs(struct snapshot *snap, int argc, const char **argv)
 {
+	struct refs_for_each_ref_options opts = {
+		.flags = REFS_FOR_EACH_INCLUDE_BROKEN,
+	};
 	struct worktree **worktrees, **p;
 	const char *head_points_at;
 	struct object_id head_oid;
@@ -623,8 +626,8 @@ static void snapshot_refs(struct snapshot *snap, int argc, const char **argv)
 		return;
 	}
 
-	refs_for_each_rawref(get_main_ref_store(the_repository),
-			     snapshot_ref, snap);
+	refs_for_each_ref_ext(get_main_ref_store(the_repository),
+			      snapshot_ref, snap, &opts);
 
 	worktrees = get_worktrees();
 	for (p = worktrees; *p; p++) {
diff --git a/fetch-pack.c b/fetch-pack.c
index 40316c9a34..570caa03fa 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -292,11 +292,14 @@ static int next_flush(int stateless_rpc, int count)
 static void mark_tips(struct fetch_negotiator *negotiator,
 		      const struct oid_array *negotiation_tips)
 {
+	struct refs_for_each_ref_options opts = {
+		.flags = REFS_FOR_EACH_INCLUDE_BROKEN,
+	};
 	int i;
 
 	if (!negotiation_tips) {
-		refs_for_each_rawref(get_main_ref_store(the_repository),
-				     rev_list_insert_ref_oid, negotiator);
+		refs_for_each_ref_ext(get_main_ref_store(the_repository),
+				      rev_list_insert_ref_oid, negotiator, &opts);
 		return;
 	}
 
@@ -792,8 +795,12 @@ static void mark_complete_and_common_ref(struct fetch_negotiator *negotiator,
 	 */
 	trace2_region_enter("fetch-pack", "mark_complete_local_refs", NULL);
 	if (!args->deepen) {
-		refs_for_each_rawref(get_main_ref_store(the_repository),
-				     mark_complete_oid, NULL);
+		struct refs_for_each_ref_options opts = {
+			.flags = REFS_FOR_EACH_INCLUDE_BROKEN,
+		};
+
+		refs_for_each_ref_ext(get_main_ref_store(the_repository),
+				      mark_complete_oid, NULL, &opts);
 		for_each_cached_alternate(NULL, mark_alternate_complete);
 		if (cutoff)
 			mark_recent_complete_commits(args, cutoff);
diff --git a/refs.c b/refs.c
index 7b1ef769c0..791654a0f6 100644
--- a/refs.c
+++ b/refs.c
@@ -526,7 +526,10 @@ void refs_warn_dangling_symrefs(struct ref_store *refs, FILE *fp,
 		.indent = indent,
 		.dry_run = dry_run,
 	};
-	refs_for_each_rawref(refs, warn_if_dangling_symref, &data);
+	struct refs_for_each_ref_options opts = {
+		.flags = REFS_FOR_EACH_INCLUDE_BROKEN,
+	};
+	refs_for_each_ref_ext(refs, warn_if_dangling_symref, &data, &opts);
 }
 
 int refs_for_each_tag_ref(struct ref_store *refs, refs_for_each_cb cb, void *cb_data)
@@ -1979,11 +1982,6 @@ int refs_for_each_namespaced_ref(struct ref_store *refs,
 	return refs_for_each_ref_ext(refs, cb, cb_data, &opts);
 }
 
-int refs_for_each_rawref(struct ref_store *refs, refs_for_each_cb fn, void *cb_data)
-{
-	return refs_for_each_rawref_in(refs, "", fn, cb_data);
-}
-
 int refs_for_each_rawref_in(struct ref_store *refs, const char *prefix,
 			    refs_for_each_cb cb, void *cb_data)
 {
diff --git a/refs.h b/refs.h
index 7a3bc9e5b7..01dc3c2fd4 100644
--- a/refs.h
+++ b/refs.h
@@ -543,7 +543,6 @@ int refs_for_each_namespaced_ref(struct ref_store *refs,
 				 refs_for_each_cb fn, void *cb_data);
 
 /* can be used to learn about broken ref and symref */
-int refs_for_each_rawref(struct ref_store *refs, refs_for_each_cb fn, void *cb_data);
 int refs_for_each_rawref_in(struct ref_store *refs, const char *prefix,
 			    refs_for_each_cb fn, void *cb_data);
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 6c98e14414..ab96760781 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3149,6 +3149,9 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
 					    struct ref_transaction *transaction,
 					    struct strbuf *err)
 {
+	struct refs_for_each_ref_options opts = {
+		.flags = REFS_FOR_EACH_INCLUDE_BROKEN,
+	};
 	size_t i;
 	int ret = 0;
 	struct string_list affected_refnames = STRING_LIST_INIT_NODUP;
@@ -3173,8 +3176,8 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
 	 * so here we really only check that none of the references
 	 * that we are creating already exists.
 	 */
-	if (refs_for_each_rawref(&refs->base, ref_present,
-				 &transaction->refnames))
+	if (refs_for_each_ref_ext(&refs->base, ref_present,
+				  &transaction->refnames, &opts))
 		BUG("initial ref transaction called with existing refs");
 
 	packed_transaction = ref_store_transaction_begin(refs->packed_ref_store,

-- 
2.53.0.536.g309c995771.dirty


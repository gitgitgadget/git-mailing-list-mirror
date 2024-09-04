Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C011917DF
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 08:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725439993; cv=none; b=b/Svb7++7gotHgRgocaZVmMoEsQ0Xy3hMWALsHzgqbuB76JxV93fZzNw1qO1KwImvbIUCzEGcXFZ+mcOtq2elfYNsvxPl2HjjbxIDXMNBqH9JhfYzGzzXGlOkfQgyej14YIE+cl/lJ45pNWwMtVw5ahTh23he82MeNejmCE2cm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725439993; c=relaxed/simple;
	bh=NBPR95cniluZlC/PT2+sYuUuyUmACe4HP12keYJZNVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uLsQ3v5qJHrzNYHO9aju5oYKTwGthghfS3hBif1EEu3w0lSKkU9DAWWfG4Y88VabZJRLpVSL6kViiVrrB33hpJ2t+eopw8VFHg2g15Pu10O4Mcy5uT8IadKmBSID24d1d8VvWRkGhSA+o0t6jB50JscFxxVcqo7A5B1JsUvjPTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=U4sO0XkB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qqZh5Tqp; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="U4sO0XkB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qqZh5Tqp"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AF5B61140232;
	Wed,  4 Sep 2024 04:53:10 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 04 Sep 2024 04:53:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725439990; x=1725526390; bh=fhrK0iElhb
	NwhCCSzf99bdeOm0F5kpsnSgt8PjnLY2U=; b=U4sO0XkBCuuXsPy3q0BcxfFnOU
	mFOajIFE8noS5iQKBDlQBWvu7aG+0yIF1C48UiCEGEvs4lbJruGP5FmdySwFBzK/
	grtHNZ55ABHSnSyonkgm121Lnmz2Hleud5gsKmWNjv4PhOY5Wm7xrJh9NRXde7SJ
	W0v9XKCus/BvfYuA4Qr57CtxxtExZERq6G8T0dNyZpmaXZIRzke0BqB9ev7veLYR
	Rw94/obpL9LEMcw4U3ltDNgHMZj8LDMeEnptX7bHNoQJf/7BBlnTRzkfANdr+1JT
	4rBx2jMQoOgNhiSHj0jyCFz9fROgw00jq1F0R3qcfKB/zLVARhr+Glece8tg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725439990; x=1725526390; bh=fhrK0iElhbNwhCCSzf99bdeOm0F5
	kpsnSgt8PjnLY2U=; b=qqZh5TqpoAbTMriHw6kduJm4iEzGFN4u73SyGXAAzEkz
	HB9daUO3pEcBxUfgnqAbE0W7gvv5y+o1Fm+L/ejAOKPDxCWc+5nVjP+NbGxSFsHZ
	MwEfr15/sdtm1WnjFReM+3n0Hh7HuSqUqa8L4WoSVR1+xM57i+WTSDwfJCTyjGyy
	QLeMjHTf1EIvDtcM5cAiTgjVXFKesgrIcmwn+0sNk6Fjfg264+0eHAf17zJ2ryu3
	chXkWCDD5BJpiIymjJ4GrtCVw18sZIMJmSJRIA3tfoyfFhCURx30gP+ManXwpFwu
	RO42PWB0qWAVRBhY+M/WBJS6xQG/9KogMFrpmjYLsQ==
X-ME-Sender: <xms:9h_YZjsMvfF_WXyXoLz6tn8hT1o8kPMI_2aUsUV9wM7wWn6Wg3zZFg>
    <xme:9h_YZkdT1X5edDo_7IMeJ90dgAWPDIrva1_DgHo9PDU78sw2-BOzuLUfsD84cgtUg
    Z4a2rsKnHudDA2RKQ>
X-ME-Received: <xmr:9h_YZmyXeviG4EmzsF-sQhfhAdottrC7b_J9rHzBAMmheDI_pdGFE5kYvhBRiER-CriUcEFy99uRiXrlFNtVuAlvmw-WD2kkHf9HlWYsRt4P>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehjedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhgrrhht
    hhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:9h_YZiPtsHR2-OIqIKVHY3JBQHnP-gpsJ37F09ImEMoAvv76VqGDNA>
    <xmx:9h_YZj8u6tZvICbNsdkX6f-0ep6kQCurNfQPyJrdkJpH1DbTD_IBUQ>
    <xmx:9h_YZiXnPKzcyncdMzUEtF4FWOS_edshyvsJukH-defIs0eLITo4FQ>
    <xmx:9h_YZkc6U6y4XECZ7cf8jB96Z1hEy4vBIJYsJaRjXxWNT1FxxGFRXw>
    <xmx:9h_YZmYsa1DU-ofuA0UJBKLxGCaiEI7jyrFdV_A_DU4ofwHeWElS_SI->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Sep 2024 04:53:09 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2e10de45 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 4 Sep 2024 08:53:00 +0000 (UTC)
Date: Wed, 4 Sep 2024 10:53:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/3] refs/files: use heuristic to decide whether to repack
 with `--auto`
Message-ID: <49f953142b1b20a63102b87a1d96f5bc1f79da82.1725439407.git.ps@pks.im>
References: <cover.1725280479.git.ps@pks.im>
 <cover.1725439407.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725439407.git.ps@pks.im>

The `--auto` flag for git-pack-refs(1) allows the ref backend to decide
whether or not a repack is in order. This switch has been introduced
mostly with the "reftable" backend in mind, which already knows to
auto-compact its tables during normal operations. When the flag is set,
then it will use the same auto-compaction mechanism and thus end up
doing nothing in most cases.

The "files" backend does not have any such heuristic yet and instead
packs any loose references unconditionally. So we rewrite the complete
"packed-refs" file even if there's only a single loose reference to be
packed.

Even worse, starting with 9f6714ab3e (builtin/gc: pack refs when using
`git maintenance run --auto`, 2024-03-25), `git pack-refs --auto` is
unconditionally executed via our auto maintenance, so we end up repacking
references every single time auto maintenance kicks in. And while that
commit already mentioned that the "files" backend unconditionally packs
refs now, the author obviously didn't quite think about the consequences
thereof. So while the idea was sound, we really should have added a
heuristic to the "files" backend before implementing it.

Introduce a heuristic that decides whether or not it is worth to pack
loose references. The important factors to decide here are the number of
loose references in comparison to the overall size of the "packed-refs"
file. The bigger the "packed-refs" file, the longer it takes to rewrite
it and thus we scale up the limit of allowed loose references before we
repack.

As is the nature of heuristics, this mechansim isn't obviously
"correct", but should rather be seen as a tradeoff between how much
resources we spend packing refs and how inefficient the ref store
becomes. For all I can say, we have successfully been using the exact
same heuristic in Gitaly for several years by now.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/files-backend.c          | 65 +++++++++++++++++++++++++++
 refs/packed-backend.c         | 18 ++++++++
 refs/packed-backend.h         |  7 +++
 t/t0601-reffiles-pack-refs.sh | 85 ++++++++++++++++++++++++++++++-----
 4 files changed, 165 insertions(+), 10 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 1cff65f6ae5..51bcd16f821 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1311,6 +1311,68 @@ static int should_pack_ref(struct files_ref_store *refs,
 	return 0;
 }
 
+static int should_pack_refs(struct files_ref_store *refs,
+			    struct pack_refs_opts *opts)
+{
+	struct ref_iterator *iter;
+	size_t packed_size;
+	size_t refcount = 0;
+	size_t limit;
+	int ret;
+
+	if (!(opts->flags & PACK_REFS_AUTO))
+		return 1;
+
+	ret = packed_refs_size(refs->packed_ref_store, &packed_size);
+	if (ret < 0)
+		die("cannot determine packed-refs size");
+
+	/*
+	 * Packing loose references into the packed-refs file scales with the
+	 * number of references we're about to write. We thus decide whether we
+	 * repack refs by weighing the current size of the packed-refs file
+	 * against the number of loose references. This is done such that we do
+	 * not repack too often on repositories with a huge number of
+	 * references, where we can expect a lot of churn in the number of
+	 * references.
+	 *
+	 * As a heuristic, we repack if the number of loose references in the
+	 * repository exceeds `log2(nr_packed_refs) * 5`, where we estimate
+	 * `nr_packed_refs = packed_size / 100`, which scales as following:
+	 *
+	 * - 1kB ~ 10 packed refs: 16 refs
+	 * - 10kB ~ 100 packed refs: 33 refs
+	 * - 100kB ~ 1k packed refs: 49 refs
+	 * - 1MB ~ 10k packed refs: 66 refs
+	 * - 10MB ~ 100k packed refs: 82 refs
+	 * - 100MB ~ 1m packed refs: 99 refs
+	 *
+	 * We thus allow roughly 16 additional loose refs per factor of ten of
+	 * packed refs. This heuristic may be tweaked in the future, but should
+	 * serve as a sufficiently good first iteration.
+	 */
+	limit = log2u(packed_size / 100) * 5;
+	if (limit < 16)
+		limit = 16;
+
+	iter = cache_ref_iterator_begin(get_loose_ref_cache(refs, 0), NULL,
+					refs->base.repo, 0);
+	while ((ret = ref_iterator_advance(iter)) == ITER_OK) {
+		if (should_pack_ref(refs, iter->refname, iter->oid,
+				    iter->flags, opts))
+			refcount++;
+		if (refcount >= limit) {
+			ref_iterator_abort(iter);
+			return 1;
+		}
+	}
+
+	if (ret != ITER_DONE)
+		die("error while iterating over references");
+
+	return 0;
+}
+
 static int files_pack_refs(struct ref_store *ref_store,
 			   struct pack_refs_opts *opts)
 {
@@ -1323,6 +1385,9 @@ static int files_pack_refs(struct ref_store *ref_store,
 	struct strbuf err = STRBUF_INIT;
 	struct ref_transaction *transaction;
 
+	if (!should_pack_refs(refs, opts))
+		return 0;
+
 	transaction = ref_store_transaction_begin(refs->packed_ref_store, &err);
 	if (!transaction)
 		return -1;
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 7a0a695ca2f..07c57fd541a 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1250,6 +1250,24 @@ int packed_refs_is_locked(struct ref_store *ref_store)
 	return is_lock_file_locked(&refs->lock);
 }
 
+int packed_refs_size(struct ref_store *ref_store,
+		     size_t *out)
+{
+	struct packed_ref_store *refs = packed_downcast(ref_store, REF_STORE_READ,
+							"packed_refs_size");
+	struct stat st;
+
+	if (stat(refs->path, &st) < 0) {
+		if (errno != ENOENT)
+			return -1;
+		*out = 0;
+		return 0;
+	}
+
+	*out = st.st_size;
+	return 0;
+}
+
 /*
  * The packed-refs header line that we write out. Perhaps other traits
  * will be added later.
diff --git a/refs/packed-backend.h b/refs/packed-backend.h
index 09437ad13bd..9481d5e7c2e 100644
--- a/refs/packed-backend.h
+++ b/refs/packed-backend.h
@@ -27,6 +27,13 @@ int packed_refs_lock(struct ref_store *ref_store, int flags, struct strbuf *err)
 void packed_refs_unlock(struct ref_store *ref_store);
 int packed_refs_is_locked(struct ref_store *ref_store);
 
+/*
+ * Obtain the size of the `packed-refs` file. Reports `0` as size in case there
+ * is no packed-refs file. Returns 0 on success, negative otherwise.
+ */
+int packed_refs_size(struct ref_store *ref_store,
+		     size_t *out);
+
 /*
  * Return true if `transaction` really needs to be carried out against
  * the specified packed_ref_store, or false if it can be skipped
diff --git a/t/t0601-reffiles-pack-refs.sh b/t/t0601-reffiles-pack-refs.sh
index ed9652bb829..d8cbd3f202b 100755
--- a/t/t0601-reffiles-pack-refs.sh
+++ b/t/t0601-reffiles-pack-refs.sh
@@ -362,21 +362,86 @@ test_expect_success 'pack-refs does not drop broken refs during deletion' '
 
 for command in "git pack-refs --all --auto" "git maintenance run --task=pack-refs --auto"
 do
-	test_expect_success "$command unconditionally packs loose refs" '
+	test_expect_success "$command does not repack below 16 refs without packed-refs" '
 		test_when_finished "rm -rf repo" &&
 		git init repo &&
 		(
 			cd repo &&
 			git config set maintenance.auto false &&
-			test_commit initial &&
-
-			git update-ref refs/heads/something HEAD &&
-			test_path_is_file .git/refs/heads/something &&
-			git rev-parse refs/heads/something >expect &&
-			$command &&
-			test_path_is_missing .git/refs/heads/something &&
-			git rev-parse refs/heads/something >actual &&
-			test_cmp expect actual
+			git commit --allow-empty --message "initial" &&
+
+			# Create 14 additional references, which brings us to
+			# 15 together with the default branch.
+			printf "create refs/heads/loose-%d HEAD\n" $(test_seq 14) >stdin &&
+			git update-ref --stdin <stdin &&
+			test_path_is_missing .git/packed-refs &&
+			git pack-refs --auto --all &&
+			test_path_is_missing .git/packed-refs &&
+
+			# Create the 16th reference, which should cause us to repack.
+			git update-ref refs/heads/loose-15 HEAD &&
+			git pack-refs --auto --all &&
+			test_path_is_file .git/packed-refs
+		)
+	'
+
+	test_expect_success "$command does not repack below 16 refs with small packed-refs" '
+		test_when_finished "rm -rf repo" &&
+		git init repo &&
+		(
+			cd repo &&
+			git config set maintenance.auto false &&
+			git commit --allow-empty --message "initial" &&
+
+			git pack-refs --all &&
+			test_line_count = 2 .git/packed-refs &&
+
+			# Create 15 loose references.
+			printf "create refs/heads/loose-%d HEAD\n" $(test_seq 15) >stdin &&
+			git update-ref --stdin <stdin &&
+			git pack-refs --auto --all &&
+			test_line_count = 2 .git/packed-refs &&
+
+			# Create the 16th loose reference, which should cause us to repack.
+			git update-ref refs/heads/loose-17 HEAD &&
+			git pack-refs --auto --all &&
+			test_line_count = 18 .git/packed-refs
+		)
+	'
+
+	test_expect_success "$command scales with size of packed-refs" '
+		test_when_finished "rm -rf repo" &&
+		git init repo &&
+		(
+			cd repo &&
+			git config set maintenance.auto false &&
+			git commit --allow-empty --message "initial" &&
+
+			# Create 99 packed refs. This should cause the heuristic
+			# to require more than the minimum amount of loose refs.
+			test_seq 99 |
+			while read i
+			do
+				printf "create refs/heads/packed-%d HEAD\n" $i || return 1
+			done >stdin &&
+			git update-ref --stdin <stdin &&
+			git pack-refs --all &&
+			test_line_count = 101 .git/packed-refs &&
+
+			# Create 24 loose refs, which should not yet cause us to repack.
+			printf "create refs/heads/loose-%d HEAD\n" $(test_seq 24) >stdin &&
+			git update-ref --stdin <stdin &&
+			git pack-refs --auto --all &&
+			test_line_count = 101 .git/packed-refs &&
+
+			# Create another handful of refs to cross the border.
+			# Note that we explicitly do not check for strict
+			# boundaries here, as this also depends on the size of
+			# the object hash.
+			printf "create refs/heads/addn-%d HEAD\n" $(test_seq 10) >stdin &&
+			git update-ref --stdin <stdin &&
+			git pack-refs --auto --all &&
+			test_line_count = 135 .git/packed-refs
 		)
 	'
 done
-- 
2.46.0.519.g2e7b89e038.dirty


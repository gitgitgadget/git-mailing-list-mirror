Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826E718026
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 13:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722863282; cv=none; b=fICY67qCCseqfBNFU/e/Fsfh4twEZhx+qrhunce7iwutyowUeL71mkhed6TPNexdAZvGE+ujj0ADqb21tQ1kZ+OpIwOQUTq+83cLuphfd4xQfR4QJzSZDgnNHU5CiYXfnQhAgO2hQyGD4H9VeiHDBM8LFStTL+nNRHct9vJXwzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722863282; c=relaxed/simple;
	bh=8jMKZE9hxTjupKXxZzcGKPL2tThZORtqEHHQtd1fu+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VHhUl3dV67c7VVKFPLgIhN2zCYvT0XfwzyZ+/fyAL5mO6VkcDIeUlN+tEQll2PcHjzEKraNdiV5fhT5t3aUmt5GwXoX05lB8oaNl6bl5fcYDSjs14igLOxlavrM0ESJ/ZZpGpQNRuCd8mitS/MSNypJ0GCwNvh13xxSo8XgO/8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=k+IWnkmm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XKshQe/f; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="k+IWnkmm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XKshQe/f"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id A1F181151B3A;
	Mon,  5 Aug 2024 09:07:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 05 Aug 2024 09:07:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722863279; x=1722949679; bh=CPCDINA6iX
	Bp0WKVkmowxYemInt8WcxhsrBxbDkilJ4=; b=k+IWnkmmfPywAiE8uzFw3WMOta
	KsuL/DJl9xTh87QGoNsisNRsOyXGMGp+bqkd+p33IqzHdttiyFXO8unC1QypE33r
	7x2T2iyeFVb3d0MXKMmfzw3tQ682wFDc7lHh8IPz17PcuWtY7RBiuNJb05u2XnHY
	XrPFHUlmiYLdPvMrNNqCR2dF76pNQbsqzs7vuXX/lFr/7AMjqrnuNmufo8YtBycB
	UxRg12byR5NWGWQweztZnMQTzPrDYjc/OLoICn1bz1VZG+FE9CazdZeICm61ONBA
	93ISdtZ3y9yqQXHWnlGTK/LnCDpsrm4MgZtYtSryH3MfkkGMByrld26sTY/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722863279; x=1722949679; bh=CPCDINA6iXBp0WKVkmowxYemInt8
	WcxhsrBxbDkilJ4=; b=XKshQe/fPyZg1kqRwK+ccFvRlyRPWHz/d1GKHVJYkMwV
	Ru8aYpnFI/1evxci+8WpKgEqGIy17xQrs3ntoaTEZFFlnlF9owH1oTT6qb2s3PsF
	RdpIX8zd/FtyC8AVDZNu6TnDQZ1JHt35v4zaJFv/wl1f3ymZuNWswMJbUJoPyGNt
	bz9BfIIwHjTGtzqQ8tjlMXYsBB0l+UpO3aq0i948KQvF7zVTB484G5vdORsZlxBS
	C3lY2KtlyChyjrTXmaBWHorWV134Tami/5KW7Tivym23ilwiS8Lcauuv603gYAdT
	XJzw8HcC3gDH1+3SqShDmT2FnDn26SURRVQxcLWPjg==
X-ME-Sender: <xms:r86wZupCyMC8DmL4ocld3Rphkv0wjkZcW_N9VOuBY9I0CSj_yxmcEA>
    <xme:r86wZsrVEOWYmawkT-TASJgkreYwQHgrTUndSux8uw6DDxVi25NvbwTioeGqCp9Hh
    4r6WlDTDtIj_AFITQ>
X-ME-Received: <xmr:r86wZjPb1uEmwv2AD-wXwaXxfqfJX98AlEgVfN-dkaW-csUgD0_0_f94RyozbID4_ftnsHeD0apdYPcTbFGm0huV3BpDisXZxWbNWD-cLQP2G7XNFA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeigdeiudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:r86wZt6SUsMxuO5UvQJtJ8OYKQkCME4uE2JNEujTN0cjihdEBrdyYQ>
    <xmx:r86wZt7AB3_uoZpIpp0YfveaACxn5yAoTFDoF2mahi0ptSbdESbqrg>
    <xmx:r86wZtguI9-J-yEJuaa7B0iEUn1MVCG9V9MwO-svtKoVE90HgSPMXA>
    <xmx:r86wZn6Tzo9M9V8LPewTh-kQbvAM2SV-U74ZdKj1_sKPSbVhRclHJw>
    <xmx:r86wZnmXgXD72Gi0jR2EQtnrnZ6U6t8fsOUadRBrZmn-WwG91CTm0E8p>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Aug 2024 09:07:58 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 16416d7e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 5 Aug 2024 13:07:57 +0000 (UTC)
Date: Mon, 5 Aug 2024 15:07:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/9] reftable/stack: test compaction with already-locked
 tables
Message-ID: <63e64c8d82783b5d3fc8db189a29d69c844f5465.1722862822.git.ps@pks.im>
References: <cover.1722435214.git.ps@pks.im>
 <cover.1722862822.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/4gcpVKdr2Q7po5P"
Content-Disposition: inline
In-Reply-To: <cover.1722862822.git.ps@pks.im>


--/4gcpVKdr2Q7po5P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We're lacking test coverage for compacting tables when some of the
tables that we are about to compact are locked. Add two tests that
exercise this, one for auto-compaction and one for full compaction.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack_test.c | 77 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index 61dddf7f69..46d376026b 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -887,6 +887,45 @@ static void test_reftable_stack_auto_compaction(void)
 	clear_dir(dir);
 }
=20
+static void test_reftable_stack_auto_compaction_with_locked_tables(void)
+{
+	struct reftable_write_options opts =3D {
+		.disable_auto_compact =3D 1,
+	};
+	struct reftable_stack *st =3D NULL;
+	struct strbuf buf =3D STRBUF_INIT;
+	char *dir =3D get_tmp_dir(__LINE__);
+	int err;
+
+	err =3D reftable_new_stack(&st, dir, &opts);
+	EXPECT_ERR(err);
+
+	write_n_ref_tables(st, &opts, 5);
+	EXPECT(st->merged->stack_len =3D=3D 5);
+
+	/*
+	 * Given that all tables we have written should be roughly the same
+	 * size, we expect that auto-compaction will want to compact all of the
+	 * tables. Locking any of the tables will keep it from doing so.
+	 */
+	strbuf_reset(&buf);
+	strbuf_addf(&buf, "%s/%s.lock", dir, st->readers[2]->name);
+	write_file_buf(buf.buf, "", 0);
+
+	/*
+	 * Ideally, we'd handle the situation where any of the tables is locked
+	 * gracefully. We don't (yet) do this though and thus fail.
+	 */
+	err =3D reftable_stack_auto_compact(st);
+	EXPECT(err =3D=3D REFTABLE_LOCK_ERROR);
+	EXPECT(st->stats.failures =3D=3D 1);
+	EXPECT(st->merged->stack_len =3D=3D 5);
+
+	reftable_stack_destroy(st);
+	strbuf_release(&buf);
+	clear_dir(dir);
+}
+
 static void test_reftable_stack_add_performs_auto_compaction(void)
 {
 	struct reftable_write_options opts =3D { 0 };
@@ -935,6 +974,42 @@ static void test_reftable_stack_add_performs_auto_comp=
action(void)
 	clear_dir(dir);
 }
=20
+static void test_reftable_stack_compaction_with_locked_tables(void)
+{
+	struct reftable_write_options opts =3D {
+		.disable_auto_compact =3D 1,
+	};
+	struct reftable_stack *st =3D NULL;
+	struct strbuf buf =3D STRBUF_INIT;
+	char *dir =3D get_tmp_dir(__LINE__);
+	int err;
+
+	err =3D reftable_new_stack(&st, dir, &opts);
+	EXPECT_ERR(err);
+
+	write_n_ref_tables(st, &opts, 3);
+	EXPECT(st->merged->stack_len =3D=3D 3);
+
+	/* Lock one of the tables that we're about to compact. */
+	strbuf_reset(&buf);
+	strbuf_addf(&buf, "%s/%s.lock", dir, st->readers[1]->name);
+	write_file_buf(buf.buf, "", 0);
+
+	/*
+	 * Compaction is expected to fail given that we were not able to
+	 * compact all tables.
+	 */
+	err =3D reftable_stack_compact_all(st, NULL);
+	EXPECT(err =3D=3D REFTABLE_LOCK_ERROR);
+	/* TODO: this is wrong, we should get notified about the failure. */
+	EXPECT(st->stats.failures =3D=3D 0);
+	EXPECT(st->merged->stack_len =3D=3D 3);
+
+	reftable_stack_destroy(st);
+	strbuf_release(&buf);
+	clear_dir(dir);
+}
+
 static void test_reftable_stack_compaction_concurrent(void)
 {
 	struct reftable_write_options opts =3D { 0 };
@@ -1012,9 +1087,11 @@ int stack_test_main(int argc, const char *argv[])
 	RUN_TEST(test_reftable_stack_add);
 	RUN_TEST(test_reftable_stack_add_one);
 	RUN_TEST(test_reftable_stack_auto_compaction);
+	RUN_TEST(test_reftable_stack_auto_compaction_with_locked_tables);
 	RUN_TEST(test_reftable_stack_add_performs_auto_compaction);
 	RUN_TEST(test_reftable_stack_compaction_concurrent);
 	RUN_TEST(test_reftable_stack_compaction_concurrent_clean);
+	RUN_TEST(test_reftable_stack_compaction_with_locked_tables);
 	RUN_TEST(test_reftable_stack_hash_id);
 	RUN_TEST(test_reftable_stack_lock_failure);
 	RUN_TEST(test_reftable_stack_log_normalize);
--=20
2.46.0.dirty


--/4gcpVKdr2Q7po5P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmawzqsACgkQVbJhu7ck
PpSgmhAAg/DIAVlT/z0oj85BB5tNjES3YsySzRNAno13Hrao2VnH+UuYQnug5DyY
vGCFLYwJ4fEbJg2ryVTPac56NiQs+pLzKt2BjoyA3fQ6o9+JzG5C5n7zZVNvPY4P
w9VuGcVZyr1wZ2z2BZ33XyB9hubq3i1Cj1p4szG31M5rEoasX+BYViWHkig7QI4D
/Hk0Oo8dlusP0wnlzHVQwlsNKVPokr+8pGY5D2J7GEmriHbZqzDdTY0z8lujqlrE
6YS8xSnAPOry+Z16McyVItxrHC8fu0mPqZDWwLYoieZHPq7tufYOVIsfzayGHkEF
mwbvZ2w7ukg7xmZ3378VC+mNPxhN9ZNBgtPRqnbaIJcc/tnkvTnXL1Vg1GZp9RPK
29DAjs9Fh6LFMImJmTTjmDKihkSJhakiEWX05Ovu29yDfKwb0kU2N7NAJSsJc6t5
L9sTRFoOxHihvgTRE97i4+9oKL+ksdEJd/KIMzA6prixiVMs4Zzie7o3J/Y0/Egv
WQCe/iHDjOZA9QcL1/jLhvDNCNWX+1N1ssRiZQA1lOkWFDrRQNhy/Vr81h7posBN
1oQllr66NQj9qpYhOXTyMPmfGvZgmhpVCdHzJH+PkAc4xYwq4Qi0ye3D84B88eV1
C2iSTuaDTBn7uk9k2y8KyV2Lqcl61RDGSxydtg2RIbDcPaYGpo8=
=cwle
-----END PGP SIGNATURE-----

--/4gcpVKdr2Q7po5P--

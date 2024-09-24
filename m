Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A600126BF2
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 06:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727159574; cv=none; b=J+JT0jVN7FfnXWU2D0Wg7UQRgRNtFuEsul9nkhVMnre8AK3L5v9VbJSjUavPVgETgeEfuq1S2HvNxGuwNXZFVhLikF1NNi4TJ4F3QYhUpjzKsJfs29Or55RxMG/Gude7ZBl9Pj7POuLuIp+DsPkkFfBslmBGEiN+ef25ILdSNQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727159574; c=relaxed/simple;
	bh=jqxDxBdtF/MUr7qAqPQKFNTAmC5BK2/hdncYmQUQPS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVdgIzbcVQTjamEd9YXaPGb0z1owZEuIOjG4h71tPQk0ml0iZnuZYJ5Zg/jDaZSEL+bUWMnc6Ja5DB+wVAeuAx80CnoPFZg13tpyqlgRwCdGAOIn0d+QYBQIf3sa1EIpffrR574XihZZxiuFyaxgMhDi1ClOUPQdiNilJsMilho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ktSRsAil; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jje8Y+oM; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ktSRsAil";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jje8Y+oM"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8EBF01140311;
	Tue, 24 Sep 2024 02:32:52 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 24 Sep 2024 02:32:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727159572; x=1727245972; bh=ZXepxEPasu
	+zIa5pJ4rbvbb2TObjFBTvTyfPJyD/+hQ=; b=ktSRsAilbWigaOrJN7a5chd3/n
	t+iqvgPUor0ENnjZLRIT0HSIUAfzVrDSfMIFYEi8gNchiG9l1coPXDjpd6BwUFJa
	xE/38nPzCYBMNb1MuIyahRQr+uM9rf3PrUihe3Lrd6xj896obXlQoxfONbyltfqA
	LbXFL60tGQ1DcTSMwLDrpq8pduBXq6B5eb95XoNib9tR1Ujy5CRasmbFX48nn9Vh
	XwLPt3x328I/7S4WoMQy5S5ml1Cma9qiDAbGBG27RPeFrXK44QFf0ezFLUuDgsGT
	2EAgg0fQd38ZduT5hzYauCUvsBwx/gdFFU0utpaAxKgJlx3qaJKJq3k3ZFyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727159572; x=1727245972; bh=ZXepxEPasu+zIa5pJ4rbvbb2TObj
	FBTvTyfPJyD/+hQ=; b=Jje8Y+oMZKddjHeF6cD+MpLbXImY0uCrQWO/bu+0Ge6K
	l0M3Y8iVmiroodfIS3jAdCnkQ23gWs2PVQALoKeYfrvnyIIdTMOD4y3k6j5t2pbA
	7WJIKwKGh2Wo31itWPAAS0A9ivYtZfo9wE9Vz7PunCu7/AZCR+iwlj/qqUjvNlN2
	H/R5Ws9v2iCF1ruPPCJx+aSqsgEDscXa/j5pHzWjKaXBbh1RdZdAzvO3m2srYzLV
	NjxUEWHwy9dPprEDw7fmZK116nv9MKlvrXkRnFZkqBMYU0TxDN3ZEcY/dS6eSFAO
	F5JeG2ZpbnCRUpYJ0Pg5m6IsBhZe9OraG9UHJum6zQ==
X-ME-Sender: <xms:FF3yZnSgc2K4khz6mI0IbPGvoKzvd23BjNTU7kA3U4aeK4ih6jjzFQ>
    <xme:FF3yZoylSZgbjjNq2o83NFNuvxjMPxufWQM8duApueyWHADECsvfxoHhyHnKsYVLC
    YirKCzCXimIqeSs4g>
X-ME-Received: <xmr:FF3yZs2ch_7fROwk-2KMvQloOUEpHq0YKsl9xS1PscvvTZcAdVI8gYF5yM4cVphIIsAEqMNIj1YX0GvuPwNRfqwEPCwthIFwnHGHGhV4mLWyMQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtuddgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsoh
    hnrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:FF3yZnBdfc68Jyx0zAzJ2vUrkq2hczQHdWgiZzi1WsxJLq1WXS0TXQ>
    <xmx:FF3yZggt1wy9iGDZ7ocfq5ZA-XIXl-CHR57T3113lGckC86Xy98tSw>
    <xmx:FF3yZrr4Wb64rrjjeOeuuqat22rC1wXvNQ_QuoI2vGEslVAFp01y0A>
    <xmx:FF3yZriU2-sNTAJXxGHvR1J7i1QHfRBsIcO7lKjfHjD6oFOG46UiNA>
    <xmx:FF3yZpv7nsmmAfciR1rtqG647MMnOOagl8D22vsKjipuw6Dpi5SfUKgU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Sep 2024 02:32:51 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a52c6e57 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Sep 2024 06:32:18 +0000 (UTC)
Date: Tue, 24 Sep 2024 08:32:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 17/22] reftable/iter: handle allocation failures when
 creating indexed table iter
Message-ID: <271839a62609b00c2f6d572ca8d5bf135d54c5dd.1727158127.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <cover.1727158127.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727158127.git.ps@pks.im>

Handle allocation failures in `new_indexed_table_ref_iter()`. While at
it, rename the function to match our coding style.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/iter.c   | 20 ++++++++++++++++----
 reftable/iter.h   |  2 +-
 reftable/reader.c |  7 ++++++-
 3 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/reftable/iter.c b/reftable/iter.c
index 416a9f6996b..d319538f804 100644
--- a/reftable/iter.c
+++ b/reftable/iter.c
@@ -181,14 +181,20 @@ static int indexed_table_ref_iter_next(void *p, struct reftable_record *rec)
 	}
 }
 
-int new_indexed_table_ref_iter(struct indexed_table_ref_iter **dest,
+int indexed_table_ref_iter_new(struct indexed_table_ref_iter **dest,
 			       struct reftable_reader *r, uint8_t *oid,
 			       int oid_len, uint64_t *offsets, int offset_len)
 {
 	struct indexed_table_ref_iter empty = INDEXED_TABLE_REF_ITER_INIT;
-	struct indexed_table_ref_iter *itr = reftable_calloc(1, sizeof(*itr));
+	struct indexed_table_ref_iter *itr;
 	int err = 0;
 
+	itr = reftable_calloc(1, sizeof(*itr));
+	if (!itr) {
+		err = REFTABLE_OUT_OF_MEMORY_ERROR;
+		goto out;
+	}
+
 	*itr = empty;
 	itr->r = r;
 	strbuf_add(&itr->oid, oid, oid_len);
@@ -197,10 +203,16 @@ int new_indexed_table_ref_iter(struct indexed_table_ref_iter **dest,
 	itr->offset_len = offset_len;
 
 	err = indexed_table_ref_iter_next_block(itr);
+	if (err < 0)
+		goto out;
+
+	*dest = itr;
+	err = 0;
+
+out:
 	if (err < 0) {
+		*dest = NULL;
 		reftable_free(itr);
-	} else {
-		*dest = itr;
 	}
 	return err;
 }
diff --git a/reftable/iter.h b/reftable/iter.h
index befc4597df1..b3225bc7add 100644
--- a/reftable/iter.h
+++ b/reftable/iter.h
@@ -82,7 +82,7 @@ void iterator_from_indexed_table_ref_iter(struct reftable_iterator *it,
 					  struct indexed_table_ref_iter *itr);
 
 /* Takes ownership of `offsets` */
-int new_indexed_table_ref_iter(struct indexed_table_ref_iter **dest,
+int indexed_table_ref_iter_new(struct indexed_table_ref_iter **dest,
 			       struct reftable_reader *r, uint8_t *oid,
 			       int oid_len, uint64_t *offsets, int offset_len);
 
diff --git a/reftable/reader.c b/reftable/reader.c
index f696e992dfc..0179e4e73dd 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -715,7 +715,7 @@ static int reftable_reader_refs_for_indexed(struct reftable_reader *r,
 		goto done;
 	}
 
-	err = new_indexed_table_ref_iter(&itr, r, oid, hash_size(r->hash_id),
+	err = indexed_table_ref_iter_new(&itr, r, oid, hash_size(r->hash_id),
 					 got.u.obj.offsets,
 					 got.u.obj.offset_len);
 	if (err < 0)
@@ -740,6 +740,11 @@ static int reftable_reader_refs_for_unindexed(struct reftable_reader *r,
 	int err;
 
 	REFTABLE_ALLOC_ARRAY(ti, 1);
+	if (!ti) {
+		err = REFTABLE_OUT_OF_MEMORY_ERROR;
+		goto out;
+	}
+
 	table_iter_init(ti, r);
 	err = table_iter_seek_start(ti, BLOCK_TYPE_REF, 0);
 	if (err < 0)
-- 
2.46.0.551.gc5ee8f2d1c.dirty


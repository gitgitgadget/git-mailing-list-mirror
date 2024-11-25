Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AD8188724
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 07:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732520328; cv=none; b=gcm85q9zVjxAqW+tCIXPzC3jmBFh9F8PxjODbmuispqNiPgeYhcAiLTmfMa5MlhwedR5EEefHr/T0ztRgegouCoj8UWGXGGNv3E37YjnPeKA/8lkEYjOukDgJJSbCNw+etcuJYBoLSaoejDJGMrzz9ZN8phddOD/9hxs92KEupw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732520328; c=relaxed/simple;
	bh=dzTZYbdXfJGgPC2+q9cfMPJ2sp3jfoAoXkQFEecljJ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C6h8IpJ4YNtv2Tr3PPPCWw1Gje/yXz9rAdkfjGXKZrFbr5K1hfpi23SiboocZ0FqLbNDalSH0xzixoW4gft65j0hdo2qAv+fiGtwLfZJ8XyQ84k2qmsr8/eQYAHB2DozlXQv8B1ALyHeeXg393cLeUP7Uf50X0ak7OgtecngAOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ctGDTrMi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OlO2vDIJ; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ctGDTrMi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OlO2vDIJ"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 792022540118;
	Mon, 25 Nov 2024 02:38:46 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 25 Nov 2024 02:38:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732520326;
	 x=1732606726; bh=qqxcr8+HTD+Uw1FqkzOn5QuDehXNhSEgv282g9j9V3g=; b=
	ctGDTrMijuGzP66W+D6t9rdhWjtfdK8RDCVy6Etg1w4DYr/VQ92L5Bay9VcADXqL
	CnKp3BMnPBEv8IyLy4wCL9pkHgcOecxKyzF9ITOV26Hn4NuBfibUvmegFhaRwlNc
	2fm6sjeLsdr9+xpIsxtrVD9EuZ/lsxAdhMRz0OvAcy35kirwzeXNwshm/0TkmqwT
	N/2Rwj+NGyKLeL+HMs7UNacPRZCXZ/ru2ogSEVIHgAFzYB24bRc+E8M5kGlQxGzU
	M5ARNSKcFwCYfODchgwtFT+ln1UC0/O69WphPeqtS4rY6ippNadLIgNvViytNEPP
	jm9mZUDBRoZmjTejPW5VvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732520326; x=
	1732606726; bh=qqxcr8+HTD+Uw1FqkzOn5QuDehXNhSEgv282g9j9V3g=; b=O
	lO2vDIJlvcJiKjQTeFXIZnDVwJge7RuT30VRmE7BheNQ0/QObDJi/aOAj8Looow3
	ONAsJrYEafwDiTPsepMBtHqFwRoZXTbJwNKCV3STtDBsy3nbpaliGlaj4UZ3F/F5
	I3dG5bAUkeHE4ZTNPLMQeBarKatMFc3IEyr6twpX6g6a9VNi4Pb81KluRpIMMM3k
	b4UCGJAwsfMgZOcEUFityb0Bx6H91vsCRqkqhGfpZah6SqONoOZYGfY6Gaj2pZ0n
	ZOf5Zim2azT6kdThzS4qaPe2yOBNcXv44GODS7YVyew4Rw3EkwIKyGzJwvYmj7Sh
	04XGfUnivrMqhVWwEaHGQ==
X-ME-Sender: <xms:hilEZ9r1MY5Rcv7n5sIJALliFiCcCw3bghy9GZHS24gVcMJDO5dBtA>
    <xme:hilEZ_qlFWcoDTaUJxaKnHsLYcjadu_a20JWFqc2ANW8bb7Cp75lkBERGzToSeblI
    lD50p4yvDN_yz6OkQ>
X-ME-Received: <xmr:hilEZ6OfLh2evu8g6r3R_m0JUPnZQiQu7YWCKtoLNo9Lsx9_H5N9HUFmBlFPq5lwRgClCrhSOHQ9LPNfLb_GDTzjpipI2sAnCKfsI-2CdMLS0Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeggddutdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:hilEZ47WbRkJV1Db-5CiUP4sQeD2eXnQrdVOhVx4ng4inrDFtbH8dQ>
    <xmx:hilEZ86ys62PFPvQXb6xg3a2iiNEzZkkUI5N21IonFaR0Zybz0VFRQ>
    <xmx:hilEZwjS9mIJspbNT5y_LackKRoZdL3rUyj9tR4j0RLCFkElquyPyw>
    <xmx:hilEZ-4uyOXLeNWHM2zBdfQgjWCh_jxLIbjxj3v2FUZq_DO4GgZF5g>
    <xmx:hilEZ6lwFEcU8lS2IVIyfWECcZLdTPX6i4opWKizmWugteYS7Bj2FmKQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 02:38:45 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 01a4f567 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Nov 2024 07:37:41 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 25 Nov 2024 08:38:27 +0100
Subject: [PATCH v3 5/9] refs/reftable: refactor reading symbolic refs to
 use reftable backend
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-pks-reftable-backend-reuse-iter-v3-5-1d7b658e3e9e@pks.im>
References: <20241125-pks-reftable-backend-reuse-iter-v3-0-1d7b658e3e9e@pks.im>
In-Reply-To: <20241125-pks-reftable-backend-reuse-iter-v3-0-1d7b658e3e9e@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Refactor the callback function that reads symbolic references in the
reftable backend to use `reftable_backend_read_ref()` instead of
accessing the reftable stack directly. This ensures that the function
will benefit from the new caching layer that we're about to introduce.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/reftable-backend.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 5933c561f5c422d12b616514ed76b75c52a13477..498bc9f932673e6089bd3b27e1bb7ed8d0e36a4c 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -884,21 +884,18 @@ static int reftable_be_read_symbolic_ref(struct ref_store *ref_store,
 {
 	struct reftable_ref_store *refs =
 		reftable_be_downcast(ref_store, REF_STORE_READ, "read_symbolic_ref");
-	struct reftable_ref_record ref = {0};
 	struct reftable_backend *be;
+	struct object_id oid;
+	unsigned int type = 0;
 	int ret;
 
 	ret = backend_for(&be, refs, refname, &refname, 1);
 	if (ret)
 		return ret;
 
-	ret = reftable_stack_read_ref(be->stack, refname, &ref);
-	if (ret == 0 && ref.value_type == REFTABLE_REF_SYMREF)
-		strbuf_addstr(referent, ref.value.symref);
-	else
+	ret = reftable_backend_read_ref(be, refname, &oid, referent, &type);
+	if (type != REF_ISSYMREF)
 		ret = -1;
-
-	reftable_ref_record_release(&ref);
 	return ret;
 }
 

-- 
2.47.0.274.g962d0b743d.dirty


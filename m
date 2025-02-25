Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7B7260A29
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 08:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740473765; cv=none; b=LsDn53Mppx4ro2W5gQepkfRbEfoWKGkp8saoNcirIP6+6CT4ZLb0dHh0GFRERLGA/ccznF42mLC+WUKgQSlsWjN5cT3IgrsWRMI/czUiyJZNYENBfpF5Fu/Wo05MtvwLo/0rCc4jU1OnUwZmoJV2fm/i7a9F/GcEis8QyJHekVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740473765; c=relaxed/simple;
	bh=FCd5Qbw1UGLzbLIxJBFn421BlWUI5QW4aGPS308dDWY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mTgH7UgWdx93Eah4Z2vrhizrLph3zDrSKB8s+7Zzb/zbkQvXnRYS/RLpq8nUScDUIAYnqqbHYF1/fVP6c0VEP56XDcvBn0zS1gI5+u5dXYC9ZTU9Sff4dG9OGWEx1aANwS+nrmQ/skUvpRUWJw7J+MnWMStbLqLICb8aNdTxf74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kCppiAFR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h9vtIwBd; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kCppiAFR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h9vtIwBd"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 8FC19114017D;
	Tue, 25 Feb 2025 03:56:02 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 25 Feb 2025 03:56:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740473762;
	 x=1740560162; bh=R6067vBTdGDCOOTefe32aHFDIqEnOE2Ruv9Qxwp6r8U=; b=
	kCppiAFRKLSnWa4ylDnvD0siTjE5L8AgSgPGcPqCVu8QBLMYCBh/PHA4Q8GEW3w0
	RuRJDK6sO8F7UbjnOgVD9ulCR1CiX/CgtIUc4Pnatw2y6Q95Dzu0ds/kc/kjJhoP
	54HYS6qepRX3MorNpzoGyqBtjOTkLFx6JiOFLJKZeBWEOIu1JdZujyxHKQhtvmyM
	mKoTQq+tUDJkRnqtUN9SlLDcFLX0zg5QM3jQj8VUbgQEukeTClNfMmgTdfU4Sbts
	kgaMxLsIcKNiIKEhfHB5M24P3O1d2iSBmYiosKESen9xY0m9+r4zCH8DKCjFLr0z
	GXc9eiVuUxVIpATsxx/b9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740473762; x=
	1740560162; bh=R6067vBTdGDCOOTefe32aHFDIqEnOE2Ruv9Qxwp6r8U=; b=h
	9vtIwBdVwBKFJAlvl1VkP9TAPWBBeK1NSIJNqtDSO2Ql+Of0LBl/Cbs1uWnpKSQe
	WB5zixBOLJPw0oW+Hr0MVWJwdRUHzOsyb48Lr3/1k7w9awSTt4q9BR0khU8RDIP0
	J47prGYAFibAuhH+9rPr1E+/V/gxFOWaxqejAdYg2kPvanaNQbcHNpVu1WY6dRNd
	PkJYyX8G1GNoa6/qcvdZlu40jRX1O7GQkiRoDCjKkuRQqiKmv3Jnm2AidSAP5nua
	GWbtDbVI0FEtNur6tR0IGjKwtDXGCrmHbyg/rxeWKd+D6pNINDdC80CsA30bOeZs
	85cwQxAe0Exh2Hkppk3NA==
X-ME-Sender: <xms:ooW9Z9wJ17v2oUkBzscpy-nTReSAwBc_lQMOXbaTVKLD4hsWkJ-TYA>
    <xme:ooW9Z9T2MFSJxvaoQ-P4aANBbOlI-EFmftzEKSN3bffi0l5QE6qEZTaO0ySiRsnq8
    t8uK713q48LYZBa0g>
X-ME-Received: <xmr:ooW9Z3XoazE3hw3qMrPxf37dKW2mYv57-0mhBfWjKRiOtCXG8Hs21rgjlyE3uftTmkk_zK0R6phGAzU6v_xR_77CzP_YvJg9TroqcwW_k6LSIQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekuddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgr
    nhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepkh
    grrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhstgho
    ohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnh
    gvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ooW9Z_iDigQbbvmk-hvvnDaJOsKSjZ7LAaV-XRRB9_2u-_UtcKWnLg>
    <xmx:ooW9Z_DEblajnzxphWt3tILxurQ-DuLH2I3ewuz0plj3WRe0lLxDIg>
    <xmx:ooW9Z4IWQIASuuO-_bDsPNhwLXfsjfianh5bCTQB_qvl7_N1TV-Hmg>
    <xmx:ooW9Z-Dy9x1hFk8xLa2U67aLl21lscVvyoHQVk-RqTXuPMnFAAi_QQ>
    <xmx:ooW9ZxDe1QzWQDmQrvStN0RPSgG6h4X9AyD6WeVfSGgine1lrEbw5s6f>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Feb 2025 03:56:00 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b50450bd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 25 Feb 2025 08:55:57 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 25 Feb 2025 09:55:48 +0100
Subject: [PATCH v3 02/16] object-name: allow skipping ambiguity checks in
 `get_oid()` family
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-pks-update-ref-optimization-v3-2-77c3687cda75@pks.im>
References: <20250225-pks-update-ref-optimization-v3-0-77c3687cda75@pks.im>
In-Reply-To: <20250225-pks-update-ref-optimization-v3-0-77c3687cda75@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 shejialuo <shejialuo@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

When reading an object ID via `get_oid_basic()` or any of its related
functions we perform a check whether the object ID is ambiguous, which
can be the case when a reference with the same name exists. While the
check is generally helpful, there are cases where it only adds to the
runtime overhead without providing much of a benefit.

Add a new flag that allows us to disable the check. The flag will be
used in a subsequent commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 hash.h        | 1 +
 object-name.c | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/hash.h b/hash.h
index 4367acfec50..79419016513 100644
--- a/hash.h
+++ b/hash.h
@@ -204,6 +204,7 @@ struct object_id {
 #define GET_OID_ONLY_TO_DIE    04000
 #define GET_OID_REQUIRE_PATH  010000
 #define GET_OID_HASH_ANY      020000
+#define GET_OID_SKIP_AMBIGUITY_CHECK 040000
 
 #define GET_OID_DISAMBIGUATORS \
 	(GET_OID_COMMIT | GET_OID_COMMITTISH | \
diff --git a/object-name.c b/object-name.c
index 233f3f861e3..85444dbb15b 100644
--- a/object-name.c
+++ b/object-name.c
@@ -961,7 +961,9 @@ static int get_oid_basic(struct repository *r, const char *str, int len,
 	int fatal = !(flags & GET_OID_QUIETLY);
 
 	if (len == r->hash_algo->hexsz && !get_oid_hex(str, oid)) {
-		if (repo_settings_get_warn_ambiguous_refs(r) && warn_on_object_refname_ambiguity) {
+		if (!(flags & GET_OID_SKIP_AMBIGUITY_CHECK) &&
+		    repo_settings_get_warn_ambiguous_refs(r) &&
+		    warn_on_object_refname_ambiguity) {
 			refs_found = repo_dwim_ref(r, str, len, &tmp_oid, &real_ref, 0);
 			if (refs_found > 0) {
 				warning(warn_msg, len, str);

-- 
2.48.1.683.gf705b3209c.dirty


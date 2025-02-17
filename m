Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B986225A48
	for <git@vger.kernel.org>; Mon, 17 Feb 2025 15:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739807430; cv=none; b=dqo2VYaPhTSt4F3+d9XZsS8IvFRQF58bNITbNg4LgnEb0L1f28rtjO1P7JqrZCSi/CO5EKFgZZqagofnWFlbTgl2wCq6O97q04uP7fq3Td6Zh58FQ0iReEpniocdGviwr7S8/7jhH5C3L5v/a9OeVfIm5fcNW/CPHk/AWrti9zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739807430; c=relaxed/simple;
	bh=G2EvjM7vgNw4uXBAPunsAh2IXURPndinaevDpATevek=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lGDCZZH1fcKM9HkwyqN76K+qYLpuFmFs8XNrB5FXgSJwWOsYik1KvYg/0wuC0ExJYzgLBwN+ztPC89CS8vfybyNq3rqwi8Qr+CsjBWLIcd/pKms6SOdWps5hxwTsI/LWEOy+U1KsTvRSt/iWkGAHs9tUk4+oNvWH1o9F3A6x4Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FkbNoZDq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q0VNcATV; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FkbNoZDq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q0VNcATV"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3048F254010E;
	Mon, 17 Feb 2025 10:50:28 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 17 Feb 2025 10:50:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739807428;
	 x=1739893828; bh=p/F5sAqFDMRBYQ5NjN4k9ezzr4FyDN+Cf8ixyfTl+Ls=; b=
	FkbNoZDq6jzfM8qxJt84iQ3zG2Zv+s58vveAwvBblIhv1FAbBNqoyExPkCjOkO1d
	vrdEYVcX1KfW4RhSwZsDG2S1g/6ROy14by1mTh/2w4fDAe63R2OnIdwRiEE4/xap
	bqi4T8Kj++q7mhOsL/UyAnL5EqXWFId3/Ga14zJeRzS31DtSj57IKR/GNTFvfxbC
	XIuI3D8rqA8XcTMU/YqNJJkRG0fNT1VcLlziM1CUlt3AFo4AyKV7V98WT52umoeh
	EPegG4CptztZfaWSmaki2ooHnBRxEZTJjOjgGN9yJk9Q0Dm1lkqkU2H+HLdqiO4N
	DRw4aPhjpE8LmlI0b5pu1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739807428; x=
	1739893828; bh=p/F5sAqFDMRBYQ5NjN4k9ezzr4FyDN+Cf8ixyfTl+Ls=; b=Q
	0VNcATVdYAGRILX3KpK/lb18/frZ2GX1q612g9NkBwIO1oOiBHnx9ut9hXHxXdYX
	GLV4gm/h+Um8Ie+OmlH4XnpwQpUvBMHOwWt+M9SjCcT/1srNNT+ZmohcoUh2wjPQ
	RMwm9Gbl15p902071IpPJOkcdcN3pPkUvUIP3OPOiHtrDrsyGxO9TTRX9cwnW5bY
	3JhmQlCP8MSbsEv/DBqkCLOmFSOkjL/0FOJ8IUEZOl+quXLBv46G+SCcJYqhHjMD
	A9zLyObGK01xRH4eCPDvXdPgOyN8MT/Ra+nfLheCmN15mAn/OPJPNqTrwaTNVEUh
	f0heWs9ZB/MDICPX6xB8A==
X-ME-Sender: <xms:w1qzZ-VF9dT2k78w9Bu34MeG816Z2TS8jT5fScyvBASZbbf6sNc6Dw>
    <xme:w1qzZ6mcTFZLp3MAbzWnSjETyTHPhHenU8ZWiN6TRzBgpWUmkuXnWmeN8r998ciK0
    0V2vpK7PRXCo0padw>
X-ME-Received: <xmr:w1qzZybiioTFt302gLAvc_Jhwzxp9gqrPwPTAwDSeIWERZTva9NiYcvnZ62JpI-y7GuOVCmbg_w9sjHz0i6MVR_SH6Q3XU0S-I_P3W-PO8MQDlY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehkeektdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgr
    nhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepph
    gvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgr
    ihhlrdgtohhmpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidroh
    hrgh
X-ME-Proxy: <xmx:w1qzZ1XaO-owy49w3Dl5fh57SngGr3kE0efK1B1YWnKjTq1y9Li2cQ>
    <xmx:w1qzZ4kYRLqzqU3RkHmtRZ8_sJ1oIhF1DrQYuB2UgnKd77Lg-SM-0A>
    <xmx:w1qzZ6ckPGog4PyUXpqZ4eon4lDDPDsjgPj5UzSbtnL_B7uiFaIYXQ>
    <xmx:w1qzZ6E2G1MmFdMjiYAVU6eSh0FM6RsSIiiAqs2I56G8n851i-N4_g>
    <xmx:xFqzZ2buAzS3YhaTccKSvuB6w7wA6OT7umTlWWIuPSQVb-sdAMwiwojc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Feb 2025 10:50:26 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2edb19b7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 17 Feb 2025 15:50:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 17 Feb 2025 16:50:16 +0100
Subject: [PATCH 02/14] object-name: allow skipping ambiguity checks in
 `get_oid()` family
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-pks-update-ref-optimization-v1-2-a2b6d87a24af@pks.im>
References: <20250217-pks-update-ref-optimization-v1-0-a2b6d87a24af@pks.im>
In-Reply-To: <20250217-pks-update-ref-optimization-v1-0-a2b6d87a24af@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 Christian Couder <chriscool@tuxfamily.org>
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
index 4367acfec50..aeb705d6850 100644
--- a/hash.h
+++ b/hash.h
@@ -204,6 +204,7 @@ struct object_id {
 #define GET_OID_ONLY_TO_DIE    04000
 #define GET_OID_REQUIRE_PATH  010000
 #define GET_OID_HASH_ANY      020000
+#define GET_OID_HASH_SKIP_AMBIGUITY_CHECK 040000
 
 #define GET_OID_DISAMBIGUATORS \
 	(GET_OID_COMMIT | GET_OID_COMMITTISH | \
diff --git a/object-name.c b/object-name.c
index bc0265ad2a1..0b23a65d2ed 100644
--- a/object-name.c
+++ b/object-name.c
@@ -961,7 +961,9 @@ static int get_oid_basic(struct repository *r, const char *str, int len,
 	int fatal = !(flags & GET_OID_QUIETLY);
 
 	if (len == r->hash_algo->hexsz && !get_oid_hex(str, oid)) {
-		if (repo_settings_get_warn_ambiguous_refs(r) && warn_on_object_refname_ambiguity) {
+		if (!(flags & GET_OID_HASH_SKIP_AMBIGUITY_CHECK) &&
+		    repo_settings_get_warn_ambiguous_refs(r) &&
+		    warn_on_object_refname_ambiguity) {
 			refs_found = repo_dwim_ref(r, str, len, &tmp_oid, &real_ref, 0);
 			if (refs_found > 0) {
 				warning(warn_msg, len, str);

-- 
2.48.1.666.gff9fcf71b7.dirty


Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865581E284C
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 13:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739971423; cv=none; b=E0cqUYl30kKas/Rm+SC6uHLODMgYCoRdYgUX2a0KSC3lkeZF0JjCtc1sxgp7Ao0Z0c5xYa8JOPOL8g6YbTBfaNJQ/D2dI4cYoO6WQVtcTp8I3Ix/AtFT4ZkFL2z/p0kCI0cwsOFhUU2tU00+mCa/Ry01eR03PgxjyvVclFSpGMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739971423; c=relaxed/simple;
	bh=Gx/RrPtS7YGqofhGQFsa9AMrgQygwzxvui6lFtcURGE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eGE1bVsL89ikSpTK9Knuh2+gO+yW9K5WxDlUz5kRQZKC6/w9RygVQF5h02kgGUIRfU6i1KRt/PRxJgzClwJPWsDiMc/mLkjvw46RBp58wZ2SO+pZrpU3LDhYcOICJDQITu6VzAymgYgzOALUXH0ThH92sLWLTK89o6EVzFGbfIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PFJRsyZr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oh7pVZVM; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PFJRsyZr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oh7pVZVM"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 71E471140151;
	Wed, 19 Feb 2025 08:23:40 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 19 Feb 2025 08:23:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739971420;
	 x=1740057820; bh=RqThhAR5Bq97zC1cdMpKiv6/QUQ/3+Nrmh5K/rsJOuU=; b=
	PFJRsyZr97vxddo5lQbX74MhBC1fbJR07CkJFr8xSniBS8SVR+bMsx3cA2drxQd5
	menfXp7vgzZpB6MBqO7MXwnjwxGaHoQ6tiZ+h4H11eOtpixcVG89zAs3Rha0NjLV
	T3GqmeM3q59LoJMfAUek842z1aCaWaEwvZkuMZ481IKEWCPR2X4gN6TWvZuqL9cF
	IC5mCL/npdGwc7k/A3RoJ0wXgA9xVViMgbYUswcZ2adOX8SF1ApuUDoZbd586BJY
	Tj40ySBofAuFWBISS3q9J25I6MnfP+RmJM/pcCTTZ8jP2VZTD8VsyDpDyZvFUu63
	sf0w5drTtnjhnM9AzT8A3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739971420; x=
	1740057820; bh=RqThhAR5Bq97zC1cdMpKiv6/QUQ/3+Nrmh5K/rsJOuU=; b=o
	h7pVZVMrGDb2WMVeHYSC3KPrAeX8GT9Sm6p8P+SLpgsFYKTF+EAjYG+WU/IQ15Gq
	yw369L31kCHDNRVni0OoIXPpKOsJnwVyOkaNkKIZbWxtw2AvM5bGXfeYQXeLFJUu
	kMn+zU4geqC+efDAF/8OM69kQFp67tzBfdWQt3kWrkTSjLmfal0PhtmJVhSvIiym
	jd8oFhaLgfYcl6dtPhWXG44JrnbeLE5yt0c5qRr/b7RQY1fgHslx8ankXKlYNo2B
	lxE+ghLtjxlf/2tdIlcS3f3VOVKaCCqBaAayGlTNQ0c9iOn6n1p0GiifqZGbuisq
	LoTcCronPQ7YhPgKsf6ug==
X-ME-Sender: <xms:XNu1Z2PWAyl-31yaHPycy3uOOHbxoPNpAmzhMpHsILIKU-yN20Kfzw>
    <xme:XNu1Z09Wea6i5kqvfaWF5EqLeQviYUryfmVKkJ9zDVRlkGH0U46mOBhLSBNZCRlLg
    O7ftJ79ZhTCYGlzNw>
X-ME-Received: <xmr:XNu1Z9QRaVcnG4oS702YrqMu3ZOmDdU6674QaTz03Be3Gt3YmAnhvJPd2mc3qNGbU2DmDmPzXPM8gS0E_H2WVqiAjftW-vdhSGnOQKjmsTr8YuQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgv
    thdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepshhhvghjih
    grlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhmpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrgh
    dprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:XNu1Z2t7FCpav6lczjfhWuoFRHak3JAWemJSOkRoO9_ylCcj8C3edg>
    <xmx:XNu1Z-dygh5BGsdk4fi5NbFMeUnpU_wrv-RlYa4i9L8qx_AgQJTZvw>
    <xmx:XNu1Z60SofCbZyLocqg11okGglAd1Q4rugVr9Bj8xFza2C8oKHaQYQ>
    <xmx:XNu1Zy_zddtgnWoZ6CL_478DHytGCHNVBlmMJiYDaTaYPCuOC9nMsw>
    <xmx:XNu1Z0sSse1LIm8rktkMfVjjoqHgm46rulprehqCvz9TY1_xIsj7hNie>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 08:23:38 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fb93937a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Feb 2025 13:23:36 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 19 Feb 2025 14:23:29 +0100
Subject: [PATCH v2 02/16] object-name: allow skipping ambiguity checks in
 `get_oid()` family
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-pks-update-ref-optimization-v2-2-e696e7220b22@pks.im>
References: <20250219-pks-update-ref-optimization-v2-0-e696e7220b22@pks.im>
In-Reply-To: <20250219-pks-update-ref-optimization-v2-0-e696e7220b22@pks.im>
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
index bc0265ad2a1..3e0b7edea11 100644
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


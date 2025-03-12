Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1982566F4
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 15:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741794978; cv=none; b=rmg8N5re4bfit+CRukRqm6VKMqBPDp9okuCligxoFU4pkf29vDSDVMWI3F5WZ4BrGHgjlEbSepyW4+Rd3Kualxp6UaQ9d1jVBn7qc4iLlY9zjOoMSNQyc75OTdwocNfO23ggqYNdSaI400X6Znm1c90L8FkN4qyK7rOGLI8PVhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741794978; c=relaxed/simple;
	bh=Luos7sQ/K/RPefsi6L+A2RlSPWFG+fvAr4lXAelps5k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VnD3IA77vStAwdS4KDXiTrAamt+NQaGq8ONgciikhHWCbxzke6xujN0bJSlCNHf7WM/V4HT43V47sS/ZuYDkAMRO784cC6CIlF5fVS6F0tETIonGprlq09oNaeRYU3XjrC5v0/duX6MLY77YLHy0ikPc5wSprDKxO81Yq14b8VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=F3lupS9B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=2ID+QPGq; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="F3lupS9B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2ID+QPGq"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 7E0851140213;
	Wed, 12 Mar 2025 11:56:15 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Wed, 12 Mar 2025 11:56:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741794975;
	 x=1741881375; bh=y0mNlBvGbUeoTWzlBu1AAJb4S8z2vUT7GV8pWSe2ASA=; b=
	F3lupS9Bi4f0vmdRpYSFbpJOo42MG896WG3Ka5LHaoQ7LPoF4c5/K9opX9OvSmqV
	WLJ3UUBPrKj71hZjzzYjtdusVIfKG/Uc/+TvJRuq8GGQSZMhKOi4xNiuf+f72ONu
	RZ83xRU6OQRVg0s353Ngh3Q5p2K0bQvYZWV/K41Xi3R+FzR/f7ExSWeLjeK58Tfj
	olK8+7SsYfW8rInQkcyCMkqBtmzIACAaEcJqBFq2QW0mgHbOkWzrAa8o9rRFc9kX
	kGTbrpItVH/QtQNKDtfN9ZHQeKHSIyAR/0f+17KYeFj3TF+8l5hxaZxpmYPhNqhq
	T5tfq4OH5Gcw5gl+dwwkgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741794975; x=
	1741881375; bh=y0mNlBvGbUeoTWzlBu1AAJb4S8z2vUT7GV8pWSe2ASA=; b=2
	ID+QPGqviBs4z0by1uu8UJjWNW0/2fsh44pOVUfWOldYsBeHlbC6a+ZmcmRgWzbH
	+kbKp33ZD/AzPGntgW1BBbVQmreux9HEcgFegz0Km6OT2xADf9tRck0QK6ekBNpt
	CK95EztAwT3E9JNM7jjwXo3fPQMUQis9CdVImplAjEX2a3CU5O0JVs2ab8/U6gq8
	LezaXlyiRA4/gBk/sSozdHs6ns252bYRCIpusODqLf1ix34n8veNZJOWFUvOf/lp
	l0Tegr+mXHiS6L8ZcgKbMD14nnSy5UPtP+jn/U3sxG9AueRgifUZb/yrGZqBdPan
	SjhLwtozZOpS/HvL+kziQ==
X-ME-Sender: <xms:n67RZ2Vt16s3KI7Nx4UBPCwCRgEgjGcR1taprYiC94-nKTmqN_SB_g>
    <xme:n67RZyluFG6Y0pM0Q11M8HB0ppmeoTkGYZOVUcq8l-t2DZe_insZ7F89IUrM5iqd8
    NjMMOe6MOXCY28DHA>
X-ME-Received: <xmr:n67RZ6YV2EwbHx4ZyKAbxmc7V4wTspmsuqh4aHWfv1qLzTO2JwbQscArrj45FHIEHecyPyR1bsWylMLfUcbXVTNNgFh5CUcXgSp5YOwE_o3jaUCckA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdehgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehshhgvjhhi
    rghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshht
    vgdrnhgvthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrgh
X-ME-Proxy: <xmx:n67RZ9XHXwkkm-bRJaK88oZLwRe_W4PoPX-ay1OVKKKXNF-C9kBUag>
    <xmx:n67RZwk48TUKpHxiO2q9kM8iUv7IlDdHfRV7txmFP9y8hd0QHL8Kng>
    <xmx:n67RZyeOP6eJfAHE8U7x76HoEvtSi7fRbXLeSYKLCH9w1ECqz9_yIQ>
    <xmx:n67RZyEiWKAyls4Dp4WjHSmpmArw7dTXv7pU_veZhGmvuvPhMZXPXw>
    <xmx:n67RZ6XUCVnFkf1-tQiOogv1qwwIKNJCqWHmMJoepkQTonfCFjdvkLIN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Mar 2025 11:56:13 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a7dd6985 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Mar 2025 15:56:11 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 12 Mar 2025 16:56:07 +0100
Subject: [PATCH v6 01/16] object-name: introduce
 `repo_get_oid_with_flags()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-pks-update-ref-optimization-v6-1-f778e0414f55@pks.im>
References: <20250312-pks-update-ref-optimization-v6-0-f778e0414f55@pks.im>
In-Reply-To: <20250312-pks-update-ref-optimization-v6-0-f778e0414f55@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 shejialuo <shejialuo@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

Introduce a new function `repo_get_oid_with_flags()`. This function
behaves the same as `repo_get_oid()`, except that it takes an extra
`flags` parameter that it ends up passing to `get_oid_with_context()`.

This function will be used in a subsequent commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-name.c | 14 ++++++++------
 object-name.h |  6 ++++++
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/object-name.c b/object-name.c
index 945d5bdef25..233f3f861e3 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1794,18 +1794,20 @@ void object_context_release(struct object_context *ctx)
 	strbuf_release(&ctx->symlink_path);
 }
 
-/*
- * This is like "get_oid_basic()", except it allows "object ID expressions",
- * notably "xyz^" for "parent of xyz"
- */
-int repo_get_oid(struct repository *r, const char *name, struct object_id *oid)
+int repo_get_oid_with_flags(struct repository *r, const char *name,
+			    struct object_id *oid, unsigned flags)
 {
 	struct object_context unused;
-	int ret = get_oid_with_context(r, name, 0, oid, &unused);
+	int ret = get_oid_with_context(r, name, flags, oid, &unused);
 	object_context_release(&unused);
 	return ret;
 }
 
+int repo_get_oid(struct repository *r, const char *name, struct object_id *oid)
+{
+	return repo_get_oid_with_flags(r, name, oid, 0);
+}
+
 /*
  * This returns a non-zero value if the string (built using printf
  * format and the given arguments) is not a valid object.
diff --git a/object-name.h b/object-name.h
index 8dba4a47a47..cda4934cd5f 100644
--- a/object-name.h
+++ b/object-name.h
@@ -51,6 +51,12 @@ void strbuf_repo_add_unique_abbrev(struct strbuf *sb, struct repository *repo,
 void strbuf_add_unique_abbrev(struct strbuf *sb, const struct object_id *oid,
 			      int abbrev_len);
 
+/*
+ * This is like "get_oid_basic()", except it allows "object ID expressions",
+ * notably "xyz^" for "parent of xyz". Accepts GET_OID_* flags.
+ */
+int repo_get_oid_with_flags(struct repository *r, const char *str,
+			    struct object_id *oid, unsigned flags);
 int repo_get_oid(struct repository *r, const char *str, struct object_id *oid);
 __attribute__((format (printf, 2, 3)))
 int get_oidf(struct object_id *oid, const char *fmt, ...);

-- 
2.49.0.rc2.394.gf6994c5077.dirty


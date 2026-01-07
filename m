Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3929631B80B
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 13:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767791307; cv=none; b=p0N3dH/SS8KI6RACFoxyzj5GyaaAGj5JbRQuM8039lUkvQsqmEE7QGL3dve+SFvFl/+nrA9esQgZK/H5pFU857jMYGxtgpnnP+ffGBregHbZmXm/X8BUT49EVQBsBacuBDdP8mFU2X1tUPzxLC9gMWCQEp6CVr8XeHZ1PRK3rzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767791307; c=relaxed/simple;
	bh=MldFRCOdk0za2J9vZXyBBCMKO8AsX0ZxUEJBYsHPdOs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xeq5wKJY+3XGM3Kittk6aa6pmTf28RlgkBfWpJWus8qCWCNR0OUcabywrigYwKXCNjLseFGfYxjWtkanZ65CMvjJNL/GSKPsiA+WRnG4s6y3Wr0u8Jv4pfRtAF4RtD8e/8yeuU3sH9PetD2YUsCsgDkc8xoWhEzGZ24VbgdfhAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZJ3GCYf1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GGJOh9v8; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZJ3GCYf1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GGJOh9v8"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 32612EC026E;
	Wed,  7 Jan 2026 08:08:25 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 07 Jan 2026 08:08:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767791305;
	 x=1767877705; bh=f2fjCLbSZVgEocYo+dWt0r0btYd6Qb8VXJVoCr+i/sM=; b=
	ZJ3GCYf1478bAgsspXZ/j34ySG73DcuKkd2bKRmcAQUBk9xx4ZcfVfFw1kMVnxgh
	G9orh1NJj7nhW81p5kDH13WZ+YO92ssfKZ9HG2m7fGHTGNByCn82hGmIWuCj3SlV
	rFIYkFu5DM/fIA1h5/h/pw2/p/HR2yhMX0cl4iYHiwVBmbj6rGh2l01iHp95YzmZ
	Gb/cDbGKw/VXp1sjTwSHq2DyKLhDy3QWpA4mxq3stfHAfsg0Dl9D1ZDIIfpkGp45
	+I3roHsO23N4ur4GXY4RetQweTWeMQaDap4TfHQsZpHLtR3DWO1xffLI4GFl4Iry
	T8QM+4E+JLONh5uV8pkI0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767791305; x=
	1767877705; bh=f2fjCLbSZVgEocYo+dWt0r0btYd6Qb8VXJVoCr+i/sM=; b=G
	GJOh9v8BcTXBusopoumw5kmm26wS0LgFHO/x7rGmjxuF8AT4iv+LtMYOgTNoTQw1
	4AJYoTixtz/AyQe5hqEb/Nzm8jkpXwswQ/zMKA39+zuQZv7vZeeZva2O6q9nEnd1
	uXH/khg0pgb8KlpvqeYJiNIMzuqd2UZm4g3W7TrlAUyB1YXRAlywg+e2elAm11bB
	nB8JnipEv2OT1HNUJ6raUl9QVpradFJPVKdb9htiA+LFq7W6tEuH7FV0b3EhLeq8
	dUTdZyhb4OvSfYSdjv+WGow1NKigLvASrYBcoJb78eNT1MSipjq1vWWBp7gPmYCG
	rTEvDq4zRrGnntsODOJDA==
X-ME-Sender: <xms:yVpeaXUvP8M8JjpvBpEXMtGkwsKuSUEvbDYouWaS_iqzuQY9lFYAjg>
    <xme:yVpeaTSU1xMkPTKBT-BsOggeyyYy1zoXyJ9Zknbexm6jxQLPMv8XyeJg_M_uo0k6L
    ognRaAImnQBR6q3bsPApC1Jo6xbShePQeE-mGs0kOqtJ19wk57K>
X-ME-Received: <xmr:yVpeadMspCLBjm4p6dvMxRZz_qNVqc2ewFHUIW6Ab8psSYa48_oWXZCDJhvANLH4uCfY8NbbZfEl9vF_LJFOITf7CV8RX1R905MYrmqJxTI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdefudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohhonhesihhothgtlhdr
    tghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsth
    hmrghilhdrtghomhdprhgtphhtthhopegrphhlrghtthhnvghrsehnvhhiughirgdrtgho
    mhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:yVpeaZQXnnBVNN61O9Nl4dOmPefX_jNdLhW4sRKGSkmvAQwYIDtpQA>
    <xmx:yVpeaTjRZHfPie1RdyG7kFV8sXFOzkf5nGCqxiFldc9_-b9BcyIZRA>
    <xmx:yVpeaa-DtWjJc19XO38Ait6P7Al6-rEeqZlK0cVXGr3ltqWsyEbPBg>
    <xmx:yVpeaSHC9N5A9hKfr9qYiItR8lp3NG9zYJJa5C3A7NGmejrzQTEqGw>
    <xmx:yVpeaeX68iPBEixkugMIqpJghSS8Ld8T0aYFpT_aaert9jyqWTKQylXV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Jan 2026 08:08:23 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8db57c4b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 7 Jan 2026 13:08:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 07 Jan 2026 14:08:03 +0100
Subject: [PATCH v4 4/7] packfile: always populate pack-specific info when
 reading object info
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-b4-pks-odb-read-object-info-improvements-v4-4-b5d55c47082a@pks.im>
References: <20260107-b4-pks-odb-read-object-info-improvements-v4-0-b5d55c47082a@pks.im>
In-Reply-To: <20260107-b4-pks-odb-read-object-info-improvements-v4-0-b5d55c47082a@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Aaron Plattner <aplattner@nvidia.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Toon Claes <toon@iotcl.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

When reading object information via `packed_object_info()` we may not
populate the object info's packfile-specific fields. This leads to
inconsistent object info depending on whether the info was populated via
`packfile_store_read_object_info()` or `packed_object_info()`.

Fix this inconsistency so that we can always assume the pack info to be
populated when reading object info from a pack.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 packfile.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/packfile.c b/packfile.c
index cc797b2b6a..f7c33a2f77 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1657,6 +1657,20 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 	}
 
 	oi->whence = OI_PACKED;
+	oi->u.packed.offset = obj_offset;
+	oi->u.packed.pack = p;
+
+	switch (type) {
+	case OBJ_REF_DELTA:
+		oi->u.packed.type = PACKED_OBJECT_TYPE_REF_DELTA;
+		break;
+	case OBJ_OFS_DELTA:
+		oi->u.packed.type = PACKED_OBJECT_TYPE_OFS_DELTA;
+		break;
+	default:
+		oi->u.packed.type = PACKED_OBJECT_TYPE_FULL;
+		break;
+	}
 
 out:
 	unuse_pack(&w_curs);
@@ -2156,23 +2170,6 @@ int packfile_store_read_object_info(struct packfile_store *store,
 		return -1;
 	}
 
-	if (oi->whence == OI_PACKED) {
-		oi->u.packed.offset = e.offset;
-		oi->u.packed.pack = e.p;
-
-		switch (rtype) {
-		case OBJ_REF_DELTA:
-			oi->u.packed.type = PACKED_OBJECT_TYPE_REF_DELTA;
-			break;
-		case OBJ_OFS_DELTA:
-			oi->u.packed.type = PACKED_OBJECT_TYPE_OFS_DELTA;
-			break;
-		default:
-			oi->u.packed.type = PACKED_OBJECT_TYPE_FULL;
-			break;
-		}
-	}
-
 	return 0;
 }
 

-- 
2.52.0.542.g9473a8513b.dirty


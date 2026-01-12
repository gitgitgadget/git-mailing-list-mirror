Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBFC346AEA
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 09:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768208469; cv=none; b=sRYvYjmYSWa0vXJAWgjvktSmhvgC+GVyzasgC15r/AljD085sveYbhF4M0/UN2WFU9ENa3XmQka/dvsexGHspVyyxK/nvjE3TvlJxBycG3ujoHBKPEMXR4bxMFs/n9WE5vFmNbMFdYKgOFaIHRBdAlgnzT56eBOxO5VZMo8XV70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768208469; c=relaxed/simple;
	bh=p6UbcssXk6f1OwCwtuP/2qhi0RzbgWy/f5bKdCTjKT8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bY0kzf26rq8pqqX1gQYWl0z4YR8js7Ab/PqZArATQK5A1CpFx/YEcKKtrQVBX0W7xLpIarlPIGUlsKLCHBL4kuMxS/Bv6M86BFMVRMNbEVXeFxfTuLquYzclTrFPt70WijLax78RvL96pQ5zR4T8Z6NQ3L3nUoqt1lVM7JbIt6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ejAfVXQg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=t4dC2HEo; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ejAfVXQg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t4dC2HEo"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1781A7A0040;
	Mon, 12 Jan 2026 04:01:07 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 12 Jan 2026 04:01:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768208466;
	 x=1768294866; bh=pTaxlK2KuGhG9M4a5b/qRzxFXdX39ISoMV86WIhE/wU=; b=
	ejAfVXQg/4uO+SVn5U00SSif3MJ47wcGNekJZ2+KQpAE44NBEd4cPu6UvBPHhxuQ
	7G1poU39opD2PQnca/qzm9btwIEU3YUfrudn9HG92xNZFGsSqugylqtxfB1P56sk
	CdLT9L/QrQnGqCWc3ArSatDV4RNPQHlyjNwB5zJydF6Hm4r5CXPHTMRoX1cD3sfT
	+zgmxUbQPhhk0S3ZB39WmBThhH/Tl1T2Z6aK3ny6VXHRCYws3ozSK0UifhyUXQVt
	pv7EMatll+tE0+frYExbbsnxILHwmiOEOOUPrSjEkhtWPOxc2mBsmlnivUBUqjBt
	16/Fxm5ZjgwJjf+f8FSBjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768208466; x=
	1768294866; bh=pTaxlK2KuGhG9M4a5b/qRzxFXdX39ISoMV86WIhE/wU=; b=t
	4dC2HEoYwZovIGDzd+Bdd9pFJvsx0v/+3AfA7/C6d+syoWFLHI5XaWYluhSfGMK2
	GADgFQQcAYsgXBG7rqAdvpvc/eS2getCO8+sjcTcbzzsLVozSOPjneCsd+oAeCRP
	TWacExAq1OuVFpt91BL0KgjusbPqYeie2fBfpb7gEzwiprxevZKSsxtG/lZwVqk6
	EI3S5aXRhdt9JY+7EbBd798e5reAQlGxRRUKKppDDJJkQDJrTf4+Z+c9SWIO97Fn
	+IpDpIrK6rI1q9kRs61x3nDK9CJDo+A614UrNn2vtCUUOt8b5gDORUxYQHPPWyYR
	D3TXYuyJBR4ta14P48J5g==
X-ME-Sender: <xms:Urhkad9odly9xHgLwmzy63dueVkzpkKZ3yNg1ZX0Xs5pg0V664zaTw>
    <xme:UrhkaVZCqMcxTITYdRnsQa9AZ0iCnyH_JmetmMvxXi_87Tq5-saXJF8o7zFbbkjMg
    sOxdczMUfyLedRjuOv-On_ZV2G8X4QtHeDhJGAZfy9FENZO908dww>
X-ME-Received: <xmr:UrhkaU3dSDIiF22Ye_Qkhb1RUBQK_W4I0-J36BpznL_PfhQ1N85afGJaY5U93aFjoiMrYqP-tcvZ-mMsOYf01r07k2qR0deTThOmCNSBcQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudejtdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegrphhlrghtthhnvghrsehnvhhiughirgdrtghomhdprhgtphhtthhopehtohhonh
    esihhothgtlhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggr
    khhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeekse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:UrhkaYbXwozgdfksItJsJqAulG_5XCSSwpdJK5hwageQBctKxU4IPQ>
    <xmx:UrhkaUL3lUaiTDhTgWXmGqTNxPgSj8ZF2psyWsrecU5zi-5FpqVbiw>
    <xmx:UrhkafGxB4ZStwYubZjUX4s4CgmH9-4hOI-pY8saXnppGAOoyxLL5w>
    <xmx:UrhkaTvAWRF_cpw_E6u4RZyyUJvtI9In2Rh4ZVgcueYKMYsd6ABdJg>
    <xmx:UrhkafUn-75x-HhUNkqGnXZlWuA9v_Ff-Bdf3TRYnNkIJVgj7uRRYEcI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 04:01:05 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 77210ed6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Jan 2026 09:01:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 12 Jan 2026 10:00:44 +0100
Subject: [PATCH v5 4/7] packfile: always populate pack-specific info when
 reading object info
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-b4-pks-odb-read-object-info-improvements-v5-4-9a6124e95bf2@pks.im>
References: <20260112-b4-pks-odb-read-object-info-improvements-v5-0-9a6124e95bf2@pks.im>
In-Reply-To: <20260112-b4-pks-odb-read-object-info-improvements-v5-0-9a6124e95bf2@pks.im>
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
2.52.0.590.g1f87b77810.dirty


Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049631C3BF7
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 06:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767682513; cv=none; b=A8eZPoMBvzbhJpOWqH5y07Fbe6EtEA35irS+OpdRH7mZERTAuZWxusgih/nHixgW3GUnQUw9B4FPHxb2P8VSl38yWvDmQm6Bn2LOmYoYoEw560d7JFKP/7Ihko42Lx4pFgkRciMbcLNliF3AyGcWTBZ7+JwmgqFAzIBjVKL4fP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767682513; c=relaxed/simple;
	bh=eDN/PxJIBa7v4XBiAv/DcN1L79pKCdwf/BIpsCGTL0A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OtHfXL7VJUwdRZkbUgfJF0JEOoVuwwd0FAXvKaTNZJFqSVkXqPITYaR4FXPwpeK0EIPWO1zN3Zwi66zPV3Nh06cweQsfaeutOVsu6i7oHQqy86yVvTqp9EBN3STfaQ0Rr3DsgDNwERgjse/PxAK9vy5Nht8dj+FvdSseZx2j2Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OT0L4MLA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=z2s9d+13; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OT0L4MLA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="z2s9d+13"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 2EB661D000B0;
	Tue,  6 Jan 2026 01:55:11 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 06 Jan 2026 01:55:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767682511;
	 x=1767768911; bh=XR9HHFOgryeTZHgMN5iPfeCogaiRsDnzylJ5AbQvGps=; b=
	OT0L4MLAjQC7Vo1PIUkLlAzsKBwiDvzJzByCnCm+tfM0jxWt9RgO8zNTqOOa3II5
	F7uk16VHnvKVPjBS3dJ3b27MytJBudFBdaVl8o/IQivJ3dbEIIN1usxS9ivNmL1W
	qtKikRimvt1anjxWVIEAyQn8dRm4mgjtnnxAkERE6jdiG6qZq/YIRXDD5SGs7TmU
	RXgqsE3v4isw4beTTto/dpPaeOsbWR39uT/jObU+CcPAoninuc9uotMGOA0c7XkT
	Vq+p2lSrp+Tj7Je/Ztmcvu0AE1uo04gdiadjQoUQJiRomVdaeLimZ1U7kf2h7atY
	u1XVIgRgpC8ChAadm60F/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767682511; x=
	1767768911; bh=XR9HHFOgryeTZHgMN5iPfeCogaiRsDnzylJ5AbQvGps=; b=z
	2s9d+13VJEWoP7+6W4LjsITDYOS/rsGHkvfZ40CzR7YDNRMCy8r40MKOWY4W1CLE
	gws1rYiGGQ5ewDmORBy0Jvzt1WpF2US5JNkJWygHqUGizcEVcNBnEKHXOjRN1mtg
	KkX2bq/qLupBZxWhydtZOEirMqANJTzQ2E+G5852AGkpcIjleyHXVeJCGreepe6r
	fCd5t8Yh1rvuEQ+6IoYe9/bgC+mNL0DAoIOQQZfuLI92X179ijNxKHeRSxZN7li3
	3M0Yk1+7X2mF23U0zD/x1G1BGrsmjfHqxvBoOlVSbkPYswb4vCh3hI9z/dYKzk5T
	XxGMiUHPQQiwDlOHMpL0w==
X-ME-Sender: <xms:zrFcaTDzqX_nk2CguMlqEBK1N-QxErOX0fAnQ2a9FCTWfXIZXubmRw>
    <xme:zrFcaQaSRvdOSiXF6SgaNgkDMmucveAaZ90oQ3wr75_S1P3n6_465bxGAbEmZXOPt
    ze84vfbn0vA37q84vGDE4ylOP5BOpclLGxoyREwsNjV6mVZfwoybpY>
X-ME-Received: <xmr:zrFcaW4j2CRoPdPJ8S5M0DaHy0ipUasct-LijJZWdgo2uml9QH63NvfF8HIPcjVeQJLy-9ZQKUlbOiDYXF4OhkujE3OkPVNjPOtIfDa4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdelleehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epkeeiveevgeeiveeiueevfeehffegueehteehgeffffekieejtdeufeelffdvveelnecu
    ffhomhgrihhnpehprggtkhgvugdrihhsnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghplhgrthhtnhgvrhesnhhvihguih
    grrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphht
    thhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrh
    hhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:zrFcaRYU5XIJZ9BGZ-KYt1iKdO8ty8GxUFeLnxPXUVAsDXXhHmA-sA>
    <xmx:z7FcaVgO84h55EJdqL-X06kf4_5AZ-1CTi3SuhtgbFEGFW-_DjCqNw>
    <xmx:z7FcaS-FfDuwdJNAknMZPR2tQWd_al9pAaAEMVW9_sx-VF3C8LRRkg>
    <xmx:z7FcaQo3OhNwXoZ_uKBZTyxAbowz0BiCbHPiXjYwOmMKwKiGsbvPlQ>
    <xmx:z7FcaQ-uUhTVZWcfOdcF5kqGtRcsPcDMfGgbsSR9q55grPdKEA0TbANS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jan 2026 01:55:09 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 80688f8a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Jan 2026 06:55:09 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 06 Jan 2026 07:54:59 +0100
Subject: [PATCH v3 3/7] packfile: extend `is_delta` field to allow for
 "unknown" state
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-b4-pks-odb-read-object-info-improvements-v3-3-b5e02fae1fb0@pks.im>
References: <20260106-b4-pks-odb-read-object-info-improvements-v3-0-b5e02fae1fb0@pks.im>
In-Reply-To: <20260106-b4-pks-odb-read-object-info-improvements-v3-0-b5e02fae1fb0@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Aaron Plattner <aplattner@nvidia.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.3

The `struct object_info::u::packed::is_delta` field determines whether
or not a specific object is stored as a delta. It only stores whether or
not the object is stored as delta, so it is treated as a boolean value.

This boolean is insufficient though: when reading a packed object via
`packfile_store_read_object_info()` we know to skip parsing the actual
object when the user didn't request any object-specific data. In that
case we won't read the object itself, but will only look up its position
in the packfile. Consequently, we do not know whether it is a delta or
not.

This isn't really an issue right now, as the check for an empty request
is broken. But a subsequent commit will fix it, and once we do we will
have the need to also represent an "unknown" delta state.

Prepare for this change by introducing a new enum that encodes the
object type. We don't use the "unknown" state just yet, but will start
to do so in a subsequent commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.h      |  7 ++++++-
 packfile.c | 17 ++++++++++++++---
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/odb.h b/odb.h
index 73b0b87ad5..afae5e5c01 100644
--- a/odb.h
+++ b/odb.h
@@ -343,7 +343,12 @@ struct object_info {
 		struct {
 			struct packed_git *pack;
 			off_t offset;
-			unsigned int is_delta;
+			enum packed_object_type {
+				PACKED_OBJECT_TYPE_UNKNOWN,
+				PACKED_OBJECT_TYPE_FULL,
+				PACKED_OBJECT_TYPE_OFS_DELTA,
+				PACKED_OBJECT_TYPE_REF_DELTA,
+			} type;
 		} packed;
 	} u;
 };
diff --git a/packfile.c b/packfile.c
index b0c6665c87..cc797b2b6a 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2159,8 +2159,18 @@ int packfile_store_read_object_info(struct packfile_store *store,
 	if (oi->whence == OI_PACKED) {
 		oi->u.packed.offset = e.offset;
 		oi->u.packed.pack = e.p;
-		oi->u.packed.is_delta = (rtype == OBJ_REF_DELTA ||
-					 rtype == OBJ_OFS_DELTA);
+
+		switch (rtype) {
+		case OBJ_REF_DELTA:
+			oi->u.packed.type = PACKED_OBJECT_TYPE_REF_DELTA;
+			break;
+		case OBJ_OFS_DELTA:
+			oi->u.packed.type = PACKED_OBJECT_TYPE_OFS_DELTA;
+			break;
+		default:
+			oi->u.packed.type = PACKED_OBJECT_TYPE_FULL;
+			break;
+		}
 	}
 
 	return 0;
@@ -2531,7 +2541,8 @@ int packfile_store_read_object_stream(struct odb_read_stream **out,
 	oi.sizep = &size;
 
 	if (packfile_store_read_object_info(store, oid, &oi, 0) ||
-	    oi.u.packed.is_delta ||
+	    oi.u.packed.type == PACKED_OBJECT_TYPE_REF_DELTA ||
+	    oi.u.packed.type == PACKED_OBJECT_TYPE_OFS_DELTA ||
 	    repo_settings_get_big_file_threshold(store->odb->repo) >= size)
 		return -1;
 

-- 
2.52.0.508.g883dcfc63e.dirty


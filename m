Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76D4257844
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 10:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766055280; cv=none; b=gD4nKciIvf5acekuz7HD6yiEWiKXoyHLiDNeVL+yDl4p6Qh9mfbT0WvDJ8i14E81nE20+owRkOB892p9vJMNSXSPnTGvLveKJvCUQMGyRKKvkt3Zk9ewkxT9ij8RWTb11KGvGz3gmQpE15yTcHH+ho5WIBq6cfYPr8tNj1yL6GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766055280; c=relaxed/simple;
	bh=WKLU3WaaobtBfxQ1gs4sL/84qL2DctdL8vUEphXQHIg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p4BF4kyCOx6usHaYaG8QXQKjCgHSB9wSNQ01cwTbpBTlIZFFtBf/GgJu4HP2eNkbGHJSEKruZdDnUJuT6SaH7yZJUNqu0fxcIuJ/gC5rjRapIRW1QUr/0NZLlmBEDQBnBTd5m3obqr4/0y9s+QGcPUhDW/qQXTROAvt7ZrNXt24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NvrQujJr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sTdzhLDH; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NvrQujJr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sTdzhLDH"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1DD7B7A0126;
	Thu, 18 Dec 2025 05:54:31 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 18 Dec 2025 05:54:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1766055270;
	 x=1766141670; bh=oFDdatiNS/to0ESwJCG/711o0CgY4dtt+6mpt83a4/c=; b=
	NvrQujJr/MOo7TSlmhpvbVlyUFFGFh6HspTS0W435Kz4Ta6BEy279Q+KEJlpxXE5
	EO/lm5sgXDNd3QSu3oYFVtAACoUph0/vxZm2Kr9/m1/UcxjURCVGYOKaDhEeaHkz
	4Ln9+IMwTRfkqPasarY2PmgGY/ctNZ6FhxGxU4fau0tb2dMMQh3BbKMPiClpglOk
	1bsCC3NmJukjzR0XA0rIbHNhxwuLW9xf3z+OwTFiRlNd5IvsOsZ8cR9pRnbk/A7Y
	4iSpm0IEo6QpTZ4UIzuXmttC/t3Kg2vzeMu5Yr1259P36D9zqeKclL/gy2JqPVp5
	yEf1cxmP7W8sPizFdKfUBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766055270; x=
	1766141670; bh=oFDdatiNS/to0ESwJCG/711o0CgY4dtt+6mpt83a4/c=; b=s
	TdzhLDHezL0jfh9yqbRK6h1ckbMl0W3Pep62VJongehzZmv1KHOoX0MW/KB0PPYA
	Iq/FzX2tHbJPtm0ZqHdHfaQ704uMU4JaYEOK/OSPJ3yqKxcJTbCQMBqYDpC3QGDZ
	iQHvjJXB9uK/N0DHsptApaARFRP8xrO+p3I0UR7CGMNI1ZCTBfApw81lDrDcsXzv
	7XxCf7g64X/wdNIkDO07HrNnTA6nf9ljjKca7SpsRBV7rQnsSItj75CAdzHOuum/
	SBfdARPw3wR6aWnu3jXxCRnEkL6aerfqT9dbOhPuaUDJW33bnNJDwsX6zpAOqcqI
	afXSkVaCoTXDA7G/xZMeA==
X-ME-Sender: <xms:Zt1DaY-uji55kKYbU505Mw1u_XCRUXn9ckmniSE6Tb1qc_OLpguJuQ>
    <xme:Zt1DaYLEOqPk4-41xkVpoLsRQZzWMQImIi--GoJCbgapwwfGNCg5ZpCl_xdJPFUgQ
    YhINuUadnZyme6FtFnoPGbQsFejhABsY5Yxu5D7KyQxNcTYoBa2hA>
X-ME-Received: <xmr:Zt1DabZ_6GR0NjfAz0h1m1OXir4D_YXS9oUJXw7EMrixSSuNggWwNaXU6SG3DmPuk9HGzQZ4Tdd9ihigBET3PtnP48oW_MDITkpz43DV8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeghedvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epkeeiveevgeeiveeiueevfeehffegueehteehgeffffekieejtdeufeelffdvveelnecu
    ffhomhgrihhnpehprggtkhgvugdrihhsnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheprghplhgrthhtnhgvrhesnhhvihguihgrrdgtohhm
X-ME-Proxy: <xmx:Zt1DaSJoTlJEPHWiYPb9T-SFQKZ8iFym6X17opeczyZr8_W-Pi-AAg>
    <xmx:Zt1DaRBeqmKP3IZrAO8msuMMgBxuPAZAhPCC2Jov3zNodiobbcO17A>
    <xmx:Zt1DafrtXbRIqCz01Pvd79gvyiiFwmqUqQ1ERDj4G2BIPhGCsp26Ig>
    <xmx:Zt1DaUj5F8yCStgavZKLgDPYkRSCMQHJqUaUQDW8-AMdZ-Ji97hkIQ>
    <xmx:Zt1DaVwCxbhI5a_uyGpNAXVBP_yvf91RDBEKllFgV4abmxrz61Ghgcd6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Dec 2025 05:54:30 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f2f85f8d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Dec 2025 10:54:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 18 Dec 2025 11:54:15 +0100
Subject: [PATCH v2 3/7] packfile: extend `is_delta` field to allow for
 "unknown" state
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-b4-pks-odb-read-object-info-improvements-v2-3-62e3e49072bc@pks.im>
References: <20251218-b4-pks-odb-read-object-info-improvements-v2-0-62e3e49072bc@pks.im>
In-Reply-To: <20251218-b4-pks-odb-read-object-info-improvements-v2-0-62e3e49072bc@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Aaron Plattner <aplattner@nvidia.com>
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
to do so in the next commit.

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
2.52.0.351.gbe84eed79e.dirty


Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20058320CCD
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 06:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766039317; cv=none; b=bpn+BWGevKgNS/XwcObQe8/xtU++gJH4X7jHPnW5fnuxRlUMHAY9DNpW+wx7PDB1aNOm9tlgXrCL1iVCgC9SwrC1N3De8cG6s23MC7PNGHdb1o8NjrpybxNcahv6IwrJAC41ZZfbizKCBgqlhdpef3ofQhkRQ/OJFcH+/uNDDE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766039317; c=relaxed/simple;
	bh=/69xDM9h8B9YGFeMD4sA8vk0nsNWPKKQq83wuUW6pLM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gq/oHI2lOABAJ9iatThpg+ojrRU2BffWVnipFimeXVLo7KsbsBOsKq0EFlm7iHBlAfYdLDBtfDm5q0wXATOJMNSS6gvC6K2vWD4m8BcXCEkatkHmVj7Go0AtnsL/XgNJEkkiswsxACL0+i3hvvB9dGr1sZlpcsmUlApHKWjyXsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=vCsNrT3j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oi1UBjF1; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vCsNrT3j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oi1UBjF1"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 69DB41D000A0;
	Thu, 18 Dec 2025 01:28:35 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 18 Dec 2025 01:28:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1766039315;
	 x=1766125715; bh=si6gAVbosPIb9E4uwGTY/xuN+WrDto+UhRyM7MRZZKI=; b=
	vCsNrT3jvFcM5SjL1ytmzoz6gpc4Vyh4IzGJn526k29wofDfAX4DYAy9ZXGKXvpp
	XRcKVX7FMDYkXHPEBvjTNZTW2cY2OZVCsDqO0GkQN49j28+ATWxd0ieP7cHIGSAz
	b+0QUk8CEyFxhwqgsZKyjqptyWSAY0Gg+RsSo/YxF8ENnekY8pwvnGt9WVrcMlHl
	XbNbF+Z4i9x9zOMCmq1krmem9ayNtiA4wPWoVltX1U3/4okWDMzNTGJEw6Pih9z0
	zevnW/LNPtvKyRpKRsNd20KeFlzyWlf3mBlsSuW5qrw83c5fDW4Co1LizbfzfldQ
	31uUdHG4ilU/8eZLirqTRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766039315; x=
	1766125715; bh=si6gAVbosPIb9E4uwGTY/xuN+WrDto+UhRyM7MRZZKI=; b=o
	i1UBjF1v+EKbNkGYVbcMS725OduQ+ZmR9H2GO1SEVMhiJ9NLlGhVfZf4dz3CajT7
	NLcDYuwgmtKDKEAphBw5bQBn6IxtRADGP7HpU1Ol/mrDEtKPNH1Sfwe/qnS05KWR
	j/Xd0i/zq/Tm6GOPfEBEZ5qDC/RDjgyyOFXiqh2Wi+M8WBtMEJAjFbBPo+jJVB3l
	9evEf1PWfSgryzjmX47DCaB0+Zn5PQW1YxjKRiUQlNhyrLRIi59nygQ6ju483nK7
	X7ElOFKhxP9yZCsnSOwSDqxC1PBP6DM83zx/bXijcaBkdncNCgfB303o6gUcfKmx
	Iv5M9m2vU/AKPE5GwtopQ==
X-ME-Sender: <xms:E59DaWg_DYqq545sy2ZrZynrw8pfdQJYUxZdPz3QJrlwCYwWmxUiBg>
    <xme:E59DaedmTQQZMvtDeJD-wlKZKsq53kLF32Wjr85KJtTaDm929tna_ygwzLWzfys7P
    8N0Ceo-99kScI3Cl4h16ArEDgg64BpWExKqnMlr_85Jd3-eQg85Jl8>
X-ME-Received: <xmr:E59Dabdi2sJHhaZ80KKb2KEgnnSQt7o4ip9Fj2K4Pf7S4f4albCZYCYUnoYmEA1wYhc52Qbs4CWyd7YFwaNOmE-YRY_Y8TQjUKawt9OfJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeggeejtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghplhgrthhtnhgvrhesnhhvihguihgr
    rdgtohhm
X-ME-Proxy: <xmx:E59DaY_1KscQATQ-2k8b46y_DzBjLmPIBIImngr7u9Qbxv4ae429AA>
    <xmx:E59DaXmDHjKFeMt-6TkiU4RDAPc_sD1QXTeyY_mgthn76sUAR7TttQ>
    <xmx:E59Daa8xOu2rMo3iZ_poOTOJ_Q24N3ROVjxLfiYeQ8mc81RTt-Rx3Q>
    <xmx:E59DaVlrkUe8soIPo1bO7UDYdqotvhTGyHa-VpdpGKIp7vGnjLv9Tw>
    <xmx:E59DaRhkcVxAPRUarEunXrDj0RyFysQ1W3K7uLOTHOajL3mdR3vaUGnK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Dec 2025 01:28:34 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d1eea06b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Dec 2025 06:28:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 18 Dec 2025 07:28:14 +0100
Subject: [PATCH 4/8] packfile: always populate pack-specific info when
 reading object info
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-b4-pks-odb-read-object-info-improvements-v1-4-81c8368492be@pks.im>
References: <20251218-b4-pks-odb-read-object-info-improvements-v1-0-81c8368492be@pks.im>
In-Reply-To: <20251218-b4-pks-odb-read-object-info-improvements-v1-0-81c8368492be@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Aaron Plattner <aplattner@nvidia.com>
X-Mailer: b4 0.14.3

When reading object information from a packfile we are not always
populating the pack-specific information. This happens in two cases:

  - When calling `packed_object_info()` directly instead of
    `packfile_store_read_object_info()`.

  - When we've got the empty request.

Fix both of these issues so that we can always assume the pack info to
be populated when reading object info from a pack.

Note that we don't really care about the second case right now, as the
condition will always evaluate to false anyway. This will be fixed in
the next commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 packfile.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/packfile.c b/packfile.c
index 9bce52f912..6e66c90c46 100644
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
@@ -2148,8 +2162,13 @@ int packfile_store_read_object_info(struct packfile_store *store,
 	 * We know that the caller doesn't actually need the
 	 * information below, so return early.
 	 */
-	if (oi == &blank_oi)
+	if (oi == &blank_oi) {
+		oi->whence = OI_PACKED;
+		oi->u.packed.offset = e.offset;
+		oi->u.packed.pack = e.p;
+		oi->u.packed.type = PACKED_OBJECT_TYPE_UNKNOWN;
 		return 0;
+	}
 
 	rtype = packed_object_info(store->odb->repo, e.p, e.offset, oi);
 	if (rtype < 0) {
@@ -2157,23 +2176,6 @@ int packfile_store_read_object_info(struct packfile_store *store,
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
2.52.0.351.gbe84eed79e.dirty


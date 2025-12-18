Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02E22D876A
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 10:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766055281; cv=none; b=i2FsPQbyrrplkqAqTK4ZvCugUS8g08mUB7NFSJ9kAT3XWmWHqvfxIIcb5LuAdHd3fxH//usU+XtDlUkpkNsN5NtTATnEoZUct364WzSm1m71WmWnuNAfva6z8Dp8KpYW6pYDWDzBSLxkER0DUkAKp6Y+o9qX6WVqZ8T/EeSm6Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766055281; c=relaxed/simple;
	bh=ZLHKMOjtcphECE0x4pgFDjMMzbAj/+GYTzim1ekrcHA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B5LM7kgg1bq/vNGPkZLvKRkMnYNfC701LSeaHzIw6UnnywmMvJB3FjmjJQ2ZRfoJlQlbEbfHNan4eBsnkJ2Dw5+LZDTtdZZB/to0M2/TY95hysLJl2D2dVTvqQlqpM5D9+L11UDH9xSrPygJUCxFMDCt7q5qg9rvhrpNu53SmFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AqfAUyEl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EEAPSjNY; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AqfAUyEl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EEAPSjNY"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 88C8B7A01B1;
	Thu, 18 Dec 2025 05:54:37 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 18 Dec 2025 05:54:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1766055277;
	 x=1766141677; bh=EzlL0uoIhDgyS3czvNFIV5Ho6+HT8mjUpXIsEK+ON0c=; b=
	AqfAUyEl6WkR3LbGQfqcuQwPtUBiqsFG76ISU4K2Ma514ARvae0gUmNnoGKDm0qk
	vjt408SrG+klrySFaIAqFaj2DfjErsAXWMfBNWKpw75tgbEaOAN9CgSVh4pUkA9L
	JSVRHvKIejiix+dShdzeWXQ+yyBat9hcFJWV5Nm8jx6QdJgAnB2XrjZhUc4MtGz+
	3a6QErDZhfRcwTI9RU66P97Dxk0kOc6rPsm2UuBWj2Xm4b9G0qCBd7uYuSoASxtN
	yWS+8oEszgB9EJGZMC8on3aTHT0Wn5Ne8kmEk5Kowzep3A/hb8MFFTGfIpDP0EV+
	h7oqHWrd3v4sD6fcp32lnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766055277; x=
	1766141677; bh=EzlL0uoIhDgyS3czvNFIV5Ho6+HT8mjUpXIsEK+ON0c=; b=E
	EAPSjNYG7YKWBvQ/7v76kDZFFXmtrlc/WO7wzWT2xN0Uj6sgHV8Kae12h7cHQ1QH
	G59SVze4TLduPywTGC97DI4xSJLxL7cgnPeDtWChwbudif61cJMd/Zt1i58LBjML
	3hMTWkhwNsjus0r/yvC09qQBohzb3vvBzRlU38bGGGq6bKsQ1dJENuLMF6tt6B44
	I3lLW9Lh8j7jnRibaPHI/qHUH9GqkZwK66NUM0RdIBXQXxEpBrYmPoxWQsFAVMRt
	2mUyaWW/E35fT/HhzmpVmzHZeuH9Ad84Ygp2zHEkJMNlnaTmc0nmLX/M5jsL9Ocs
	u5zB6xcFfXffvkesXeauQ==
X-ME-Sender: <xms:bd1DaaI_p20kaBXwuMzdqzJphCgAJ7OIhw0K8pI7lRqfizLHlhbuWg>
    <xme:bd1DaZmbi8rLZAzEgKkmYkCr_k_bZvPLk83tCucHr4a_4kjE70xYrc6zEpWO6l4Oj
    MreBhzeTR2QMf2wRXFWvequ-wvNb8-G64v2Mnno_LHazpR6G4yX>
X-ME-Received: <xmr:bd1DaYG-xv7ebTdxlhAsSWByHMkqnMIgUUBtV53YGbOHvrpXl0J3XJHyybLlhxfYF134qHMPVRyNShpAhl17Si-R1VUMo-kyTZrjAsVVuQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeghedvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegrphhlrghtthhnvg
    hrsehnvhhiughirgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhg
X-ME-Proxy: <xmx:bd1DaZGGfW_Ax_4wdAmPrQnukVuQDwIQR3rxxrfKcQiACjMD8IpIXw>
    <xmx:bd1DaVMNZnUdHHRTd02ESWzgWwvv-j6WtAemYFZAwD2eUKjt-cgSaw>
    <xmx:bd1DaYG_gflNI7czzmDCG1OQVsFdATrTcNai7Ta8v4K-mdgMKz07Nw>
    <xmx:bd1DacN5C6WABPWJUyBIiGFJ8Dw5HURhrmuCjbJN8-mNIOmJz_zN2w>
    <xmx:bd1DaSuzpbK6PPwIW0habCWatrEJjY97aP5mNF77kid8VL3Qf_3i8SAz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Dec 2025 05:54:36 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 758b7af6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Dec 2025 10:54:35 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 18 Dec 2025 11:54:17 +0100
Subject: [PATCH v2 5/7] packfile: disentangle return value of
 `packed_object_info()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-b4-pks-odb-read-object-info-improvements-v2-5-62e3e49072bc@pks.im>
References: <20251218-b4-pks-odb-read-object-info-improvements-v2-0-62e3e49072bc@pks.im>
In-Reply-To: <20251218-b4-pks-odb-read-object-info-improvements-v2-0-62e3e49072bc@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Aaron Plattner <aplattner@nvidia.com>
X-Mailer: b4 0.14.3

The `packed_object_info()` function returns the type of the packed
object. While we use an `enum object_type` to store the return value,
this type is not to be confused with the actual object type. It _may_
contain the object type, but it may just as well encode that the given
packed object is stored as a delta.

We have removed the only caller that relied on this returned object type
in the preceding commit, so let's simplify semantics and return either 0
on success or a negative error code otherwise.

This unblocks a small optimization where we can skip reading the object
type altogether.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 packfile.c | 21 ++++++++++++---------
 packfile.h |  4 ++++
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/packfile.c b/packfile.c
index f7c33a2f77..8c6ef45a67 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1587,6 +1587,7 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 	unsigned long size;
 	off_t curpos = obj_offset;
 	enum object_type type;
+	int ret;
 
 	/*
 	 * We always get the representation type, but only convert it to
@@ -1607,12 +1608,12 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 			off_t base_offset = get_delta_base(p, &w_curs, &tmp_pos,
 							   type, obj_offset);
 			if (!base_offset) {
-				type = OBJ_BAD;
+				ret = -1;
 				goto out;
 			}
 			*oi->sizep = get_size_from_delta(p, &w_curs, tmp_pos);
 			if (*oi->sizep == 0) {
-				type = OBJ_BAD;
+				ret = -1;
 				goto out;
 			}
 		} else {
@@ -1625,7 +1626,7 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 		if (offset_to_pack_pos(p, obj_offset, &pos) < 0) {
 			error("could not find object at offset %"PRIuMAX" "
 			      "in pack %s", (uintmax_t)obj_offset, p->pack_name);
-			type = OBJ_BAD;
+			ret = -1;
 			goto out;
 		}
 
@@ -1639,7 +1640,7 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 		if (oi->typep)
 			*oi->typep = ptot;
 		if (ptot < 0) {
-			type = OBJ_BAD;
+			ret = -1;
 			goto out;
 		}
 	}
@@ -1649,7 +1650,7 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 			if (get_delta_base_oid(p, &w_curs, curpos,
 					       oi->delta_base_oid,
 					       type, obj_offset) < 0) {
-				type = OBJ_BAD;
+				ret = -1;
 				goto out;
 			}
 		} else
@@ -1672,9 +1673,11 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 		break;
 	}
 
+	ret = 0;
+
 out:
 	unuse_pack(&w_curs);
-	return type;
+	return ret;
 }
 
 static void *unpack_compressed_entry(struct packed_git *p,
@@ -2152,7 +2155,7 @@ int packfile_store_read_object_info(struct packfile_store *store,
 				    unsigned flags UNUSED)
 {
 	struct pack_entry e;
-	int rtype;
+	int ret;
 
 	if (!find_pack_entry(store->odb->repo, oid, &e))
 		return 1;
@@ -2164,8 +2167,8 @@ int packfile_store_read_object_info(struct packfile_store *store,
 	if (!oi)
 		return 0;
 
-	rtype = packed_object_info(store->odb->repo, e.p, e.offset, oi);
-	if (rtype < 0) {
+	ret = packed_object_info(store->odb->repo, e.p, e.offset, oi);
+	if (ret < 0) {
 		mark_bad_packed_object(e.p, oid);
 		return -1;
 	}
diff --git a/packfile.h b/packfile.h
index 59d162a3f4..07f5bfbc4f 100644
--- a/packfile.h
+++ b/packfile.h
@@ -378,6 +378,10 @@ void release_pack_memory(size_t);
 /* global flag to enable extra checks when accessing packed objects */
 extern int do_check_packed_object_crc;
 
+/*
+ * Look up the object info for a specific offset in the packfile.
+ * success, a negative error code otherwise.
+ */
 int packed_object_info(struct repository *r,
 		       struct packed_git *pack,
 		       off_t offset, struct object_info *);

-- 
2.52.0.351.gbe84eed79e.dirty


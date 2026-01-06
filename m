Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF823009C1
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 06:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767682518; cv=none; b=HMBA0LS/lipKjqnVMpznouitkdm5+CKj5wZotjw1k7jxphglALKkN7dZkWWfzFa+nCVLhImUhwbEwS624zwhcs+h6jUEg1FocGJiNde819APom657L8ETKQD42CdI52iYhQMfxUx/DAqxTg2o4nuu/CXejZ/R0HZlaQQYyj+0nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767682518; c=relaxed/simple;
	bh=NzDvUCRbF5okHDzYoMV1akLckEgT9rnx+OIaAV7JZa4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PHJqqangseU0l4UNzvKZVPc7dZl1s3jHoMzIx9QVQPpJUXrAbut7hLqF6vAFUAZC//reXKtAfAriC+JpMBI01bK9cmfuhoopvx/QMsjycHBMQOQGy1RHqr6tLdphInSpxXizRD4nBICZsBdhwwp88gwApFNNHuw3FvSozbohMq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SySHEsVa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=v03qrO7g; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SySHEsVa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v03qrO7g"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 36DAB7A0152;
	Tue,  6 Jan 2026 01:55:16 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 06 Jan 2026 01:55:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767682516;
	 x=1767768916; bh=et5nr5BWtkX5aHOLQu/SyUWb23ksju6hiEybpd5Tnbs=; b=
	SySHEsVaLf3HLH8O4sSJZ7bzlZP2EdboyvqKx4Zr4MuNCG+7IcQ/HDbSVwarA9DX
	bNBxh9M96tEEYnjfjclsIm+9Ae477G2FpzZsSlSto03iR8fA67+AekKBp64Tq7vl
	UZglgySjx1f1jYfm4TWCH/yygUwyuOFhiBocMOKsPpzPEvSKoO5ZDiXYd6KkkFVR
	N0qCCHXOXqen14EQZZ0Yaxz59Q2v0qWR4hPTPjtz0JzWhvsjZD5a5JCJ3QvinsYD
	9xNYe/W668xKMj7OL1bGaklRh0M4UaC3qO2pSVpqY+Ug4eT8e+Ui0RI17ssCkyjy
	ZrZE4a6COZOMgO/JeqnRPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767682516; x=
	1767768916; bh=et5nr5BWtkX5aHOLQu/SyUWb23ksju6hiEybpd5Tnbs=; b=v
	03qrO7g1UAOvdct9IKFAZjOux7B0kw1g/LVWbdRqfJzKMVpej2rT+tz3Hz0SoVoS
	7GErflazHF7yIRB4rxA7HSJmJrwDrDks5zFVtCXR8bT1BjqGVwJdlB3h9YV/bVpK
	ACjMNkgxVqYxI2nmckXCVJOxQ5utLOTStigBL+spdZpSKR9FbgkoQ7/5okSzMNKW
	3fcz8+ASjGsJ6AaFcalOvn4sn+Et/+SUv2QspER9e7I2LoKdjhwG1ZDyqQlVbPdI
	xPOSy1B9h3RmBt8aVz/rLR7c1yKbsuVvf3Ixg4IMlY7rTZSkv85Saj7ie5sYRkrV
	F+jxSVpDru0IbqKcXSvUA==
X-ME-Sender: <xms:1LFcaVUUgHPTU4JtAguvjOrsm1oqsDN8omiG5VlOayTVMy49bsPljA>
    <xme:1LFcacfsVc8IwBMMuph_CeWJzB_hRipR69hzEQIrKm09Pu8M66vmb0v-GUdKjN0w5
    tI_RIV9hzRwkfTybsBdiuEcVM_EQeEU8tHo2yucu_sEEggMb3-kQ8U>
X-ME-Received: <xmr:1LFcaZst1_Z76kZmJMU0Oa3X47pQ416gjWGqcChgkRhxCi7dDputU55DAZszr_fz3DjBqy-7jLF5xqp-FGzXBDgYERYri-tOA_FHYFVz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdelleehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhh
    gruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtoheprghplhgrthht
    nhgvrhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:1LFcaT_XHGeTPKqsnQPoFOZgOfAJPhimzZ-cyH5fV7p-PKBVb-0N4g>
    <xmx:1LFcac380xU41sjktQ_abexIUFfRStNlg8HOU-GSd_uclZeAOC2ZXQ>
    <xmx:1LFcaQArW5eEPnbhHA9zEKI4dVOYgIKdsT8W-6E9v63MpGiMYb2W2A>
    <xmx:1LFcaQeXrFRTUGlIdv-cZ9_sIP4YkG8Gi80-HPOHkk5UuAoTB4neoA>
    <xmx:1LFcabAecl4re_QLQ-5DGFvjHV_iyNx0aLnJ4q68LEhpkIieAbS6iYnv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jan 2026 01:55:15 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 763b7fe6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Jan 2026 06:55:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 06 Jan 2026 07:55:01 +0100
Subject: [PATCH v3 5/7] packfile: disentangle return value of
 `packed_object_info()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-b4-pks-odb-read-object-info-improvements-v3-5-b5e02fae1fb0@pks.im>
References: <20260106-b4-pks-odb-read-object-info-improvements-v3-0-b5e02fae1fb0@pks.im>
In-Reply-To: <20260106-b4-pks-odb-read-object-info-improvements-v3-0-b5e02fae1fb0@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Aaron Plattner <aplattner@nvidia.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Toon Claes <toon@iotcl.com>
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
index 59d162a3f4..d7cce582af 100644
--- a/packfile.h
+++ b/packfile.h
@@ -378,6 +378,10 @@ void release_pack_memory(size_t);
 /* global flag to enable extra checks when accessing packed objects */
 extern int do_check_packed_object_crc;
 
+/*
+ * Look up the object info for a specific offset in the packfile.
+ * Returns zero on success, a negative error code otherwise.
+ */
 int packed_object_info(struct repository *r,
 		       struct packed_git *pack,
 		       off_t offset, struct object_info *);

-- 
2.52.0.508.g883dcfc63e.dirty


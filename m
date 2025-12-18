Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F61E322A2E
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 06:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766039321; cv=none; b=rgGkmhSoFMqJjDiPxmTh+YbGUd22R6Ri3iy72k8Y14soE1c/pkjNtPgmsH7QBXMuk5ym2UxG7gC1hJ9P/nXZt8PR7CTvTQAlgeZu5sUdNGCFYUPPVVUnCMScA8BbY3xD8I21QSVfjbFumhAOTt7MD75cPLqD49AKNq47uhJS49M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766039321; c=relaxed/simple;
	bh=B+T23ZG9ECbd8wSk0xVxZixxH2xzqBS2oMYD5PcJBCw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=na+Io7xQIp2LPIuStJecAeuSq1bhdZW2j2WLFuzPHnZnA35nmS5P6YfbReDIOX8N5k+S+utQpZ39tyNuULXbAFuYx1Q0lIAoSc2wGBZI4fexFhQm2SAg53gPesOn50VWfMle+MGoevT6LsilLaQla8aSKTShlDWEFmzED43X9TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XyiKr8UQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Krfa2kZj; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XyiKr8UQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Krfa2kZj"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id A3CB01D000A0;
	Thu, 18 Dec 2025 01:28:38 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 18 Dec 2025 01:28:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1766039318;
	 x=1766125718; bh=JWhnclizRHgx8Qp46oKtX9yJOwqeTZh1vR0EhMex8YE=; b=
	XyiKr8UQ++XmdkDkVKCQeanqhYCOPgblTPgE5uPky65gzMcIrqjgq1YHclRqTHIj
	3NBID9stoaBWH5AzoTQwSWKmkkkd5AGl0tuqoDxTiu+6z89gPyWeZ3RUplZmlAU5
	klaF4k/J2R8OqMrw7Bojcdgcb/O+Qg6T1OlKgiFpV34jxZI0ffDk4TP5Gxfc84oD
	WoE6OANvWHTGbNlk2TLmSWDFiAz4x2FY+i3upF43GeroK+2yGhhj3Fp/cMz6afFv
	YF6RCzieICfFTLYdIX9YNg3e5UrrG4ZUkR+panVSYrnMx801+c5RyQD9HRzsGp1O
	W+tU4xSWQxvblbCt1luTHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766039318; x=
	1766125718; bh=JWhnclizRHgx8Qp46oKtX9yJOwqeTZh1vR0EhMex8YE=; b=K
	rfa2kZj2BUU2W2QEvIOQRNCdUVLge1KFFpz5TXlWZFGCVNG06KBs+08cdRYwUQ7q
	oBYXLBO29zqqhOTw5hF5fMKGajxstTNHpVAhfEiKYOWGa8H17+ucQiU+EXg+uyFx
	gPgFynY4FspAnaXGWp3eV0YLrEX951y3dXgf/magV7aNlKL49Zib+BF4SgtTK9Rq
	HJicped9kA7uKkGfAe7y2Lc04vETsnEWABMm9gW+IrggGUUfO3JxukXmnohMxY9m
	LyWlw3uuQij6Mrr9QoJe+SZUJK7RPah2ctF0/LDi0pFb76gDMtQhjjTQHGTs2K1F
	gYgVzyhjhZnWfxYBNfhMA==
X-ME-Sender: <xms:Fp9DafBjtT-RBZZODEEx_jxaHAtYugUUwN_8YrQCQj85ecOWYqIaMw>
    <xme:Fp9Dac8kFwuV5Yx5eFWV_MVfG7b8BUSOHQ4RCVDJVbv1O_aFSjA1zCNzFgK5Pewwx
    zZ8fuE9bbRtdvedeybv1YPoaGq7q-ft09JR8qHBb37rBFRd5pceuA>
X-ME-Received: <xmr:Fp9DaX-uPimkj7GAbVCmvbNsGGqXkNOJc4nOzGCWJL1bby00FW7yCFO27bRFXPagQ1-ThmlZ9G_A4plazbLvVabGFSx4CrfXDYzSqJNzfA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeggeejtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtoheprghplhgrthhtnhgvrhesnhhvihguihgr
    rdgtohhm
X-ME-Proxy: <xmx:Fp9DabfpVMioxUw-K_82gluPkU7tMSiNRCzeH6wRCcusv1czzq2XLw>
    <xmx:Fp9DaYFoNyeFy6iTJdowkwuYn2MWDpKuyHIypKbVTiVtMRmmsljhdw>
    <xmx:Fp9DaRfm-LkdYyZxAlrlQtHkoE0vzjx-BltjXp3pIgnmbeQfgBvgbg>
    <xmx:Fp9DaaGruUrBHhNGW9FiXCebCWIk54KQEo9fU-T2CWeyQfg5UG-3aw>
    <xmx:Fp9DaREAQSTskB7Wt_wVS2oa7pGmQmAJnofzW57K6u_hzbl39n9WrKWR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Dec 2025 01:28:37 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b96c6248 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Dec 2025 06:28:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 18 Dec 2025 07:28:15 +0100
Subject: [PATCH 5/8] packfile: disentangle return value of
 `packed_object_info()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-b4-pks-odb-read-object-info-improvements-v1-5-81c8368492be@pks.im>
References: <20251218-b4-pks-odb-read-object-info-improvements-v1-0-81c8368492be@pks.im>
In-Reply-To: <20251218-b4-pks-odb-read-object-info-improvements-v1-0-81c8368492be@pks.im>
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
index 6e66c90c46..c141b8a7b1 100644
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
@@ -2153,7 +2156,7 @@ int packfile_store_read_object_info(struct packfile_store *store,
 {
 	static struct object_info blank_oi = OBJECT_INFO_INIT;
 	struct pack_entry e;
-	int rtype;
+	int ret;
 
 	if (!find_pack_entry(store->odb->repo, oid, &e))
 		return 1;
@@ -2170,8 +2173,8 @@ int packfile_store_read_object_info(struct packfile_store *store,
 		return 0;
 	}
 
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


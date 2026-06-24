Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618CD1E376C
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 12:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782303583; cv=none; b=NQ1+8cM2snoPS29Ipdl9lNwMu7Qu6A4DYNQgKQmGJlOfBYfuk4byRmJ7wRwIPMngUi9NCXrUK54hA8oymdKTe3jqRIwCDMUUO5hxbEcpUt77nwRJgfZoOOIJdxZQy92Piw3lCcOefanChH04T6aJssOugEt8LgczSEY1LQNSjnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782303583; c=relaxed/simple;
	bh=/r1q/aMcESRjFA+Gbg5rM1LaqZ4/Ut3HTYaJTCubiyc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LmVhwmYtQmb3RCBlpgP+kJz5JQwPDkOxEczACKDMSm9032Jg6N36Fovgw8kicRAIHUX4fhLne7JxIM30/RgXXrLNBMdQXVjmdwgFYurdI6/9IUaxYawRjV78S6CexRCufQQUBKEze9t+NZV/anx9ESlpIHNR/7QcUCpDRX5+hX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AFo0ff5X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PkCK22JF; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AFo0ff5X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PkCK22JF"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id BA5781D000AE
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 08:19:41 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 24 Jun 2026 08:19:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782303581;
	 x=1782389981; bh=g8qOvCJKe6TS0iA6muL6xf4PVQBxI5nMRAGEuvpTU6k=; b=
	AFo0ff5XtYYzrT8jqHnqrdRvKDrxlLO0Quhk6dDSDRpsCQPSpireiCeYR3/g/cp6
	MIol8/AyDt/GnZlRIREHFHjEDbvHn6SEKMo3P0CInh5CmzDji85eRvRxCXWpTFfb
	9nPBhslToT/cOYmd/U/ijevXUbV+TBDIRncwAU0EfjuWCL3Vzi5WcCMd/ClMNQHR
	AIc8oZn/Co10QZf7k8BMMBD2MLsaVTYXWw7mFoS68DCkeXla39NIIMwJES9CS5C4
	3DTNIACTUNbpdbpqseuS45a2kgsGiT859vkVcOA7o5+/dslpwu3lT/qE2Hg8wu90
	ZmxqeosPAXvaV5lNRoKVHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782303581; x=
	1782389981; bh=g8qOvCJKe6TS0iA6muL6xf4PVQBxI5nMRAGEuvpTU6k=; b=P
	kCK22JF6BUGobnN81PV+uMoyECjdRx5nVBXLULzXhW0i4wJFaYuz+AzX9sl/2Juq
	57MKxlxUWT49Wkx0quIDB0gTVZuo6YMkJW3lXETI+qFLzAP2uy+WlNHkNMd+cvBA
	2Sx16MGqbXfiYQdFuzSflEdfqgn/lF61/1wN/QdZsL0sQ3lAwriedvtIdjsxAMnh
	7zjIzqEIybg3Oc0IxKLvJgri/7v9AEjFE/jfyp5dm9wVafhJf0QV/AdIFAE8wNUg
	6x6F8Qm7RsV2VfC5ryXv2ICYFPUjb0oPjN7C/+IpNFwiKVwsnslsGpLi+2C84cLH
	Z84eWr6FesjtJ/FdIQpgg==
X-ME-Sender: <xms:Xcs7aslJz_qSXp_XqXyb11jwByS3v7XeUXISTMbHuEcRLk2qrMEeiQ>
    <xme:Xcs7at1r-9U4gx1SM3q5jVavG_VRKm4_CMQu6K21jvmF4lc_QHIr0-T4t2tis3WtO
    8HR8SHN7_LGJd5JSFRy0P8fLPkBnS9E8payp2sJHWO8SkRoAH6lwA>
X-ME-Received: <xmr:Xcs7akD8Jn3mX2skQ6yUbQbwRDXOZHxVVx7aNEidvXxhmyzhiDb0Wwgw0lb2Rdo2BrNIkKMMGq_nN0OWXDo1jzPh03HwSeUgsU03Ix6L>
X-ME-Proxy-Cause: dmFkZTEtmXOLLIsNiauJ50z8uCvbTPd/pwqieZcH2Ae+uakLkoH3kOReEhbkkicooJJOjU
    tcDMvrRpE9/q8O5xjkoSaUlkAfzOKdQO07bTyGDxNcuwg1SU0kKP4OPNmGs9zHRjM6L1MY
    0nEZ4mxDeCBHyi3E0TxGOr93EUT4EaaHNIbV2+cNezTlVVSLd2cNZHbYDzNuZgQQHeTqNS
    KfEQg6fJ72BRXyd1NUB5iFTHfIX+44W6Yxfglmaqh6C+8hz/GkfBHDfriESZRp93LDf867
    6AXDOAFVHd8R7rZtT2V1MfOWkF6pCaH8HUx6EcLahXPv34NECU9snJoAMK9YBbVtriaAZu
    KBgki6sWepiO5+myv9QHJF8Q2pziF6ZgTgD9itHm8x/IIxZvPB5C5gLn+dGRUjePrXDmPy
    RsF16z9IyV14k6BKAadC4hQqS382BoXUgSXGYTh1j0TsjwefrhZnk1K2rhNMoVQ3qpMTl8
    rFrA/WnfxUWZKbS01Pr2cvbcKvWeQ/bVLzZHl9jxeH9z7U6HrQK5HQRFvMA563RHJKwjDo
    eIxZskkpZwBP6Ng215IrjY/R2bTC9t6SF9Jl7gQ9OWGXC/zA+KPZpbrT7QusSWthw2hORT
    INb31jafrgcP2dtWDlvb1+4sGGc5FY5i3u+VAgTYm/cZUcXvk/sabBRu8TKQ
X-ME-Proxy: <xmx:Xcs7aqzcX_wb3ODerkcCsKVZJDI3eea98oro3s8lw-SDrVxcK8B8UQ>
    <xmx:Xcs7ailqTu1K3EaHx4u58F7g99wospVM3vk1QpStO6mH2B6ho0ABFA>
    <xmx:Xcs7avESj_hxWg1cdlZy3RL4vk-9Ls7_ui5Uay9RswGFExzmMZ-VxA>
    <xmx:Xcs7aiU2r6y6cnhLUDoE4zVU8nr6dmKOAPbi_vNODuOM5pnMxZssCg>
    <xmx:Xcs7apuEKyQy4AUNANgT1OaYNxwNrrC_PgwHqN4hICfoKxU5ig3kPc6b>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 24 Jun 2026 08:19:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 29d249c3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 24 Jun 2026 12:19:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 24 Jun 2026 14:19:18 +0200
Subject: [PATCH 5/6] odb: drop `whence` field from object info
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260624-b4-pks-odb-drop-whence-v1-5-8d1877b790ac@pks.im>
References: <20260624-b4-pks-odb-drop-whence-v1-0-8d1877b790ac@pks.im>
In-Reply-To: <20260624-b4-pks-odb-drop-whence-v1-0-8d1877b790ac@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

In the preceding commits we have migrated all callers to derive their
information of how a specific object is stored to use the new object
info source instead, and hence the field is now unused. Drop it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c                 | 1 -
 odb.h                 | 7 -------
 odb/source-inmemory.c | 2 --
 odb/source-loose.c    | 2 --
 packfile.c            | 2 --
 5 files changed, 14 deletions(-)

diff --git a/odb.c b/odb.c
index 99f4e7551c..82c41f1793 100644
--- a/odb.c
+++ b/odb.c
@@ -691,7 +691,6 @@ static int oid_object_info_convert(struct repository *r,
 			return -1;
 		}
 	}
-	input_oi->whence = new_oi.whence;
 	if (input_oi->sourcep)
 		*input_oi->sourcep = *new_oi.sourcep;
 	return ret;
diff --git a/odb.h b/odb.h
index 330a55879e..e0d05eaf87 100644
--- a/odb.h
+++ b/odb.h
@@ -311,13 +311,6 @@ struct object_info {
 	 * or multiple times in the same source.
 	 */
 	struct object_info_source *sourcep;
-
-	/* Response */
-	enum {
-		OI_CACHED,
-		OI_LOOSE,
-		OI_PACKED,
-	} whence;
 };
 
 /*
diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
index 2328e62687..008e49bfe9 100644
--- a/odb/source-inmemory.c
+++ b/odb/source-inmemory.c
@@ -54,8 +54,6 @@ static void populate_object_info(struct odb_source_inmemory *source,
 		*oi->mtimep = 0;
 	if (oi->sourcep)
 		oi->sourcep->source = &source->base;
-
-	oi->whence = OI_CACHED;
 }
 
 static int odb_source_inmemory_read_object_info(struct odb_source *source,
diff --git a/odb/source-loose.c b/odb/source-loose.c
index 5c4e9892b5..e743ccab42 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -198,8 +198,6 @@ static int read_object_info_from_path(struct odb_source_loose *loose,
 			oidclr(oi->delta_base_oid, loose->base.odb->repo->hash_algo);
 		if (oi->sourcep && !ret)
 			oi->sourcep->source = &loose->base;
-		if (!ret)
-			oi->whence = OI_LOOSE;
 	}
 
 	return ret;
diff --git a/packfile.c b/packfile.c
index fa22095b75..4a8c108034 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1421,8 +1421,6 @@ int packed_object_info_with_index_pos(struct odb_source_packed *source,
 			oidclr(oi->delta_base_oid, p->repo->hash_algo);
 	}
 
-	oi->whence = OI_PACKED;
-
 	if (oi->sourcep) {
 		if (!source)
 			BUG("cannot request source without an owning source");

-- 
2.55.0.rc1.745.g43192e7977.dirty


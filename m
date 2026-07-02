Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D9C496904
	for <git@vger.kernel.org>; Thu,  2 Jul 2026 12:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782993742; cv=none; b=AbwwMjtVo31EXbeRTFkdBC/x/y178mBathSiqRxlHTBHQ3Uv4tYuqUoQWSrlu5CaEIYoFlTbYfdfuXsJopHX6ym+CEg8eu/2T0OwQgwGYhsF2MFfL89AQ31Y6bbycIS+yRyhnuSMCncay+M9Lt0SRBL+nNwbEZ7/NRSJ2LLEo/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782993742; c=relaxed/simple;
	bh=xHhVyZBqJpjoFtyjMWXLSvmoPGxq5f7vRhApQ3koKBg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UHEieB/+W1tGnP2heQ8xImNapY+CIm2FD//n9AUMbtzpXHlQ9kqRvQ8LN3VqgHP0+iD32zGAynHOLYBcaDHvzdghxxKC0iRrlkRNPTqfhh9/EDKLzPRuxqnBAOwIWikAQ+cyFr60fG64CMdvRB5csWkLWTXSp9+1yKzrGmq5M/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HOHywAf8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G2RCUFwR; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HOHywAf8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G2RCUFwR"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 1B4D91D000D7;
	Thu,  2 Jul 2026 08:02:20 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 02 Jul 2026 08:02:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1782993739;
	 x=1783080139; bh=o6QW6FifP1IQQc5ew+YYP4DWDg6skIkSADre8zPiISs=; b=
	HOHywAf8sOQ9Uel+4Wid1OoUZRTNRTVIYeNqMg7F5mPbDIK2OwdZZCd5bqLdcW9+
	t718wMEMvYwrFW81dMnoIMOFbggTuCMzGcCGEG/nOUB11tKCbKuFwKUJmzsPhEla
	rxcqVJ+O7AJu6mj9WuV7N49+y5WRC637+X5akFgrm7clQDSwBgPgvbIuBwLXEm55
	N5nloy1qqW/mu7c9lGdOO1X1ftcVFsGk6dOIYUGCG/oNWrXIEL/D17b+z4gWqLWZ
	toudDk/EH8C2hGP1CbORwnZgoJr4SZuS/bvztrclCgpau+TPJkcFiS4pjHHADE6A
	hlj8SaYA/DpKrJvQSUYk/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1782993739; x=
	1783080139; bh=o6QW6FifP1IQQc5ew+YYP4DWDg6skIkSADre8zPiISs=; b=G
	2RCUFwRUQiFB1GtnqxWBb5M9mvCoWZnkxvCAShRIHCuQ8ohIJOX/dUw41iXv8u4s
	Qy07RFnBdRvPSCNmasPD2mDvzgnTGSGCfj+Qd5SwYvGAA8pcvcsEnN2h+KdnX2mm
	UnYmXr9pHcPqXX6S68HDcgG2ilihpGuiFarhh0xAXICMiECY2mmjjJKrIH9HIcNs
	kyPyjib65E3FxItwTqInENZX9w8+IGPfzTNqD9VDC9BqlNyVGfWbK9LxH8epeSej
	KqjLM5U+QjYklfghb+VeFWD7QWn3972IFeKbi3ZIUckj9UGsBjuGFU+QKMgbj7Ep
	nV/ePY79IjqxhWyhdsRbw==
X-ME-Sender: <xms:S1NGaqB1ncMhXSx4oelApYlp4fpAOLYUTFWfjQ5VM9IkzbKM_TZ3iQ>
    <xme:S1NGar_MCqOPrT9C2w_oKsZFa_y_ff0A3uIWCxgteUFu46_9NNbTPHEBIWXlbXk98
    mLQoGQVoOJBv-yJo4v1zRJsF4UTO3Y-ZFaYnhUa6QeBxtwpyeKCgA>
X-ME-Received: <xmr:S1NGaq_PHrZGGi0sSgkXPQHxI5usfhcILtVrTFaVz2MyIMFmCzmvlBhokh7JsRO31FAMJW27bVKLzX2w3cURkJ1qRZ8mUSwFdHRx8JJ3ZmeJ6Q>
X-ME-Proxy-Cause: dmFkZTEdVSM+JlHEMpaGMYk6VQAzmlC54P1ecMLvSWNfufarlrh2t9EBtuoJigHv5iI9iS
    5i0hz9M8jy9i5XJs9jun76jK4coeeNLZwgnp0/GESifkkgvxfaz/Ahu65evKVS22SbpQoU
    CpNuSxUMJWmKM6YBolWAZ292TrdAoPJ1iAOfs4uxb8fqSfDcJli8H9i5CqdetJcuRfpJtk
    8xnaJkmbgNL5MMutmdNW2bBThDVGwBM5SxgEN0rxpBKWc9qCEhlADAF1bc1VC7ftmQvZQ9
    AZELavfHj0GjG76fdiT+SAaw6JTL1BkGc3IlU1ZGxFWf2qPr4HeKUwPJGqFB7PcKl6rwMp
    aDNu+FhGhRW25zTQqUxiL4KLbrO5rpbgKkGFk4TAZrlV/p3gV6wNclrTeq3MchZW+Kcj0n
    Kg5aBW8Sm0lBkBNLKVLEyEhNN8mt/wWSosuWlSrP3Xeu9EG8D+gXfzRBCGjhrUZbifmWF7
    b/giuEWBlCE4UfeoxjwtVhXjYypNwCJRGVF3edl86lZ+xQinmHiPNmOmiAIg5LEPx1DNYe
    tN6OUTUHEUjgp2sXFncYVqV1DQqZDluIFkZ2HcXmSSaLCFec/wDv5Xnhy6s8II7Xl0p7Dl
    oVZiXVOr8rK4As6DN3e/lQo2ds5/FTYWFC0PcgUUMKTSlKe9YnHz1FKRc9Lg
X-ME-Proxy: <xmx:S1NGaicr1FnMZ4LaPbQIhm7DwMECHj8IPJBGtoFYqMr4J3Da76tGnQ>
    <xmx:S1NGajHlcOJNho8aBN4oOZ7v2Gu1PmTb44i40C4hVhv4BxOaCKQXHg>
    <xmx:S1NGagcduali5ZBlC1MI6XPKuRXDuGvKS36RGk0cKrsmpPnB7mW6jw>
    <xmx:S1NGatGvLNbZ7sNwWbMvQ4HixXSjiIet5-vcsUReL-gHVPgeRcrFsw>
    <xmx:S1NGar870b-KyMfCOUdw-nK0I8HF3oCYwZeDjPHafLuvFdPvrvpuin0u>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jul 2026 08:02:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 539b32c4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 Jul 2026 12:02:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 02 Jul 2026 14:02:04 +0200
Subject: [PATCH v2 6/6] odb: document object info fields
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-b4-pks-odb-drop-whence-v2-6-b0af7468ad95@pks.im>
References: <20260702-b4-pks-odb-drop-whence-v2-0-b0af7468ad95@pks.im>
In-Reply-To: <20260702-b4-pks-odb-drop-whence-v2-0-b0af7468ad95@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

Some of the fields in `struct object_info` are undocumented. Add these
missing comments.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.h | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/odb.h b/odb.h
index c251788d50..a1e222f605 100644
--- a/odb.h
+++ b/odb.h
@@ -283,12 +283,28 @@ struct odb_source_info {
 	} u;
 };
 
+/*
+ * The object info contains the query and response that is to be used for
+ * functions that end up reading object information. Callers are expected to
+ * populate pointers whose information they want to request.
+ */
 struct object_info {
-	/* Request */
+	/* The object type. */
 	enum object_type *typep;
+
+	/* The inflated object size in bytes. */
 	size_t *sizep;
+
+	/* The object size as stored on disk. */
 	off_t *disk_sizep;
+
+	/*
+	 * The base the object is deltified against, in case it is stored as a
+	 * delta.
+	 */
 	struct object_id *delta_base_oid;
+
+	/* The object contents. Ownership of memory goes over to the caller. */
 	void **contentp;
 
 	/*

-- 
2.55.0.795.g602f6c329a.dirty


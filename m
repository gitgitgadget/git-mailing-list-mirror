Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2779E32E75A
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 06:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784096579; cv=none; b=kzNNyXynz6cjIcwc27HSsrjQqkwdURMEePo/GmBRiBgXka4A/rs1hlNRWwGWEQI0GOrQyD9a86fqZ1ud2SunpoksOiUyGoxODY7aEhytCG9G4yzr7lJPdAJXHeiRRptvrF5pSU0YkoHDTCQazj2Ujf+hek76vuPwO4Iz3v0cWBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784096579; c=relaxed/simple;
	bh=oHvCBUOFdwi7KhJ2CTwWGxubhE2bRbfOw7PDeGyfU20=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QxduCcT7QCYGKCMmhUZ9PtKN7GWrXSVRntSXtud5A/ubvQhkb/+TjonzOPQQUz4tKpHAAPasKVqIGPa2EGCm2YN/5HtCwjOfjnMRbYWp4hB+841ij0OI7zGoG8uis/KHsDLCaIPdHXOpSFETMZ10DMiH6nc5Bsu805I4285E95E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mIg/sC2T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TZCHhOGJ; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mIg/sC2T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TZCHhOGJ"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 468E27A0149;
	Wed, 15 Jul 2026 02:22:57 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 15 Jul 2026 02:22:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1784096577;
	 x=1784182977; bh=NC90gZW42axOXpJfLOv1Njhi+uXG67bJ7YMkUDnQIjg=; b=
	mIg/sC2TKJELMMLLQb6Hf9AYyaAGxDPtgjLd8MraH8I2fajcizq6KnUOitS/rPWh
	GpEqklQkXrWVLmDDTlx4bwV80SV/ZmZwGF2zNqN6PR/gGrNLmzxe35Cbxls+WXqj
	IO6VQ8COCaF4pQhvXcHkdEodpoSf4rXDCOsesKDMlC2dTAJ8ahf9sYszOIOjTl6r
	ZuMOKUOgYUAkTwRACoXZWoGDH55+joUPst0cOLI9hgAV+5MCOD1FhIdsSBClNTRz
	76LCYOu22Hivj3Lz+tBXpfVt45VLlflR3gpvy/Mrl4F+S94mDRUn8Utz6JlLWERH
	XYMRg4byrDi9St5QVJubDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784096577; x=
	1784182977; bh=NC90gZW42axOXpJfLOv1Njhi+uXG67bJ7YMkUDnQIjg=; b=T
	ZCHhOGJ9XdysBNUn2PAZJ9YswqNGUErBgdebrM9TTwVnOLKC0Ya5Cr7Ey26N7GA8
	c0jP6zzU/PulCHjVLh0WrEO4x55IJpjNPG9QQoSE8gQ/64s5D/7yDLpMVvNLKFo0
	9nnXHOWt/m/Hhcselo4jEt7kGYC8P4hRG1jz+sUkv3jltndeS5RzHn4OThUEWzbW
	NVo69c087XVi9oi8c//X69ErvH/hXfru7/b5HNed1tdmKdxNNowHn57NeZIzF9Pm
	Jb+2xN9p7kjkXg9oAASe2KFpJt+Qfl3YKKXbHue5DEYgqHy+ccQkjx8xNtIZRn3g
	b0HVppn3+EwiRN2xskqxQ==
X-ME-Sender: <xms:QSdXavL6wSaV1Nv1qNJyUYCac0k3SAvq4QJ9uYKS7W1v14CR74KOLg>
    <xme:QSdXam2GlvJ9HTJzEnfFOD6AuyL7vwMpf2OhH_e97PXhEC_5XmbjTbxbEnLkkHnJU
    e-O5gLSl5R2vgHMkQoe47NVpRl2zSZBMka08PohWNYuagCKRuXQWQ>
X-ME-Received: <xmr:QSdXahiFHEJtEeachl45zMBi-PSzawGi4-Afr-VELAW-OkU84c0lsakTwuDp-IDyUiJwBCRjpsvbZmC4gI9lzrqPrG5NRdpfpOjtYs0q2nw>
X-ME-Proxy-Cause: dmFkZTG3d8BgpCjexbgNjgZIPvtwSf5ncnlaNbKLWnCsruBermBFbvgXKjzgj6asvGcJXF
    7JAm4EV5SwVDdx7mrpNtk/Q2EmglLOGX3C3Bu3FzRwZ9iYfjMclJN/MS3L803AquvxSs7W
    TAN2MwZQOQWAjmzsvqaZmMMOb/3MfcJYuLBDWPuanZTG0KioEHsX9Ix2NP8d7zJvq56AM9
    k4jKMRpcHhX6egGl8qkrhk7HusegSGOEflr4jZ0XDclR4g2GRt2hL4NOZEVvAy3Da/WTEA
    ASFLMzeC7hKO11hvI2QOrAE5SDH/+mSyCcL3C5WgrbVVWHXxEbIGKCX68+nYcn6GxMt2pa
    YocXkDuoYHeS8Iz0lhBKVy7oyoQmkCo3SQSrjNxxkqzssq3nXn7+sWxIifbCpOPNQJUKAM
    BM3fZH/pZ4LNpLyNiwWDnSV1iloFqt/28K3G8rnwca2Q5uAxoA37XtTAgQctHVSU2MRHWV
    lh7zLIUJ6Zae0PU8X2nh3mMw5vW3z/O6ZcqZ/yBwvMnROr8BEGeCUrXEOUxMkBM0FPr4mb
    gSmFFBRRlL5KefL/h0sUxGmcsTnR5MuWo21vquAw9kORXJktO8JI9FETAR7EUcRigmfURH
    TU0yJ1itzLEMNaB8ybLfRejoFVZByE16zPvE9HvuadF6gTP5l+cpaNfytwbQ
X-ME-Proxy: <xmx:QSdXavWqxSucIVFfZ1H7LNOmmB-B3DF8RwXR9KY3R9lWnQtx0ddomw>
    <xmx:QSdXaoW3E7GSKxCHXq8cMrQipW7C-v4DHZsnM6mn42V6uSX1an3Oww>
    <xmx:QSdXanjAEjBJ_r51hur7mbqeN9glm0WRGj2NSnsKcOiXEatWarC7Zg>
    <xmx:QSdXarY5kN3Pr-TBu0xEuwXSANfoeBzC-4S2DRxluxITxu92yM6CfQ>
    <xmx:QSdXagAB6Xj6OiZOz0oLf_v6DW-R2RRSTLvaFOxrq77DhadbegQII3s3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 02:22:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 34fa8c28 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 Jul 2026 06:22:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 15 Jul 2026 08:22:37 +0200
Subject: [PATCH v4 7/9] pack-bitmap: introduce function to open bitmap for
 a single source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-pks-odb-for-each-object-filter-v4-7-616d7adf7fb7@pks.im>
References: <20260715-pks-odb-for-each-object-filter-v4-0-616d7adf7fb7@pks.im>
In-Reply-To: <20260715-pks-odb-for-each-object-filter-v4-0-616d7adf7fb7@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Jeff King <peff@peff.net>, Taylor Blau <ttaylorr@openai.com>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.15.2

The function `prepare_bitmap_git()` opens the first bitmap it can find
in any of the object sources connected to the repository. In a
subsequent commit, the "packed" object database backend will learn to
use bitmaps to answer object filters when enumerating objects. That
backend operates on a single object source though, so using a bitmap
that potentially belongs to a different source would be wrong:

  - The source would yield objects that are not part of the source
    itself.

  - The object source info would be attributed to the wrong source.

  - With multiple sources, each source would enumerate the same bitmap
    another time.

Introduce a new function `prepare_bitmap_git_for_source()` that only
opens bitmaps belonging to the given object source.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 pack-bitmap.c | 12 ++++++++++++
 pack-bitmap.h |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 72c8ae3228..09ba15d26b 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -753,6 +753,18 @@ struct bitmap_index *prepare_midx_bitmap_git(struct multi_pack_index *midx)
 	return NULL;
 }
 
+struct bitmap_index *prepare_bitmap_git_for_source(struct odb_source_packed *source)
+{
+	struct bitmap_index *bitmap_git = xcalloc(1, sizeof(*bitmap_git));
+
+	if (!open_bitmap_for_source(source, bitmap_git) &&
+	    !load_bitmap(source->base.odb->repo, bitmap_git, 0))
+		return bitmap_git;
+
+	free_bitmap_index(bitmap_git);
+	return NULL;
+}
+
 int bitmap_index_contains_pack(struct bitmap_index *bitmap, struct packed_git *pack)
 {
 	for (; bitmap; bitmap = bitmap->base) {
diff --git a/pack-bitmap.h b/pack-bitmap.h
index ae8dc491ac..9f20fb6e56 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -9,6 +9,7 @@
 #include "string-list.h"
 
 struct commit;
+struct odb_source_packed;
 struct repository;
 struct rev_info;
 
@@ -68,6 +69,7 @@ struct bitmapped_pack {
 
 struct bitmap_index *prepare_bitmap_git(struct repository *r);
 struct bitmap_index *prepare_midx_bitmap_git(struct multi_pack_index *midx);
+struct bitmap_index *prepare_bitmap_git_for_source(struct odb_source_packed *source);
 
 /*
  * Given a bitmap index, determine whether it contains the pack either directly

-- 
2.55.0.313.g8d093f411d.dirty


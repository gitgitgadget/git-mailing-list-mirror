Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA863AE193
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 08:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782289423; cv=none; b=i5Iio3duYb21iRE8UttD4r/23sLPoOC1CsvQEu8o3v1L5szhlDE9V9kMA2U05RdBPxDs2gU/QsJBkd95AhODtTj6UW1LL5caupuxbFSaAAD3JkVVywFDpR/slQ4uLq/ORva8919q9i/POt2+y+r45RKfnip9TdWsN9TyBFMyiGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782289423; c=relaxed/simple;
	bh=gT7s68YRAQQL31CrQ+t0Q0syoWeXFuIuC0wscCUhZRI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CsB+Bvi9Ui731S4SsSNGUv9/y7SRUrDkmc9T/5TO2/TuYAjDJ1xtQBBZNX2OT60L2aotJzyuYyk8cOOtKF4fSKBA53KGD7GEKmblg1SvXhYg5TGZsox1hX6MLwsYbCLY7JL6gGNL6UQrhNgulmwP003gHmxQWyE2dXuPWqKeiME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gPCMxvzG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kdnLez5h; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gPCMxvzG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kdnLez5h"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id D3BE11D0004E;
	Wed, 24 Jun 2026 04:23:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 24 Jun 2026 04:23:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782289419;
	 x=1782375819; bh=wQzTu7oS78frQFDKNbobN15Llzczc1GLb3fOS2U1Ziw=; b=
	gPCMxvzGVOGjfQARHR221upOVDN5ybP/C8whY29qGwXp1kOaixfX7SCnIaGrIPu0
	Xty+n6sq7/Ri3JJTQbOTWhc7WameESOc0buoDnw79WfHNZmPKRgj7rPrtK+TNblz
	LZsD2DprojPVLyWbi64v6em1eFmgGO/8yt72IcMK6D6aLJmSxvVDxzWdSvdZAOXW
	WsS5ugA1wdxYbkV0QpmCgy/OWq4NVR0lKFvs/hjYhb7Xc89GDFCPuEdo6NP7/Qzd
	ING/g5k06G0sfejU2+VefkVF+ujUfYWvD/GoatZ+b9Ch43hHBb1MYstRyEVOq9ej
	0ey3KsmsMnrT27Jy4Hnjfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782289419; x=
	1782375819; bh=wQzTu7oS78frQFDKNbobN15Llzczc1GLb3fOS2U1Ziw=; b=k
	dnLez5h0hw/Ai9zzG2HwdamFfIhJQBqM33rh0sGfGrD0S0sN2vKhOX4xcgnv4z9F
	SXi1B0OvsH4uN9zn/s2nVVMCHjixI88C32nb9aoKt5G9rX1xIieJwRyb4Ols3r0k
	91KvdPkFN0cZhHz9+QqZqGX1HuuGvhjo5Ndcd/1bf/sZA6KaHmfIXTIZ/v/igvYg
	s7y8Lcn8qq5cl5ldwrSQppX02tMenIAP62d/eiSegHpEoygoGdJO1prgZxyZcAIa
	e/NbAKlAxoy5RlfwjLABk24/bXue080oMuA4TWimD3PjXa64jZfD/9XU/HtSYfhJ
	C56wJbNpzfdn2QT6ow3xg==
X-ME-Sender: <xms:C5Q7aht-KEXwW40d3BHpyt7WBewI2E1kx966oefslrK13fkWJ7FchQ>
    <xme:C5Q7ageTAVd9L9gJlH4Axn8RPBCTQ2PhPBtVorBKeok5L2LOnhXgG2w8ayYOcwXj-
    w3X8rZd1UYdZVYifO7fa25UxkrOm2F0DNHnuk-s6XSDCCYXEslNwZ0>
X-ME-Received: <xmr:C5Q7aibagEbvW6hc1vyQ2UPWU7aKLLghxmTlLwkr-CIuWkCb4NHoCUVqgSW8zIaid6E-3MdNezeOmrKPP7oTD5P1FuZ-blaHATdRpIX1>
X-ME-Proxy-Cause: dmFkZTGhdet2ItwvUgz4oa9q250EhFHQ9U9tz4O1dL/XkJ5ZyFJJUQRFo4JQGGhKAyPcTw
    gaBBFW6bmgaIg9Gk2pxYRKh4o03P7cXmavet6k4nNUfWpUB5maJcrY/0k3qBdWpOihdPPW
    VfpQakKkdUFOuVzqvKaxLNlsavE7w8EdKPcQLjjH5YGELDuEjIzSjXnjr5FtC2IYHPQgOV
    Pyxw0OseW3D0aOlB9vgDiwjkdWIDplMKgSGEmR79G1GeadT0fMn3SS474oZ59AvPHa5Usc
    glsBDsy91qgiZSuMvIIJLFZh79VH2GT2rRd+Sb6LxgcHl1kZui//HgFfhQc6RwVSpVAcdJ
    Hryw3VR3BYg7+7IxL/SSnLoDGH5FPq+AEAQ5KxA6cLPvFEk+FFyiO8Fb8Mzmirm9UXWDFs
    UX3jRUcad8VyZ0UwH/+HOG4vd06OOkTBR3+gIJi2cjEANWcK/ADZ8OH7vqkYxSvwWAbSp7
    B85kYghl26aCBeaLtGrmnjZeUYGlfgEwxqFINiK7+jIaGFL1aLq3o/qyrbozhVHscIdBq0
    YBWrotlt7tUHB/ANJztqT+Cy/hIRImsPgiHjDVoxpfPrO3COiufgxRgl0L4FEjdzj/X4am
    60mYsBDcGkjg2A/xCMWduFohD2SIgzaVy/vMeXSHC8ZIZv43KTuQUeD8H5ig
X-ME-Proxy: <xmx:C5Q7ajVPvf-mt2beyDKKUTcdNOLfb50OKggmnQfSFUrJxWVPq9YTSA>
    <xmx:C5Q7akjVZt2QU067t6aI8tyx2F8gXV1DFCNPOzqKeNdrSc25pHAARA>
    <xmx:C5Q7ahVrX1T6g-AWA80ZmKhU2xcdjU9ixokXvvZ5k9AOwjbCvi1F6Q>
    <xmx:C5Q7arMoxm88dWR3j6S4YFrV08RqgULoy9chOW0ti-BxScZ9ptYRRg>
    <xmx:C5Q7atJb3pj3VhxNXt6zIZUNuRKdRg2ONGhCPv0kyRuXpLiB8z16r1w7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jun 2026 04:23:38 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 10615a99 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 24 Jun 2026 08:23:38 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 24 Jun 2026 10:23:07 +0200
Subject: [PATCH 04/11] reftable/record: don't abort when decoding invalid
 ref value type
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260624-pks-reftable-hardening-v1-4-66e4ce87c6b9@pks.im>
References: <20260624-pks-reftable-hardening-v1-0-66e4ce87c6b9@pks.im>
In-Reply-To: <20260624-pks-reftable-hardening-v1-0-66e4ce87c6b9@pks.im>
To: git@vger.kernel.org
Cc: oxsignal <awo@kakao.com>
X-Mailer: b4 0.15.2

When decoding a ref record we read its value type from the block. In
case the type itself is invalid we call `abort()`. This is rather
heavy-handed though: the data we're reading is untrusted, so we should
treat the issue as a normal and not as a programming error.

Fix this by handling the error gracefully. Note that this also requires
us to set the value type later, as otherwise we might store an invalid
type in the record.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/record.c                |  6 +++---
 t/unit-tests/u-reftable-record.c | 24 ++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/reftable/record.c b/reftable/record.c
index fcd387ba5d..1fce441930 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -388,7 +388,6 @@ static int reftable_ref_record_decode(void *rec, struct reftable_buf key,
 	r->refname[key.len] = 0;
 
 	r->update_index = update_index;
-	r->value_type = val_type;
 	switch (val_type) {
 	case REFTABLE_REF_VAL1:
 		if (in.len < hash_size) {
@@ -426,9 +425,10 @@ static int reftable_ref_record_decode(void *rec, struct reftable_buf key,
 	case REFTABLE_REF_DELETION:
 		break;
 	default:
-		abort();
-		break;
+		err = REFTABLE_FORMAT_ERROR;
+		goto done;
 	}
+	r->value_type = val_type;
 
 	return start.len - in.len;
 
diff --git a/t/unit-tests/u-reftable-record.c b/t/unit-tests/u-reftable-record.c
index 1bf2e170dc..9c95083ef4 100644
--- a/t/unit-tests/u-reftable-record.c
+++ b/t/unit-tests/u-reftable-record.c
@@ -11,6 +11,7 @@
 #include "reftable/basics.h"
 #include "reftable/constants.h"
 #include "reftable/record.h"
+#include "reftable/reftable-error.h"
 
 static void t_copy(struct reftable_record *rec)
 {
@@ -202,6 +203,29 @@ void test_reftable_record__ref_record_roundtrip(void)
 	reftable_buf_release(&scratch);
 }
 
+void test_reftable_record__ref_record_decode_invalid_value_type(void)
+{
+	struct reftable_buf scratch = REFTABLE_BUF_INIT;
+	struct reftable_record out = {
+		.type = REFTABLE_BLOCK_TYPE_REF,
+	};
+	struct reftable_buf key = REFTABLE_BUF_INIT;
+	uint8_t buffer[1024] = { 0 };
+	struct string_view dest = {
+		.buf = buffer,
+		.len = sizeof(buffer),
+	};
+
+	cl_must_pass(reftable_buf_addstr(&key, "refs/heads/master"));
+	cl_assert_equal_i(reftable_record_decode(&out, key, REFTABLE_NR_REF_VALUETYPES,
+						 dest, REFTABLE_HASH_SIZE_SHA1, &scratch),
+			  REFTABLE_FORMAT_ERROR);
+
+	reftable_record_release(&out);
+	reftable_buf_release(&key);
+	reftable_buf_release(&scratch);
+}
+
 void test_reftable_record__log_record_comparison(void)
 {
 	struct reftable_record in[3] = {

-- 
2.55.0.rc1.745.g43192e7977.dirty


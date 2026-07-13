Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA37814883F
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 14:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783953698; cv=none; b=ErBO8EG7aBVRDg0ZLeGLgRRTAmm9+PxruZqQRDhJnkd+CvkHhuNXFNelLbmw5h/Bl7Cozusr2jz16WocboQBWdNSnRCoHM26PsTIlHTuBG8OErrAlA9WeRznE3arbOBr10w4GLCVYGet+w5kZiixkUY+yTxE4tCb9l66C4ubdiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783953698; c=relaxed/simple;
	bh=/hMSysPlI8knV3KeQJ0AcPKsr8dChrKP2cVFd0LS5sI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E5VaVZ4gzTo9ycTSmSoaJQ9Qm25vRTYvBX83YY911QKtngRULsvwM4ULNxv5Grl/aMT7v6dZGXDs1G8PRTm6CGzUTnjazLA2K+KJ6VNe3rh1QqfCwkxnu9EYVUZMLY3itm7RQTVgZMZ6i/QWC/FO21wO5am8KSTlk3CgVvcAR3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hwdqsyRl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EW77+9A/; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hwdqsyRl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EW77+9A/"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1899E7A00D5;
	Mon, 13 Jul 2026 10:41:36 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 13 Jul 2026 10:41:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783953694;
	 x=1784040094; bh=u/KYJs4R6UmAlSxz1SZtqf9XD2+tbp6s9JuW/cdNqvA=; b=
	hwdqsyRlLjxqKFPReb55Ui38imarX3rR4YNftyP8sgEvZqHT23IB1etrv3fko5Uy
	HkG/AvR8MBj8P77HKRILdNn6sE1AhMhknLKM/O+XECQmfmvMh0tMhxcWbYruW47g
	AL6iIQsTXglmy8g5+FhL9B0CXAqWyqPNAQMIBYtnrIIrSzISD50rE7u3NdIXLQ4s
	a05pB90Pkq2gBKKHxUVwMFQtLR53mQIgEd14nR40PqUuT29XSYqPxiMkXnWRvkTo
	xY0S1s3vJGQ0bB8cremfKFLK5r4MOe1XaJrCihDWUtmoUUdVUozl1miIe0vApMOG
	b93wK+1GgB+sAOjS14gaOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783953694; x=
	1784040094; bh=u/KYJs4R6UmAlSxz1SZtqf9XD2+tbp6s9JuW/cdNqvA=; b=E
	W77+9A/8t9ee1f6R2DAA5mEvVdg9+FxTsOuve48k9Po3sYhaDqx/4NMT5Id6iHtI
	DUmGaJy9JcABnOKnLO7wysyTn76qch9JCKbgwMnj4cPfx5cl0MDyJ7DFB9JuyyTq
	yNrsy/cHZ9+gW5mpaLrj19w+WeEGlUGb6GRaZ+hW5mgvG5eUi0IXw6lcy/1fNzAr
	qOL8yX/4vCLdth6YVeCsvr1OPm58QHS6PZVHGdBnm0kQkvCzISWlepRaJ6W93SGY
	20JX0Anb+NEHMAb0EgWK49P24sl0M+VjKoMvzBQS+JviIm0nVGpKBxyxOxl2XIPh
	JOmTbM64oZ/l8co1xoIXw==
X-ME-Sender: <xms:HvlUat-ZuThuYjja8-dQEiEikmUgPu6NIyQbgaDMMokW6QttDqt5nQ>
    <xme:HvlUaonEBT7lCddpj1r_FnBlL9kXdrADSIWG96ct95B0GLpXZ9KBeFjRbzRrrtVZ0
    kFfLduyCoRN0Z5G7tg62GfT2fyOcjSFs5hYM2QUPaHFS0yGw4ym5Q>
X-ME-Received: <xmr:HvlUajVXZjaH3IyHhTwI7MlJoR-Qq0WhH_T4-HJ8I11RqU-duN30I4oXDqs60ad_TDd3C0aP3eJOtZree6Xjn__eCgYygszv2Z_SH2VI>
X-ME-Proxy-Cause: dmFkZTExU3AaOgeG5BObJ1W8JdQQ7fecPK0PCMuQHCnglnCgDOzkQC0YGMEj1qcLJSgMeY
    LASbvC4Tndv63coRGptPYG0Us/QPdorbjTjJ5eG4DbvGXhIArpLYSfP1Equ8XG1heJbryq
    UDpFgrp5VTZtDpEG/07Jwy4Ag/vYtEFOYaVrF84nTGMkk2meJjHZ4oqMYl9DO/bcxScRj0
    raM+378SqfjY/MjDn56wLasjqjj0AnRoiM+HE2+qWeFjm8zVJqFwrMNDwJJ51dMxeJILN0
    DY3JMGfUUBMmVXNdlp1KiUwRzg3BnBn+tX0Xx+zOe7dMF8plSZ04smH2o1tFL5zomOi5MJ
    dR+9ZWLD6i9DlUTfs7sk1h/TeXlO9ZlZ5yDJ/36Yz7gEIeRf/us0qMOfFKaZPdnd2QqRyJ
    gViT3vywkfyDUxrfIVfR5PKzLq+ajz2y3IFFmOy6z5KalYZOZYVtWdCjoj/O7Qwj7psu9M
    pYBYTcf/YzJB+wUetzDmu0aEd6OBQLU3ylf/4YC2hVEfw5Jsg0rK4BqV7B9s9w2nAMG4lr
    IuT1hcwsVJuF9B1MwUNn+aSeIVnzvpUMUcLbORNy6XEmrHbCnF0iYNSRd7qLahBWaObKvf
    wz9up+U1nLWsNYs7S/iFpGkG94BQ7po5cze9n4wMxPcsBwGAjqKdklPbszYA
X-ME-Proxy: <xmx:HvlUatHpafzhU1jW0UKVJenwp6HJ7AMB4u009jR-gTtw0tEf78oCJg>
    <xmx:HvlUavcQ7KAv9K6F-CiNTqpEL-8Qa-v5UckIuoQ6p79aq0SAQun5sg>
    <xmx:HvlUauJ8cXVyEiT-E-P2m8v4tR1aaa-VbXshQ9McrJ0MUeQzj1Rlhw>
    <xmx:HvlUakGAFmrHI5Lr_IKrQ_WbQxoiaM-gy1kO6KbzsqEh7flL3qeL4Q>
    <xmx:HvlUajY0gy-USZ3PPdja9ikqeWOClWCJOLxmvD3CuuXz_MH2FtZH9kv0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 10:41:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0320676b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Jul 2026 14:41:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 13 Jul 2026 16:41:25 +0200
Subject: [PATCH v3 1/9] odb/source-packed: improve lookup when enumerating
 objects
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-pks-odb-for-each-object-filter-v3-1-b3c65c641073@pks.im>
References: <20260713-pks-odb-for-each-object-filter-v3-0-b3c65c641073@pks.im>
In-Reply-To: <20260713-pks-odb-for-each-object-filter-v3-0-b3c65c641073@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Jeff King <peff@peff.net>, Taylor Blau <ttaylorr@openai.com>
X-Mailer: b4 0.15.2

When iterating through objects of a packed source that have a specific
prefix we do so via two different methods:

  - When a multi-pack index is available we use that one to efficiently
    loop through all objects.

  - We then loop through all packfiles that aren't covered by a
    multi-pack index.

Regardless of which mechanism we use, we then iterate through all the
objects indexed by the respective data structure. Curiously though,
while we use the indices for enumerating the objects, we completely
ignore it for the actual object lookup. Instead, we call into the
generic `odb_source_read_object_info()` function, which will itself
consult the indices to figure out where the object in question even
lives.

This has two consequences:

  - It's inefficient, as we basically have to figure out the position of
    the object a second time.

  - It's subtly wrong, as it may now happen that a specific object will
    be looked up via a different pack in case it exists multiple times.
    This is unlikely to have any real-world consequences, but it's still
    the wrong thing to do.

Fix the issue by using `packed_object_info()` directly. While at it,
rename the `store` variable to `source`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-packed.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/odb/source-packed.c b/odb/source-packed.c
index 0edea5356d..9cfa02b7a2 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -143,7 +143,7 @@ static bool should_exclude_pack(struct packed_git *p, enum odb_for_each_object_f
 }
 
 static int for_each_prefixed_object_in_midx(
-	struct odb_source_packed *store,
+	struct odb_source_packed *source,
 	struct multi_pack_index *m,
 	const struct odb_for_each_object_options *opts,
 	struct odb_source_packed_for_each_object_wrapper_data *data)
@@ -170,6 +170,7 @@ static int for_each_prefixed_object_in_midx(
 		 */
 		for (i = first; i < num; i++) {
 			const struct object_id *current = NULL;
+			struct packed_git *pack;
 			struct object_id oid;
 
 			current = nth_midxed_object_oid(&oid, m, i);
@@ -177,9 +178,8 @@ static int for_each_prefixed_object_in_midx(
 			if (!match_hash(len, opts->prefix->hash, current->hash))
 				break;
 
-			if (opts->flags) {
+			if (opts->flags || data->request) {
 				uint32_t pack_id = nth_midxed_pack_int_id(m, i);
-				struct packed_git *pack;
 
 				if (prepare_midx_pack(m, pack_id)) {
 					pack_errors = true;
@@ -193,9 +193,9 @@ static int for_each_prefixed_object_in_midx(
 
 			if (data->request) {
 				struct object_info oi = *data->request;
+				off_t offset = nth_midxed_offset(m, i);
 
-				ret = odb_source_read_object_info(&store->base, current,
-								  &oi, 0);
+				ret = packed_object_info(source, pack, offset, &oi);
 				if (ret)
 					goto out;
 
@@ -219,7 +219,7 @@ static int for_each_prefixed_object_in_midx(
 }
 
 static int for_each_prefixed_object_in_pack(
-	struct odb_source_packed *store,
+	struct odb_source_packed *source,
 	struct packed_git *p,
 	const struct odb_for_each_object_options *opts,
 	struct odb_source_packed_for_each_object_wrapper_data *data)
@@ -246,8 +246,9 @@ static int for_each_prefixed_object_in_pack(
 
 		if (data->request) {
 			struct object_info oi = *data->request;
+			off_t offset = nth_packed_object_offset(p, i);
 
-			ret = odb_source_read_object_info(&store->base, &oid, &oi, 0);
+			ret = packed_object_info(source, p, offset, &oi);
 			if (ret)
 				goto out;
 

-- 
2.55.0.313.g8d093f411d.dirty


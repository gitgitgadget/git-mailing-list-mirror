Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7003F0AA4
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 08:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783586166; cv=none; b=R418+BTajgwYqAlDhveLvt9B8DYY2qUos2HZnK2N8wfdQGiYA1dMmmcu1LtEr5HsV1sRYS/D6i7yBtmSY/DC5mWYLyChJpPCehIAP+ljiVXZle2JUBJSZ2FVe4iIaZGlt4HHJvBsfioep8IMJqRisPT8rc8u2FFNt/ufXHhz69c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783586166; c=relaxed/simple;
	bh=f52pJ6Go6Kl0eDHFqtr2CaoLKUpmNPZKonfQ9Io67yE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IcxWhDCZ6mJ9fiDMCa1ogVxHGj0guQcjGexc+yIs7H9jhLkg5JGpoNGcTpJ72TR8Qzlyb49jU5QiiyD/8t4cUY+3YvDtrvVrtJmLwBWB6zdZbQpDz9Vt5ywpz3eOFV97UBCZPAcRWUCVQudFAayp354Ldnwq74jqGaAzBeshPu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RGSJcwHH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lUdslSg0; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RGSJcwHH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lUdslSg0"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id CF66E1D00086
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 04:36:04 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 09 Jul 2026 04:36:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783586164;
	 x=1783672564; bh=DbjYdc+p8ZY7f/CVrAt849XtMaDszSiCJ1EIL0WMhHg=; b=
	RGSJcwHHjeM7yZJEzD87u3kJjkuaLbBheVMo788OihxRuRuczt59Ij6GXXpyJ4Zp
	Slh+p4n+Fu150EcoR2WPmzXivj+c1iVWX0LylRdq8/M32V6q9r5ZDgVFqXmHgD0T
	W+37BjjP4fnuXSm6l9xkoC0/A9Si2yBqkGidIDX+67iSj1SlOHQZ9mkk2T96init
	qPz5u/9kGXEdWNYepqCKOS83mrE33R0tt0LvLb9eGEOeMo1S3S/iKJ9ZgwgzeRIT
	hEgKw5u59cQgxfOl3zhaUewJ9VF9yDmyjhAfF4u9tnijHTmydZ0S0vD8FXG49a0a
	qnYZmGh2yvnqVs2bPd6j6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783586164; x=
	1783672564; bh=DbjYdc+p8ZY7f/CVrAt849XtMaDszSiCJ1EIL0WMhHg=; b=l
	UdslSg0imxz/Buk2aiJUG2iNz7d4ivIJPtV6tEZebNTCSNXQgfLR/hohMgsSsU7e
	5ZJgQRzgHTxZmfO5wdL7MICLwIN/Y+HmnBHaX1z2KCO2kDBMqtxFvyguzHL9F8UV
	+mjq1iUA2LGCZiGz8rJ/jiI8pSxjVrxXnyq4w6+pZ2n+QWN+c33J+Dv/lhYXZkS1
	2SfqYpBGc7hzDRjzobjwqsMj5iy/HVHRamYBs1N4XUhY+Uzg55/J70d1Rd+df/l7
	hcXCywCPXB/l3m9Jztu5GNlH0MoccYEiamc/BQUi2xsqtXEkWsftROoPb8KLnQAY
	4Eo2RrCXo2bjo9XbZ3BZA==
X-ME-Sender: <xms:dF1PasJ4ImcUdkoU5QjkSKKsbTjVZTUlQhPcd1Bcj6tl7XkJVINRRA>
    <xme:dF1PajHLoxcZxGEUQxEgmU2RcMf2R-A37KtT3Oy-wItreWIzA_FwSPHLepqaRRreg
    I3NgBj7KwLeDAHYCqt8xP41x1zt-hDRAaaM0wkzuKgG-u4gRAuaZw>
X-ME-Received: <xmr:dF1PaiX1mYQ4lypwHiWZM9VBa_gMYggeaaxdojZmvp1VotW--zctkeTIl0sX0Yau2PzWTGWesdvq7Ve4S0bluHvgQOxEKA4iMihpvfbF1Q>
X-ME-Proxy-Cause: dmFkZTGVX3wGpxpiSCWJAJLYw56uc7AsI8lzGGtirC1PyeoNkmCS9OJmVpj2C4zgT0w4Bv
    fRRIRvb2Zgw11cWYDofZgFH3L8ZF9LsrJVYGp6LyzbEvhWT3LGZdU4A11BhGzHT71Yozqo
    8bJhwHECnddG8lIqfrPNfvCfxUxE/oS1mFXHxRylUQj1j9URASU8hVG3yejfXf6fflQiuS
    bLeSzH21T8lGztv+qF6FixffIjzLX7LOEToB+wMzSeOPg+ZmdRQOrM2RnxJ5HFz8KjjTBj
    pcZnHacq2D3zm2wPW5y60IfhSgZnCjs5gOfOMOVVOkwDcsrHxYXboZUOONGkZnkoLLnIJ2
    EoO1GoeqCfAIxc7CPEN6l1taNCQ0/ET4+87pKbpxIOsi2KST5O0k4txplcsrIQohxk0dPx
    i6eECDSE0cyuW/evk4FEUELPCmJrwwrmodIQ2pRXksBDJw+72XmFfgpBM4e1mTO4P1eub5
    cvoutjfPH0BuBjqC4gUwKYggFbmUMPHss0z2+Hvk/Ylmf0914tmWcUZt7rv413LT1bF0Rs
    BkX2w5pMVmqxDLa1s1j6V6MRFfU6VdsZ4kskGiH4Uw9vTSCWaIZnKLLpclonEPjFO+CvRH
    Qo+GAEVwetWxpRk+9uv8HwjeUy72YdY3kJKka8NCvHBRyxN4tt9nXAdOxikQ
X-ME-Proxy: <xmx:dF1PaugfXkSD2sDwndoROmhKLi6U3Y1hwsxASocxcMORkuTHnw0AHg>
    <xmx:dF1PajT7wufehlUasxpt7CzMPN-Pf12Q99EEvRURLR6DHZfsHldROw>
    <xmx:dF1PahGaUEk_BH1CuMeX9HjbFB2Dhczm4Iz99jnvjjEwC6RiqMLQwA>
    <xmx:dF1ParnoZ3YuPoBXTVTsw_6cSZiPANsV5INjkGzFpHlU0ARLkjWbvQ>
    <xmx:dF1Palo5Ou-qKKflbpjJJ9yHL-BSKBVQ9ObuHDGq-LOhVSrbXjS2AnFs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 9 Jul 2026 04:36:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4fd6b4c8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 9 Jul 2026 08:36:03 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 09 Jul 2026 10:35:21 +0200
Subject: [PATCH 1/7] odb/source-packed: improve lookup when enumerating
 objects
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-pks-odb-for-each-object-filter-v1-1-82fe014b12b3@pks.im>
References: <20260709-pks-odb-for-each-object-filter-v1-0-82fe014b12b3@pks.im>
In-Reply-To: <20260709-pks-odb-for-each-object-filter-v1-0-82fe014b12b3@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

When iterating through packed objects via `odb_for_each_object()` we
do so via two different mechanisms:

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
2.55.0.175.ge4962bd3d5.dirty


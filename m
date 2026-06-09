Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C234A3F410A
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 08:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780995109; cv=none; b=f2xZ/Lp1WmTU/Swv5x4xVfHBjJgFdIw7cqsE0fh1qVVPRWGTk0XoClWeWKMDBKsMDjHNH3cTGziWcCN6DHTH4B3haj/iITxisiocjIRYrqedyD6lwIivNQtp4VU7KoP/Qo7ZekSmIzj2/rVBtHZWSnYhjTugkixX2P7xRDxtd/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780995109; c=relaxed/simple;
	bh=ElnjLNOrhRApIIg5uy+Cj1ZtlKIks4A1rKLLBhqabxA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=htiXNe44MuDm3PidoNVjt5NqMMyaT0atOrUT6R3Oo7dpoqcZt0NqvFM28CKcBXwoEz/6d0Z3AXx4P3/rAD2rTukxAs4q4BPFp6tMpYcVPxZKh+gc046HIJrRAHOmfTcfE3Cs3dKfG68KtV0vuHFDRzgGOPq7PYdyHcIWdyQ1L/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZzP8OTJx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QR11Zrkz; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZzP8OTJx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QR11Zrkz"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D25747A00F9;
	Tue,  9 Jun 2026 04:51:45 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 09 Jun 2026 04:51:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780995105;
	 x=1781081505; bh=kNe5564PqKOyZTb+pnro+iCinFD+9VVkfPBZeKF39Q0=; b=
	ZzP8OTJxHUkNtmtSDn6ueMKSl3Dr7LTjlr3OwxfrdLFNI/5v/TkE2P13xUao+0Fs
	8LlgSQ7cQU9Jaday1zrPIO/M47OGnBYj+svsNjkwmtuNZwXlS/S7iaIHU1eD7xpp
	7l5j1vYXtA5lvpAQ1kJ9XiDRmcxbnfmic5cMB/bc5lSnwJ2I/Tg+owT72rZB594j
	m7sg++NRWU+FaCXJ33YIZtigA3wgQXWJSODVY0I4FjwkgviB+TrVPgR2xxlYpRf0
	4algu2KniX00rUaxyrPx9zjHFF6JRKIFfl2ZIQWP2w3RddkgbOQ0fD1EK7dhkW0t
	drOgvc7dBbRKjAAqkr3g5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780995105; x=
	1781081505; bh=kNe5564PqKOyZTb+pnro+iCinFD+9VVkfPBZeKF39Q0=; b=Q
	R11ZrkzR/cVrMGBnEBvIu8nY+OiYFlvE4Mdw4cKmKJ0spQbCPFS8i7pAJpvaw8Ra
	114+VKUtxmpgOeSh7XAVCMMwMQKcZvKUExJfvW5EP8fevxgm/EgA72SUThIPBNaq
	XQE/q1ynlz9DZIo7rFcNMYw6UC4Rso3ikTGJ7iD/Lx9e9uMh4iCaG3LF15z6TDj1
	SwFw03LvBBKlGD3uax/EJJPiwfHNs4EJJ9cf/oukPOsQE+syiMeotS3/pfE2D8Ve
	U0vZgnL53GLj9BARJQBD9NElukJRRHSZkFKBbyETUC+ZPvHXOW/31vxWKRG7yD6P
	bNWodK973Eo+INFV5JPnw==
X-ME-Sender: <xms:IdQnakUeSAa0gfpH6hS2QdUM_N1-5iPfJmAuS8WCq6opEscA5dTMSw>
    <xme:IdQnaumAFg7yr0gOYpQIRZZT49lSR0Tga2SwwoWJwN9gG2i2Zh3dKQnwM6kO5Imky
    c0JDR6AgrsBSOOcFK9QOj4zHWurIsnfQC_0v16r5eLmIrP-M3Xfow>
X-ME-Received: <xmr:IdQnamAve1BockIssVHY6sO7jiKge8BhHd6gPiRYCvXUxpYLepYiH1KcQYfzYjgBfz2Nghbi2VcaGGCiMbs3z4ErNqgl-ghaKn1SaP2knxY>
X-ME-Proxy-Cause: dmFkZTGHcLQNSpLSt/NXdkOaoJkTmvj04CJZqgn+zAvtnJsraJpdZ0ddSiSTFtEp0UEZbO
    /Wl8U+7383P89z8nu4XASlnQ0kEwbP0rvN/aGyp2/lJ60oOrnWlnHeg9FJVKkfykX6zHax
    e9cZL63tpGUrA2jT5KaI4nhsaz14vnFe8cHnENfZPuPThc3Ak/Uu7FrNhe5Unv1HQX9xMJ
    pBu6IPmTnfEwyXoirtywFzr6e0eFBa9JIGgo417lo6KFvgvzWWgi3TArqhDtqUygUobbk3
    ZRlDMR7g6RGBjmfVBDf2lq2Bs7vhbVY+ufr2Ex/bUSpOg8GNJp996m8x+U/hw4z4iOXXtq
    GcTSUZSzR2Hy/t1wfYDAkAYU/LUaH23YHieF8MUeFqwGzvVVTeu5YPsOBqdR4hegXvutyt
    nFlLzUGH9OQWAhhbi+aqHaNhoDR6/OxJPmrmkCCRzkIk0jsqCcXqVvLjNq5zktVsbd7K+y
    UGY0dECrRCZlvu/Wi4bex0ePdbG8/LR+MBKOI0KoVCIp4tbcU3YYWFj1pfnzSFA2SuICeH
    CKMkZREtH44U9kzRLVZT+ZnAZ/e8fq/q+OxhdeCigXGBAQ9wnwR0ibftwo+xk5YF8vnLck
    HZOtHywpbOHdQ617Ye0fh0JMFqSlWZ2JuhkLDnj6FCDHpxGPA64sRyusBZAw
X-ME-Proxy: <xmx:IdQnaue0XQXliNRFQ6riatXjDXwtaGQRCFS0yydBmAPEN43JDDzR5g>
    <xmx:IdQnahIOKHru2oATLm1EIbvg-MnnsJ3NiB6SXeZX-MxqhEVFH_Zm6w>
    <xmx:IdQnahcV4jHB6NRRCQFSIxx_HhhvW2R1kufjhDvcr4Mt005nV9qnLg>
    <xmx:IdQnao1X_pp0MYqo2HRf98EKMVJ_kszsTa0mVnl6u9IvgCvieUAHEw>
    <xmx:IdQnapG18BTB0TN5-uQ1up7gagosmqI4eSF7XL6ox7DCi8Yr_gyQLIER>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jun 2026 04:51:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f5aa1cb5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 9 Jun 2026 08:51:44 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 09 Jun 2026 10:51:08 +0200
Subject: [PATCH v2 15/17] odb/source-packed: stub out remaining functions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-pks-odb-source-packed-v2-15-839089132c8b@pks.im>
References: <20260609-pks-odb-source-packed-v2-0-839089132c8b@pks.im>
In-Reply-To: <20260609-pks-odb-source-packed-v2-0-839089132c8b@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

Stub out remaining functions that we either don't need or that are
basically no-ops.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-packed.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/odb/source-packed.c b/odb/source-packed.c
index e40b52e445..08a2de9bc5 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -501,6 +501,43 @@ static int odb_source_packed_freshen_object(struct odb_source *source,
 	return 1;
 }
 
+static int odb_source_packed_write_object(struct odb_source *source UNUSED,
+					  const void *buf UNUSED,
+					  unsigned long len UNUSED,
+					  enum object_type type UNUSED,
+					  struct object_id *oid UNUSED,
+					  struct object_id *compat_oid UNUSED,
+					  unsigned flags UNUSED)
+{
+	return error("packed backend cannot write objects");
+}
+
+static int odb_source_packed_write_object_stream(struct odb_source *source UNUSED,
+						 struct odb_write_stream *stream UNUSED,
+						 size_t len UNUSED,
+						 struct object_id *oid UNUSED)
+{
+	return error("packed backend cannot write object streams");
+}
+
+static int odb_source_packed_begin_transaction(struct odb_source *source UNUSED,
+					       struct odb_transaction **out UNUSED)
+{
+	return error("packed backend cannot begin transactions");
+}
+
+static int odb_source_packed_read_alternates(struct odb_source *source UNUSED,
+					     struct strvec *out UNUSED)
+{
+	return 0;
+}
+
+static int odb_source_packed_write_alternate(struct odb_source *source UNUSED,
+					     const char *alternate UNUSED)
+{
+	return error("packed backend cannot write alternates");
+}
+
 void (*report_garbage)(unsigned seen_bits, const char *path);
 
 static void report_helper(const struct string_list *list,
@@ -715,6 +752,11 @@ struct odb_source_packed *odb_source_packed_new(struct odb_source_files *parent)
 	packed->base.count_objects = odb_source_packed_count_objects;
 	packed->base.find_abbrev_len = odb_source_packed_find_abbrev_len;
 	packed->base.freshen_object = odb_source_packed_freshen_object;
+	packed->base.write_object = odb_source_packed_write_object;
+	packed->base.write_object_stream = odb_source_packed_write_object_stream;
+	packed->base.begin_transaction = odb_source_packed_begin_transaction;
+	packed->base.read_alternates = odb_source_packed_read_alternates;
+	packed->base.write_alternate = odb_source_packed_write_alternate;
 
 	if (!is_absolute_path(parent->base.path))
 		chdir_notify_register(NULL, odb_source_packed_reparent, packed);

-- 
2.54.0.1136.gdb2ca164c4.dirty


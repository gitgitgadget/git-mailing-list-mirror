Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210012EA72A
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 09:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754992478; cv=none; b=E4+JzBUQFeVjoGlp00/IrWjERy8s8VbLQeFRKJ7n3U5amx1jV0Rw3y81F+jRU4DKEc57+WABGpoeW5AlQ8VhXRkw8oKNOCHwC2q7THDE/rEoMxjkaHDBcQeDlVxeasFL+eotLvf/y8E9uZoWIF5EKEaFkryr0ftHxyKirx5u2i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754992478; c=relaxed/simple;
	bh=uYmFTKrJ09TgO1xkAskgOKjzP7NLQnkhn7Yl3e55WWw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z2gDK9X3EarEm8JOKZyo0QqqG0DNLqBy4Ljnbsz29cpZIChTSd4YVh4y5it8iXbiIR67i4rdZ+gRCvO4X/O5nlBuhRbbwNMYnd1avzabJdOnzrjHdfpvdctAcJuZcsf4N+jSAIeDAA8LjGLckYFXEVAy72D6KdVa440cHUSm1Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TE5TrHk6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DayMTWCG; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TE5TrHk6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DayMTWCG"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 16B65EC01A9;
	Tue, 12 Aug 2025 05:54:36 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 12 Aug 2025 05:54:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754992476;
	 x=1755078876; bh=ze0rvJ8P0DkPG5W3HKuxA2Y1seEcGXBlV5hchY2+XwE=; b=
	TE5TrHk6nrStev/0dUXmTOrahQstgDh1gymO6IukaZhrPjHYFIFNA5YIV7T/QP5M
	tHUPjzrs5DTiLkUVJfOqc5Js//hWAeDLDUfbudHA4n5mrty8N2q7oiXfE5H6Wf53
	2MrdfDsu7I0HuABgJV3pgt8/YLRwZMMYYz2f7jb0c8etSzQwyQ0l1OtvLhRD65tU
	XqHfQBsMbJNdurX10gGO0xvr6WVG9Q0j481OVQIMoPKLx+YCd2HnKzK4RuzGXEMF
	+o2vi+THD4ER+tef4R7VNIx0naGpSHkT28km5RRNC0kk3dGdmiB+jtPN4T0oqqQG
	gmVwrwdzUD1Pg/1AM5TcOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754992476; x=
	1755078876; bh=ze0rvJ8P0DkPG5W3HKuxA2Y1seEcGXBlV5hchY2+XwE=; b=D
	ayMTWCG7fg975wFOFN4Kvdafj4S5CFecdDBb0YKc11j4wiZ75pZw85WWvYBIEUTw
	/g2ruFbhaWpUHgyI2xCPDekmq+Ys/h1Tol2HtmTQF73I5KZ0LKoM7bYN8zRkVrgR
	jkq+rmU6+LHq4Vkzvd+VrZeNXMGIngR6wNT18qeRw541Fp6B+aXXuy7Jv6a3gXvE
	aADY9NN7RGl9Z+/VvaixgJZokLhaDTtT5xAtOagWUG+mxloA9Pp2qf/of2kd2Nmw
	FHxw0qJKQQL75a2Cf19SKPR2YI18/5sQbSSwfGgp9Asz5vdd2cpcZ1o10MmqkEdA
	QqgzVPM0G9A0ODHtk/TLA==
X-ME-Sender: <xms:Ww-baJj-C_cS2_Grnuq9w4HfsKulDKZ-rbNx5lxLlfSgFF5kcs5qeA>
    <xme:Ww-baJiJCh7nELnVPrwJ_zPC-TthltpbYweeK0-QS9Vt2ZbjjBTPsfk1SPhjGfOXc
    lJiHYxSM2wcuA7zig>
X-ME-Received: <xmr:Ww-baPhP3G9FscIK34Pt55g-dTtnAxyj7FuKSAU47Na7pVOM31Lci4x__98HGjgEPR1zvaIZ_RO2JOCIco1Z0pnHNtQkf-6Bc-bD038Z>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeehtdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhi
    nhgvtghordgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpd
    hrtghpthhtoheptggrrhgvnhgrshesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:Ww-baJKZXI5lA9iVW0a6hvFLfOfBGKfQyR4506gRGk98oPKbNt_sNw>
    <xmx:Ww-baOHo-gGbPn7cr_dARDno6EXcN61XOfHj5vZmkQUAWH0C4ART0Q>
    <xmx:Ww-baNSVtGhVXb-iq3K3UAu1DAeOlQ3FdmFBkV39uSY9NPdr6SLuLg>
    <xmx:Ww-baKeEYcKncx1-q2PrfULXRw1G7JEk-tm5Wr1wGhTV7Y6kvjdIvA>
    <xmx:XA-baMfhURuE-FCiQ8XXMzO8aEcmVPjGvNSi-02OfcMY__kayczP1W8P>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Aug 2025 05:54:34 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2aabc6bc (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 12 Aug 2025 09:54:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 12 Aug 2025 11:54:16 +0200
Subject: [PATCH v3 2/8] reftable/writer: drop Git-specific `QSORT()` macro
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-pks-reftable-fixes-for-libgit2-v3-2-cf3b2267867e@pks.im>
References: <20250812-pks-reftable-fixes-for-libgit2-v3-0-cf3b2267867e@pks.im>
In-Reply-To: <20250812-pks-reftable-fixes-for-libgit2-v3-0-cf3b2267867e@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Carlo Arenas <carenas@gmail.com>
X-Mailer: b4 0.14.2

The reftable writer accidentally uses the Git-specific `QSORT()` macro.
This macro removes the need for the caller to provide the element size,
but other than that it's mostly equivalent to `qsort()`.

Replace the macro accordingly to make the library usable outside of Git.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/writer.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/reftable/writer.c b/reftable/writer.c
index 5bad130c7e..0133b64975 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -399,7 +399,8 @@ int reftable_writer_add_refs(struct reftable_writer *w,
 {
 	int err = 0;
 
-	QSORT(refs, n, reftable_ref_record_compare_name);
+	if (n)
+		qsort(refs, n, sizeof(*refs), reftable_ref_record_compare_name);
 
 	for (size_t i = 0; err == 0 && i < n; i++)
 		err = reftable_writer_add_ref(w, &refs[i]);
@@ -491,7 +492,8 @@ int reftable_writer_add_logs(struct reftable_writer *w,
 {
 	int err = 0;
 
-	QSORT(logs, n, reftable_log_record_compare_key);
+	if (n)
+		qsort(logs, n, sizeof(*logs), reftable_log_record_compare_key);
 
 	for (size_t i = 0; err == 0 && i < n; i++)
 		err = reftable_writer_add_log(w, &logs[i]);

-- 
2.51.0.rc1.163.g2494970778.dirty


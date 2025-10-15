Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4139E305042
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 06:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760508268; cv=none; b=GlpqDpJO7acFIMwY6MAiVFNxbGl4fDn60oezL9oLRlpSPpd4GV/zbcj4Haq/XD6e/Ap9k63s03mIpT+nXBMLZ6PEJlpbINaF7vDimPrwS70Fkodv0q4OvklGTnobAFru/OF1O343hzSrZluwe6N20n4nJw/OeE8G3QAMji+/vSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760508268; c=relaxed/simple;
	bh=OH5rXrsbS2FC9+HieniSebonGAHzzbD96v3cQi4+xgU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BqL5uMLzAEeHmJo5hbJ6C7sJFqkr3YqGxJtKm3/bMMBWUhV6w2I2IdGHlFY+AUfYuCmHvUW1YlmJkDfzZMWh99GbpYdgYEEheBYV4FgG3K5pSet1idIwsaYRLHvfnlIHXH6YzfW8h5zYu4bwjB74TlQ2l2012RAWxs1xR0nLTds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LHHZ9v93; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iIbpogq8; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LHHZ9v93";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iIbpogq8"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 29B2E7A0182;
	Wed, 15 Oct 2025 02:04:25 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 15 Oct 2025 02:04:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760508265;
	 x=1760594665; bh=OpQpWXIBQ0Q0U+XXK3T5QJZRX/dnR2tyPosR6949cBM=; b=
	LHHZ9v93/qpxOfeMn5/vwDo2wa+yAIeuVkFQCmE8TynkYGorOTFpzlohW3OUXBRt
	14d6gQ7CVScbPDw1My5pKNC1ECcx4qgL4G5Jxcx0/C7dMiEE96sz1V17J4YlH1ZM
	tsL7xy94kHA59HJt0sr/ZNrauOEgOURSgsvWkvbBnaXzdGN/EUQN7cSdFim892ok
	9t9sXaQIHo2CI292HthBgHGjYoGJvmdFD3HDIX1VtjfnKunv8IwGFgkXNFvZUdej
	pJcyEVbGiVCXqOuv3hz6dmK+gbup6sddqSmpxnakXtrIHjC4R5U+2Z3xvBZPCiMm
	nErUTeWk2FzhFYlL67tKKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760508265; x=
	1760594665; bh=OpQpWXIBQ0Q0U+XXK3T5QJZRX/dnR2tyPosR6949cBM=; b=i
	Ibpogq8jFEB+nYY+IFHsMpqLJbHHaXJ82cyYdlEiYKj+hCqODmG7nOWbFnF+vSCt
	8+fV8ombkKIcrCD+KZrEGIxjt4r46/3BUNUQan4unm3UN5UlFS8F/Va1sJ2dm2Da
	Uu1wzgUhQr3sJ+Lfi59Dqo194VqudGSjupdCrxvkJq8xDXEN/X3jpOKvutReTCBi
	88vtWGTAuh922LHPg/CJZqCI+bp4VKzoIODVZgpxKbkPOd6+jvtccNuZpAC9ne2Z
	0HqAx4i5HVCqxE0P0fvGKjonfUrY72yAf/jnjNXUy95l7yygWk6TJDFwzz7oTTcM
	NRblVVk555kriL7TfyGhQ==
X-ME-Sender: <xms:aDnvaATBQsdTvyBtu8PEI-JOIzuqQyyiG_1VhQUou8W_jEaBOBcfLQ>
    <xme:aDnvaM3B7sbuT3ccf0B70sLPO6cuUg8h2FI4jo0k-9CoMjT7V20kQoIctUU21i9dP
    qXGUBM6HcNfwwYnBljrdLIS6lfZrEdRID91pem5_4mm8dIaQRQuJQ>
X-ME-Received: <xmr:aDnvaEBwTzgnsNEX2_BeXoyB6nPYmCGLCOL_7WRcvx7zSka1n_YpfQjkn4VoitOdELoCAsOeWexut47p4xWtguNMR4unvczCADgisRCGyoaB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddvieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvghrihgtsh
    hunhhshhhinhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghr
    uhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepkhgrrhhthhhikhdrud
    ekkeesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhsrdhtohhrvghksehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesgh
    hmgidruggvpdhrtghpthhtohepvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:aDnvaAhplcgkfXyJaSEpgt1kummtToP23FkPt7AhT-UmcqKGZAT9FA>
    <xmx:aDnvaON2mY-N8JT3b8fquUW7-S_5RGCdatIFojnYlREvqfDSvoqTlQ>
    <xmx:aDnvaI-OI1n55CoZY-AjPll3vHIH8U1KasJEmWx9FsnHuIKFwnrDGQ>
    <xmx:aDnvaHd9z9YZtuurWa8CwZaiRn1_8GsxjevQP-jSKKGpb043_aechw>
    <xmx:aTnvaK-Xo4s_nKPzp3VEs9kAUuylSP_-scyY-7DlDYRRx7a3pFtoSWQ2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Oct 2025 02:04:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 42781f6b (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 15 Oct 2025 06:04:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 15 Oct 2025 08:04:07 +0200
Subject: [PATCH v3 3/6] rust/varint: add safety comments
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-b4-pks-ci-rust-v3-3-13810af33bd5@pks.im>
References: <20251015-b4-pks-ci-rust-v3-0-13810af33bd5@pks.im>
In-Reply-To: <20251015-b4-pks-ci-rust-v3-0-13810af33bd5@pks.im>
To: git@vger.kernel.org
Cc: Ezekiel Newren <ezekielnewren@gmail.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Karthik Nayak <karthik.188@gmail.com>, 
 Eric Sunshine <ericsunshine@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Chris Torek <chris.torek@gmail.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.14.3

The `decode_varint()` and `encode_varint()` functions in our Rust crate
are reimplementations of the respective C functions. As such, we are
naturally forced to use the same interface in both Rust and C, which
makes use of raw pointers. The consequence is that the code needs to be
marked as unsafe in Rust.

It is common practice in Rust to provide safety documentation for every
block that is marked as unsafe. This common practice is also enforced by
Clippy, Rust's static analyser. We don't have Clippy wired up yet, and
we could of course just disable this check. But we're about to wire it
up, and it is reasonable to always enforce documentation for unsafe
blocks.

Add such safety comments to already squelch those warnings now. While at
it, also document the functions' behaviour.

Helped-by: "brian m. carlson" <sandals@crustytoothpaste.net>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 src/varint.rs | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/src/varint.rs b/src/varint.rs
index 6e610bdd8e..06492dfc5e 100644
--- a/src/varint.rs
+++ b/src/varint.rs
@@ -1,3 +1,10 @@
+/// Decode the variable-length integer stored in `bufp` and return the decoded value.
+///
+/// Returns 0 in case the decoded integer would overflow u64::MAX.
+///
+/// # Safety
+///
+/// The buffer must be NUL-terminated to ensure safety.
 #[no_mangle]
 pub unsafe extern "C" fn decode_varint(bufp: *mut *const u8) -> u64 {
     let mut buf = *bufp;
@@ -22,6 +29,14 @@ pub unsafe extern "C" fn decode_varint(bufp: *mut *const u8) -> u64 {
     val
 }
 
+/// Encode `value` into `buf` as a variable-length integer unless `buf` is null.
+///
+/// Returns the number of bytes written, or, if `buf` is null, the number of bytes that would be
+/// written to encode the integer.
+///
+/// # Safety
+///
+/// `buf` must either be null or point to at least 16 bytes of memory.
 #[no_mangle]
 pub unsafe extern "C" fn encode_varint(value: u64, buf: *mut u8) -> u8 {
     let mut varint: [u8; 16] = [0; 16];

-- 
2.51.0.869.ge66316f041.dirty


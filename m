Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458172E8E13
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 06:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759904858; cv=none; b=pkpKlgIZA/zEgblRqhH7+aJIg9e8YBysMIqWC5qvj+OyRO24vPmF3jr3J0FkYMpUn082ECb/mED4qErHEimi53NrnC47ZL+5qGUmg47xPbihn5o7JaV6ahOXVqrVr6iZMC3lU9bmfDWaFmtzQ/+UPwh+aJ8X8Inrl1QqSQZQUqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759904858; c=relaxed/simple;
	bh=jMdnbbhIgHDQxP4tgkg0AzC3MSc2auiL5QVVlXDOlgI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l+p4FbJCTdcwUxjw9zrxcd8RvoC1FRgfgdVg3OUzaeCx6pliHl89rsgpZc+eTeGSKHV7oBzm5gKoYye7XzTjQd7k5I/zhf8i93kgroBUbk9nWn75qAH3cxisp4P2sTsspXLRdmVq+vGgLLisvEuq177lbv2qQbgJhYKrOFeFGuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Wuo5H/z5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cJDZq7pl; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Wuo5H/z5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cJDZq7pl"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 6A08D1D0005C;
	Wed,  8 Oct 2025 02:27:35 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 08 Oct 2025 02:27:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759904855;
	 x=1759991255; bh=gV0vA5/bjpj4VOucmxFZrXK58qKI3AtZONFyxEqNaTY=; b=
	Wuo5H/z5e+IWdhkytBwjfBgj0VZ2zmKf6Q6mVeIMqXWQgU6Mdj13xjdLyce9awgx
	yeJCPERUPfniw89dmkd+M/SaGO13y+QgYzUe1XhzKhz7IsHDGdxiW29Xkc/MCemB
	zfWIF6zpXikSt2xCzRSvxo685iemRUdhLYbAdTbGWB4ulbKjQnLzq7C89fYGu6Rs
	Tg2qDPL2x9tPqICswDIsRylMtaOED7mxyHha+/jwphTnozF+OFFHZC2kjeFYgBH7
	GknhIAjYZHhMPb+Sa8XJmX63VfFbNNtk2Lv9D5ur3P5WLqCr2gxZH8/g2BiEQQf4
	kwCeXnodZPpIP6IpptCOZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759904855; x=
	1759991255; bh=gV0vA5/bjpj4VOucmxFZrXK58qKI3AtZONFyxEqNaTY=; b=c
	JDZq7plOSOU8t8U6dj2aGy+Eh9nvbIHlhxeMdDOJu4xVDe0DgyynjptDdx/vy4ip
	nRK/RvRkP7yMC686dj6hjbmKJrEfZ25wOu4QivXNJT16cDEKCY5RtbvAackcCYkH
	YEapJDEpaJ2Lz0cyErTGXTJzdYTSe5LcmQkpuWklfnFdu5uI22Nan4Okm+mi6hQ2
	B99klCWaXkOfjT41Ju5VBeKKM4FOth9kDC1zvj+VfPJyI7RGqWcDFoGu7YciGDYq
	wdYzP5c7n6QtLpCjPtUm+xYBgohpIyzhgx++ttg/vqfyDc9SNZttwiWaRO7qQ6kr
	lAGizZGhu/WOuH+ODlpWA==
X-ME-Sender: <xms:VwTmaKFqe9co1mjwAPSvtdDA4gJEy6ylc1Y-3GhBNDb5qYeDocb_kA>
    <xme:VwTmaKYHLhpyKG-2TyqOXKnLFgYe6LVCduv0RiWwDZbg9-xkChUG1ATU-nxmTqBKt
    ufqrtloIoCH2XXaivcQqrCCDJ6D5KWxg_uv7SVeMx6pIumDq1NFLg>
X-ME-Received: <xmr:VwTmaKUjDRX5fCNib2km-oSAR9sPoDDXiIsLLPYO8BV6PVCRuM2pV7QlSxfiuykSrHMANM6wbUrC--dxOfjppL2RwIWwRDC3NQZV3MMQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddvheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegviigvkhhivghlnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvg
    hrihgtshhunhhshhhinhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheptghhrhhishdrthhorhgvkhesghhmrghilhdrtghomhdprhgt
    phhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepsh
    grnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohep
    jhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggv
X-ME-Proxy: <xmx:VwTmaAmJoyurfFL2aMuqO38eChVlTeOKPM2U8GO1EnDsENzWGLqReQ>
    <xmx:VwTmaFD9ScxBnaO-AUMihLePuE0lvSn1_KeawpTGn33AdvvkpUkCeg>
    <xmx:VwTmaPi4jjvW19q2tAmsqdlew0k_ev4rWBf6epx0nlcJsGITxs5KPA>
    <xmx:VwTmaCziVq3RI00QCtFYfMMJdO4Rm3FpkCxAtgFypsUpte9xG56Z6Q>
    <xmx:VwTmaLjvt1sTvMutEh1qdQGH4GxwHR9ybEH0zbkIYklMV_2aYHdW_JAw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Oct 2025 02:27:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 921fdadf (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 8 Oct 2025 06:27:33 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 08 Oct 2025 08:27:14 +0200
Subject: [PATCH v2 3/6] rust/varint: add safety comments
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-b4-pks-ci-rust-v2-3-d556ee83c381@pks.im>
References: <20251008-b4-pks-ci-rust-v2-0-d556ee83c381@pks.im>
In-Reply-To: <20251008-b4-pks-ci-rust-v2-0-d556ee83c381@pks.im>
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
2.51.0.764.g787ff6f08a.dirty


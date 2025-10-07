Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2112DF3C6
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 12:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759840611; cv=none; b=hSkPVPlIiRajMHTJMlKAFpFp6d4IWPmu7PzMkCnJGwDtPyiS2pUenb2lNJK8qp4XYVyPVYvaHeCmWCfHM4xzij8XxaAJHCfgmALlXsc2h3t7VWYShsOBHOk/mRroqSwesVjyJMpu8JiPlF9NeibGMVTA1sZ01lc0SrbytEqx5Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759840611; c=relaxed/simple;
	bh=I/jeMkS29jwnKPNbJ9dCgCCrZNgMfXmKnA3WImP9sJ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R29z0pLCymHcvwpUWbFvkwDYNI3PtCr5d6HGqFEBDE8vw4if19h+jCaFHy5cO21NfVmD47wMN4E+SpdHxPgx2b4J/8+LGa1JywqRBd1/OvEunYbYW9C9ronE50lppygWzfz/Ib2jv7Y7MeOvYr80onSWEuMDW+wrZohiZzV8K54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PIwN8mdF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L8W5Mjtr; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PIwN8mdF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L8W5Mjtr"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3268F1400332;
	Tue,  7 Oct 2025 08:36:49 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 07 Oct 2025 08:36:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759840609;
	 x=1759927009; bh=i7ZZ9U0OdklrdcOmUbfDO30ALHQ3jsM8LRDxVAc5Rss=; b=
	PIwN8mdF1u2h8OUNVDG3DAfgZzR6F6zm1a4G76bSFmETrBadozDWGRHglQ7wbt1V
	ZHiZsR3lLPElV87ZGI2CpD+jRbZ//dhWwV82875xcD1UJPCnw5vRM6wLQzJ1FEt2
	xLJFm3QUqZprMZQCHVGVlppNnNQ4SLC1RmE3WcstZFrkgnzTD7R/nv6NLCm1T1bh
	GBiDRYhP7K4Mo5gdRVylgAKw3GWhm1oHeIVOxw28Ur/yUrUQtSEMkfoDEIaaSgdW
	EkI3nk5U9bapsRbBve2Da8YadnNOwAl5RvtGxcIsA0xGdLxCKA0ohYeq2j/Zgfcl
	D+wYAqq/2UUyrdSHWZeGBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759840609; x=
	1759927009; bh=i7ZZ9U0OdklrdcOmUbfDO30ALHQ3jsM8LRDxVAc5Rss=; b=L
	8W5MjtrjwM/pfFKghwYXj9lbIxpztXfEB9e3HsOqW1I/1n+QH/1gyBYZGTdMpdsi
	395+xsnYMlt2BYJUO1cQtil15y8Q6KRelz7b03+n9Zdat+XyraI11E1wGxNSPeYr
	4AdVmr+0diFn435xXR0gx9HkmrX0wMqc7mXcHw3d4vYuzJYegz+isD3Ygxp7n/w6
	6V/RTZYTvwsqxAW2czkyBeOcbc5Ha5DkEwOuwtBImyzL9HjVguOzVnlDJHuIe0JV
	YEO91nUGCaXgwxKuUMhG9b7m6x0QdooWFB6S4Kf0Kz4C1w1SztcJzwurb2bsb0Ba
	4XVWF32bWGifQiynHTqTw==
X-ME-Sender: <xms:YAnlaJrOMFKrK7GttR4gIM2aStd6c9juhAjXjbEyqsYmzLlx8mLZaw>
    <xme:YAnlaCoUjT22XNkpEdyA5Uv4T9jUKLOoDEIP15fKbm3eqXizFek6Uk78vcumzQlMC
    ya5399W3umMYpxgwQ7vcCwQ5t3HOHsQksFqS4CWGSpIeEM0F9IG>
X-ME-Received: <xmr:YAnlaLNf0WVnuPbV8J6YISH0Ub8_asAo3AaWCzgc5WbsYjxRLZgXcZ3up8kyIMEJIUir4TN1n5P6dsFyEe4ymOoBKUWl8YIEYtaOuf3GODk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddtgeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtph
    htthhopegviigvkhhivghlnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    jhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:YAnlaDyfRMKCyGYZlkBT-Hr7vNBsUnaIc36u2Usv4miKirUmmVuniQ>
    <xmx:YAnlaEvq2N755Hawp9Sup4GIyqZXVMbZOqjAqu1OPqMZtfmsmA3WkA>
    <xmx:YAnlaM5xlRq2PvitbT4Bj0PQR-P3NyhX__GIYVi0jxwxogi9K9r_Xg>
    <xmx:YAnlaDScs6t0QFGwS9EM_PfIO3gqlqwP4vz5KFIH-bvkohjgcd_lzQ>
    <xmx:YQnlaIb-esDyp4Oi5GZdwn9FZjp3FqEZzIR-HJBXzwmPKOYvRsl6_ZTz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Oct 2025 08:36:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a5547061 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 7 Oct 2025 12:36:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 07 Oct 2025 14:36:31 +0200
Subject: [PATCH 3/6] rust/varint: add safety comments
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-b4-pks-ci-rust-v1-3-394502abe7ea@pks.im>
References: <20251007-b4-pks-ci-rust-v1-0-394502abe7ea@pks.im>
In-Reply-To: <20251007-b4-pks-ci-rust-v1-0-394502abe7ea@pks.im>
To: git@vger.kernel.org
Cc: Ezekiel Newren <ezekielnewren@gmail.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
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

Add such safety comments to already squelch those warnings now.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 src/varint.rs | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/varint.rs b/src/varint.rs
index 6e610bdd8e..43b48debb5 100644
--- a/src/varint.rs
+++ b/src/varint.rs
@@ -1,3 +1,6 @@
+/// # Safety
+///
+/// Callers must provide a NUL-terminated array to ensure safety.
 #[no_mangle]
 pub unsafe extern "C" fn decode_varint(bufp: *mut *const u8) -> u64 {
     let mut buf = *bufp;
@@ -22,6 +25,11 @@ pub unsafe extern "C" fn decode_varint(bufp: *mut *const u8) -> u64 {
     val
 }
 
+/// # Safety
+///
+/// The provided buffer must be large enough to store the encoded varint. Callers may either provide
+/// a `[u8; 16]` here, which is guaranteed to satisfy all encodable numbers. Or they can call this
+/// function with a `NULL` pointer first to figure out array size.
 #[no_mangle]
 pub unsafe extern "C" fn encode_varint(value: u64, buf: *mut u8) -> u8 {
     let mut varint: [u8; 16] = [0; 16];

-- 
2.51.0.764.g787ff6f08a.dirty


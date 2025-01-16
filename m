Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4421DDC3F
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 10:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737022128; cv=none; b=LaXgKUf0UpTeBWAvf6K/1Lh4RQXWkZnwSyAk3xAiPnwgRb2zIbs6Tst9yEMTlO5yUbs7MhRBsAIQ/EPnYoPctNx9vdw2iAsV0KMTX/tyWBIroSLoN8QIx2w1xTGL2NmTpbSSMOPZSlaXIQYjP3k/5KqNNPy4x3+MHYWqEYIaDyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737022128; c=relaxed/simple;
	bh=2fQJtX3NTdXO8OKKCNTdB67rFdW94l+9bC3gjTjh5CU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bv/wMQGt0+Jd7EErebmEwmMK11PVtC3YFfgMkYLokS4zqg6O6+S0yydAY3FySVCKYrHhpfYOu27O38EB2JL9o+peok+7m5Qd+N69n4kZ6qhkmpvSF3sZUZZ2+ffnGoRE8VN3h68oeQnr9pghZsmVDMyo7z/VEYnrr3OOhov1mJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PHBPd9MM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CiSXW78X; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PHBPd9MM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CiSXW78X"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 504E7114016D
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 05:08:46 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 16 Jan 2025 05:08:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1737022126;
	 x=1737108526; bh=Z/Sm9Zlp0hVf15+pFN9ng9mhqTkLhnK31CaQcTBpJ9Q=; b=
	PHBPd9MMaBs5rnw3dMYv3furzT3EmrfmX4ZA6NmnjhFev6r/2k2y+x7kKUce7XsD
	y+YAaeC5c1rWJBM6f3RUnAI4OX1YRblVsLC2Hwq7hjUDJ/oXpzOmXjrbz+NJvjYK
	R0KaapnhtpiViMypdzX71jDRqgwMZt82CUvhcNXqdK9A9CvyRnnmFdg5Y8zFFo4F
	BAHIW2ZV6ryUhbIpT78Ou2eWxBZ49/MBiL8clH0RfPWdDE4S6672qUPZr1VdzD+z
	Yfop71PaahQ5X3cralFNKGQpmSyM2S340QSI+4FQCtrpNGN9/eRwUpL8t5ig6K9L
	MSMXZyWY/tJha9+T/bdzRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1737022126; x=
	1737108526; bh=Z/Sm9Zlp0hVf15+pFN9ng9mhqTkLhnK31CaQcTBpJ9Q=; b=C
	iSXW78X29qLNuG1+JbDA/+hy9WhU9xknjcFKh6yueTbmj0eahajl4ZsBXEWTDBfs
	Pqqfdcc4AJ58oeCC3mAdWaNJrxIkR03FyjhhLgGV8HmwefczQpMKRwWqksteJCbj
	tM3Ztn3B7E5CXKErqCt0uxsrqNB0uJjHlUV2QhcTDoN04Z5sYkpL9UmX/wRwNdLG
	Ho5XxpZzciMn6J0F5Sl8pXNVkmZNTB5jwYt+eNjOmtSTutbRo1p7xUjjReVnWZbL
	JqkPx4eqwKKHF/bkUFy3zO0mq2Wecxjyes17B2Xvxf6mNNoRE8bQpAyRbtgfXG6Y
	91TDzwSGwhFKddhBrleYg==
X-ME-Sender: <xms:rtqIZ7nFi4lEdsD437CBloJmhe1m2DJgV1DZWrXVXmvz7YDeoiW8bA>
    <xme:rtqIZ-2BqSA7mQdx738OVuNYItwRYALBZPJSBixFW3hP9c07d-PAhCtdz5kF-wBjK
    nedKcRvFtFpYGP1Rw>
X-ME-Received: <xmr:rtqIZxqYw3bIXLS6QmPDntQt83LZ2bohr_uLzUGtstpr1IsG7HbFBdD_TKalRfJX10ZUjLr9bFrvX8ff68xt5FAsSKdG4STBXirpF64L6OnfhdoSQg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:rtqIZzmLylSIC9808wePjy5FAN0JT3gyupkhRN98om0PYdSJ1GrivQ>
    <xmx:rtqIZ51BIhaCzhDSk8RDUwjgtBvzLi39t4bPulC1gn0jEYi9q50ThQ>
    <xmx:rtqIZyuaK1fakLF7HNWq8gUM9Vw4RRlX2dIe-Jx7D9gFC5028RytGQ>
    <xmx:rtqIZ9XXVCa2kmMOSL2_HvqEUJASoQje0gv6FyEn-9cuqT33P3OWdA>
    <xmx:rtqIZ69kKFwWVN_XMt3wFKGOCMIusVrg4OdN0a719PEmn5AbiMrCp0wa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 16 Jan 2025 05:08:45 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 15a16cc4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 16 Jan 2025 10:08:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 16 Jan 2025 11:08:38 +0100
Subject: [PATCH 06/10] reftable/block: adapt header and footer size to
 return a `size_t`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-b4-pks-reftable-sign-compare-v1-6-bd30e2ee96e7@pks.im>
References: <20250116-b4-pks-reftable-sign-compare-v1-0-bd30e2ee96e7@pks.im>
In-Reply-To: <20250116-b4-pks-reftable-sign-compare-v1-0-bd30e2ee96e7@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

The functions `header_size()` and `footer_size()` return a positive
integer representing the size of the header and footer, respectively,
dependent on the version of the reftable format. Similar to the
preceding commit, these functions return a signed integer though, which
is nonsensical given that there is no way for these functions to return
negative.

Adapt the functions to return a `size_t` instead to fix a couple of sign
comparison warnings.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block.c                    | 4 ++--
 reftable/block.h                    | 4 ++--
 t/unit-tests/t-reftable-readwrite.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index 2380aabb2f..1275085257 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -15,7 +15,7 @@ license that can be found in the LICENSE file or at
 #include "system.h"
 #include <zlib.h>
 
-int header_size(int version)
+size_t header_size(int version)
 {
 	switch (version) {
 	case 1:
@@ -26,7 +26,7 @@ int header_size(int version)
 	abort();
 }
 
-int footer_size(int version)
+size_t footer_size(int version)
 {
 	switch (version) {
 	case 1:
diff --git a/reftable/block.h b/reftable/block.h
index 5f67ed74c5..bef2b8a4c5 100644
--- a/reftable/block.h
+++ b/reftable/block.h
@@ -137,10 +137,10 @@ void block_iter_reset(struct block_iter *it);
 void block_iter_close(struct block_iter *it);
 
 /* size of file header, depending on format version */
-int header_size(int version);
+size_t header_size(int version);
 
 /* size of file footer, depending on format version */
-int footer_size(int version);
+size_t footer_size(int version);
 
 /* returns a block to its source. */
 void reftable_block_done(struct reftable_block *ret);
diff --git a/t/unit-tests/t-reftable-readwrite.c b/t/unit-tests/t-reftable-readwrite.c
index 6b75a419b9..2e553154ea 100644
--- a/t/unit-tests/t-reftable-readwrite.c
+++ b/t/unit-tests/t-reftable-readwrite.c
@@ -643,7 +643,7 @@ static void t_write_empty_table(void)
 	check_int(err, ==, REFTABLE_EMPTY_TABLE_ERROR);
 	reftable_writer_free(w);
 
-	check_int(buf.len, ==, header_size(1) + footer_size(1));
+	check_uint(buf.len, ==, header_size(1) + footer_size(1));
 
 	block_source_from_buf(&source, &buf);
 

-- 
2.48.0.257.gd3603152ad.dirty


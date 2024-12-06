Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52501202C35
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 10:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733480865; cv=none; b=HgYF8k4UNg3NeNnH+zLWmFR/uuHi/NgdlpBGYouyEW+0ZAPPpbdNLkX8Gz0ZJ8cax5PI69fgKS79XBdPTi31B0yb9UC6YUWyOPLqqegE863KgrNxZyu15JyFU2jxJeSDyqOvczirNh/D3PNNsrYo/0ZZEOP7ns5RzOtvS2OxDuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733480865; c=relaxed/simple;
	bh=9idDw9a3ghceEKfwMFfZou7ibAVDLPZ/fx5UQGxSwjQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YCnDDwkkyaT6EIkiITsp5ou5NRWx9Zy/ev7k6dY2IZrfPvJTyEUqmmtQBcUmu82sBbqv/NVjyetyLyxzj/uwiWVIBEU+zZ76HyYNkeQ0CeQbjhJJuAHpNxgs6t+4tkK50/5rg63ldeS3eXbUt2v1J7UyguyCBpupVjN/M0zwYu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Usen9/9+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aaStIWxI; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Usen9/9+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aaStIWxI"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 67B7E114019D;
	Fri,  6 Dec 2024 05:27:43 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 06 Dec 2024 05:27:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733480863;
	 x=1733567263; bh=QbdMSJMfkp0/ImGVEVlA9hsHcvgfxuuU6m1G1ySNEuI=; b=
	Usen9/9+tJJUfrPLapZRmt0RDwNaNsE9ueLWJ6Ovl9C3WNDESwvDJ7YWDQrKS+x6
	y8pCV9uEb6kV72FkRZaODp60hs7UteF/pVX1k7acFxD572W75ZNCdeNfIFhk2jJT
	m0S+9LjRD6LNniD5GzV8bVYY2BfbfvtUsMBOuBn/ABoYwml+cTT4U/2glVVpr1Jv
	XzQjfChqqRmxBc93PxiIOKWIQ7EsXziPOXJefti6k4TxxFRApHrkMaJehMBkMfoT
	xgsimPrvhhKwPmGNYNJ60Ddti84PxpP396vQ+4q9yR2zfn00suRZsdCFbS4D2IIY
	xNbHN6SSp7fpX5p6SS757g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733480863; x=
	1733567263; bh=QbdMSJMfkp0/ImGVEVlA9hsHcvgfxuuU6m1G1ySNEuI=; b=a
	aStIWxIqO2C9AmuxyFtkg1N6kgN6WtCbjUw6wXCjSsuItWiWS4vAdQP6LCatxO5D
	GZ2bVWEVHO/xUsEv72ZF1iLSgFqmwTZpVk1tNy3pCVQMdwVEkuGpQ+PoWyZJU6+h
	nMEcLxLTL9q8EE51j9mZFTqRCX7S2PdvnzBC5C8Vb8lKpuP7ZNYSwaTJ3pJH4X60
	Axp+bMum+ciQGHFMH45zRmeufxiCgCFGJ9hmq/sxSc73/ganIHQJ3zUnDD7JuVjq
	DG6S/7U5tnl4utvQ6exXhzL2X6Bf2apiQvo7KDvRrdsGP00sVTK+Y1qjb0ULzjGN
	2AGY3o8FlZEVDmBJSO4cg==
X-ME-Sender: <xms:n9FSZ8NjfhvjiFbHLwcad9X3CDRTL1an1g-JFmVq3bpIHiyUDMHPlw>
    <xme:n9FSZy_IK5xT4UJGbAD-hjbOvZvaIPyZBEyvtaKxEodoUZUgW58hp6P0VEWX3CZQB
    vh1Ckfi-PczcJrO3w>
X-ME-Received: <xmr:n9FSZzTOMhkkdI2lT2hG6-q5F8gElVX56goR0r-e7FaqbcJPTszubcZGWAnIPhRJf1vLXcH3yj28n5MbOB9KVsF3MWbWPYEeU6_ITmYrJ83QEQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieelgdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvd
    ekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshhgvjhhi
    rghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:n9FSZ0vwt9SVZ6diyhQV3OipXm-aSrd3O89sZmc09os9H3i1SaYW2Q>
    <xmx:n9FSZ0d2nJ_Rz3Y-vTYuTisYsDPki_8ct5mz5H86IkBtEFv5tA8zFQ>
    <xmx:n9FSZ43CPKR19gJQriCdJ5X4dvrdJ_lCeAIKteZg_z-4eihK-B96jg>
    <xmx:n9FSZ48VQ5dQOB9HZgVKymW0WUJ2pY5UwOOtLrFjMFbw6hkA_IdiQA>
    <xmx:n9FSZz4npm2zH5yEiKymbN5rHDiRSq1w2OfTFnqnM3C-A2A22gvtWfUB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Dec 2024 05:27:42 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 17c68933 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Dec 2024 10:26:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 06 Dec 2024 11:27:23 +0100
Subject: [PATCH v4 08/16] pkt-line: fix -Wsign-compare warning on 32 bit
 platform
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-pks-sign-compare-v4-8-0344c6dfb219@pks.im>
References: <20241206-pks-sign-compare-v4-0-0344c6dfb219@pks.im>
In-Reply-To: <20241206-pks-sign-compare-v4-0-0344c6dfb219@pks.im>
To: git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>, Jeff King <peff@peff.net>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Similar to the preceding commit, we get a warning in `get_packet_data()`
on 32 bit platforms due to our lenient use of `ssize_t`. This function
is kind of curious though: we accept an `unsigned size` of bytes to
read, then store the actual number of bytes read in an `ssize_t` and
return it as an `int`. This is a whole lot of integer conversions, and
in theory these can cause us to overflow when the passed-in size is
larger than `ssize_t`, which on 32 bit platforms is implemented as an
`int`.

None of the callers of that function even care about the number of bytes
we have read, so returning that number is moot anyway. Refactor the
function such that it only returns an error code, which plugs the
potential overflow. While at it, convert the passed-in size parameter to
be of type `size_t`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 pkt-line.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/pkt-line.c b/pkt-line.c
index 90ea2b6974b1d0957cfdc5e2f9a2c30720723f12..2dc29d5b68e45740a7f4e473b7c7ffa57bc09528 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -340,30 +340,32 @@ int write_packetized_from_buf_no_flush_count(const char *src_in, size_t len,
 }
 
 static int get_packet_data(int fd, char **src_buf, size_t *src_size,
-			   void *dst, unsigned size, int options)
+			   void *dst, size_t size, int options)
 {
-	ssize_t ret;
+	size_t bytes_read;
 
 	if (fd >= 0 && src_buf && *src_buf)
 		BUG("multiple sources given to packet_read");
 
 	/* Read up to "size" bytes from our source, whatever it is. */
 	if (src_buf && *src_buf) {
-		ret = size < *src_size ? size : *src_size;
-		memcpy(dst, *src_buf, ret);
-		*src_buf += ret;
-		*src_size -= ret;
+		bytes_read = size < *src_size ? size : *src_size;
+		memcpy(dst, *src_buf, bytes_read);
+		*src_buf += bytes_read;
+		*src_size -= bytes_read;
 	} else {
-		ret = read_in_full(fd, dst, size);
+		ssize_t ret = read_in_full(fd, dst, size);
 		if (ret < 0) {
 			if (options & PACKET_READ_GENTLE_ON_READ_ERROR)
 				return error_errno(_("read error"));
 			die_errno(_("read error"));
 		}
+
+		bytes_read = (size_t) ret;
 	}
 
 	/* And complain if we didn't get enough bytes to satisfy the read. */
-	if (ret != size) {
+	if (bytes_read != size) {
 		if (options & PACKET_READ_GENTLE_ON_EOF)
 			return -1;
 
@@ -372,7 +374,7 @@ static int get_packet_data(int fd, char **src_buf, size_t *src_size,
 		die(_("the remote end hung up unexpectedly"));
 	}
 
-	return ret;
+	return 0;
 }
 
 int packet_length(const char lenbuf_hex[4], size_t size)

-- 
2.47.0.366.g5daf58cba8.dirty


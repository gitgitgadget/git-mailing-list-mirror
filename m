Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA4E14F98
	for <git@vger.kernel.org>; Sat, 18 Jan 2025 01:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737163645; cv=none; b=qXObypcx7uoy2mxIYNGCywz+eeDUJTGM5gbc/mp8KbxGtd5UpNy1F7ZZuNLQzkB9e9OFDb2YU5oVpZu8iIZnq0ormgB+xxpvuOSurlp+1xNzrMj5I4ppw29Dfi/1K36uuMxEzaz6zf5Y0nDz38erMulfYrsGlz7alOb6X0firzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737163645; c=relaxed/simple;
	bh=4YAnK1E+lXjUpWhpBFakwbnut/ih3cHZsVhkOPWmQZ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JSkq/fXBbP+V5uHgkktR5mhPAdCTwVdd05o3agx+wZAx/8tb89pZeQ0FD6sYLFxhaBfgnKyiLLH9C3JWvRpoUbNPx0uq1G44POoLzSH/GX/V/u6HSEvepu///y2eEizwPDA98STvPw6+locJomAfXBrWsvJHJhDCR/Cf1JYa39c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lyyUdl9y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fgVFHA6r; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lyyUdl9y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fgVFHA6r"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CB2132540108;
	Fri, 17 Jan 2025 20:27:22 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 17 Jan 2025 20:27:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1737163642; x=1737250042; bh=tGVCXCrGca
	XFF5yAgSSNecWBvKCMlZCw+2ifCYwOxOk=; b=lyyUdl9yv8h+k3fVsyN6Ll2eoE
	M/v4XQjuEHDunv6ZOAT5wn6hhlj2DN61HMVo0zfI4tas30MkMIJRx8a5kJi6TgJd
	8dgXnvvzN1wUGbfEmaHnRvi+s1YapK0ygvZML3ebkrQkVKp5IuJIMP0pjQtlhhaq
	PynndLLXC0xSrAV6WHvbLyC5UfGgmLyo26GNawVEIXnYxdgmuwVnRaw8fVzGWQHy
	Eaq0+WtE1JDF9igHa81/J5IceIwUqfi25nQRKbwH8N+CW7pOrIGW6JeIQUnnO6Jl
	fyvgveI5bSjBuMKUnp27fzh/aHRDDiGo0sQUhLbF6muTq0Q/0S721UKYEh1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737163642; x=1737250042; bh=tGVCXCrGcaXFF5yAgSSNecWBvKCMlZCw+2i
	fCYwOxOk=; b=fgVFHA6rkA/5DkO7YnA9QUBUdt+yC7wprXsVsky6E1sZtV3JAFV
	w0OpNVgZmZ/zNDt+IMNPQ/kfnf6aRfreBxh+mPjhoxZlYlp+X15v7fMGYsI1MKY/
	/UMPKzhacGytwUCj+Uf+NG78e0ez7z++RFqF+UvJe31dam3fdDKiXCqpxJMKAHwQ
	wfPRHxBrWQjyqFeXkfn/faBiEYgx64+Jwj82eupLVXwQP4F1Xh8HoqcR0xwKMZ8V
	cxiA0G56mKQ4WUDjG1CTDTqoRZXOifQI70aTNqwfc/dU8jfErTSch+tdnPbghuB0
	OiLOwwpVbiryyih6qNdgKDCZWbY1H7q9JTg==
X-ME-Sender: <xms:egOLZ4Y2uqYIobxZnEDULS0H64YaFxXU3hp85niFIxczmdpoAckbfw>
    <xme:egOLZza3wwnZ_F0Tl8j7SEY4F3BEmRAWcoGHo5TYQjI519gUA-qtBzEuhF5BqmZkR
    xqZ4oVoOHygMxQcKg>
X-ME-Received: <xmr:egOLZy_eF7CXaKk4L-wlQbR3IKdOnyrVHl1p6jzKxltgzWlMWan7wi9eTDREK5pBcQHKTa_d9P5aD8sePN5_5yQKFKVmE3ZTpYAa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeigedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    gjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefve
    etteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepkhhorggthhgrnh
    esphhrohhtohhnmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:egOLZypA_0Uy4VkGOASmr3329wbwBvj6rOpnNGuxXkjcLjpNFPc5VA>
    <xmx:egOLZzrST_DRVetP3dfy3cNTZshNiNA_U7ox-z8KMYYgI9nZXvS0vg>
    <xmx:egOLZwQ7O6PE4Cs-PBccYozmAh1-CigA21FeECi2Os_AcTjZ_kOr4w>
    <xmx:egOLZzpKiwksXI_TU-1BRzTYvV3WpmcrtBMXlwjXLglS3E1ZUZCF4Q>
    <xmx:egOLZ0kmYtPWqL9vjIVQEOF83zU8xeK28KdbXO110KUPoqXDoKemEeN0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jan 2025 20:27:22 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Koakuma <koachan@protonmail.com>,  "git@vger.kernel.org"
 <git@vger.kernel.org>
Subject: Re: [PATCH 2/3] parse_pack_header_option(): avoid unaligned memory
 writes
In-Reply-To: <20250117125530.GB2893666@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 17 Jan 2025 07:55:30 -0500")
References: <20250117125207.GB2356599@coredump.intra.peff.net>
	<20250117125530.GB2893666@coredump.intra.peff.net>
Date: Fri, 17 Jan 2025 17:27:21 -0800
Message-ID: <xmqq7c6s52ti.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> +	put_be32(hdr, PACK_SIGNATURE);

Tonight's comedy.  PACK_SIGNATURE is defined as 0x5041434b (in pack.h)
In <compat/bswap.h> we want to take advantage of the fact that
assigning any unsigned integer to *(unsigned char *) would assign
the integer's least significant 8 bits.

static inline void put_be32(void *ptr, uint32_t value)
{
	unsigned char *p = ptr;
	p[0] = value >> 24;
	p[1] = value >> 16;
	p[2] = value >>  8;
	p[3] = value >>  0;
}

But sparse seems not to like that.

compat/bswap.h:175:22: error: cast truncates bits from constant value (5041 becomes 41)
compat/bswap.h:176:22: error: cast truncates bits from constant value (504143 becomes 43)
compat/bswap.h:177:22: error: cast truncates bits from constant value (5041434b becomes 4b)

Of course we could do the mask, but should we have to?

I think the real compiler would be clever ehough to produce the
identical binary with the following patch that is only needed to
squelch this error, but I feel dirty after writing this.

By the way, a "git grep" finds 

	put_be32(&hdr_version, INDEX_EXTENSION_VERSION2);

in the fsmonitor.c file, which does not get flagged only because the
CPP macro expands to a small integer (2).  That is doubly insulting.


 compat/bswap.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git c/compat/bswap.h w/compat/bswap.h
index 512f6f4b99..b34054f2bd 100644
--- c/compat/bswap.h
+++ w/compat/bswap.h
@@ -171,23 +171,23 @@ static inline uint64_t get_be64(const void *ptr)
 static inline void put_be32(void *ptr, uint32_t value)
 {
 	unsigned char *p = ptr;
-	p[0] = value >> 24;
-	p[1] = value >> 16;
-	p[2] = value >>  8;
-	p[3] = value >>  0;
+	p[0] = (value >> 24) & 0xff;
+	p[1] = (value >> 16) & 0xff;
+	p[2] = (value >>  8) & 0xff;
+	p[3] = (value >>  0) & 0xff;
 }
 
 static inline void put_be64(void *ptr, uint64_t value)
 {
 	unsigned char *p = ptr;
-	p[0] = value >> 56;
-	p[1] = value >> 48;
-	p[2] = value >> 40;
-	p[3] = value >> 32;
-	p[4] = value >> 24;
-	p[5] = value >> 16;
-	p[6] = value >>  8;
-	p[7] = value >>  0;
+	p[0] = (value >> 56) & 0xff;
+	p[1] = (value >> 48) & 0xff;
+	p[2] = (value >> 40) & 0xff;
+	p[3] = (value >> 32) & 0xff;
+	p[4] = (value >> 24) & 0xff;
+	p[5] = (value >> 16) & 0xff;
+	p[6] = (value >>  8) & 0xff;
+	p[7] = (value >>  0) & 0xff;
 }
 
 #endif /* COMPAT_BSWAP_H */


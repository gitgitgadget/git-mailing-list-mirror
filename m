Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7666B327A30
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 15:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757518577; cv=none; b=BBpMXbnryWvMEkpCY35RQOYvFxW+Ky4xwmjO3qh84pviSmL00kYTrH/bUVKZJgNnZFqD68HCqMBUuUygFQY8nNh4cgmyOUhGbf0G2IiUOeqfzAjGbpfd3+7ToDBvd/94hunNRS2T3BkJV1a7QUAFh6xmF5fEwt71REH7LJy6AMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757518577; c=relaxed/simple;
	bh=wQSb4IbPAF4GinJMCmjHfFUnNy1iyMciIAqsbaqyvks=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ECEX2790PH3nLesJM+hFiTJ5Rpb1HAr9uIvtCM9DQCmbU3uKf/T4zcEo62InsYk6GptgcBN9++xeyQrs6UePXnHpNjxVLQ5yQ9oobOuq6DIbGUchlNQ1eI1yL4I9oNWaJP5OZvgGFvR8FczFlMgLi/V8v3EBC6xkgEomxrJzXno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PzrOVpes; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I4aKFhR6; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PzrOVpes";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I4aKFhR6"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AE70C1400328;
	Wed, 10 Sep 2025 11:36:14 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 10 Sep 2025 11:36:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757518574;
	 x=1757604974; bh=dy6XbL2Adt5qCoFOTgX06OKnMjpAB+tt6grS9V0/kEA=; b=
	PzrOVpesOsA3w4owyqnCY2TYk/lpATam12CTszfm16NagSfmog0LOfUz8Tu8Hf+K
	uuppGmxIu9+oPYRSAJq8Rk8UMvNoBFP0gPaaSQZN7eW4Sy++xxhDl1xgc/Yq5OD8
	JP8jzraamVvtkmcciHs3rWS5cDzRLoyvwyHpIbMQLzg3YHeMuM7A3r9ksMOEBs1X
	EarCKOnsKacmPAzn4SDoeWC3Yku+DBdXuF+NX96AC3Y4scxJ3dGF2twMCgk7rhTL
	Tdcrb9/bQzcQk3yW35awz82VUh8AtUlhWjIjDYKq4YtR9/w4Qy2VxvSIPG+LiTO6
	cb1pH335xy82elxTvMWCFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757518574; x=
	1757604974; bh=dy6XbL2Adt5qCoFOTgX06OKnMjpAB+tt6grS9V0/kEA=; b=I
	4aKFhR69Dz9ljb8hMVEz1WXloRM9kNhX/BGiyejp/UMd6dJkl/W1d5d3IIuJduXv
	JBNsnS0V6+RVjfWu4BVyiG7wYMDtekBdlngSG82mpUeY9oHOYrmjMzQk2c0Gxg8B
	Qc6T9ZJr5g4AzFsCXJkp+ddhgFuA5uUIPuPzhxHygeMHSILrxgSoCWrfaapTOSFK
	KfkKlyf1ZisOyZocyZ+mS8TRj/FR9ZcwwoT3d1x3KypzL1mBxXSro+YhVf0GLBTh
	7FzqrYoOj0fYyZurRJpqeK4ECf7YHMCMHzD09uUF11+FEAn0glbJ34vd88dcAWLa
	tXo39Lxs9ZyGWX0Aog1PA==
X-ME-Sender: <xms:7prBaIiccDsrGWL8jZ0rcd4UlJ8g9X4JsdR7hCxpMOs2mSUOsrC3rA>
    <xme:7prBaBJnsPv4Wg3X3tCcR08mIUr7bALpCKVTVNq3Lddn8H85RL4GadBvo8GFizVIU
    JzimtijZciIo64kIA>
X-ME-Received: <xmr:7prBaHgjg85UxaNd5F9VGsOS8uQGjlZgFXYt3ybWHNticBmsyWNr1g8u06nvkTH-41I1m8pmtawRN0UPlbmyvK-StJVUOmHk1n10Dxn29yY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeeiiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepudehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilh
    hlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomhdprhgtphhtthhopehpihgvrhhrvgdqvghmmhgrnhhuvghlrd
    hprghtrhihsegvmhgsvggtohhsmhdrtghomhdprhgtphhtthhopegtsgesvdehiegsihht
    rdhorhhgpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopegtohhnthgrtghtsehhrggt
    khhtihhvihhsrdhmvgdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhoth
    hhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:7prBaP2JGi9p7SS80IvKJQh4qvTCcjpXVzD8oDlmU9l8urryzgr5Rg>
    <xmx:7prBaNgy6ZzO5SD8QyJISKnfUtdPTMIZdXbHI9Ph42YLmM9MCr9U2A>
    <xmx:7prBaA-7QxZf2FZKr_Fl6QtKxJ3wsuU5ajy0lM9sBsw1IGR3GDHWzg>
    <xmx:7prBaJKSZPxSSFinS4Grb94gO9ZhQr62BrReFE8YKnRSkEG_Q2R9RA>
    <xmx:7prBaKO7cbXzR0WFVOMpTnDJHIhkBjHWxhTmGXjpJGPACJXMtSO6id3B>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Sep 2025 11:36:12 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f9e9a48b (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 10 Sep 2025 15:36:11 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 10 Sep 2025 17:35:51 +0200
Subject: [PATCH RFC v4 5/9] varint: use explicit width for integers
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-b4-pks-rust-breaking-change-v4-5-4a63fc69278d@pks.im>
References: <20250910-b4-pks-rust-breaking-change-v4-0-4a63fc69278d@pks.im>
In-Reply-To: <20250910-b4-pks-rust-breaking-change-v4-0-4a63fc69278d@pks.im>
To: git@vger.kernel.org
Cc: "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Ben Knoble <ben.knoble@gmail.com>, Christian Brabandt <cb@256bit.org>, 
 Collin Funk <collin.funk1@gmail.com>, Eli Schwartz <eschwartz@gentoo.org>, 
 Elijah Newren <newren@gmail.com>, Ezekiel Newren <ezekielnewren@gmail.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Junio C Hamano <gitster@pobox.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>, 
 Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.14.2

The varint subsystem currently uses implcit widths for integers. On the
one hand we use `uintmax_t` for the actual value. On the other hand, we
use `int` for the length of the encoded varint.

Both of these have known maximum vaules, as we only support at most 16
bytes when encoding varints. Thus, we know that we won't ever exceed
`uint64_t` for the actual value and `uint8_t` for the prefix length.

Refactor the code to use explicit widths. Besides making the logic
platform-independent, it also makes our life a bit easier in the next
commit, where we reimplement "varint.c" in Rust.

Suggested-by: Ezekiel Newren <ezekielnewren@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 dir.c        | 18 ++++++++++--------
 read-cache.c |  6 ++++--
 varint.c     |  6 +++---
 varint.h     |  4 ++--
 4 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/dir.c b/dir.c
index 71108ac79b7..0a67a99cb3d 100644
--- a/dir.c
+++ b/dir.c
@@ -3579,7 +3579,8 @@ static void write_one_dir(struct untracked_cache_dir *untracked,
 	struct stat_data stat_data;
 	struct strbuf *out = &wd->out;
 	unsigned char intbuf[16];
-	unsigned int intlen, value;
+	unsigned int value;
+	uint8_t intlen;
 	int i = wd->index++;
 
 	/*
@@ -3632,7 +3633,7 @@ void write_untracked_extension(struct strbuf *out, struct untracked_cache *untra
 	struct ondisk_untracked_cache *ouc;
 	struct write_data wd;
 	unsigned char varbuf[16];
-	int varint_len;
+	uint8_t varint_len;
 	const unsigned hashsz = the_hash_algo->rawsz;
 
 	CALLOC_ARRAY(ouc, 1);
@@ -3738,7 +3739,7 @@ static int read_one_dir(struct untracked_cache_dir **untracked_,
 	struct untracked_cache_dir ud, *untracked;
 	const unsigned char *data = rd->data, *end = rd->end;
 	const unsigned char *eos;
-	unsigned int value;
+	uint64_t value;
 	int i;
 
 	memset(&ud, 0, sizeof(ud));
@@ -3830,7 +3831,8 @@ struct untracked_cache *read_untracked_extension(const void *data, unsigned long
 	struct read_data rd;
 	const unsigned char *next = data, *end = (const unsigned char *)data + sz;
 	const char *ident;
-	int ident_len;
+	uint64_t ident_len;
+	uint64_t varint_len;
 	ssize_t len;
 	const char *exclude_per_dir;
 	const unsigned hashsz = the_hash_algo->rawsz;
@@ -3867,8 +3869,8 @@ struct untracked_cache *read_untracked_extension(const void *data, unsigned long
 	if (next >= end)
 		goto done2;
 
-	len = decode_varint(&next);
-	if (next > end || len == 0)
+	varint_len = decode_varint(&next);
+	if (next > end || varint_len == 0)
 		goto done2;
 
 	rd.valid      = ewah_new();
@@ -3877,9 +3879,9 @@ struct untracked_cache *read_untracked_extension(const void *data, unsigned long
 	rd.data	      = next;
 	rd.end	      = end;
 	rd.index      = 0;
-	ALLOC_ARRAY(rd.ucd, len);
+	ALLOC_ARRAY(rd.ucd, varint_len);
 
-	if (read_one_dir(&uc->root, &rd) || rd.index != len)
+	if (read_one_dir(&uc->root, &rd) || rd.index != varint_len)
 		goto done;
 
 	next = rd.data;
diff --git a/read-cache.c b/read-cache.c
index 06ad74db228..41b44148b1e 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1807,7 +1807,7 @@ static struct cache_entry *create_from_disk(struct mem_pool *ce_mem_pool,
 
 	if (expand_name_field) {
 		const unsigned char *cp = (const unsigned char *)name;
-		size_t strip_len, previous_len;
+		uint64_t strip_len, previous_len;
 
 		/* If we're at the beginning of a block, ignore the previous name */
 		strip_len = decode_varint(&cp);
@@ -2655,8 +2655,10 @@ static int ce_write_entry(struct hashfile *f, struct cache_entry *ce,
 		hashwrite(f, ce->name, len);
 		hashwrite(f, padding, align_padding_size(size, len));
 	} else {
-		int common, to_remove, prefix_size;
+		int common, to_remove;
+		uint8_t prefix_size;
 		unsigned char to_remove_vi[16];
+
 		for (common = 0;
 		     (common < previous_name->len &&
 		      ce->name[common] &&
diff --git a/varint.c b/varint.c
index 409c4977a1e..03cd54416b6 100644
--- a/varint.c
+++ b/varint.c
@@ -1,11 +1,11 @@
 #include "git-compat-util.h"
 #include "varint.h"
 
-uintmax_t decode_varint(const unsigned char **bufp)
+uint64_t decode_varint(const unsigned char **bufp)
 {
 	const unsigned char *buf = *bufp;
 	unsigned char c = *buf++;
-	uintmax_t val = c & 127;
+	uint64_t val = c & 127;
 	while (c & 128) {
 		val += 1;
 		if (!val || MSB(val, 7))
@@ -17,7 +17,7 @@ uintmax_t decode_varint(const unsigned char **bufp)
 	return val;
 }
 
-int encode_varint(uintmax_t value, unsigned char *buf)
+uint8_t encode_varint(uint64_t value, unsigned char *buf)
 {
 	unsigned char varint[16];
 	unsigned pos = sizeof(varint) - 1;
diff --git a/varint.h b/varint.h
index f78bb0ca528..eb401935bd2 100644
--- a/varint.h
+++ b/varint.h
@@ -1,7 +1,7 @@
 #ifndef VARINT_H
 #define VARINT_H
 
-int encode_varint(uintmax_t, unsigned char *);
-uintmax_t decode_varint(const unsigned char **);
+uint8_t encode_varint(uint64_t, unsigned char *);
+uint64_t decode_varint(const unsigned char **);
 
 #endif /* VARINT_H */

-- 
2.51.0.450.g87641ccf93.dirty


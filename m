Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32982F60AD
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 06:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758781837; cv=none; b=k1WW6yq0vFz/8Q7HYT+AzIvkISJHstWQrydasAXLHBM7Aj1TCgM+EddrOMJqfYHAu2dWSkN14drJeSj7XRtd/T4Cn7LHKvYNzf+7UfRDu6bAeEH0//DOvpo52kTheHnHK5ORAv4gaYQMWN/PxtixDcd4xhOMFlFgmv2ira18Di8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758781837; c=relaxed/simple;
	bh=p7fMij6XDlYcaXxooqOFQboe2MXncizBUvMezxlszzk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VkEhtlPaUF7QYtrYfGAK+/jjqu6wejh0+qAgKPgRHyVAgE7Xi4z9OzlxFOM2+1wQr8E0kXCZ9Q0O/emnqR9AY1shEDZVMvl08YOaydTqb+tCWPe2n41JHZAYOOINHN41r91L5g7Gkz5qCX3MClotbsNHC5eJ6Ek7ZDKsRvVI/zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=roheC3Bs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mvg90END; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="roheC3Bs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mvg90END"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8486F7A0149;
	Thu, 25 Sep 2025 02:30:34 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 25 Sep 2025 02:30:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758781834;
	 x=1758868234; bh=ez0vW7bZ9Zn+STHfmGvVYXGQuMQ5+eIO/gZkC4hhTYc=; b=
	roheC3BsJ48hYYu9m+y5Tl3n/rKRRox2Z5xnbBwVrTDJ94kmAPAvf0k6a9vwx374
	O+lgyvhnTNz9rBXpdbEY/pf5KEwhHdHBxiD7BeL0epubNlA+ctTEEkuRjQKVbpPk
	FFyTHgv/CNjVa9qp8C3oicZvJVQSsJAOAjg6GJnrc9FQR5ZHHKcqNdAhnz2vmzMH
	FNxOMoHVHFj6tkXrw1sKGSIun+yBRMRbqewaWv3k8MxCqUsXpcLrtGGvuA5DP/rk
	7arS6hBFIrwS1G80qQc37GwbO5i/joDquxDJanISs1wFY1GkcnlH5uhBD1xdydAb
	lIj/vqWKAvh2oRbEWRsh1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758781834; x=
	1758868234; bh=ez0vW7bZ9Zn+STHfmGvVYXGQuMQ5+eIO/gZkC4hhTYc=; b=m
	vg90ENDUoMR8RrhkSoG4kG5X10dUZvk71Kno4UAcQYSt7OnTFr/CYDhJEzBUQWzh
	h0VV7IPOmqbAX53K2G/ujktGKG57c+cIvTDIV34Tj5T4kUsmibANFmviXXXt8yNb
	n7XNNvcWECpttOlHjImT6KgfQV1rAkaZxN8uShp62m5e8oQON+cCLHjvA6fYnek4
	U/Mv+a3HKitDWGU8+4hEQYFLpJSUJ4GHS6lXFBpepBlDJs7XS62UnmEAg8/TRbU5
	svHvah4V7SgI8g5QRywbeCTfuXsBVQoWfvFKqf1iG6sM1xz5+MNSIoBqb+54wNUK
	pTHluxZiUMWwQg/OpMh+g==
X-ME-Sender: <xms:ieHUaBjN8BJ-SR5ce9IEZzFceUWqa6WKEz0--N-5JWlX-ArrqDZEjA>
    <xme:ieHUaGdWlX5aCQrgzxRLFc3N2PQBI2DASltbMCxIBqLErVyM0CFkqK8udZgLwp8ud
    SY-uMQKbdyRVYUVwQdFaYRJ8J6iBLcBW2OMWQzWdMwANcz-KjTo>
X-ME-Received: <xmr:ieHUaA3EDWu0xUU0tRCzsTkN_ppV8WNL91qG4cHpHbHrbm0ttVo71f5lSOKlyyFClFwaMIhgXCmlAJA7pD5WL2iQhqlJv9ojhcHN00ZqlMg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiheejjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepudeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtoheptghonhhtrggttheshh
    grtghkthhivhhishdrmhgvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mhdprhgtphhtthhopegtohhllhhinhdrfhhunhhkudesghhmrghilhdrtghomhdprhgtph
    htthhopehsrghmsehgvghnthhoohdrohhrghdprhgtphhtthhopehphhhilhhlihhprdif
    ohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhivghrrhgvqdgvmhhmrg
    hnuhgvlhdrphgrthhrhiesvghmsggvtghoshhmrdgtohhmpdhrtghpthhtohepnhgvfihr
    vghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:ieHUaCr3jUvrP2F5VOSkDi0_imqbTr4lo9GfP9zJfKfbMi-AH8qq5Q>
    <xmx:ieHUaIgD5RieZB1_7kFtQO5PWbN4vYx8667vPigsyRhxmwgY-t0GgQ>
    <xmx:ieHUaGkQwj-2Tem0NM0cgY605N6cNNTVXcRIaFcpAfKNnvE4kQVc3g>
    <xmx:ieHUaJrafMPVkg9_rnacgNS0L1QcaPRAgs2EBygNAGomOno3E1GLbw>
    <xmx:iuHUaFYVwb_7Y0MUs5HpfHY51ScDeA0oG7fN-gfbyjY6ZY5KBAiwz9eO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Sep 2025 02:30:31 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 10ec7827 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 25 Sep 2025 06:30:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 25 Sep 2025 08:30:07 +0200
Subject: [PATCH v7 5/9] varint: use explicit width for integers
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-b4-pks-rust-breaking-change-v7-5-4e49dcb904d5@pks.im>
References: <20250925-b4-pks-rust-breaking-change-v7-0-4e49dcb904d5@pks.im>
In-Reply-To: <20250925-b4-pks-rust-breaking-change-v7-0-4e49dcb904d5@pks.im>
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
 Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
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
2.51.0.618.g983fd99d29.dirty


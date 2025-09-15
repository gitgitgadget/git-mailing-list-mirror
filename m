Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEF02FDC5D
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 11:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757935405; cv=none; b=R3fVkwW2H/EMIibFT1ym7o0aHzB0l97jvTSAjxb6JjlBwvJzcLeIMYqjTC2lmA/GJfqNnsYdw/1vdo8hJaovld9VvN+wcD0Dr38rzj0zs7ZBUKy8gg9CAWmXEaBnRmM8YuvLswmxPRT8xL4qiRvvHIKdlDUEiNWUEhX0blS+pZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757935405; c=relaxed/simple;
	bh=wQSb4IbPAF4GinJMCmjHfFUnNy1iyMciIAqsbaqyvks=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DgJ485Ie2Wo6AECMbpvv2brvAymb5taKSc322LnZbk4JsFQw96eC/qgRZBS0FODLnJsjKM13I9MP1N9D2krHkOfsQYO59hj7lnBTzpxn99vdlB8L1Hp4uHAsMJGgC/+kh4UY//+XDCCf6zqa+J0J9A94prkMjC4i6Gme9YLNhig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=V7phletl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m788CyRW; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="V7phletl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m788CyRW"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9A568140003D;
	Mon, 15 Sep 2025 07:23:22 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 15 Sep 2025 07:23:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757935402;
	 x=1758021802; bh=dy6XbL2Adt5qCoFOTgX06OKnMjpAB+tt6grS9V0/kEA=; b=
	V7phletlL8rtXN0uQYw/xu98T1nonCUG749kJ60PrSv8FYLybENC7lOsGvnZEIxu
	/q3wk/OC10TYGu0h/oq6ZdahBDpfRw/HGMiMoT5J7FIKTGRwcJ9ZQxOm7yVBeoN6
	uLthFmCrtPyV6vrMtGREQ78DeBft919g2tUDrE5KIrPbjjoKj39mDXH6xlNrf9BX
	I1R35DGVEtcIYZh24/K6HUWs2+fDMOG7pcEw/t2hSCH9E5cjbeHT77Ws7SjuJowu
	exk25j0icEPAAmvCbDLxwXXvE5Doxi78WrmLbHQc4Sg3sfwzvsc/zJ542iMdZF/R
	Rv+ecad7zyH/q1vHZCfHkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757935402; x=
	1758021802; bh=dy6XbL2Adt5qCoFOTgX06OKnMjpAB+tt6grS9V0/kEA=; b=m
	788CyRWqZeYMAoN0o26kczC/j8oD9ZDcDNE82M/GJueFoxb6i35T/8ortkOzKwc2
	2MzbkLot2LVcyKXwmu82BClZY3tXYq3nCcBpuPeJrp2jVcZj+9NP7emDL6U4bLDR
	9OP9S8U6n5q1LKLg0gr+SAW9S2pS/moVAyLOjUgejY+9AIJTqlFHJ5VRVvtr/ruT
	6i8lsXYqW0aViTxO7bgiWjnWUxzg5VfVjCtNFmIuM1cgcZvTJM4NvYXROfm1Uae1
	Qkif61/Mw/JWT1EuICIZaymANeO8stwyDft181UkM1tyaHU+xcDtIRugAkriZf0q
	ln7L5ElkuV/jOIL9uXzSQ==
X-ME-Sender: <xms:KvfHaBhUdJOMCALlbfqGC5TkIqvCIcZ3WDUDGqCBKuPsTkIl_pTnKQ>
    <xme:KvfHaGrOGANi5gsKhxfTxupWmb9Rk1o0r4MN9_NqFHNDBG9rMzeXCqrBhWFbtKoFR
    rJyiBfMshpss29vDg>
X-ME-Received: <xmr:KvfHaMPuTCeyPq9o-O58E3HnYaEZPjQll0ofHkBqd6KyufdPkvnxRviRXPfn737wuMSUoQjDDidNU4GJSI87f6PMejP1PWwCi0kYk3qL_IG8Ew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefjeehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepudeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtth
    hopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgv
    nhesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpd
    hrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgt
    phhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshgrmhes
    ghgvnhhtohhordhorhhgpdhrtghpthhtoheptgholhhlihhnrdhfuhhnkhdusehgmhgrih
    hlrdgtohhm
X-ME-Proxy: <xmx:KvfHaK3lsyrI_J-L3YoJTnVqWbpMzknO-Q_l7kmMMj9U0s0f1Am9TQ>
    <xmx:KvfHaCqYIUS817Ru0QqL2Q8MbSiEafodypB08aqJNuFSBMGKnfMNGA>
    <xmx:KvfHaMcNDfjEsgc6Ufe6B0tUP83pAtdev1C5poyK9_IU84fOHqOw-Q>
    <xmx:KvfHaMvl6Xx-TCwa0Vzo8P2DUCYwdZjAVLf0QPZywQu3iV4ONXalag>
    <xmx:KvfHaDR50qHmSespwwF1sUpAD1_-31ZCkQiZ0g6pQ0-zx7DSWUHtfTnS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 07:23:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c9535407 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 15 Sep 2025 11:23:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 15 Sep 2025 13:22:52 +0200
Subject: [PATCH v5 5/9] varint: use explicit width for integers
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-b4-pks-rust-breaking-change-v5-5-dc3a32fbb216@pks.im>
References: <20250915-b4-pks-rust-breaking-change-v5-0-dc3a32fbb216@pks.im>
In-Reply-To: <20250915-b4-pks-rust-breaking-change-v5-0-dc3a32fbb216@pks.im>
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
2.51.0.450.g87641ccf93.dirty


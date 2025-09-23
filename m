Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EB4320A3F
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 09:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758620749; cv=none; b=OTSgWUiErU9xONnMcH0DzulAPIVqQZ2oYVJ2Q7/CIC4/oCurcHhiMGkSvWPnsCTsceBkfH+uPwMpnHqwuBeScJcRyXCRPJbUD5ZQF8CT1Ns0pFNwZIUY+p4vNbfj+oFa8yiZzDgi5ml/u+xs+T9jCv0lz42kumHvanXI2fhs+Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758620749; c=relaxed/simple;
	bh=dr9Bze8qqQpJpQfOMDrrNCDRy/xNpcn3cZI9wCmzfHs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D2QXWxC1nhxrn0tcGUtQR2ZWj6ay/aHeagsTxON/BiXBLTt7OqPFmCK61GQdJUcA0MnU8U4Z2yYwgmRt2FK6q4aqCHdkj2IKaRgq1pfm5FZAWM0TbBG7bSJzFKQ5KHDEt0U8jpN44VwIj4xGEnwf5EdmYucvEqDeJCQBCkL40Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=c9EfOIvt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PSDIXIny; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="c9EfOIvt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PSDIXIny"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 36DAB1D00244;
	Tue, 23 Sep 2025 05:45:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 23 Sep 2025 05:45:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758620746;
	 x=1758707146; bh=2EUZSrw5AwCUqSZzyEptqCF9cYQXQWwzSW0o5FaocLE=; b=
	c9EfOIvteoM7QpMAxBMSq73ocsqiUvAF70gROcRu7CHGjUoM6J9jj7Aapw9RgXY4
	jETJS+jfLcRMfu1s7VoURmMEdHnrkHhC6aa9pWSmPpfTgXPzid+E/Wx7WsJ5PG6C
	ur7LgQCJq4vgpXUvdWH7k3Jex4K9NBH2z/S5CRsz61ucJIhcqWvWpFpZ+x9IQ+G+
	F3oQsSWs0914sZsZGTYnijQ6Y67q+HOHdkWm/gki4D8gwdgNg/Pzck5TINtwLgGZ
	EQG1M7H1/3tEIaR5K9ywf0v2hGUa10er9lXmQrKovmZkZDep6O3cquumBXBoe5tK
	fqpeWNgLFhMrYUKfgvXCgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758620746; x=
	1758707146; bh=2EUZSrw5AwCUqSZzyEptqCF9cYQXQWwzSW0o5FaocLE=; b=P
	SDIXIny8YeWWKS4l54irx1svd8UG8zfqMqiQkg0m8vjo4Sr1yd7hn8AL/gSo5Zxc
	yiXpoTjbv5AI2GXqaQjTLkWoZq2FcXFjtwB2uZjwsCj0tz3+PtiCjkotkXVVC7/f
	GWejcN7UHGQsbmiUyeCTIOXTs4kPbqvkTq97Y+ZRPc0JYVL8V8PrTA23R5VKZYc5
	fU0TInRWzyWpudOv8mflkbNtOL4LvaseOLwx6M2FbTucUG05jjpSCnzjOqiyzNi6
	2Bn0qDt237SU815brASGZRwGwRtWRtAFup8o2p9DfRGw8lgsEJySxsHLFqjanPvE
	sujhCqtFBndE1ty0kptyA==
X-ME-Sender: <xms:SWzSaI73p3BPdQIwEk7h_7rneMs_EJJr9wKdffjoKIvg-zHnaIfqjA>
    <xme:SWzSaKhruZvyiOj3HVvMd2Ov8482UnHA9IzqDXwUjLyoOGDu19H2V3rs_u7wrzmHp
    2RhzBCyrbSMFYFLORgDSN3UFOSyD_xVA3GTQRrPQ9OUPIkjPXKI>
X-ME-Received: <xmr:SWzSaCmWHSoscvbDQ7srsGe7W63p21DEld87-dk0_uzM28lhUpmzxLxtKalbWyC2m0836g7mPUTgDMqF-C6pDMDA_tYj2rf2ZuG7fToJdFmU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeitdegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepudeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtth
    hopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopegtsgesvdeh
    iegsihhtrdhorhhgpdhrtghpthhtohepshgrmhesghgvnhhtohhordhorhhgpdhrtghpth
    htoheptgholhhlihhnrdhfuhhnkhdusehgmhgrihhlrdgtohhmpdhrtghpthhtoheptgho
    nhhtrggttheshhgrtghkthhivhhishdrmhgvpdhrtghpthhtohepphhhihhllhhiphdrfi
    hoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhu
    shhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehmvgesthhtrgihlhhorh
    hrrdgtohhm
X-ME-Proxy: <xmx:SWzSaBvQ-Jn9uBUwNNiKDR_WsZsKSinySms4DNY0JSbb5u2CwVduVw>
    <xmx:SWzSaAA9gBBkbKI7ad4JMdaAwbnueE9BECV9XYu-jCia7JYkhzmBwA>
    <xmx:SWzSaOWAuY25vdnpqYl6BpPu0mkjq-XELgGSMEE8S15xO_AYhyPgpA>
    <xmx:SWzSaJHda0oiliJBF45Rm76vho0RD5_DTmxoTSU2Upt7eTBpNbSL0Q>
    <xmx:SmzSaK3n8N438dXvDKslCc3bHOdr7nyvNS-g1qOdcPRVhEUdMitmOvTF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 05:45:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a24352fd (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 23 Sep 2025 09:45:41 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 23 Sep 2025 11:45:24 +0200
Subject: [PATCH v6 5/9] varint: use explicit width for integers
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-b4-pks-rust-breaking-change-v6-5-59076fee486a@pks.im>
References: <20250923-b4-pks-rust-breaking-change-v6-0-59076fee486a@pks.im>
In-Reply-To: <20250923-b4-pks-rust-breaking-change-v6-0-59076fee486a@pks.im>
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
2.51.0.536.g15c5d4f767.dirty


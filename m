Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866212D592C
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 07:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759390253; cv=none; b=DAy+hJQI8juJzKA0wdxtTGEV6Rxc7DlH8xpMtle96i431q3udIVcVkKN+0m4Od4fAIceDFU4cKwki11NKEhhVDmotbZAXxywYg2bzweRppPJji0Sp8gTF+v6K2Np1rfkbXzTyo2ZtBWYLacmLYxnCa5IdL6/wwv/faj7q1aftK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759390253; c=relaxed/simple;
	bh=hWUfhYfjbq96WzdQUEJowE+DdyNF8mGZR/1jdblF1Rk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EsOh+piO/zwGQPOUVHRvm02180YXgJF8KsWJmK7+psl4MPXA0K90PCCAWlunuXcARq9TYQCJHc/E0rCH2ZTI7dTQi4qU3yE1B0A/0P7lVV0ioKLAHBFmCehjfv7LI9NFBiqr/Oeb2TvP+Md1IqOZM5VZOzHOwUkDCKVyx9yx9Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CvuzMyvq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=noB9SyYr; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CvuzMyvq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="noB9SyYr"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 78D9C1D0012B;
	Thu,  2 Oct 2025 03:30:50 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 02 Oct 2025 03:30:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759390250;
	 x=1759476650; bh=F1TPVXKFo7ADFWHP8zmKe+cjis3Qy0rOk1kTEboQft4=; b=
	CvuzMyvqyUQ20myLXrRfd243ntVRNR63Lkc8G0/RpdMErF6lX/lO4DL61Qx0mhWF
	ARinuA3gx9idvxOHJAiA5laD4uo2/oF9GBcWP8/+uyUYgk/X7TRX4PROyxYL6nf4
	yDd1E8008BFGUpWHGaB6DQ0/2pAL3uW30osm2ZpmDUW9iFxM7ND0jDeTFWQpLl18
	o6E2ATXfGJ8nsCBmjqAlHRP5gBfJ5L5QhHxrT7mwuJYsIpZfJ0M1Tpm5IY4EL7+z
	G5FVwGpn1hiPHy+QsAkJV8TE/TywXFMVv9vufpanr4aDyLufhqO7BN5oDantF7Js
	J8cYQAmSIhP0yXEwvfg0dA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759390250; x=
	1759476650; bh=F1TPVXKFo7ADFWHP8zmKe+cjis3Qy0rOk1kTEboQft4=; b=n
	oB9SyYrqUZHTAqEjDH6nk8tHrpPVkACsG8ITyjIwHHDhCm6xi8oWiScTtcrqTZZo
	dztKrUaVA0zLJKN7thv+tKFIpnwHLYTUl/8YA93jAeSa2dmGtoUsKwNj4RBlOYzA
	RJR7oKp+MzOpWr+Ihnbvkt1+p2TYJrPwCca/oB/rQ0zIqJ8srjVC6hxruVnH5O7y
	RdqmyvvfI+i0Z81M9RhKXOAn42p/oK+/Arunpa3zNaoeuDG9SdlmlPHVoheD7CKq
	LheSCZBMOPkOVsiCyDPQgpxXxoCc9+CRK/XvR9FVs6+NadjzesBdBYu7HfMlIw7Y
	59AT4jFoxRcIWuGWxTU1Q==
X-ME-Sender: <xms:KSreaEoqurU4Tnj9seg0-BYElxl3c0AUGrBtIPPv27cEIJMEetBgTw>
    <xme:KSreaLHwJP7OrXAoGnK72YDOwtY9KJye1e9fsQo67nH29SlWvT_z7FTtOGv2rVgri
    c1mhMdJEdeH8r5LOTV6ccHrv6-SfQlRAbL8f18plagDk-Yd5hCUKA>
X-ME-Received: <xmr:KSreaI_xCCiI04e7T4os-agZnEVN1F47zvy1A3Z4VlUUL_-eOt-f6XPjHA38V4POys0A7umUsgMo6e7dgfGpPiG0wGfTsJCIjPnbQHeDXw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekheegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepudeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehsrghmsehgvghnthhoohdrohhrghdprhgtphhtthhopehpihgvrhhrvgdqvghmmh
    grnhhuvghlrdhprghtrhihsegvmhgsvggtohhsmhdrtghomhdprhgtphhtthhopehmvges
    thhtrgihlhhorhhrrdgtohhmpdhrtghpthhtoheptgholhhlihhnrdhfuhhnkhdusehgmh
    grihhlrdgtohhmpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhg
    pdhrtghpthhtohepvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtghomhdprhgtph
    htthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopegtsgesvdehiegs
    ihhtrdhorhhgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:KSreaIQjOx15r2w4WVv2KxsRWHv21MgMBWAtspksDny66dHFkbi6Ug>
    <xmx:KSreaNrBceQP2WE_-vAitb1pzQgU5UnW9bY8MPpRO0mxgBf0Gu9Z6Q>
    <xmx:KSreaFPFRO2vpiJBeHW4ZaGLqY23Db3vKskr1aw1aBmJnFTEeR-0Ig>
    <xmx:KSreaDweZsYmRMGz5BB2R0D8ZKcRN6rdiVSOP-QY254yn7MVvw1Afg>
    <xmx:KireaGgJ9868S_oK7REXcKli8LBCPZ8oiV534iefyASkYUDtT246yZO6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Oct 2025 03:30:47 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1eb0c272 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 2 Oct 2025 07:30:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 02 Oct 2025 09:29:30 +0200
Subject: [PATCH v8 5/9] varint: use explicit width for integers
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251002-b4-pks-rust-breaking-change-v8-5-3a89fd5b1ce7@pks.im>
References: <20251002-b4-pks-rust-breaking-change-v8-0-3a89fd5b1ce7@pks.im>
In-Reply-To: <20251002-b4-pks-rust-breaking-change-v8-0-3a89fd5b1ce7@pks.im>
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

The varint subsystem currently uses implicit widths for integers. On the
one hand we use `uintmax_t` for the actual value. On the other hand, we
use `int` for the length of the encoded varint.

Both of these have known maximum values, as we only support at most 16
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
2.51.0.700.g236ee7b076.dirty


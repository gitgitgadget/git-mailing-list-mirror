Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A5F38B140
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 06:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773903214; cv=none; b=lMhskUUqKX/eNIwKvak0wCK5u3aH6tfxlT4+hwxLTlvULu2WFLozF8RvrRoYcrncRpU339+pGWriU2KwP/SptclTlBo8ovsXB7sSrKHJpn15S8xInKwwIhWVHwP4Xl9nVZV0lTLAmpQONS1tfDECJxIj9yE1ugYh/Dnv0KuQXgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773903214; c=relaxed/simple;
	bh=rHpbvQ+OiFhiv++FXrDZMtvQO0QNnsif00k4OJBKWx0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lBVCt0oUdbWlRdH2gmE5qc6NGlcf9wiUGZbGorxpzSbDXSLOz5TX23plGhcDItwACM22bOfIkZeabECGG/9WjtJFK6AQU1wovrzLhlnzreJnkUd/yUs4PQrOv75IlfrOJL06nmpSs5qm2KaO/57WW9RNkervsJO+Yp9/IfEmUm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QWli6dPz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vYeVUg6S; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QWli6dPz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vYeVUg6S"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4E4341400167
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 02:53:32 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 19 Mar 2026 02:53:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773903212;
	 x=1773989612; bh=Q/iNgF3mbahp8w07rseD2TUd6ql7S09h8dq481zOz7g=; b=
	QWli6dPzyToGN1OSkyFkq6pbivkqavZvftDWsyScZolugXFBEwMcaiu/enAGEvJQ
	/2B5m2KP4AqXSb04/RZW5siPUD52QJiEABoMACtdGu7HxA1kXzOkcwkDVx1yGyXn
	dRkDCpY66PS45iyNztNa3fsGPDsLoC3j6TzY7zunkeI5Lh9QF1bQL8kLYy7I5kIi
	HUAFjiWuiNcVcoxzrYxy67celoNDlyTQu40882W3W6yxUGpiOaBOWMXXihrXDh+h
	GwskBhc6FpldO6TsaotJJH6dHYlf/u2FdQ7mY+zL668yf0i9T6nAxGrd/GT1C2vC
	EhCAm7xHgRXq72E6LHSucg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773903212; x=
	1773989612; bh=Q/iNgF3mbahp8w07rseD2TUd6ql7S09h8dq481zOz7g=; b=v
	YeVUg6SgZC5q+NTHK8LNErzmsb2QlbP4nxMuv8C2b9kI9pphxfTBw6/W9Cmhs6Vm
	KPYfK0kezMgyP9lXH70sp1xyvlgN0GXIz7eXaEosZe2WuEGXz1qsq2Sfy9WTfj1r
	/6XB3uoKUsEcu80sWWcG0pWxmhqR1JLjlKQgh9fyHGEpwvDfKer8+J2IAwP+G2g+
	J2WBEmQvulLFtI1WCCWjcwnM/6wAkxoez4nu3zbt1RJ+5teukYyWAsajYicpDZVd
	qPDV6wIjl6iZDFeGnsHJZ9wtPH50dhetgw8GN7/47Aw2MjkNOkqZg1TSPEpi/ZeS
	85p19MOwzc1onjhvHMOWQ==
X-ME-Sender: <xms:bJ27aXjurTMj9A8MyTesmQQyGObZUVNnRiz7jeDMSNHXdKwwiYTmqw>
    <xme:bJ27aa9tjtLgQERVFzSQWCMjhTDfdZwOsxvDOjPcgzwkT8i3BIs43tZfT7SH-WIaI
    rvzsaRuEukHFezZ02pai5B69DWvayFM7_9dg0_vYNqGDZIiAl2ACA>
X-ME-Received: <xmr:bJ27actYpvg4lK5eui0XqUfK4l0bo3Sb6ZQVYgmCDBwoLyb41wHWsTxv2hw-98_J7YP2Upxl5DAJtSsVr_Aqd3EgpguUOnnmi3SeqXteLgcP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdeifeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepfeenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:bJ27aZaxM6DpVBD-xh-4NCyyOl0K8fBK4xo8qYvGh_gD5YmLJAvBKQ>
    <xmx:bJ27aUpW_BIBLIn5tHHYSJmMDSVfWnGNc8puEUIRxPl3eWfjXCbCcw>
    <xmx:bJ27aW8m2kR1cPyFm8xKkJYhXYiKQWfnOL1Sh8KAYrwnuD7rmOmRzA>
    <xmx:bJ27ab8gvQ7gsS1Nag5S28UuT4pUNHC05t6D8Tz6_vRQiOLGQffJdA>
    <xmx:bJ27aYiSby4YzwC9P0iXkdAzqcb0469ySc1EgDT6Lyw1KCixLq-B6XyR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 19 Mar 2026 02:53:31 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 96eb1898 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 19 Mar 2026 06:53:31 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 19 Mar 2026 07:53:09 +0100
Subject: [PATCH 11/14] object-name: simplify computing common prefixes
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-b4-pks-odb-source-abbrev-v1-11-5ddebad292b0@pks.im>
References: <20260319-b4-pks-odb-source-abbrev-v1-0-5ddebad292b0@pks.im>
In-Reply-To: <20260319-b4-pks-odb-source-abbrev-v1-0-5ddebad292b0@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

The function `extend_abbrev_len()` computes the length of common hex
characters between two object IDs. This is done by:

  - Making the caller provide the `hex` string for the needle object ID.

  - Comparing every hex position of the haystack object ID with
    `get_hex_char_from_oid()`.

Turning the binary representation into hex first is roundabout though:
we can simply compare the binary representation and give some special
attention to the final nibble.

Introduce a new function `oid_common_prefix_hexlen()` that does exactly
this and refactor the code to use the new function. This allows us to
drop the `struct min_abbrev_data::hex` field. Furthermore, this function
will be used in by some other callsites in subsequent commits.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 hash.c        | 18 ++++++++++++++++++
 hash.h        |  3 +++
 object-name.c | 23 +++--------------------
 3 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/hash.c b/hash.c
index 553f2008ea..e925b9754e 100644
--- a/hash.c
+++ b/hash.c
@@ -317,3 +317,21 @@ const struct git_hash_algo *unsafe_hash_algo(const struct git_hash_algo *algop)
 	/* Otherwise use the default one. */
 	return algop;
 }
+
+unsigned oid_common_prefix_hexlen(const struct object_id *a,
+				  const struct object_id *b)
+{
+	unsigned rawsz = hash_algos[a->algo].rawsz;
+
+	for (unsigned i = 0; i < rawsz; i++) {
+		if (a->hash[i] == b->hash[i])
+			continue;
+
+		if ((a->hash[i] ^ b->hash[i]) & 0xf0)
+			return i * 2;
+		else
+			return i * 2 + 1;
+	}
+
+	return rawsz * 2;
+}
diff --git a/hash.h b/hash.h
index d51efce1d3..c082a53c9a 100644
--- a/hash.h
+++ b/hash.h
@@ -396,6 +396,9 @@ static inline int oideq(const struct object_id *oid1, const struct object_id *oi
 	return !memcmp(oid1->hash, oid2->hash, GIT_MAX_RAWSZ);
 }
 
+unsigned oid_common_prefix_hexlen(const struct object_id *a,
+				  const struct object_id *b);
+
 static inline void oidcpy(struct object_id *dst, const struct object_id *src)
 {
 	memcpy(dst->hash, src->hash, GIT_MAX_RAWSZ);
diff --git a/object-name.c b/object-name.c
index d82fb49f39..32e9c23e40 100644
--- a/object-name.c
+++ b/object-name.c
@@ -585,32 +585,16 @@ static unsigned msb(unsigned long val)
 struct min_abbrev_data {
 	unsigned int init_len;
 	unsigned int cur_len;
-	char *hex;
 	struct repository *repo;
 	const struct object_id *oid;
 };
 
-static inline char get_hex_char_from_oid(const struct object_id *oid,
-					 unsigned int pos)
-{
-	static const char hex[] = "0123456789abcdef";
-
-	if ((pos & 1) == 0)
-		return hex[oid->hash[pos >> 1] >> 4];
-	else
-		return hex[oid->hash[pos >> 1] & 0xf];
-}
-
 static int extend_abbrev_len(const struct object_id *oid,
 			     struct min_abbrev_data *mad)
 {
-	unsigned int i = mad->init_len;
-	while (mad->hex[i] && mad->hex[i] == get_hex_char_from_oid(oid, i))
-		i++;
-
-	if (mad->hex[i] && i >= mad->cur_len)
-		mad->cur_len = i + 1;
-
+	unsigned len = oid_common_prefix_hexlen(oid, mad->oid);
+	if (len != hash_algos[oid->algo].hexsz && len >= mad->cur_len)
+		mad->cur_len = len + 1;
 	return 0;
 }
 
@@ -785,7 +769,6 @@ int repo_find_unique_abbrev_r(struct repository *r, char *hex,
 	mad.repo = r;
 	mad.init_len = len;
 	mad.cur_len = len;
-	mad.hex = hex;
 	mad.oid = oid;
 
 	find_abbrev_len_packed(&mad);

-- 
2.53.0.1055.ga2ffed1127.dirty


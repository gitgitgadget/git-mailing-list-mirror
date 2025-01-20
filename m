Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E01200CD
	for <git@vger.kernel.org>; Mon, 20 Jan 2025 16:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737389852; cv=none; b=TnxntNQYJ27gKtY3/x/NmKORYZ8MW5v3h3LH7dpPkLVnJjNTXNkOVN+7cp/j8DIA5E4HbcxRugZIKZFZ4ppSuGa6FH7tvnQtEOwdYK1w1srWbIBL0N2KpUWiZljirN2wtv9GFu3MwyY5nOtxBqqgNy+hbgcJSy90BnLWnm2x2BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737389852; c=relaxed/simple;
	bh=W8vIF2kBiRTp8lbeOF202sS3thSeJ0hGlF/etJkVbSA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O6sp7dkE/rmtj8BcI0q9G8slexey2or+zFX2cOWd4rbAdwqLX19SFqkEvtsBN8RpUfHThXpAn3go/w7A9EIE6jCAXVh7kNCWQEyDtr1jhotXiEztdfMUzbzaxgfny9so1ABjlNl47xd/rYcfFuzOn2dkeG4AZPd/90RzG7XYewM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nw+ttUtn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bJn4wkVm; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nw+ttUtn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bJn4wkVm"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 59DA113808A9;
	Mon, 20 Jan 2025 11:17:29 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 20 Jan 2025 11:17:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1737389849;
	 x=1737476249; bh=jcLDXKPm2GlABr8rWAv2E1KP+pewv/sVpkIhMdiKlkQ=; b=
	nw+ttUtn9JMHJ0FWF3oyaLkkVXt8b9o+osrJVnW2h5AgtoMkAUyLQwVzpjbNphBV
	Ai7f94qC/GwFfZ5yc8ytxcjvj6lYtF2ZZu/8aGnGWkLbG+pb00Dh+6rVj+/UxPf1
	vE1FndOWMlyXUDwuFT3biAmQaol8YTs4LPplmaY6fatVfon+mJ2hDsqvA7aBtTBP
	/l3LjY8sGv3XV3ZWusEwjhOHDeRSJ6vO6ueRO38ygejuzSsPNyxxtinGR6Rst7sJ
	IcLLYbKIo/by+3H5sQq+J1PkoRPmMWiYcvjcos3URWp2qxQeT+kR9CHhgpmYqu3O
	N+BMyD/jbO0GW3zdiu09EQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1737389849; x=
	1737476249; bh=jcLDXKPm2GlABr8rWAv2E1KP+pewv/sVpkIhMdiKlkQ=; b=b
	Jn4wkVmc62c3QLamX9AWIZF1Q3HkYAIDpUWgP02vOm2otjg9mKAfATdt1owV6YPS
	gLQK0B7gWvrPXuVPg56//XMe6TnQorxONfXj6oqYFPBgEYwValaLDGJwdEewsQHJ
	XF9T7XHzaJFXilu8Zo0KzkCd9Z2JAM8Q3EErgKF9v+0ZJGdGTQYiH8761MK089DS
	KmXvDf+5IfHtxdgo7FSrgOkLPQthhDt03S+zGq5FPEHdGfR3/fQc1ON99OuYDYvh
	OOiIUyTvo17ygT38ONu8C4I1P/edLxgpWhwpJH/K0vJF6bFN6MH99suNU4dQtxFi
	yjryvhxV/o3/K42Y+nLog==
X-ME-Sender: <xms:GXeOZ4zRwmaBry1s7N9bxOA_L2PDVL-Ll1i2tk5qvCYGoETyCkx5_Q>
    <xme:GXeOZ8QcPaarn51mWiZBaJ2wgoYMADYCs3eI-IcUz1Mum4vHSRt41eXZOFB2hJ6vg
    8jzXIFLY-A5_PKweQ>
X-ME-Received: <xmr:GXeOZ6Wv7SPmw8HAfWe3DRKm9c8ZSDzaoCghMeQMIff72ax_j9IAN0W42iepc6cG0tm2Drj78ocRLiDjDL3kpBK11-MLShKlXWfc8C_BmO2B0Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiledgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:GXeOZ2hzAR8pfC_5vURJjwzfKbDR5mZWKemLEVdztWAEDG4os3BLug>
    <xmx:GXeOZ6BXcVEuuV0BjnNSoaK8HtQu1cRzirKOrOcc-Wdr3VDgp3snMw>
    <xmx:GXeOZ3KrYoo4j_2PN-gE4kdkzji9nBc83bBS1bfIJxiXs6ZX3DbDqQ>
    <xmx:GXeOZxD9wO0WEpjEr5a1zXYvPu07IWZEdDNFOE7gLVnO5nZM2opeYg>
    <xmx:GXeOZ9O486tWN04icaZIZrvBxs5RZbwwGGYJh0REi5Oneie50q6ogHpU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Jan 2025 11:17:28 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id dbe7df88 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 20 Jan 2025 16:17:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 20 Jan 2025 17:17:21 +0100
Subject: [PATCH v2 03/10] reftable/record: handle overflows when decoding
 varints
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250120-b4-pks-reftable-sign-compare-v2-3-b4566d02e4a5@pks.im>
References: <20250120-b4-pks-reftable-sign-compare-v2-0-b4566d02e4a5@pks.im>
In-Reply-To: <20250120-b4-pks-reftable-sign-compare-v2-0-b4566d02e4a5@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2

The logic to decode varints isn't able to detect integer overflows: as
long as the buffer still has more data available, and as long as the
current byte has its 0x80 bit set, we'll continue to add up these values
to the result. This will eventually cause the `uint64_t` to overflow, at
which point we'll return an invalid result.

Refactor the function so that it is able to detect such overflows. The
implementation is basically copied from Git's own `decode_varint()`,
which already knows to handle overflows. The only adjustment is that we
also take into account the string view's length in order to not overrun
it. The reftable documentation explicitly notes that those two encoding
schemas are supposed to be the same:

    Varint encoding
    ^^^^^^^^^^^^^^^

    Varint encoding is identical to the ofs-delta encoding method used
    within pack files.

    Decoder works as follows:

    ....
    val = buf[ptr] & 0x7f
    while (buf[ptr] & 0x80) {
      ptr++
      val = ((val + 1) << 7) | (buf[ptr] & 0x7f)
    }
    ....

While at it, refactor `put_var_int()` in the same way by copying over
the implementation of `encode_varint()`. While `put_var_int()` doesn't
have an issue with overflows, it generates warnings with -Wsign-compare.
The implementation of `encode_varint()` doesn't, is battle-tested and at
the same time way simpler than what we currently have.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/record.c                | 62 +++++++++++++++++++++-------------------
 reftable/record.h                |  6 ++--
 t/unit-tests/t-reftable-record.c | 17 +++++++++++
 3 files changed, 53 insertions(+), 32 deletions(-)

diff --git a/reftable/record.c b/reftable/record.c
index 04429d23fe..a55ce76aeb 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -21,47 +21,49 @@ static void *reftable_record_data(struct reftable_record *rec);
 
 int get_var_int(uint64_t *dest, struct string_view *in)
 {
-	int ptr = 0;
+	const unsigned char *buf = in->buf;
+	unsigned char c;
 	uint64_t val;
 
-	if (in->len == 0)
+	if (!in->len)
 		return -1;
-	val = in->buf[ptr] & 0x7f;
-
-	while (in->buf[ptr] & 0x80) {
-		ptr++;
-		if (ptr > in->len) {
+	c = *buf++;
+	val = c & 0x7f;
+
+	while (c & 0x80) {
+		/*
+		 * We use a micro-optimization here: whenever we see that the
+		 * 0x80 bit is set, we know that the remainder of the value
+		 * cannot be 0. The zero-values thus doesn't need to be encoded
+		 * at all, which is why we subtract 1 when encoding and add 1
+		 * when decoding.
+		 *
+		 * This allows us to save a byte in some edge cases.
+		 */
+		val += 1;
+		if (!val || (val & (uint64_t)(~0ULL << (64 - 7))))
+			return -1; /* overflow */
+		if (buf >= in->buf + in->len)
 			return -1;
-		}
-		val = (val + 1) << 7 | (uint64_t)(in->buf[ptr] & 0x7f);
+		c = *buf++;
+		val = (val << 7) + (c & 0x7f);
 	}
 
 	*dest = val;
-	return ptr + 1;
+	return buf - in->buf;
 }
 
-int put_var_int(struct string_view *dest, uint64_t val)
+int put_var_int(struct string_view *dest, uint64_t value)
 {
-	uint8_t buf[10] = { 0 };
-	int i = 9;
-	int n = 0;
-	buf[i] = (uint8_t)(val & 0x7f);
-	i--;
-	while (1) {
-		val >>= 7;
-		if (!val) {
-			break;
-		}
-		val--;
-		buf[i] = 0x80 | (uint8_t)(val & 0x7f);
-		i--;
-	}
-
-	n = sizeof(buf) - i - 1;
-	if (dest->len < n)
+	unsigned char varint[10];
+	unsigned pos = sizeof(varint) - 1;
+	varint[pos] = value & 0x7f;
+	while (value >>= 7)
+		varint[--pos] = 0x80 | (--value & 0x7f);
+	if (dest->len < sizeof(varint) - pos)
 		return -1;
-	memcpy(dest->buf, &buf[i + 1], n);
-	return n;
+	memcpy(dest->buf, varint + pos, sizeof(varint) - pos);
+	return sizeof(varint) - pos;
 }
 
 int reftable_is_block_type(uint8_t typ)
diff --git a/reftable/record.h b/reftable/record.h
index a24cb23bd4..0df950f401 100644
--- a/reftable/record.h
+++ b/reftable/record.h
@@ -32,8 +32,10 @@ static inline void string_view_consume(struct string_view *s, int n)
 	s->len -= n;
 }
 
-/* utilities for de/encoding varints */
-
+/*
+ * Decode and encode a varint. Returns the number of bytes read/written, or a
+ * negative value in case encoding/decoding the varint has failed.
+ */
 int get_var_int(uint64_t *dest, struct string_view *in);
 int put_var_int(struct string_view *dest, uint64_t val);
 
diff --git a/t/unit-tests/t-reftable-record.c b/t/unit-tests/t-reftable-record.c
index 42bc64cec8..6d912b9c8f 100644
--- a/t/unit-tests/t-reftable-record.c
+++ b/t/unit-tests/t-reftable-record.c
@@ -58,6 +58,22 @@ static void t_varint_roundtrip(void)
 	}
 }
 
+static void t_varint_overflow(void)
+{
+	unsigned char buf[] = {
+		0xFF, 0xFF, 0xFF, 0xFF,
+		0xFF, 0xFF, 0xFF, 0xFF,
+		0xFF, 0x00,
+	};
+	struct string_view view = {
+		.buf = buf,
+		.len = sizeof(buf),
+	};
+	uint64_t value;
+	int err = get_var_int(&value, &view);
+	check_int(err, ==, -1);
+}
+
 static void set_hash(uint8_t *h, int j)
 {
 	for (int i = 0; i < hash_size(REFTABLE_HASH_SHA1); i++)
@@ -544,6 +560,7 @@ int cmd_main(int argc UNUSED, const char *argv[] UNUSED)
 	TEST(t_reftable_log_record_roundtrip(), "record operations work on log record");
 	TEST(t_reftable_ref_record_roundtrip(), "record operations work on ref record");
 	TEST(t_varint_roundtrip(), "put_var_int and get_var_int work");
+	TEST(t_varint_overflow(), "get_var_int notices an integer overflow");
 	TEST(t_key_roundtrip(), "reftable_encode_key and reftable_decode_key work");
 	TEST(t_reftable_obj_record_roundtrip(), "record operations work on obj record");
 	TEST(t_reftable_index_record_roundtrip(), "record operations work on index record");

-- 
2.48.0.257.gd3603152ad.dirty


Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437591DC046
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 10:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737022126; cv=none; b=GTaTFdCAezGOR/wT1GgMqlEXkE3AVcKDgbn/B0gyLXhmTzpPS/Do0xMWAQjRRwG6g+2okFao39Nep00Rg/2HXw+PLp+G0QStJoUG+e4Wql03W6M4VupM68HYfB02xKtTpqt/UX3nzyGa/DucZwK8LM5GSgKC6BFfAy0aLWQ5uGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737022126; c=relaxed/simple;
	bh=nkkbEQVV34P+UKbbxxFFPeQEYG8s9cnvK3Kw8iqQ3zM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pYecd4RS06vzmGrgdw7bqDXjw/0cwIaVrxgs9f3PU2d76Ckuj34aLjn5z3V7kL55Xfj5f5yAuPfe5ZwVpVZu1tIMPBs19VxHlO9YQBPBlhOXqovJlWNxpYGr6P2sCziRk4O/uhDl9ByKQkgwPUhygg7j7/iEXR+InG5fmQeU7ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KjZWjwOz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d2ceuueW; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KjZWjwOz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d2ceuueW"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 55F6D254015B
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 05:08:44 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 16 Jan 2025 05:08:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1737022124;
	 x=1737108524; bh=IYTf2r9iJGwe8HUcYGASPu6OhyBuakwqFeAjFLfy1I4=; b=
	KjZWjwOzkJHg5hCB8BrLOermLBlM8B2aLYVKbARbSUvX92TfSTvXQiH3OeDxAFd3
	Bot7zjWJu5NNzyufkrzpvbP5Y9Y7UFlY+eo5ZO1fdzDt6vDWRzVcybyww/agiDj9
	lDW+AZ5htOaLWYJaSCo5X3X2OjRH1vgTGwuXb1rurlf+HXvnLNdVIM1lXi/sIb3J
	Gi3F6BizrMy9scVWO6vmXsNtKdBfugLy2kVeUocBR9iT+ti7KIyuIVOAJGbtwmyj
	fqI6EbDtkXKROvl8qygH0FNE6qe/q1gnS2nNLzyDhmyqhBmDJflwJ3BV8OAoeM8A
	x7VbNMrH+UD0KxsNxaFq7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1737022124; x=
	1737108524; bh=IYTf2r9iJGwe8HUcYGASPu6OhyBuakwqFeAjFLfy1I4=; b=d
	2ceuueWf/zwQubt3ouSx0ZGkUZ+8dfUNkybovsgMD4zemC6YonwSV3/XdX5Z3RvB
	yWVjdcmgGEfXeaB2CP3cDi56r/qeTnxsqsAjAi0a4Y+Oy/jJlJ60BsZgbdUJvsHb
	1HDZLrkZKX1hF+bQ96ehXvD3nfQF5J2dn1TJLEriowm+vmYsKuus0TkBCCgyfOok
	BPlrgYlO/GM4N6VcZQvFsdW7KrInQTRC0PW1yO15fuKQ80y8i/C07jcda85sskCt
	UJwh3pkfKKsfpQc/jQUXDlG6FWSWOvOYDfxw75PZ//LvFzcYOr04fOmhyATGtd8D
	M/0eRv6Ou8FA2RkRBzFsA==
X-ME-Sender: <xms:rNqIZ_6xU8mTsDrUYZ8oWIPW_FViJXXIl6XTNxCrTTPJKfcYKKKuKA>
    <xme:rNqIZ04Zq4wwdMdAJ9r04AUl7KNrVu0b3xzrom1q_vlbSPQnxKneXaVTtGqgzflFL
    KaMiB1D9wTzKX9vVQ>
X-ME-Received: <xmr:rNqIZ2cy3oyQd2XL6opYQbM46SW52b6RWcPKg_2M6Xc1LzK0dnTCdHSA5wG6sv0CGkD4uFo01j0xACziNR3boCjHnufwFDnfwy3rTprCfRQEGRJCBQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:rNqIZwJsu6mLBExvA1k_g5p9FHsqYOoJ8TFoCkGQijQ1PLCwWgF3bA>
    <xmx:rNqIZzKN8jFUTme1rpld84HwnoPtLuwiOLyae4iSj4Tl0pHbMbnjag>
    <xmx:rNqIZ5ymHzauDhMM8I-BL5Q4SjB2fuZdQr9iS2GZvr-_L5T1ryUPoA>
    <xmx:rNqIZ_Kpl80thoE0SgM4pIYU-WHRpBLPVA7D0pWgg-Ic-NmUIyoPig>
    <xmx:rNqIZ5g13z7RVJTX2-nVQIO5s8FA5kGxzLjymttanoFbV5vj8VcFic7f>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 16 Jan 2025 05:08:43 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 01bd21bd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 16 Jan 2025 10:08:42 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 16 Jan 2025 11:08:35 +0100
Subject: [PATCH 03/10] reftable/record: handle overflows when decoding
 varints
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-b4-pks-reftable-sign-compare-v1-3-bd30e2ee96e7@pks.im>
References: <20250116-b4-pks-reftable-sign-compare-v1-0-bd30e2ee96e7@pks.im>
In-Reply-To: <20250116-b4-pks-reftable-sign-compare-v1-0-bd30e2ee96e7@pks.im>
To: git@vger.kernel.org
Cc: 
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
it.

While at it, refactor `put_var_int()` in the same way by copying over
the implementation of `encode_varint()`. While `put_var_int()` doesn't
have an issue with overflows, it generates warnings with -Wsign-compare.
The implementation of `encode_varint()` doesn't, is battle-tested and at
the same time way simpler than what we currently have.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/record.c                | 53 +++++++++++++++++-----------------------
 reftable/record.h                |  4 +++
 t/unit-tests/t-reftable-record.c | 17 +++++++++++++
 3 files changed, 44 insertions(+), 30 deletions(-)

diff --git a/reftable/record.c b/reftable/record.c
index 04429d23fe..4e6541c307 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -21,47 +21,40 @@ static void *reftable_record_data(struct reftable_record *rec);
 
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
+		val += 1;
+		if (!val || (val & (uint64_t)(~0ULL << (64 - 7))))
+			return -1; /* overflow */
+		if (buf >= in->buf + in->len)
 			return -1;
-		}
-		val = (val + 1) << 7 | (uint64_t)(in->buf[ptr] & 0x7f);
+		c = *buf++;
+		val = (val << 7) | (c & 0x7f);
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
+	varint[pos] = value & 127;
+	while (value >>= 7)
+		varint[--pos] = 128 | (--value & 127);
+	if (dest->len < sizeof(varint) - pos)
 		return -1;
-	memcpy(dest->buf, &buf[i + 1], n);
-	return n;
+	memcpy(dest->buf, varint + pos, sizeof(varint) - pos);
+	return sizeof(varint) - pos;
 }
 
 int reftable_is_block_type(uint8_t typ)
diff --git a/reftable/record.h b/reftable/record.h
index a24cb23bd4..721d6c949a 100644
--- a/reftable/record.h
+++ b/reftable/record.h
@@ -34,6 +34,10 @@ static inline void string_view_consume(struct string_view *s, int n)
 
 /* utilities for de/encoding varints */
 
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


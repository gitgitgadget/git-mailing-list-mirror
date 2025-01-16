Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2C11DDC18
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 10:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737022127; cv=none; b=bkTA+w6qYm0ZDdehLC1LOiWZ38ShVn1dhtm7m9rIIyf8+3Eq0jaQYPYQA3+GBZqeaQn7k5BECZ8jKqYs0TIo+WeuB9SI0cG5AvxvXCLvWbOi49qu7VHM8t1rJWC8DfxCmZvBZz9xq8bEm9jLLweg9aAWI0nG1rXIABPIsKw60yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737022127; c=relaxed/simple;
	bh=uxD7ORFPY2y/jJ5viwLqnGnRmGkJYaTxhDavee6JtPs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p4X3J/ID6aibagcOHQAFW3Nu0Ql+qE+aus6IMyYuSEsyMhJ1it1f6uD3y44UD4GI3Vcst5ZHkILMt1r0HvxdsGOXrQx1ToPUQJRRQbcLZgnqHqoc5krvaELBJSI6n0hpeoi2VipdOIct05XxZBc80loM68/oxBo2Sok2tlsRZhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OiuCSIqg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ss81/r1u; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OiuCSIqg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ss81/r1u"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 41B7A1140164
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 05:08:45 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 16 Jan 2025 05:08:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1737022125;
	 x=1737108525; bh=hLx/YWrmkyyblqxm/hEw4hwPGeUJyM9ubleoMZ1QncQ=; b=
	OiuCSIqgimuVdhaKJ+5q1UNe7FhVFJzQ4z+O/obOo50SfRYFpKpig2znYEmpjJ83
	ppIrkzcM5R9aEUn28olTplZDNFeuBWyWL/MsAgr6wbmElnzwPH2ukf0wt67Fr/L+
	FixPsSqItt3TLDf9QN6s0xObIgQ/QcEHeQXYqjP8rf40EjUiUfIY6UMliHG2HS1p
	Ibr4XEzjGGjRwZBHblAWZjgDFGWALUtgZS1Ujmv/sImKra0Fcot8AiUpIl8SPvPY
	U7dJYw2JS9N2ImlnkUyrEQl3SG4H0dCy0w2psBW+FFL1D0SZs8PY6R7aTL5FpJhN
	V89iQLXIn1y0O/wWRt4WVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1737022125; x=
	1737108525; bh=hLx/YWrmkyyblqxm/hEw4hwPGeUJyM9ubleoMZ1QncQ=; b=S
	s81/r1unZpLJi6HtnEZNwRex9DI+h0022sOyvpCm/v9RxA/c7ruTP+BY02GZfknB
	cjrCD6DtlzU06eZPnzpCEzgGobHD28mq4AGCCvz2eVgyteWw5UylaBKnsVTWZ4cy
	87xSZJ7434VnsgVI4R2QMW4bDDN8cZUXzhbezhnAJiGW5VVdDdJmZHsJnOTUfsUy
	9Sga1KhVKee7d1ztKYAPCQ3mmoAKJBcWPz3oU8x2ffqcxpbZt9byC+Igf9gS9yts
	RwmwjUG0xMyxtfgBRDIyn8H6n9YclG2FJChzjasZ+OVBtwE+ri4tXiX4uEJ+iNBS
	k67gKDB0wtlw5UhA6Ti5Q==
X-ME-Sender: <xms:rNqIZyxw8jd8risL53wisvkczNMvvXP8js0pfpUFWskiv09t4aUh4g>
    <xme:rNqIZ-Rmh3u4I_QpLMarCcI1N_y7QmvXd7waR7IGVJoPhYCqqOJDbboAZS47lyvOW
    GX0xAou0uNk44pXbw>
X-ME-Received: <xmr:rNqIZ0X_p8gBl_S3LLa2ct5M4DWHGriacEq3Z8_pVSzIbBxFq6QS9-hrasVPXjlbt51RU4szM6nomS_wGAfEm0h07YrlGAU9Q9sdr-G4eFr5983KZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:rdqIZ4gaX825mEYWJlxXXGrN3GP-2bmDrlYHpuIcB6guPeb-ECF9lQ>
    <xmx:rdqIZ0BA-IRM09DrouGdSN5qhdeIbhYBTKp3R5mlCmRXfJxWOwNqFw>
    <xmx:rdqIZ5J3U-Myt5U3iks6jTfh5MDY6u8NQLxt4hXxFFHk5z3548kmug>
    <xmx:rdqIZ7CmLBEPH5kWDwEoH4T0ka_ICLuK8-7QrVNo-vY_OiXvMH8gFA>
    <xmx:rdqIZ97uu_PRGqK1Z2dJtWvvh2oJe2is6Qcg2T4Rd8j8Xr7eZ5B4F6L2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 16 Jan 2025 05:08:44 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a28faafa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 16 Jan 2025 10:08:43 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 16 Jan 2025 11:08:36 +0100
Subject: [PATCH 04/10] reftable/basics: adjust `common_prefix_size()` to
 return `size_t`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-b4-pks-reftable-sign-compare-v1-4-bd30e2ee96e7@pks.im>
References: <20250116-b4-pks-reftable-sign-compare-v1-0-bd30e2ee96e7@pks.im>
In-Reply-To: <20250116-b4-pks-reftable-sign-compare-v1-0-bd30e2ee96e7@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

The `common_prefix_size()` function computes the length of the common
prefix between two buffers. As such its return value will always be an
unsigned integer, as the length cannot be negative. Regardless of that,
the function returns a signed integer, which is nonsensical and causes a
couple of -Wsign-compare warnings all over the place.

Adjust the function to return a `size_t` instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/basics.c                | 8 +++-----
 reftable/basics.h                | 2 +-
 reftable/record.c                | 4 ++--
 reftable/writer.c                | 5 ++---
 t/unit-tests/t-reftable-basics.c | 2 +-
 5 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/reftable/basics.c b/reftable/basics.c
index fe2b83ff83..10b234ea55 100644
--- a/reftable/basics.c
+++ b/reftable/basics.c
@@ -263,14 +263,12 @@ int names_equal(const char **a, const char **b)
 	return a[i] == b[i];
 }
 
-int common_prefix_size(struct reftable_buf *a, struct reftable_buf *b)
+size_t common_prefix_size(struct reftable_buf *a, struct reftable_buf *b)
 {
-	int p = 0;
-	for (; p < a->len && p < b->len; p++) {
+	size_t p = 0;
+	for (; p < a->len && p < b->len; p++)
 		if (a->buf[p] != b->buf[p])
 			break;
-	}
-
 	return p;
 }
 
diff --git a/reftable/basics.h b/reftable/basics.h
index 4bf71b0954..9ff81a68f8 100644
--- a/reftable/basics.h
+++ b/reftable/basics.h
@@ -169,7 +169,7 @@ static inline void *reftable_alloc_grow(void *p, size_t nelem, size_t elsize,
 #endif
 
 /* Find the longest shared prefix size of `a` and `b` */
-int common_prefix_size(struct reftable_buf *a, struct reftable_buf *b);
+size_t common_prefix_size(struct reftable_buf *a, struct reftable_buf *b);
 
 int hash_size(enum reftable_hash id);
 
diff --git a/reftable/record.c b/reftable/record.c
index 4e6541c307..69c09ec163 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -135,9 +135,9 @@ int reftable_encode_key(int *restart, struct string_view dest,
 			uint8_t extra)
 {
 	struct string_view start = dest;
-	int prefix_len = common_prefix_size(&prev_key, &key);
+	size_t prefix_len = common_prefix_size(&prev_key, &key);
 	uint64_t suffix_len = key.len - prefix_len;
-	int n = put_var_int(&dest, (uint64_t)prefix_len);
+	int n = put_var_int(&dest, prefix_len);
 	if (n < 0)
 		return -1;
 	string_view_consume(&dest, n);
diff --git a/reftable/writer.c b/reftable/writer.c
index 740c98038e..4e6ca2e368 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -585,10 +585,9 @@ static void update_common(void *void_arg, void *key)
 	struct common_prefix_arg *arg = void_arg;
 	struct obj_index_tree_node *entry = key;
 	if (arg->last) {
-		int n = common_prefix_size(&entry->hash, arg->last);
-		if (n > arg->max) {
+		size_t n = common_prefix_size(&entry->hash, arg->last);
+		if (n > arg->max)
 			arg->max = n;
-		}
 	}
 	arg->last = &entry->hash;
 }
diff --git a/t/unit-tests/t-reftable-basics.c b/t/unit-tests/t-reftable-basics.c
index 1d640b280f..9ba7eb05ad 100644
--- a/t/unit-tests/t-reftable-basics.c
+++ b/t/unit-tests/t-reftable-basics.c
@@ -120,7 +120,7 @@ int cmd_main(int argc UNUSED, const char *argv[] UNUSED)
 		for (size_t i = 0; i < ARRAY_SIZE(cases); i++) {
 			check(!reftable_buf_addstr(&a, cases[i].a));
 			check(!reftable_buf_addstr(&b, cases[i].b));
-			check_int(common_prefix_size(&a, &b), ==, cases[i].want);
+			check_uint(common_prefix_size(&a, &b), ==, cases[i].want);
 			reftable_buf_reset(&a);
 			reftable_buf_reset(&b);
 		}

-- 
2.48.0.257.gd3603152ad.dirty


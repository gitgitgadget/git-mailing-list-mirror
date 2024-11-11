Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF27176ABA
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 10:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731321537; cv=none; b=gaT4JCRoJbdLilAbU7h63k7ZEguusQnVdEuUz++omdxulHNWORa+wRL8XAjH7SSWxR+YOlRcp/YDbjW4/fUoWvDaceKsPMwxHYeLYIWrUURiyJNgemoYvsH6qPdQH5gK9RmbmBfVQXH5Z5D/z6oiWr0g/reUMKBLBjOIQcLt/fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731321537; c=relaxed/simple;
	bh=ZW5uaf3c57zbh1cAe1ssTIsSsrSHcq4QK5ZVqw/Fn9E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=koMgcAwt+r0FmgLe6zbeViR0LM48fagdoRmIewz7F37nAzhvVWJhnDR4LvG9BQncs1WI7GN8Ky25QWE175v2Gc1c15ucmWe4IeUXsAtk9+LtPCdee7geyKFzh6SJOtkzxwZBCzgmc1CCi5KRepgyc9AVsV3hYdqsQ5FTUyMhMIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=v5qJbGr8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MMKmJxWL; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="v5qJbGr8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MMKmJxWL"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 0715D13802D7;
	Mon, 11 Nov 2024 05:38:55 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 11 Nov 2024 05:38:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731321535;
	 x=1731407935; bh=lELfZa0vTGPS4SyQVgG/1N97X/Bz1bjEsWZ1KWy1pKQ=; b=
	v5qJbGr8c4YEcrgf66A1bk8Ghl9mi8qhnuIqMGfrEMoJvQO2xZcyUuGiUC91evI7
	xAt56IRZuQdYQPe9JP8Fzl/Ec3M4zCBjIlccWVpXb1wCwAmTEq/MnNGZwTTy8v+f
	sVb+aXlwQuLKlikPqI/YAn5BN1SBg4uWslbgdM/8DCS0fzFXSHJNxVArD+q4nXfS
	ci+u1X6WM2AU6MD+hjmw3ies9GaPY8uSMuWue2Zr7CRddw5uaOlveVrQaeBS9wxT
	OLJoESJu4mLjuPdBQURzAURXAWiyUb/8a/DgsdhMfS+ezyAHhzPCf1T0NpTzsP5l
	nQUQO0Q4PZSTnCnVxVACdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731321535; x=
	1731407935; bh=lELfZa0vTGPS4SyQVgG/1N97X/Bz1bjEsWZ1KWy1pKQ=; b=M
	MKmJxWLrHFEPUTVkHsexBGiWvYKvAy7rNC0SJi3yliFXviL1cHrt34+QHoRYbXBD
	mBHZp5nE4zBY3hzCrcEMbSFPppwV5nOker+3ppdV4HqydeZjdbbrs36ITPOZf71l
	5fQXyJ/9XMEAFz0gVxnNNqMWXNKXyGiHk9KK/glBoj3nj++uRDSW1Ccb0WKjXNHM
	URmtlFtLiSmb+lV+lQGGWA6b1m4nyc2QbE82bfpYktzYyk0iKINwAQFU0WSqmAMh
	byT36Ri+/WTJ8++qL85PTS0ITxua1yLpHHD/9R2oWBzHkwUOcAnaWhV4fmhBdLKZ
	v1a0VNNs78EHAi7/Ir7mw==
X-ME-Sender: <xms:vt4xZ2oi11MEPIikcoXHVCHBRTVSvpi--eEFi4Au1oLkWFGLycqlRg>
    <xme:vt4xZ0r_MumEJUUa5yVItngRQ783P-fP25s3arifEtR8vNYd82P3vXlNZc3fExl_8
    sa_PXVUOMJHFvfcVA>
X-ME-Received: <xmr:vt4xZ7OGq5dbt0hu4SnBQN5iJM7tpqv_UCkQXjH8HM1q4L3lAWqP1J0rC-c79KwDihnCjDZtnDnSiMiWjgeCpk-MYbXx_grgxymEvB3An50zfS2R>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprhhjuhhsthhosehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:vt4xZ16Y9FqOT1I5lj-zUqiqtOPOh9Z2zl1jBOD9NnuzRJCq7UXQmw>
    <xmx:vt4xZ14Y9bE0YTnTbx0B7ntzBEKFsWXqMcUijO8jjMPI3h4J8wghiA>
    <xmx:vt4xZ1hwznRmcwKbg_YvBY2KCpm0bwSAJK_0804g89Mhiql8fFWKNQ>
    <xmx:vt4xZ_52koivAU4TElCLkNlYyZH1w6MS_Pje1gg5ZZluKSpNxo-Rmg>
    <xmx:v94xZ1GTG8-DgBQZc4wzw1DE__ShlNVLhvBPPoJcGNtOjOVRAYPf1to5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 05:38:54 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b8f48758 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Nov 2024 10:38:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 11 Nov 2024 11:38:38 +0100
Subject: [PATCH v2 09/27] strvec: introduce new `strvec_splice()` function
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-b4-pks-leak-fixes-pt10-v2-9-6154bf91f0b0@pks.im>
References: <20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im>
In-Reply-To: <20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
X-Mailer: b4 0.14.2

Introduce a new `strvec_splice()` function that can replace a range of
strings in the vector with another array of strings. This function will
be used in subsequent commits.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 strvec.c              | 19 +++++++++++++++
 strvec.h              |  9 +++++++
 t/unit-tests/strvec.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 93 insertions(+)

diff --git a/strvec.c b/strvec.c
index f712070f5745d5f998d0846ac4009441dddfa500..81075c50cca4fe44608775541d876294a79d9e4e 100644
--- a/strvec.c
+++ b/strvec.c
@@ -56,6 +56,25 @@ void strvec_pushv(struct strvec *array, const char **items)
 		strvec_push(array, *items);
 }
 
+void strvec_splice(struct strvec *array, size_t pos, size_t len,
+		   const char **replacement, size_t replacement_len)
+{
+	if (pos + len > array->alloc)
+		BUG("range outside of array boundary");
+	if (replacement_len > len)
+		ALLOC_GROW(array->v, array->nr + (replacement_len - len) + 1,
+			   array->alloc);
+	for (size_t i = 0; i < len; i++)
+		free((char *)array->v[pos + i]);
+	if (replacement_len != len) {
+		memmove(array->v + pos + replacement_len, array->v + pos + len,
+			(array->nr - pos - len + 1) * sizeof(char *));
+		array->nr += (replacement_len - len);
+	}
+	for (size_t i = 0; i < replacement_len; i++)
+		array->v[pos + i] = xstrdup(replacement[i]);
+}
+
 const char *strvec_replace(struct strvec *array, size_t idx, const char *replacement)
 {
 	char *to_free;
diff --git a/strvec.h b/strvec.h
index 4b73c1f092e9b016ce3299035477713c6267cdae..4e61cc9336938a95318974903f9b35dcdc4da1cd 100644
--- a/strvec.h
+++ b/strvec.h
@@ -67,6 +67,15 @@ void strvec_pushl(struct strvec *, ...);
 /* Push a null-terminated array of strings onto the end of the array. */
 void strvec_pushv(struct strvec *, const char **);
 
+/*
+ * Replace `len` values starting at `pos` with the provided replacement
+ * strings. If `len` is zero this is effectively an insert at the given `pos`.
+ * If `replacement_len` is zero this is effectively a delete of `len` items
+ * starting at `pos`.
+ */
+void strvec_splice(struct strvec *array, size_t pos, size_t len,
+		   const char **replacement, size_t replacement_len);
+
 /**
  * Replace the value at the given index with a new value. The index must be
  * valid. Returns a pointer to the inserted value.
diff --git a/t/unit-tests/strvec.c b/t/unit-tests/strvec.c
index bf4c0cb172e1f01c452b8744084cc45bf3aa86fa..855b602337169f6fffcadf91e0734db44ceccb16 100644
--- a/t/unit-tests/strvec.c
+++ b/t/unit-tests/strvec.c
@@ -88,6 +88,71 @@ void test_strvec__pushv(void)
 	strvec_clear(&vec);
 }
 
+void test_strvec__splice_with_same_size_replacement(void)
+{
+	struct strvec vec = STRVEC_INIT;
+	const char *replacement[] = { "1" };
+
+	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
+	strvec_splice(&vec, 1, 1, replacement, ARRAY_SIZE(replacement));
+	check_strvec(&vec, "foo", "1", "baz", NULL);
+	strvec_clear(&vec);
+}
+
+void test_strvec__splice_with_smaller_replacement(void)
+{
+	struct strvec vec = STRVEC_INIT;
+	const char *replacement[] = { "1" };
+
+	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
+	strvec_splice(&vec, 1, 2, replacement, ARRAY_SIZE(replacement));
+	check_strvec(&vec, "foo", "1", NULL);
+	strvec_clear(&vec);
+}
+
+void test_strvec__splice_with_bigger_replacement(void)
+{
+	struct strvec vec = STRVEC_INIT;
+	const char *replacement[] = { "1", "2", "3" };
+
+	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
+	strvec_splice(&vec, 0, 2, replacement, ARRAY_SIZE(replacement));
+	check_strvec(&vec, "1", "2", "3", "baz", NULL);
+	strvec_clear(&vec);
+}
+
+void test_strvec__splice_with_empty_replacement(void)
+{
+	struct strvec vec = STRVEC_INIT;
+
+	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
+	strvec_splice(&vec, 0, 2, NULL, 0);
+	check_strvec(&vec, "baz", NULL);
+	strvec_clear(&vec);
+}
+
+void test_strvec__splice_with_empty_original(void)
+{
+	struct strvec vec = STRVEC_INIT;
+	const char *replacement[] = { "1", "2" };
+
+	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
+	strvec_splice(&vec, 1, 0, replacement, ARRAY_SIZE(replacement));
+	check_strvec(&vec, "foo", "1", "2", "bar", "baz", NULL);
+	strvec_clear(&vec);
+}
+
+void test_strvec__splice_at_tail(void)
+{
+	struct strvec vec = STRVEC_INIT;
+	const char *replacement[] = { "1", "2" };
+
+	strvec_pushl(&vec, "foo", "bar", NULL);
+	strvec_splice(&vec, 2, 0, replacement, ARRAY_SIZE(replacement));
+	check_strvec(&vec, "foo", "bar", "1", "2", NULL);
+	strvec_clear(&vec);
+}
+
 void test_strvec__replace_at_head(void)
 {
 	struct strvec vec = STRVEC_INIT;

-- 
2.47.0.229.g8f8d6eee53.dirty


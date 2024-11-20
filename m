Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D7D1AD5DE
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 13:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732109998; cv=none; b=T84aQk2F1VextEVCLepqI4iHo14CnJWVQru/42AtxrUgfP+YspG5jDoOPFVPSj+zinYniIHEEqKYOSuzoFia9zjE3VS2kebH8jI9ApViOfRndAnfZiq2gOfJ+28jypxCc+VdSTuhoT+aKt5xIX9tS1XrhPiIiLfRM/eQa4kC6Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732109998; c=relaxed/simple;
	bh=L89v3PS5Ri+gE0oXmiidN1U88YZ2VLSDi0DYq86pRkM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cq5fP7T6AgVZeAopRyP6uu1Sl2M1PxYn4nFdFg6um8uDgtnZaIeE5cKULB0hXWOJeypLRrXIifsL8nVs6tnl5Yk5Vycf9uEz94WPRIgETn+ePcu66Dz57kxvP1jQRec7qIN7E5JwERhqnd/hx3le7ipUBOV6onFsPuxmv55NEdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DVSi2bQ7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W4bb5v1c; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DVSi2bQ7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W4bb5v1c"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id C2AD913803AF;
	Wed, 20 Nov 2024 08:39:55 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 20 Nov 2024 08:39:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732109995;
	 x=1732196395; bh=fG8AtLUPaQtEesuz6njUFRLiBKcANgRuXPNxUQUtawc=; b=
	DVSi2bQ7PsFkqAutEysAYe5Bkc/ryVN9lhb4OyFX7sGYiZt6/Zb4AH8GAr+8J0AU
	wNG0ScLxSS8pop2Q3L1KYxFCMN3OJRl/l4yDNWiVoPEs9lg2itZ59ymh025MoeTc
	XUqZK1i1IWN3YiPsg0YZ9KQLSnqgyN0pE/FZBWl8Dg+w07jCzssN7xxEzLc5luKw
	hepKTKQKDoJy3WSdiVprvQlWKmg/Tg5yT+MNQsMEQ6Olxbs9NqVzXlCeev+38NoF
	2Dsw0dy1gx743qJQ7B0tyMSep8IY9pur9xKsizQrSFaqfNiYzs708DkaRNQPtLNe
	IMmGaCfyF3sqqueOYxlRqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732109995; x=
	1732196395; bh=fG8AtLUPaQtEesuz6njUFRLiBKcANgRuXPNxUQUtawc=; b=W
	4bb5v1colnY4xfHMIKcazqnj2zGMbTtGP20DO6RaGFcn1Y9LtoKsW/FkvcLP8DfI
	XGiFu+9Eeds7udTyG8BnsHFWmYE0o1ZcCMB2po3q4Yq9FjVhwk5V0tcj9wA4CfpT
	Eri3pxuOyoaLQ6nXWTPVFcZX81NSnrpKsz/YqURbGFdEToPN9lBYuw+G92+2zZ78
	U2z9b2dLMFgBCJSFAxfzpScJu5U3TPzkJg6IuMpEVhOJ4KukXVs1yJboNxBNPizF
	w/t4q11wH6E2R3aFGu8C66/IhOIVYObzAVlCUi9LMtOxlc+IvKWlKN8fw8I0L6u0
	3TxSjPhyZqeP0G5O9JfFg==
X-ME-Sender: <xms:q-Y9Z-EEOy9gf-FuugqQatB5adME9R7vL_FDY6_3Jb4QxcnhfH3kcA>
    <xme:q-Y9Z_VV5Qf7qBHOrwTssnfGxkUSjHlpjVSMJcD7X0M9l7ee6lP03eNLnnsFYwlZM
    ipmLmfiH5NLlgexgg>
X-ME-Received: <xmr:q-Y9Z4IPHBNUucFmIAze4TBvLB858E-NqBT2p3HIWw0pWfBvLKYXYemJI9bFBSp4_Ye-DCSQa3o-O3KFlkMbNucGAz0AC9LAC1axGDUw3o7WRg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeeggdehgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    htohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehrjhhushhtohesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:q-Y9Z4HSnKXwTbwXBUVhE4OfFPsKFoCw8vzHGMG6HgAus3Lt6SlUaQ>
    <xmx:q-Y9Z0VLFZIDif5M1Vukq2qkxfpHaYmGQE4T6s5Dqqp7K0gTRKnRfA>
    <xmx:q-Y9Z7OmMw94CwCCk2af2NFKZz0_vHlaO-iDsZ5vhPmzjDNhovNAMA>
    <xmx:q-Y9Z71dZDozOtaQOQkDOKJJ6fF9Kt1ewqu1AR_m0Cf_wApy6eeGSg>
    <xmx:q-Y9ZywHayH7D8jHYdUHWaJ0mUsZ1WX1hRpBUbg7mJ8GLnnNkV-6Ubiy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 08:39:54 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f8d9007f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 20 Nov 2024 13:39:02 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 20 Nov 2024 14:39:38 +0100
Subject: [PATCH v3 09/27] strvec: introduce new `strvec_splice()` function
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241120-b4-pks-leak-fixes-pt10-v3-9-d67f08f45c74@pks.im>
References: <20241120-b4-pks-leak-fixes-pt10-v3-0-d67f08f45c74@pks.im>
In-Reply-To: <20241120-b4-pks-leak-fixes-pt10-v3-0-d67f08f45c74@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>, 
 Jeff King <peff@peff.net>, Toon Claes <toon@iotcl.com>
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
index f712070f5745d5f998d0846ac4009441dddfa500..d1cf4e2496a564c878f4b81207efe275abed72cf 100644
--- a/strvec.c
+++ b/strvec.c
@@ -56,6 +56,25 @@ void strvec_pushv(struct strvec *array, const char **items)
 		strvec_push(array, *items);
 }
 
+void strvec_splice(struct strvec *array, size_t idx, size_t len,
+		   const char **replacement, size_t replacement_len)
+{
+	if (idx + len > array->nr)
+		BUG("range outside of array boundary");
+	if (replacement_len > len)
+		ALLOC_GROW(array->v, array->nr + (replacement_len - len) + 1,
+			   array->alloc);
+	for (size_t i = 0; i < len; i++)
+		free((char *)array->v[idx + i]);
+	if (replacement_len != len) {
+		memmove(array->v + idx + replacement_len, array->v + idx + len,
+			(array->nr - idx - len + 1) * sizeof(char *));
+		array->nr += (replacement_len - len);
+	}
+	for (size_t i = 0; i < replacement_len; i++)
+		array->v[idx + i] = xstrdup(replacement[i]);
+}
+
 const char *strvec_replace(struct strvec *array, size_t idx, const char *replacement)
 {
 	char *to_free;
diff --git a/strvec.h b/strvec.h
index 4b73c1f092e9b016ce3299035477713c6267cdae..f74e061e1419bce7c3f3730d4dfdf081c8db094e 100644
--- a/strvec.h
+++ b/strvec.h
@@ -67,6 +67,15 @@ void strvec_pushl(struct strvec *, ...);
 /* Push a null-terminated array of strings onto the end of the array. */
 void strvec_pushv(struct strvec *, const char **);
 
+/*
+ * Replace `len` values starting at `idx` with the provided replacement
+ * strings. If `len` is zero this is effectively an insert at the given `idx`.
+ * If `replacement_len` is zero this is effectively a delete of `len` items
+ * starting at `idx`.
+ */
+void strvec_splice(struct strvec *array, size_t idx, size_t len,
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
2.47.0.274.g962d0b743d.dirty


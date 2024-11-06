Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF6720400F
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 15:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730905855; cv=none; b=hJDUkc/hM7G+XzQYR4cZ/8eEDTVchFwGZNcMkcwrtSodO3uA66irM6b0X91JHuM3ETuQtY0FZJNEyT862FahmkwVJlq1yudwdsyiJMlavsD6JUi8PThEnO8znWsAcsYRFS9a44chzqp98NO4w3ZNuaZccBoeegaMzJOPOL/XuKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730905855; c=relaxed/simple;
	bh=1M8ygf+PLyY1ZekMyEndHXTNT6A+TF+5F87WjIPJvGM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j6y/sZaYeNHUyLTiG7+9LTiVfHWPwjSgbFrfX1suD58vK22BODIp0vrRb0ydv2dl6G5Zg7zMn1rI9gvG3dzxCniZ0bE3cEUL44r9ZxzzRQ1b0mMFUYol7QG7EWC/xXfHG/tfrMgsVJrr7InJvI6NZIM9P1SFmlqu13GbEZwMEL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aDuPlcMm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CsVyW6oj; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aDuPlcMm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CsVyW6oj"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 09CBD1380215
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 10:10:53 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 06 Nov 2024 10:10:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730905853; x=1730992253; bh=o57hGkGt7Y
	B/2fe0Bnw70B48LRlbHLs91jFmvN+ah8o=; b=aDuPlcMmriFscqhzGPVBudgnYO
	iTR510LnJlUUWQmDeyNygKolrEFeMhJ11lWQnjryx1obeTgxkobArBCrKPfbrJXx
	l4b9fUvzS1bfyg78mgXi2wX7xyJGYEUNOLROEiWSaBZb/+K1j3AYaGv+tA1ZbRwu
	RgR/lReTZ/93Lm2oWvJDmYxAKgfiQ6t2JNhychtldHRMTwy2IWpjH1MPSL+2TH+t
	zJy8gLHOGkCkCPLlc5lDa5PBuoSZzrzIcWnbdnN9i4tOTXcg8R0I3vxhNvqz3uW6
	7ySmP7PlaSGACB/hTPabYqbSIfgWIgLlmSBGpY5U52cPcLLiWnbSGzbBU8Ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730905853; x=1730992253; bh=o57hGkGt7YB/2fe0Bnw70B48LRlbHLs91jF
	mvN+ah8o=; b=CsVyW6ojH1iZSbxLLxanZNNlYtmCF0ZIb0CiR/vClXS61K3S/1D
	VtQM76doMkV9SBo6XvKbPyvTcVbh9EDzVGfllqU5OnDU/9u1T8lw08xNHvYhq/Ry
	lg15/3C4Ajp9sR3z2upfw/kEcpPjsI57IhazbqraGqbZWUwdWJ3CYZ3GF2l8DbeL
	qCuT3VjyuVSUIMFmAOIdODrQZPISTsbn7zH/Ox1/OWvgNZAmrzrgbb72jwvEF1oJ
	05jZL0tGocX1aZbTZ9dTozun0ILif1KeZVGlgyrDIllGkGziCFsr9+JBEcQEB1d3
	/x8L3JwRwf9wTVHjThJsdxLwc9cdRMmH1Tg==
X-ME-Sender: <xms:_IYrZ_K8RmT7aRLcnC2N3DKtcd8IO59e6PeFOxHwhLhoQoWn_zmq7w>
    <xme:_IYrZzL77ZLT8ZjSUV_BR423rnywGyAEpp-LY9itLpJ1wquUwT5XS9PvFNkMgl8_S
    1R0mIorh6Nq53bPWQ>
X-ME-Received: <xmr:_IYrZ3s4e0RYq6HI5RY7UQDP0pCv4dchwDeRdNdhR0f13Njoc5PbrJhl4FEsgpJk8_9dBkwV6To_Z3xWr-OcwGRKkmtz6FEHgFybl-UMZc3DLQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtddvgdejudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukf
    hfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgr
    rhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehkeeffeeggedvge
    dvfeefheettddtffejuefflefggfehfeelffeljedvfeehieenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprh
    gtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:_IYrZ4b6fN0VEszNuNLoknDIcawXfXUPDAQbKlGflk8jJHlsA-OXYg>
    <xmx:_IYrZ2bTFvvculUhGtJ6fSKwJ-lZFTQ13l1cvqHAYzWJkaLDUFauCQ>
    <xmx:_IYrZ8BClEHuedkdNbnMOWJcN9Nf6Gd4aOsxWadexCWXzSDWMik8wQ>
    <xmx:_IYrZ0Z9tpv6jVLLjI7m1bnWVvOcZwGCKePv4_nuMTF5ZwjDfm7K3g>
    <xmx:_YYrZ5yQardyEjkDyrbO8HFroAEn9mQMu3yX6bn4n_f5qW130ab6wBKx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 6 Nov 2024 10:10:52 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 07eaa36a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 6 Nov 2024 15:10:27 +0000 (UTC)
Date: Wed, 6 Nov 2024 16:10:44 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 09/26] strvec: introduce new `strvec_splice()` function
Message-ID: <c23e1a08854530f5c2474725ddde1da1068c2c12.1730901926.git.ps@pks.im>
References: <cover.1730901926.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730901926.git.ps@pks.im>

Introduce a new `strvec_splice()` function that can replace a range of
strings in the vector with another array of strings. This function will
be used in subsequent commits.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 strvec.c              | 19 +++++++++++++
 strvec.h              |  9 ++++++
 t/unit-tests/strvec.c | 65 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 93 insertions(+)

diff --git a/strvec.c b/strvec.c
index f712070f574..81075c50cca 100644
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
index 4b73c1f092e..4e61cc93369 100644
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
index bf4c0cb172e..855b6023371 100644
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


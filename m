Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8E122D4C0
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 08:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754553895; cv=none; b=F/dlIwijpg1D7XtIpnWCiRRGfXL3KIiw4exODDSRJ9Lls+MGKOXlFIKk3DLW44LHcUUPchwdw/D8g55ZF1b8UfnVux9jVrJFZPp/n1V2vZB95CO9y0QnbiOimd40uvmJ2K5bHovIR7vA4f+PdACV4LN8+bbBDOVDxp8E51jNQSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754553895; c=relaxed/simple;
	bh=3bPnKn/gja3ORJ5BqnE5WKiR1sUYXiU9rVRZ6g9bETE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=np+gvzTNO7cBGtOnKeDWGUegr/sICBNWhsuQjnsaJmLz6Oju2janxnZZb/3DszFLu0ILF1eMiEOSPmHX00b1TGZIWOYTLzz0PxkQketO/x0Qi66Fgm1CBVzLzybg90Sx69pUGmqI8Tgx2js9yOtU3b+MHFwZf7c78uyfW5Cgl0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Eb5be8g5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QDP9NoSn; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Eb5be8g5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QDP9NoSn"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 92A8DEC00B6;
	Thu,  7 Aug 2025 04:04:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 07 Aug 2025 04:04:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754553892;
	 x=1754640292; bh=9iQJYUvLvrBtxpMUyFQuDDbDGeK8Aeq6rMaTeD5DWNA=; b=
	Eb5be8g5djYxucYPwluIiEVvq9c4/cuhEPTzd1Tqki6sJUPjK4bb4E8RSPJx8PRG
	rAheZepBrsP9qoeWKVyOuo38zbvrhxL03pK2LNo74iJsTSxRubTauElMAGqAHhP8
	qBE/68T44wrsEcZ3XDWaqmdFUTEb6cvn1GjEw9DIwGgrdrTJENKCBMDEPeca15eU
	p8aQpacriqG5R3+d0QAYjRy/rmc4S0oUN7bOUjAMUvHYRZq8hpAZJWVqqINKvF7f
	OGhPymxz3y2lFvrLwT27R4qhp9tytH2nEECJhYymMSGNVG4/5e1lyiTQZzVDUve9
	Y7khdm2Sbabm4P+rTVB2vQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754553892; x=
	1754640292; bh=9iQJYUvLvrBtxpMUyFQuDDbDGeK8Aeq6rMaTeD5DWNA=; b=Q
	DP9NoSnGPpzQVvxNfMWAHQkmmq4iH34NA1HVlcCxrMDNzaYkGz/zdbCvycSHDKeC
	OfzmAd8ZwutwWedMomwWA+hr47IO70tM8utu6tGE5aOe/54fTeR2forN3z5s7Cn4
	001NOwF51qW2HjJiliRD6wqqZhLAggMFhw2uGWnFRRbESWye57cF/j/YzkHdf8X0
	jiqewcbpkqLj8jDC60UtB8pzlM65Gt3BsHk1e/SWf7nZlQZMMLzT5+0VB1n/Sa92
	Z4BrNJFYdWTcUypm5jOcdFfEuJ7nCCgxX4SEC+uZ1CSSiI8j5njGRsKNGG/fOGAV
	P4wtXKGISbZryOvshtJYg==
X-ME-Sender: <xms:JF6UaNfYg0XyZwQIyl86NU_w1sgR0ns7ntcy-njS6UZsco68xN1UXA>
    <xme:JF6UaGsQOwkJUrUKboF1RhMzUSUCYrTnHVYMnKgUIc4f2fRrTEe5l_NDREV1nku09
    PepiK4sC6AjWwiRMg>
X-ME-Received: <xmr:JF6UaM9JK3EDExYsuJJwFKcjhiyxlNp_0aZxNW4aIVaSTVIkII4cgaBB4BWr69A-Jhj4b0NrbaeJ2CI5qUG19Tp95p_9678_N3bMXEwaNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvddtgedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhi
    hlohhrrhdrtghomhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgt
    phhtthhopehoshifrghlugdrsghuugguvghnhhgrghgvnhesghhmgidruggvpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:JF6UaB0kqNVaA3DgVbci835uz9fPSdnthH5ChK4RtpuAxPNVtIXS6g>
    <xmx:JF6UaBDIwX31Ot1as0SogoSAkhs7NziwsNPwO3bbeCev23i-fizCdg>
    <xmx:JF6UaNfWOUog_URC_qKqqRqB7qKAdCwLNuOGTQby7D5VgIJfUyESjg>
    <xmx:JF6UaO7kSglG8UfDyt71PtiUGZd4QLCb4DMdjm7HoZgbPBJaLdHvrA>
    <xmx:JF6UaCrVTwCtPWk_Io4PJnKwbrMsLeDtFdcR8W1JlRwRXs8RsDy96nEQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Aug 2025 04:04:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 15220a83 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 7 Aug 2025 08:04:50 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 07 Aug 2025 10:04:43 +0200
Subject: [PATCH v3 01/10] trace2: introduce function to trace unsigned
 integers
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250807-b4-pks-commit-graph-wo-the-repository-v3-1-82edef830a1e@pks.im>
References: <20250807-b4-pks-commit-graph-wo-the-repository-v3-0-82edef830a1e@pks.im>
In-Reply-To: <20250807-b4-pks-commit-graph-wo-the-repository-v3-0-82edef830a1e@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>, 
 Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

While we have `trace2_data_intmax()`, there is no equivalent function
that takes an unsigned integer. Introduce `trace2_data_uintmax()` to
plug this gap.

This function will be used in a subsequent commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 trace2.c | 14 ++++++++++++++
 trace2.h |  9 +++++++++
 2 files changed, 23 insertions(+)

diff --git a/trace2.c b/trace2.c
index c23c0a227b..a687944f7b 100644
--- a/trace2.c
+++ b/trace2.c
@@ -948,6 +948,20 @@ void trace2_data_intmax_fl(const char *file, int line, const char *category,
 	strbuf_release(&buf_string);
 }
 
+void trace2_data_uintmax_fl(const char *file, int line, const char *category,
+			    const struct repository *repo, const char *key,
+			    uintmax_t value)
+{
+	struct strbuf buf_string = STRBUF_INIT;
+
+	if (!trace2_enabled)
+		return;
+
+	strbuf_addf(&buf_string, "%" PRIuMAX, value);
+	trace2_data_string_fl(file, line, category, repo, key, buf_string.buf);
+	strbuf_release(&buf_string);
+}
+
 void trace2_data_json_fl(const char *file, int line, const char *category,
 			 const struct repository *repo, const char *key,
 			 const struct json_writer *value)
diff --git a/trace2.h b/trace2.h
index e4f23784e4..115c45a1eb 100644
--- a/trace2.h
+++ b/trace2.h
@@ -463,6 +463,15 @@ void trace2_data_intmax_fl(const char *file, int line, const char *category,
 	trace2_data_intmax_fl(__FILE__, __LINE__, (category), (repo), (key), \
 			      (value))
 
+void trace2_data_uintmax_fl(const char *file, int line, const char *category,
+			    const struct repository *repo, const char *key,
+			    uintmax_t value);
+
+#define trace2_data_uintmax(category, repo, key, value)                       \
+	trace2_data_uintmax_fl(__FILE__, __LINE__, (category), (repo), (key), \
+			      (value))
+
+
 void trace2_data_json_fl(const char *file, int line, const char *category,
 			 const struct repository *repo, const char *key,
 			 const struct json_writer *jw);

-- 
2.51.0.rc0.215.g125493bb4a.dirty


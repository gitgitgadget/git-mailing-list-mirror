Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E208244688
	for <git@vger.kernel.org>; Wed,  6 Aug 2025 12:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754481625; cv=none; b=aVljKjee6LYWdaoxUDsY3Ug/A8xI68rpnDfje6HYLn5iWJ9Fzc4Yrxk3xmmJ4E/Zc0Ohf6i5RWpzq89Al2n+vf4x9V+LX+jiNnE/FQNQCEM5WUjWGHEqkFdRbU/in8xwc3JIiTrICXSIW1kMIk/IOrMPVX+7SF/3pIdJT/KzMCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754481625; c=relaxed/simple;
	bh=3bPnKn/gja3ORJ5BqnE5WKiR1sUYXiU9rVRZ6g9bETE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=apD33bmot+d8u3lT15V4bqZrrg31FnkLOKueKKFKJRfWPy49UfhVxkLRHs7eTG0PDt69j01T/FRa1vj22MdzqAz1kSfcNzdgfQmp4VcVnH12+8UF1UhVgGLGFJNMcN+Ai2fMvhAVp3e2DNsQnsWgOhU1d9KOmYMYSALXKvXF24Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UW8nPOxy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eqyq+NHE; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UW8nPOxy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eqyq+NHE"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BB24D14000C9;
	Wed,  6 Aug 2025 08:00:22 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 06 Aug 2025 08:00:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754481622;
	 x=1754568022; bh=9iQJYUvLvrBtxpMUyFQuDDbDGeK8Aeq6rMaTeD5DWNA=; b=
	UW8nPOxyZQVZ3wO/S5quKsqb5g1hqULu2Dwen2PtwlZXdBNSecYRGQ1vaZf0EkBK
	HhLiqvLHRpyew1koVubof1O4kaIb609kwu0fJxGYpR3rlTdkwbxGmcEkWScNqLfL
	sq1qFIfqa+wGYiGjS7rCWjodWVEzi3odMMaMV8ahnTB16PLpmaBOt/F4RQPXF6uE
	eQ4G9ZY5K6tN6fPcSTePdLT/DNnw0CvuI+R+Zcq1+xNI7QhD0gmFNoZ+JzeOrZMM
	cYU9ArbizLacayVsEFIHzzCy3cwLpssyGR5tAkC4td7o5T4tAmnVPJJNsxP0Z0tE
	VolVZgysYIHNZ6cqcwXAew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754481622; x=
	1754568022; bh=9iQJYUvLvrBtxpMUyFQuDDbDGeK8Aeq6rMaTeD5DWNA=; b=e
	qyq+NHECBJ1K03MCx8aAVJMGPhzTwk3z1hPa5DPAnaRNR0GWskQvHPHL7YqyWLwC
	pfIxteEWW0kb9KN9XcbCq7CbD+Uxu8xqV2cbgpaYazPWc4AaEYXUNysBJOBp4fC4
	pSHLPbr3vSeFQi8TG3FTAolIdloJOXyzeQJ9Yuzyzpvp3+gXY2QZNa3/XDs2K1Fd
	78blkBbrddWEiec4Z6ZVAbpx8uAUNyq2uI+Hm2huqHw7Kr6Xu0tsG6Nj9IFHZwfW
	RNXcWBaX+3i0pOONbjh7yF9gd9Sw82glTlLkypUqxYaNeHxLcxGVW2E4mqjZpeAv
	jqJ1Po4drTWx0Cv9YXkGA==
X-ME-Sender: <xms:1kOTaOpWMw5N1oq2nN5oQne8FD3_7x5cM_3LU8BM5jnqJ3TOW3FiPQ>
    <xme:1kOTaILQvNqhZQvY3wlpOMhsNmGDQT5swNFXrczamzJfd80O5Q5cXpqocffbIVouX
    WkVBicuFgj5-ULtYQ>
X-ME-Received: <xmr:1kOTaJq9Mj-UtCL8rTqS2zD-b0_f387WlSEOQUJKFFshn6jvdorHCsp8Lm073HtIeNnujUh_Lgfgi58qftn3ErNqXIQfx2ntEMsTAMbrNg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudektddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehtth
    grhihlohhrrhdrtghomhdprhgtphhtthhopehoshifrghlugdrsghuugguvghnhhgrghgv
    nhesghhmgidruggvpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:1kOTaIzTAApSoxoA73AK1HVZDYenIuF3XeG4QXcGZIKb32aqQvEmvA>
    <xmx:1kOTaFM0dnHaNsUpee19_nrcntFzPCpHLgURoqLsylEsn6UzPavRQw>
    <xmx:1kOTaF4hFA_hf3DBWm1tkOxL_hVLscO2Bt3NqYs1UzFU6-hAUOTXPA>
    <xmx:1kOTaGnqpb_h_nflOfBiUGigWGhFKt3jxzEbmGj6F97tSRwbipRAFg>
    <xmx:1kOTaHkxfz3BBlBrjf0HlK5ujIMfUf3zSTCOyXLma19zncVkppIRdUPF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Aug 2025 08:00:21 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1af9939c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 6 Aug 2025 12:00:20 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 06 Aug 2025 14:00:06 +0200
Subject: [PATCH v2 01/10] trace2: introduce function to trace unsigned
 integers
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250806-b4-pks-commit-graph-wo-the-repository-v2-1-911bae638e61@pks.im>
References: <20250806-b4-pks-commit-graph-wo-the-repository-v2-0-911bae638e61@pks.im>
In-Reply-To: <20250806-b4-pks-commit-graph-wo-the-repository-v2-0-911bae638e61@pks.im>
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


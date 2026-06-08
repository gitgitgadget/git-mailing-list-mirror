Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309043B8958
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 10:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780914229; cv=none; b=cveZWC1lERCFDoP3q3bLiZFFAmJRDOYS6xmbH0xm2ja62lt0RRFPDyPzWOQ238p77cgpjGTMSUOSP3igX4l+lzzUZbTZNY5r6rSkqnjAYqe4Iq+VepnsvtkLsDaemVxW3rpoQkAJnPSgWaD4Zc3B3T7iUo6ZEj2CftN/2PcuH3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780914229; c=relaxed/simple;
	bh=kz0/pYWQnUmLqKfeKhGGKtgIKTBAp8HkeWBtgNld79o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S/NWHYw2k0zGbiSA1ImIbJ/8xdLRaB3cdr9bVBi0GjyLtay1AAvYOL37+ovFM8id81CGTu22s7AjxV1QyFOb0E89aMViBJx2hjUiPL+bMJyxCcZ32DnExIdGd/ssMFy9ox1KGv+j/S55BetWaQ6qYbPeBUXSvG4z+oUiN2JEViw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Fag1C7uF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WJSyRe1r; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Fag1C7uF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WJSyRe1r"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7B5367A0079;
	Mon,  8 Jun 2026 06:23:47 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 08 Jun 2026 06:23:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780914227;
	 x=1781000627; bh=jqLt4ehA1CFxw9UGbO0LdDD/NWjg+bYuGlPYpV/f3Yc=; b=
	Fag1C7uFn3HbP8yYmNLjS7mOKKhhBrr3RLtaQzqJKoMw/O9ndzGH8NBeUZdnJPos
	3StzolFla16d+K2epTMzk308sUzz0j2Hc80i3Ww/V0/FzOcJJkS0sm2ZX5mXL5KU
	U04ed+xsSBIH6aORjEpCUcNf4NJbfGQTbeUxLAQPtgTaE01vIRMVbunV03LhWK4y
	nGTmnpaNMjmLG+/unal4cv4Opxhg/dOXYs5jOqdE8JYsTmgJndL5EQwHMC5MwUBm
	p27yF+ZQ6tqICQFaGu6ya7qfQRvhxS7J5lcwwMKlwB9y7aWU9aVKXD1OpFhoDCUF
	MBW0XEPulIGqHYv2j8Yzug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780914227; x=
	1781000627; bh=jqLt4ehA1CFxw9UGbO0LdDD/NWjg+bYuGlPYpV/f3Yc=; b=W
	JSyRe1rbY5TuzwGHVFi1AQszxkbkK2OQBarS1uLUZ0bLAfNFM6Y6gYNQCdPceiJm
	DdsAi9HjxcBHVyldb5uKTIXRvcwvWGwYM8wOZN8+Bo7Qtjwmtmk3j1X66m9atCJ5
	FOUs+1UvFnqkQOXN3RRIt0qxMphrMmFpXRPLAS1YR+/VzToyC0QZ7lu15/a8g645
	B5V0yTuTQ9j/PrwdQUoBHysax6Lsvy6v3jkUAk2MdpUFkbumUquww2/ZR0Dzu0L+
	nWoIelroFtjpQt66ohBLE9fTl64WW2jkDgmj+b8RsAJ9qncOLvsBB9kY2M1f5lJG
	Xqosop4+IdKw/0ppLeq4w==
X-ME-Sender: <xms:M5gmavuTSehDSNSV-3MPk2hfd00kTTr3qahMALKiVKgfLbMPd74pQA>
    <xme:M5gmah-uTJ1oHUtdqTh67JRrW685wGc8zwLVvmN5B7oytjlvVo_d249xilC9t4lyt
    eYA-Tbm5yhsne4hY6s8s92eRUW_FQ8ZsXpg1xWdAla5SjcxyAcu>
X-ME-Received: <xmr:M5gmai26v3lEc-yeYLg6HYyA4AnN83NocRF4sQ3ZUvxee-ZVsNzONEuOMqB7xurDQtcUlUJJWePSQ4lzviCO4A4bxKp9kZvgCulJYr5FGw>
X-ME-Proxy-Cause: dmFkZTE5TQe8hpv70ABKPBTJxGWpdo/cGQ72TfL6sqGzRnXYRKe2zl1W4uOIootjY7cZ80
    MniDNd/FNRDj1su/0pnc3HD+a/NtQ4/l0tMPv0ndV+mMpmp9/FVlN8MEifvX4kBYvCEMGg
    YbFb3qassHDopf/x+IzqMaPdLLZBldKr+Hf9eA+gNF9LzdD6ZHfzYJyUrRzMUMjGYSJxev
    D+UZFjhrRS8B/kVLgTLeoJ5Ei4zam2XjDnc6pKm4P72xLHD+niqliX1XcVTKQbiQsR4F2R
    Sq3LHl/JD0qLSnR9kovfQmrgSYkW6S9Si0VQYG7juxkUvbtkOBzqIja7YEM21vPF3WF/Qd
    tKoh2jiyo5s+uJvf6PZTBgaQLnrO7eRGaVwZ9bj1LKlO6u9AXSd400zQ1drcMuUWGvDWdP
    TMRw+1/7UcVgzP8L3DSw9Ewo/FK1GCGZVR7x8yMe2fw9++vvF/pOgTy5jxNTFxUBKR8WXb
    wc2a0egxQYKgrvmroccse0L0F0xBqX9+cautM6W0X1JaB83r9F8t17gbB8qR2fNWjxOM77
    K54Ne3GAjSgiwQYKqpmLIsTA/tqvYjLqlOHkmVA5novNy0yjQ8RtxGLCXsm8trOb8+jYn3
    AGVdpNhFZqh+7JspTkDnDjONHc508MVihlKtlktht6+FLaK/4auBN/IAX5Hw
X-ME-Proxy: <xmx:M5gmauAMX8NZulFfbMOeY9TTj0vOHFOQm3tbQcPVoRPhddulJqsYsA>
    <xmx:M5gmamcDwwnwa8hT8oNr4SqVcVLUgeOpEQbqq0PzR3mJ-0msRrfcHg>
    <xmx:M5gmaj4-fMm2nkUhJe8dwLTEnFjXA2jRdaejH-kCCvoDxAx1ermXCA>
    <xmx:M5gmahWPvdfYVCQcw72EA6iS7wxL98-s9g4EvbAxmzHGlZUB1_kiPg>
    <xmx:M5gmagRmGHcHVyARToRk8DBKfgxP-66t07NTOOSyiAeLDC7kljXg26bC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 06:23:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8a2a790a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Jun 2026 10:23:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 08 Jun 2026 12:23:30 +0200
Subject: [PATCH v3 6/9] reset: allow the caller to specify the current HEAD
 object
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-b4-pks-history-drop-v3-6-84ca8e43e937@pks.im>
References: <20260608-b4-pks-history-drop-v3-0-84ca8e43e937@pks.im>
In-Reply-To: <20260608-b4-pks-history-drop-v3-0-84ca8e43e937@pks.im>
To: git@vger.kernel.org
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.15.2

When calling `reset_head()` we automatically derive the commit that the
callers wants to move from by reading the HEAD commit. Some callers may
already have resolved it, or they may want to move from a different
commit that doesn't match HEAD.

Introduce a new `oid_from` option that lets the caller specify the
commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reset.c | 5 ++++-
 reset.h | 5 +++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/reset.c b/reset.c
index f88f32d563..5ba9a3a574 100644
--- a/reset.c
+++ b/reset.c
@@ -121,7 +121,10 @@ int reset_head(struct repository *r, const struct reset_head_opts *opts)
 		goto leave_reset_head;
 	}
 
-	if (!repo_get_oid(r, "HEAD", &head_oid)) {
+	if (opts->oid_from) {
+		oidcpy(&head_oid, opts->oid_from);
+		head = &head_oid;
+	} else if (!repo_get_oid(r, "HEAD", &head_oid)) {
 		head = &head_oid;
 	} else if (!oid || !reset_hard) {
 		ret = error(_("could not determine HEAD revision"));
diff --git a/reset.h b/reset.h
index d2f8546844..9387fc7dce 100644
--- a/reset.h
+++ b/reset.h
@@ -37,6 +37,11 @@ struct reset_head_opts {
 	 * The commit to checkout/reset to. Defaults to HEAD.
 	 */
 	const struct object_id *oid;
+	/*
+	 * The commit to checkout/reset from when doing a two-way merge. This
+	 * is used as one of the sides to merge.
+	 */
+	const struct object_id *oid_from;
 	/*
 	 * Optional value to set ORIG_HEAD. Defaults to HEAD.
 	 */

-- 
2.54.0.1136.gdb2ca164c4.dirty


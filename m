Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EE62D23BC
	for <git@vger.kernel.org>; Wed, 13 Aug 2025 06:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755066344; cv=none; b=lcBNclzxjSRyarxXxSjLoBK1JoglcdsCw1x45U0Cf+mt1+oppMGScy8dtFEZT9AHsFQWHOUUoUD2/itPnbmuSlKx98zMta8mpAPSLIn8v8xrylQ7bBTdZA8BcG0EjUoM+3ewqwB1ADztEgoQS3YawxisKKM7JueSBkcQx0JFMU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755066344; c=relaxed/simple;
	bh=uN4mawUoXeRZPR0Sx8+re0vFdisRfDPayV/TZIPY6z4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DY5usbnDm7nJo4pyXWsWs+GHoWwbrj8/tLlcy40OVBtxM3tEBXpqbRQBVJWQOgcoGSqS6Sevvdpw2fn9mYF71LF4NJGMNvcJW7KJkR5QYWw2sOiQSeq09VawFem8FdGSwXCDzNKVkCVJnY4iaj15/JllNNQCG9uPzmPTeY3Z20I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iEta82BO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fIK9zFmT; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iEta82BO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fIK9zFmT"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id E676B1D00111;
	Wed, 13 Aug 2025 02:25:40 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 13 Aug 2025 02:25:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755066340;
	 x=1755152740; bh=uWcNI8xKwrkjeOzb5D+AZqTrISB/EtfC1Go5WIsQ7Cc=; b=
	iEta82BOMrIWo8UEB8R5aO0IMo1NghxxT9Z1Fas3YxmVUbdMScjZ2GNP7XDdZY1x
	AiJPEK3WoTpQlPIoIL0fzodpqAG4u29ia/mwizMfV7bTAko56LZk7nWUukcSPrfC
	vNLEx9uvd1KaxBlHfEhF/f4F85ROfH31fGUDTDgUU840klmg5AE+tDwXS9odnwI0
	IJQe2xbBJYgP3f37e65SI0F3p+nVfdKKssJEO2NpBrDdOvi9zbuCSYHwwhug9nVR
	FfKdOoXBBdXOSgehIcZfu/aexmL76yKS6FMF4gIiZGPuOHEMwx+UQtzoWBQyHSNt
	oQ15OoDnbRb2fPm9oljGcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755066340; x=
	1755152740; bh=uWcNI8xKwrkjeOzb5D+AZqTrISB/EtfC1Go5WIsQ7Cc=; b=f
	IK9zFmTrPCOKL1xL5e4fCdfVNAxp5CxZWLW43UmgaX4jkLEgREHsdFl+Q6YyU/D1
	yPSlCOik3TUA+nQ2zyvDOBeBKquJvAxEkYPxL9tcYxqlgqazmoXkgTIn4jhKJTRu
	Dx/ihgb7OGJNBwm6d+5sMx2zCXOXVIq6VOekOUaxdhchiiSOKwQZkWJaXzWkqGyA
	u5s6RNjNf4jUlGDrqQDIkFclaTO4/LxyVqEvfyMQyTVXw10NECzAQLz6/4EpMjVK
	xS5jVAVPh6zdPJxwc0WNI/oy0Y1seY6bPm6V1Nnyu+NAG4wEmbT1ti/Uvyq0UeXY
	p16Pntog2luQ2SlgjtB9g==
X-ME-Sender: <xms:5C-caG8qHkCeJgecfzOsNIYZXp5qAyJ8W045CeCjcJn_fnyqH9NMtQ>
    <xme:5C-caCNeXmrtJ1eEPGRaXlQ3FhX7ckouExeoAE3OHhoZwht-e2id_hHrPCkzzlVmH
    RIjISVVVF_Ku_q2qQ>
X-ME-Received: <xmr:5C-caCexprpOIIG5H46oZyKtR429gAI2LJKAsk0IhidvCe5kWxgpEFHZhPOwc8NkVRoPhsgtcg20bKRQ5MH0kw948FDo1T1mEWZChShDltk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeejgeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslhgvrhes
    ghhmrghilhdrtghomhdprhgtphhtthhopegtrghrvghnrghssehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:5C-caJU0LJM-VPechh3bXDmpJ98KB1QLOqa-dI9q8UF7Qu6F9-vZfg>
    <xmx:5C-caCibaBQSfy3q_yv4iU6cyMfXes2lNUIPwlna0xq-Di64fok7Vg>
    <xmx:5C-caA9ICbvMu-DgQ2FXONkQhFAppmYYyFidrcvRlgtWWzIN_jPzsg>
    <xmx:5C-caMZp9mBojIjXsMJusy80XxXKoImxeJIg3tGJ_Lpg4NBtt1WKew>
    <xmx:5C-caPjM3Ur1fHGkDdyDGoOEi9GAeNSj1B9GkXazjjsODBQcabM2lfsf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Aug 2025 02:25:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 050ce36c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 13 Aug 2025 06:25:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 13 Aug 2025 08:25:26 +0200
Subject: [PATCH v4 2/8] reftable/writer: drop Git-specific `QSORT()` macro
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-pks-reftable-fixes-for-libgit2-v4-2-42b5544c8e2a@pks.im>
References: <20250813-pks-reftable-fixes-for-libgit2-v4-0-42b5544c8e2a@pks.im>
In-Reply-To: <20250813-pks-reftable-fixes-for-libgit2-v4-0-42b5544c8e2a@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Carlo Arenas <carenas@gmail.com>
X-Mailer: b4 0.14.2

The reftable writer accidentally uses the Git-specific `QSORT()` macro.
This macro removes the need for the caller to provide the element size,
but other than that it's mostly equivalent to `qsort()`.

Replace the macro accordingly to make the library usable outside of Git.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/writer.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/reftable/writer.c b/reftable/writer.c
index 5bad130c7e..0133b64975 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -399,7 +399,8 @@ int reftable_writer_add_refs(struct reftable_writer *w,
 {
 	int err = 0;
 
-	QSORT(refs, n, reftable_ref_record_compare_name);
+	if (n)
+		qsort(refs, n, sizeof(*refs), reftable_ref_record_compare_name);
 
 	for (size_t i = 0; err == 0 && i < n; i++)
 		err = reftable_writer_add_ref(w, &refs[i]);
@@ -491,7 +492,8 @@ int reftable_writer_add_logs(struct reftable_writer *w,
 {
 	int err = 0;
 
-	QSORT(logs, n, reftable_log_record_compare_key);
+	if (n)
+		qsort(logs, n, sizeof(*logs), reftable_log_record_compare_key);
 
 	for (size_t i = 0; err == 0 && i < n; i++)
 		err = reftable_writer_add_log(w, &logs[i]);

-- 
2.51.0.rc1.215.g0f929dcec7.dirty


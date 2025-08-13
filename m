Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D052D1F72
	for <git@vger.kernel.org>; Wed, 13 Aug 2025 06:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755066341; cv=none; b=f6ICkQwe5378Ca9tV3jJqpYQYV1uP9eTwpw87k5xCUWQMpYxNSVw0J3BH076Eg2HzEdVvcrtMKNwGpV/lF3NRRM3KkXr0bpfsX2+DMeUBwhuIxU38BiNOr27qEs2R+nQNkrxy8u9EtDMVikDvq763UgRf6h0yD0X67QJrK1uH7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755066341; c=relaxed/simple;
	bh=9di5cI3F3iMoIwXjFfwutsXIXq8JdeJtLY3TGM6pTuE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Un0dkqa7xeySOqt3Qc8rCGeg+vQrarWzmUIkPgfoRnrogEygeITJi3sWsPTvmXxddTXMT4ZBWe0uFCeT9FI6GLHdnWrDBp56D4rDqDmOmNClVQ/3V2dovMWbwzc9c1Hy5f1PERBeqnS4lc/u3Y2SNU8ql5mawZv+nfzePMNJ1Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MZQAws7h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ASrYTBtG; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MZQAws7h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ASrYTBtG"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 8499F1D000F8;
	Wed, 13 Aug 2025 02:25:37 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 13 Aug 2025 02:25:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755066337;
	 x=1755152737; bh=ZTpO0u4IJ/jZfVC11OXWw2LgSwucErZNUitqaVDkaQM=; b=
	MZQAws7hlRZDKgnVkLp5YN63qQZVpwBNh4QA4QKSVvW2M6sAN/Fs2Erpc/weq8I1
	pWF3NvY9hIQlUKIqQKXXD6ZyJE7pIUNJ54BC8KkCHNSMe8EDlLyqL79ScAAGlS9G
	BfQKv2sa1Gvo67r2ypMQQhBmZoOeTQwvcNP5aQ1GDaZn7XoA3MBSe2JFw/63rcJI
	Mfwgcea2WFqrUKQC62heMOGrSUGC6LYySzpmLtMupuvjAYKM80oJI1jjyg58kOFy
	XhwRQjJmc+LuARtX7jeTrIQNKBS0lSS9gTLEfzMde1hH0C+yx1QudODR6eF6cRmd
	n+UzznQYQIC0H/C81DzYsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755066337; x=
	1755152737; bh=ZTpO0u4IJ/jZfVC11OXWw2LgSwucErZNUitqaVDkaQM=; b=A
	SrYTBtGjpf0Jqpbvo6UqZLge8MYYaMZl5t+Tstkf2fAfrJSZfQ/YmaL3FuO8TU9P
	XcMTLXGmFL/leomuRusCGZOVH/SpHTR9e7iLE2PbuaY4jzVWcMe28RtR5Un+csW3
	chEy4z5X3oJ4XKM6fu1XFWjzmZDrHONY7kz0HI8LBKbNpBC0OBMz2O8UziiSYDwT
	OCKF8Jj5Q0gUHJGNuarflNpyXrOADQIrW/UoMsUCwBIz1TzfjjiWl9/oNNa+zDsP
	qqKnjtg0ouQpNO3OusZCd8HyOAxQLe4aB8c+thKzbRmsTuXatqNdTFNaMb3MYxpE
	0JxSeI1eg4kTTo0LNhrvQ==
X-ME-Sender: <xms:4S-caHdHEPD4ORthhEdt13DgcnGC4q6xzAY7CXrj7eZ_qkzramqBWw>
    <xme:4S-caIvq6Y2VWMSyi3IdLb7WngzwYHlpZs_VpOaKb_j50e6TS9sqWr111lq3BmBmt
    Td0GaHXpwtwHFfFGw>
X-ME-Received: <xmr:4S-caG_pFt3WDRHfw7Zn54ZkPITNkmoemNmTQGmr9oVtEV_0yolNNThRclQYlfWBP3__md2m44nk_yQg_jV8mrniGSBkNMguQy0jClGysrk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeejgeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhi
    nhgvtghordgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpd
    hrtghpthhtoheptggrrhgvnhgrshesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:4S-caD3b5GHW8hix80Dxvup41LS-S3rOMe8BcUdaqbACOHFS8Lp4UQ>
    <xmx:4S-caLCAolH6cB6wNX_FY9It-JyPGLAY9iZn82QI_Te81as44OY5aA>
    <xmx:4S-caPcySFpDqc9DSbw2WdE9HmJhOUO_nHf17wPBjVXj1H-CydJgBA>
    <xmx:4S-caI7erHMZ7yampPsQCOpaKT2bRp_aOgZ4gSZ6NFyOSaOma8kmjQ>
    <xmx:4S-caEK7W07E2Ud2PLe_JzC4XOpok7JdYEwJ87ZlnnV6lm8E1gvjqw5_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Aug 2025 02:25:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 120d7cf0 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 13 Aug 2025 06:25:35 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 13 Aug 2025 08:25:25 +0200
Subject: [PATCH v4 1/8] reftable/writer: fix type used for number of
 records
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-pks-reftable-fixes-for-libgit2-v4-1-42b5544c8e2a@pks.im>
References: <20250813-pks-reftable-fixes-for-libgit2-v4-0-42b5544c8e2a@pks.im>
In-Reply-To: <20250813-pks-reftable-fixes-for-libgit2-v4-0-42b5544c8e2a@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Carlo Arenas <carenas@gmail.com>
X-Mailer: b4 0.14.2

Both `reftable_writer_add_refs()` and `reftable_writer_add_logs()`
accept an array of records that should be added to the new table.
Callers of this function are expected to also pass the number of such
records to the function to tell it how many such records it is supposed
to write.

But while all callers pass in a `size_t`, which is a sensible choice,
the function in fact accepts an `int` as argument, which is less so. Fix
this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/reftable-writer.h |  4 ++--
 reftable/writer.c          | 17 +++++++++--------
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/reftable/reftable-writer.h b/reftable/reftable-writer.h
index 0fbeff17f4..1e7003cd69 100644
--- a/reftable/reftable-writer.h
+++ b/reftable/reftable-writer.h
@@ -156,7 +156,7 @@ int reftable_writer_add_ref(struct reftable_writer *w,
   the records before adding them, reordering the records array passed in.
 */
 int reftable_writer_add_refs(struct reftable_writer *w,
-			     struct reftable_ref_record *refs, int n);
+			     struct reftable_ref_record *refs, size_t n);
 
 /*
   adds reftable_log_records. Log records are keyed by (refname, decreasing
@@ -171,7 +171,7 @@ int reftable_writer_add_log(struct reftable_writer *w,
   the records before adding them, reordering records array passed in.
 */
 int reftable_writer_add_logs(struct reftable_writer *w,
-			     struct reftable_log_record *logs, int n);
+			     struct reftable_log_record *logs, size_t n);
 
 /* reftable_writer_close finalizes the reftable. The writer is retained so
  * statistics can be inspected. */
diff --git a/reftable/writer.c b/reftable/writer.c
index 3b4ebdd6dc..5bad130c7e 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -395,14 +395,15 @@ int reftable_writer_add_ref(struct reftable_writer *w,
 }
 
 int reftable_writer_add_refs(struct reftable_writer *w,
-			     struct reftable_ref_record *refs, int n)
+			     struct reftable_ref_record *refs, size_t n)
 {
 	int err = 0;
-	int i = 0;
+
 	QSORT(refs, n, reftable_ref_record_compare_name);
-	for (i = 0; err == 0 && i < n; i++) {
+
+	for (size_t i = 0; err == 0 && i < n; i++)
 		err = reftable_writer_add_ref(w, &refs[i]);
-	}
+
 	return err;
 }
 
@@ -486,15 +487,15 @@ int reftable_writer_add_log(struct reftable_writer *w,
 }
 
 int reftable_writer_add_logs(struct reftable_writer *w,
-			     struct reftable_log_record *logs, int n)
+			     struct reftable_log_record *logs, size_t n)
 {
 	int err = 0;
-	int i = 0;
+
 	QSORT(logs, n, reftable_log_record_compare_key);
 
-	for (i = 0; err == 0 && i < n; i++) {
+	for (size_t i = 0; err == 0 && i < n; i++)
 		err = reftable_writer_add_log(w, &logs[i]);
-	}
+
 	return err;
 }
 

-- 
2.51.0.rc1.215.g0f929dcec7.dirty


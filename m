Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4550F18A6C1
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 07:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732520331; cv=none; b=tB34np1ftRT0xKq3t/FL9P1B9q/yTLkp1LRyjS9iyY5B73XTwJz4qrbmauLzqydi72W1k63+bJxyuqKDHRN4vWtaQKYzVygxYdlgYck1+DKEYq1pYOantLkSS2Tw8qQVD7Udm3TBt0nmnjzAnejkfar3C3uYtUitaoehlMk9bHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732520331; c=relaxed/simple;
	bh=98VJGSXFesCywwiZLYL7xEMrsR8kF0GOkWH7oksUGIk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=alm29nmnaAcZ/VhF9yWNL0UXV64UAz35PcG8fB8DzCyJKtxS3V21tHF9wE3kcq2ZxZVAvzRjTWxKs/WhIOdsJ/3ulAnCxMEngUkfoXA5+KfHf2/F7cf8DD8OYmBwymaZ9k/LRepol93rUHX3qZdD0GpUF9FyHxNMnwrSqT6uI5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CgN5kRc/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ht393JSP; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CgN5kRc/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ht393JSP"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 726BC1140166;
	Mon, 25 Nov 2024 02:38:49 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 25 Nov 2024 02:38:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732520329;
	 x=1732606729; bh=DY2czddyHJeCOFmz4pgFQLiMfzW0D9GHX2fXky+hNjw=; b=
	CgN5kRc/TQxA1nM602IGpZ69SHRaVV5BiRR79DR9u195Y59AyIO5d7Sejva+aiY9
	nKrdB2etmQvDV0kDVM2zpU9B54dlCeISVKejV0GtOWiCxUuF1xWRHI35Hsisw220
	m1zt2YCrjkziLXiePH1N06a8Hxo6n4PPu5POc/QV4YoGMbkjTtE3I/3a53deA+Qy
	6nzBDvjlc0RNjmEAdkrv9Xr0ss/x/FYUEuf75A4/GFyxXgx/BdPy+MWM0N1wvVSC
	EKn7jS2Fa0rBisAZvgrQYPjY08jgBgQkm5qT2Dx3DCDVS8DBvqoT+Wt9VEFLaEZz
	2JFqJ4rvB5Pb4sKvCJHMTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732520329; x=
	1732606729; bh=DY2czddyHJeCOFmz4pgFQLiMfzW0D9GHX2fXky+hNjw=; b=H
	t393JSP1p8Hmy99FuMsR0342KTJRZnNl+r5nCFqPTnAHv3frrBV/CBlJoBUuSTIv
	1syXLSfNLjxHKrnjRLGMISUpgywTQ3bDKH5nWPnZ/p+9/45ep6TK0vbph4jd2sY6
	GFDqf78MHbsQ17EkX5Kkq3pUFrv8xb2A7Yg/g+eyAkdXvPEZtCNp6WzjTaUiWBH+
	rrgGCUivL6XzE1dsbx/a9TQ8OuKnYmw56oRIV2uoEDsyu3JQkiZmez0I1O2iZla8
	u63ZlKuykamuCMjUbZ7GFGqr2777nsdOW2mxQWFkVFQioGbHSThIxSgkKrT8rdNv
	ddyp1Zj9ZFZi7ReKCUjyg==
X-ME-Sender: <xms:iSlEZ2NtFmkuit0uIcf2cGOdgp4uJV-COdCKg30yz7_XKEb_NJNv_g>
    <xme:iSlEZ0-hDd6g86m7qCO7qNz52GG6X1k5eCGUyL5hNVQhGuNPiy09DtmSj3fVozSGz
    xw6A_f5QMFlPCejzQ>
X-ME-Received: <xmr:iSlEZ9QA7_h0ShHna9Y2qA6LkvOPwQR1jWp9a6jFcdEnm0cTecZ8hEUwFvdQjpRgQ0rZZ_6yRs58uIPgyd4CXj3IPzo7ysdxN2kppbbx-u1GMQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeggddutdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:iSlEZ2s-1ZhBCx5Vr_xOLlDpcmtMpJiDQ3YW46n7XfJ-aO0RJ8kuaQ>
    <xmx:iSlEZ-d5xzmwRR97F3j0Q5qfmTetQkmhPZfjGuQIx_PYLexk7FbYSw>
    <xmx:iSlEZ60NTwXcZOtYqFtLa_9oizsJK8wRtbiL-vg-cqgpCpZ9so7QOQ>
    <xmx:iSlEZy_SC10kKAuALrNARHiaKt9ae4I4cVKBGctWRCpDeBKyYsNfEw>
    <xmx:iSlEZ-6bWBs2IOeynRcRtFafF6z2twddcN9zfSuUWXhrlJXX1XWVXf2W>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 02:38:48 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f8ef9e8c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Nov 2024 07:37:42 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 25 Nov 2024 08:38:29 +0100
Subject: [PATCH v3 7/9] reftable/stack: add mechanism to notify callers on
 reload
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-pks-reftable-backend-reuse-iter-v3-7-1d7b658e3e9e@pks.im>
References: <20241125-pks-reftable-backend-reuse-iter-v3-0-1d7b658e3e9e@pks.im>
In-Reply-To: <20241125-pks-reftable-backend-reuse-iter-v3-0-1d7b658e3e9e@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Reftable stacks are reloaded in two cases:

  - When calling `reftable_stack_reload()`, if the stat-cache tells us
    that the stack has been modified.

  - When committing a reftable addition.

While callers can figure out the second case, they do not have a
mechanism to figure out whether `reftable_stack_reload()` led to an
actual reload of the on-disk data. All they can do is thus to assume
that data is always being reloaded in that case.

Improve the situation by introducing a new `on_reload()` callback to the
reftable options. If provided, the function will be invoked every time
the stack has indeed been reloaded. This allows callers to invalidate
data that depends on the current stack data.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/reftable-writer.h | 9 +++++++++
 reftable/stack.c           | 4 ++++
 2 files changed, 13 insertions(+)

diff --git a/reftable/reftable-writer.h b/reftable/reftable-writer.h
index c85ef5a5bd14595d75f99457fef4407040e197c5..5f9afa620bb00de66c311765fb0ae8c6f56401ae 100644
--- a/reftable/reftable-writer.h
+++ b/reftable/reftable-writer.h
@@ -68,6 +68,15 @@ struct reftable_write_options {
 	 * fsync(3P) when unset.
 	 */
 	int (*fsync)(int fd);
+
+	/*
+	 * Callback function to execute whenever the stack is being reloaded.
+	 * This can be used e.g. to discard cached information that relies on
+	 * the old stack's data. The payload data will be passed as argument to
+	 * the callback.
+	 */
+	void (*on_reload)(void *payload);
+	void *on_reload_payload;
 };
 
 /* reftable_block_stats holds statistics for a single block type */
diff --git a/reftable/stack.c b/reftable/stack.c
index d97b64a40d4ad05cfd9e6f33e8ba1e713281ef6d..5384ca9de0d1f064aebcb09308a74cc397b37463 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -548,6 +548,10 @@ static int reftable_stack_reload_maybe_reuse(struct reftable_stack *st,
 		close(fd);
 	free_names(names);
 	free_names(names_after);
+
+	if (st->opts.on_reload)
+		st->opts.on_reload(st->opts.on_reload_payload);
+
 	return err;
 }
 

-- 
2.47.0.274.g962d0b743d.dirty


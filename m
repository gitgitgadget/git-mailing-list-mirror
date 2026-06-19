Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7BC17C203
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 11:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781868512; cv=none; b=WsyntIWvg+hEoDz9YRpp1sFq7QJgKeBXygtnDkxP7cvU4rObmXbnZBvq2glEc768Eg8UBadC9Ktls3DZe3UNUe7k+fhxgCOPy5FszkPQo0y7eRiYIdbbIUblIkzVULHRqV9Rc1U32NQ37fWpVa7SYGhPErHmgMXxOj2AofVtFO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781868512; c=relaxed/simple;
	bh=yxjegufBDAFvGg865Rx1jHGWjdbbQRmBo1MzXeYmLME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jm9Co6VJedFSULNH6/Wyysqqt96EhPy6WpKaQTxAytDAn3VrAN/ZALa0o9RQaUMFOQDk8GuIoGFAVh/CginMhDsT7D5B1qbpFkkGBJLNCx8dKwhl6XJJ9SJ2uud+jbErxYDg7BWE8Jj9wkNfd5WgccvUSYIKk5A94z9UmiD1gH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Z6IzHwCF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CITCLZb3; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Z6IzHwCF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CITCLZb3"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 7163E1D0015F;
	Fri, 19 Jun 2026 07:28:30 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 19 Jun 2026 07:28:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781868510;
	 x=1781954910; bh=kjqx60BiWHDuD5/E5kv6ePnVLZte84eAHdGA22Uy9yE=; b=
	Z6IzHwCFh2McsbD7j8+hWsC/1DFWFV/bM+KYr+2PfQ2xkhWSLR+ka85eDjBSnXHc
	bfVXIQX15TppULx4TeK/QmhMejsYFVJhp3W/Az3J7ecIdHnebv8KQk5Nm8cfLQ2M
	FqVCMk+FfZKtXnELP5DphUWMfudAHs8MT9HP9VjSl4H+nBPr78F330+iq/pAmiBB
	alXHGR5IcGnIAg2IPkFxVjGfMITWpT0BE7Wb7bT1Cd9N8QzWVtTK0puT5XeCWV29
	400bB8cf3Cbe/NFPGkxZWFyyVrEFvWSyE5Qtr38pQnXVNDwxwRTCl4Dzp0UjLEKH
	63hNBMjleGd4/d9KcH/uOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781868510; x=
	1781954910; bh=kjqx60BiWHDuD5/E5kv6ePnVLZte84eAHdGA22Uy9yE=; b=C
	ITCLZb3Mla5qmovlbie4tfj5WAfstrqNoHPiNVSjoIzulKR3Kyys0iMRGOWtQK84
	HihP5SBcEh2M/RIzAqtvsYioZYR1efLfmBuufBISuhZ5iaPZggdS5enN9dJVBShE
	3KQn/dywjGHV5QJUMeSthlScMCNH9LchIujv4WtJ4PRn+HWkZyWDnKbKoQv67cGi
	KpGgqoyPUQ5efYgmGjpAOEvwRBDon8oN6j/k54jQtEbx9EkYqfIY0bU/GfRblzLK
	eq8TRXmQiL/WreiPPkT98EGi5fy/4nTxJ5l2xZ+0OsxovEK55CVcoduoATWFpQk7
	qpxD//uOrIIoGyBF8YNFg==
X-ME-Sender: <xms:3ic1alz97pcmVGWcH8FvO3YI5obz4b98j-Yogk8denmOtOt2VSGxlw>
    <xme:3ic1asRIYSTF_GqbYv4fZvhl7TrGXNIY_T6efneXQ1uuMM2untCS1bcmF7rdgV-vL
    fas3wts9NrvoM1zXCeR2qoYWGaDCldLux40wdyHFS7Lvmop6_wSqg>
X-ME-Received: <xmr:3ic1akUhZl8meNPoYq3_IrRV9qAsylRJULb8sQ5MTn4lsQ8ktypLTW-41C4I8KPq9ANkyuvV7ABcx72pl23-A6Uaey3prrnu4D0-V-sVMZk>
X-ME-Proxy-Cause: dmFkZTEde8rkG7Ow/YQajJOxpUKYHnTWdG0AUznTDLiHmSMbSqWzB/6nKIAIdk1nkTwS0K
    C8jTqdNp1V7h/KMFCwexCiiwcxkUoPM3XGMXsNXnEqixWMufecGwaAXNpfHOfwmwhgziKB
    gEME1JUhRUF4zEWjEcolbPL4SS80OZZVhDQXhaESCZsPSITOIFAzr9mdv/wwDKbMEUglz6
    Lrw5108LV8TWN60J1S3iQg3WXtzla3Zx7Q2iJ+qofdJhYzq3vyVO5Ie87s6Y7SykEWxrmz
    /vmzMKfUyKVDBOQcXezzDDbfTiNE3Vevxi8qzYGVvv3v5UE9OxNTzNX4wxQEWsT+cwQAj+
    3CvfBtAIn7ffKHB/J3QnV08D8O9LxCMIaAIeHnc2EVCqheepLcU3DOCOMExcXC7urHEUEf
    LBKq6fC+jvHEIRnA6eUsyr22pq4oJpfQz1gD3V4FYu19fdrTgV6hS8bXCAU+nXUi38l4lv
    UTs+8FmCqHrQDVLAuxS+IOTDls4sQvprRPt7mqXkJcoDf3H6NVT6EDAVA1Dq4YteJupB3B
    NZQoja8UsC5k5Csdbbn6wDI7FnF/jKhix6fBNz8UlV56UEIHXROmY2MeyhUZY65IT12m7L
    OaNwSbHyw3JvWzhR4JqCRzxhWhG4ws1LRiYOXOIwJ4SrOmoJbY9m4Yl3qEIw
X-ME-Proxy: <xmx:3ic1amY2HLv1AFxjFtxtYVgVMFAbIONbBe2i0Dzn9-MiHFhe9MjUKw>
    <xmx:3ic1ai0DLEug7dyjK7sY9N6x7hSzPOyOmq_IA4MC2sqEIqN2vzKxZg>
    <xmx:3ic1aggWqs6AxBj6bmNZ6e90t7kguaNKFB7WS8_ZLFNUr6U3Kpl6bA>
    <xmx:3ic1auakgZWdDjUCtpoJuTiBwwET7dGek9j2czBCBAhQ7D7dJDMFzQ>
    <xmx:3ic1aoajwasqxiEnS2L5F6S87HkXK-8lQYTLcBD-aHdDCCX_9Fo1wln4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Jun 2026 07:28:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bb350f22 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 19 Jun 2026 11:28:28 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 19 Jun 2026 13:27:58 +0200
Subject: [PATCH v4 10/10] refs: drop local buffer in
 `refs_compute_filesystem_location()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-b4-pks-refs-avoid-chdir-notify-reparent-v4-10-a6472be7acc4@pks.im>
References: <20260619-b4-pks-refs-avoid-chdir-notify-reparent-v4-0-a6472be7acc4@pks.im>
In-Reply-To: <20260619-b4-pks-refs-avoid-chdir-notify-reparent-v4-0-a6472be7acc4@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

We're using a local buffer in `refs_compute_filesystem_location()` that
is only used so that we can fill it and then call `strbuf_realpath()` on
its result. This roundtrip isn't necessary though: `strbuf_realpath()`
already knows to use a single buffer as both input and output at the
same time. So all this does is to add a bit of confusion and an extra
memory allocation.

Drop the local buffer.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index f242e6ca96..582dbeff0a 100644
--- a/refs.c
+++ b/refs.c
@@ -3570,8 +3570,6 @@ void refs_compute_filesystem_location(const char *gitdir, const char *payload,
 				      bool *is_worktree, struct strbuf *refdir,
 				      struct strbuf *ref_common_dir)
 {
-	struct strbuf sb = STRBUF_INIT;
-
 	*is_worktree = get_common_dir_noenv(ref_common_dir, gitdir);
 
 	if (!payload) {
@@ -3585,8 +3583,8 @@ void refs_compute_filesystem_location(const char *gitdir, const char *payload,
 	}
 
 	if (!is_absolute_path(payload)) {
-		strbuf_addf(&sb, "%s/%s", ref_common_dir->buf, payload);
-		strbuf_realpath(ref_common_dir, sb.buf, 1);
+		strbuf_addf(ref_common_dir, "/%s", payload);
+		strbuf_realpath(ref_common_dir, ref_common_dir->buf, 1);
 	} else {
 		strbuf_realpath(ref_common_dir, payload, 1);
 	}
@@ -3599,6 +3597,4 @@ void refs_compute_filesystem_location(const char *gitdir, const char *payload,
 			BUG("worktree path does not contain slash");
 		strbuf_addf(refdir, "/worktrees/%s", wt_id + 1);
 	}
-
-	strbuf_release(&sb);
 }

-- 
2.55.0.rc1.722.g2b3ac350e6.dirty


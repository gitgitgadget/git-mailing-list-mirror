Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4971F1318
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 10:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735296442; cv=none; b=Z/jW8sbLkMIcaIWMWa9dhihS0MKuPbl1EWXmygUkjledC0po/9h9b5VQOMQNgAfGacOcQNwUnsICADI+WMKZD7GLI2m+JZgCxjeKWwwBaDIT2i3gMK2EyAhUocGayC+08KdsOnfZBNv1yHO0rvWbKIdmmhW/GJ7O3/Au9C7akcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735296442; c=relaxed/simple;
	bh=6xVxPtbtC+2Y2SHomu4gdtUQExVWPnWx6rlpLB5LxRg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M0XJTrtt4sQPogI7vC2vmZYDm2vR3zAbCyuYnnQbp5w0t2IBAXhbmGAPgRTq2r8wtRWT04lbEFI0FSS7ZZ7XVqb3oaOXFmkSIMoC4QFl39I640+1zZedyXuX26P6IUe0xHc4vEejHJku+R07zYVHAkdpSDQyh7M+U8PvkQbQgsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YtmmEhUh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yWg7F2n+; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YtmmEhUh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yWg7F2n+"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id A31AE138017E;
	Fri, 27 Dec 2024 05:47:19 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 27 Dec 2024 05:47:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1735296439;
	 x=1735382839; bh=/5KdHv+h8Ku/y6CIc5v5ba7jNIK+0Vg5OI6fTAVMoXQ=; b=
	YtmmEhUhL3Yk7Z2XRJqUieTGEYYDZQXxr4pVKE7a32aw5GCJwadDICJ2jqsfKoBh
	EwmvafGDETg87NqG3+wJzeWu4uG2XGeS1YFacx0MOAOraGQkjEUy0ngWA33ncPmt
	kCSklMny/66tJsAke5oFyT8cNEPdBNJcBY/ydHl11jiWJ1Al2keCnHC7XxXaLcOQ
	3TIIWgi3Gk3Rl/cfYSxHfukkI50MOplfEpoIoXdNcWs8qiXocXJPZW2nhAoP+w08
	TduZU0jMkZ+uIUc9/jA4UOfR7wvYT5AvyZZh+L62P0UocohjxQqJvXsml6wRPmXT
	DRi1/eZKt1MidDXfo+yJnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735296439; x=
	1735382839; bh=/5KdHv+h8Ku/y6CIc5v5ba7jNIK+0Vg5OI6fTAVMoXQ=; b=y
	Wg7F2n+xpdqgxfLgI5UmjRjJpEyQg3e0S0Q1ukK0yxQb7o9DmoHc7O3TVynzREvT
	nc2ChhLPv0VI7AqoZotjZ3djil4IgCzCMIohwH7mw8VM6MX5HCbcEKmUZrcujRF5
	9D7vzz1jNIGMqP1AG5UXM6oZ5kKWgtrgnfRd8aOL4i1qjIEa67KF0wSeBz5p17zp
	+4jGsddVSGuZM+sIN7h9hod7xS0gtpMQ/GG3hBZEKqBE8sTXjPMyYK83T0nE7fi5
	Xt6kkDgJ0JxuFIOXp9Q5GsQua79VsXeRVGkFCc4yabT6wCPlk4QjxrVnEnkrJImk
	i0nHEa9I9KjSyvagI/tgQ==
X-ME-Sender: <xms:t4VuZ8BiZWnSYjgcaTefw4fxTcndEAHCq0kDTHx5M2pGPTNTH6HvYA>
    <xme:t4VuZ-in2cckmT-VoMc86qpApnu-Ato8JtMdfls0p1P2adbIL5s45saskcvIRg50Z
    6RDJkf3Kc1u9Tif7g>
X-ME-Received: <xmr:t4VuZ_lFx5VLY16K3bMWL7N5Gc1Px22_L1LAt1QWPee2wJzqh__XrmQ0QjCpRQr10KeDNn9LdzWYOi65iYo6Tympl-XXiN7MS11iMIJo3rWTIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvtddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhf
    sehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:t4VuZyztJYMoapNugHprX2HzctByuFCk6GAXZAvhDbEZb8m6-xc08Q>
    <xmx:t4VuZxRID_O8uCfbqou40KZeR1pv0VUanMWsMd7LK1S3wlFPGmCQGw>
    <xmx:t4VuZ9ZEmoMLkWQ2MHwZQe0_OhR7gAe4WXWMpaNFdPj4mLOZ1Ie80A>
    <xmx:t4VuZ6QkbR7R4FMTADUIU0j1EGya0l0ty7GAbkYLzQWk6KQTIdQ_wA>
    <xmx:t4VuZ8fDa2ZYgHREucu6bnbBv3v1uKIr6u3oQuLOPUvQQE1Ev_XDX9yn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Dec 2024 05:47:18 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 64bb6045 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 27 Dec 2024 10:45:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 27 Dec 2024 11:46:23 +0100
Subject: [PATCH 3/9] commit-reach: fix type of `min_commit_date`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241227-b4-pks-commit-reach-sign-compare-v1-3-07c59c2aa632@pks.im>
References: <20241227-b4-pks-commit-reach-sign-compare-v1-0-07c59c2aa632@pks.im>
In-Reply-To: <20241227-b4-pks-commit-reach-sign-compare-v1-0-07c59c2aa632@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
X-Mailer: b4 0.14.2

The `can_all_from_reach_with_flag()` function accepts a parameter that
allows callers to cut off traversal at a specified commit date. This
parameter is of type `time_t`, which is a signed type, while we end up
comparing it to a commit's `date` field, which is of the unsigned type
`timestamp_t`.

Fix the parameter to be of type `timestamp_t`. There is only a single
caller in "upload-pack.c" that sets this parameter, and that caller
knows to pass in a `timestamp_t` already.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 commit-reach.c | 4 ++--
 commit-reach.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index e65872617003d0e43776909c30343f091d6b42f2..9f8b2457bcc12bebf725a5276d1aec467bb7af05 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -780,7 +780,7 @@ int commit_contains(struct ref_filter *filter, struct commit *commit,
 int can_all_from_reach_with_flag(struct object_array *from,
 				 unsigned int with_flag,
 				 unsigned int assign_flag,
-				 time_t min_commit_date,
+				 timestamp_t min_commit_date,
 				 timestamp_t min_generation)
 {
 	struct commit **list = NULL;
@@ -883,9 +883,9 @@ int can_all_from_reach(struct commit_list *from, struct commit_list *to,
 		       int cutoff_by_min_date)
 {
 	struct object_array from_objs = OBJECT_ARRAY_INIT;
-	time_t min_commit_date = cutoff_by_min_date ? from->item->date : 0;
 	struct commit_list *from_iter = from, *to_iter = to;
 	int result;
+	timestamp_t min_commit_date = cutoff_by_min_date ? from->item->date : 0;
 	timestamp_t min_generation = GENERATION_NUMBER_INFINITY;
 
 	while (from_iter) {
diff --git a/commit-reach.h b/commit-reach.h
index 9a745b7e1766850a77fbe52c3eeae290b68038d0..d5f3347376b6310727c74b81cb7660485b96c0bc 100644
--- a/commit-reach.h
+++ b/commit-reach.h
@@ -81,7 +81,7 @@ int commit_contains(struct ref_filter *filter, struct commit *commit,
 int can_all_from_reach_with_flag(struct object_array *from,
 				 unsigned int with_flag,
 				 unsigned int assign_flag,
-				 time_t min_commit_date,
+				 timestamp_t min_commit_date,
 				 timestamp_t min_generation);
 int can_all_from_reach(struct commit_list *from, struct commit_list *to,
 		       int commit_date_cutoff);

-- 
2.48.0.rc0.184.g0fc57dec57.dirty


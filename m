Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7EB1DE2C2
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 10:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737022129; cv=none; b=rw63MSCQgoQ4qgZCGqFzEHfj0V/8tMpow+Itb+3jCeSUqPC/rWsyWBXGSpHku1lqCC2sYb6xI3k78wlO9+yVyWN59hSZS1MvDOoynzcbuqGCmrKV5cQy6G6YCyI1M7NzBVznHvr8mbJxFWgYuZwAzM++XFO7Y4HrQ6JA65TJdfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737022129; c=relaxed/simple;
	bh=yu3OJLwsFWZRZdFNmbWSBDgGoNf7atK+Yz954hbU/LM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RLjsgtiHx/T14nUCvrIb2YCRfMESbAsycRJGubdNVK4EU5+LYr5ORHk1KFZ0SMg8i2qDhD++M4nlByEXw5qoEu+8BJwqL3HQ51z0Uz5DRI6GZy9/P6IgV+zLSDvj9AZkttdHqM1fGZLdYePHHW9KpnqzU0HdzQmjapaoWFyUtis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TW1fxl29; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qrVoT72p; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TW1fxl29";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qrVoT72p"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 5648C1140192
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 05:08:47 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 16 Jan 2025 05:08:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1737022127;
	 x=1737108527; bh=WaoR+k+6DjARBBtjMn9106/s4+VHDkUvuAKjlisjXJY=; b=
	TW1fxl29dvDeuVhKpT+I22lD8ZUyvzY05P8oHPm+Ek/lDXVDNIyiIV7GR7U+SDgs
	vEqeaDExo249N/66WokJ6f+33XkUsjVUT5AdoUY8UlJ/HyrfK41aIYvA7ilzPSH4
	+0coMjQNKoWfvYesldTpNqtRKg8t3dKZ+JWuFL6/DVfa+qLMkjYK2Gu7UNlNtVXJ
	3e7Ffq/bu5GcQ6FYe8b0kVh52Mi6CXeKYo8kkM+ZdXCYFpKUhkuVCUWlQu0AK/Ts
	1OnH+XlvdnKxtz5t98jp3+/B1TzatinNUdcQktBEc1oO0NDBOqAQ+fBUTl9tM4pa
	z5sDMBwbBJix/+bpDpTI8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1737022127; x=
	1737108527; bh=WaoR+k+6DjARBBtjMn9106/s4+VHDkUvuAKjlisjXJY=; b=q
	rVoT72pJUrfCVNvk30n2qx9LnILpU2Q/+k3Hm7qUao7mGjR+lsG2IoqXfjzzmYVo
	oZhjj+dN6wQVbp/l0OCI7rQNcJzMFL7bQnLKCPFg0BeSvd0U/26ey5lUITDfhvu2
	9tdRyvQEXLxpdY/AUIVJSVRYVS2dVer3ETRJSNM5/KRQlc8M1R2dFFOjF42F39Dr
	qWFdF62iBnZ5aXohmA9I6kUVaIzb4d9H7dq7Y7uFVwk8V3N6O/sJnw26KDvDyet3
	xo07bI+0nRKPOpenfPFCrNxVVdVOZCZG3PPCWEpbe7zClcI+dNIKLQvnV5t6PmiW
	epsjyFRMQKavAx4kiuqXA==
X-ME-Sender: <xms:r9qIZ0DYpi3QvMKJprM3TH49XXK-8iSRdISD2AZadZ_3XLpSqdDHfw>
    <xme:r9qIZ2ivSXm92EGFIluguTZj800Bt2jMJVvjB26uKlUUmxex_osXw2DL67lW-NKH6
    _8eAnvheHgAyV7b8Q>
X-ME-Received: <xmr:r9qIZ3l3N7MifR96H4DBsVDEBP7neJ_5S-Vwm5YM_qqCo_X_V0Z9Z-eELXUWLjR7La7uVbEERN14atqQrKKFqrJbAI2STlJyvKvoAl7-AeEEN3mkcQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:r9qIZ6wAZHofEKynOyMKJuJvDhTAGWgwuMLryKoQSW2mJjspggwVOg>
    <xmx:r9qIZ5SVAvjPpXOS1EKnXOrSDiIyDQJL9zpOPfFzKYd3SbbKOK-Fhg>
    <xmx:r9qIZ1ZE06hKT2L3ehh4TKGExZYIk0DKP1AD8njcNlXv4oCggizZKQ>
    <xmx:r9qIZyTuPrcF3EPpxHOO570kMj7g9s9kBd7oH2q7TN8xBODeLHIU-g>
    <xmx:r9qIZ4L1geuiC_wGDjD5mha5TwVRllLowpO6HbwHrTg3Q_zUvbXlz5B2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 16 Jan 2025 05:08:46 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c9d1158b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 16 Jan 2025 10:08:46 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 16 Jan 2025 11:08:39 +0100
Subject: [PATCH 07/10] reftable/block: adjust type of the restart length
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-b4-pks-reftable-sign-compare-v1-7-bd30e2ee96e7@pks.im>
References: <20250116-b4-pks-reftable-sign-compare-v1-0-bd30e2ee96e7@pks.im>
In-Reply-To: <20250116-b4-pks-reftable-sign-compare-v1-0-bd30e2ee96e7@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

The restart length is tracked as a positive integer even though it
cannot ever be negative. Furthermore, it is effectively capped via the
MAX_RESTARTS variable.

Adjust the type of the variable to be `uint32_t`. While this type is
excessive given that MAX_RESTARTS fits into an `uint16_t`, other places
already use 32 bit integers for restarts, so this type is being more
consistent.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block.c           | 12 +++++-------
 reftable/reftable-writer.h |  2 +-
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index 1275085257..8ac865ce78 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -40,16 +40,15 @@ size_t footer_size(int version)
 static int block_writer_register_restart(struct block_writer *w, int n,
 					 int is_restart, struct reftable_buf *key)
 {
-	int rlen, err;
+	uint32_t rlen;
+	int err;
 
 	rlen = w->restart_len;
-	if (rlen >= MAX_RESTARTS) {
+	if (rlen >= MAX_RESTARTS)
 		is_restart = 0;
-	}
 
-	if (is_restart) {
+	if (is_restart)
 		rlen++;
-	}
 	if (2 + 3 * rlen + n > w->block_size - w->next)
 		return -1;
 	if (is_restart) {
@@ -148,8 +147,7 @@ int block_writer_add(struct block_writer *w, struct reftable_record *rec)
 
 int block_writer_finish(struct block_writer *w)
 {
-	int i;
-	for (i = 0; i < w->restart_len; i++) {
+	for (uint32_t i = 0; i < w->restart_len; i++) {
 		put_be24(w->block + w->next, w->restarts[i]);
 		w->next += 3;
 	}
diff --git a/reftable/reftable-writer.h b/reftable/reftable-writer.h
index 5f9afa620b..bfef3b1721 100644
--- a/reftable/reftable-writer.h
+++ b/reftable/reftable-writer.h
@@ -84,7 +84,7 @@ struct reftable_block_stats {
 	/* total number of entries written */
 	int entries;
 	/* total number of key restarts */
-	int restarts;
+	uint32_t restarts;
 	/* total number of blocks */
 	int blocks;
 	/* total number of index blocks */

-- 
2.48.0.257.gd3603152ad.dirty


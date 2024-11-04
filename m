Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092DD1C07C1
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 15:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730733120; cv=none; b=I7BPLwlnm6awDRXnaFM24KhXrL24a/E5ZkPfi5EuHEp90h7yAWw46aImbCIYuYsJraxN4tcEpCPe8l4+VDsDc9TLUPeHkNvjxmJF4ffEev805TKoxdq9D+Fpw3RnVCSjm8W56lwL97wrNsbW1Zf7R+j05V8Yx/yCvkpwoDIrxH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730733120; c=relaxed/simple;
	bh=ZZ8wTp5prx4nJm1xEhq+AcqA8jqA+8pNJODtE6oYJN8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GtVmnWc24LzsMDVjo6LaxyrpVNT0qG+BEZMF8YJs8KBSfEdhvDyy3dawbjEyWji/IQIKvf/VnLKnk3MbnLfJJnH3mdkZfyBblqb3qV5J2W+UkxDGAXDjhxrpb8Y2lfMBvaCXEz5ZnOSH7iNQxOlw29Kkh0EVMmyp42rD/aHJMV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZrvCK4Fr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cG/S/V53; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZrvCK4Fr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cG/S/V53"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 59FBF1380229
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 10:11:58 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 04 Nov 2024 10:11:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730733118; x=1730819518; bh=mhJP8fjTGu
	GdDYsum51xfbWiY+WMM3H2pOttuHhbyes=; b=ZrvCK4Fr3Wy9+58ic7BBjSAsSo
	Rybe+diYLwYpXtx7szS8fGwiZLiXQnfy/Tv6DEPZdXcz8z9zoy5VvTNp2bIln/Tp
	aPBwz1DksGFCoeE4PX1SYiyUNHq7fon4rcbuq8jgvRyS0Iy4Wg4pUKaYdFir49a8
	EhlHmpZcM355VEsMXAEPObZbHqORSeuIDnVT6EAWBhwOfBoXhToLBNdBSNwhcqgP
	spGejsBnO8NmlujfVmiSW/3rRNjooturO2mDfLFBqbgKzo64MFbXbUCGBdW7e+o1
	UKc/HKATk1LY3IWE+J1srL6Fc3jDol9nJjhl5shGX36T90hMrhLxSGA3M2hA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730733118; x=1730819518; bh=mhJP8fjTGuGdDYsum51xfbWiY+WMM3H2pOt
	tuHhbyes=; b=cG/S/V53Z6B0WljrelGfQj438UjUPidWtL6tNslW/TB0ZdKb6ra
	QIS+E0Y+uduVNijaL9EH3ob3JPxYl5UTNozUqsylgRHWx/APpuhbtSPNIU507Zc+
	YEtHWukTbQdV+klRMxkoV94Tg82mf9jbuPG9Zr5jgvK0SATXvsQ0Ve6UJljp26Go
	PiohYPXb/NA+YAAfS0kycqwU+vqyIM/BpLtuqCd8mml5zHa8IEO0bjY0KjiMSd05
	pDSLbFdMe+dYJORAeYitXQB4CsLrW8Wzabf4wz0TkV6KI3e5hpA6oojD+I6breYH
	U9os0S8BosQdKEo5xtPz2vqGoe+CPGG8Eig==
X-ME-Sender: <xms:PuQoZ1s0qXj48Ex-JiaWrp1XyRU3IUiFqFyQ3Y-mhAS_73U3CdO_wA>
    <xme:PuQoZ-co79qM_iGu9bMUltwA9f6NxB0ftlqYTczAYvoGPKJbP5eqeXHv5dJjYkS4T
    tiUPdQSfFGgOqlAGA>
X-ME-Received: <xmr:PuQoZ4xM6BRQRAI91_aBqbQX861jqHtQ8hCpHeFW0ZCXXYqSpZLGvcWwEESewmfprHdNdRzjVQLtUtEywF_BH0a2nVH8OXVg4MWE2InxobRCMp0lzQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeliedgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:PuQoZ8PLodmvdTCm5vkBhWPif8nqxWXbHMApub-pOw8RkrrTgNLFcA>
    <xmx:PuQoZ1-4_DSDnLT7vO6beDRae0sru7_jXt8DmyLGz7HkaqdwqP-TUA>
    <xmx:PuQoZ8V2uncQ4hivOuXKMrngLJhUUm-1Y-flQEnIK_3PnFY0nTnbBQ>
    <xmx:PuQoZ2chU0ffWG703eoNxAXD3qL7rPpGRgr_U5U21azAvQjsQjHqTA>
    <xmx:PuQoZ3ls7zaUCqoA8uKwg2koawh4_P5wsSSJkcnQqY7kau3BkEhOUedL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 4 Nov 2024 10:11:57 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 076449ef (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 4 Nov 2024 15:11:37 +0000 (UTC)
Date: Mon, 4 Nov 2024 16:11:50 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 6/8] reftable/stack: add mechanism to notify callers on reload
Message-ID: <0a294b577f915ccc901c6cd5e04f05ef24f34b15.1730732881.git.ps@pks.im>
References: <cover.1730732881.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730732881.git.ps@pks.im>

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
index e4fc953788..d027f7070b 100644
--- a/reftable/reftable-writer.h
+++ b/reftable/reftable-writer.h
@@ -62,6 +62,15 @@ struct reftable_write_options {
 	 * negative value will cause us to block indefinitely.
 	 */
 	long lock_timeout_ms;
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
index 530ba2d927..f943fc5b85 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -539,6 +539,10 @@ static int reftable_stack_reload_maybe_reuse(struct reftable_stack *st,
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
2.47.0.229.g8f8d6eee53.dirty


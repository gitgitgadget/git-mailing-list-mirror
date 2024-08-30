Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE899170A3F
	for <git@vger.kernel.org>; Fri, 30 Aug 2024 09:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725008960; cv=none; b=bgfbFOV03qZcWaRIoc4Vbds2PtgyKZHwoc04+DEN2qxUhX+JrQXG46NIPyHb4QAd9x9aXnSjaXJo0PvEaWRgMmZOAbihK405DdTCr8YQ6zkcJ/PFPDyx+JG12aETHCzIQT0tr0oqSpkfIJhkEw05RPAkoIzeWWw1rvPs7m3r9NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725008960; c=relaxed/simple;
	bh=JoD51J+JOJqwnkiD/LyF2hQOEb4TAbVQzeoNTbQX55A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WgQkg74P9ObJ90TpDxzYsOupe72vFZwoff/Adlvr6kbQi39W+vJ2hk1/N2nKjc6AiKqiKbGIAR6wA1Zdv254h/+aR4FWgwLykI+pBeFtEWJ3xdFLFX3pITqIe5JA5QLq53G5yONO8Peg3/fsYH/HMlMIYujl/Wf9BAH7qHeoYEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BqH+XowC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gBpM6bcP; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BqH+XowC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gBpM6bcP"
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 27EC4138023A;
	Fri, 30 Aug 2024 05:09:18 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 30 Aug 2024 05:09:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725008958; x=1725095358; bh=OTItF557so
	uhcXA4J1+3V/q03k7S7/YyyAAQEVNCS4U=; b=BqH+XowCCwmLfS38ur9siUoZWg
	cl+x4+pDQm4rh+a/Pk9zsuaJdEse+/Q3rBsfmNaYMxL2UXC5KYWuOwtKCIsqXpYF
	ah+PvVD3zsj4s/PFnqQSmNsze+9qduF5CNynS2dLjaeCgCmZ5pF+FIj7/JKZvWmj
	EmDNer2yn60hgiu+Eu7RciH7t/XYrWTkJ4EAwLiLfzTqPw8D+i0xzENYIK1OuTu5
	jRiwoZbVIMLI5J3T7sUF77qTv6BKZI6Pel26NwjlOjN9vV2XzeEpp/SBALQ5nxkb
	b/glm0+2vSrcw+or9+3PHXGNL5BkRnPHOQtAECbq4vVLV03Owzp3pmhseEHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725008958; x=1725095358; bh=OTItF557souhcXA4J1+3V/q03k7S
	7/YyyAAQEVNCS4U=; b=gBpM6bcPdVwa4dxSxPjwyWtc6s+xuRugmKiKzbNYoqOl
	VSoNAkye3hqkTZ1YS2ewgCPYqgVklQWZWqskgagzTeBJmHMauLZpjDN9RjXKZEFC
	ZwMYITe/+eWaJgcYMMZZDAtYhdbzqYbEBCjX9incV48cRr0RoSgk4nvaCG8WIZB1
	p4LZltYLjY8u4rqwvFjSYSuUe2nySrmLVByjIkOw3WrYdACQCTglgD397kDwABxu
	htV362Qme/Mozo33xsSOrhA9bZb+wRjcUbrLe4YV2ofCZkpyZMLxRiu01OnXn4An
	4EjHRP3Um/2NsXDJlngBW4Ouu9XLDajT5jU1hkV+EQ==
X-ME-Sender: <xms:PozRZt4EO7pKrAfQ92jk25EVWZu6PHQSomS9bED8jTVWvcWJsqEDaA>
    <xme:PozRZq6iHpo7sbYbKaPYZkPWLzAsmncvHlTN4YUHObhSYV6Ta59wdp_L-eTSWF3ma
    DA54GCc4dWZ6fripQ>
X-ME-Received: <xmr:PozRZkfw-_gJgOmiGqNt6bl5JSwdMhugAIMSPCDtNrEE7a7nb_u0ydtMhLUFmtB-6xLgGKgOz37taRtwoJNaCgg8fOCGiJgRZCg4puVagtnMrkiX3A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefiedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoheptggrlhhvihhnfigrnhesghhooh
    hglhgvrdgtohhm
X-ME-Proxy: <xmx:PozRZmKEfLVBTjHVd093rqvwNI9uz68U-gG2W6m2n2fXl_Q-O7xdkQ>
    <xmx:PozRZhIukGcJF1D08nHQWiZMMAJQ3uYAvosJQgdr0VPgylLL00Ae2A>
    <xmx:PozRZvxlRjerHOGYYInfcHpGpbFIb2cch76vz2OKz9oanup-YRIS7w>
    <xmx:PozRZtJlh8cEo_jpjUSXBJX0OJacl7b7bIwWIliim4FHzD4oM49ZGA>
    <xmx:PozRZuEc_UrXcyjzMphs9aTFcKxS_qzGgBGk-HD7LQCID2CU1TMpr9Yz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Aug 2024 05:09:17 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4c89eb75 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 30 Aug 2024 09:09:06 +0000 (UTC)
Date: Fri, 30 Aug 2024 11:09:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 07/21] config: document `read_early_config()` and
 `read_very_early_config()`
Message-ID: <ec4804a99bf70f9a97d1faea60bd55aaa97d1b80.1725008898.git.ps@pks.im>
References: <cover.1724923648.git.ps@pks.im>
 <cover.1725008897.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725008897.git.ps@pks.im>

It's not clear what `read_early_config()` and `read_very_early_config()`
do differently compared to `repo_read_config()` from just looking at
their names. Document both of these in the header file to clarify their
intent.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 config.c |  4 ----
 config.h | 11 +++++++++++
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/config.c b/config.c
index 0b87f0f9050..a8357ea9544 100644
--- a/config.c
+++ b/config.c
@@ -2234,10 +2234,6 @@ void read_early_config(config_fn_t cb, void *data)
 	strbuf_release(&gitdir);
 }
 
-/*
- * Read config but only enumerate system and global settings.
- * Omit any repo-local, worktree-local, or command-line settings.
- */
 void read_very_early_config(config_fn_t cb, void *data)
 {
 	struct config_options opts = { 0 };
diff --git a/config.h b/config.h
index d0497157c52..f5fa833cb98 100644
--- a/config.h
+++ b/config.h
@@ -192,7 +192,18 @@ int git_config_from_blob_oid(config_fn_t fn, const char *name,
 void git_config_push_parameter(const char *text);
 void git_config_push_env(const char *spec);
 int git_config_from_parameters(config_fn_t fn, void *data);
+
+/*
+ * Read config when the Git directory has not yet been set up. In case
+ * `the_repository` has not yet been set up, try to discover the Git
+ * directory to read the configuration from.
+ */
 void read_early_config(config_fn_t cb, void *data);
+
+/*
+ * Read config but only enumerate system and global settings.
+ * Omit any repo-local, worktree-local, or command-line settings.
+ */
 void read_very_early_config(config_fn_t cb, void *data);
 
 /**
-- 
2.46.0.421.g159f2d50e7.dirty


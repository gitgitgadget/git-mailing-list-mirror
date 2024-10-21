Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7E91E32B7
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 09:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729502896; cv=none; b=FThQw0RB22gnjqR4EWf+2u8Ep+k/i9BiIfM7ktVQj6dCOlPQvlBQmn6tBc1uPLt0jhks9Z9IbsvqdKgqe1oLRRm+8hfrp1eFyQ9Eohl8osk5Mb1uMrEEB2il1fVgQl7OOEo9dVSKdL2GwwXZ9DNkpAV/NAsrpGJlhpIY8s98WBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729502896; c=relaxed/simple;
	bh=NK/MCqC/OBLfOutgfCpdP1DJO8djVpJvzwDUXAAIv30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXNdJWo07onjfDZwPB8SGUhF6H0LIcbU73YDDprlvRhj2CkiYwzqowXRiOWXq2JodeRc8GxY1oS0neRAckx85o5J5x/cNT/3tgG0ceLje9+sl5QQgIdKwiKF3QrUU29AqQqb5WvLChjOiSEChSF9CCStNxgj9pwgLLj95Xp5cNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YfVR6+ww; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gkon7I+a; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YfVR6+ww";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gkon7I+a"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5D0191140234;
	Mon, 21 Oct 2024 05:28:13 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 21 Oct 2024 05:28:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729502893; x=1729589293; bh=18pBriPVSE
	COFiQaFKdE1JIDU37ak3bibCZdrbp8LIg=; b=YfVR6+wwu7h460eaCAcfv9cfnO
	vQEqSmDMCZ9l2CC7XbaOW3UK6g4RP2HCHJQFTdIQF+ok9D1gqfdpljjiaWIvnSqV
	UJvvxxv4iZ3zJxW+tfAUnOIKbWRW8/7JlsLbdDe7G3x+wErZ7L8E83HRDWv3ujbg
	sy7+Dt9Dw5ZX2Smlmsnxpj9MBNDk5RlWtNjAVdu5kGBiAQ5jOucCSCbn+DmF2thb
	lS3pCDPWqBioNuHcPoKhvA3ijYUSNuqFT/3AeN+LVnmifqCHXU4URNBNlIkDR1lb
	ou/wtDjruhg1hjLqvi9Ss+8wJyOJmdYSMc0K/wPdc5yMNUcV1Gy3bKmyXz3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729502893; x=1729589293; bh=18pBriPVSECOFiQaFKdE1JIDU37a
	k3bibCZdrbp8LIg=; b=Gkon7I+aOHCYhUcHG/dZ3lfJGCU9dARHAQHuSEKmWbFu
	zJbg+wf/gXj/gxQLzz4YJrKosrKlkgm7WiZqU/NGZIRy91oGcNjWj83ml32eg6Xf
	iR27aorj6N7B27r7UgDFJ31iEptuwW60xHWUqLNgKOCzpAcNVEMDvN6XaSEMNKDt
	21/nICK6pgc79hOiPZMP0ml2OMQ88M5+Kex7g0SiarAnCtVxaHOz55sZDzejN/TF
	1KMQfWiUelOhAcZjoXX24W3wmYH6Df+cvwMp3fvJFiLI+l1YTAasrbsN0Rx8GhxZ
	uTsvp3UxpnestfdNHgO9zgQ24BP7FRqgT1w8z/vw8g==
X-ME-Sender: <xms:rR4WZ9IXNRoN3hbhevtRH9oaGU2NZgFSVfCPD-kOclm-SsQGJH35qg>
    <xme:rR4WZ5LsjzUXNGt0jj2pMNayiPBSbGzOuyrgC0UxQXEmmYE5V9fUyGHBenKA2WFLu
    0u0K1IEfcXhT5wzUg>
X-ME-Received: <xmr:rR4WZ1s-y8ZBeYl8b0eE9anqe_XPlG8seXkfPzd3mVuP_uHSC4-N22lFO0lFUWVBeAK-nMMnghMj3EPjHULmEEtwzYCr9l-VyiqbOMuuyN2C>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:rR4WZ-a6VukSC7Ugl-MeBgRU5KLEVabTJqaf6qERBDJlOz_ONloljw>
    <xmx:rR4WZ0b8I0L8QCdem098_dMqSAj04WoC8MRWyZB4EJXBROzZ1U4kpw>
    <xmx:rR4WZyDqZ0N4wGHFMR-kBZ47pxlsGUQRzLcySsRiDcEvz120lpQkSA>
    <xmx:rR4WZyYBtRd38O9bes8wc-rezniDSZHyajPRd5lQ0O00_pBJ0WhERg>
    <xmx:rR4WZ8FzF9f5G_HSk3kjADdliyazAw9GzM5uFGu0qtR4j0lplUAT3-Nj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 05:28:12 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0c418afa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 21 Oct 2024 09:26:44 +0000 (UTC)
Date: Mon, 21 Oct 2024 11:28:09 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>
Subject: [PATCH v2 03/22] grep: fix leak in `grep_splice_or()`
Message-ID: <cb4eee37b4024a451a385f94ad57e7278e542de7.1729502824.git.ps@pks.im>
References: <cover.1728624670.git.ps@pks.im>
 <cover.1729502823.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729502823.git.ps@pks.im>

In `grep_splice_or()` we search for the next `TRUE` node in our tree of
grep exrpessions and replace it with the given new expression. But we
don't free the old node, which causes a memory leak. Plug it.

This leak is exposed by t7810, but plugging it alone isn't sufficient to
make the test suite pass.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 grep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/grep.c b/grep.c
index 701e58de04e..e9337f32cbf 100644
--- a/grep.c
+++ b/grep.c
@@ -756,6 +756,7 @@ static struct grep_expr *grep_splice_or(struct grep_expr *x, struct grep_expr *y
 		assert(x->node == GREP_NODE_OR);
 		if (x->u.binary.right &&
 		    x->u.binary.right->node == GREP_NODE_TRUE) {
+			free(x->u.binary.right);
 			x->u.binary.right = y;
 			break;
 		}
-- 
2.47.0.72.gef8ce8f3d4.dirty


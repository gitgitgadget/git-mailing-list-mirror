Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFAC43AB2
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 14:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724162557; cv=none; b=tB0YXS64pJ4Q5Z+XEEEJErgoYEudg5H7LUfwdWpksnsqdM2I785bClHK5emCzcOjlzCuSL6/rEU+Q+8f5C4HKHF1oWo45nBKb1F9jNBng5NEGcFl5aUxw6zipeRXhP8PZpPCQeiv37Z3Jh6Y/kgXivCkDc7g8/xVWoLrNowtSqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724162557; c=relaxed/simple;
	bh=Vwx5bPW3d0FgCACMzBghkZ8siqhOv+H2PACrJiEeUMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JgN8tP7+v7a9Z2pXB1NVT8bF00lMKKy1INuVplzRhG5eJJ8Vhs5GOLnpg1A+uyA2YJNPyGQHh4Uooe22PlJC1Mn/EKYjg/kvImxDMK7cQh+mQxDQYyng/nOujqygZ0b+DDwIP1gIHUDaYVp9fPPMn8xcvpuUn1C3iEhKdFF3g1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=j/P3+Srv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XESiTFLF; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="j/P3+Srv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XESiTFLF"
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 88A7311516A7;
	Tue, 20 Aug 2024 10:02:34 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 20 Aug 2024 10:02:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724162554; x=1724248954; bh=9ZuWZc2XVZ
	SVvtJohp0pY4H6XS8y6mRT955Kou/RDl8=; b=j/P3+Srv0kcu+7a0YxPqQKXalx
	cLh/u2ubhvEe+shaf5GrEzfj+2tC8rrb3GJCRhMbOnB4Umw5KEC8ucTJQGe0l0YZ
	x8PcRQbHq3hNOBleRXDgjy8lk+5fMlyQops4MqGllrRmWz3K0EKVO0WpzX3P3Vyz
	0JSe/QikY1gKmjC1RF6dc8hv+oXQ+x3+eti40iLX2vgDBvzMnvudQhdq5sJmChO4
	TAKBZfte341n5jkkGsPqr0T2t5xhArp4Ht1o2pEKlf1OeA5WIBLacEQG1rpMzoWC
	TzNmReFsk+ClGa9kmY6yfTXxFxfcb92fwrf8g5DimkLhBTH8eAb/tll/HhaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724162554; x=1724248954; bh=9ZuWZc2XVZSVvtJohp0pY4H6XS8y
	6mRT955Kou/RDl8=; b=XESiTFLFPZj5iRn0TPU9dBk+9tfCSN9fwAL9ojb3LVZo
	H30zrjngjoGHQ6ha56PVpNydL2E7Qbxh9iRxpw7RJl18IPke8F6wCIAT4+fA2SVQ
	cDkmptA63FOjIqgjzAASx1ENoYcG5fDSCdR0X1H2OscNgy3M7FtVPRAOlWp7bRnD
	ze2xGrMnyiq8TGyoanH2/RWIuLOdZrfUgbL6ZhRWJII0aygtGqWiq5fAQ57Yc/Dl
	9XwRIq6YNBr1zNCjxhK42NINzQXiM++sHucWOhBTVqQ1Ib43MARWYFCsp6AwaVNz
	C3RWorgMmbeGVsZSsv2M32CuQj8gPWtJAIAmbItT0w==
X-ME-Sender: <xms:-qHEZulYZh48b3cCaixepbxc2CLSrqz-1B3QjKgN74rgZ1mMyjfayw>
    <xme:-qHEZl1NNzJfmNfp9K9I2Tik_1YQqjRWyn_pPmqLJLNYzysMBS82v7UHZGYVUgqbJ
    S5cQzZNVRyWT-o9yg>
X-ME-Received: <xmr:-qHEZsrWKQCDWJMraz6tXqXnTsdxJ8vKf_3Ob1Gl8JAAuiQR9wtHpvPvaPP1myi6K3KFjtv7wX8pGemed_nkhnwShrzbTsOnwxZOHrlki_Kn34Zk1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduiedgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdroh
    hrghdruhhkpdhrtghpthhtoheprhhssggvtghkvghrsehnvgigsghrihgughgvrdgtohhm
    pdhrtghpthhtohepshhpvggtthhrrghlsehgohhoghhlvgdrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhgrnhhnvghs
    rdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepshhtvggrughmohhnse
    hgohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhmpd
    hrtghpthhtoheplhdrshdrrhesfigvsgdruggv
X-ME-Proxy: <xmx:-qHEZilc5RsXjcl51vTgz2tSC5OgXPEvdLWgwiQOyAlntVIjw8zpjw>
    <xmx:-qHEZs3XhLGdiuONUGRkX0gXEZ5GApwk4rx6v6UfX82PDdGKk55xww>
    <xmx:-qHEZpusVCdaTXIi1ijia8hc7a_emEIisBe1wB1KtrwB4Bw2qQucqA>
    <xmx:-qHEZoVRos0OgbdQtUQWi_RSku59J8bqVXNx28zrnYzdfkte0mQYUQ>
    <xmx:-qHEZizZnR_4BpNdKGOrPpZoVb_IeWFfuCHkAse58HrSKqVTfdxe7U5t>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Aug 2024 10:02:32 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 82723cb4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 Aug 2024 14:02:01 +0000 (UTC)
Date: Tue, 20 Aug 2024 16:02:30 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v6 07/13] Makefile: fix sparse dependency on GENERATED_H
Message-ID: <e0dcbd5ca833481b2b08ac3355c70ab18e78e77b.1724159966.git.ps@pks.im>
References: <cover.1722415748.git.ps@pks.im>
 <cover.1724159966.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724159966.git.ps@pks.im>

The "check" Makefile target is essentially an alias around the "sparse"
target. The one difference though is that it will tell users to instead
run the "test" target in case they do not have sparse(1) installed, as
chances are high that they wanted to execute the test suite rather than
doing semantic checks.

But even though the "check" target ultimately just ends up executing
`make sparse`, it still depends on our generated headers. This does not
make any sense though: they are irrelevant for the "test" target advice,
and if these headers are required for the "sparse" target they must be
declared as a dependency on the aliased target, not the alias.

But even moving the dependency to the "sparse" target is wrong, as
concurrent builds may then end up generating the headers and running
sparse concurrently. Instead, we make them a dependency of the specific
objects. While that is overly broad, it does ensure correct ordering.
The alternative, specifying which file depends on what generated header
explicitly, feels rather unmaintainable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 28742a60964..efd305ab358 100644
--- a/Makefile
+++ b/Makefile
@@ -3254,7 +3254,7 @@ check-sha1:: t/helper/test-tool$X
 
 SP_OBJ = $(patsubst %.o,%.sp,$(OBJECTS))
 
-$(SP_OBJ): %.sp: %.c %.o
+$(SP_OBJ): %.sp: %.c %.o $(GENERATED_H)
 	$(QUIET_SP)cgcc -no-compile $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) \
 		-Wsparse-error \
 		$(SPARSE_FLAGS) $(SP_EXTRA_FLAGS) $< && \
@@ -3295,7 +3295,7 @@ style:
 	git clang-format --style file --diff --extensions c,h
 
 .PHONY: check
-check: $(GENERATED_H)
+check:
 	@if sparse; \
 	then \
 		echo >&2 "Use 'make sparse' instead"; \
-- 
2.46.0.164.g477ce5ccd6.dirty


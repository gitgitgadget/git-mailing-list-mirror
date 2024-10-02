Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6201D0F4F
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 15:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727882150; cv=none; b=O6gdVQP1pCb53e6YUkGN1T7wcQvn67Z9yFbSyu259nr/ycb68OlgEgSMXuOeHOjnTebSDS5kRovpeqRqdbZn7GYLrf4A7Ah5Ruio8+2SZFGVjYhGahZuvjeRO+mgtmUC/Fl3GohmzEMsf59f1ARkpfDLPe6YIzaN/cnV3+TQ28I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727882150; c=relaxed/simple;
	bh=eVbs43NP1mC4RM7R5pXL1zG99WYwhezPLboaG9ADTHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QJgCSxpkT068GzmIpKYdmngJht+FyN82i/2hmpmDhUgW48fIZHIOIPGKKA0iVu/3wnNRECQDAEl0pNVL0Sl7wMMS1DIbgEH3T8KNZ3iwfxORexc5aZTg70bo4s5ZBLgKfO+c5B69m1OUOJwC5XWA99OMQNEUA7MAQ375Tp3PZ+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=da097Ljm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oISwTtCb; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="da097Ljm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oISwTtCb"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 30A531140185;
	Wed,  2 Oct 2024 11:15:48 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 02 Oct 2024 11:15:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727882148; x=1727968548; bh=WkxW6K+UbP
	Ihpy+k7WTWT4mYjjU68qRJkwtsc/Quf+k=; b=da097LjmUkuQ0Gw4GFpY5vlE88
	Gp6ACdFl3icIPwPU58EowEOI0NxkmLAMIlWJ6io4B0IyevIrYS+2DdFbFftSgVc1
	mBMDkro8Lhp6ZAyHCJu9fHTcTaLm9ZzXym4e29luxjkaMSrA6S6m8aUDcwj1plV/
	n6A9wOfQssDSYWbrhRtJ6euxyWEncHks+Rj0FOaZClblpgbND3LfZYSzDEL8okYq
	uwAZeU0XuRxdwkJSkOjFH9iMxoGicilCO8WuCyCT4LiQUeRX3HM4u8WiUAIojPCw
	d11kQulW2nxFphXukgb9ZLko+X76AvkKTy/tWBRKiI5F/8rPAAT9997B62lA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727882148; x=1727968548; bh=WkxW6K+UbPIhpy+k7WTWT4mYjjU6
	8qRJkwtsc/Quf+k=; b=oISwTtCbZqsLcopvzNWngvIFYYBebFR2PUYw2nEz+30i
	r1H2H/KErJJ8cK/c3maHUs3fCV/NvBLrHy7qrKm2BhKaQ6viiMoQBYpcVcO9QjxR
	J5pDJFgRF2KGMpcD4pet8B4DoJmrCAxOTQRsD4QpIqqKAEE9SeRwaQRO+8OtlN6Z
	RjC9AcysSCJUPx9cI8FPjdb2G364Hsw/raew3oVkYLvk+mjW9OjWg8dyNNpk81Tf
	zpM+s9VN79jP2gClS5Hy81OgwecSwFZGzNMGsM5wzGTwMfDVmjei7eLrNZ078Z7y
	SV0uXlyEMdUPyhBveL/s6ovQ2IflMRrthVsWloVixA==
X-ME-Sender: <xms:pGP9ZndYvx5xU5zxPgLTG5krG8Go2Fs38RdI1yhCI88bT_1sDiVHbg>
    <xme:pGP9ZtOwnQj4QBjCj41j5DJImpQXz4F5840RIt2xCjbadOHGu4H4d9DW2Lj03sDhg
    RuFGzItGY_6bBUutA>
X-ME-Received: <xmr:pGP9Zgg05kvLabb8tJzuOqpEwSWDSvBeiN6PpBZ08QWZ0u7idt4GVfSC6KvyrGG9VM2u2wg6C9xeZDEl3C61Z8XxRZsdAMnOxRxEAs7OGrFa_6yt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:pGP9Zo_DBlCK8MtfmKDTz2crZWfrpXiRorQSr5NnlIp-obioWhysTw>
    <xmx:pGP9ZjuCq6wa02zyhb0MIbgjczt5UOrT2DFaOfVB8imsCETnfrZKxg>
    <xmx:pGP9ZnERUlVq4dn79T5gLz89K4mFlckDimPqXIw4ka1FKiL3nd1S1Q>
    <xmx:pGP9ZqOEZpTibaU3Ukngy9kt8DbwHWpeDbbaCXhh7e-FsPKo_4qUCw>
    <xmx:pGP9Zs57UPz8MZAreODdeX314s4fXLqTkDSynuZBucLQpWgEJ_jJ2sJj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 11:15:47 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8db4104b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Oct 2024 15:14:57 +0000 (UTC)
Date: Wed, 2 Oct 2024 17:15:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>
Subject: [RFC PATCH 04/21] t/lib-gpg: fix setup of GNUPGHOME in MinGW
Message-ID: <b5c116396da61f44057fbb5a8abcefe7ab1b67f4.1727881164.git.ps@pks.im>
References: <cover.1727881164.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727881164.git.ps@pks.im>

In "t/lib-gpg.sh" we set up the "GNUPGHOME" environment variable to
point to a test-specific diretcory. This is done by using "$PWD/gpghome"
as value, where "$PWD" is the current test's trash directory.

This is broken for MinGW though because "$PWD" will use Windows-style
paths that contain drive letters. What we really want in this context is
a Unix-style path, which we can get by using `$(pwd)` instead.

Adapt the code accordingly to fix tests using this library.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/lib-gpg.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index add11e88fc..3845b6ac44 100644
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -6,7 +6,7 @@
 #   executed in an eval'ed subshell that changes the working directory to a
 #   temporary one.
 
-GNUPGHOME="$PWD/gpghome"
+GNUPGHOME="$(pwd)/gpghome"
 export GNUPGHOME
 
 test_lazy_prereq GPG '
-- 
2.47.0.rc0.dirty


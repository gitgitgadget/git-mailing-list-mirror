Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A29319F113
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 14:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728485783; cv=none; b=uWlw6wJYv+Fa3AnDkr4ln2FyOWyYLidicOXVEwovWy/cYfgXZJg33LHvSLhMBbP7cXBAK9lpDb84GiSTyR8ocSqNhyr/y45jNQR8G1cOywI0asGr6kS+54OQflh83KF+NHhIyBCyox8T1y7N0/KyTajZ8y97bJHBzBBd6sSwmVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728485783; c=relaxed/simple;
	bh=sz8+FJfbDJEmYGlSsULuVY4b5/VYRLAVtiLICeNnSbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r0LQ1Ik3t46z15mmYqg8uByJu+xTHuGoC/EdV6tM4LqGfAeGytdxd7SygMRrmTXmXPWsYi/zs+3lHAzv6ks166W/X1SvnS3SOpUukuM+m3JFFLR9QLRU+whQv7gjryMiy4mp8IY94u/YLOqHgLNZAJDxLH2pLApsS8qAPx03ZEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=L9PFqjIF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Dn55+29j; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="L9PFqjIF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Dn55+29j"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 8911313801AA;
	Wed,  9 Oct 2024 10:56:20 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 09 Oct 2024 10:56:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728485780; x=1728572180; bh=XbpwAVxM/1
	jpu5o6notWdip+cxP/ESw0hvmoxD/VpLQ=; b=L9PFqjIFsXiJyXTmbt02CCOBG4
	S4icda0y4yWvdK5NtFCUw9v4H05kZNZdZf82Ws6bOCAi9LOUULSabeeITD6sjCjx
	CVOJJewhkSfxmRWMBL8GDXvl/qi4yrSlmrR3q5WGdUxi0H33KQB+yzAnxL1tFc1H
	Y1pM4hQEFAIJizAlbIrVwEmz7oSZSlMH+hbCqBgTJt3POn2dYevEYIX4wiAF88vI
	EQYifGpjhkDvfRmEbsZv5Y8QoZbcCDqTZweVY5yJdBpUPgIGwLjvOCSngxMLdSZV
	x3OO06AvArHMMFYeiw5qKH4da9T4QzSUdWcVhnUV/WHxncOTuFznaEZs7apw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728485780; x=1728572180; bh=XbpwAVxM/1jpu5o6notWdip+cxP/
	ESw0hvmoxD/VpLQ=; b=Dn55+29jPLyQwzmco7p71Q244pzFQP+v776vVbabYm/w
	lxnjpzBfIib/viWxZaTBYjzmm7REUMvCkIOF1ZDPQgL6ddj4taKl8Q2qVpbcsnBe
	31CPuM/IJK0Ts9YlZ9/LY93ryZJ77HOBMMU3BgfHAZk12qIvMdfAu1rSlLAUiW23
	zY2ZL+xqeNR16RBa95BMSD+7ol1o/7urQ6FvK0Qfdc6Xz02UIW4I8IE1zEsXoEpg
	VuXquvMvNMgB8Mwt2Zx+ZVe48ZKKmW4gAkgmhdpflJpjdydBpf5lIbdRF4o4rkmq
	/X/6EXBypiibIAr+9luLAsOMhylXuyuvTnuRe7kj3g==
X-ME-Sender: <xms:lJkGZ-YR7r4JpCu0n7agRn6j4PoRkiYZXjOYygpnZ-JBUZrososbJw>
    <xme:lJkGZxZfcGsH6USllm7a3KsxuW5IczOFwVhN6iNmlXN1Jp1QS-0ZlFmTBDdta0DDB
    j24Z9X7KaO3eJ5E-g>
X-ME-Received: <xmr:lJkGZ4-Y7mdG43ZmmciTpp3xPfg6ukKtRl51faQb3PMA1-cu9-RpRoiiiHZiEtWBn_gyGmSMm1gIdJ9SICNb77mo7ZqMNp6LSjhnrxWxsLT6Mw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeffedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvshgthhifrghrth
    iisehgvghnthhoohdrohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdef
    sehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:lJkGZwrbXoh48Y1tCDegnK88QOBsFmWMKECGIxsRQWUP2S3C3Y6NlA>
    <xmx:lJkGZ5oDqh4pZdA43yPa_WeR5-7DCAcUgFAcF5xXB8Bm0ZOZ8sttOQ>
    <xmx:lJkGZ-SAfiy_cpcxuen7gPBspNh8ueNZYcYX0IlIPIZXvQBUKv6Gyw>
    <xmx:lJkGZ5pKd5a4schLhx5lif81b-oIZv6kGgIcvEQCoGRyCljzJZKLkA>
    <xmx:lJkGZyB-5z-6Q-OA3z1dBQCngBMAsKYFLkHkXV9TuPzPvqxGVyOhj7Z9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 10:56:19 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3df3c697 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Oct 2024 14:55:16 +0000 (UTC)
Date: Wed, 9 Oct 2024 16:56:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH v2 04/24] t/lib-gpg: fix setup of GNUPGHOME in MinGW
Message-ID: <ffb661dad7170759642e4012de169b1db0cbb8df.1728485139.git.ps@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1728485139.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728485139.git.ps@pks.im>

In "t/lib-gpg.sh" we set up the "GNUPGHOME" environment variable to
point to a test-specific directory. This is done by using "$PWD/gpghome"
as value, where "$PWD" is the current test's trash directory.

This is broken for MinGW though because "$PWD" will use Windows-style
paths that contain drive letters. What we really want in this context is
a Unix-style path, which we can get by using `$(pwd)` instead. It is
somewhat puzzling that nobody ever hit this issue, but it may easily be
that nobody ever tests on Windows with GnuPG installed, which would make
us skip those tests.

Adapt the code accordingly to fix tests using this library.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/lib-gpg.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index add11e88fc0..3845b6ac449 100644
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
2.47.0.rc1.33.g90fe3800b9.dirty


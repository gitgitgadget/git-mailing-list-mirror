Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739FD1EC006
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 11:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728992725; cv=none; b=tCkXHROkYMH8zw2Msi/MWTPSEJJbODRGRGJz2KElI6ZPBICB7E4Qxxz1GFy8N1XIZuwVy76QZsbuJEvFKsln99qPVcayxh+19sWDz3l6Rso7n9uZDsZurHNrvH5raBKGJBzS7GGAE6lT60slBiabVnm6YZ/gXFucqfGLUwkR000=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728992725; c=relaxed/simple;
	bh=6wCUDR2uWwl4w7N5YG2d3RdZ2ut+HDil49fwgmEGuoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=diGWtoqgtVkjaibRTpwBjRdQyT8r2LqM2y37MsMyyNXM+rvRypEllSXOsHpvLwGKi/TXuQEl2PLznlLXCqtd0+XaEXKG1x0IBtIeP7piKojU9ypNCAuj+TvHgR4ZjBssSB8dOvWO6p0K3BVG+He2Z/oQ+8bnQNoIMcVfsEe7g50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ESrrGP5g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=auGrdijo; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ESrrGP5g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="auGrdijo"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 797DC11400B9;
	Tue, 15 Oct 2024 07:45:23 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 15 Oct 2024 07:45:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728992723; x=1729079123; bh=jLJmF5/uZk
	1UixwX0/0kRWJ9Rhewqx2nglz2///Euug=; b=ESrrGP5gXdya3CjogNOtvqGVd2
	PdlBW8MojNhMj4c+NibapvVK8ul2j6SSjSjrV1pMcS4riPGfIjjZ3P6pK866MK61
	t48VJllNfel0j/ThOx0qkV9+2WjkGRIyfsiz2MkizeglgDqQeCWInW+AiPJvVfq4
	XcwrrL8pTKwzf5h+w213C+55ChU/oLJYP2+3voK3pJwO5mVRL5/8UOq99d1f34cp
	0XlyTiZzTH6RNeyVr/NuNduoAXSNXjPhNZcAwdzBofSj7fFc+3gvPlGFQJHJmuDw
	F0G3OrIGmqcY/mnJ+ZejssZxa6e/xsi8CgHm9HoO1iW0DstFVGRCpoD/wc4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728992723; x=1729079123; bh=jLJmF5/uZk1UixwX0/0kRWJ9Rhew
	qx2nglz2///Euug=; b=auGrdijo8YzAwpzudyRfGwlxyoyOvZIhg2RD+Qo/sxXY
	kDhWkwvAJ02jIgpfCzMVBgZiLnl/ENY6T04f9lN7Xyk3a5G5w6R0PvB4XUKWTfBw
	hH5tMO7fmiPM6duK01A2uQo7E+Z9yJqJN41ncIVFi73Si3IzxEYfoJIWLvpuQB7a
	f3PQ91tCYQcuI4DgH97+AsUOFo9fhMVQElf2naMFyAZkk6Bh4GvJl0Zbg8N6oB/y
	NvMGVhstlggJWIUVEL4j1zfa6PwwtRlYtiVaVqZ/fwiUN7Lv6xhD5l3DrBZ17QY4
	PsmNj+BES9sglLVEFc19jMfeyyxpNRhTzRFqhIglDA==
X-ME-Sender: <xms:01UOZ4B4L7LNBcuys45FPAllfk9VolSnGybcH4PcnOBVGlpvDaLdNA>
    <xme:01UOZ6hqb-LGpY9cPtZailNwaz0zSgM5CmdBHb5Xw06rikkgrQ7KVMK5sEVWYnt_o
    IDYJVVEIiigMDJUeQ>
X-ME-Received: <xmr:01UOZ7mxg33hLcYfjR2IcRU2CUy6aCu0HZEgEM1A4DJEtBBgyZZ4C2pMoWYk4Z6109IFzVON_BKwZhxneA027nblceClC1MMGMFTZuquo6dzMA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegjedggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtg
    homhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:01UOZ-xNLkyTatQoEjsL7bNkJT0Tdbz9-HJFdDTgn7s8ECXvEyCvVQ>
    <xmx:01UOZ9T5jMPXLeL8hHYtiJAxiz3kusGcTf07sS2w0aYjHRGLKgIWBA>
    <xmx:01UOZ5Zz0ZNSyVzUExZ5kaFGv4Af8XNi5PObwdVFaQGaQ47nlPTziQ>
    <xmx:01UOZ2SM7DIc-4dh7PsbXZrCHedP-qAbFZq6Wd8q6z_WoBtBNnxDSQ>
    <xmx:01UOZ_d1IOk1X6V1VaqGCSG087rhEUImwZAmHPeLivekoJCyR69YESLd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Oct 2024 07:45:22 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 126f112d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 15 Oct 2024 11:44:07 +0000 (UTC)
Date: Tue, 15 Oct 2024 13:45:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 05/10] t1401: make invocation of tar(1) work with
 Win32-provided one
Message-ID: <58691dd652b23f2c630eba71bb9b93700ab66a09.1728992306.git.ps@pks.im>
References: <cover.1728906490.git.ps@pks.im>
 <cover.1728992306.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728992306.git.ps@pks.im>

Windows nowadays provides a tar(1) binary in "C:\Windows\system32". This
version of tar(1) doesn't seem to handle the case where directory paths
end with a trailing forward slash. And as we do that in t1401 the result
is that the test fails.

Drop the trailing slash. Other tests that use tar(1) work alright, this
is the only instance where it has been failing.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t1401-symbolic-ref.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1401-symbolic-ref.sh b/t/t1401-symbolic-ref.sh
index 5c60d6f812d..90af3f955c0 100755
--- a/t/t1401-symbolic-ref.sh
+++ b/t/t1401-symbolic-ref.sh
@@ -16,7 +16,7 @@ reset_to_sane() {
 test_expect_success 'setup' '
 	git symbolic-ref HEAD refs/heads/foo &&
 	test_commit file &&
-	"$TAR" cf .git.tar .git/
+	"$TAR" cf .git.tar .git
 '
 
 test_expect_success 'symbolic-ref read/write roundtrip' '
-- 
2.47.0.72.gef8ce8f3d4.dirty


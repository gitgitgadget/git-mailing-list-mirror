Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AAA1D172E
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 08:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729066387; cv=none; b=nsxJ7wuS8DRFvzdcPIM9ndENnbTao3KnIewXAZxguZ4zTmd3hFSd6Wzr0sRuC3d3MhhvzTOwNw77rCgYvRfGsQq0Q5hq4JKCzxuYlz7zHVXvgQC4qM0sC97LvOnEK9YEykkWMWcLbUR04JHkjKGupIonkzTi6hUZO6D0KDxyQGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729066387; c=relaxed/simple;
	bh=Nqjg2a5IkK6/ZlCxiwMUNx1Yb5gNfNmFkFqUFzpma6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Da8XRxxLN8nsy9WgfI7JWZIbhDFv3fUsazPSYcy5FLevwCtb37mVMOAQvByxBtBnRZRfT4OQ8fVzuyHn2KQx/mNHXQuPDGE5qQhIeHo1mQxUevLjhO0F4TKVOr2vmUrbPBdFSuGC5JIkyhK1kvu3Ud1ZCXgtYkpG1xtnCiGLsYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UI37C8NC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aey99kOT; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UI37C8NC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aey99kOT"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id AEA911380123;
	Wed, 16 Oct 2024 04:13:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 16 Oct 2024 04:13:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1729066384; x=1729152784; bh=tyn/Jj7fgo
	8+SLdCu9RDXNInfdUUAuCS0IFtRuJQuo8=; b=UI37C8NCyBCZYd3NBTj9BAv2BH
	0xh4+dGn/9A8DAWyz23Fj+U2JqQGBrl8cxAOaW3pADWdxnMaj65dUAGUqgfDWGHz
	1j0GREUai+UE+ydBh9sLkY5MmG/SfmnwSJC/8txizXTz/Nx5VDU3GxLS7NZzZ3lg
	autILILJwleb2VOlM5njlj1JQOkZdtTrn/VV/8hf3OT78Gi8LjaYbbagzkZmsbL6
	6c+sr0SixovehR742ON/JGTKlHMsF3XQzwMBvmikvf+pW0pHoYKPyXj+lBOF+UjM
	ArvMfCob/yEY6uq1pCmwvjtdbh7SgxMLRArfTOOnZigwRhBf9j2ZdMw6DgYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729066384; x=1729152784; bh=tyn/Jj7fgo8+SLdCu9RDXNInfdUU
	AuCS0IFtRuJQuo8=; b=aey99kOT5ykZFHbo/FZnrsWDVIM+n0fQd6w71a/hVsgh
	AuS6hGIdOY3/FMA5rSJwJhZtZjh3fAUM/K9wTmlxoZQJ6xrauK0r7Yy716Ifal1I
	msJ9dhVy6CYRR1EumCax0p9+O6jk+ReQnZuLyrQMoko0Ad2iNzJnIxsMrjhB4wU+
	18UCe4v23cB8JWp73aOurg5eoouddbxDNp9kO+EJAAXMgrmEC1HKVjoXW0xmn7ge
	VnOMy0n59Nsp0B4WOMX640OGH89Vw45jDvCUoN9Os+lqTVWJ49YTGTh/pkNnrwFP
	WeFWOKu1Etv1FmHvI+ypEWeABNdjOLwxbjRiQWexBQ==
X-ME-Sender: <xms:kHUPZ-Luz2rudZrn0IP2a6wh0GsHSXxCxcZ4FU9e4OJtk4BK785WTw>
    <xme:kHUPZ2Ledcf0k-HLXNoDZVg87PKhmFV7su3-N6fPatXEqLrbiE7juXtNAZWuduzQb
    rCBX1qtv11plcfQ2g>
X-ME-Received: <xmr:kHUPZ-sTtMi9xbAaVJuwwoUFfh783T4WLwbdeQnqfgvwp3WGyxrFp9lk2s3DNQuhF5A6C-ureCtRg9lWPOhVWtfE5-QzCi3dprhYawaDaMSLKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegledgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:kHUPZzYJGapVQanmRAXYi6sfNVSFtQ7Jxwzi_Zchwl3PiOZqakD43A>
    <xmx:kHUPZ1Y0-3hXd8qCVpybF5CpyLTF1-mOwUg6NkSiN84wAkgaqfEI2w>
    <xmx:kHUPZ_AoKYjU60SR3pn8e37ooRr4ucoQCIGozhp38aEVqsB9dxleBg>
    <xmx:kHUPZ7afK0RrPBk7U5-bqlOeC4XPEuBIJI9khrzpPAQWvqqe1tUKxw>
    <xmx:kHUPZ5G8E_6nfoHzWTPiGx2MOZhwwuBkYGrkT5jTUwhNSG2iCYBd3eQ1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Oct 2024 04:13:03 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b62d43ef (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 16 Oct 2024 08:11:46 +0000 (UTC)
Date: Wed, 16 Oct 2024 10:12:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 04/10] t/lib-gpg: fix setup of GNUPGHOME in MinGW
Message-ID: <89957caf6ad2f3af4b1c7298ba8253f07b9b0455.1729060405.git.ps@pks.im>
References: <cover.1728906490.git.ps@pks.im>
 <cover.1729060405.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729060405.git.ps@pks.im>

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
2.47.0.72.gef8ce8f3d4.dirty


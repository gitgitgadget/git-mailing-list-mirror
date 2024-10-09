Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D326B1A0BD8
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 14:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728485780; cv=none; b=E6bFhLdPN7p8dOgqQ5es7uWOR1pKdANiqF6thCiOzuVMut1aX3xQqOzoXY7RA2PCSxxxH/0JHI3t3ACSrCcwT+BqYmCRHkJXZKzYT36qwVL39dPz2X16HKEGrBhU8/nYbtZlLwizfwwb9C1kzjqgpmJFSXUsvtkzWRknGPZr1Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728485780; c=relaxed/simple;
	bh=aInkWAtxQAUDeI8nwnkEFdOar1euJmQOcvGpr/l+pfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZliofvCzwEUm1vU+SgEyfLiYWsW+LJ0H+ToF5LNXMewVDcE4Hsv1sKw2Ta4b5gLub80wk1cYwGRAwn+JozEHOE6TscnYDOBJqX0x+myLw06eBbinJRNIVzdOoItsf6ZFEWNu/JSfyNB4sPEDc4pqJ3f5kObyt5HJkoN4a6qnLN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pALpf9Nx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XebyEhZ9; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pALpf9Nx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XebyEhZ9"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F39F8114013E;
	Wed,  9 Oct 2024 10:56:17 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 09 Oct 2024 10:56:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728485777; x=1728572177; bh=FVP0Qo1RoI
	s3a407OD7rhr8oZQ/QXTBPpm9S1hNhAjI=; b=pALpf9NxZHs9y1uhDXCW6ISmP8
	I2tlT5xKleRgQwhypNGGNrVm1HeDGdmyQLjk54cmg9hhJKitgsDu8xoxvTEAAYmo
	YqB6LGTPpXXC/PHp1ZUmPs3f0awUnxsQ9d3yLKCLhqBh25bZeD0Cr0VueLsgCXol
	mI97bxY6Rd/XX4nTn/4HJ/kgi/B4jnDxK252BAt77O6KS9IC17q2TY/wWUOI6cmH
	WNJVXLLpZihgntr0yRBXrmL5aHIQhUD2WWyGDR8Mc61w/o32iyIEQFSpmgsuTyom
	WCFsTzdi67Cf2xMCI6y58kXzzlggTAbpbsE9glTpYCOq2AhL3OcqyhfJPtWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728485777; x=1728572177; bh=FVP0Qo1RoIs3a407OD7rhr8oZQ/Q
	XTBPpm9S1hNhAjI=; b=XebyEhZ9vAszpAa8j61cYE42XNhdlD4ZqQ0V3g00U8F6
	2RlZolXFQTatG7XGu+KoLRsNpNc1Q012NVhtOPATN51Kst03FIyljslVqGYzRA5t
	HCPD1jRtK67wOvarPXmZx81j3z72Mj7x/gZ2DQQ+QcVo44kGC40/o4bpQ4koxLdZ
	eVJYjApO2KDZfJ1SPBt2eOkKmYNF+kD/SqxdXtOxvwTShK3G0XFF9BmnAk3E/S1a
	3OX746zY2NHVMlkHtjB63Q10GY/itfDbNogYdHHhS6xNL7D8uqDv7BBgR7qIvcwK
	SRCbpcAwd1FZ1LbJi45glftJcfrSyWQ3eRPACwKoJQ==
X-ME-Sender: <xms:kZkGZ1-vW4wx-rS2eyVHbrlDIp6RDazB28f-GPTzK6_lkU7E1vTuZA>
    <xme:kZkGZ5shI3hqC-VIZGk8uqKgcDfIODeCMScVyHykoP8LnQCX-cU56dQ7SJb2NES25
    dD60QhHHd2VjkDR6Q>
X-ME-Received: <xmr:kZkGZzDpahNs1HXA-C1IpOcFAG9KFXSWZkuiI5jJ6fH9U7Hqt_7Idl4J6NbrLtOsdpjICbBXtGpjd6O_Kk2oX_l60S4NuzRdX9RUUXrWykKDUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeffedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhunhhs
    hhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehphhhilhhlihhprd
    ifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvghstghhfigrrhhtiies
    ghgvnhhtohhordhorhhg
X-ME-Proxy: <xmx:kZkGZ5fVKS8A5blU3FFLGHln-3CeutyQUy1EcafzSSb55-V8ZcpxPQ>
    <xmx:kZkGZ6NfLcDx9lQPKodiDcM28zmB-xXTUkTDkEnO4HVGhy_8vBSADQ>
    <xmx:kZkGZ7nGaJxHsKhw6zcK0de3ifO8FgSJcv1hfQVvW1dgMT9BVqB_jA>
    <xmx:kZkGZ0tkUM7n_sjQjvq40W27Ua_C8dELNGALPbM5a0jlrgPqeRmy3w>
    <xmx:kZkGZx0DLL9XllXUK2PxdcibP-MehHkjeF3f_zV3p0jorl9yYBynZj2m>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 10:56:16 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4244b129 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Oct 2024 14:55:13 +0000 (UTC)
Date: Wed, 9 Oct 2024 16:56:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH v2 03/24] t/lib-gitweb: test against the build version of
 gitweb
Message-ID: <94664e2cc0681856635e13e1e4d5873a5a442d33.1728485139.git.ps@pks.im>
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

When testing gitweb we set up the CGI script as "gitweb.perl", which is
the source file of the build target "gitweb.cgi". This works alright as
long as we run in-tree tests. But we're about to make out-of-tree tests
a reality, and there things will break because "gitweb.perl" will not be
found in the build directory.

Fix this by using "gitweb.cgi" instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/lib-gitweb.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/lib-gitweb.sh b/t/lib-gitweb.sh
index 1f32ca66ea5..c64c87fb87d 100644
--- a/t/lib-gitweb.sh
+++ b/t/lib-gitweb.sh
@@ -49,7 +49,7 @@ EOF
 		error "Cannot find gitweb at $GITWEB_TEST_INSTALLED."
 		say "# Testing $SCRIPT_NAME"
 	else # normal case, use source version of gitweb
-		SCRIPT_NAME="$GIT_BUILD_DIR/gitweb/gitweb.perl"
+		SCRIPT_NAME="$GIT_BUILD_DIR/gitweb/gitweb.cgi"
 	fi
 	export SCRIPT_NAME
 }
-- 
2.47.0.rc1.33.g90fe3800b9.dirty


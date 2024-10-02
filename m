Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228991D0DEB
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 15:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727882147; cv=none; b=R0kclJSWV/LgCWFa4zmC2B3uOGm6xnA4CpADl6VMHMhergoJxNDXGDF2FoQpYxWNM0nPqi0pHyjtrUkEMmCRxv0No2ikq4OW770Or7yaeSrOqI8JhdbC+K+/cVozdj3MaS7thEC54CMTAAzz1kDgZOkTpfkORJbIJbcU50ZDeR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727882147; c=relaxed/simple;
	bh=x+tajcsWuWQHT7Q4jDkKxaI12eqWabEngKVF0IEbeWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tY2sXtYp23RsXBXDSXHSnaGBnsMUyxpfGXDnw3HXkmnjNWsn4RnwIj++2E5Hme6Ow0J8SwbBCQBdjDqstNyDmxvcJgI/Pp4w3IVgPQNTGatl2Hp+KYr9MLN6HrcPS1ba65Fuav2lbalg+MF3a7ZMdLhYZspEeqdVm7UR7YhWsmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qw16r8Bc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VQshqlNr; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qw16r8Bc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VQshqlNr"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1DB651140176;
	Wed,  2 Oct 2024 11:15:45 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 02 Oct 2024 11:15:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727882145; x=1727968545; bh=SK7CQg8Hj8
	Qrp/4+TbJpqN7dK4Ne18qRtY4x12NvmRA=; b=qw16r8BcDX54pqsmDV/xJ/xhiY
	hKQXTXSvFpGRB6h3v6XZOVFfUcFythI/c0Xa0v+ADtJjrCOGzkTszq9UYiGSjMkM
	t6a2FmPm/J17hHHrMcLjqEyEXmmAGlQKNt2liqKCW0PDXkzHgM9KLUFZ9mGG2NTD
	hQ1ZK1QKP4UXml6gVPLtbI7mlZyXfpReBHxkOmB4rREpOlztcHqG3INivp0yP7IE
	Jb5YWQU2q3X63op6zdVe8H6/2lL3nSdiTd6G76j78hhJ6R9G4g4tNHSR6jwGM3av
	jJCPYOCg1mSJwsAjMRuKDUrcBm7/dJ+CB605B06pQmu8jmbqMsH9ZY/HclCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727882145; x=1727968545; bh=SK7CQg8Hj8Qrp/4+TbJpqN7dK4Ne
	18qRtY4x12NvmRA=; b=VQshqlNrhOUbM6ayLkEkmHcrfjnpHuNZci1qJoe1y8hP
	XJRzEoiwB/dUZoj8oObcxN/OhPweZAKOpkTQamagzeaiSEvUbZ62l/qrJVP+a7fy
	Xd4jaoqtCCZiU30bdx5RVb7+W3OpU5bBeB9Nrx6n4lZHJu8WFmvc0UaKID5YE+ey
	9r+BmLr6cah/8qP4RBcqFxEaiXLnZ98TgGG4GNwuasIG6nsyFCU69uyySSIgwN0b
	ZekKJ2EAhQRqlyjzFtKDsrS6uq4eAnjZx/P/jqKny5qN4F3qDjdWVjHk/BOB9H5E
	qomUjQij4XINsXU2uR8eydmW3EZFvI8XL4S6KXAGrA==
X-ME-Sender: <xms:oGP9ZigUH73qDoNRlqYucGpNRaFtGQEUi5dSx6pwqDP_GeKfu94FFg>
    <xme:oGP9ZjChLf9SJ6hvmhBwKgynoOpoFHkSEYdUtADYKokzr8RwkaA2YiXF01UXSITmw
    5BWa0VdgZD_a6ET1w>
X-ME-Received: <xmr:oGP9ZqEZ39TpEx7d8wKm117bAty7tlW_m5htQkjOlySbkLpn68PMAyYyM8ilykq4JDmoTJmKuTIUijWW83IL3w8xogL3rWN0dePhhIGSab9vLCiN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrgh
X-ME-Proxy: <xmx:oGP9ZrT7U5eZd9CK_IMQF-fbAi-OifZIOrGQrND07te3a6pVcMfSHw>
    <xmx:oGP9ZvynGUGpinOwMNE0ma2jsprG-SGW7swZnzdgZm0S69YkKkRuOA>
    <xmx:oGP9Zp6KD6oH-FpR8ttNmaeFNrTD4QTEieKKGNb-P4OiGXeD-Bm1tg>
    <xmx:oGP9ZsyKbZ_ivy5w8_rwrh3PC1Q4WJySYH9njEe7DPWwui2VX-4l9g>
    <xmx:oWP9Zq8429vfLKtFPEgRf0UkXHLdt73G91_uMMmwFFQ5nEG3-6H-vJzI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 11:15:44 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 461fd166 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Oct 2024 15:14:54 +0000 (UTC)
Date: Wed, 2 Oct 2024 17:15:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>
Subject: [RFC PATCH 03/21] t/lib-gitweb: test against the build version of
 gitweb
Message-ID: <be8ba4b96799985a5e102994e75bb135b8073516.1727881164.git.ps@pks.im>
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
index 1f32ca66ea..c64c87fb87 100644
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
2.47.0.rc0.dirty


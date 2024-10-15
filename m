Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99A01EABAB
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 11:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728992720; cv=none; b=rni95HEa+LjVyozSLkoFSNlA37dYDUglJqj/3QwIB8SWw9ZmnpEOYFoQuaxY3PJKRIpNxs/MvwBM/Lh1sX/MKAmK0M89A9F3XJjhRUPHX98SsqWLM2wR2x3BJ/6/EngQaG/qWoae2OpEcNE7+iwpPsElj2FjBUReyIrJGTdOVF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728992720; c=relaxed/simple;
	bh=n0A7Jc9eGhxSM4IzpqM4TS3JdMe3whp3xtYH79sSuFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fAUFlJB660r2dWneSzoxcXoX96mXgaT6KfVM+hyb5UWovCqL06+1Zc4vicHpkF5eSkDVH78WiQXorTr9RPK21g2tQGYJTBnUKYUn8Nl1G3Wr7dj5UrSWYgeVuceP1vOmu5MDm7BJNtpmZl/1oRsTfOK130SLi3WjhoGOOZREH+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=P5Nv9hHA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zcl3JKng; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="P5Nv9hHA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zcl3JKng"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 8EE9111400B9;
	Tue, 15 Oct 2024 07:45:17 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 15 Oct 2024 07:45:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728992717; x=1729079117; bh=Y3q+0LDusJ
	XB3OB3K5AJ3qj6qWUbRw1RNRQDnKGedRE=; b=P5Nv9hHA3LKDv3mlWwe9aMKxnb
	6mUPxbaXKJj4gxE8Jd1zpJ/nL7FlOouqrefUjrK3KsEGUk/Rbn6Qk61SC9FjfHpl
	b0Bq2kASheehiLEZDQOhu5MWmyJpimKLBj0zBVP+PyJ5AtTYODQ050EhcRjZ1abU
	QfER3OSfpLeDhmpgXkMqEory3+Urinyp8G1grODAdJYEDHIznS1ipqfquNgiJ3R4
	Usw2Dn/Tw43aotIY2zorN13CtJQlSLdwRPT9YqyC0gBo2BDSbPFHIAsfmqgphfRq
	4bKe2uCDpAOIDBnMLsJ9jz7kHq9yXnDI5RDqrDyDf2+DsKa/z6miZuTiP4JA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728992717; x=1729079117; bh=Y3q+0LDusJXB3OB3K5AJ3qj6qWUb
	Rw1RNRQDnKGedRE=; b=Zcl3JKnguf67gdVLUopdBamtvjG1y0KhwNtym2vo/TyJ
	cel6nriHVAWkDz9G3+565gOoT4tbX4siMToiMtBOUE/RDRmpWhFwjcNTjgkoJPBC
	+OmULD0E7TDXTue9YBM747OLGDPRTKQuveX0iBaubGnI5slR2zmwI6RzBmAsaWTY
	BtGnHiWqUUQdk7wDCqawi6VPz+m3ssDGGybaQYBi0Sa0aKKjbQd1B4139FNd47mp
	3Xx888vkOT9lBvqFULQnmzNgCATO0rEY8TDRSHUJB2W1yQQtfJYh7TfDkzUVnomZ
	M6s+H9WMYb9Z2g+ryfG0KMdUXP/mIWdpBeg2+9xyEg==
X-ME-Sender: <xms:zVUOZ6wh1g6lLd8Y29L5_3Db70jA1r2PM_d9qv4CwU8VUZTvabu78w>
    <xme:zVUOZ2T68i2SvlidYAfA2oDf-vRn7smlsDSkQFFCCAnsyeowKuOj0OALcXUsy2Zi5
    I0NgiSFgwywf8mzPA>
X-ME-Received: <xmr:zVUOZ8XM-mBB6l5Rc3Civ22NHsGN7lVlTJFTxzZWsADMm9ybXAdqtJHynwEHw1PTP3I5DuykD6Yovz0tMvU51YKhf6Qa1ZSp28HZJKEVOfBnxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegjedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhunhhshhhi
    nhgvsehsuhhnshhhihhnvggtohdrtghomh
X-ME-Proxy: <xmx:zVUOZwiaQX8z1_LGveFmITFT-SX3Vipc6huZsMnrxLkg-lSe4cHBNQ>
    <xmx:zVUOZ8CJ9Uqtd6qLQepwvtC8FuLhi8vfNZ1Yd4sKV9yNL_8gaZq65Q>
    <xmx:zVUOZxLDNIJFc7OdAC9WclDXgVtmO4ZjWRxb494s6mRQMZJefZY78w>
    <xmx:zVUOZzDM7rpOapTqzJbsJwIGsgWphDeFmU-2LqpCKFdDXQ71cRR8Kw>
    <xmx:zVUOZ_O4N9PCWNSA84KX5dZb8rpPT5PxaBGwV5B1b6RfjpSECSIb_Wk1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Oct 2024 07:45:16 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 07251505 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 15 Oct 2024 11:44:01 +0000 (UTC)
Date: Tue, 15 Oct 2024 13:45:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 03/10] t/lib-gitweb: test against the build version of
 gitweb
Message-ID: <2e2d208ef1b64e87795e91cf8cf1e4376067ccd4.1728992306.git.ps@pks.im>
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

When testing gitweb we set up the CGI script as "gitweb.perl", which is
the source file of the build target "gitweb.cgi". This file doesn't have
a patched shebang and still contains `++REPLACEMENT++` markers, but
things generally work because we replace the configuration with our own
test configuration.

But this only works as long as "$GIT_BUILD_DIR" actually points to the
source tree, because "gitweb.cgi" and "gitweb.perl" happen to sit next
to each other. This is not the case though once you have out-of-tree
builds like with CMake, where the source and built versions live in
different directories. Consequently, "$GIT_BUILD_DIR/gitweb/gitweb.perl"
won't exist there.

While we could ask build systems with out-of-tree builds to instead set
up GITWEB_TEST_INSTALLED, which allows us to override the location of
the script, it goes against the spirit of this environment variable. We
_don't_ want to test against an installed version, we want to use the
version we have just built.

Fix this by using "gitweb.cgi" instead. This means that you cannot run
test scripts without building that file, but in general we do expect
developers to build stuff before they test it anyway.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/lib-gitweb.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/lib-gitweb.sh b/t/lib-gitweb.sh
index 1f32ca66ea5..7f9808ec202 100644
--- a/t/lib-gitweb.sh
+++ b/t/lib-gitweb.sh
@@ -48,8 +48,8 @@ EOF
 		test -f "$SCRIPT_NAME" ||
 		error "Cannot find gitweb at $GITWEB_TEST_INSTALLED."
 		say "# Testing $SCRIPT_NAME"
-	else # normal case, use source version of gitweb
-		SCRIPT_NAME="$GIT_BUILD_DIR/gitweb/gitweb.perl"
+	else # normal case, use built version of gitweb
+		SCRIPT_NAME="$GIT_BUILD_DIR/gitweb/gitweb.cgi"
 	fi
 	export SCRIPT_NAME
 }
-- 
2.47.0.72.gef8ce8f3d4.dirty


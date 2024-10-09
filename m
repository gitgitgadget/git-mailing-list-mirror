Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D26D1A262D
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 14:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728485813; cv=none; b=G3bgSN7W+2mCb1CktWTT3u1AjVVN6uhriRKXi1hGp3+qmLag5C2HA7U6/Mf32lVKo4ZiZ6TCQqVxPMD6rrwq+xH9CY/xbyT2NK5AKFthtA7/ZHTT+eu8Xaky/SI1NpEbtuEc6jwI7jYTlSOl4jkj1ctW4XY2WfjeVbeecAJVYgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728485813; c=relaxed/simple;
	bh=cutmeHvdZU8iCvZtCsqtwAv9/yo1Q1IJBbR8Bzw/FVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iUTCkktsseEJtigLzVAKZ7WnJV9RwP280gktXzgv+AypAcUkjbYPtGqSA6WCpbJbbXCnwytcv+tjCWXtdVlio6kSXHgEJ1VkugQO9htnRCctS04dN4ef6FKDTPjnyGiSAVZy+WiLLoSnadL2P82+pRnRXdXhGZLthyjP5tioEn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kZuzDkbV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M71aXGIl; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kZuzDkbV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M71aXGIl"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 57CC71140170;
	Wed,  9 Oct 2024 10:56:51 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 09 Oct 2024 10:56:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728485811; x=1728572211; bh=tOav+8enP4
	GrF/lCB2i7kBctBDEpSRbTqU/IM1XtpD0=; b=kZuzDkbVkEGtwy1iy0c9SAKrSD
	CkUxoxcitqxtoQkdQXGw4zXJjmE2YRhp5E5wyM6bfCol0no2o8lMR94LwEEtWZUf
	waeYp0bmLPOBtrptnKGHMcEhRPKXAiX/EcOENYcPET5BR75jfYAfKw/WpyKuAYq8
	IYq38tBCutUbsRKcBZUfnRJ9WGOrKmR143GoxG8w8scVX0ehz/WGJA3cM/V3JlOK
	k7YH3nMeByJVCr3LlaP2VfuIoGdjmadm20I10OB3fdO4JhTMwnbogJSwXVbdLkTQ
	28OOZn+04JKgKWhWq9YcBhnq4IDu2ZPJB6aVqwqwPtwcbWDIuy5LDT3TQNKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728485811; x=1728572211; bh=tOav+8enP4GrF/lCB2i7kBctBDEp
	SRbTqU/IM1XtpD0=; b=M71aXGIlf4awwMdCKBZlxJfI7+pTMpjKazUiFjwvS3mQ
	dFnGCB/BzDmeqsFX50kpKxBJ4e6iwTH7YCiBBoJn+D3gMAQnf4ws8ti8lYcBm80+
	pnVlSqpFNYJZM/UX4AZl1KeFwwtgpoLVj5M+8ZmWH1+tV/gLfNIsvML5IJOft7tw
	fStHS7MK3c3V8qA8gWahc+Xut9GeiJGnWOPYrQwjysCbTylkypyhS4nNGgHQzdUy
	r6MAYR4qQSjS3ZsH+joqiBfmTmPOVuNKUK7oI/QArLRnDhBPUNOUCL9glJ2cLCxh
	fw414l60rtOJNcFJAY4sJVQh2P/2o7At916DJ9OZ5A==
X-ME-Sender: <xms:s5kGZ3xyYS7UtVwXkznuuddbTio2n6tawTbuyGPyKWM3yF4GWUFcxg>
    <xme:s5kGZ_RCn6bgEeXT0yofLYQ5_JSlMQT1_UANRih--z0fUPiMwhGtewC0-xUVExst4
    S7aMFIvfsQadpfNfQ>
X-ME-Received: <xmr:s5kGZxUSR1CchltW-TIWi3LJ7_NOrPptozzXUp4bEBfUF6juVM-zcd6ozkBlukqpP22VPabfHDxrMip4bgUc_17u96hCH0TFtW5lsj35FIL9uw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeffedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegvshgthhifrghrth
    iisehgvghnthhoohdrohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdef
    sehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:s5kGZxj9wC5j-xxc8B5Xtvg5pLgzoYFrX0xyVh9cc-n3cNtJe_hNOg>
    <xmx:s5kGZ5AX86lgWHJi0HQOuImyEluOikBb1KjSpU_MS-8FKvvlIK_kVg>
    <xmx:s5kGZ6IEU937P_U3SlC-VAVdjy86XA2bq81qyTqoo6pYe1rfX5SM6w>
    <xmx:s5kGZ4AWeAakgXy4_7LS9qcgxkQrPvIeg6WetQpBMARo4XQbdgBjlg>
    <xmx:s5kGZ85ia1cgENhdZC2L3F_HuDi3jnrts_Bvnx8M7exO5VV_iBqJ5M1P>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 10:56:49 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0ac0ba0a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Oct 2024 14:55:47 +0000 (UTC)
Date: Wed, 9 Oct 2024 16:56:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH v2 14/24] Makefile: refactor GIT-VERSION-GEN to be
 reusable
Message-ID: <dfc941cd18dc2a4d3483ff504f3b1b2b9ae5fc50.1728485139.git.ps@pks.im>
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

Our "GIT-VERSION-GEN" script always writes the "GIT-VERSION-FILE" into
the current directory, where the expectation is that it should exist in
the source directory. But other build systems that support out-of-tree
builds may not want to do that to keep the source directory pristine,
even though CMake currently doesn't care.

Refactor the script such that it doesn't write output to a file anymore
but so that it instead writes the version to stdout. This makes it
easier to compute the same version as our Makefile would without having
to write the "GIT-VERSION-FILE".

We should ideally refactor our CMake build instructions to stop writing
into the source directory. But this step is out of scope of the current
patch series.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 GIT-VERSION-GEN                     | 12 +-----------
 Makefile                            |  3 ++-
 contrib/buildsystems/CMakeLists.txt |  5 ++++-
 3 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index b3265f7becb..f2c0f47786b 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -1,6 +1,5 @@
 #!/bin/sh
 
-GVF=GIT-VERSION-FILE
 DEF_VER=v2.47.0
 
 LF='
@@ -28,13 +27,4 @@ fi
 
 VN=$(expr "$VN" : v*'\(.*\)')
 
-if test -r $GVF
-then
-	VC=$(sed -e 's/^GIT_VERSION = //' <$GVF)
-else
-	VC=unset
-fi
-test "$VN" = "$VC" || {
-	echo >&2 "GIT_VERSION = $VN"
-	echo "GIT_VERSION = $VN" >$GVF
-}
+echo "$VN"
diff --git a/Makefile b/Makefile
index 50fbc4f29d0..cd28f88e1b3 100644
--- a/Makefile
+++ b/Makefile
@@ -592,7 +592,8 @@ include shared.mak
 #        Disable -pedantic compilation.
 
 GIT-VERSION-FILE: FORCE
-	@$(SHELL_PATH) ./GIT-VERSION-GEN
+	@printf "GIT_VERSION = %s\n" $$($(SHELL_PATH) GIT-VERSION-GEN) >$@+
+	@if cmp $@+ $@ >/dev/null 2>&1; then $(RM) $@+; else cat $@+ >&2 && mv $@+ $@; fi
 -include GIT-VERSION-FILE
 
 # Set our default configuration.
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 1384c0eb6d3..21d6bce26c7 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -87,7 +87,10 @@ endif()
 if(NOT EXISTS ${CMAKE_SOURCE_DIR}/GIT-VERSION-FILE)
 	message("Generating GIT-VERSION-FILE")
 	execute_process(COMMAND ${SH_EXE} ${CMAKE_SOURCE_DIR}/GIT-VERSION-GEN
-		WORKING_DIRECTORY ${CMAKE_SOURCE_DIR})
+		WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
+		OUTPUT_VARIABLE GIT_VERSION
+		OUTPUT_STRIP_TRAILING_WHITESPACE)
+	file(WRITE ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "GIT_VERSION = '${GIT_VERSION}'\n")
 endif()
 
 #Parse GIT-VERSION-FILE to get the version
-- 
2.47.0.rc1.33.g90fe3800b9.dirty


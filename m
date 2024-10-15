Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E691018B488
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 09:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728985580; cv=none; b=AJda1OMQcIi3mxGn0Jv7Y7/wvO5rbuiS+fBOww2Z+091PTqklRFAlWI78zW19oQCj6Uq3732pI5UHQytUe27DB+QQaBpr7fWqiUzcZWiXm3TboY6Ek22qQVFb6D5lDpgxM85SfBCuFMT2TbwS4KDUO8eLpmOFz/whi9OVMShgzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728985580; c=relaxed/simple;
	bh=EpPnw98TyI0UZJK2b9Gn/zqqSGSFxhV0BBIrjgsLTF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bPBWqwhv1dFEXuqIStTfIhPYXWy0JnvflX0nlUqcnGkU/a6Hv4uvDCHNEIyzKTJdXMz/m5PajL07pC/KS+lPydf8oop2ShNw0xAsfJsJowI7W11lt3mp5YxlTJqoaEsPu6JiN+efj5pNru2EJ6da4Lbv9JIytXRgre6/MetLfFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DiiAHqdx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LoworOKM; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DiiAHqdx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LoworOKM"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 83E2E25400AC;
	Tue, 15 Oct 2024 05:46:16 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 15 Oct 2024 05:46:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728985576; x=1729071976; bh=hXzL9ENRXL
	7hlmqvuYVttyoKRFXeC+Oq7mZQ2hJJMp4=; b=DiiAHqdxP3hCjKOP0jZFzBElOQ
	3oi/DNlPvGLLleR7VbZLHQj/bVnvZMpa6P39Bcbp0VeKOLfgdPxPHcvO04pUkt3E
	Jf2xjGGHUtQ0DAbSVRUxvWaxfQRZ9coniDcKwsSY65GPR+u87TkyEU6Y6xomYE4w
	gBHbG1k4s64tTr4yEM2tEscnH0p4kHyk10/2OiQ5DGYCjqYhXla3O9Tvak2D26K1
	pdXNmT3kfE11guHc2oDep4278zIaruXPHYz3VLx4K7569l6sptVLadjCI2K63ZcF
	nHk74KJRrAZJoQaMW8fQSQTMo/toaniGAfzibMGAjqFOPWW7m4vBYpbXz0iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728985576; x=1729071976; bh=hXzL9ENRXL7hlmqvuYVttyoKRFXe
	C+Oq7mZQ2hJJMp4=; b=LoworOKMZDN7VmJbuBUW9Sv79qAW9pH/cLQjwq5MqIg9
	5z2M6JmLuQw1FAHgPlyJNi2UdoQd0sKub8Sez/vHu8STL2joKvnJJQ45HvTzUyq0
	JLXUr0t/BG5XThCkpFOhVm3nd6nPgiPP4i5XR+1CczPbQeqpYARMsx0JkCeD3Jke
	nQ7jWGtljnURZt9+pPT3+PRyHNgQ/0lhm8UAppPMpvs++HbA+8OzodMEgZRZ88OE
	CEC3S3ryPuCOIpiy20mXc/6CZf0SsBuTz04ufVxpcpWW793Nov39arU2En6Xttcb
	ZC0psR09edykPDyRiXkqEHfbTawFTbTbA39L04o68g==
X-ME-Sender: <xms:6DkOZxufk-J5WeVoD8mjJBhY-biwJa7s8qec2OvDuLLzdkpFPbLuJQ>
    <xme:6DkOZ6ccp3g185WYbcUgroU7fVqSH0mbmjdmW7VFBffGy6AMKUeyJ5uP-D3KCUfdG
    eFcF4R0z38ijCdTFA>
X-ME-Received: <xmr:6DkOZ0yVObZmafA714gZQEr6b6p5Ejp7lcfQ_h2qev-XvXs3hT6laIOTHLCNI7xzQ5zuk4kE1XVtz1u7JFxh3scfuc1wjONk5n8T-0V-qnGf_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegjedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesgh
    hmgidruggvpdhrtghpthhtohepvggurhgvvghlsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:6DkOZ4NFmiGROKEzGaBkncF0LMFPDYzQz11PogLejAcERHu-jASyPg>
    <xmx:6DkOZx8PK9TWn1tn0ifnbN39mNxwq6m4-iaVcBHFWxeb_6ULN8GKdA>
    <xmx:6DkOZ4XmZVmmFsDQhkZ09QSyKNr1Uw_dcVSRbVlXmYXcgEk5QUBwww>
    <xmx:6DkOZyc2uOgic3tup21nZEkYrK1D0IppASLcXRojO3RrhHo46ILTig>
    <xmx:6DkOZ9bC9cozIaEeMX-Xb56vWz660_VA3wl6ixYMXgZQInOh7dbh19wj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Oct 2024 05:46:15 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 62c1ce83 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 15 Oct 2024 09:44:55 +0000 (UTC)
Date: Tue, 15 Oct 2024 11:46:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Ed Reel <edreel@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2 0/3] cmake: fix autogenerated clar headers
Message-ID: <cover.1728985514.git.ps@pks.im>
References: <CAGjHeYfyH+cOMYYYHnFR+Vu9T+RbmzO1SpB_-kbmBSf1DitJhA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGjHeYfyH+cOMYYYHnFR+Vu9T+RbmzO1SpB_-kbmBSf1DitJhA@mail.gmail.com>

Hi,

this is the second version of this patch series that fixes building clar
with the CMake build system.

Changes compared to v1:

  - Use a for loop instead of `while; shift`.

  - Provide a bit more context around the PRIVATE/PUBLIC switch in the
    commit message.

Thanks!

Patrick

Patrick Steinhardt (3):
  Makefile: extract script to generate clar declarations
  cmake: fix compilation of clar-based unit tests
  cmake: set up proper dependencies for generated clar headers

 Makefile                            |  4 +--
 contrib/buildsystems/CMakeLists.txt | 52 ++++++++---------------------
 t/unit-tests/generate-clar-decls.sh | 16 +++++++++
 3 files changed, 30 insertions(+), 42 deletions(-)
 create mode 100755 t/unit-tests/generate-clar-decls.sh

Range-diff against v1:
1:  346aa2f0830 ! 1:  7a619677c7a Makefile: extract script to generate clar declarations
    @@ t/unit-tests/generate-clar-decls.sh (new)
     +OUTPUT="$1"
     +shift
     +
    -+while test "$#" -ne 0
    ++for suite in "$@"
     +do
    -+	suite="$1"
    -+	shift
     +	sed -ne "s/^\(void test_$suite__[a-zA-Z_0-9][a-zA-Z_0-9]*(void)$\)/extern \1;/p" "$suite" ||
     +	exit 1
     +done >"$OUTPUT"
2:  b9afeffda29 ! 2:  447afc4a0f3 cmake: fix compilation of clar-based unit tests
    @@ Commit message
         "clar.suite" files as include directories. Instead, we accidentally set
         up the source directory as include directory.
     
    -    Fix this and propagate the include directories of "unit-tests.lib" to
    -    the "unit-tests" executable so that the latter uses the same include
    -    directories.
    +    Fix this by including the binary directory instead of the source
    +    directory. Furthermore, set up the include directories as PUBLIC instead
    +    of PRIVATE such that they propagate from "unit-tests.lib" to the
    +    "unit-tests" executable, which needs to include the same directory.
     
         Reported-by: Ed Reel <edreel@gmail.com>
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
3:  129d28ae48a = 3:  cf4955b2ddc cmake: set up proper dependencies for generated clar headers
-- 
2.47.0.72.gef8ce8f3d4.dirty


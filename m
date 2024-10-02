Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842231D0BAA
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 15:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727882179; cv=none; b=EEo/j9gKdq4P7N90rpYsmIwXsBxF6mtzYTZAGxg9RugnZLll72yM0KWEzK1vSS9ZEBGj2+xbC4C2f2KI5B02fQSDb5yyFQr0piMdxRDnzDawIP/UmvFwNFOcelx+L0Is9f1m1bXNN+1+kn70WZXdEE4pw2klXAI2VeDoVdxCjFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727882179; c=relaxed/simple;
	bh=m1SV/tgZtrcWTtn/OL9Ai/xju3mRiYFJusg2ukjY978=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UwKHPxcGkrCdoWpVp2awvcGOM44d9IM4743Mvet2LXI50FLUBl+0NP7h2BL+7DsCUZVG7X+BJiYkoWJ2q5BSQMGFfu/v3XTcR7nehoh4h6KN4R9VSuKEKQ9R2dl3Aq1qBexyk92iBLQ0uZ8DI/BF0N6Vj3wh1CqqS5tJXHG/mnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=e2iGrt0L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F9Gh1g/w; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="e2iGrt0L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F9Gh1g/w"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id B557013801B1;
	Wed,  2 Oct 2024 11:16:16 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 02 Oct 2024 11:16:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727882176; x=1727968576; bh=ShOC0RDAt1
	Zkm9lhGo59IQ6zHISk7CuyKzDT510He9k=; b=e2iGrt0LNlkJYSoHFgW9ZaVbvY
	klXOXyXzeD1Db+kmA7d0eLSVgR00YJ4gFr8iBpFyoO1p8fLZl9ee4dwCmGQjeuxt
	jBmN+06G8YvF3ceW0ERVDk6MMTA+Q0Tl+7R63ztAKFp5ke3jsOvPkU+FVvFo9brT
	9YTrgTuyVLFh6OodD55mbcTwx+PVwLzTA/eWQr8ebKUrwkHsynx7jgu8/n0XcbwH
	bxEO0z77WmDEnLZkqZx1zjSTm47uYR0vCHcO6wl+QgC5mLqkTB3gLcnvVd2qEoPs
	C+1JpOTKvaz7E6pJVxSqnnMLANB2IDWgbg9r64/PP5D3iCUjMgeSJcSpRIlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727882176; x=1727968576; bh=ShOC0RDAt1Zkm9lhGo59IQ6zHISk
	7CuyKzDT510He9k=; b=F9Gh1g/wWyEWfuGsZVynn8rusQqtmC663H8Nl6WSMg3e
	lDDbte2zvoB6gc7x89QiS53jGGzlYj0B/RAH7rfFum7GmPXcVkdVPLAtvHyMdJee
	EaOtX8LdIKuwQuVvgMNNCQFM+me/D3tMMEBwxcAevfau3YL7WN9uQw/LPUi6qJ4Z
	XFU1N+dd+23vPZBrccizJ3DUKdIf02UJI75jJm4HW9EqYgGZvKbIUvAGHodUq43M
	uxjbHv4JgCBs6pXj2ensVzGhd1glmTFuQRTED52RNz/o3ztm14uGnZiJU3/EyCyl
	pxr8fAmxZyHdx77DcXbFFzdMLXzq89+VS/fMYkEk2g==
X-ME-Sender: <xms:wGP9ZiywDzEKJjEpM3nUN8myNt3JH0uiQqfjWWWGJtGeQLuFhGIoxA>
    <xme:wGP9ZuSme9TzHH3C_IfvHA3pjHlNpE350Gzm3iN_MKrvGPNiI3ffTgma83RpkMtla
    8DR7DTLtnppfJs0Nw>
X-ME-Received: <xmr:wGP9ZkU_Jxq5LDDbF1hgICXQRA_-eXtZxmTRKkDmduddgnKlG8ctlFjZk0rAWEDy5FJUM0wuCI069ZZ0SLxd8PfGmzmFiTIMZnLj4Fd7uajoIojK>
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
X-ME-Proxy: <xmx:wGP9ZohaDdQCl0v0WVm_kjYSrhR7NWP1tj12rptYgTLE_vqNNZwvXw>
    <xmx:wGP9ZkCAqeoXMAD6lwgPHHBAtPOGR8IREfxNloBLML8LcGIYlGKQ-g>
    <xmx:wGP9ZpK3S2-npJnQ8_Vq6B33LP9SURdx2wd0h4iF8ihZb2LzcB-C4A>
    <xmx:wGP9ZrDmX7Oo50R-i5gwYDCB3iH7LjD1RzzoLzUZ-NYkfHq9mkgW4A>
    <xmx:wGP9ZnNVjIwFiWm4dwBeCC6sedwY4Gb2nHH4drfcsz2cICh9phzX_ihM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 11:16:15 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3ae9415c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Oct 2024 15:15:25 +0000 (UTC)
Date: Wed, 2 Oct 2024 17:16:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>
Subject: [RFC PATCH 12/21] Makefile: refactor GIT-VERSION-GEN to be reusable
Message-ID: <ada39ec21ddfca5980d512a480078b6b8012fa1d.1727881164.git.ps@pks.im>
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
index 38e920725c..f626d74d6d 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -1,6 +1,5 @@
 #!/bin/sh
 
-GVF=GIT-VERSION-FILE
 DEF_VER=v2.47.0-rc0
 
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
index f582ccdc98..fae931ff0b 100644
--- a/Makefile
+++ b/Makefile
@@ -588,7 +588,8 @@ include shared.mak
 #        Disable -pedantic compilation.
 
 GIT-VERSION-FILE: FORCE
-	@$(SHELL_PATH) ./GIT-VERSION-GEN
+	@printf "GIT_VERSION = %s\n" $$($(SHELL_PATH) GIT-VERSION-GEN) >$@+
+	@if cmp $@+ $@ >/dev/null 2>&1; then $(RM) $@+; else cat $@+ >&2 && mv $@+ $@; fi
 -include GIT-VERSION-FILE
 
 # Set our default configuration.
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 62af7b33d2..01a23788e1 100644
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
2.47.0.rc0.dirty


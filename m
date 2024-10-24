Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACB71DAC88
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 12:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729773617; cv=none; b=fEk1JnEJ+8q5SPbpeKka+40SLxuLhvbtQMmkMgIWvlPk7MBxq1S1H4+/Hh0PKd1UyckYwozdhpLluFiqSslyLQfhGpNGFKJHZBkWN+ZyUoGGpN8dMeP0Vg+b0MGbLEQJ4qReXO/iye0MiSKi2VIfeE571JDYYRxQqyW7Tl75OEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729773617; c=relaxed/simple;
	bh=MCC1cUVq+zAySBc2KO/Zi+uyYzHSWRFrF6XNU19EclQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VWUrb/W/3xoH2tbG4hg3XJSh8A2dfCkEk0+GwHfHU57cPtkDAT943x5tf3SuRfELM0Udlg2hMOw0okKVz3FP9aOSQPmv5GJxp6GbdeQs1hZKbTefDsWFE+vgSwqT6NQxNInZkc9lRTV0RZhqRTK8+nqsJOzVG4Ai1JGKB4hOkII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XyHohzMK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RGd55w+6; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XyHohzMK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RGd55w+6"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8A37F254013E;
	Thu, 24 Oct 2024 08:40:14 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 24 Oct 2024 08:40:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729773614; x=1729860014; bh=FWqztG9A9b
	urONDXJxNF7tyakgaBWjOEZ2Rku7ao6dA=; b=XyHohzMKJROIDwudespXEnD6n2
	c3LJ8kCJGPBlIDRSukxBDvr/b2deqE/LS/P4ZyOXKpsUk7BRc1K6uRKlztEkMzbx
	FEiVo3D2BMZqMqohI+VXT9yS01EG1KfpZMRGIOcHvVSfe1kESgS9c/5CDY1FrNvS
	SV2ibZ3noZW5gQfdFx+5s6ghQLW4pM0GmjRa3rFE0lum2langJLR4pt6068RWj8I
	IVukVMJ+VG4nLYdNTVqlhwFJ//D+ZMwSUqgiHfrusYcB8TCxq2yj1IDErpxpE9yk
	7rotgPcwOWpdpZnJLwF8UaAitF64RfvTUzJddEt58JgnC0QuLPy3Tiu23lUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729773614; x=1729860014; bh=FWqztG9A9burONDXJxNF7tyakgaB
	WjOEZ2Rku7ao6dA=; b=RGd55w+6b5moy4Eozmgdcr2hKEp68AYQTyJYJFGV62Fe
	aYVIRAemXQN9WedW1DFmAPQP8hpKchdEvXRvpYnEopRs9qBZr5Wq1kaixkH9n0iW
	GgEkd0YROfLuQzXFyLpEJ5ZhmmnbBmi7q8+PqQ7Icx3RyQLGEXgWr83pcnWb8pPj
	ulSaKoX4r8fwFSPdWW9S7ycm7cYOlI9Tqdu+DXS2TUKngtMo7bA49cE3lYlU8UcQ
	OUbWjbVw+Lji3RGTa6vjirFp+OyYPahk8gdRJrpKj4J18AKbpYUxfMggJcgRieUH
	/2TN50y0Pn38AvYkcyDDBxgQjC+PQ2OEXkN3yJcPYQ==
X-ME-Sender: <xms:LkAaZ1YqKw1nW9RD8DdCkN6u7q0yEB82kk97jlENhGycemDv8x3mKQ>
    <xme:LkAaZ8ZmqEb8zR2on_62ZIEMqqwzKtw3qDSXQOUgSwMK8xkhqaOiwt8CgCEP_w-bP
    rkY52pSseJS_7du8Q>
X-ME-Received: <xmr:LkAaZ3_-8csB6yPHd-nvV-Y_e3wu3EYSxCPm__hcVfHZEMZBRq5ssBtBTJsMTkp74owjyKskzJbp0nq_XT7U00hYrRguvlKcK7cVlsBnuFKX91z5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejtddgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepvedutedugfejgeduffetvedtgfekgeffhefgleejteet
    heeltddvfeeiudduueetnecuffhomhgrihhnpehgihhtfhhorhifihhnughofihsrdhorh
    hgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhs
    sehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehtthgrhi
    hlohhrrhdrtghomhdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhr
    ghdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpd
    hrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:LkAaZzripkRVuj0a36ZDt1l-n4GotxyJw3uMKBUsAvRS-e3Al5XBTg>
    <xmx:LkAaZwozCkCozosEgZvhJaJpsQd2KXURyjunJq4T-e_4JHEClYhORQ>
    <xmx:LkAaZ5RTUahI6IFZ0vs75t_RvQuUmb6sTg6hWqt5yiz2b6B-82PNYg>
    <xmx:LkAaZ4ofxZLAqPN9MD4Ka8U-hBXAnOtFt58SQKVdESCnYZmrsBUUYw>
    <xmx:LkAaZ4IusQUw_7aUqyJErTswObTBhF4EC0Mdoewnb2ctaasUXIwsVRG4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Oct 2024 08:40:12 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3d25239d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 24 Oct 2024 12:40:15 +0000 (UTC)
Date: Thu, 24 Oct 2024 14:40:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: [RFC PATCH v4 08/19] Makefile: refactor GIT-VERSION-GEN to be
 reusable
Message-ID: <0e682b68e25154461faf8c73f05af18208d47050.1729771605.git.ps@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1729771605.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729771605.git.ps@pks.im>

Our "GIT-VERSION-GEN" script always writes the "GIT-VERSION-FILE" into
the current directory, where the expectation is that it should exist in
the source directory. But other build systems that support out-of-tree
builds may not want to do that to keep the source directory pristine,
even though CMake currently doesn't care.

Refactor the script such that it doesn't write output to a file anymore
but so that it instead writes the version to stdout. This makes it
easier to compute the same version as our Makefile would without having
to write the "GIT-VERSION-FILE".

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 GIT-VERSION-GEN                     | 12 +-----------
 Makefile                            |  3 ++-
 contrib/buildsystems/CMakeLists.txt | 12 ++++--------
 3 files changed, 7 insertions(+), 20 deletions(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 78e8631f677..671f853512a 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -1,6 +1,5 @@
 #!/bin/sh
 
-GVF=GIT-VERSION-FILE
 DEF_VER=v2.47.GIT
 
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
index 2afad000762..461f0216bf6 100644
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
index 2e22e87d188..e1200f294de 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -83,16 +83,12 @@ if(NOT SH_EXE)
 			"On Windows, you can get it as part of 'Git for Windows' install at https://gitforwindows.org/")
 endif()
 
-#Create GIT-VERSION-FILE using GIT-VERSION-GEN
-if(NOT EXISTS ${CMAKE_SOURCE_DIR}/GIT-VERSION-FILE)
-	message("Generating GIT-VERSION-FILE")
-	execute_process(COMMAND ${SH_EXE} ${CMAKE_SOURCE_DIR}/GIT-VERSION-GEN
-		WORKING_DIRECTORY ${CMAKE_SOURCE_DIR})
-endif()
+execute_process(COMMAND ${SH_EXE} ${CMAKE_SOURCE_DIR}/GIT-VERSION-GEN
+	WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
+	OUTPUT_VARIABLE git_version
+	OUTPUT_STRIP_TRAILING_WHITESPACE)
 
 #Parse GIT-VERSION-FILE to get the version
-file(STRINGS ${CMAKE_SOURCE_DIR}/GIT-VERSION-FILE git_version REGEX "GIT_VERSION = (.*)")
-string(REPLACE "GIT_VERSION = " "" git_version ${git_version})
 string(FIND ${git_version} "GIT" location)
 if(location EQUAL -1)
 	string(REGEX MATCH "[0-9]*\\.[0-9]*\\.[0-9]*" git_version ${git_version})
-- 
2.47.0.118.gfd3785337b.dirty


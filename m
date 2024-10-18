Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD8818E356
	for <git@vger.kernel.org>; Fri, 18 Oct 2024 12:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729254260; cv=none; b=GOq3ByT+gPfPn0fMu2XLgIt+N1yQGbso7QWa4GTvvINbFgYHw/F7ghlmYK3hYH50g3yK/9NcK+t4MZXyZCtf3NQqrafyteDBp5B1HzfJqhDu5BWNGrReR3Tffa+/UALGeL+gtdQ5PRTJchg4bIDkeMtNq9Cmat4yKqR02Q5nuLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729254260; c=relaxed/simple;
	bh=+eKI4OnxhHHhPDV9dBO2c5Rrgy4zg2UpQfNsrO2XVV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/NMA5oL6K7p+Y34oNg3B+Vg0Fzz1befBIISlNZTdr7teLibQxRDooUXjrJFw+Z++f1SaAXBE4LkS8aweFWcA+CJaVeLHyAtIwGyhtYSah0iRdA8g/ivAw/w8mylQWhrM1lcVjU96SWJpJD6MaBtOo8S1bv9YMxu1EYNGuYpXJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ohJji/az; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dx9kMAh/; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ohJji/az";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dx9kMAh/"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 2947E11400CD;
	Fri, 18 Oct 2024 08:24:18 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 18 Oct 2024 08:24:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1729254258; x=1729340658; bh=fjP2XSbWU5
	CmwQeD+GH8o8SQBOB5acQB6zGadP7oBvU=; b=ohJji/azFcAI/TRdAwrYkvqqGY
	CP8o7gqJHzskDnOOw/zn1GzN77a+AiZlrDeAqo2v+7GcrsKHGxkAbZp4V4g2NFgJ
	MiqYz0NHPWgAbIPcb9dRylOlNdHvoHEIX+QAs9xxaQku+lM1IG9cuGoTjE7Ghm2c
	FrR/TcLyJw6GP+Cp1jxEa2m55+NIbfeznu2Y5it6VVb7GmffX1BGECV3C1rERT2G
	iSsUOCOAnFoDCHrtXmuIA3HU28dUWsl9opJcFnXZrDcG7UUQAQA7DA5/rauQQ7O/
	KvsbKv9XJGzoGZql+pUPLd0XqNgpK84+4PO6hZpif+0HRKxJa+a10p16CVSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729254258; x=1729340658; bh=fjP2XSbWU5CmwQeD+GH8o8SQBOB5
	acQB6zGadP7oBvU=; b=dx9kMAh/56+t8V4SIGF3oAx3rlWn/1B+fGcT5MpZBY+e
	R4SLwJBwg/yAylRCI3zGtK530hB9iejgelv8LJT88tzM/Un5WUgpEvvg0i9kmsSY
	A6oQG4l1RgsqBqW/lPkrkXSxjbOTp2OlyeoeRTkLWmvsxu2auWqsPXHd0Wvuozny
	8FNfOpKkIGRrzqx2XJ4DAM9D0g6jZlUoo3XHwnLjxvNGcYJpFqT0on1jfns4U/Y5
	Nq8TFc4lVgTMfoDIh8HDnBBHTKsyHt80ofqXcEkIXhL4++NIKJc/UzPxgsrQKvNd
	H/gaBnaXSni7nNlOTV2gJAmfTGEAzQui9qg0NpsEsg==
X-ME-Sender: <xms:cVMSZ9ybAaajeCH2yHsUnOS7_9EauHjbCDGY6TfgmfNVimKr7rjRMg>
    <xme:cVMSZ9Qgfd_kIDw53iPzf2oQxw_p5pJ5JT9zZe6Aua8J6oBvMoqSJKv9uk2D-UbK9
    5rwwGCNK5784ME8ZQ>
X-ME-Received: <xmr:cVMSZ3XKlaaNPEZL4Y4b27X9w6734G8z4Fyz-3HpXyXaOvw9sPf4iCeSOe7D5X5mjezPU1GAg3ISYC088RXezPqtosYXDwR9yRM-eVQ6Ne9L>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehfedggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepvedutedugfejgeduffetvedtgfekgeffhefgleejteet
    heeltddvfeeiudduueetnecuffhomhgrihhnpehgihhtfhhorhifihhnughofihsrdhorh
    hgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhs
    sehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepphhh
    ihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhh
    ihhnvggtohdrtghomhdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvsh
    drphhluhhsrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:cVMSZ_i9a-D-VcWxvsXLXCcHc-Jwq8Wa8IMPC_gLsz9VHYTzEJP8mA>
    <xmx:cVMSZ_B2cMfa0_xae04yKh1-1sujY2I5yAwVlMuxz4vv_bUh_71lQw>
    <xmx:cVMSZ4Lg5DupnSiaF_SiBpXA84mGMDWK7A_btPKSjj8-xG3LOhBQpw>
    <xmx:cVMSZ-D0nUhNCNP3im-GXnzI7S8vuEBQJqng__JykDWMpS-GhcaSew>
    <xmx:cVMSZx2wvfTfNr52qUz8oPlETUiNirj-VyGLsRzOmMX-id_zlTNew-Mk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Oct 2024 08:24:16 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8bee0bb8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 18 Oct 2024 12:22:54 +0000 (UTC)
Date: Fri, 18 Oct 2024 14:24:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [RFC PATCH v3 08/15] Makefile: refactor GIT-VERSION-GEN to be
 reusable
Message-ID: <d2cdfad10f551e7cfd925ede4d03e4a1e61d3774.1729254070.git.ps@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1729254070.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729254070.git.ps@pks.im>

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
index 85877b25bab..2211adbeba2 100644
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
2.47.0.72.gef8ce8f3d4.dirty


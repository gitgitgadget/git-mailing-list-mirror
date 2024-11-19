Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772D61CB9E8
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 11:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732017065; cv=none; b=ePfiWxvWbOJTFGub/I7ed6c/nt69pnw2wVhfZPTl3ytoMjQpfwnZKXu/sJxLt6vYoekyWHuSkuMmhD4yqsZIrY+BqPEx7PHdI0uN1TuAo+7ZgZzF5PmeW+n0YolwAaS1ZwlRA+2MCx7fwz4NjXzIrahr/D0O+vDoB3BvNo/S7Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732017065; c=relaxed/simple;
	bh=/vU1gpFoDfQrZqH48j1lf4OsZuXDjc8j2r82TMQ0GZc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tiSCRuXaiAB1CVbixxWgsQ79rAn4qCG5CwdbZIpQRqNNGUsE+knJliklY+LLsNXw5L0KSfPabxRZrjVK04d2zGda36CVXBM9SdwqTDW2+Dw5RUXkGK+ZixSIjKijo2NQNxY2ZR+NJk6V5tCpaW2f6I3Ti+QWQEKaakNE6V8fdMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=4a4f3a7s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wv6icm8D; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="4a4f3a7s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wv6icm8D"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 77D7D13805E5;
	Tue, 19 Nov 2024 06:51:02 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 19 Nov 2024 06:51:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1732017062;
	 x=1732103462; bh=WUh5m8w0Rul61eFXCcUPot+y3OOajR2a6b9qXchIpsI=; b=
	4a4f3a7sCA/K4ZXRJaOdAyVc2Ex1YnS9v2pKakIqozeWx5VNuj6lYz498khdCsY5
	xsxBdIgdg+h1xEaMDWoJg11QuQA0caA9/YOfpkFi0mZTJvzPLh/a7bhysyGLhzUe
	fUAx0j9YN0yDv9QpejyYkvn8Zh2Bgx9PDXsKqJD9aF5mm+uTpJZ0ICsQpo4ozprT
	B+Eb2ld7DBIjB/BoOt+HtWs1oNbazYB3Q6k0gl/CY8P6T/87Mp0Ji2M1qIEQWcDw
	xHseS2mElOY/2y9ghpLUmUoFsMtcK/z3/kSg3bTE7Q5ulmcw3jph9JrdPdwq3tGd
	JXNODU+rqodCf1r+F7U3vA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1732017062; x=
	1732103462; bh=WUh5m8w0Rul61eFXCcUPot+y3OOajR2a6b9qXchIpsI=; b=W
	v6icm8DtqSZeYohieVnEYPW8f7ofKmJjFn6F6Jw3s8iy9A2x/3xNJPX4JN37PYUN
	EI4wo281oUsD+bnyuJdg/5xIYOLR8EDGTLNO92dpZr0AH1dkRy45W4Z6Vjr5nthU
	VQvprCbK+25dbMIqpCkYy8jDKhaRjdxxnYWyN69OypoSwzF3ERtKjlKC+cj30AvR
	WGR29jSAubdCm3cu2SxCLjSWOtEz4bC0Z0VSlERU2sqp9DOS153pFEpy2WbGkoww
	tnWDa09HLEYB3u5Fk6kcTAbAYP5+i01fFovNt3tTOf0Ln211Ydof4mnoFNvNwslA
	iod8vb2UzDpwfEMivR2YQ==
X-ME-Sender: <xms:pns8Zzqe6C7vAvywj2DCInyZb3Q9CxVgKHuhPwcopZVhOT-k9KFg5w>
    <xme:pns8Z9qWoWjU2Gj7_cv2AsswlnLxkUHlPvkHIQ9n7skshoM2WmJuQ1tMOc26ZdhZf
    YdLqekGVS5hH3-24Q>
X-ME-Received: <xmr:pns8ZwNvrc4yI4qGZ_IjvLBD4Ns0FrxjYgBblMbAsn2Ek0atB4QoPavtRl-5hh86yWGS16eWcLUMsWwE4h_G_c9S-_ScfWXutWBa61CC6ppNE-s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfedvgdefudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnheptdeuvdegkeevuedtleelveelgfehgfdvheevuefhueeg
    jeefleejhfdvkeehudetnecuffhomhgrihhnpehrtgdrihhnnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghvvhhiug
    esghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehg
    mhgrihhlrdgtohhmpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrd
    hplhhushdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsuh
    hnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepmhgvsehtthgr
    hihlohhrrhdrtghomhdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdroh
    hrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:pns8Z25iPAcr-GEe2Ap8wK__UqqwG8EX6FFhX3d4O3bfy6fVUHPPEQ>
    <xmx:pns8Zy6B0LL9v0aEF1l9Ezian8wOKP8eMiwdlz3lvqoNQeaSxUQCKA>
    <xmx:pns8Z-jwJPJwhbw2VOPr6G2s85rBafQldaGOclpgnoQGNeLn7oEa3g>
    <xmx:pns8Z06UqAJs37NZ1tMWWug2GiTvmaOerV5shrTd8ZzhEz70p0mTPQ>
    <xmx:pns8Z_y6MWGpeK5EsG3Fg3RKYy_-zNRU8tuTWsTod35TTysXC0hgKc3v>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Nov 2024 06:51:00 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ad66c6a5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 19 Nov 2024 11:50:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 19 Nov 2024 12:50:42 +0100
Subject: [PATCH v8 05/23] Makefile: generate "git.rc" via GIT-VERSION-GEN
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241119-pks-meson-v8-5-809bf7f042f3@pks.im>
References: <20241119-pks-meson-v8-0-809bf7f042f3@pks.im>
In-Reply-To: <20241119-pks-meson-v8-0-809bf7f042f3@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, Taylor Blau <me@ttaylorr.com>, 
 David Aguilar <davvid@gmail.com>, Jeff King <peff@peff.net>, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

The "git.rc" is used on Windows to embed information like the project
name and version into the resulting executables. As such we need to
inject the version information, which we do by using preprocessor
defines. The logic to do so is non-trivial and needs to be kept in sync
with the different build systems.

Refactor the logic so that we generate "git.rc" via `GIT-VERSION-GEN`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .gitignore                          |  1 +
 Makefile                            | 11 ++++++-----
 contrib/buildsystems/CMakeLists.txt | 19 +++++++++++++------
 git.rc => git.rc.in                 |  6 +++---
 4 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/.gitignore b/.gitignore
index e17963e84252fa094c10f5e84c0e3724153c819c..d3be460040c6120d862a25dff1abd325b93b37fd 100644
--- a/.gitignore
+++ b/.gitignore
@@ -199,6 +199,7 @@
 *.tar.gz
 *.dsc
 *.deb
+/git.rc
 /git.spec
 *.exe
 *.[aos]
diff --git a/Makefile b/Makefile
index ede181f92708a1720027b25e30b74178ec1d45a6..13dc29695361af8ded3c5146ff0578e198b4d0ab 100644
--- a/Makefile
+++ b/Makefile
@@ -2568,11 +2568,12 @@ $(SCRIPT_LIB) : % : %.sh GIT-SCRIPT-DEFINES
 	$(QUIET_GEN)$(cmd_munge_script) && \
 	mv $@+ $@
 
-git.res: git.rc GIT-VERSION-FILE GIT-PREFIX
-	$(QUIET_RC)$(RC) \
-	  $(join -DMAJOR= -DMINOR= -DMICRO= -DPATCHLEVEL=, $(wordlist 1, 4, \
-	    $(shell echo $(GIT_VERSION) 0 0 0 0 | tr '.a-zA-Z-' ' '))) \
-	  -DGIT_VERSION="\\\"$(GIT_VERSION)\\\"" -i $< -o $@
+git.rc: git.rc.in GIT-VERSION-GEN GIT-VERSION-FILE
+	$(QUIET_GEN)$(SHELL_PATH) ./GIT-VERSION-GEN "$(shell pwd)" $< $@+
+	@if cmp $@+ $@ >/dev/null 2>&1; then $(RM) $@+; else mv $@+ $@; fi
+
+git.res: git.rc GIT-PREFIX
+	$(QUIET_RC)$(RC) -i $< -o $@
 
 # This makes sure we depend on the NO_PERL setting itself.
 $(SCRIPT_PERL_GEN): GIT-BUILD-OPTIONS
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index b9ebe2ef74e37d5fad51f6e23aa234c563cad392..b893b0143a72ad284887d1d4ca72f1beb0a39ad7 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -691,18 +691,25 @@ list(TRANSFORM reftable_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
 add_library(reftable STATIC ${reftable_SOURCES})
 
 if(WIN32)
+	add_custom_command(OUTPUT ${CMAKE_BINARY_DIR}/git.rc
+			COMMAND "${SH_EXE}" "${CMAKE_SOURCE_DIR}/GIT-VERSION-GEN"
+				"${CMAKE_SOURCE_DIR}"
+				"${CMAKE_SOURCE_DIR}/git.rc.in"
+				"${CMAKE_BINARY_DIR}/git.rc"
+			DEPENDS "${CMAKE_SOURCE_DIR}/GIT-VERSION-GEN"
+				"${CMAKE_SOURCE_DIR}/git.rc.in"
+			VERBATIM)
+
 	if(NOT MSVC)#use windres when compiling with gcc and clang
 		add_custom_command(OUTPUT ${CMAKE_BINARY_DIR}/git.res
-				COMMAND ${WINDRES_EXE} -O coff -DMAJOR=${PROJECT_VERSION_MAJOR} -DMINOR=${PROJECT_VERSION_MINOR}
-					-DMICRO=${PROJECT_VERSION_PATCH} -DPATCHLEVEL=0 -DGIT_VERSION="\\\"${PROJECT_VERSION}.GIT\\\""
-					-i ${CMAKE_SOURCE_DIR}/git.rc -o ${CMAKE_BINARY_DIR}/git.res
+				COMMAND ${WINDRES_EXE} -O coff -i ${CMAKE_BINARY_DIR}/git.rc -o ${CMAKE_BINARY_DIR}/git.res
+				DEPENDS "${CMAKE_BINARY_DIR}/git.rc"
 				WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
 				VERBATIM)
 	else()#MSVC use rc
 		add_custom_command(OUTPUT ${CMAKE_BINARY_DIR}/git.res
-				COMMAND ${CMAKE_RC_COMPILER} /d MAJOR=${PROJECT_VERSION_MAJOR} /d MINOR=${PROJECT_VERSION_MINOR}
-					/d MICRO=${PROJECT_VERSION_PATCH} /d PATCHLEVEL=0 /d GIT_VERSION="${PROJECT_VERSION}.GIT"
-					/fo ${CMAKE_BINARY_DIR}/git.res ${CMAKE_SOURCE_DIR}/git.rc
+				COMMAND ${CMAKE_RC_COMPILER} /fo ${CMAKE_BINARY_DIR}/git.res ${CMAKE_BINARY_DIR}/git.rc
+				DEPENDS "${CMAKE_BINARY_DIR}/git.rc"
 				WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
 				VERBATIM)
 	endif()
diff --git a/git.rc b/git.rc.in
similarity index 67%
rename from git.rc
rename to git.rc.in
index cc3fdc6cc6cb83b084eebe2ad49f3c78c981789b..e69444eef3f0c558707e067d52820668d2116308 100644
--- a/git.rc
+++ b/git.rc.in
@@ -1,6 +1,6 @@
 1 VERSIONINFO
-FILEVERSION     MAJOR,MINOR,MICRO,PATCHLEVEL
-PRODUCTVERSION  MAJOR,MINOR,MICRO,PATCHLEVEL
+FILEVERSION     @GIT_MAJOR_VERSION@,@GIT_MINOR_VERSION@,@GIT_MICRO_VERSION@,@GIT_PATCH_LEVEL@
+PRODUCTVERSION  @GIT_MAJOR_VERSION@,@GIT_MINOR_VERSION@,@GIT_MICRO_VERSION@,@GIT_PATCH_LEVEL@
 BEGIN
   BLOCK "StringFileInfo"
   BEGIN
@@ -11,7 +11,7 @@ BEGIN
       VALUE "InternalName", "git\0"
       VALUE "OriginalFilename", "git.exe\0"
       VALUE "ProductName", "Git\0"
-      VALUE "ProductVersion", GIT_VERSION "\0"
+      VALUE "ProductVersion", "@GIT_VERSION@\0"
     END
   END
 

-- 
2.47.0.274.g962d0b743d.dirty


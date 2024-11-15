Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B761885B3
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 07:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731655302; cv=none; b=YI9rAN/ktlTbWh34Hgvm3Hx2QadegX0CsA/AiE/9bdiiWRLdAAPWqDe6FuLhI2ExFWUXLzDX79yhM0g+E+1sQgYeWkyuPP5kevTVE1yHilQHCXE5XLOJhrTsrmT7M3E0cptzJgQSBZv2BLXCZXYrY+3SP+MXElehqyk8bWE/jiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731655302; c=relaxed/simple;
	bh=58n7OETtHZiZ2jaIzjNheORD0Kd9+z2p/crE3io1mkU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m8QIZ5IyTTItGh+y91VTiebVeP0NcMZYf9EieE+/qO5XDVewQoMwjm4eTdzaMey25KjFG+rVleDx9rsIuKtyqmK44N0P7vtAiRjsv7bR2LGR5QUtf5/+1gi6kpeCRdJ+6xbMbJxpBKwXlPkmWTV5pM2X7vP/hD3UYj4rOwJRtV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=442xutcr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=moX6P5/k; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="442xutcr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="moX6P5/k"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 123E21380601;
	Fri, 15 Nov 2024 02:21:39 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 15 Nov 2024 02:21:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731655299;
	 x=1731741699; bh=/KHIJCRwzOdi4j8MF6m/+VqfUPJDplm6I9hlV0c/Eak=; b=
	442xutcrYAm1FR/KA/DraLw5R/cJLhTdWjxp1YufKw3QkOox/wTZ3iOKU/IemaAl
	yUj6xmb4cFnQSOgD3KUn3KQXiHyk42oWx+KyEcDSc1zysIGWvI12Wc3jZR9/jdGP
	e4sz/R2hSYuobR63YmeX7CuMbBCyysJKEgkdu0cl2GmRH2C3H4PX7Od/8acZII0k
	iZAzsdnANbFVB9o0nEOMevBrf3Q7kAIP3LeRB/EZBY54/74p6TUZi+TI58Lksuab
	3JERrbC8Oqimhbc0R7b+4rJPrw/OmjLUM3zhkrCQuNk2En62J7GYIahd3+A/xJwo
	1sSFa80qsbrzgqMjOiMwbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731655299; x=
	1731741699; bh=/KHIJCRwzOdi4j8MF6m/+VqfUPJDplm6I9hlV0c/Eak=; b=m
	oX6P5/kd3lNmKNwZRJ+ng02krUkw4HXZpuWZJaRl6YN7jw5JDCFvFP7WhhQEH2Ee
	7syX7uU22Xkj2OVJkCpfOOxO9q+1wC1tlZPJTiXfwocGnKochN+5avF/yxF59JLx
	dW22I3+4JQoHxsx+VT6/mIjRr68W1f3BUAD3msqxv6ZA+zZibOjprzexpPK4qPWT
	moaFDdvI088MvbWzQOklW1fwZvBG+ZB6vCq/XtcsNgDw7BRWvocfCRs0PR5qLwuG
	CkHgQ627MKxCwlp310/4PlR9s6UjPMp03Gw5BxhHqTnfZKWJ896DjNaHjZGwFuIz
	CeSMojEPUb1XuDHukSpEQ==
X-ME-Sender: <xms:gvY2Z6Tl4M-CqAnyNBxTuNJey4sxR2MjorsdLBJ5H6eB4Jrzx0vwvA>
    <xme:gvY2Z_w6OcQy3mKJWxlB9rw8E60TlqtNcDmjYuH_x-hEy81LL6zbPHY6bk67kaSby
    v44GSfCWKwRBY-OVQ>
X-ME-Received: <xmr:gvY2Z33dDNfswcQPqZAB424qkC5yKRtATHFe1SZH8uccL5IeDINYmFafqZJaSDvrWixlZgOl394U9KTEa-EisqUSuYBQkZg-KBT47QNl4CtPua38LQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdefgddutdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpedtuedvgeekveeutdelleevlefghefgvdehveeuhfeu
    geejfeeljefhvdekheduteenucffohhmrghinheprhgtrdhinhenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggp
    rhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgrmhhsrg
    ihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopegthhhrihhs
    tghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepvghstghhfigrrhhtii
    esghgvnhhtohhordhorhhgpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhn
    vggtohdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopegurghvvhhiugesghhm
    rghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpth
    htohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:gvY2Z2AImPkrAq0sGVHQdnLss8VprxyK16etlgkEpgaNjD_OfDHCoQ>
    <xmx:gvY2ZziVBRLvspafjWUoN56u_z8nzcTZmX7mJ_WGuxFo4QiAcz_FGw>
    <xmx:gvY2Zyp191CmwauFn3lvnLijfRsGDywt-SzQ7RYiGa7MSiGM1anVZA>
    <xmx:gvY2Z2gw9q2k89huJTHCs6rB3ul_Gbo4Z8AJevBKoYM6xam_aOfgQw>
    <xmx:g_Y2Z4blW8wRWsS5VPXc97SeGei6QXob_W2tSzAPNw-FH7ps7KB7hR1k>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Nov 2024 02:21:36 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bf07462e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 15 Nov 2024 07:20:52 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 15 Nov 2024 08:21:17 +0100
Subject: [PATCH RFC v7 05/22] Makefile: generate "git.rc" via
 GIT-VERSION-GEN
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-pks-meson-v7-5-47ec19b780b2@pks.im>
References: <20241115-pks-meson-v7-0-47ec19b780b2@pks.im>
In-Reply-To: <20241115-pks-meson-v7-0-47ec19b780b2@pks.im>
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
index 28807f6586a69d6ce0abf1b20ce31ca58e9d02a9..eced752985caa10a21870c4ba638b4e6fbb3e5ec 100644
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
2.47.0.251.gb31fb630c0.dirty


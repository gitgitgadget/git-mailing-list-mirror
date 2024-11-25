Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61604192D9E
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 09:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732528640; cv=none; b=lQ+RQuo4Adf+BueuLL5QD0+6mv9NyIN+dHIxxzKmaIRrYFUNmpV4VEwoQm5CkbrBbwammr/1ypUud0KMFBax+neuVOUylctBq3Cvs5PF5Oou0R9+jLAxMn9sYyrDR9k/c/QU2r4lTvM32pcUTZw5Igu5/jQtI4x2GIcf2V+6XPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732528640; c=relaxed/simple;
	bh=7ML0pv2mbik6q5x196bLZ+CHd+sLfItTwHYU/v9W1YA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NpSj8TSSrDduG/V++w5ev+yb2aboEnkzM19aII1WEZne5bI43dGHHdXzTBxNpzV/Hu6uN8cA21ZfcKi/uetCDgIyWXsckRkg7qCsgHkMLRMEmA9SzP0lNhRAiYUTaNOG7lWmHx8y8LM9RUDxC3h3+yQUuCz9hYFyWvzqi8RXAEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=uhcJP9SZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ctzFRa9k; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="uhcJP9SZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ctzFRa9k"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4029325400D2;
	Mon, 25 Nov 2024 04:57:17 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 25 Nov 2024 04:57:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732528637;
	 x=1732615037; bh=sVv6D4yaWHKC/RIPbQQVWb4PyKDGAeXqFd+EIN9wbNI=; b=
	uhcJP9SZ8j3QrKqv7ZlIhW9FbQe8A67UjTdXiPA7i0X8vA4fTeqJ4tco1nz2K3R/
	rWCSwSxCdq5sgzkMaVD7RKOWYh35lNWYodKYneRTpDpflAfBoPm2QkdRAmLipNYF
	UL0TzcQGT+Kl835MjfnlHwaPMolE3LKZKn32H4OKjLZaCgWz3uQ3n7WnO3iAJKmP
	wVbYmOfgGslwnlJ3vBRDaqNw9E9K3kF7zKr4aIy7ngUCDyMU6U3afUlIUl/MEhcf
	YYrcnPJ1EuXQwEQBsOtICnhg7UPxSHj0grlVCTNDwIBTybDMPLmGhu175llMw154
	Id9IHBl1eor2YuyKGpIWgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732528637; x=
	1732615037; bh=sVv6D4yaWHKC/RIPbQQVWb4PyKDGAeXqFd+EIN9wbNI=; b=c
	tzFRa9k/rfrLdZHdQxYfdE7wBf5CvE76p4JEpk7CJa30C1y9ILwE+iJ/UYwU3EOE
	MQR354xTkkjmak5qkiaKQFT3/D5wGP0oTxXwUSKA+8T1RI4RBjdyZHTP4gWfVph5
	dhGQt1eZOjZWtTOoBvI5WDoUaehoYm3x+wFVooaZP+IP9suFeILpnuISSNpRXAz6
	yKjMffSt/CJ7U+Fet74aromczvn+Jnp5XSIlEDoeM7e0WVgteWJP0Z6k204FCjIw
	tXvdCS/UfuUvzzx/bQjfqrBrkHTilBxRs3AosPErar8UTnZOh4gmbWE4G9bQ/YK/
	DMa/DA6+fjrb8PlgCQAXw==
X-ME-Sender: <xms:_ElEZ0YqDHBP2DrKTb9tB-agp4bTRy5_Tx1Hz98Zx3cQAKPYhzld1g>
    <xme:_ElEZ_b_ppdsotPJeCkTsAy0sJhYis2E4ZniMti9NYhR3PA4MJGp6pMxjXsOKYldJ
    pOKQoaPsdsUj7ujCQ>
X-ME-Received: <xmr:_ElEZ-9XOt4fjV-5HIqiK9JqYQuxLB-LxQVEqykb8q76yRvH0niQJ82_ggcduNiSgnssYekBAHm2nOq77XrkDD7aQDXDOBso17gGyJyQbFzerA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeehgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnheptdeuvdegkeevuedtleelveelgfehgfdvheevuefhueeg
    jeefleejhfdvkeehudetnecuffhomhgrihhnpehrtgdrihhnnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesph
    gvfhhfrdhnvghtpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohep
    shhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehmvgesth
    htrgihlhhorhhrrdgtohhmpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghm
    ihhlhidrohhrghdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrph
    hluhhsrdgtohhmpdhrtghpthhtohepuggrvhhvihgusehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:_ElEZ-qWD6GWOXCHuJouUST7lOWHYkm6pOOtj9Lov8x-4--9bFoHAw>
    <xmx:_ElEZ_pBNd09BiX2ifh-SIajyCNNybO42FOyJVwQ_3-I3ksnv4sstg>
    <xmx:_ElEZ8RPUigWarBCMFAQKdtLeypDrAZtvta0ATTWZvUHh2YFTD74Uw>
    <xmx:_ElEZ_qfAxLp5UpXUjAZbh2CL5xg03P_gioUVx74mXSNU7KKqudFbA>
    <xmx:_UlEZ4Tb68Sy2iQKyYMTB2Q_kvr9dAlS1P2VgLTBUZrBYLhz1viIjJp5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 04:57:15 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e4ef7378 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Nov 2024 09:56:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 25 Nov 2024 10:56:53 +0100
Subject: [PATCH v9 05/23] Makefile: generate "git.rc" via GIT-VERSION-GEN
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-pks-meson-v9-5-1c6cf242a5f1@pks.im>
References: <20241125-pks-meson-v9-0-1c6cf242a5f1@pks.im>
In-Reply-To: <20241125-pks-meson-v9-0-1c6cf242a5f1@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, Taylor Blau <me@ttaylorr.com>, 
 David Aguilar <davvid@gmail.com>, Jeff King <peff@peff.net>, 
 Johannes Sixt <j6t@kdbg.org>, Christian Couder <chriscool@tuxfamily.org>
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
 GIT-VERSION-GEN                     |  8 ++++++--
 Makefile                            | 13 +++++++------
 contrib/buildsystems/CMakeLists.txt | 19 +++++++++++++------
 git.rc => git.rc.in                 |  6 +++---
 5 files changed, 30 insertions(+), 17 deletions(-)

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
diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index c18f24e515436b71ef40120b88b6fbb0b5621c01..a1c8146f05cfa7fbc6c47804aec5fb848e67c69c 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -58,14 +58,18 @@ then
 	GIT_USER_AGENT="git/$GIT_VERSION"
 fi
 
-read GIT_MAJOR_VERSION GIT_MINOR_VERSION GIT_MICRO_VERSION trailing <<EOF
-$(echo "$GIT_VERSION" 0 0 0 | tr '.a-zA-Z-' ' ')
+# While released Git versions only have three numbers, development builds also
+# have a fourth number that corresponds to the number of patches since the last
+# release.
+read GIT_MAJOR_VERSION GIT_MINOR_VERSION GIT_MICRO_VERSION GIT_PATCH_LEVEL trailing <<EOF
+$(echo "$GIT_VERSION" 0 0 0 0 | tr '.a-zA-Z-' ' ')
 EOF
 
 sed -e "s|@GIT_VERSION@|$GIT_VERSION|" \
 	-e "s|@GIT_MAJOR_VERSION@|$GIT_MAJOR_VERSION|" \
 	-e "s|@GIT_MINOR_VERSION@|$GIT_MINOR_VERSION|" \
 	-e "s|@GIT_MICRO_VERSION@|$GIT_MICRO_VERSION|" \
+	-e "s|@GIT_PATCH_LEVEL@|$GIT_PATCH_LEVEL|" \
 	-e "s|@GIT_BUILT_FROM_COMMIT@|$GIT_BUILT_FROM_COMMIT|" \
 	-e "s|@GIT_USER_AGENT@|$GIT_USER_AGENT|" \
 	"$INPUT" >"$OUTPUT"+
diff --git a/Makefile b/Makefile
index 7150ffc39c1b444a2c4775382f943c603490d54e..1255d222c2dec9a034dee2621192bf97afe905ee 100644
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
@@ -3717,7 +3718,7 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) -r .build $(UNIT_TEST_BIN)
 	$(RM) GIT-TEST-SUITES
 	$(RM) po/git.pot po/git-core.pot
-	$(RM) git.res
+	$(RM) git.rc git.res
 	$(RM) $(OBJECTS)
 	$(RM) headless-git.o
 	$(RM) $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB)
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 3cc5e318190292dd66981aa8593e7bd2739eea1d..865b3af9fb2c1e7bdc1e7cecd0f021ee460971dd 100644
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


Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3F11BBBFC
	for <git@vger.kernel.org>; Thu, 28 Nov 2024 16:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732810354; cv=none; b=eKnUg9q+Z935t/077ptk+W60uyNDTBminVHrg0x1sQEgnMComiGlza/SvcHfJ+SSRTL3CVm22fVnDmDPKe0U3k6t83DULDpmrnFV3r0v66BgoYUtVwevQwJrNY+Q9llpTlEN6oiDd2xFlzf8UFRrqrWOcboFYY6HmZAxNRFcgz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732810354; c=relaxed/simple;
	bh=3I6IeEG5ogKAjlJso7rDgTVMHLrF8fjZOejKRBlGqko=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LjPak38PHUDuBQroJDRk19N4pAXtelTycsu2g+OnA5VgTNdlcz40EQXAJauFowoUwEv6EynVy09XMN6WwFF9ZZ8QroeE4EAs0d0mKZIadDun6fbDF/fcdGKLC7j3tSSYEAfl025IRt0avKwYExnerPw9d+8dyJqO5MNuCEXhrYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=uIEdDat3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hyq9TBf9; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="uIEdDat3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hyq9TBf9"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 72A0D1380274;
	Thu, 28 Nov 2024 11:12:31 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 28 Nov 2024 11:12:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732810351;
	 x=1732896751; bh=tZ2dJiigwjnGxZbt1D6LoS5EMr/ORQryR4xHoEbUxSA=; b=
	uIEdDat3d3F7Y+bkvasFlh2k1BqP54USI4y9Fe6gQGRJwJlmDSAg11LPXtOmHoY1
	Gftya7ihwST04HdaPqxspFcp14mdeI9exNvwxHli8nrpUtXKZYMwP0A35yezLohG
	vXEP0u3hi/d9Ok6JNITWDydeBLkl3RfSJpAAmP1pQCXmvuoh+QcAp31bXdd74nEU
	m11LXJTwsZAQyGKqwq4LLBMl/W3CMQRYaMX4gPhlNB0mxR78Dt+/b52URfQHM8lN
	Yv6ZwNv6cTK2tfflFMMlI/c/RBP9V+1jcYlMcdC+WOPn8pXL4cgIncov3owHUIz3
	KoK3NTKLGNwgmHf4ARRw+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732810351; x=
	1732896751; bh=tZ2dJiigwjnGxZbt1D6LoS5EMr/ORQryR4xHoEbUxSA=; b=h
	yq9TBf9hIRdFJFQ5roRuHQY7ih6a4Ja3CPLNecgSE+n4cDWcPlEuhO5nhLhWs5u3
	n4pzDI/Tx7OjvrgBdoTmqM3naSjFk+uL9b+6bOWWahAlM9a3OMQgbjmh+CzEHgyx
	tmnPLKZuJTANj7n0yqob9pTwAKK4z9aPN0h35mt+46sAgTqtKm4fBSd7k3EDPifn
	S4IArSnPXkTWKWgENGO8OAuIGjTzRsx10dqZz7FvaMYA0/uf8JZmtTvn9edwVwgB
	UASKh+15f2p3+TiBDramciCHzEIN81XknUCUUlMZAkWv0rwPojEU2tjuoumDKVeb
	0d2tvyP6yKXK0Js2s9Gvw==
X-ME-Sender: <xms:b5ZIZ0wRJ4EZvlvaeUTtxEUSnBc3D-ChTemf0kzywfDojP3QJlgtTw>
    <xme:b5ZIZ4TBMjnOIunVWXoBvyRvbOv8hTxs6oeECaT5DHYPf1F6EhnpIpbwKov2OA5W-
    plqFCRPc6jlI9_Psg>
X-ME-Received: <xmr:b5ZIZ2VVicmJeXbPudezL0OD26LfmPU0CQLAc5TzXLRxlq7A8He4EollJJ2ntbUaVWhPPkIZcvXTJ0_oktBg7_Y24eeN5RTRBmim816-g4TQKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrhedugdekgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrph
    hluhhsrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphht
    thhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopegvshgthhifrghrthiisehgvghn
    thhoohdrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomhdprhgtphhtthhopegurghvvhhiugesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:b5ZIZyiGMcbgVG1LughFvjD-GhyolIKNW9uKCP_ZD38PZeodzoJujQ>
    <xmx:b5ZIZ2DTwXqUkJLpk3145vNEsAL5X_f4-qFsi2x6arDTd9CqOM2Gsg>
    <xmx:b5ZIZzLc1QXlTG35U5m8CAc7XKFVRR_WrI0XwSiDkgTUlML_P-ha8Q>
    <xmx:b5ZIZ9A-mWyqikwiuwCrUjDb34teaZCLiLd4RNlBiL-_Etxf4RpfmQ>
    <xmx:b5ZIZ3JfQ-xgRlWbqNvpudZQdn1-xY_nXG87t_t-D6JI1yLZyn-s8vtR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Nov 2024 11:12:29 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a7c3c743 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 28 Nov 2024 16:11:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 28 Nov 2024 17:12:05 +0100
Subject: [PATCH v10 04/23] Makefile: propagate Git version via generated
 header
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241128-pks-meson-v10-4-79a3fb0cb3a6@pks.im>
References: <20241128-pks-meson-v10-0-79a3fb0cb3a6@pks.im>
In-Reply-To: <20241128-pks-meson-v10-0-79a3fb0cb3a6@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, Taylor Blau <me@ttaylorr.com>, 
 David Aguilar <davvid@gmail.com>, Jeff King <peff@peff.net>, 
 Johannes Sixt <j6t@kdbg.org>, Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

We set up a couple of preprocessor macros when compiling Git that
propagate the version that Git was built from to `git version` et al.
The way this is set up makes it harder than necessary to reuse the
infrastructure across the different build systems.

Refactor this such that we generate a "version-def.h" header via
`GIT-VERSION-GEN` instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .gitignore                          |  1 +
 GIT-VERSION-GEN                     |  7 +++++++
 Makefile                            | 13 ++++++-------
 contrib/buildsystems/CMakeLists.txt | 16 ++++++++++++----
 version-def.h.in                    |  8 ++++++++
 version.c                           |  1 +
 6 files changed, 35 insertions(+), 11 deletions(-)

diff --git a/.gitignore b/.gitignore
index 6687bd6db4c0a6adf02292a9cb545d3e5270e2b0..e17963e84252fa094c10f5e84c0e3724153c819c 100644
--- a/.gitignore
+++ b/.gitignore
@@ -195,6 +195,7 @@
 /config-list.h
 /command-list.h
 /hook-list.h
+/version-def.h
 *.tar.gz
 *.dsc
 *.deb
diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 7afc7aad1413d552cbadc68b7582ba639faa4d8a..c18f24e515436b71ef40120b88b6fbb0b5621c01 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -52,6 +52,11 @@ else
 fi
 
 GIT_VERSION=$(expr "$VN" : v*'\(.*\)')
+GIT_BUILT_FROM_COMMIT=$(git -C "$SOURCE_DIR" rev-parse -q --verify HEAD 2>/dev/null)
+if test -z "$GIT_USER_AGENT"
+then
+	GIT_USER_AGENT="git/$GIT_VERSION"
+fi
 
 read GIT_MAJOR_VERSION GIT_MINOR_VERSION GIT_MICRO_VERSION trailing <<EOF
 $(echo "$GIT_VERSION" 0 0 0 | tr '.a-zA-Z-' ' ')
@@ -61,6 +66,8 @@ sed -e "s|@GIT_VERSION@|$GIT_VERSION|" \
 	-e "s|@GIT_MAJOR_VERSION@|$GIT_MAJOR_VERSION|" \
 	-e "s|@GIT_MINOR_VERSION@|$GIT_MINOR_VERSION|" \
 	-e "s|@GIT_MICRO_VERSION@|$GIT_MICRO_VERSION|" \
+	-e "s|@GIT_BUILT_FROM_COMMIT@|$GIT_BUILT_FROM_COMMIT|" \
+	-e "s|@GIT_USER_AGENT@|$GIT_USER_AGENT|" \
 	"$INPUT" >"$OUTPUT"+
 
 if ! test -f "$OUTPUT" || ! cmp "$OUTPUT"+ "$OUTPUT" >/dev/null
diff --git a/Makefile b/Makefile
index 73510d6bcbc9ca60d45b70459f9e1c79f19b4c09..7150ffc39c1b444a2c4775382f943c603490d54e 100644
--- a/Makefile
+++ b/Makefile
@@ -2508,13 +2508,11 @@ PAGER_ENV_CQ_SQ = $(subst ','\'',$(PAGER_ENV_CQ))
 pager.sp pager.s pager.o: EXTRA_CPPFLAGS = \
 	-DPAGER_ENV='$(PAGER_ENV_CQ_SQ)'
 
-version.sp version.s version.o: GIT-VERSION-FILE GIT-USER-AGENT
-version.sp version.s version.o: EXTRA_CPPFLAGS = \
-	'-DGIT_VERSION="$(GIT_VERSION)"' \
-	'-DGIT_USER_AGENT=$(GIT_USER_AGENT_CQ_SQ)' \
-	'-DGIT_BUILT_FROM_COMMIT="$(shell \
-		GIT_CEILING_DIRECTORIES="$(CURDIR)/.." \
-		git rev-parse -q --verify HEAD 2>/dev/null)"'
+version-def.h: version-def.h.in GIT-VERSION-GEN GIT-VERSION-FILE GIT-USER-AGENT
+	$(QUIET_GEN)GIT_USER_AGENT="$(GIT_USER_AGENT)" $(SHELL_PATH) ./GIT-VERSION-GEN "$(shell pwd)" $< $@+
+	@if cmp $@+ $@ >/dev/null 2>&1; then $(RM) $@+; else mv $@+ $@; fi
+
+version.sp version.s version.o: version-def.h
 
 $(BUILT_INS): git$X
 	$(QUIET_BUILT_IN)$(RM) $@ && \
@@ -3728,6 +3726,7 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) $(FUZZ_PROGRAMS)
 	$(RM) $(SP_OBJ)
 	$(RM) $(HCC)
+	$(RM) version-def.h
 	$(RM) -r bin-wrappers $(dep_dirs) $(compdb_dir) compile_commands.json
 	$(RM) -r po/build/
 	$(RM) *.pyc *.pyo */*.pyc */*.pyo $(GENERATED_H) $(ETAGS_TARGET) tags cscope*
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 376d748ce9021710eb72258ab3b9bac52950a933..3cc5e318190292dd66981aa8593e7bd2739eea1d 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -229,10 +229,7 @@ add_compile_definitions(PAGER_ENV="LESS=FRX LV=-c"
 			GIT_HTML_PATH="share/doc/git-doc"
 			DEFAULT_HELP_FORMAT="html"
 			DEFAULT_GIT_TEMPLATE_DIR="share/git-core/templates"
-			GIT_VERSION="${PROJECT_VERSION}.GIT"
-			GIT_USER_AGENT="git/${PROJECT_VERSION}.GIT"
-			BINDIR="bin"
-			GIT_BUILT_FROM_COMMIT="")
+			BINDIR="bin")
 
 if(WIN32)
 	set(FALLBACK_RUNTIME_PREFIX /mingw64)
@@ -668,6 +665,17 @@ parse_makefile_for_sources(libgit_SOURCES "LIB_OBJS")
 
 list(TRANSFORM libgit_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
 list(TRANSFORM compat_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
+
+add_custom_command(OUTPUT "${CMAKE_BINARY_DIR}/version-def.h"
+	COMMAND "${SH_EXE}" "${CMAKE_SOURCE_DIR}/GIT-VERSION-GEN"
+		"${CMAKE_SOURCE_DIR}"
+		"${CMAKE_SOURCE_DIR}/version-def.h.in"
+		"${CMAKE_BINARY_DIR}/version-def.h"
+	DEPENDS "${SH_EXE}" "${CMAKE_SOURCE_DIR}/GIT-VERSION-GEN"
+		"${CMAKE_SOURCE_DIR}/version-def.h.in"
+	VERBATIM)
+list(APPEND libgit_SOURCES "${CMAKE_BINARY_DIR}/version-def.h")
+
 add_library(libgit ${libgit_SOURCES} ${compat_SOURCES})
 
 #libxdiff
diff --git a/version-def.h.in b/version-def.h.in
new file mode 100644
index 0000000000000000000000000000000000000000..347995df0611e19428cf96ec9539f0dcfea999d2
--- /dev/null
+++ b/version-def.h.in
@@ -0,0 +1,8 @@
+#ifndef VERSION_DEF_H
+#define VERSION_DEF_H
+
+#define GIT_VERSION "@GIT_VERSION@"
+#define GIT_BUILT_FROM_COMMIT "@GIT_BUILT_FROM_COMMIT@"
+#define GIT_USER_AGENT "@GIT_USER_AGENT@"
+
+#endif /* VERSION_DEF_H */
diff --git a/version.c b/version.c
index 41b718c29e1b9fc2981d7d14a3d25e69c31a3030..7adc4d51ff25a0841607c21807deaf20721252de 100644
--- a/version.c
+++ b/version.c
@@ -1,5 +1,6 @@
 #include "git-compat-util.h"
 #include "version.h"
+#include "version-def.h"
 #include "strbuf.h"
 
 const char git_version_string[] = GIT_VERSION;

-- 
2.47.0.366.g5daf58cba8.dirty


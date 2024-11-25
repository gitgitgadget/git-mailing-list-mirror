Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200EF192D8C
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 09:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732528639; cv=none; b=dZGjic7SNoD08Aq+7fEXmrfb+vgN+OX9uyh1RvhpBi8C8bcCHiplGNc9tjdzfT63JU9KGDD6iw1nhPXyOj9fuybdki8Qp0+DZsneEPjQ1CMT15sCmPztCuV9vumKURKpj1tb57FL6rxziGkVZv0K8l0nKSz5Vxdk6ihdpvDFlOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732528639; c=relaxed/simple;
	bh=Y+wy8wpH+wpjcV1g6uNrAfZKZsYI0XJIallx/s2o60w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HY5FALuz3I6ZBlo5mW0wvjyn31SUvJ/Q/3sYHq5vqrNTbEhmgplTqYAkORxdZzZ3p5CpmjYYXCtUuUvLOnjhNRTpShwXfePhhFuGL/vYEVyjILWOBl6YEMUGE/WVpAo5a6O4PvOHF0ygWoNomI6DxeIXpRciTo1qNJ0avFSdljM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DdyEU6Oz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NrEiZu73; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DdyEU6Oz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NrEiZu73"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 05B4B254012D;
	Mon, 25 Nov 2024 04:57:16 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 25 Nov 2024 04:57:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732528636;
	 x=1732615036; bh=jV4M7ku+EOP8tu7/nw7UZfWclRfTq3FjyhD7p1ObOVU=; b=
	DdyEU6OzJOfBPlIDX6wy/fdmIP0oanK4XdOI9vK6KOI5N4eNyBHV7ubfDzqXGkSU
	5DmkiBAFy7G1TLZMMRhSi6Za70uzc6hdaM8Nj5w00+H3VwzVVSM8RERoNpwrT6qH
	rbujLGY/iCeffufzimXA8Gy34xVYFrSwylBrDsnjiaA9Ge5RXMDKc1WmnXhdAcCT
	SGp3PP3OGm8QmfOubLr6cwT4dD5DYZYdy+163vGxl+96zth1w3la658p8mOtp45M
	o3dEfHxk/tPByJVHj/+TBQ+7wXZ6uCbknHF+LYu/aSS0VyZrx3waaTOI75JGxPNw
	0tZdMTHjpauQMkBQ86iDNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732528636; x=
	1732615036; bh=jV4M7ku+EOP8tu7/nw7UZfWclRfTq3FjyhD7p1ObOVU=; b=N
	rEiZu73zzDySxUzuHN7Rf82gsGCk/M1fPSgn5gnaWlKZSqN5tchdEVJpNfR2n2Dq
	riV06+X0VOZqnjrHrM9x6E17IgaWj0DsCZhUDYqwE+w4wCru6JnMkOWguq28JsjB
	MJJ+1dONtgWKgnbG88Drb9wmxGSuVsOih7MNFX5bT3tSoGJ5xx3H7RBjtFFjHH32
	WeCyjsp1Ah6yV7MCeXmogvFQNKqi24MPRx2QI9s65u1OTXrtKcwcnovCiTyTNIlg
	szfDuQ0+FqFn8qDzz4kdmDxZjgKUzvTbJBxCwf2VhM9QzDbtQ0SY+A1DdxRwK8IZ
	4odmXng/J7jhaC8k0Ym7A==
X-ME-Sender: <xms:_ElEZ5dmC6igDJYntpKOwRYukiPBtw-4bo5uaDUYCizK_Ve5AUX40g>
    <xme:_ElEZ3N0MJhJ8Wd-O_yDWWRVPk4aPn_Xr6sX1dil5ftUtglKtxoLATojhX35HZe-M
    hDH9KAl5UGgHG4tEA>
X-ME-Received: <xmr:_ElEZyg_pWCegpckZDqV4bIQfaxOP4340kXwGq7T6CTQIoiAlVHZMlIvUKZ1ifD7-vCeUiLcIBFWIMeCjyiq9EFGJBn9vDNxkyJ-YZsk9sp-yg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeehgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgt
    phhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoheprhgrmhhsrgihsehrrg
    hmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopegthhhrihhstghoohhl
    sehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtg
    homhdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphht
    thhopegurghvvhhiugesghhmrghilhdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvg
    esshhunhhshhhinhgvtghordgtohhm
X-ME-Proxy: <xmx:_ElEZy9A3crp3C33RiX9matSBmrXLmqCWnr8Fb5JnFhzw6op_bYuSA>
    <xmx:_ElEZ1tSdlFy3bycv5WcJkwNKGOzfU_RahNXs-d5qgmkgpgZpevJAg>
    <xmx:_ElEZxFvKVRbau-TBJ4m4JwPZQZALFD9EVT3Ef-uZRkSTvNfiUKLeg>
    <xmx:_ElEZ8Mht6N5jm_90P2MtbnbVVhMTP25JNd_ZCfsavZeXVLxPrBdtg>
    <xmx:_ElEZxForaP35n04sC7oAlJifvIRTmShmtqnLioe1jJR2n3XpDbKUiop>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 04:57:14 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b341393c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Nov 2024 09:56:09 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 25 Nov 2024 10:56:52 +0100
Subject: [PATCH v9 04/23] Makefile: propagate Git version via generated
 header
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-pks-meson-v9-4-1c6cf242a5f1@pks.im>
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
2.47.0.274.g962d0b743d.dirty


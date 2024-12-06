Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DD4207E02
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 13:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733491528; cv=none; b=W+CM+5fU1OqW3FIouVw810KtQdkD+xhG+7QJ1z4a94+Zlm7tGBDB0rpZcoaymzempAb2ZJ0gz0LPNRkCuwPytWjWFGzj6AyZOfplcbCa1tw/vIHoISZq1PnYbSZ0ZvoJ4WQY2vnwRAdszjgVu7QdfSidQs0V00JRc5NO76/5wE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733491528; c=relaxed/simple;
	bh=+i0FovYi1amnC9qzA3KaZwDFHk2Db1bwvMuaOkZwdy4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UflnehkRxaxR5cEqNpJZwpMLjh0+VM0yx5HAk4x88bvsFslxuWYrCs1J1xYE2InivZdIXRxe7tMhEu+k7bQAdDTwc1gUFllLq7OE/6of0G/u9mhmYhwfC7WQbW5EtkQCOcXcbjE0q/Jg6OLxyUXehUYrypo90Gd1GJ82ncOWa9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QhhdrH6V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=egL652Cg; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QhhdrH6V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="egL652Cg"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5AA652540164;
	Fri,  6 Dec 2024 08:25:25 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 06 Dec 2024 08:25:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733491525;
	 x=1733577925; bh=jNO7ulr6uyL+kJY8eJEMC3LirRE/OgIhPQhp9M6tpTg=; b=
	QhhdrH6ViTGZR3iT5ngSzBOnWrKPperFLPx/aWb6mKR9Bkb5XQbp139G8ANXbF2S
	ei4ecyFJ2PwiuxYjl3kIdacMqbmQWCMaCr9SJlEoJhyck2vKH1d0PNHK1sxvJT1I
	FxwxyOE31bkjbfdeMx1jmnzWIMfRg15IbD7C4fK7Hls26vY7l9lu6aqTjH1a9SvD
	bDXFJ0+/Bm4tTEb2A/An+Wu/ZJJqwhRa4PClMV9mHeIOj3Qr2jwwWsjFWUOQLaDa
	g5Uu0aA5QsEKFXNO5cdSGYs8W1bW3E5YzFXm78CmjXjSrzpIyFs6J33RuMth+m/x
	pRpgNTwNVLfZWLNG+Pqr8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733491525; x=
	1733577925; bh=jNO7ulr6uyL+kJY8eJEMC3LirRE/OgIhPQhp9M6tpTg=; b=e
	gL652CgjGN3bI9lMdlrJ9pvf4cH+KFR4lFbrXopzuU0JaTfH7byf0V3NV3d2EoPC
	BUhtbonHH/3O+B4FABkxUccdq/lpUjtVZEbXWd34GEIt5WS1ND8lzH/WcdySOs+9
	4tjnuiVDD2xSou/mrPONmvMyryxb/FwqIyXy7Ls7rFFVTW6MKNk6hkeXOEQqYhNs
	j3X5R6vMqu2IgbgU9poR+tXy5HmhFNl6798W3UKw33r6BpXVDsz0g3BTSMKLxyPN
	SCQJUOUstapmNgRqQpIas+V+9c0UwheOqBqh2IYYcDefhBkzUsMQYguz8qWal8c8
	T+26osrTmsSncXVlmWRjA==
X-ME-Sender: <xms:RPtSZ_aQdFPZgMMof9_gXXgwhhXqjKJe7xiPYWcBWiblURfL5SUNKA>
    <xme:RPtSZ-bYnIFrEndkOZ_W0gKm2AkUheuOnzC4W0US05EOqtWudqYd6NOsoMO_VrtfX
    6WX4E6LgFcPzvqFow>
X-ME-Received: <xmr:RPtSZx9WD3qOlLTK6TURxdo8jp68z7q_nmN_Zp3aZTFVdSUrjcUZjqmJU9FwqTQQtv1h1oJk-oJOfzDtVB6LjvOBvY4JDQl3yLmd98hlsUJzpA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieelgdehtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghord
    gtohhmpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdr
    tghomhdprhgtphhtthhopegurghvvhhiugesghhmrghilhdrtghomhdprhgtphhtthhope
    hjiehtsehkuggsghdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhm
    pdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepphgvfhhf
    sehpvghffhdrnhgvthdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdroh
    hrgh
X-ME-Proxy: <xmx:RPtSZ1rxXkvNe-SQelvflN939uWkDuSVnigehSbe6RNjieKcM8GwVw>
    <xmx:RPtSZ6pjfyuWZ3576c7Lc6E4PQ4MhIJ-JiMMNRBCmnsXTWp0iu-Xnw>
    <xmx:RPtSZ7THZsa94_gNjmq8hEpXNT7lxwdFdZs8cXrsOAQFfwcwE-5U8g>
    <xmx:RPtSZypRvHXmQ8tuUn3QhZN1pbr6kN4TobfAWaaveFTPVizAoPclXA>
    <xmx:RftSZ3Qvzmnfng8006DR7nZUQplpIDCAeeTNISb8Pibz7G7QopJe7hVY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Dec 2024 08:25:23 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e88d2e10 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Dec 2024 13:23:56 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 06 Dec 2024 14:24:39 +0100
Subject: [PATCH v11 04/26] Makefile: propagate Git version via generated
 header
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-pks-meson-v11-4-525ed4792b88@pks.im>
References: <20241206-pks-meson-v11-0-525ed4792b88@pks.im>
In-Reply-To: <20241206-pks-meson-v11-0-525ed4792b88@pks.im>
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
index a529df85ad4c68f6db981c8dc05540e9e4991995..53b98eccbacb8ddd65020d9aebfee532e92d2196 100644
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
@@ -3729,6 +3727,7 @@ clean: profile-clean coverage-clean cocciclean
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


Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21EB187FE8
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 07:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731655301; cv=none; b=hRoWS5Akpbzfyh1UtXflEPIN9IOOjL9bAwUEl3qs03MNrCQhpDwUtzdFdhNmOEq7GN/I0rvutlpvf6RWINJeo4GTeiKMq5ArwKQm4xOeirBn6+OQSPKiCbChUk4jJcLDtiKm7gSDRgdzIg/sZn4XSPLtDu9yzLEyrrBIAr2XzR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731655301; c=relaxed/simple;
	bh=LlP/s0JDltEWbrQ+RUkdN5bjtLwmO+vyztFIhJ5wAjQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IQf+JgyFb965L/crhe275RcpjqCSr8E6OclYhgVNg7U3JquC5HYyJby31jmGv4uv+OQHlFn0mrNSfEhkqJ9z7QQUJt07DSEEXNeOLk328PksJ2UmCgfePfjNP6rrT6+0cC/yGSfFeO5Te8hRVzm1/6GvEJQeaaEwMALyd5lnb7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=P7WLra5R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GWvfg2j4; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="P7WLra5R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GWvfg2j4"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 104DB1140107;
	Fri, 15 Nov 2024 02:21:39 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 15 Nov 2024 02:21:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731655299;
	 x=1731741699; bh=d/M5LLcU/hdPXaJ2YMbWO63Frz6oPPvm+w3/Omu7USU=; b=
	P7WLra5Ro7TgYmXJCXvrFP8lq4+J3k8G2EOyB2+9rtP4kLu08VKU+NDVgA3vY/v6
	yMDhG12N58btIa0J1E1f5lYDOKn1PelM/5ZI8MVZpbioApcAJPYT9zIvIhpU38+8
	XTYj8kXzNPS5t7vvUsUWoWgCJprScg7cD6pft/SK4YVV8akCH9AUVLYi1sbWPCCO
	4A25wdhgT1soaeYvCDgUqXlBQGdelnABx2eEUr60Ev+UXqdWe9e81WqFrqHJ0/2U
	cgKe9GB7JtIkSC7zlULm0T6R/qn5sdxReIhGrHGeRWKyUhv1R12IxbP1zOXRt/SK
	t4jJC6A3/pIVfQ4z8n0v+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731655299; x=
	1731741699; bh=d/M5LLcU/hdPXaJ2YMbWO63Frz6oPPvm+w3/Omu7USU=; b=G
	Wvfg2j495Uhn2GOkuFEUAnIcpeQZ/7/MvQ5H8rnz+hAOj1wxJdYQd5v+863c2DmM
	LUIeouk95RzmL1M7I+w6UoUspa/mHfDGNa1la1bhh+G8T5oO0UpwLWC/87yZ3Pna
	YuIzrApZcjAPKdLR2FpAMa+mJNob5DATIBphTD1o8Vg4k8Ntj/R9QD/mMxgDvoZN
	H0RVjiGGe8Lih1piRbWRO/D+Zcid5IhiZLIrHzUYstj7ui9v4ohLmmqgvm3b5ZR2
	1WuskKXXRnePaDjQl8/gzsV6fd1ZNd0MtbZbfKv105pxkPpizjc5pPonFWTIo6y1
	TvsKPwci1PRjV8rkSTPTw==
X-ME-Sender: <xms:gvY2Z9HsIg3W0a-HtWCFCek9GXjFISHJfdfxy6fAqS2NX3LOqLMviQ>
    <xme:gvY2ZyW3RM_yONIO2CGzgEjsnElfK0pOzngceIuGRHrj1ghK0e0xgLYGO-rKjIb0S
    rnNHtmZVGTRQiSDKQ>
X-ME-Received: <xmr:gvY2Z_KQSeA2iEwb6Ipv4JnBlDLXb-1udGaMvVR9tqiMYXl43V_vrMLJYwMRVtYoPQwnXGHswts3gbjJLfbZoDLN_ASMjekeQCp8E5wPYLLHMeg-sQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdefgddutdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedutddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtph
    htthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepuggrvhhvihgusehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhg
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegvsh
    gthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopehrrghmshgrhiesrhgr
    mhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:gvY2ZzGPh1eLl9rTgLI5joVAygkYaPPiHhODey4DwaBHYzNDj4f_rg>
    <xmx:gvY2ZzXCzcq38WX3pwGZyuLekUq9qGxhkjj-Cy8s5r5lUumZ7Q-krg>
    <xmx:gvY2Z-Pq2bW3B2hBbmMehm6OUSpuVwFuUpA5VVq48ZjrDF5tEeDMCg>
    <xmx:gvY2Zy2GsgyqcllHIn9btfk9cFsIq0nntHFFIhfbvrNzohTXQLNT8Q>
    <xmx:g_Y2Z8NLLYr2slZk3s22KOz51CvFgMP6C_z57SAzpvE2NIN1fZuLuvG9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Nov 2024 02:21:36 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1fd594b3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 15 Nov 2024 07:20:51 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 15 Nov 2024 08:21:16 +0100
Subject: [PATCH RFC v7 04/22] Makefile: propagate Git version via generated
 header
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-pks-meson-v7-4-47ec19b780b2@pks.im>
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

We set up a couple of preprocessor macros when compiling Git that
propagate the version that Git was built from to `git version` et al.
The way this is set up makes it harder than necessary to reuse the
infrastructure across the different build systems.

Refactor this such that we generate a "version-def.h" header via
`GIT-VERSION-GEN` instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .gitignore                          |  1 +
 Makefile                            | 12 +++++-------
 contrib/buildsystems/CMakeLists.txt | 16 ++++++++++++----
 version-def.h.in                    |  8 ++++++++
 version.c                           |  1 +
 5 files changed, 27 insertions(+), 11 deletions(-)

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
diff --git a/Makefile b/Makefile
index 6c55c47e961047a8e9a80ab948e21c7466cf54de..28807f6586a69d6ce0abf1b20ce31ca58e9d02a9 100644
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
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 752479cac59d3833e7fff9239ebea75179692bf4..b9ebe2ef74e37d5fad51f6e23aa234c563cad392 100644
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
2.47.0.251.gb31fb630c0.dirty


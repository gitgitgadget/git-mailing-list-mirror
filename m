Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377191CB9E5
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 11:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732017066; cv=none; b=T54iBTvjM7QeFIDz84v6MZ6mSe+BoUmUTrxkwiOOHOjpq12O/DefMj1HsiJkTPRgwuj0ZYMZdEcq5mDNq6EfRTGsmum8c/p8D3hGAZd5TBsN8/mEYQ793kmZK3oz5/+1LH3J44u3KoYYM+pdtKId5L96Zl/eTOD6MRWAT0oeDJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732017066; c=relaxed/simple;
	bh=IpmfOl8uP66eHD9rp/wV2L8u9BKuyDUdgVw641j5LRw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kF8oDdswyrtWGAh3G7G+vRi3QklMNQ7fv2rZkJe/svNV0nCm2MptBxyd3ifO7VTurX8xFyge51Q7seHtSgchSDA6P+ZzhOT8xkJ/QVPj4txQEDZTFV+3Nm9iOlZAuogbDlZNaQ32I+IYMjD6ZJ+XY7UA/kduFH3UHfr6QQvYY6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BdSsXr2h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FnqQAmWu; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BdSsXr2h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FnqQAmWu"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4E70A114012F;
	Tue, 19 Nov 2024 06:51:02 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 19 Nov 2024 06:51:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1732017062;
	 x=1732103462; bh=nI9cmZvhJJd8PekEDkAMSfflCJfVxxywTvkf9WK/Uaw=; b=
	BdSsXr2hbL5U6PAEvAUhN2sJh2Tn/vX4W21K+WHncoEhpb9nZNrecz32sxh9spZ2
	1h2lFcRDQSKgie7d5+JD0nalpiiqlmU+5LLrxEZtv61FkToIvh3nKI8FR+nqjJ+l
	BPnBPjOvoSpbn67yCJoR65iYAXM3OQGb7IY05z5HOL2zpyFTc/zBR1Cs+zyRvNXS
	KBmWrK/pCSA60Su28pv4KPHYKryRw3EL3cwrvFkMOTyyIEn27sWJy94YQzQbInaf
	pb3a2hG4yleqV0+qybNNunIj7BdbMhW7Jv5hhGTuFXWCij1a4/FYTU+YnhrAKYoF
	JWdsP3pTFlDQc26yiNqC9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1732017062; x=
	1732103462; bh=nI9cmZvhJJd8PekEDkAMSfflCJfVxxywTvkf9WK/Uaw=; b=F
	nqQAmWudMIy+yhWEVzWLvyyQtoNVC0vrSazDCAapBFL7hfJqwCrMyOt4r4/DdX4T
	OjDomb7RH7pf/6efFlvw0+bzu2+qQnsTZIPXyKTf6xSrZob+tsPe1cqlbPi0yHpC
	6/nMd+OmjfLtpYdcXqYHiv1Bq7f671nEBYdmwi1paxBG/ZAxmqecqB2/W/+ZMHo7
	TjtKYkWYQtjL+mfqD/SOEDhUcYq2h7DufEYY3qJo+A5XyfkJM+tCu9dlV9fq3WO5
	2VC0BNQzRv+hpObqdwDFtEwHdC1JSCXxtj7rWh2YMVC9xELM5jXALnVU7qIUWG2f
	mQxBxt+bdlCpuEmClbk1A==
X-ME-Sender: <xms:pns8Z7oeADB5CSJc9e0HBM3g7bmynW22jDt9TFmmB5hHfjp8TYx8uA>
    <xme:pns8Z1pNFnPDrMkMQQCbmGU5czJ45yjDAZQxFFN35GzdexFQiwkrzy9SnKa_DXtvz
    gqiTypkewOOSuVM5g>
X-ME-Received: <xmr:pns8Z4MjVlyFYD4gyaRdmJRSxPHDrb2VTcWQJWNiJXVZdCSaAOKxbN7Fsnz7LYWtSWqcV_q5WMH_oR4EnlMR3bK0-gk6O6qGDP5VVCwsVuxk3XQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfedvgdefvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrd
    horhhgpdhrtghpthhtohepuggrvhhvihgusehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    phhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehsuh
    hnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepvghstghhfigr
    rhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorh
    hrrdgtohhm
X-ME-Proxy: <xmx:pns8Z-48PFDq2esKtpvHE7kOXQ7G9JhEa1XRCqXNlq81TlE8ZMBfPw>
    <xmx:pns8Z66JDxQyYt5eX3FRN2GyNHwFg2UZO6B-cC6UG04e2WpdqtuXuA>
    <xmx:pns8Z2iPntEh1h3bDdKnYvbDxURjdIQdHBeBgOj05HCD4w_Zl7D2RA>
    <xmx:pns8Z84Q2Iv5epf3SOtTay87h4eVa5eGgfkpjnSCPWfSR6aHj2oaLA>
    <xmx:pns8Z3zjQ2qRjXQmjcY_7A2OsAesGNxHSS42sNg5lgH2oSIQ94sB34_w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Nov 2024 06:51:00 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4905de20 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 19 Nov 2024 11:50:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 19 Nov 2024 12:50:41 +0100
Subject: [PATCH v8 04/23] Makefile: propagate Git version via generated
 header
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241119-pks-meson-v8-4-809bf7f042f3@pks.im>
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
index 456dfa0311b53627e6f5550c36a503808a4e5e3e..ede181f92708a1720027b25e30b74178ec1d45a6 100644
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
2.47.0.274.g962d0b743d.dirty


Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFAE320CA4
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 09:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758620739; cv=none; b=rIUdpwL5cYoP/9Sgl5xa0yEMRo0N6s+6wnCRkQZqbu/GNx1khIBigmp/FA4lTPYLrnpB0ZkmnrB/7InUfA9U8xfNpYi4h97KpjjpzyuYyppuA49GgHPhGgQhTNdMVJoVul/Eft7dIGYbAz9ZCo71Xx9Wk+ga+DM3TE8C3f2hN9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758620739; c=relaxed/simple;
	bh=+wuCjkIb9RvkHGA1ACtf1EPHbpKcL2jPBN4Ym2xLoTI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n/6nff9A+4MVdEmWp9BXIRN6lgGolAyILHF8tlXGVJJVMS+YzMNyIj6t0WebKbglWhgFBrObMy//UHyqVfZWFf8zJUPq8m0L48GI1iK3EsNiWYTAMV2A3lbsXPPynJ5RRsI1MDqGwjmNQrY67K77kkxRxgMYETMxb7QsWz5kd6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=U+hvBVzp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OhrOos/o; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="U+hvBVzp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OhrOos/o"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 9B3311D0029F;
	Tue, 23 Sep 2025 05:45:36 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 23 Sep 2025 05:45:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758620736;
	 x=1758707136; bh=+u99EIfnu/1eeux90BzzZXXskYWiKISpUzBf4Hbu1m8=; b=
	U+hvBVzpmpWwbW2jySdSvHBmIlmJDxL3U/oOZwMKbL6ujNH71KyMzkk90YljUp1w
	JQYKKdQ5/zunNYfVnTDbkGkItNRzvaD/hCiDSxmw7HRzhH/xH0zYgDXZbaSoGE9j
	fk+4DxNsHwk5VL9Vocl3oH1UGZKllsKgu5B9zxbD+Su2mlKYwRBDTXf6aEGbgKCU
	eY1Ha+FIGlVYqDYi3+wFIDj+KNzKflfgIQjXOr3fsQmdrFYQB5VNjTd9UwFJvWfM
	LTRxYLtOk1WXecvLz02GJEJ9nNmBLOb0fQyTXREBdXL/FOxvCJFwLATGpzXgDN88
	6TuP7qet78ssL3UkqR75/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758620736; x=
	1758707136; bh=+u99EIfnu/1eeux90BzzZXXskYWiKISpUzBf4Hbu1m8=; b=O
	hrOos/oeTu2GYvtxdUibAMPwf3JTLWPWncWRj6IYt3fUE5JUK6pndFVCqKZDousa
	QdWlD0J+q/0Hltw8rUwg16pCZKlXtzA+q0TEZkbNtnDU1fuGFLEzrYVX3ZT8d8LQ
	uoeI1tpxbI+PTd4hELLyMpY1jisGAeUv6Ny4Sb1+eocbvgnLfW5GyFq6QgBSZK0G
	J+nrDjGY5A80AXSORx4JFJ0sdTnnIeYHBTxChlpgCV9JCQvMm78L8BOK9vbC8Eb+
	bxe3wllAZYht74U8INa22sDomH0c1ZAvMUiU76oaZXuYYFyEpgRSEfQU2DV1Pn2z
	WlAZw6N/VoY/A4liNLqGw==
X-ME-Sender: <xms:QGzSaHO1sC_x3dQwweqOWcDYjT2jSS4yERjpRDOj1R7xKys4pNImsg>
    <xme:QGzSaCYH8UQK_Y_0Nh4blFIqlwqYyBiGrJuZ4-4QUNENEpE0OwzwjcKORCzQ5F38x
    ZEYTMcqqhRQqoyfT5aD_ZqIHSdY-pVajav2a68FVyr8gILslRLM4w>
X-ME-Received: <xmr:QGzSaGCf99LIR9p6tSISOFeLfIP8TOAPlffilozk_o-jIdB_MgSQiSCJ8Mo2O7d7rtv_rzhIuu6F2Gsa2eAP1IVPHoyC9rPFeYpJ0f9Jk9Wc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeitdegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epuedtheejheejueegfedukedvieelvdegjefgjeefkefffedtleeukeeujeeviedunecu
    ffhomhgrihhnpegtohgttghirdhtohdpmhgrkhdruggvvhenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgt
    phhtthhopeduiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghonhhtrggtth
    eshhgrtghkthhivhhishdrmhgvpdhrtghpthhtohepshgrmhesghgvnhhtohhordhorhhg
    pdhrtghpthhtoheptgholhhlihhnrdhfuhhnkhdusehgmhgrihhlrdgtohhmpdhrtghpth
    htohepphhivghrrhgvqdgvmhhmrghnuhgvlhdrphgrthhrhiesvghmsggvtghoshhmrdgt
    ohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomh
    dprhgtphhtthhopegviigvkhhivghlnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvsh
    drshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehnvgifrhgvnhesghhm
    rghilhdrtghomh
X-ME-Proxy: <xmx:QGzSaIHrsM87Z0io2nyCEaH7g2HL62H-e99IePg6IdJ5uwlXuIq8-w>
    <xmx:QGzSaJM2gXUvVOjVZTgi-z6pMzRPh8r7b7whMllGu7c-AcHPiv6wWA>
    <xmx:QGzSaBiuQ5w3wR8ST07zcc-79-PhYL1rgCwuwApweavZdG3Yd1Mb6Q>
    <xmx:QGzSaB04rLmpymUlVI6LWIRDiZf7eRRUaQtFtrwSsV5ON0WlKHqLFA>
    <xmx:QGzSaAFnQNh92_1QSkqqrGbG5z-2bTcPWeq10jTXrhMg0Cp99rfGWhNW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 05:45:34 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ead1ce0e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 23 Sep 2025 09:45:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 23 Sep 2025 11:45:21 +0200
Subject: [PATCH v6 2/9] Makefile: reorder sources after includes
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-b4-pks-rust-breaking-change-v6-2-59076fee486a@pks.im>
References: <20250923-b4-pks-rust-breaking-change-v6-0-59076fee486a@pks.im>
In-Reply-To: <20250923-b4-pks-rust-breaking-change-v6-0-59076fee486a@pks.im>
To: git@vger.kernel.org
Cc: "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Ben Knoble <ben.knoble@gmail.com>, Christian Brabandt <cb@256bit.org>, 
 Collin Funk <collin.funk1@gmail.com>, Eli Schwartz <eschwartz@gentoo.org>, 
 Elijah Newren <newren@gmail.com>, Ezekiel Newren <ezekielnewren@gmail.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Junio C Hamano <gitster@pobox.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>, 
 Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
X-Mailer: b4 0.14.2

In an upcoming change we'll make some of the sources compile
conditionally based on whether or not `WITH_RUST` is defined. To let
developers specify that flag in their "config.mak" we'll thus have to
reorder our sources so that they come after the include of that file.

Do so.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile | 176 +++++++++++++++++++++++++++++++--------------------------------
 1 file changed, 88 insertions(+), 88 deletions(-)

diff --git a/Makefile b/Makefile
index 555b7f4dc3..7e52625d75 100644
--- a/Makefile
+++ b/Makefile
@@ -919,6 +919,94 @@ LIB_FILE = libgit.a
 XDIFF_LIB = xdiff/lib.a
 REFTABLE_LIB = reftable/libreftable.a
 
+# xdiff and reftable libs may in turn depend on what is in libgit.a
+GITLIBS = common-main.o $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(LIB_FILE)
+EXTLIBS =
+
+GIT_USER_AGENT = git/$(GIT_VERSION)
+
+ifeq ($(wildcard sha1collisiondetection/lib/sha1.h),sha1collisiondetection/lib/sha1.h)
+DC_SHA1_SUBMODULE = auto
+endif
+
+# Set CFLAGS, LDFLAGS and other *FLAGS variables. These might be
+# tweaked by config.* below as well as the command-line, both of
+# which'll override these defaults.
+# Older versions of GCC may require adding "-std=gnu99" at the end.
+CFLAGS = -g -O2 -Wall
+LDFLAGS =
+CC_LD_DYNPATH = -Wl,-rpath,
+BASIC_CFLAGS = -I.
+BASIC_LDFLAGS =
+
+# library flags
+ARFLAGS = rcs
+PTHREAD_CFLAGS =
+
+# For the 'sparse' target
+SPARSE_FLAGS ?= -std=gnu99 -D__STDC_NO_VLA__
+SP_EXTRA_FLAGS =
+
+# For informing GIT-BUILD-OPTIONS of the SANITIZE=leak,address targets
+SANITIZE_LEAK =
+SANITIZE_ADDRESS =
+
+# For the 'coccicheck' target
+SPATCH_INCLUDE_FLAGS = --all-includes
+SPATCH_FLAGS =
+SPATCH_TEST_FLAGS =
+
+# If *.o files are present, have "coccicheck" depend on them, with
+# COMPUTE_HEADER_DEPENDENCIES this will speed up the common-case of
+# only needing to re-generate coccicheck results for the users of a
+# given API if it's changed, and not all files in the project. If
+# COMPUTE_HEADER_DEPENDENCIES=no this will be unset too.
+SPATCH_USE_O_DEPENDENCIES = YesPlease
+
+# Set SPATCH_CONCAT_COCCI to concatenate the contrib/cocci/*.cocci
+# files into a single contrib/cocci/ALL.cocci before running
+# "coccicheck".
+#
+# Pros:
+#
+# - Speeds up a one-shot run of "make coccicheck", as we won't have to
+#   parse *.[ch] files N times for the N *.cocci rules
+#
+# Cons:
+#
+# - Will make incremental development of *.cocci slower, as
+#   e.g. changing strbuf.cocci will re-run all *.cocci.
+#
+# - Makes error and performance analysis harder, as rules will be
+#   applied from a monolithic ALL.cocci, rather than
+#   e.g. strbuf.cocci. To work around this either undefine this, or
+#   generate a specific patch, e.g. this will always use strbuf.cocci,
+#   not ALL.cocci:
+#
+#	make contrib/coccinelle/strbuf.cocci.patch
+SPATCH_CONCAT_COCCI = YesPlease
+
+# Rebuild 'coccicheck' if $(SPATCH), its flags etc. change
+TRACK_SPATCH_DEFINES =
+TRACK_SPATCH_DEFINES += $(SPATCH)
+TRACK_SPATCH_DEFINES += $(SPATCH_INCLUDE_FLAGS)
+TRACK_SPATCH_DEFINES += $(SPATCH_FLAGS)
+TRACK_SPATCH_DEFINES += $(SPATCH_TEST_FLAGS)
+GIT-SPATCH-DEFINES: FORCE
+	@FLAGS='$(TRACK_SPATCH_DEFINES)'; \
+	    if test x"$$FLAGS" != x"`cat GIT-SPATCH-DEFINES 2>/dev/null`" ; then \
+		echo >&2 "    * new spatch flags"; \
+		echo "$$FLAGS" >GIT-SPATCH-DEFINES; \
+            fi
+
+include config.mak.uname
+-include config.mak.autogen
+-include config.mak
+
+ifdef DEVELOPER
+include config.mak.dev
+endif
+
 GENERATED_H += command-list.h
 GENERATED_H += config-list.h
 GENERATED_H += hook-list.h
@@ -1387,94 +1475,6 @@ CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
 
 UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
 
-# xdiff and reftable libs may in turn depend on what is in libgit.a
-GITLIBS = common-main.o $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(LIB_FILE)
-EXTLIBS =
-
-GIT_USER_AGENT = git/$(GIT_VERSION)
-
-ifeq ($(wildcard sha1collisiondetection/lib/sha1.h),sha1collisiondetection/lib/sha1.h)
-DC_SHA1_SUBMODULE = auto
-endif
-
-# Set CFLAGS, LDFLAGS and other *FLAGS variables. These might be
-# tweaked by config.* below as well as the command-line, both of
-# which'll override these defaults.
-# Older versions of GCC may require adding "-std=gnu99" at the end.
-CFLAGS = -g -O2 -Wall
-LDFLAGS =
-CC_LD_DYNPATH = -Wl,-rpath,
-BASIC_CFLAGS = -I.
-BASIC_LDFLAGS =
-
-# library flags
-ARFLAGS = rcs
-PTHREAD_CFLAGS =
-
-# For the 'sparse' target
-SPARSE_FLAGS ?= -std=gnu99 -D__STDC_NO_VLA__
-SP_EXTRA_FLAGS =
-
-# For informing GIT-BUILD-OPTIONS of the SANITIZE=leak,address targets
-SANITIZE_LEAK =
-SANITIZE_ADDRESS =
-
-# For the 'coccicheck' target
-SPATCH_INCLUDE_FLAGS = --all-includes
-SPATCH_FLAGS =
-SPATCH_TEST_FLAGS =
-
-# If *.o files are present, have "coccicheck" depend on them, with
-# COMPUTE_HEADER_DEPENDENCIES this will speed up the common-case of
-# only needing to re-generate coccicheck results for the users of a
-# given API if it's changed, and not all files in the project. If
-# COMPUTE_HEADER_DEPENDENCIES=no this will be unset too.
-SPATCH_USE_O_DEPENDENCIES = YesPlease
-
-# Set SPATCH_CONCAT_COCCI to concatenate the contrib/cocci/*.cocci
-# files into a single contrib/cocci/ALL.cocci before running
-# "coccicheck".
-#
-# Pros:
-#
-# - Speeds up a one-shot run of "make coccicheck", as we won't have to
-#   parse *.[ch] files N times for the N *.cocci rules
-#
-# Cons:
-#
-# - Will make incremental development of *.cocci slower, as
-#   e.g. changing strbuf.cocci will re-run all *.cocci.
-#
-# - Makes error and performance analysis harder, as rules will be
-#   applied from a monolithic ALL.cocci, rather than
-#   e.g. strbuf.cocci. To work around this either undefine this, or
-#   generate a specific patch, e.g. this will always use strbuf.cocci,
-#   not ALL.cocci:
-#
-#	make contrib/coccinelle/strbuf.cocci.patch
-SPATCH_CONCAT_COCCI = YesPlease
-
-# Rebuild 'coccicheck' if $(SPATCH), its flags etc. change
-TRACK_SPATCH_DEFINES =
-TRACK_SPATCH_DEFINES += $(SPATCH)
-TRACK_SPATCH_DEFINES += $(SPATCH_INCLUDE_FLAGS)
-TRACK_SPATCH_DEFINES += $(SPATCH_FLAGS)
-TRACK_SPATCH_DEFINES += $(SPATCH_TEST_FLAGS)
-GIT-SPATCH-DEFINES: FORCE
-	@FLAGS='$(TRACK_SPATCH_DEFINES)'; \
-	    if test x"$$FLAGS" != x"`cat GIT-SPATCH-DEFINES 2>/dev/null`" ; then \
-		echo >&2 "    * new spatch flags"; \
-		echo "$$FLAGS" >GIT-SPATCH-DEFINES; \
-            fi
-
-include config.mak.uname
--include config.mak.autogen
--include config.mak
-
-ifdef DEVELOPER
-include config.mak.dev
-endif
-
 GIT-VERSION-FILE: FORCE
 	@OLD=$$(cat $@ 2>/dev/null || :) && \
 	$(call version_gen,"$(shell pwd)",GIT-VERSION-FILE.in,$@) && \

-- 
2.51.0.536.g15c5d4f767.dirty


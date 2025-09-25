Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E5D2F547A
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 06:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758781828; cv=none; b=WXkXgh+DiG9wlSLsfMCPvSz1NSqCI62JKxgmtAsb5AQhopWn7echtxrwa35NXi7S/mfQemgF+XYDXANr5syb2i2sOVyz9zvSsig0qKszBkRHz36Lhm5lv8IPLzpzQv026wCFpnu951bVESOusdpv38E/J6/fiW6NBOD1fz847Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758781828; c=relaxed/simple;
	bh=kHfGAuK1L5L2bvi+Tmkeef6achnU7J8AV/TesjwV+PE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rdTdvqKIyNjL7RoCQueK0h11daiO9/B1PkyoT0HUPbQbUnh56Z1pV21LMX2hERuUMXz1hgg5HjRnk6CKKzCav8752E2EtkAIs7Rynr3aEsv9XBt7KgWoTbDm5mrW6gCht1IAFU8Q07BWyd4tlIZ3qUKcEy0ykCvi+khUuxHV+9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bWda+HeB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YmR/Feev; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bWda+HeB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YmR/Feev"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BF5D97A00AF;
	Thu, 25 Sep 2025 02:30:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 25 Sep 2025 02:30:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758781824;
	 x=1758868224; bh=82u+1PSr3z/M3ck/+07405xIDeNuJ3A+95Z1ze/TMSY=; b=
	bWda+HeBAYuo1tVHKJhVhg0wCMXR5YiPq/bnlwhry8hVia7n3ydqUpnDf3WktuiZ
	h9E/pmbzeOuKnA1Hc9IpGOzzfEjrNJ2aVkNTu8tyQ62iyKXX1tFQEOUwbY0A27vG
	iZawuuFvjLW/qORWdGLyu3HIeUtF7LHwrvLv3RzBHKeN6L1OK+gixx1qcCSmlDvk
	Dr+22h5PGMo8joJcq6gRwHP6F9gy7crfdxjMZgAKmoLRMo/1hzdepBiPmkSFc3xn
	/N/A15970kTuD5W9CR6YXebtXow8lspn1jpv/1NC4qvWIsxGrz1tjgg7lSaFnO9s
	Bb02AveN7Le6dqKrQNOcpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758781824; x=
	1758868224; bh=82u+1PSr3z/M3ck/+07405xIDeNuJ3A+95Z1ze/TMSY=; b=Y
	mR/FeevuhapVm3VtymOhMv4575sLUUSfLc6OMUsuiZGx+3XLGoI7n6EwWTKVAPb+
	UXW/ySVsFlsrr76Ee4flyuAiiMDS6uFCcWFVLbx64Jjcsyn0f3V+NuUXYXwpwbpO
	JayyGtTogaai/MtVYPoOMNmqP+OL7zUGKz7PecGWzEQo053RHryTei+m1DUSmVmW
	l9m7xDX1N3TPXWsBMRmKJ5NWPfxmk448vSH+RqtIyzSIkR4AwlV0qlE16UKZeTDL
	9WcpqJGh1A0ZzC/fkSNLHM0pujXnHGQghwmIPp4bMd+fvl0htz4gW9zP+pyoo/+9
	6670bDL9pj+k9eSpFqpRA==
X-ME-Sender: <xms:f-HUaKI0vy0eTQ5QEvQPnYqzk400IMUy8fZmBIGVW5Rgfcg-QDSbTA>
    <xme:f-HUaClotXiu8v_Aybp6l_y56_LH6EdOwBffq3JhSszK0oZuvIYKxLqMe01ajlodl
    GF15nQ-WZseyrReGKTbP2EBoiry7MSWSDLRhLamnMcOzMiheZQpkg>
X-ME-Received: <xmr:f-HUaKefgVXEWfZqxk9rjIlIqKkOl-W3IHEd9NJdGeUdbjHKyNgum7iDYr05mvzXgWx7LSdlaoGj6fWEW2PDb5W7PWo5WWW-PMbTybBjnEY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiheejjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epuedtheejheejueegfedukedvieelvdegjefgjeefkefffedtleeukeeujeeviedunecu
    ffhomhgrihhnpegtohgttghirdhtohdpmhgrkhdruggvvhenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgt
    phhtthhopeduiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptggssedvheeisg
    hithdrohhrghdprhgtphhtthhopehsrghmsehgvghnthhoohdrohhrghdprhgtphhtthho
    pegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlih
    hprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihl
    ohhrrhdrtghomhdprhgtphhtthhopehpihgvrhhrvgdqvghmmhgrnhhuvghlrdhprghtrh
    ihsegvmhgsvggtohhsmhdrtghomhdprhgtphhtthhopegviigvkhhivghlnhgvfihrvghn
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
    dprhgtphhtthhopegtohhllhhinhdrfhhunhhkudesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:gOHUaLzTJjSPP7mrRtKae5xmuRdC3ZxU0SNgTm6TZhTdpAFqeIrojw>
    <xmx:gOHUaLIZvmqif8PEsAhe83cgpAxcVGPmzwDp41l-zSWJGVQ3m4w7bA>
    <xmx:gOHUaEs80v0PIPL3zal_8b3R6hOrt4pMAmzZkX7jAWk-oz9iCioScQ>
    <xmx:gOHUaNSVJKiMbBqitjjGQiBE4u6J2BNOO-sRyu22H2UB5DOxGSaVVg>
    <xmx:gOHUaDUZK_3xnvKifomi2ch_ojIexK66lb5gBMoLMF6gPgUcxl7tdMT->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Sep 2025 02:30:21 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 57818857 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 25 Sep 2025 06:30:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 25 Sep 2025 08:30:04 +0200
Subject: [PATCH v7 2/9] Makefile: reorder sources after includes
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-b4-pks-rust-breaking-change-v7-2-4e49dcb904d5@pks.im>
References: <20250925-b4-pks-rust-breaking-change-v7-0-4e49dcb904d5@pks.im>
In-Reply-To: <20250925-b4-pks-rust-breaking-change-v7-0-4e49dcb904d5@pks.im>
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
2.51.0.618.g983fd99d29.dirty


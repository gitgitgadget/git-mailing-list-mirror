Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67B02D3A9C
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 07:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759390243; cv=none; b=uUip7xCNX7lp4V3uPB69z6AtytJQcc8ClEpo2KU97+rmsOLkj/85vPrLAXJqpdoDAHV3/d11aAxxDzXRL1qUV7uUTJds01awgYZamdph+pKqnd0uBQ4n9nsKT2XDUOeog94iIvRgNcT2GJqetUImO33UScfLkyUD6l3+KQ3iqms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759390243; c=relaxed/simple;
	bh=wmXftKmT8cHMYRRO9bz442zwaGx9spZ7i1ziJgm2lR0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WLdnj4QsSi3B75uAcfhZ631cGaCS2aZOCPRHofG+2HsDJM00RmKvnLO9yJRd/eoBt2uezkwpaU1oaSCsvIPyXdp5fqel+rAfZAmXXERfB0o5LLuF1xDk32t0cF8v9EgjRwBUhKF0HGWtBC0zENNrMwNsJH6llMIAKYI2Nys8LVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=axzbsHf/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LoKXWXsJ; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="axzbsHf/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LoKXWXsJ"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6AC557A0156;
	Thu,  2 Oct 2025 03:30:40 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 02 Oct 2025 03:30:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759390240;
	 x=1759476640; bh=1fI62Fa4bt7+LQDC5ORiHTrkNosb0DQKUMOBbjL2DIk=; b=
	axzbsHf/OVd7Eqqnz9RQVfEuWUcoxqa+LHR5mKeKEHXRL3SOgiujzwLvgz6SN0n+
	Via4DyXZhY9wiSbrRtyZUhO8he5Oi3So4CTwuj6ALcRq3orLkHeBIZp6Xt2DRQGg
	BmwgPGRXsinspw9+r09UztaGjRy6lqnu2IryyVxFK4l5ocnC+4ArlFgxKQj9u3dw
	3UcZXaRwvlNVVYinikpZrzasx9v3/X1xpRQv7Tz+Iv5gkc5A2abjmP2nMsVRN2qV
	huAOIyWPULEHvDzdkgEyNvvRK9WIu5yMzr4CuEKVntTKOEAptZPHl+LUxl2kWZDX
	beQV8lVe7Nfmn9GldZUjzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759390240; x=
	1759476640; bh=1fI62Fa4bt7+LQDC5ORiHTrkNosb0DQKUMOBbjL2DIk=; b=L
	oKXWXsJV40ltk3S7y/eIwBcvqjhSARq5kN9iARC3SGc99MY3TwPxU74FFpZB8nq1
	8mqjz8Zr/Rek/upLl2LaPKgCE9DDmxE4HQAsuVwmI8rUnqpsy+m+PHQ3PP7X0RN6
	8D7M2Fo2gP+LRUZST0M/giVBTiqVPbHYrjXgrzc83NqNFz9ISBBfVkmu5ZevqEmT
	mVlw/AztjZyqwoSXwfEqTXwAktR1z1/v9XuFobRK5KGL/W2Q4sjLv/pew5LHC6rM
	XnamrLl+KWleCXiGAcnb7zn9IHLup7bMLtg2xImFLzJVPsug7kpI6M1ftBWqFQOy
	O5k/13Bzx/4CmYKWCvfUw==
X-ME-Sender: <xms:HyreaK_QU5xRJxhWl0QUwJOZ2ih0hF9W2jMZ86w6K_GwibTKNPIk_w>
    <xme:HyreaLKHKzTDs51Wh-VJnSwFnnWThEZKSmMvGrFFXWSC-r7avLYz7ujlW1JRD_m65
    k11i411HUNor1ibidwfGSX-HRmLCVzSasFhW2181CGNV0RAtckXWg>
X-ME-Received: <xmr:HyreaPwibiePuccU_JU1Usf-EGRSVhNCm43rYS59y1dvYpedpg1t6Xz9ubo35X5JToX_7Y3cqQini3AvPppP4dBSqwVT1kB8OssO-jaFCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekheegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epuedtheejheejueegfedukedvieelvdegjefgjeefkefffedtleeukeeujeeviedunecu
    ffhomhgrihhnpegtohgttghirdhtohdpmhgrkhdruggvvhenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgt
    phhtthhopeduiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhivghrrhgvqd
    gvmhhmrghnuhgvlhdrphgrthhrhiesvghmsggvtghoshhmrdgtohhmpdhrtghpthhtohep
    mhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopegtohhllhhinhdrfhhunhhkud
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepshgrmhesghgvnhhtohhordhorhhgpdhrtghpthhtoheptghonhhtrg
    gttheshhgrtghkthhivhhishdrmhgvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrgh
    dprhgtphhtthhopegtsgesvdehiegsihhtrdhorhhg
X-ME-Proxy: <xmx:HyreaO0cNdzF6JjMjXtN3J6VpfJLaTvVKfI4ZGvgh4mPdqIQBtRlog>
    <xmx:HyreaI9JwcVsW2kYef2j_htKcf71DTDqYpqJTodl8r7Mkxig6Uk6Wg>
    <xmx:HyreaGQr6mASd7eFcv5b5f1dHCiQY87wUg7H6-tKlZ8F4myVOqbvtw>
    <xmx:HyreaHnZMXMES1IUgr9XGHGlAJz2Cc9Q3yBJFdhJFX2jOkKv287D7Q>
    <xmx:ICreaC6lHd27eHZKHP4gZ0GT3KSV375do2gvJuLQgC3FUx_80nclwFdG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Oct 2025 03:30:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4df57438 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 2 Oct 2025 07:30:36 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 02 Oct 2025 09:29:27 +0200
Subject: [PATCH v8 2/9] Makefile: reorder sources after includes
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251002-b4-pks-rust-breaking-change-v8-2-3a89fd5b1ce7@pks.im>
References: <20251002-b4-pks-rust-breaking-change-v8-0-3a89fd5b1ce7@pks.im>
In-Reply-To: <20251002-b4-pks-rust-breaking-change-v8-0-3a89fd5b1ce7@pks.im>
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
2.51.0.700.g236ee7b076.dirty


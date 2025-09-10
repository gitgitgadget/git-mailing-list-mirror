Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FED26658A
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 15:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757518569; cv=none; b=pyiGV6+W3JbIbg8A3p1NSo00MZc6fKxSSgVz4GpU5pK4uq4V7m8E5Ec4Qoqhr+i/ItGat7B+W9SFouVTWQTlxsabV4Bskr5Ga1a1OXAsiTPiGbt6ZddBN9z2X+WTnxLhImMvhU9tcK7zKq5Wc6n6Aq2un3CCeK9fcSR6b1Y5Yxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757518569; c=relaxed/simple;
	bh=jifTBWNujfVAmES0SmL7WzQqnsfxd881IZZi3jp+9aE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DL2tc29zIbmqlO3i7VbzrVz/PeiDI3iMGq0yW3twh/iVcXA6kqtwxKIPHIeNoU4OobuccMkhM8lfW5b7F6dNNJtlJAhCc5gqbRItNIgySstlB6eVifPQYugoddQkHyE7xFIXBJkJkFaGNUIpSFHBFR1vV1HYlKJmF4iLC/pIhPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YCXX/sK1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cX9oKkE7; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YCXX/sK1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cX9oKkE7"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 63A03140039E;
	Wed, 10 Sep 2025 11:36:06 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 10 Sep 2025 11:36:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757518566;
	 x=1757604966; bh=XiC+GR0dwxHAcVEGoyoDcDFLjGaZ07UaWQ3CKpW1JSc=; b=
	YCXX/sK10NWam97s4LrEcD1DK0Mn4B1VElGdb9aHqeJLn+Ia4dnvmct9c2v32PNY
	IvaTjrEgZYf1c6Wakzb0E7hTJfkHxopcs9pUqGM3mJf8FpViQDXmcByHngi4v0s1
	IXc07aDPMcqRnNXpmZLY7nAn+GT8wAxK5W+hQj32i4WGyuq8H5gCSC4MEWaiKJCN
	wtgFL61zsilDdPyTtAWhbfFSXnb/3PwfY7D8GJlpATOeDV3OSG+vtPG8PcdFb+Z5
	0+hI1tHZpRpA92VaKgyq9QZ8c7/yMTCAyoJfmuTqnN1gqjnOQVO12G1orGSgJ102
	UX+JuWQmMOyPIAnQkBv5vA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757518566; x=
	1757604966; bh=XiC+GR0dwxHAcVEGoyoDcDFLjGaZ07UaWQ3CKpW1JSc=; b=c
	X9oKkE7Ep466wKnEhXu3Tr39582ixriZK3G9SfAZNbAahT68+lq4FSZ+OjxSx2Rb
	/OEhWb0GAxMlk/wG7ZOCJiAYqozmOShh+GvDkMnLojXBasM4ZgcqeyORELobaVI6
	HAzx1NpFqhpcfOcUUfYGlNhESI7TfkHsAIVJyW2/ZUGuhMQyQdFvAmVop4ODEEHi
	OUbs/p7MTtwI5gOKrj2WBs2j9JJOsczJn8VucnPD7oh2tF5UerlMrpY/8m8vu/Mq
	lGnxOzPAopTFC1B+/vhqQ8UVbjW02YP4kEz0mFhQz7H8q70HbMjk+Q5W2dBZYP5K
	HyojGrwEaW5NnT01k5ndg==
X-ME-Sender: <xms:5prBaG1v7dluEpP8G8l36wt8biFMOmIGjxuIK6-qve8vOu5lnfWLPg>
    <xme:5prBaJPwa53MJ8Al8Rbyih7xRxeAiaoO80FFVFCp7JBRC1r014FN-WdpzQAODb5gN
    CGRdUJkH2p3Q7VYlA>
X-ME-Received: <xmr:5prBaGWV0smVWQVSZaEspmkOkFggBKkHVGRqnpMauxn9nJH3htQ8c0_3pUWD7cgKIkIJtXdSj05bRPfYt_bbBP7uVYwUfa-Ol2g9bTjABBM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeeijecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epuedtheejheejueegfedukedvieelvdegjefgjeefkefffedtleeukeeujeeviedunecu
    ffhomhgrihhnpegtohgttghirdhtohdpmhgrkhdruggvvhenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgt
    phhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhivghrrhgvqd
    gvmhhmrghnuhgvlhdrphgrthhrhiesvghmsggvtghoshhmrdgtohhmpdhrtghpthhtohep
    tggssedvheeisghithdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtoh
    hmpdhrtghpthhtohepshgrmhesghgvnhhtohhordhorhhgpdhrtghpthhtohepsggvnhdr
    khhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopegviigvkhhivghlnhgvfihrvghnsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgi
    druggvpdhrtghpthhtoheptgholhhlihhnrdhfuhhnkhdusehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:5prBaOb5xByxdOFfAHRCaIFB5YsdkNhjP-utudYR_wae5uOR3aqhzg>
    <xmx:5prBaA0v0if_A0nvbYtG228BCM04h5aSeX2j-lYDT-dkS2otp9x2Mg>
    <xmx:5prBaKC76gTWVmW0lCezvTXdsRTT5TIF6h6RH-9FHwrtNKdX3mMCwA>
    <xmx:5prBaE8WrucOT00a0f4SM2DEbQYDDYS4JcU3eMSGHN6eFYUCrolsiw>
    <xmx:5prBaDixcUp8JlxCoDcHVwlmMM9qpepNmkH8rW8Q2koE06m7bKXXClxv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Sep 2025 11:36:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7b868b7f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 10 Sep 2025 15:36:02 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 10 Sep 2025 17:35:48 +0200
Subject: [PATCH RFC v4 2/9] Makefile: reorder sources after includes
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-b4-pks-rust-breaking-change-v4-2-4a63fc69278d@pks.im>
References: <20250910-b4-pks-rust-breaking-change-v4-0-4a63fc69278d@pks.im>
In-Reply-To: <20250910-b4-pks-rust-breaking-change-v4-0-4a63fc69278d@pks.im>
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
 Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
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
2.51.0.450.g87641ccf93.dirty


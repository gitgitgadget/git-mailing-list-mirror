Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BE430CD8A
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 14:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757340812; cv=none; b=kgmlZYOQdXPn69C+Y+iEY6FO0SNeUn5RogR3h+drnzLOaaIOCd3wBzR32CmvmwviMIN1McYPJr4nyhgx70LGBeTcot4HbE/xtcK5I7t1QHz5/+JHuhiXPw0A318DJmxcR/IDlFHVooGn7dECcKTCFSpidp31YfcjHRtNaaR/4t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757340812; c=relaxed/simple;
	bh=CHhaC4FcCcMx+saQQuZughhWW6kEw4Z+IYpMHp0wq1Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fxg4ZxJt/xARSWVmt5mfdW+c+9yaZOiSXYDRsT8XrHi6FZeHh5G75t2hPvI4CY7mNdmKEBfMKy3IieT5nzqy2sY2t2tnT2T+U0rKvhd7CGMqtZRBLuQyhUJvvUUCSd/jEdc7VBVn+SUxFGlV6fSXl483FKVQITWi5RaE9Vnjd18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sf7PWes1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YDddMdfR; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sf7PWes1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YDddMdfR"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id C8519EC022D;
	Mon,  8 Sep 2025 10:13:28 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 08 Sep 2025 10:13:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757340808;
	 x=1757427208; bh=UmBGD8n9U8PRgYNKqJ9qo41lbNGh+aP6dCiG+9yZzAI=; b=
	sf7PWes1c+jC6sm0RYTl45Xqc7exjuNRyaHHNGKSxfLslMU8dBI7uNaOVNyEb3ny
	ruSsZgI/TklucluNeIa7nkYPY1VEmUzCGTxRSqcGoQHI1iHs+na8FWkhkiWm8gl4
	GxunhSzuYSKRhjCHy28aO+R3vWd+BOU3wvTv0EKo5teCSzukt+EibtvZONdHiXCN
	tju642PT3jdP+z1/iKXC/9X8spUPAX2M2Vv77+vE+1Eai5saNU6KWAag/kBf+/+n
	NA06QllxdwaxO52M7osZA/iZpcnd4teaJpN9GTUSX7GM1MnzEQXjE1cLHyPJO/JG
	qVRVcFhKB8Q2k8hoIrUVmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757340808; x=
	1757427208; bh=UmBGD8n9U8PRgYNKqJ9qo41lbNGh+aP6dCiG+9yZzAI=; b=Y
	DddMdfR+TuCAb/NN41EOox5zGp1ZzlKexbi4Yh7ag6ILjm05jjziX+6e1+mWAR2c
	bnfyT4/WiL5vlGqyPMifatixOd76QwPyLnQ3+lrwQetGXimKDFcmhJQtHnNFPfoe
	QY6aEtHpjnLqZai68LtECa2aQX93yBizo0vaiw4a1vqGbtFWiN0IEEVbB3EnAJuB
	QUSiwXaVhQrr9pXl+9rplV27d5eIqwy8Nb9WfR33ij1FnXicoKDKoQSBAMhvoIBQ
	/xcsnjILC1iKzwDf57vnAVO/s6j61HpEG88QjNRGh3ZRieVjjcFcvJ/ZrpmWrScn
	lY0FcZoMa/KVkiw03Y9Wg==
X-ME-Sender: <xms:iOS-aClUAUmztlrVHFbZgIGLQg6ORoRon1VJzixNAKtGut4dHpqQ4A>
    <xme:iOS-aJ88ta0pBzinLbfqjVUTp07Nlhxl3F44_FP296ABLr39LRXkkvLn3ZCOBV2X_
    BHjJutwOzPvGi87dw>
X-ME-Received: <xmr:iOS-aIG-ahYRAuhVmeYrm7f660P4mYZjjWz1PsWCZLxAzy8Xg9mGZqRle_v6p_qxzkzKJQeokq7_fgdygfWNXCBdgkFdik7Rkn0qa446BwrJYw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeejgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epuedtheejheejueegfedukedvieelvdegjefgjeefkefffedtleeukeeujeeviedunecu
    ffhomhgrihhnpegtohgttghirdhtohdpmhgrkhdruggvvhenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgt
    phhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhi
    hlohhrrhdrtghomhdprhgtphhtthhopehpihgvrhhrvgdqvghmmhgrnhhuvghlrdhprght
    rhihsegvmhgsvggtohhsmhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesgh
    hmrghilhdrtghomhdprhgtphhtthhopehsrghmsehgvghnthhoohdrohhrghdprhgtphht
    thhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtph
    htthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphht
    thhopegviigvkhhivghlnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghi
    lhdrtghomh
X-ME-Proxy: <xmx:iOS-aNKiTZycNkOhMTaXeFr8NtVPV-BTsr0m5L0oT_wVAAC068Z0UQ>
    <xmx:iOS-aIkjVp77b5-7-qh405FyqK4liXVRvOoKc0vcig94SVahxD9Okw>
    <xmx:iOS-aGw8EfNnvz2BtCi7jqM5mH0uzt6XPor21of1jg_P1NabzRKB9w>
    <xmx:iOS-aCs12okARp7c5THoFZ5lRYTy_R8kCVdCyIkdGEVhiQ5tIBpoXg>
    <xmx:iOS-aDQWBbB5YlOW8UoTZTzwcnYMn_9HISSpdqMgTWjfy1hqPwilFA7b>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 10:13:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a6b6bf26 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 8 Sep 2025 14:13:25 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 08 Sep 2025 16:13:09 +0200
Subject: [PATCH RFC v3 2/8] Makefile: reorder sources after includes
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-b4-pks-rust-breaking-change-v3-2-1cd7189fed3b@pks.im>
References: <20250908-b4-pks-rust-breaking-change-v3-0-1cd7189fed3b@pks.im>
In-Reply-To: <20250908-b4-pks-rust-breaking-change-v3-0-1cd7189fed3b@pks.im>
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
2.51.0.417.g1ba7204a04.dirty


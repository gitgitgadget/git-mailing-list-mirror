Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08644284880
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 05:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773898414; cv=none; b=Q2boE6d0MzdxI3Z7sgu5vE5ex2XyVxSKuJye3AMRL5vxo1nRFYijBFu1giaPRrk5sCrKhbh19EGouiAHT3EbI5x8B3H1yHoxkkekXOqOW8Blu+zWY1ToTSsxc0tw7tiSJIOw0HR5I7TE9mQ1XjVnEjMpp/QWOtJWclEiaRZI60s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773898414; c=relaxed/simple;
	bh=O53yk9DBUoQ9T+rQe6hiROd61m7CdxqAIEIP8Uyaq4A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RursDRi142kNbG0rJmSV7Id5KWntfr3JC3iVoVv5TPPWTQqPPUCuxUEn+/AOw7h+wgjg8DyUKJs1LiqMQFeKDY/jq+PpIB9nN6v/uf93RFWqIF7SmV9qnkvCV08sK44ayETpzAQSW+44IMk69ktsJty8hFt+W7UTUpMTJpgOjKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=U8KjlesR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=1pyGWVqt; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="U8KjlesR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1pyGWVqt"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 17C82EC0210;
	Thu, 19 Mar 2026 01:33:32 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 19 Mar 2026 01:33:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773898412;
	 x=1773984812; bh=jPBvHd+6ZUC1w1Y+5u8u6zFAG5zBpvUB6LBybfYh7UA=; b=
	U8KjlesRxUDZIHovY6LynZKlaw0f6l55I/oDfFlGn8MFke0N3w0/zTZtDRgMVoMx
	nEM1u3EDYVTZ2EEntQdANugbDRNN8jXFchbK3HbnFvsOvBlxYnD24bz37vi46Pt+
	mUd90ezlZP6h7ud/QVIjdAuCfzGjKSzFuMUl1FBq2AxY9xeDXa6dBAA7dOk6Q5A4
	9zp8RM7Da2xZAyTBM6KI2IfRWXTMNSNwi7I4Mu90j54dglOP7GfEMtGPe7ABSGUO
	LYa0ZuRa9/cR4BSPBjJXlq0t3dz1J+QTbKfJaSdAYNdX+n0aPT83XQLNFqlucb54
	oAXvEdoFIpVGone+sUleog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773898412; x=
	1773984812; bh=jPBvHd+6ZUC1w1Y+5u8u6zFAG5zBpvUB6LBybfYh7UA=; b=1
	pyGWVqtUCi2XYFG1Uw+H+nlyLTRpFxIsAfDSTdyBhwa0jGsXBT4UaOlanpz9rlIO
	uiBR7BaNrfcq58bj8VuEKLzrVPGPNMGifF7tDm4Anqg5Fez+k9ovO5QamiF+7vMM
	FN42lvbyPBxuVs/1jzot81xhC3mF8Pd/tpliAVHHyBzoFu0p4q3MY2WXIX8KKpdb
	tIUldrUxf5ATDS+cQyFVlXwd0IPNOoO/kfzRfqJUNKeGJ2ymwJi7Gg5b3q9NWV4n
	HYfrr7dSUv6xABmFYZ4Tu2rFABh8566W8ATnyed+6/+M8uYfdsVi4EjcKc60ruAS
	wILavqJzLng5hYTv9is/w==
X-ME-Sender: <xms:rIq7aUQV309aMm5sSB27WGaegMIjiuSjt2RBmyNv1F20zsEIkvQcqA>
    <xme:rIq7aTRQaIe8PO-tqG_-PFNTAiDBg6gR05l32roI-M9drf_rFshbLMkEu1ZNFkKkC
    EZ3Ai2wGM4bGHzrcQX1w1EjYMpFdYhUgEL7osSHNsKUsgzhGqkvYkg>
X-ME-Received: <xmr:rIq7aR6bfpy1WLvCz51IHTcOpZ0-N-GqomZyjJl6l9a8Xnb5KjoowPAjFSabz_ksMiRBJw1ZPGvTXdWOmllYqa3YqBUgAsxoUGsNlTQsUg6e>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdeiudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffhedukeehteffkeffkedthffgjeegkeffffefheefueffjeejudeuueetfefggfen
    ucffohhmrghinheptghotggtihgpghgvnhgprghllhdrsghuihhlugdptghotggtihgprh
    hulhgvshdrsghuihhlugdptghotggtihgthhgvtghkpghprghttghhvghspghpvghnughi
    nhhgrdgsuhhilhgupdgtohgttghipghruhhlvghspghglhhosgdrsghuihhlugdptghotg
    gtihgprhhulhgvshgpthhrrggtkhgvugdrsghuihhlugdpfhhouhhnuggphhgpshhouhhr
    tggvshdrsghuihhlugdpfhhorhdrsghuihhlugdpshhprghttghhqdhruhhlvgdqrdgsuh
    hilhgupdhprghttghhrdgsuhhilhgupdgtohgttghipghtvghsthgprhgvshgpghgvnhdr
    sghuihhlugdptggrnhhttggrtghhvgdrsghuihhlugenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphht
    thhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrhhishhtohhffhgvrh
    hhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuh
    hnvghlmhdrohhrghdruhhkpdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:rIq7aX1Z6WgV9r3461trL_OQHA2DW-HrxRxcTe5PIiaSQTyUYiwl4g>
    <xmx:rIq7aUCwNo1wtq1ahsbfluGk9a14crzQZ_A_2DDF8WU5TtrtOWSg3Q>
    <xmx:rIq7aaPMEzUiP613F2lKBnY6qFmububIawXL-QVZd6UzIL9jBwR0TA>
    <xmx:rIq7aRbuT6wZIZf10AxYcTBB-mta_CJEKlxuyda_6T6V_NGEW7R8Kg>
    <xmx:rIq7afEulkthQMbuf7-yxSmzcM4FJT2fQ1kNVZ5DjLX5mup5eFQjQMK_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 01:33:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 303f9554 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Mar 2026 05:33:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 19 Mar 2026 06:33:21 +0100
Subject: [PATCH v3 2/8] contrib: move "coccinelle/" directory into "tools/"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-b4-pks-build-infra-improvements-v3-2-82f5fb3edc3f@pks.im>
References: <20260319-b4-pks-build-infra-improvements-v3-0-82f5fb3edc3f@pks.im>
In-Reply-To: <20260319-b4-pks-build-infra-improvements-v3-0-82f5fb3edc3f@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.14.3

The Coccinelle tool is an ingrained part of our build infrastructure. It
is executed by our CI to detect antipatterns and is used to detect
misuses of certain interfaces. It's presence in "contrib/" is thus
rather misleading.

Promote the configuration into the new "tools/" directory.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile                                           | 40 +++++++++++-----------
 ci/run-static-analysis.sh                          |  2 +-
 contrib/meson.build                                |  1 -
 {contrib => tools}/coccinelle/.gitignore           |  0
 {contrib => tools}/coccinelle/README               |  2 +-
 {contrib => tools}/coccinelle/array.cocci          |  0
 {contrib => tools}/coccinelle/commit.cocci         |  0
 .../coccinelle/config_fn_ctx.pending.cocci         |  0
 {contrib => tools}/coccinelle/equals-null.cocci    |  0
 {contrib => tools}/coccinelle/flex_alloc.cocci     |  0
 {contrib => tools}/coccinelle/free.cocci           |  0
 .../coccinelle/git_config_number.cocci             |  0
 {contrib => tools}/coccinelle/hashmap.cocci        |  0
 .../coccinelle/index-compatibility.cocci           |  0
 {contrib => tools}/coccinelle/meson.build          |  0
 {contrib => tools}/coccinelle/object_id.cocci      |  0
 {contrib => tools}/coccinelle/preincr.cocci        |  0
 {contrib => tools}/coccinelle/qsort.cocci          |  0
 {contrib => tools}/coccinelle/refs.cocci           |  0
 {contrib => tools}/coccinelle/spatchcache          |  6 ++--
 {contrib => tools}/coccinelle/strbuf.cocci         |  0
 {contrib => tools}/coccinelle/swap.cocci           |  0
 {contrib => tools}/coccinelle/tests/free.c         |  0
 {contrib => tools}/coccinelle/tests/free.res       |  0
 {contrib => tools}/coccinelle/the_repository.cocci |  0
 {contrib => tools}/coccinelle/xcalloc.cocci        |  0
 {contrib => tools}/coccinelle/xopen.cocci          |  0
 .../coccinelle/xstrdup_or_null.cocci               |  0
 {contrib => tools}/coccinelle/xstrncmpz.cocci      |  0
 tools/meson.build                                  |  1 +
 30 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/Makefile b/Makefile
index c7cedbcd7c..8564b1be36 100644
--- a/Makefile
+++ b/Makefile
@@ -1005,8 +1005,8 @@ SPATCH_TEST_FLAGS =
 # COMPUTE_HEADER_DEPENDENCIES=no this will be unset too.
 SPATCH_USE_O_DEPENDENCIES = YesPlease
 
-# Set SPATCH_CONCAT_COCCI to concatenate the contrib/cocci/*.cocci
-# files into a single contrib/cocci/ALL.cocci before running
+# Set SPATCH_CONCAT_COCCI to concatenate the tools/coccinelle/*.cocci
+# files into a single tools/coccinelle/ALL.cocci before running
 # "coccicheck".
 #
 # Pros:
@@ -1025,7 +1025,7 @@ SPATCH_USE_O_DEPENDENCIES = YesPlease
 #   generate a specific patch, e.g. this will always use strbuf.cocci,
 #   not ALL.cocci:
 #
-#	make contrib/coccinelle/strbuf.cocci.patch
+#	make tools/coccinelle/strbuf.cocci.patch
 SPATCH_CONCAT_COCCI = YesPlease
 
 # Rebuild 'coccicheck' if $(SPATCH), its flags etc. change
@@ -3457,15 +3457,15 @@ check:
 		exit 1; \
 	fi
 
-COCCI_GEN_ALL = .build/contrib/coccinelle/ALL.cocci
-COCCI_GLOB = $(wildcard contrib/coccinelle/*.cocci)
+COCCI_GEN_ALL = .build/tools/coccinelle/ALL.cocci
+COCCI_GLOB = $(wildcard tools/coccinelle/*.cocci)
 COCCI_RULES_TRACKED = $(COCCI_GLOB:%=.build/%)
 COCCI_RULES_TRACKED_NO_PENDING = $(filter-out %.pending.cocci,$(COCCI_RULES_TRACKED))
 COCCI_RULES =
 COCCI_RULES += $(COCCI_GEN_ALL)
 COCCI_RULES += $(COCCI_RULES_TRACKED)
 COCCI_NAMES =
-COCCI_NAMES += $(COCCI_RULES:.build/contrib/coccinelle/%.cocci=%)
+COCCI_NAMES += $(COCCI_RULES:.build/tools/coccinelle/%.cocci=%)
 
 COCCICHECK_PENDING = $(filter %.pending.cocci,$(COCCI_RULES))
 COCCICHECK = $(filter-out $(COCCICHECK_PENDING),$(COCCI_RULES))
@@ -3480,20 +3480,20 @@ COCCICHECK_PATCHES_PENDING_INTREE = $(COCCICHECK_PATCHES_PENDING:.build/%=%)
 # on $(MAKECMDGOALS) that match these $(COCCI_RULES)
 COCCI_RULES_GLOB =
 COCCI_RULES_GLOB += cocci%
-COCCI_RULES_GLOB += .build/contrib/coccinelle/%
+COCCI_RULES_GLOB += .build/tools/coccinelle/%
 COCCI_RULES_GLOB += $(COCCICHECK_PATCHES)
 COCCI_RULES_GLOB += $(COCCICHEC_PATCHES_PENDING)
 COCCI_RULES_GLOB += $(COCCICHECK_PATCHES_INTREE)
 COCCI_RULES_GLOB += $(COCCICHECK_PATCHES_PENDING_INTREE)
 COCCI_GOALS = $(filter $(COCCI_RULES_GLOB),$(MAKECMDGOALS))
 
-COCCI_TEST_RES = $(wildcard contrib/coccinelle/tests/*.res)
+COCCI_TEST_RES = $(wildcard tools/coccinelle/tests/*.res)
 
 $(COCCI_RULES_TRACKED): .build/% : %
 	$(call mkdir_p_parent_template)
 	$(QUIET_CP)cp $< $@
 
-.build/contrib/coccinelle/FOUND_H_SOURCES: $(FOUND_H_SOURCES)
+.build/tools/coccinelle/FOUND_H_SOURCES: $(FOUND_H_SOURCES)
 	$(call mkdir_p_parent_template)
 	$(QUIET_GEN) >$@
 
@@ -3507,12 +3507,12 @@ endif
 define cocci-rule
 
 ## Rule for .build/$(1).patch/$(2); Params:
-# $(1) = e.g. ".build/contrib/coccinelle/free.cocci"
+# $(1) = e.g. ".build/tools/coccinelle/free.cocci"
 # $(2) = e.g. "grep.c"
 # $(3) = e.g. "grep.o"
-COCCI_$(1:.build/contrib/coccinelle/%.cocci=%) += $(1).d/$(2).patch
+COCCI_$(1:.build/tools/coccinelle/%.cocci=%) += $(1).d/$(2).patch
 $(1).d/$(2).patch: GIT-SPATCH-DEFINES
-$(1).d/$(2).patch: $(if $(and $(SPATCH_USE_O_DEPENDENCIES),$(wildcard $(3))),$(3),.build/contrib/coccinelle/FOUND_H_SOURCES)
+$(1).d/$(2).patch: $(if $(and $(SPATCH_USE_O_DEPENDENCIES),$(wildcard $(3))),$(3),.build/tools/coccinelle/FOUND_H_SOURCES)
 $(1).d/$(2).patch: $(1)
 $(1).d/$(2).patch: $(1).d/%.patch : %
 	$$(call mkdir_p_parent_template)
@@ -3538,13 +3538,13 @@ endif
 
 define spatch-rule
 
-.build/contrib/coccinelle/$(1).cocci.patch: $$(COCCI_$(1))
+.build/tools/coccinelle/$(1).cocci.patch: $$(COCCI_$(1))
 	$$(QUIET_SPATCH_CAT)cat $$^ >$$@ && \
 	if test -s $$@; \
 	then \
 		echo '    ' SPATCH result: $$@; \
 	fi
-contrib/coccinelle/$(1).cocci.patch: .build/contrib/coccinelle/$(1).cocci.patch
+tools/coccinelle/$(1).cocci.patch: .build/tools/coccinelle/$(1).cocci.patch
 	$$(QUIET_CP)cp $$< $$@
 
 endef
@@ -3558,9 +3558,9 @@ $(COCCI_TEST_RES_GEN): GIT-SPATCH-DEFINES
 $(COCCI_TEST_RES_GEN): .build/%.res : %.c
 $(COCCI_TEST_RES_GEN): .build/%.res : %.res
 ifdef SPATCH_CONCAT_COCCI
-$(COCCI_TEST_RES_GEN): .build/contrib/coccinelle/tests/%.res : $(COCCI_GEN_ALL)
+$(COCCI_TEST_RES_GEN): .build/tools/coccinelle/tests/%.res : $(COCCI_GEN_ALL)
 else
-$(COCCI_TEST_RES_GEN): .build/contrib/coccinelle/tests/%.res : contrib/coccinelle/%.cocci
+$(COCCI_TEST_RES_GEN): .build/tools/coccinelle/tests/%.res : tools/coccinelle/%.cocci
 endif
 	$(call mkdir_p_parent_template)
 	$(QUIET_SPATCH_TEST)$(SPATCH) $(SPATCH_TEST_FLAGS) \
@@ -3576,14 +3576,14 @@ coccicheck-test: $(COCCI_TEST_RES_GEN)
 coccicheck: coccicheck-test
 
 ifdef SPATCH_CONCAT_COCCI
-COCCICHECK_PATCH_MUST_BE_EMPTY_FILES = contrib/coccinelle/ALL.cocci.patch
+COCCICHECK_PATCH_MUST_BE_EMPTY_FILES = tools/coccinelle/ALL.cocci.patch
 else
 COCCICHECK_PATCH_MUST_BE_EMPTY_FILES = $(COCCICHECK_PATCHES_INTREE)
 endif
 coccicheck: $(COCCICHECK_PATCH_MUST_BE_EMPTY_FILES)
 	! grep ^ $(COCCICHECK_PATCH_MUST_BE_EMPTY_FILES) /dev/null
 
-# See contrib/coccinelle/README
+# See tools/coccinelle/README
 coccicheck-pending: coccicheck-test
 coccicheck-pending: $(COCCICHECK_PATCHES_PENDING_INTREE)
 
@@ -3857,8 +3857,8 @@ profile-clean:
 
 cocciclean:
 	$(RM) GIT-SPATCH-DEFINES
-	$(RM) -r .build/contrib/coccinelle
-	$(RM) contrib/coccinelle/*.cocci.patch
+	$(RM) -r .build/tools/coccinelle
+	$(RM) tools/coccinelle/*.cocci.patch
 
 clean: profile-clean coverage-clean cocciclean
 	$(RM) -r .build $(UNIT_TEST_BIN)
diff --git a/ci/run-static-analysis.sh b/ci/run-static-analysis.sh
index 9e9c72681d..ba67e80b4d 100755
--- a/ci/run-static-analysis.sh
+++ b/ci/run-static-analysis.sh
@@ -10,7 +10,7 @@ make coccicheck
 set +x
 
 fail=
-for cocci_patch in contrib/coccinelle/*.patch
+for cocci_patch in tools/coccinelle/*.patch
 do
 	if test -s "$cocci_patch"
 	then
diff --git a/contrib/meson.build b/contrib/meson.build
index a88c5dfe09..569c23ee76 100644
--- a/contrib/meson.build
+++ b/contrib/meson.build
@@ -2,5 +2,4 @@ foreach feature : get_option('contrib')
   subdir(feature)
 endforeach
 
-subdir('coccinelle')
 subdir('credential')
diff --git a/contrib/coccinelle/.gitignore b/tools/coccinelle/.gitignore
similarity index 100%
rename from contrib/coccinelle/.gitignore
rename to tools/coccinelle/.gitignore
diff --git a/contrib/coccinelle/README b/tools/coccinelle/README
similarity index 98%
rename from contrib/coccinelle/README
rename to tools/coccinelle/README
index 055ad0e06a..fd0a543cc2 100644
--- a/contrib/coccinelle/README
+++ b/tools/coccinelle/README
@@ -38,7 +38,7 @@ that might be useful to developers.
    So to aid these large scale refactorings, semantic patches can be used.
    However we do not want to store them in the same place as the checks for
    bad patterns, as then automated builds would fail.
-   That is why semantic patches 'contrib/coccinelle/*.pending.cocci'
+   That is why semantic patches 'tools/coccinelle/*.pending.cocci'
    are ignored for checks, and can be applied using 'make coccicheck-pending'.
 
    This allows to expose plans of pending large scale refactorings without
diff --git a/contrib/coccinelle/array.cocci b/tools/coccinelle/array.cocci
similarity index 100%
rename from contrib/coccinelle/array.cocci
rename to tools/coccinelle/array.cocci
diff --git a/contrib/coccinelle/commit.cocci b/tools/coccinelle/commit.cocci
similarity index 100%
rename from contrib/coccinelle/commit.cocci
rename to tools/coccinelle/commit.cocci
diff --git a/contrib/coccinelle/config_fn_ctx.pending.cocci b/tools/coccinelle/config_fn_ctx.pending.cocci
similarity index 100%
rename from contrib/coccinelle/config_fn_ctx.pending.cocci
rename to tools/coccinelle/config_fn_ctx.pending.cocci
diff --git a/contrib/coccinelle/equals-null.cocci b/tools/coccinelle/equals-null.cocci
similarity index 100%
rename from contrib/coccinelle/equals-null.cocci
rename to tools/coccinelle/equals-null.cocci
diff --git a/contrib/coccinelle/flex_alloc.cocci b/tools/coccinelle/flex_alloc.cocci
similarity index 100%
rename from contrib/coccinelle/flex_alloc.cocci
rename to tools/coccinelle/flex_alloc.cocci
diff --git a/contrib/coccinelle/free.cocci b/tools/coccinelle/free.cocci
similarity index 100%
rename from contrib/coccinelle/free.cocci
rename to tools/coccinelle/free.cocci
diff --git a/contrib/coccinelle/git_config_number.cocci b/tools/coccinelle/git_config_number.cocci
similarity index 100%
rename from contrib/coccinelle/git_config_number.cocci
rename to tools/coccinelle/git_config_number.cocci
diff --git a/contrib/coccinelle/hashmap.cocci b/tools/coccinelle/hashmap.cocci
similarity index 100%
rename from contrib/coccinelle/hashmap.cocci
rename to tools/coccinelle/hashmap.cocci
diff --git a/contrib/coccinelle/index-compatibility.cocci b/tools/coccinelle/index-compatibility.cocci
similarity index 100%
rename from contrib/coccinelle/index-compatibility.cocci
rename to tools/coccinelle/index-compatibility.cocci
diff --git a/contrib/coccinelle/meson.build b/tools/coccinelle/meson.build
similarity index 100%
rename from contrib/coccinelle/meson.build
rename to tools/coccinelle/meson.build
diff --git a/contrib/coccinelle/object_id.cocci b/tools/coccinelle/object_id.cocci
similarity index 100%
rename from contrib/coccinelle/object_id.cocci
rename to tools/coccinelle/object_id.cocci
diff --git a/contrib/coccinelle/preincr.cocci b/tools/coccinelle/preincr.cocci
similarity index 100%
rename from contrib/coccinelle/preincr.cocci
rename to tools/coccinelle/preincr.cocci
diff --git a/contrib/coccinelle/qsort.cocci b/tools/coccinelle/qsort.cocci
similarity index 100%
rename from contrib/coccinelle/qsort.cocci
rename to tools/coccinelle/qsort.cocci
diff --git a/contrib/coccinelle/refs.cocci b/tools/coccinelle/refs.cocci
similarity index 100%
rename from contrib/coccinelle/refs.cocci
rename to tools/coccinelle/refs.cocci
diff --git a/contrib/coccinelle/spatchcache b/tools/coccinelle/spatchcache
similarity index 97%
rename from contrib/coccinelle/spatchcache
rename to tools/coccinelle/spatchcache
index 29e9352d8a..efbcbc3827 100755
--- a/contrib/coccinelle/spatchcache
+++ b/tools/coccinelle/spatchcache
@@ -30,7 +30,7 @@
 #	   out of control.
 #
 # This along with the general incremental "make" support for
-# "contrib/coccinelle" makes it viable to (re-)run coccicheck
+# "tools/coccinelle" makes it viable to (re-)run coccicheck
 # e.g. when merging integration branches.
 #
 # Note that the "--very-quiet" flag is currently critical. The cache
@@ -42,7 +42,7 @@
 # to change, so just supply "--very-quiet" for now.
 #
 # To use this, simply set SPATCH to
-# contrib/coccinelle/spatchcache. Then optionally set:
+# tools/coccinelle/spatchcache. Then optionally set:
 #
 #	[spatchCache]
 #		# Optional: path to a custom spatch
@@ -65,7 +65,7 @@
 #
 #	redis-cli FLUSHALL
 #	<make && make coccicheck, as above>
-#	grep -hore HIT -e MISS -e SET -e NOCACHE -e CANTCACHE .build/contrib/coccinelle | sort | uniq -c
+#	grep -hore HIT -e MISS -e SET -e NOCACHE -e CANTCACHE .build/tools/coccinelle | sort | uniq -c
 #	    600 CANTCACHE
 #	   7365 MISS
 #	   7365 SET
diff --git a/contrib/coccinelle/strbuf.cocci b/tools/coccinelle/strbuf.cocci
similarity index 100%
rename from contrib/coccinelle/strbuf.cocci
rename to tools/coccinelle/strbuf.cocci
diff --git a/contrib/coccinelle/swap.cocci b/tools/coccinelle/swap.cocci
similarity index 100%
rename from contrib/coccinelle/swap.cocci
rename to tools/coccinelle/swap.cocci
diff --git a/contrib/coccinelle/tests/free.c b/tools/coccinelle/tests/free.c
similarity index 100%
rename from contrib/coccinelle/tests/free.c
rename to tools/coccinelle/tests/free.c
diff --git a/contrib/coccinelle/tests/free.res b/tools/coccinelle/tests/free.res
similarity index 100%
rename from contrib/coccinelle/tests/free.res
rename to tools/coccinelle/tests/free.res
diff --git a/contrib/coccinelle/the_repository.cocci b/tools/coccinelle/the_repository.cocci
similarity index 100%
rename from contrib/coccinelle/the_repository.cocci
rename to tools/coccinelle/the_repository.cocci
diff --git a/contrib/coccinelle/xcalloc.cocci b/tools/coccinelle/xcalloc.cocci
similarity index 100%
rename from contrib/coccinelle/xcalloc.cocci
rename to tools/coccinelle/xcalloc.cocci
diff --git a/contrib/coccinelle/xopen.cocci b/tools/coccinelle/xopen.cocci
similarity index 100%
rename from contrib/coccinelle/xopen.cocci
rename to tools/coccinelle/xopen.cocci
diff --git a/contrib/coccinelle/xstrdup_or_null.cocci b/tools/coccinelle/xstrdup_or_null.cocci
similarity index 100%
rename from contrib/coccinelle/xstrdup_or_null.cocci
rename to tools/coccinelle/xstrdup_or_null.cocci
diff --git a/contrib/coccinelle/xstrncmpz.cocci b/tools/coccinelle/xstrncmpz.cocci
similarity index 100%
rename from contrib/coccinelle/xstrncmpz.cocci
rename to tools/coccinelle/xstrncmpz.cocci
diff --git a/tools/meson.build b/tools/meson.build
index e69de29bb2..f731f74312 100644
--- a/tools/meson.build
+++ b/tools/meson.build
@@ -0,0 +1 @@
+subdir('coccinelle')

-- 
2.53.0.959.g497ff81fa9.dirty


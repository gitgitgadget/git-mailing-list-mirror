Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CA9175A6
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 09:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728985579; cv=none; b=kjVUJf9oHpphL+6hX5wxlAlphr+86+mThQy2NyvjgwOA+TGtd3iVnlj4oT8U+vXQ/nCQddvbzWi16t7APdig5nJ3aCkM+56E10H28uNRofO61/kewwfpyl3Llfq6WV5ggkAtWVW6TTsXkDd0KaTcsFJpMABeYcAB4caXtcHN3uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728985579; c=relaxed/simple;
	bh=OV6U0d3vfE0IzI1n7/TAYc5yiiEPvG1KZTWVY2SUBYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nFbrJerJLwBWBT42ivyE9Qq6yLUD27AdrqT9u4g7dxPyA88wvgxO5zHWLxuLSVwF/NolibcdDtxrf1Y/3Q960Zv7o/izbTpcjpmVPUnQEYM12u3P2EiVVJbTtJNlM9MKnTmrK9DQZv5IyAZTVolim9ToUdP/wBq20cCncBqExMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HEvl6AIN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WOEciAE9; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HEvl6AIN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WOEciAE9"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id A07FD11400AA;
	Tue, 15 Oct 2024 05:46:16 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 15 Oct 2024 05:46:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728985576; x=1729071976; bh=xsgcGpYc+A
	HRZqMJGfgUgEmvEDcq5E7CBkAURUnPOLA=; b=HEvl6AINhoohoC9F4Tiv7xu93e
	d1wrSB6eudO84FLgaEclHI4xDacDhs0TFDS++2vOUuGxfTGxuh/cH0LJhsL1wJhQ
	cRBgK0UEa05LC9b7R9Yh5smqaVIgSuYme4lwm0vtkNk/Lc77+Wn1cIysh9gNsMRD
	9S+kyl5vbL65Tr5Q/7/+Db5Y9iOqgECuhM35nuXMzet9QpeqJ7jFJl43u55EYkBM
	/Lftd0AJw1Jm/AZilkQ3bGxY2OjJ1pag+ZhAvw619dHj7+GWrQoWa8iw/DTzCCvu
	c2XoAP6PWxuayfMM1JcG3+n/sJ9OzBDlrOZw6TybkFms15uR5t/wsAu0B7vQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728985576; x=1729071976; bh=xsgcGpYc+AHRZqMJGfgUgEmvEDcq
	5E7CBkAURUnPOLA=; b=WOEciAE9cRiHVHg4YAdP6rS7Fc9pYHqJCopYkAgVQ2vK
	uBoiImiH8GizPPPxSltkwojA2sKxmRHCnSfl31Rp3MUoNHzH24tA51BX2+DyIrbq
	azs0xqolURZ8/pHYmI9hsoAJLdkU5OWkqteA4J+XcLV5/EFEB4J7cchWG0wrkJoD
	y8lgWvHktdhDbYYB7HlU0qED3edgV7FnnxAPVXAE/1Wr+M+2i0HlFFnBIGNd57uv
	s2HjI9l72ngIzuewPJIJuxr5TpHTtY16yIHQUXGXOR1NVvAJt3miF/DEUH+PmUSU
	aqIe667RmESB+MhDCtSAnB+CO4CQbP9TH8W4FHgAng==
X-ME-Sender: <xms:6DkOZ0nIOMu89oZq1zez0Fdj4OM2K3JzDustLLBGkO047-6mLnuMRA>
    <xme:6DkOZz35YMTEiidjBsAutJf7hOPOvKAYZA_cRdADEOrCPXUcDZCx5gu6lkLxP6sHl
    jdts2GQVj3oUpdfcg>
X-ME-Received: <xmr:6DkOZypF014PCRTFYYyOpX6HJK-W_vE85KFq-5lujYKCcgVng1MZCrbIv8vGNrrGTNKTfzsyJ3gjKioQdYolnYY9KDs-i3OzVrhAkKdmOP7EIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegjedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgt
    phhtthhopegvughrvggvlhesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrg
    ihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:6DkOZwmbs6NJJtGZk69iUaiUig5RvgBIDfokS8NhXQfzdzn3WbjiNg>
    <xmx:6DkOZy3dUgfCFPaUhL9tCmgWb0RFvppl6lhhtEa3zPeYdOYRwkwiow>
    <xmx:6DkOZ3s2Yf3hHFhFQbp8-eUAsy-aDnUjWh89YWuM6khxg07w2QVEPQ>
    <xmx:6DkOZ-VFWI-Rvjj1LWPdVoSQDMKkvqS701QSshTl_7EMs4n1SMkawg>
    <xmx:6DkOZ1TM1Pej7GotXwDPBKe3zjJ2XdsZtQmI5aYDRl45CEZbnM_22It6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Oct 2024 05:46:15 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b661a90e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 15 Oct 2024 09:44:59 +0000 (UTC)
Date: Tue, 15 Oct 2024 11:46:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Ed Reel <edreel@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2 1/3] Makefile: extract script to generate clar declarations
Message-ID: <7a619677c7af6ba8213a36208e20ab75c4318e38.1728985514.git.ps@pks.im>
References: <CAGjHeYfyH+cOMYYYHnFR+Vu9T+RbmzO1SpB_-kbmBSf1DitJhA@mail.gmail.com>
 <cover.1728985514.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728985514.git.ps@pks.im>

Extract the script to generate function declarations for the clar unit
testing framework into a standalone script. This is done such that we
can reuse it in other build systems.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile                            |  4 +---
 t/unit-tests/generate-clar-decls.sh | 16 ++++++++++++++++
 2 files changed, 17 insertions(+), 3 deletions(-)
 create mode 100755 t/unit-tests/generate-clar-decls.sh

diff --git a/Makefile b/Makefile
index feeed6f9321..87b86c5be1a 100644
--- a/Makefile
+++ b/Makefile
@@ -3904,9 +3904,7 @@ GIT-TEST-SUITES: FORCE
             fi
 
 $(UNIT_TEST_DIR)/clar-decls.h: $(patsubst %,$(UNIT_TEST_DIR)/%.c,$(CLAR_TEST_SUITES)) GIT-TEST-SUITES
-	$(QUIET_GEN)for suite in $(CLAR_TEST_SUITES); do \
-		sed -ne "s/^\(void test_$${suite}__[a-zA-Z_0-9][a-zA-Z_0-9]*(void)$$\)/extern \1;/p" $(UNIT_TEST_DIR)/$$suite.c; \
-	done >$@
+	$(QUIET_GEN)$(SHELL_PATH) $(UNIT_TEST_DIR)/generate-clar-decls.sh "$@" $(patsubst %,$(UNIT_TEST_DIR)/%.c,$(CLAR_TEST_SUITES))
 $(UNIT_TEST_DIR)/clar.suite: $(UNIT_TEST_DIR)/clar-decls.h
 	$(QUIET_GEN)awk -f $(UNIT_TEST_DIR)/clar-generate.awk $< >$(UNIT_TEST_DIR)/clar.suite
 $(CLAR_TEST_OBJS): $(UNIT_TEST_DIR)/clar-decls.h
diff --git a/t/unit-tests/generate-clar-decls.sh b/t/unit-tests/generate-clar-decls.sh
new file mode 100755
index 00000000000..81da732917a
--- /dev/null
+++ b/t/unit-tests/generate-clar-decls.sh
@@ -0,0 +1,16 @@
+#!/bin/sh
+
+if test $# -lt 2
+then
+	echo "USAGE: $0 <OUTPUT> <SUITE>..." 2>&1
+	exit 1
+fi
+
+OUTPUT="$1"
+shift
+
+for suite in "$@"
+do
+	sed -ne "s/^\(void test_$suite__[a-zA-Z_0-9][a-zA-Z_0-9]*(void)$\)/extern \1;/p" "$suite" ||
+	exit 1
+done >"$OUTPUT"
-- 
2.47.0.72.gef8ce8f3d4.dirty


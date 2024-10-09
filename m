Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510C719ABB4
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 14:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728485807; cv=none; b=KMMBqLhLlf8pj10jyqonDlxN1BSf6JNxxXEE5TWJGKZHeGpMX43ZvXY+/s+twouPqbOBMfojK+/m6vlwsIgixuge/L/2w/RNtCM61AzsMjsP9zl6VHepLUZpr1rOekBgzHYaRIPNyjGticcGt6J3bxlSZ0yweqTQe4i2MyKBdfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728485807; c=relaxed/simple;
	bh=eZDN8vTPDZkLkCbsgVDKUtL8DHla4HnHRiZI5yXLqjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ORqwxgYYCLrbZr8MUj1Ef1H1vB60VPhDr14zXcLJzMmRgcBVF/JqLamBbJTApeL4T/PLbcfgjiIpGh+GsgDnfTEnLxBcrCFXn1pLV4Tuw4bmszTTBNnRZda+EqirInjSJBN+iWasaCDaSxgeuYzp69x98bk6Woaz7HA82EYYm1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MFL85whz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hTadlg83; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MFL85whz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hTadlg83"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5934111401C0;
	Wed,  9 Oct 2024 10:56:45 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 09 Oct 2024 10:56:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728485805; x=1728572205; bh=5DiS/1/xM3
	0Sr1Il2mV2ExXQNnP7gvUibDkC05llDI0=; b=MFL85whz2enQH6cEjBtnpiu6f3
	lh4dgsVrdFWip5N5v0Fxws45Hk5MurkBrAc6VflGGxaWnlIPuZNGShDp5Y2lRdid
	KatKZZWH3/dfou9lusmk+dJZr3kJkNMaTX27AVCnFBV8ulhmoR84OOPryrUpJPqI
	gkIgDSJxOsfJSFLxDJzv3J7uDa+E3sHqQqTOCdjIoMhcXVDct2GX8kFQ5V6aDuzL
	wgWih78PfGSuXNp8vUf1CSf9HpTtz7honFLb1WxQ5eb4XSQsH2lOnGCL4FVox3Jy
	Qfa+0B+ocCU7pWapxnox7E21JasNXRignVnSewEbaTbieM5yovXhLjzl34Og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728485805; x=1728572205; bh=5DiS/1/xM30Sr1Il2mV2ExXQNnP7
	gvUibDkC05llDI0=; b=hTadlg83Fg40o08ebUfBNCCaihKAgHIuFgqSowLbl77J
	LDyfYkCrvDdp+HjsgDI/Cd5HPh+FFq4bfmjv+toshJ//qfQFFutMNghuM/Zd+dPw
	LxYysOGz/p2M52rxypc53WbbbEnZPSnLhBwogNXwJmxMwPH8z+GwJIrKMMSmii51
	1fx44IxPav9IM8QEYsS6G9GR2RmdHMw9LggJWaSGvvFC/7aciNL43GRlhSFUS30c
	gOypKpk4vLKWB91fXqxQ+1PtV7kuKHR1Sp5SIXDrQSXHL3/TPmPwFhSfkSPvcHQQ
	YCdg9ijWJmxNAgdlPtkwUEky5t4IR7TRJJvSyjlJ5g==
X-ME-Sender: <xms:rZkGZ5fo6GeET4a8hisMi7GBsnaBWV-DWt5mO-_Hu5WgGBZHlRb9gw>
    <xme:rZkGZ3POTCSEyfFzjvLZBWJE82KBPSfLcRh_EVq1LnOOZDCCiT3Tr2ru0WFqUE45Q
    a1LJD1Tf8mflgeNRQ>
X-ME-Received: <xmr:rZkGZyiRk3nBAmtXvk56KUjHOL7p-fzZmpKZ2tZHKh5NO22k-NsYIccWQ4RZ9p4xKID3Bqk31CCOwhIgoRVhKN_0DZGLLJ8f_B_sObIyZG3F6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeffedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehsuhhn
    shhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdef
    sehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:rZkGZy8qAh6Jc1q9iXH2aRews8pVKjbkrhhcvaNneHPB33Wk6-esZA>
    <xmx:rZkGZ1v0aZo6iCiGbVDZQeNNUPNSVLSrqpNm4I6HQbzZCLg0HVpnFw>
    <xmx:rZkGZxFpcZ_plvFoT73UdAyAt_QfDLcVgnrJdmPadGp3qpwcBxRYXw>
    <xmx:rZkGZ8OT-NPtHz9QYvzK6Z9z7uMRGL8P7eQmBQO4lxXxjC10Y_s-7g>
    <xmx:rZkGZzW0j_zsod4d_ifLwC4bKVc_0360mnHVOIuufihRzakVQxRlpxAa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 10:56:43 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6b693e43 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Oct 2024 14:55:41 +0000 (UTC)
Date: Wed, 9 Oct 2024 16:56:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH v2 12/24] Makefile: extract script to generate clar
 declarations
Message-ID: <6ea97bc92f2ae09d406c445fd8dad1fe803cec19.1728485139.git.ps@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1728485139.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728485139.git.ps@pks.im>

Extract the script to generate function declarations for the clar unit
testing framework into a standalone script. This is done such that we
can reuse it in other build systems.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile                            |  4 +---
 t/unit-tests/generate-clar-decls.sh | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 3 deletions(-)
 create mode 100755 t/unit-tests/generate-clar-decls.sh

diff --git a/Makefile b/Makefile
index c094840426c..0d542c58f3a 100644
--- a/Makefile
+++ b/Makefile
@@ -3906,9 +3906,7 @@ GIT-TEST-SUITES: FORCE
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
index 00000000000..6646a90f711
--- /dev/null
+++ b/t/unit-tests/generate-clar-decls.sh
@@ -0,0 +1,18 @@
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
+while test "$#" -ne 0
+do
+	suite="$1"
+	shift
+	sed -ne "s/^\(void test_$suite__[a-zA-Z_0-9][a-zA-Z_0-9]*(void)$\)/extern \1;/p" "$suite" ||
+	exit 1
+done >"$OUTPUT"
-- 
2.47.0.rc1.33.g90fe3800b9.dirty


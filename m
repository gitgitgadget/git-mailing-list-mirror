Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C2F1D0DD9
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 15:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727882170; cv=none; b=ENvRCaUX4lA7RVMmmXdzgCbV8+o9pq4gi6ZzGqRlAr20yBIRUSBZ63o7MuaCVeY04GV0hYpJ9c/VWJ/lj2JQh0+2rk4YvdFZoCwLbTV8/3oSK6+kVZrN/3TB5tpFtoSOYFdZwFYUtxXtkFQMBs319S4uczN6pr+IUxoYfwdcvEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727882170; c=relaxed/simple;
	bh=OrHKwcb4/ayllhi/mpJ0wA1bUBK5+RMD5t2MnfDuuCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cPS47dh+nCi9eLrULCNxJ5dFXHhPsIenAfLKLKLIZlDqEIgc0ODfqVV06McdEE9OjZfLzgtrypyWBfeKpJz5HXNWIsqZXWW4Qu8vCpTTUWj9XbgTohhsQDEpvwtDdw2Zsj/rkQxOJZKhWp1xzF1kY7kIlfcNzUUNPxVp4WL64i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PaiM9pWF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C/v6jdX+; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PaiM9pWF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C/v6jdX+"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 9047D1380250;
	Wed,  2 Oct 2024 11:16:08 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 02 Oct 2024 11:16:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727882168; x=1727968568; bh=cL2nu93qkw
	Y/QAK1BC9dXkiX+7l+O4wq8LdwUc4F0DA=; b=PaiM9pWFrawiRXry0GKdjDO3lU
	O4LXxZp2ZqSdqhj4ENKzbzM/i6/ICyiekaaX/JSfsbUPrmWgLghb4CJudXYWXeQA
	XMNZ+GpJk4iD8ghK1aTBkBi2SxCYZqL9pISs50A11z74BoBeaP1jtfIS0Uo8APMS
	b9UVKQWp4TUS15lZAjarmez42N0aGR/kvssriLbACue50MTkB/0MKsmGBiH+BeDv
	NIIyBkwV++lxsIXbj2h1oFN6l0BFyTquBIAlMsE6OFxe7PzgRfP6MhfmFIHvbLv+
	jYBSh0Htx9/RlxrpgcrFZ6leuU4zXtdyK/SgQqjMBzrGlP+nqzv3egrJ7VIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727882168; x=1727968568; bh=cL2nu93qkwY/QAK1BC9dXkiX+7l+
	O4wq8LdwUc4F0DA=; b=C/v6jdX+ze4ilXcf2/p8e0ArOkXyDD8EFfMBfqtsZ3Mf
	n7SzlsgDfcKPuf+MCmmj5IoMc+FquD7+7ELX8IbZMf2rZcuJ2ErO/FrJUShSm4B/
	vf4TZKKqrxG+QsrE3x0R79oC5RMcXJ7O8jOzRudi/YDsbdwmR63Di1OJAgnSvsO6
	GreENw+NZIz21O8OYG9F8AqgdKUNRqVkJaI6O/k4rP5KTjPbZ39OsB0WehF9D8Va
	OgGUaoxhheI7cLmwTtqeePHDNKihmJG3gZVIAZ1guHETHEELeVZqeehTpuMP1zM1
	w5nccsGQhneJLKO9rtglwh2Nt2LiEyT9F5XvvO07Rw==
X-ME-Sender: <xms:uGP9Zqnr5Z5Gegeby3y_MkyDPl7ZhFKJchtDegqw3ar3Eeo_M3aPVA>
    <xme:uGP9Zh1JYU9Ie-6IOFtHp3JjP26mKIRhewjVHpGZAaFiwBMHhVzMSqhhGmrYSKwvY
    JvORniN6h2jniuy5A>
X-ME-Received: <xmr:uGP9ZoqHOLi2s0VGX18j1JnzDlMCGRb_WWD1HIU398-ju9sxBldyzleScyAIEASyao05LHv9g0xXmkKm-Zg0RH66UeJ_q_pxvkK1FXVk8fAVtkKu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrgh
X-ME-Proxy: <xmx:uGP9Zukd8x3ETB_JGPmKK9FA2wpbQ0SR5prE7loZa2PvEUqRmk4YBQ>
    <xmx:uGP9Zo3Wcgr55jf3qhB3khQ-K4FYw6afG6yHwILTM-G4H4meWTH60g>
    <xmx:uGP9ZlukijBQ3ZzKu0ZzPFlT-3NZIIdYvihYNTjkVWZTyGHULIS6XQ>
    <xmx:uGP9ZkVOMxvNtT1oKxUWsTG0z9afs9RcniKyyGAtoUQbpQF98CaMkA>
    <xmx:uGP9ZmBIO_6yXXK9Zib4MwkhxWSjrMpIvFc762mi4Oqk6ZCKOHQBxrnm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 11:16:07 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c131ddac (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Oct 2024 15:15:17 +0000 (UTC)
Date: Wed, 2 Oct 2024 17:16:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>
Subject: [RFC PATCH 10/21] Makefile: extract script to generate clar
 declarations
Message-ID: <b05a551b1c2570780046ca21010eca27e6e3c18e.1727881164.git.ps@pks.im>
References: <cover.1727881164.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727881164.git.ps@pks.im>

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
index 7344a7f725..de6426a684 100644
--- a/Makefile
+++ b/Makefile
@@ -3880,9 +3880,7 @@ GIT-TEST-SUITES: FORCE
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
index 0000000000..d5ddbaa5da
--- /dev/null
+++ b/t/unit-tests/generate-clar-decls.sh
@@ -0,0 +1,16 @@
+#!/bin/sh
+
+if test $# -lt 3
+then
+	echo "USAGE: $0 <OUTPUT> <SUITE>..." 2>&1
+	exit 1
+fi
+
+OUTPUT="$1"
+shift
+
+for suite in $*
+do
+	sed -ne "s/^\(void test_$suite__[a-zA-Z_0-9][a-zA-Z_0-9]*(void)$\)/extern \1;/p" "$suite" ||
+	exit 1
+done >"$OUTPUT"
-- 
2.47.0.rc0.dirty


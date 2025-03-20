Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978A3222577
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 09:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742463345; cv=none; b=IW7dVGVTtQqvzGilX8RGWwDl9WEviGcLqBVi2ZjPri/Y6wcbyWeef8FR+gMXqwN9V+JZUCuIA26vyvMXHCaNVdqfeaXwC1+vM8sO0l54REd8UBg7QcKWGNrHORg/6VKhHHyu8+OPyOOoQN51CGqFOnYvmYY29ijepZLh/4MsrrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742463345; c=relaxed/simple;
	bh=l++6TOMGDvU+Ku1F+XjsGw22Ru2u7Sy3ITLF2o+P/oM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ku9hUz3sdYgzbr4CLBMOlT2LOc7viYzEnHDa1hv0a/FTpKRIGArzEJ2eMhAyEv926YL32nK8qMpYpvzN+CAA8QkUF9G1lZMZA4gx6z7wj9AUIgO0NIki76jI9n2Z1497VqbupD3lmFSrjbgtE6p+tuJ/WasN4IChOerTfyg1w0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cMMt39nG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CSWy6Fjv; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cMMt39nG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CSWy6Fjv"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id ACC762540170;
	Thu, 20 Mar 2025 05:35:42 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 20 Mar 2025 05:35:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742463342;
	 x=1742549742; bh=3ClEJeq0r9S2afkT2Gk3D1jB1qy87nJM7NWRNiLDVUI=; b=
	cMMt39nG4Mi1uDjZHr6R9kuiO8kJkKUthmNbPumOa25SGjzkfzzVokAanO7Kuxz8
	G2lQP0/BDqwFBD0Xxrq98hyWxOjSqBMvrHHoSsqifFuZUOKm4EpHfiOut6I71nbJ
	nuqy3Uggjo9o0Nk83u296G8SzSVMpBdLZaZ+AgqG8ygj0LC1Nm/BL+lmOH84/pt6
	JyY+97PjF2C3E79jIoKegRf6xUEotxPA3091LAqIWAnAfzcrZQZSdFvG1jB50anQ
	aLqSiv3tOTWsaqxxMLwL+u3BrQlUbyMxC/OOY5rMJ+RQAZ9t09FTJmdcj/2tvSP2
	5rjrIp0O0pkCyQ6p6FivBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742463342; x=
	1742549742; bh=3ClEJeq0r9S2afkT2Gk3D1jB1qy87nJM7NWRNiLDVUI=; b=C
	SWy6FjvVhjB71CbeJTsNy/8VrsNmJLz6QH8j1Z9xzol5JegmRBm/JKWtmSBAwh+E
	OG3e5KRLIaxB9OMGOWKr42GV4zd/kZAsVelvQTXHD20TKv6/BVNgaeUj1KtHqatk
	hRRrWLj6optTgd/8apLDKGDyUMpcnotXgFrzaGvaML2jFqnTPqNgxXEdgI7xmI3b
	TisbsLN7dtR2NjkgQZOVSCZCwfNCyD3HwBWMlPmm58lUPG4tk4DN1qYGxNunNCGo
	Qpo7xHSvsVEBHpbNLdg8Pi36ZrBaNSklIzSjT1pNopZpu5uZm7lWdHHJ+kqh0cl7
	vvaZvAEyuWrQkKXIEcgPw==
X-ME-Sender: <xms:buHbZxVR3iNESAO48vUX8B5GJ4Q4I8xXa8ZjQjSS-VxgH83kHr6xWw>
    <xme:buHbZxmA0z-Cw_0jUPIQ-aMr19lItDXB4LB_9qFdkQj8EJMa1taiqEKWTpoxqct1z
    U_ehQSEfmMVUQtPdA>
X-ME-Received: <xmr:buHbZ9ZYkO7ACOPafp2mRKBGUkbLW1HHEMc5ZYpn3x8Qm9oWdWHA16qV7UoCzdVBKFwX3h3e3QLGp18kcYYOzcDrftk_uEbOMm0yoWds8RbNXm8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeejkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpedtvefghfeuudethfdtfeejkeeugfehheduheel
    vdehfeekveekuefgfeelvdegffenucffohhmrghinheptghouhhnthhsrdhshhenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdr
    ihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:buHbZ0WDcQF4N8Iq4x-KOwMnOevnCR47-KqJVv_5F7oXZX8gYQ4Xeg>
    <xmx:buHbZ7mmJK9LEdPsa3dPW41LfuDMKXwWlBu10YlXoDp9t33vZY5uvg>
    <xmx:buHbZxfP1yHoDD5wv22xMFsAyrZnUipg6caLBarua2L5l-cbdi6nzA>
    <xmx:buHbZ1Fow5pMR5lAJ19eaX_rwqyyRsGuug7To-b_uyvJiwAox_hsLw>
    <xmx:buHbZwxyzhO-7mBUURABFFVYySwBug49RMBhglJAyt-DCnWGPvgvjzoj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Mar 2025 05:35:41 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1ff3e545 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Mar 2025 09:35:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 20 Mar 2025 10:35:36 +0100
Subject: [PATCH 09/20] Makefile: stop requiring Perl when running tests
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-b4-pks-t-perlless-v1-9-b1eefe27ac55@pks.im>
References: <20250320-b4-pks-t-perlless-v1-0-b1eefe27ac55@pks.im>
In-Reply-To: <20250320-b4-pks-t-perlless-v1-0-b1eefe27ac55@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.14.2

The Makefile for our tests has a couple of targets that depend on Perl.
Adapt those targets to only run conditionally in case Perl is available
on the system so that it becomes possible to run the test suite without
Perl.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/Makefile | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/t/Makefile b/t/Makefile
index 2994eb5fa9a..791e0a09789 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -59,16 +59,21 @@ CHAINLINTSUPPRESS = GIT_TEST_EXT_CHAIN_LINT=0 && export GIT_TEST_EXT_CHAIN_LINT
 
 all:: $(DEFAULT_TEST_TARGET)
 
-test: pre-clean check-chainlint check-meson $(TEST_LINT)
+test: pre-clean check-meson $(TEST_LINT)
 	$(CHAINLINTSUPPRESS) $(MAKE) aggregate-results-and-cleanup
 
+ifneq ($(PERL_PATH),)
+test: check-chainlint
+prove: check-chainlint
+endif
+
 failed:
 	@failed=$$(cd '$(TEST_RESULTS_DIRECTORY_SQ)' && \
 		grep -l '^failed [1-9]' *.counts | \
 		sed -n 's/\.counts$$/.sh/p') && \
 	test -z "$$failed" || $(MAKE) $$failed
 
-prove: pre-clean check-chainlint $(TEST_LINT)
+prove: pre-clean $(TEST_LINT)
 	@echo "*** prove (shell & unit tests) ***"
 	@$(CHAINLINTSUPPRESS) TEST_OPTIONS='$(GIT_TEST_OPTS)' TEST_SHELL_PATH='$(TEST_SHELL_PATH_SQ)' $(PROVE) --exec ./run-test.sh $(GIT_PROVE_OPTS) $(T) $(UNIT_TESTS)
 	$(MAKE) clean-except-prove-cache
@@ -132,8 +137,13 @@ check-meson:
 		fi; \
 	done
 
-test-lint: test-lint-duplicates test-lint-executable test-lint-shell-syntax \
+test-lint: test-lint-duplicates test-lint-executable \
 	test-lint-filenames
+ifneq ($(PERL_PATH),)
+test-lint: test-lint-shell-syntax
+else
+GIT_TEST_CHAIN_LINT = 0
+endif
 ifneq ($(GIT_TEST_CHAIN_LINT),0)
 test-lint: test-chainlint
 endif

-- 
2.49.0.472.ge94155a9ec.dirty


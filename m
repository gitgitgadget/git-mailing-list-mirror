Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97D1210F6A
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 10:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743071838; cv=none; b=LswMFqOvTHEX4d6Mk/4Vi40/Y6TbS4yONEUADUjqLpsZqckJcbnQD1gSdc45jbAt56Zm7eE8fqzmqME5TDYxggCygANnTd4Uc5FuYCFb3jcpq+35dNP/O5tHQCmO2b1//tkmCFahJPE3kNnLOg3J7J5VUclF/dSzq4Spg03nmKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743071838; c=relaxed/simple;
	bh=l++6TOMGDvU+Ku1F+XjsGw22Ru2u7Sy3ITLF2o+P/oM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NafDSTBDrB0MmEIjRaGurXoBRM2SAeD8a3sBmXGHAnVkioIbHGffmTzlj4ed+frF8qhSPLKH2WQW7Mf2YdPCnw8W0/VrQqhWagNCPPH2ljiyncURRsLE9BWkTW5Lp8ASNQfjU45NigVMPhZz1mg/qirzAzm2ve73SJ/mS+TcV7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cAnhoxMd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N7w1AfIZ; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cAnhoxMd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N7w1AfIZ"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 1DBDC13839BD;
	Thu, 27 Mar 2025 06:37:16 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 27 Mar 2025 06:37:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743071836;
	 x=1743158236; bh=3ClEJeq0r9S2afkT2Gk3D1jB1qy87nJM7NWRNiLDVUI=; b=
	cAnhoxMdMgueKjxBXgsbXI2zJHO8jf5UIn5VoKb0Vr1WYWOV/5MSjTPrS37K+sZj
	KoLaHzHwddX+KQyupmUoEoe52V3NSD/4WTU151UdBtfGXaAT96DGzf+/+eolP9UX
	1nFC5+WlztQMnN0NrAMqcf4mS5eBMd9bDzLVZlSUQ5swextlbgms2lX+HaVlT0mA
	Uyl2g3fexHFpnluXQ+KZeWUVNpuzPxH+OtcJWrkJgwj4wZQTAykSVYn6VRfXRMMM
	eCl8v9A1QYKsl+0WA/FMytyQvvSQBCfC8Vvfa6si8/RU+xtaZQXUjtKJfof5QmD1
	DDsTJFl9gO4r2MXSA328sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743071836; x=
	1743158236; bh=3ClEJeq0r9S2afkT2Gk3D1jB1qy87nJM7NWRNiLDVUI=; b=N
	7w1AfIZiFuV5ovF93uOgg2eXRKi5NHsYvVol9HsQ67seNebOh9Jc7h9xCxWGatWg
	LCVn6KxfIEegszajtlaKZbXQj35vbDCRZbB3KhKeIQxhtqMlvqT6yTc469yARKdw
	gvWorD40wir9paiUSuy1dfPAN2A9ISI1BeilqBdFiYbgzKWOl3ZIMwWwrfEaFru9
	UQoW/rjN+PmAGP2dqvX12K6Ta1t8KZKMrH8icsVvpcJ/Y20mYleDb4iyglJA84Vg
	0XNJ3TSjyR5TD2HnCGl315Nh+U24vUsbZcCqbNFpfqwsnPJXp3nAO/Qvf4R/pp8Z
	bZk93GAB6NYX6ORWeewQA==
X-ME-Sender: <xms:WyrlZzEuNX20m1OZPaN6_3lG1ur0uXDRCeKJYwv31d3tmPQvVkw9ZQ>
    <xme:WyrlZwXNRnKp0goMz6UTo21EV804Mrb4M3TeaL-qQ3U_s0iQnI1cpv5oOaFhjJn1g
    2rDtMB2zi5BR3x8FQ>
X-ME-Received: <xmr:WyrlZ1IhVJLumzdS8jU0ey4pk0J3gd57gUJx17Z5Ra6aENfc3zKHDzb8LZ4G7cLpT-4gAPCZMcLKWuwGG32bhxhCBVMN29OeWFr_b9ZNXi95Sw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieekudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpedtvefghfeuudethfdtfeejkeeugfehheduheel
    vdehfeekveekuefgfeelvdegffenucffohhmrghinheptghouhhnthhsrdhshhenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdr
    ihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhunhhshhhi
    nhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifoh
    hougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghh
    ihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrgh
X-ME-Proxy: <xmx:XCrlZxFIPfzyLEiPLPaSHFv5caK-_nIp-I5_zS41E0k4AMWcsA-CdQ>
    <xmx:XCrlZ5W5xt7CuO2-st06zqBkYlCPaNgclhve-bZHlxp8Jqz7EL8kIg>
    <xmx:XCrlZ8N-mzGML7jyEYkweTKmuEQoHQKlexZA6ehmEjRXozg2Ab5woQ>
    <xmx:XCrlZ428eTv-pQ38rafxs7mpRtWuNI05oJLxyjwjBC98gqjdk7Cyrw>
    <xmx:XCrlZ3cMmIePtfcluV3aW3rQAv18yv7AMibqokKolMiSn-T-Mz0o3y32>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Mar 2025 06:37:14 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fcc9fc90 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 27 Mar 2025 10:37:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 27 Mar 2025 11:37:07 +0100
Subject: [PATCH v3 09/20] Makefile: stop requiring Perl when running tests
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250327-b4-pks-t-perlless-v3-9-b436de9da1b8@pks.im>
References: <20250327-b4-pks-t-perlless-v3-0-b436de9da1b8@pks.im>
In-Reply-To: <20250327-b4-pks-t-perlless-v3-0-b436de9da1b8@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Karthik Nayak <karthik.188@gmail.com>, 
 Phillip Wood <phillip.wood123@gmail.com>
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


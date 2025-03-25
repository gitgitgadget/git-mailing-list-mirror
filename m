Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3311E268685
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 13:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742908476; cv=none; b=l58oG3+m+drukvwVXi0XLp3F+MJ5fITkGnGxxf7NMTfBmDbXahsSO3SQVgJlfFglnOLt8qFDma/sHmMkiW7FCWc5o2DCxtQ5YyLMKmcLe0Ubk2BpdB6Mft/Kk1gKZWRml9eQukZh9DUQ7r55/O8Sf3kr2fX/MdXF8g8fXDKgFdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742908476; c=relaxed/simple;
	bh=l++6TOMGDvU+Ku1F+XjsGw22Ru2u7Sy3ITLF2o+P/oM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C9kzzh+kafzPFcnegelc5vEoHKPBEPQDmnT8nbXRvGR9wqzKZUY8saJPdMCE9EWIv3FhBeTerStRqltq0nTyJBOmpbhFBTgGuCIHkcR9MPXhJp3BwX0yNDKqR1MOC/hdbNH13D7OUvonPifH2w8Td1rfwi8x2MQFCy/tgyuorgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=l5Rs4NN4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OZZAzPct; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="l5Rs4NN4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OZZAzPct"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 0A3AE1383842;
	Tue, 25 Mar 2025 09:14:33 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 25 Mar 2025 09:14:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1742908473;
	 x=1742994873; bh=3ClEJeq0r9S2afkT2Gk3D1jB1qy87nJM7NWRNiLDVUI=; b=
	l5Rs4NN46oiSHQ+SL/kMklCsi0mM9O38Wo+JeCMv2ARYYfHmpsegZb2zPF14bQ5P
	2ewjYMZjt3NKMXS8SvXIPtPTfKGwjkvNmaCkG6yTOrbDbn7Nz5tNj1Q+PEDbqUfY
	Rf7WDa7RscX3QRP/UQ4Wm2GFSrAm9UVRcf54ZOn/fXnPrLjT5AWJCrW0n+ddYMHS
	/NvZaj2EJkTgV4TW9VU5kzChMW/7v9txuSzpta2G24+i57ABG0vf8m3FdjXF2+yZ
	9cjQ5yro4NlepXgsvUHEKhQeYuAgUqiGnizp95w0f35vIDKMlPn07vzyflSAV/QJ
	0lZNrlyL2ii7MYCWr5gVMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1742908473; x=
	1742994873; bh=3ClEJeq0r9S2afkT2Gk3D1jB1qy87nJM7NWRNiLDVUI=; b=O
	ZZAzPct2OFOfsFkygzuHuf0wYsO7VAyQJDM3oRv3M1qBl8gP4X58PDPUdBocxrHQ
	LUO1sgJdnDHyHkG8e0PzDkWAkREYk2qlBe66TEOpxyUFZQGT07UWUrWuSNebzCHc
	492tKr1NvKTDsG5ENSvGFF3LnFDUECUUKy6VsL/I24KtiOfrBERAwtpTieqv9Gr3
	tD3ytzSzc4nWWWdWJDVs60RUCbghlZvavqQn8cnZ4oVOAnLID3Qi4dBoQ7kpYAp8
	M2TwMUmLWxnPUFvAvPYGsPYXVlM4HvvBq//Vz3OAtJnLAHxwFV/zMBJgE827eQRs
	WQwgrNp9ce+Ack06/n1vQ==
X-ME-Sender: <xms:OKziZ4F-uHF88BYoLXQmXEX5lKTyeGQFmGm8QvhREWaWI2sC85rLdA>
    <xme:OKziZxXfF_L8rUaEoGj7qE_Yi696Dl6cHeSsAyeBTSB_EzCM-apCKRs4yMuq6W6vz
    3vV951YCC_R3vWrsA>
X-ME-Received: <xmr:OKziZyIyU1v6UGy8fdqKjT3Um7BflwtRmt8WYEDt9dNqnvXj92b-P81mn2tagZ6fgZiJX_xPgk1fVe0tWvWaSIKjbARnxs7GYHpKFq8v-48kAg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduiedvjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpedtvefghfeuudethfdtfeejkeeugfehheduheel
    vdehfeekveekuefgfeelvdegffenucffohhmrghinheptghouhhnthhsrdhshhenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdr
    ihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhu
    nhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhn
    uggvlhhinhesghhmgidruggvpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrg
    hilhdrtghomh
X-ME-Proxy: <xmx:OKziZ6FQspkPpkom2VZ3wuTvv7mQjrDDmxSkrJ1YOpH5vfRzVEjh1g>
    <xmx:OKziZ-W-DNTsKN4uQO1AMFnI9PPw00s_3IZsoeb5BhSbDeEIDUZYjg>
    <xmx:OKziZ9Oh8c7Znt6wm417n0rghOq0N5cc120Zi4J_ZXWAmms4mScEaw>
    <xmx:OKziZ10KZ8_5VrdiZEsfi1lKOTCsCXYoTc2VPL4s0TyaEsSn71Aq-w>
    <xmx:OaziZwewcyGz-krnuPoOLjKcodoUUmaCbRX1vdOfSVgrtMQcQcod22Pt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Mar 2025 09:14:31 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2091f689 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 25 Mar 2025 13:14:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 25 Mar 2025 14:14:27 +0100
Subject: [PATCH v2 09/20] Makefile: stop requiring Perl when running tests
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250325-b4-pks-t-perlless-v2-9-4b87b8072670@pks.im>
References: <20250325-b4-pks-t-perlless-v2-0-4b87b8072670@pks.im>
In-Reply-To: <20250325-b4-pks-t-perlless-v2-0-4b87b8072670@pks.im>
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


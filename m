Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC4C1953A2
	for <git@vger.kernel.org>; Thu,  3 Apr 2025 05:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743656772; cv=none; b=CUISkQZeEuXIdKbGz1qsP5c2xw7Lck9pmJ/XGziNCiXyKMDzeHGUbBFZWmVaaCpYt1pUNYTQzujMypjltcgm8KmzVC0qd1C0GKytCG0p34DKAGIocnNzVwAnamgC9hOxWGUt7wCvtI5TURydBiwPszi8wc/TrsVnAI18zX7C4O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743656772; c=relaxed/simple;
	bh=PQs8dC7jGso/8rUwbzAiZurJsfzBa92/3TrhVRQ0zh0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ur9XAAEepgjyOhvJLbntfD7adZZnOrqirWHrOUpQK2OMLfnTXJWHKwkJN8r7gbQgM5SB+jYQY7a9HS4suF0KFSTT86YZYpIyFbrXW7w2fuHb4WsFeANUEcO/p4kFaagZ/kXj7ZKG5p7pJCXih2Wm3kbnS3KAkWWV4Yxj9jo5gGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=V6m1EIXf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dC6G/ylF; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="V6m1EIXf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dC6G/ylF"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B41712540212;
	Thu,  3 Apr 2025 01:06:09 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 03 Apr 2025 01:06:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743656769;
	 x=1743743169; bh=fdtE8Bp3WPW/jE+AsucoZatYpA6vtrSwZxyfYwh/o80=; b=
	V6m1EIXfKc36ScIXBhlTEy20N1/hDi197LbUw3DRihd5d2PYO0hNtsDsvANk5fki
	rdPGemDwy8KzYgnSElxPgsVyht8f9keXlEdruQjhUwICrxGFqMx5ZvEqmjGNFTwx
	64ngBOvKUs0klzf0UOX+keLqf+GVwcxxPMqB0wuWwIBQB8jSrvRkEPHbQMorCNLh
	1F1AIQzkeY3SOjT3m1GsGyuEcfoeU5DxAy/czE/UD2G9MtQ+aPS8X3GCy4W6+TT3
	P/zpC1nd6YPbJMb9UTQsDbDGFY327oJDqX5WCbmaZVRhWn/tOUwpY4Zd9tpIZDob
	2uV5M0umccitny0r0lCYTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743656769; x=
	1743743169; bh=fdtE8Bp3WPW/jE+AsucoZatYpA6vtrSwZxyfYwh/o80=; b=d
	C6G/ylFhHAGhiESRvlr/IZjZp9thRTIzNOmjlJqcurmGx1d0yr7Wu70AY7kqKDqV
	Va6rx4xZL4DPlPfAFdSHXCJSzbUBmUO8cEy0Flot9vb2Z3+3kF0IaBhTREyiGCXH
	2PONF6l6XstPS9YNhFD1SM53TgwS9QnEGuhmGyIKr1B+4jIjYipZhzQHa1tYSFkr
	labsKTB5qHrB1q48xiSsC1JPJ35XCV1ZaEjMlQcMzhWel0RkwgKyCMTZzZ6MUIDm
	vaONks+RiTxrpC5FfDzl4DEwIxqYkHktyz6eSIUnL96ryNKwHMM8q/K7IAHMn7ln
	K1x+C8ssBDxbTuPoJnUpw==
X-ME-Sender: <xms:QRfuZ29mmiUFnwnElT51Bxtwaq0kjxkgFhjvG2x5mSVxHKf1LqxmTQ>
    <xme:QRfuZ2tzD7P_hEXzBWY1ke-RFYGh7mfR4__jduwuLy16hPLgmY5LmJse0VPhIsGFc
    yInDudJeIuXWBYzMw>
X-ME-Received: <xmr:QRfuZ8CeSkeI21s3Ty3AxuMgjxBi5rZQEI-HhBsVPcdnQIqNIxifXCZa3tPQ7j2PPIFnPxYzJdKb7ajDkHNEeqY8aa0oLsHjFKPcOJUTNyO4tP8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeejieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpedtvefghfeuudethfdtfeejkeeugfehheduheel
    vdehfeekveekuefgfeelvdegffenucffohhmrghinheptghouhhnthhsrdhshhenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdr
    ihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgr
    rhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvg
    esshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnse
    hgmhigrdguvg
X-ME-Proxy: <xmx:QRfuZ-eDSYM--QPoTq6-7erFDdr9a6978p7l3EtcREAJeWltJUV1Gg>
    <xmx:QRfuZ7N3Bhr4cIf42dq7L-ZAh_9KIHfuKzd0J1Lx7qoYVzem8XbfFg>
    <xmx:QRfuZ4llNvjUPb0JsChBAsO78V3ewb6hhZ0Ynd8a8dHs1sBQzWuzfg>
    <xmx:QRfuZ9viS2lDpxhvnNsAaQFoYmnzfrInLtzp6UAmk5BkUx1Sm3sv_g>
    <xmx:QRfuZyB5Lmnj25Dn7DO-vv097M1OiVTlo3FdPpiPlGBpASYGw-0-ANOi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Apr 2025 01:06:08 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4a331a60 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 3 Apr 2025 05:06:03 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 03 Apr 2025 07:06:00 +0200
Subject: [PATCH v4 09/20] Makefile: stop requiring Perl when running tests
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250403-b4-pks-t-perlless-v4-9-be20ac3db39a@pks.im>
References: <20250403-b4-pks-t-perlless-v4-0-be20ac3db39a@pks.im>
In-Reply-To: <20250403-b4-pks-t-perlless-v4-0-be20ac3db39a@pks.im>
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
2.49.0.604.gff1f9ca942.dirty


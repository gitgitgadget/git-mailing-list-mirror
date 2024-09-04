Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5482575F
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 14:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725459411; cv=none; b=hVfsw8sUVHKwZycNFZfKfwA1JLRkryb1zVWgh8z/ilv3VcasCK8SbK4TKRsHsq7smXec+3F62/3liBXZ56Vs2jEmQTZaAjJpUuXWs8JkGuAJ5JKzs8FKM6rC+rIiVM7+W/watGomgyEMfg/pjFTJdBz6Fxrbgu6uKp5N9bcXnK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725459411; c=relaxed/simple;
	bh=y/cCf3OFCQ9FfSP+K//k6SkZA0KXUO6cqB7EaO5HxnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nAkvCoS/qrCbYffW40n0xzZxQkCg+LBdGIaxP4ZVpaOcgdcj1zvfkigHO7eJq7bLoP36E01Q0+R1BDLfxIllPinUGNhWZ4c03WXAaS1EGPSGJPqmidsvDXbVIw6YG+af+kuhvo3FQ75OKjc9+D3GTusMTtg9RcBPL6ddMC+B6oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IiNQyVB1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l49wbNq4; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IiNQyVB1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l49wbNq4"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 0EA4D1380274;
	Wed,  4 Sep 2024 10:16:49 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Wed, 04 Sep 2024 10:16:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725459409; x=1725545809; bh=zEVV1QfiBD
	G5NXJLKEUx1ZYa/KzPl+333TKlf5f/TZM=; b=IiNQyVB1NSiEunf2ivGOGXXd5z
	ulslUuE1GKWow+r+FR7FA1sHL6gO73Bfl+mKJ7TbvfnaIlaRd/PeH9yp2woLZW7v
	5Cq8Ky7BNMGK7yVtIKPZBGi7KoxtnReKCsV3mIjuvn5yDwAg4K2pdVh47QLyFnva
	61mxpc2Zhe/hBE6cptYmamC2i198nFaoivwjmBmmKNYQiQwfVA08uj5Kn5IKYQ5f
	tYYnJj3k86pIFvW5mzCJ6ee7SoZenAV+0JeMEM7xWKal/NyChELYjQmB0rW3QBoO
	p2byHpL/BvbpifuIsrZdGm/oAeoJMq6Cmp2QeFvgqYv1w0l0xgnjjUsAuwlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725459409; x=1725545809; bh=zEVV1QfiBDG5NXJLKEUx1ZYa/KzP
	l+333TKlf5f/TZM=; b=l49wbNq4Uh6tdKgnTgkEZf4j6+sMdKDQK4tFE8qgfXJJ
	xS87tk10N/enI6IYHopgikWyYdFWP3knRfijAGXMDKXNB4TlttouExvhYaM1gtG7
	iYBc3MBciimwqYOhVGoRRT6eQ/xkN5grfDBcfj4ftpAdtnJdDTqMhShOMeVzHjIK
	mzVVf4fTn0XRyft8q54DPMUE+RRNzrpwCIC8PvESnnvGTb87ewsb3uhKxDZtvhw/
	lGAdbvVhBHGW8PnQ3n7WYP3Qxx3dC/Y9PO/WkpCbIpy2R7MQeZNvnd5KxyUkRx5f
	t2TP8KJTg0h70J92zIcHee/ih5SEUJ1S5r5AWKio8Q==
X-ME-Sender: <xms:0GvYZrd04CGrXMxf4rzgn3a0JWC4FeA1BF28tS9iieRsUqsN402-Aw>
    <xme:0GvYZhM4GKhW6BYrER9YeKLMoIJtPjBF4kLNik-nweye_LUQ-CRbdvLPop7SUVY4_
    1x57PZMg8baXtq-Aw>
X-ME-Received: <xmr:0GvYZkhKlXdYNjDKRCP65fr97zCAQfLI0364BKFGc6537jNvVIp2ZVoVA7_UiUYiYIDcpe2S0R52qkzIuSeVqgYbjpaA1-tXTnNfJDcj5Bsx0p4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehjedgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesgh
    hmgidruggvpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheprhhssggvtghkvghrsehnvgigsghrihgughgvrdgt
    ohhmpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtoh
    hmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhk
    pdhrtghpthhtohepshhpvggtthhrrghlsehgohhoghhlvgdrtghomhdprhgtphhtthhope
    hsthgvrggumhhonhesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:0GvYZs-8kDot9-DfsTbyzpUw-ATaRX6X5S9NfUXIjgSq-sN1Ey5MfA>
    <xmx:0GvYZnsiWsbLd8xAaCI_Hmhs4S8nFywQ6X_sH_faSzcRI1_EUs82tQ>
    <xmx:0GvYZrHMpWOeDITzj1hLweAB8rDtMWxBFYxcrwMtfVBcvclQYiAQAA>
    <xmx:0GvYZuO-SAcLhNw3Zg3mLFV6TOKEn-wE6eQnMGOhJMjXQUsN9p65YA>
    <xmx:0WvYZlKvGksmuIy3K04giSjxlLHnw3CH391-pHtESFHQvRR730OEnfGa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Sep 2024 10:16:47 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id be9779af (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 4 Sep 2024 14:16:38 +0000 (UTC)
Date: Wed, 4 Sep 2024 16:16:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v8 01/14] t: do not pass GIT_TEST_OPTS to unit tests with
 prove
Message-ID: <b67f10ec0b08699eec93e3a7eb6ef3e06b5cedba.1725459142.git.ps@pks.im>
References: <cover.1722415748.git.ps@pks.im>
 <cover.1725459142.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725459142.git.ps@pks.im>

When using the prove target, we append GIT_TEST_OPTS to the arguments
that we execute each of the tests with. This doesn't only include the
intended test scripts, but also ends up passing the arguments to our
unit tests. This is unintentional though as they do not even know to
interpret those arguments, and is inconsistent with how we execute unit
tests without prove.

This isn't much of an issue because our current set of unit tests mostly
ignore their arguments anyway. With the introduction of clar-based unit
tests this is about to become an issue though, as these do parse their
command line argument to alter behaviour.

Prepare for this by passing GIT_TEST_OPTS to "run-test.sh" via an
environment variable. Like this, we can conditionally forward it to our
test scripts, only.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/Makefile    | 3 ++-
 t/run-test.sh | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/Makefile b/t/Makefile
index 4c30e7c06fb..d2212de0b78 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -68,7 +68,8 @@ failed:
 	test -z "$$failed" || $(MAKE) $$failed
 
 prove: pre-clean check-chainlint $(TEST_LINT)
-	@echo "*** prove (shell & unit tests) ***"; $(CHAINLINTSUPPRESS) TEST_SHELL_PATH='$(TEST_SHELL_PATH_SQ)' $(PROVE) --exec ./run-test.sh $(GIT_PROVE_OPTS) $(T) $(UNIT_TESTS) :: $(GIT_TEST_OPTS)
+	@echo "*** prove (shell & unit tests) ***"
+	@$(CHAINLINTSUPPRESS) TEST_OPTIONS='$(GIT_TEST_OPTS)' TEST_SHELL_PATH='$(TEST_SHELL_PATH_SQ)' $(PROVE) --exec ./run-test.sh $(GIT_PROVE_OPTS) $(T) $(UNIT_TESTS)
 	$(MAKE) clean-except-prove-cache
 
 $(T):
diff --git a/t/run-test.sh b/t/run-test.sh
index 13c353b91b4..63328ac630c 100755
--- a/t/run-test.sh
+++ b/t/run-test.sh
@@ -10,7 +10,7 @@ case "$1" in
 		echo >&2 "ERROR: TEST_SHELL_PATH is empty or not set"
 		exit 1
 	fi
-	exec "${TEST_SHELL_PATH}" "$@"
+	exec "${TEST_SHELL_PATH}" "$@" ${TEST_OPTIONS}
 	;;
 *)
 	exec "$@"
-- 
2.46.0.519.g2e7b89e038.dirty


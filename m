Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796031714CE
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 11:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723720927; cv=none; b=MsKUDatgjbCpOBMseAMKWasZAPhrVjR1KDPUxIe7M6UsoxmdtHOyvOPwSPW6q9/FhJ0faBtWCQJ04x+A3DwxOlvuODpT7rdT6u/Q1VNFzu/ncSnY7ps4hvODdQKjLG3J5XPezvV8PPLIuo/AR5YUuFyGdIi1OEKaqw6i/BoyXPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723720927; c=relaxed/simple;
	bh=iV39pDlehJKJMBmJOmKhSuEQlUG8uyI1v1x6V8sA6jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wo6ZvP8NBukpUI67flpJMBqTqQ7QWBjgHFMizI+HqAvM5CtcTe0PmUb3Gr0Xya2rs/SxPdFme06PkIA5HP27L+wzN8HjCBtUUZam0do4JZp9bOAXzIuHLC52aP4WDfl+resJ3tVa0cVlgZt5jY6Anje3WzuqQyWZgzyNu5ERDlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Y2PDPqdc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z0m8prmS; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Y2PDPqdc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z0m8prmS"
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id C44EE114AB51;
	Thu, 15 Aug 2024 05:47:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 15 Aug 2024 05:47:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723715259; x=1723801659; bh=orPsHs5Lug
	gSDieKEbgcLoqHqNj5BVZFiYwm975jQIY=; b=Y2PDPqdcVoS5ZnBIF5MSHokDM/
	8K3ZHF/XX7tk3LTFNWUo6WdGwMk4dbq1tVCFVSLlRko5XoRCf5vv8Wny1xcmakhg
	VWjVPM/KQ1q7yeuXjVdRQkA39QwrNH8GMu8fARzR1pNhaWYOrSaUGMZH3rWIpe5G
	DvGd1hZvigYVej2eIzZBK4Hibs2Mx2I8BiGRy4Rvahsm4PtOp9wIXjPn1JyooRQ+
	9wPelZPDNaLbbIE1S/ubiNIaKiSnpyKfIzNPnsgBBuwFM7yPSckBj+XMr70/DIsh
	Nm2abzkwbAmWH0f0WTTcDfR1HaT4ZuZn78rMZvUKVkAQ47I7lRW2DAz8Cl5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723715259; x=1723801659; bh=orPsHs5LuggSDieKEbgcLoqHqNj5
	BVZFiYwm975jQIY=; b=Z0m8prmS7opz/DkES8wUbi9vto3uVFOfwjC54yU5volx
	bHqpOhWfLv8sFilOqTBIvhZ4BoMzFz+hH2mLcwASQ+HZGm1v4XWOQGvDJDDQvWiv
	To9Chd3+JhG0kyH7y+yqyBLU7e3KlhoTcbb9cMKi4cxxJVMAQ3NNBwjA0LuOdKm+
	W5n4I8Epo1BiAgPb/6I+USckp/rlZnAT1gmJdrt+Z+MpYwJbT7UH1Yn1ktrTJ7fi
	L6PE9JP+YT7aRGyUKHU3xw2nx28eql2JPJZbOibnyA589hLLD0wf8hKXH8miKkkD
	nKl1xyDptbABwKxfOxVyGVZWFTp9I6x+flyExdlxcQ==
X-ME-Sender: <xms:u869ZuTN-JkyoOv40MaLoxU4EclCKPDC3XL-SgdWpTqb937ARKSsfQ>
    <xme:u869ZjyeEOaveT-Ga1MYxEeaGGgg_ZGKyfaktnFDWuirqz_NkBmptzSpvB2Tc9qk-
    jsLOEJP21Fc3UGTsg>
X-ME-Received: <xmr:u869Zr2f7cEaix4ql5veUi0Sqd5LRRM0a596TUKAO9a0_2Sfgg8kCibgQbZ5E9i_WWAAMeBL1cdURPNfXoEyYhxgEB1QKHwC4k8ZRNJpSRw7pQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtiedgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhpvggtthhrrghlsehgohhoghhlvgdrtghomhdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepphhhihhl
    lhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtoheprhhssggvtg
    hkvghrsehnvgigsghrihgughgvrdgtohhmpdhrtghpthhtohepshhtvggrughmohhnsehg
    ohhoghhlvgdrtghomhdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvghthhhomhhs
    ohhnsegvugifrghrughthhhomhhsohhnrdgtohhm
X-ME-Proxy: <xmx:u869ZqA90HzC2nifBsqZe6wRn_fhTq1laSE3WrTldXzUqcYygy1OyQ>
    <xmx:u869ZnjBywfiT-gG7I0tOLPvOCn81PkmAdZ0D68QLbJAs2yqmFsHlw>
    <xmx:u869ZmrMGU0VfS9tEZ3LSI3EIvydFcK4qKkNaTiTAWsA9Lo1a1VKDw>
    <xmx:u869ZqjW-NFDfVStr-hARltjMz2PpeCp9OQ1lNZ9HCEfLTyigWXf7w>
    <xmx:u869ZoXx55GPeq_JHAQ0zoHWs74a3syPkeHV4sPVHTQEBDNSqdoV3bsq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Aug 2024 05:47:38 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 262c4478 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Aug 2024 09:47:17 +0000 (UTC)
Date: Thu, 15 Aug 2024 11:47:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>
Subject: [PATCH v4 1/7] t: do not pass GIT_TEST_OPTS to unit tests with prove
Message-ID: <086dd728a72bb418e0d1b616d4f0318282b9f24d.1723712012.git.ps@pks.im>
References: <cover.1722415748.git.ps@pks.im>
 <cover.1723712012.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723712012.git.ps@pks.im>

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
---
 t/Makefile    | 3 ++-
 t/run-test.sh | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/Makefile b/t/Makefile
index 4c30e7c06f..d2212de0b7 100644
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
index 13c353b91b..63328ac630 100755
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
2.46.0.46.g406f326d27.dirty


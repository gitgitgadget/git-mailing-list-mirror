Received: from pfout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CFF19F43B
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 09:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725354882; cv=none; b=Btl0QXtk/ipfQCSwd9JXd224ejuduvPWyo5eAxxrhnGVaUxZXMP3zhMqctYuAZzs2iWbuLjL0JPD/sKmQdSre0tpI4Lt/CoCiFnc5drS8hw32nittnDN/0G0dXjv/IJCpVDyBvsTM6DJ0SzVjf7AVvTaAko3tIH/rJ6FcHHOnng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725354882; c=relaxed/simple;
	bh=axVoeBeO3+G1i8CjNEGnZ3LQIvmMNw0SOha9RctPyTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jKMuO2jTHCYUrZVWH6jSwLraCQCy7rUQ3Tc6MWl0/7THIMCH8gjw7Z4GXoBEsVbFs3abnRaN9iv92zMre5CH2yXJKulWPwvHVCN9TOLMww+QTWYPMP53xfacppDHcjeAJIInN/YXG7iQtpErSrw8iCsY3kcCbmCDfd2emeUIyAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=O/tcF9hw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g9oEiDDl; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="O/tcF9hw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g9oEiDDl"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 0EFC6138037F;
	Tue,  3 Sep 2024 05:14:39 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 03 Sep 2024 05:14:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725354879; x=1725441279; bh=vE2Bw3zlWz
	0JKf5giy+Bb5ybj8Rkmr9xJz4acHe1lSs=; b=O/tcF9hwDy6L2BpANelqULwBjf
	XIJum0Y/+T2xgWkLku0pFlSc+E7QrcZ82TExyQXz5/GxCK7XimCMg3Y8MHCc4oVE
	fs86cMNfgPx0nt55CnXlCq45J9bJIbVT5p2PpjHkEffkaXhf5pxc8tg/OEqbaXY5
	vFvhO3T6YkBoR1e/WnkMLh+itr8fX1+SqxwkF1DBqdZb4LYauQsZi0GiNqWXnTmU
	jtm5ZKUZOzCMazdEjPmkAWZCRYdZOBeruxJ6JveOvfXjKBYcAzpstI6V67aCuTWK
	8ug6IDDBcLDLb46XGkrQ8wufLvMRxRZM7mRJwp3elXPEYHAViu40jinwxM2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725354879; x=1725441279; bh=vE2Bw3zlWz0JKf5giy+Bb5ybj8Rk
	mr9xJz4acHe1lSs=; b=g9oEiDDlgAO10U9Wgmu+HeAxI9YtyMP6DvdfHA6/c/H2
	iw4U1RDiNOstcooOt5y93LeRduoWuwgqjcAziyOE9WloVVp+XWPttlNcLU4tAnZ9
	X9kt77PL+DBeKny3lBUVlW29EtwIjC9X2PNSPLekCr934Ky0OdBLGNL2yymtL06V
	+PkVzZPM1ckMXZEqnWdlyoAj3tXn0JJTpeXEmK6qaEvzwgwUAr+00Fi8jzL8l5Je
	v2Vc72diiDeQ3ASAGXjHJ/F2VWZWirKx/AgSfoIXHN4NJR1NtHQWfwlR+tZZRQVP
	T7X8/mN6sN7SV4y6cyB1YmOGItIJYqMiWf20s/0Wsw==
X-ME-Sender: <xms:ftPWZv7GHG_6Ac7cmgiK44_BXUke7ugBSgigFAHgmKZyvABHMwy8EA>
    <xme:ftPWZk4KJygBGMtAoUpYINJmgVTISLryhnj9VDxd5tVkcOsu5ssqTe_Iezw-zmfzH
    bbg8io_Jtjir_TBDg>
X-ME-Received: <xmr:ftPWZmfPKUdAMqt87MAxpr8HcrZ6LG4sWzstieLAEQK-PqWIqRsPQchwGEdwhSr8xMVdWUJ78GAKa7pF_8RQ4zcRFkOeD9z21wNmDvnElG8nOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehhedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomhdprhgt
    phhtthhopehsphgvtghtrhgrlhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepshhtvg
    grughmohhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohho
    ugesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthh
    hinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhmpdhrtghpthhtoheprhhssggvtghkvghrsehnvgigsghrihgughgvrdgtohhmpd
    hrtghpthhtoheplhdrshdrrhesfigvsgdruggv
X-ME-Proxy: <xmx:ftPWZgJF-6ZzXzwqrORTvpSZ2-GZlIecMit9xErOYJFnEAM1M-7SWQ>
    <xmx:ftPWZjLyF2982nqb07jRNhgyQfEUF5jNL6h0zH4zFpN0x50grcnvTQ>
    <xmx:ftPWZpynyfO4JBrArBO5pyvghxYSZFbp5uyj0N_7G5bEKq-5G6NxJQ>
    <xmx:ftPWZvIW4Dfq_pG2C7I69OAEcGLsTmnUfGWIDcZmxHhntKzrt2973g>
    <xmx:f9PWZkWqU367MMII_T60mxJeit2zFCAkFsQZrM2I_GtNSAR0hWTFTkZy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Sep 2024 05:14:37 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7ce3ad88 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Sep 2024 09:14:29 +0000 (UTC)
Date: Tue, 3 Sep 2024 11:14:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v7 01/14] t: do not pass GIT_TEST_OPTS to unit tests with
 prove
Message-ID: <b67f10ec0b08699eec93e3a7eb6ef3e06b5cedba.1725349234.git.ps@pks.im>
References: <cover.1722415748.git.ps@pks.im>
 <cover.1725349234.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725349234.git.ps@pks.im>

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
2.46.0.421.g159f2d50e7.dirty


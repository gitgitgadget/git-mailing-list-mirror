Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781A6839F4
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 07:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723793775; cv=none; b=PfxUy74hNfgd6I2gJTqrpWF8bNgK42L/1dGWsGHh4QCa2RPUnGymlZt+7xd1DzeB+4AE2t3nOTcCXiqMbJbuMSdYG/+NNDDunDuVYjmU96PZxgeoT91S8EKKuqxNGDEl6mdGUxYxe45cCGGourrvM/7Y0r+UkfSdPIG2mae7jTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723793775; c=relaxed/simple;
	bh=B0x4nMCDptS6Dx0fUemWGRMIUeCKlPsrFIxGNUbN3VY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vpjjf7FyT2gFR2diSPMBjrIaYJeNYbEJZW3J0tdgUtlUmbii/ttBxe7dLkif4ifBtbzOzrVwEB0Kw/6rUphT5mVGtCs3Zqjq2VI5dWgcwRGDZf68tS9y1HUO9fCgO6zKYv7+UCx4SH79NgTnCxgpjgNNfK/FV8NvY3zPsAEIjfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bTKmFh+S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LONuH8ki; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bTKmFh+S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LONuH8ki"
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 6CB05138CADA;
	Fri, 16 Aug 2024 03:04:41 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 16 Aug 2024 03:04:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723791881; x=1723878281; bh=n4d/teAYQr
	+mxE/vfY/0lfZ3DGDeOvNvVlG8shdrbJQ=; b=bTKmFh+Si5ihZW4Xv8SLrP9jcF
	rolbNK6mp2gfr0/cBtDSPfDrCKaYXZIWrZBUiepztcpxV5a3+JLHcgqyLkD9qNUN
	shX76+GZmDo14SCcuDpUlyhjI/TPAmB50tNoEOewXL+JhARLl7U1R0UB2APu1Y4y
	shI5BSFdSFO95QT7sV7+9szr0gr2AgnWl+oGd3cOOPNTF80jGvu5wSHXDdKquJXq
	rPcncmLm2dq/uSyoXlM/t5/III5gLFH3otbKh7ncGA/F5BjYNDGt5snjRdKEgw1r
	1Y7efsUBfcwQAJPgQoarNYshnLJNTzOAFJJ3YajY5EE2vKVDVJaiShYkhV+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723791881; x=1723878281; bh=n4d/teAYQr+mxE/vfY/0lfZ3DGDe
	OvNvVlG8shdrbJQ=; b=LONuH8kiUAfl8InCBgk8mZY1Bip8Lk452xUziYN0Pf5C
	5H8BMpgWZUVHZHzPPgptCWnSZ7/PhvoTAPpH2QiLFgqz62Z1tSr5I1xh3he5DFsS
	JjysSLT4QMUg1WEvJxUWxeOSA3klmtVgctIAOgFN5V1AoQyb3h3Pen7L6fPELXwL
	rTN6hm/kcuMXsMiBaNFH0FJ+F0j0Q4Pt02w3gircUgfOoyus5HO3L44m9lkVvDUm
	Nx50jK7cDq4YRT1Byu9h1PgwxzpbsVewpNWmll2Zo06Myb52t1BRD4yzUhXsCyTv
	OPFEV20Du0ZduRj1TUusoVdfdvup5M+8YS/Dl8iJDQ==
X-ME-Sender: <xms:Cfq-ZtbFvvfzwrzghql6KR6k15zqnC2pcZMX1_JmJ-Gc_iAYoeyAgw>
    <xme:Cfq-ZkacNh-9BLsCmVNhJJ3aTCIn0au6JiW0wng-qPayfp4Wovw_FEdtzt4F6LIZq
    UQmmxDDOQtWtl19dw>
X-ME-Received: <xmr:Cfq-Zv_FjxZs5GdDjXsmjfMgqpYfvgxx4HXx-jYmyET_vipKTxCXxXlSFphfeIDJorc9s-HXnBhxOd-VML8sLgzyN88VT3Ju1VOoOxHxwVneWU0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtjedgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeekpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrd
    horhhgrdhukhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtoheprhhssggvtghkvghrse
    hnvgigsghrihgughgvrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomhdprhgtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtg
    homhdprhgtphhtthhopehsthgvrggumhhonhesghhoohhglhgvrdgtohhmpdhrtghpthht
    ohepshhpvggtthhrrghlsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:Cfq-ZrrTEbURtNrUS98r580Rpxct4vrDT2fNJ5ZswN2aTVOCA_kt5g>
    <xmx:Cfq-ZooGjNQ1fJ9saiMpLlG0HEWyyKokbrNWGCIfkTod0o7jHhH_uw>
    <xmx:Cfq-ZhRhnYHQB6cBZ-mmwePtOS1jGhT7cx_SEJ2VGCFstTZZg-nr6w>
    <xmx:Cfq-ZgrfR94HkWOYMfUIVDRE-8glVSwOTyFGHrwiKPHGPaw757UIyA>
    <xmx:Cfq-ZkcsSGnXlwwnSTqm1sXpl3Q2hoA-CocxTpM21FTTJrYMoaiwEUli>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Aug 2024 03:04:39 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 15a2de5b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 16 Aug 2024 07:04:16 +0000 (UTC)
Date: Fri, 16 Aug 2024 09:04:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>
Subject: [PATCH v5 1/9] t: do not pass GIT_TEST_OPTS to unit tests with prove
Message-ID: <832dc0496fb4daaf858a4b44fba86695fb1e20cb.1723791831.git.ps@pks.im>
References: <cover.1722415748.git.ps@pks.im>
 <cover.1723791831.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723791831.git.ps@pks.im>

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


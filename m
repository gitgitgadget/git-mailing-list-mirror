Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665A11714C9
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 11:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723720928; cv=none; b=FNk6DuzTcFKYWzXvMQpp+vBZ9TTtmuzccVaHa2b/xsdHMdsnBSXSgZclCVAvzMv+DBlnmihITyMlYuPGnjvNKe4yJ+jjhLSyDO4gNKpABjrCoFs/9dndjfOoUb31KNRl2zgqBSctmv3tXb/TfXq8xfZok+HAHfA5JrrXLmOYnp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723720928; c=relaxed/simple;
	bh=JXOqFMVoFZlSWL2x49q76QT7ZHhUe11LJcHISCov8b8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pCIn60ywOETJJLbe/fRKM6PFnX3pBcPQE1u545OXueUhAWidKfOw6EZjhbHdI8kemuWsCdj+u2OFGp+JIx0mqydMRRG9RP8O7p4g7Uc9iL8ErrPztOGLfbpokksHoPeg8GWrs9dLeP74uLGp6AGcim4xDAJEPX/hMwGAS8lGBPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dkVwENDC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o6N69lyd; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dkVwENDC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o6N69lyd"
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 260FB11503BC;
	Thu, 15 Aug 2024 05:47:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 15 Aug 2024 05:47:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723715266; x=1723801666; bh=0RQMF889Eo
	js7N+NpOXHnT/wfqTlg2E2akgIbStPR5Q=; b=dkVwENDCOATGF9jZxxDFkKnFjH
	ZnuhlCAvxxbr3BcESzEzyRZ/skKFcyjAfk6AqSNpNEBdAFn8Y6kPNK4mfq7mtW+s
	K+3ukxTXBwQZa1B1GAW68LVUA8xRzd3Qzid29xACWvhpin92A95YW+3/UP57aCbg
	oqH7IScq9vxv7uWqYImZ/6hA4EYuokjqzQWvZRs88ukcHjX+vHKUrTdC0QAX3xvF
	NnaLCInGLtLUEaZ7dLxc4kmCalGROVXpmSSw3xcAUuTo9PXgf292ilWRIOyPn2SG
	PRTD6GseLQgz1spQWZl5so1fOH/6D2+NB21HQlxAh6yvsyq7F2KSiYqkj4EQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723715266; x=1723801666; bh=0RQMF889Eojs7N+NpOXHnT/wfqTl
	g2E2akgIbStPR5Q=; b=o6N69lydeCBBKSdgUZDOXCO7UAvT3qM4G16DOgFDrBBc
	FxMZTkbLRwghsapppJeFcEYYNkKJaJzG37fSIJSLs8sTWXL9ZJvKtvJCUSu7V8jU
	n4YZ2NM5f1iaP9GsKb0/U1q76uXt7Mq/DRf7BUg33GVlfKjzu9dZJ1J2kYPNyQsR
	NmfoHGIbKK5KHwNtIAnrZlNL/vkhg/342NwZSoYRrKvkIsOmdLPqastw3PGiYaYG
	abeUdipYyjqctI5JqLX0gt+KrQJ4BEX0pAVmOI8vV+7Jsngl6tzhcTmpeYfZXAJH
	b6e2UoNlH+4ZuRJkgRUr+TaP5ZDAiXtV03lm2lwWXQ==
X-ME-Sender: <xms:ws69Zqb3WblnpnMYXDAKBt2dBT23fogGf44R2bxj1FjKRwdOKEOmoQ>
    <xme:ws69Ztaxy0jxC7s2lBAwjLx9WvH889HMwnKaYItJ28L0Xefa1OOxdDdbq62ZpePJX
    WhNqJyOc3jPNuMGhw>
X-ME-Received: <xmr:ws69Zk9UKX2ySVrdu7awVfZAfjBmW2qeEnm7be5Y7nGHayPtXvM9FRufunzULJE3lPcCTpaterw2UpsX-d3VjB3Sp-ta4PRbc5gI0mzjkXa9lg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtiedgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhephfeigfdvffdvtdeuhfelgfelhefgfeevueetffdugfeh
    tefgveelhfeuueevuedvnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlrd
    hsrdhrseifvggsrdguvgdprhgtphhtthhopehsphgvtghtrhgrlhesghhoohhglhgvrdgt
    ohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruh
    hkpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hrshgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtghomhdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhtvggrughmohhnsehgohhoghhlvg
    drtghomh
X-ME-Proxy: <xmx:ws69ZspLD-xW0zN3aZqsiKM3zJozL6pS7v2oZkfDsLyvLhtNTihktQ>
    <xmx:ws69ZlqFFofzXDaaG5zImiWDbrXYyeA6FPCCDvVoBBXUAbZWrAh5Ag>
    <xmx:ws69ZqQ_RDyYgU3j5T2fXANGJi2aFHnIRGyB2UGBLUgNX4bVugHoKw>
    <xmx:ws69ZloCClBkdDf3_RaGpX4Sd6YNYKxWWsr6rLnZ3UW-lqYOHH29hg>
    <xmx:ws69ZpfuoSXxDhzBTo5EhR2NypGb2tM6XYjGXJvYsTbz65hPBGXUOus9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Aug 2024 05:47:44 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 371f2ed7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Aug 2024 09:47:23 +0000 (UTC)
Date: Thu, 15 Aug 2024 11:47:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>
Subject: [PATCH v4 3/7] t/clar: fix whitespace errors
Message-ID: <e0f99874cc0233338d225cf98e88b7e9b51a55f5.1723712012.git.ps@pks.im>
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

Fix whitespace errors in the clar that make git-apply(1) unhappy. This
has been cherry-picked from the upstream pull request at [1].

[1]: https://github.com/clar-test/clar/pull/97

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/unit-tests/clar/clar/fs.h       | 2 +-
 t/unit-tests/clar/clar/sandbox.h  | 5 ++---
 t/unit-tests/clar/generate.py     | 1 -
 t/unit-tests/clar/test/.gitignore | 1 -
 4 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/t/unit-tests/clar/clar/fs.h b/t/unit-tests/clar/clar/fs.h
index a6eda5e5dc..3e39890bd3 100644
--- a/t/unit-tests/clar/clar/fs.h
+++ b/t/unit-tests/clar/clar/fs.h
@@ -146,7 +146,7 @@ fs_rm_wait(WCHAR *_wpath)
 			ERROR_PATH_NOT_FOUND == last_error)
 			return 0;
 
-		Sleep(RM_RETRY_DELAY * retries * retries);	
+		Sleep(RM_RETRY_DELAY * retries * retries);
 	}
 	while (retries++ <= RM_RETRY_COUNT);
 
diff --git a/t/unit-tests/clar/clar/sandbox.h b/t/unit-tests/clar/clar/sandbox.h
index 0ba1479620..7c177f3525 100644
--- a/t/unit-tests/clar/clar/sandbox.h
+++ b/t/unit-tests/clar/clar/sandbox.h
@@ -25,9 +25,9 @@ find_tmp_path(char *buffer, size_t length)
 	static const size_t var_count = 5;
 	static const char *env_vars[] = {
 		"CLAR_TMP", "TMPDIR", "TMP", "TEMP", "USERPROFILE"
- 	};
+	};
 
- 	size_t i;
+	size_t i;
 
 	for (i = 0; i < var_count; ++i) {
 		const char *env = getenv(env_vars[i]);
@@ -151,4 +151,3 @@ const char *clar_sandbox_path(void)
 {
 	return _clar_path;
 }
-
diff --git a/t/unit-tests/clar/generate.py b/t/unit-tests/clar/generate.py
index 931b4d60d9..80996ac3e7 100755
--- a/t/unit-tests/clar/generate.py
+++ b/t/unit-tests/clar/generate.py
@@ -264,4 +264,3 @@ def write(self):
     suite.disable(options.excluded)
     if suite.write():
         print("Written `clar.suite` (%d tests in %d suites)" % (suite.callback_count(), suite.suite_count()))
-
diff --git a/t/unit-tests/clar/test/.gitignore b/t/unit-tests/clar/test/.gitignore
index 3e8ae0a3a5..a477d0c40c 100644
--- a/t/unit-tests/clar/test/.gitignore
+++ b/t/unit-tests/clar/test/.gitignore
@@ -2,4 +2,3 @@ clar.suite
 .clarcache
 clar_test
 *.o
-
-- 
2.46.0.46.g406f326d27.dirty


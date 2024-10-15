Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EF41EF084
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 11:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728992736; cv=none; b=RNuV1WsPt5aV0Ia18pZLSIwKxLdoMVyF5BBkyCRr/NvNirbt4G9/k6gp6dan8+PKLNkL/Du0cAszM+H3NrtpBRo9XtGOLD3uKA//NPB/4CLQJIbX5hcPQuoUJqUajAz8qF5Kqn9tD6l+NqpgR/TxMgczL9qdKFxF2yvz/rw/9Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728992736; c=relaxed/simple;
	bh=by8igO0q7de+8Pr4v/o3o+r6WtjlLD0Y7USo0Ulpkbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7jF0W40VAUoYNPLT7hgs2NrgmsLlykDGhijv9WitktPVFhsvyp6EVfpzWOpRJYcYvqRwNk///uuOzr2ZRJVfx0CiUWavkGmFLwR0V81nHFtRYoAqh7dUt1adX9jwQDYK2K2l++bRtoaaaWl8/BUel4dr0Se+vggO+OLWG+bRfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dEW81hvO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c4TwKSkX; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dEW81hvO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c4TwKSkX"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EED1D25400C0;
	Tue, 15 Oct 2024 07:45:33 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 15 Oct 2024 07:45:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728992733; x=1729079133; bh=ptVDxD4kjQ
	9TY5IlxMJteqiioPQyfYws8mLwL4HXbUY=; b=dEW81hvOYqIA/VD64DAycVdMqX
	pllcMTTNGw1tgsEcy94dwwmAP4BjbwItDsNULVdfdQHCvox8edpTNsbBC5CDH2d5
	eNHkClR+ZIUJYiS7+3PblzBTDg2dACPe499iq8SwmspKY0URinSgAUl+aJmKdgu2
	2KYHabajxgx7LNwQgjB47EHsX9gFP1BRXYHpRt0y5HhxQQbfQcOreCIbLBQ992pp
	sh+x9Igvc2yhBP0XsPPATMreouQu73iPYUNle7CkYCgn1TMy1Vp+7S3VY9L7G/Vq
	cjzrhl8pvdtal5NZa+pjmAm9Nd5dDiGBOpRN/fL/olsfYsM/Ii2lvnZHrt6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728992733; x=1729079133; bh=ptVDxD4kjQ9TY5IlxMJteqiioPQy
	fYws8mLwL4HXbUY=; b=c4TwKSkXJ6tmiPeJ9lftcsjzRL8UPvTa/hVZyj52MP7X
	UDFFKr3zqw9o8x3PEas4gVsLUaI+MO8jaV0D9YKI8J54h+3VHRPrRJI4BY5U/jIF
	Jong9s/w4uhBS3tyEKDS9h/CewxoXlJAAq1W+3S4Scpve8jajLvH1T7bvxChZhRD
	tqCUyioqIBTpITUkqe3atLJ6y5+Af5g9lHsarJnRFrT9CHwjgmZ8gj9jJt0qatKE
	aH7v0vCEhcaiQ/lWUUN2+XQkzsc0Nd82iFe7EHeelb+a6k15uyNMJMrd3hETmWT8
	nt5IZeGUB+61Pj2z4BEfgtai74yFTxD24bij+HW2Sg==
X-ME-Sender: <xms:3VUOZzmQwV5K3gctBHSsWaAbg-fIHdO1CXCPBZvllcj1NalGYNpfgA>
    <xme:3VUOZ226f-qO_6NXLHtPZ5myo2WlNisZIpimidpumZ6KTQUKkPcK2s-Z68e-Xbf1N
    IjGWI0N8_3CdQAX6g>
X-ME-Received: <xmr:3VUOZ5qmvPOWuc49HBxrDtzznggR0OhXksZNlM101O1vKkBkZ9-dnL5vTflXfveqlTxgDL295rdA9iohLpSqtwPPDhFUCWxCfQREc9XhYxso-Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegjedggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:3VUOZ7m33KulFtf6dFIO3yP3ffafOYVSG5HePIcZXhh6JjGqHeeZLA>
    <xmx:3VUOZx002oIcXfTrJCNPWUQfyKCqE3s3eh2YZsi3JitULwKdMpic3Q>
    <xmx:3VUOZ6vaXHPqFnbD-STQZq4ED2N2gHF0CIBtIbyWRS3BBEsEXaKNYg>
    <xmx:3VUOZ1VOQN3M-OFHrLVOaCnhP4Z_EEGgX1J3S5DWbJkEuoqEFO-3Ng>
    <xmx:3VUOZ6zKJ0Ax5ycCZVRlluhCLd2F5zWafvTnjv62QDg0wSUg7-bui9tE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Oct 2024 07:45:32 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fffe76df (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 15 Oct 2024 11:44:18 +0000 (UTC)
Date: Tue, 15 Oct 2024 13:45:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 08/10] t7300: work around platform-specific behaviour with
 long paths on MinGW
Message-ID: <13c06a8129b13a672d3b8329db83db103607787b.1728992306.git.ps@pks.im>
References: <cover.1728906490.git.ps@pks.im>
 <cover.1728992306.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728992306.git.ps@pks.im>

Windows by default has a restriction in place to only allow paths up to
260 characters. This restriction can nowadays be lifted by setting a
registry key, but is still active by default.

In t7300 we have one test that exercises the behaviour of git-clean(1)
with such long paths. Interestingly enough, this test fails on my system
that uses Windows 10 with mingw-w64 installed via MSYS2: instead of
observing ENAMETOOLONG, we observe ENOENT. This behaviour is consistent
across multiple different environments I have tried.

I cannot say why exactly we observe a different error here, but I would
not be surprised if this was either dependent on the Windows version,
the version of MinGW, the current working directory of Git or any kind
of combination of these.

Work around the issue by handling both errors.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t7300-clean.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 0aae0dee670..12ab25296b0 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -747,7 +747,7 @@ test_expect_success MINGW 'handle clean & core.longpaths = false nicely' '
 	test_must_fail git clean -xdf 2>.git/err &&
 	# grepping for a strerror string is unportable but it is OK here with
 	# MINGW prereq
-	test_grep "too long" .git/err
+	test_grep -e "too long" -e "No such file or directory" .git/err
 '
 
 test_expect_success 'clean untracked paths by pathspec' '
-- 
2.47.0.72.gef8ce8f3d4.dirty


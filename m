Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22AC4A11
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 04:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752727421; cv=none; b=Tc5IMNfWDhK+uXAfqiI3E3R+POW8cPQkgDL7QHYjBEiEe2bCU5QF3tTmigQVpKTKqvUMUcle5LcHKecBqQktOJOcE3gNYdwi0dEsfbAfJ4Q7CojweXHPTs1oAEeD0WNqksPGP4RQKkojVCDfH9n7uBfgytdx6SiN0alal5w0fZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752727421; c=relaxed/simple;
	bh=iY6IyRBXLQcaiLL8xIsVFwSRGN73VPfpw6kXUyRAU34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PSePu7Fi6IuJTg957OXaez2MTXJKiegEGAzC1y2iiALjsq41TBDhhws+GZRaP4l1ZBmUB8lS9B+tPq5NBCBUxp3EQqsgiVMrPRpWuNmp003VaXRn4uwBYjGwKx1UnMKdbuyCKtnTbGo5d3P4ShEJpPd9Y0f0I/8FEQN1HbLPLM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ti4Y4wQC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nBcgd+7J; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ti4Y4wQC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nBcgd+7J"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B1D977A0170;
	Thu, 17 Jul 2025 00:43:37 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 17 Jul 2025 00:43:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1752727417; x=1752813817; bh=Mg63si056L
	x0F5fN77VzsypO/KlfrCQA2lAlWU2IiRg=; b=Ti4Y4wQCVFKad/KrbDJyiefz4V
	V0tq9H1gBVdJg+G23IPLK3o9gOcUKKrA+dOml1Dj7wBMriiFNZNLLYD0uMmU7DNT
	rEaSIMqANz8xcm/U6vIy0m/PXtceogUmomlXhvwH5/kSp5sFvjfHcsSNjesYqRt2
	r7KUHjtXpDVvGaWA9FAdn6LX8NJFqh1kR3Uh/qg77rXwouc2AMZVjOXHnKmRsedH
	XidUIkAWNlD+6NN/PkN6UnNWILXdOoa3DSAVMEPE7P3txWEdQMV6fLvhHe9rkDSh
	bthNtd8DGpmHx8J2D2CvNL4bHUWxDyPE+O3lystjd+DBD9l4RIMW3lt1pPEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752727417; x=1752813817; bh=Mg63si056Lx0F5fN77VzsypO/KlfrCQA2lA
	lWU2IiRg=; b=nBcgd+7JgxietOVvzYF9JTCA8iibJrDg95V9p92XFwYM3xdDTxI
	ZUxd68MVVogSkoVOaBXgRpRyYvxz34ErYQ0oLD5tAw9PNHmzQuDoi+sP46fwegU3
	Yqx7FORmwCbG41AWA3Lq9eEtBAdu3sMJwn6o5s6kTnIQWIhl+iqtn/dVhlqKMgXX
	6lI2cQ4eqbdw17YXvdPixnntxD9wHD/NmYLGWvTgBhfJ+FjI1dX1h9EJrAZ2sSmb
	r9qIU52DTmlUOW2pJiHhCGaNS8QWTyR4rB1ftXJ64KrESkAmMMvDH7UGt2aEwIuH
	GOzgZ8kZsW4u6C34wQDNmhEhGQa/6emPwKA==
X-ME-Sender: <xms:eX94aFO4-NX4eoxYhZ2-ZHHO0cSZ1MDtZ_aeoXOOUlcXysALikSYpg>
    <xme:eX94aIIDTqsdPlFnwKJ3I0o6V5IzCibrG_qCoMF1SZS6rdKvRtQWmtV8VofinuRsq
    SsXtr_lvcAKuKN6Pg>
X-ME-Received: <xmr:eX94aGGTECdkyJWJxWnnKju7OHfSjIqEggtxWl_emvMhB6bJm7y1aWjEoDVdpK7umtE31RRsChgY1z9fVGQ8Ywypg_VxzezCM6JwlxSo4ON0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehleeiiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhe
    fgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:eX94aARkqmvkOq1SmFfRxiRFFQOGUEj9DSe7K_xYb_ofnP8sIAyiqQ>
    <xmx:eX94aCEZsDZHh1uoLLkil1puarI5P1cIpHHnO3uSynUVAmsDtmZRFQ>
    <xmx:eX94aM8LjyM39kwO5q79qnhb-0u5Ul7itk6L53zLpX9wP_EbIQtzAA>
    <xmx:eX94aML4Kb8mWhgncRTyqPIvoqxdixnwO_M2KUYh7QAl3pzPkIM7IA>
    <xmx:eX94aHxZQ3GwmFfdqLCORvnep29s_0PV68EdnMFPq9Vusnp_QnTB0UbP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Jul 2025 00:43:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0adc2e29 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 17 Jul 2025 04:43:34 +0000 (UTC)
Date: Thu, 17 Jul 2025 06:43:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] ci: allow github-actions print test failures again
Message-ID: <aHh_c3KDGC9oQIzQ@pks.im>
References: <20241213-pks-meson-ci-v2-0-634affccc694@pks.im>
 <20241213-pks-meson-ci-v2-8-634affccc694@pks.im>
 <xmqqa553alp1.fsf_-_@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa553alp1.fsf_-_@gitster.g>

On Wed, Jul 16, 2025 at 02:07:54PM -0700, Junio C Hamano wrote:
> eab5dbab (ci: wire up Meson builds, 2024-12-13) added two instances
> of a very similar construct
> 
>     FAILED_TEST_ARTIFACTS=${TEST_OUTPUT_DIRECTORY:-t}/failed-test-artifacts
> 
> one to ci/lib.sh and the other to ci/print-test-failures.sh
> Unfortunately, the latter had a typo causing shell to emit "Bad
> substitution".  Fix it.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  ci/print-test-failures.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/ci/print-test-failures.sh b/ci/print-test-failures.sh
> index dc910e5160..5545e77c13 100755
> --- a/ci/print-test-failures.sh
> +++ b/ci/print-test-failures.sh
> @@ -41,7 +41,7 @@ do
>  		case "$CI_TYPE" in
>  		github-actions)
>  			mkdir -p failed-test-artifacts
> -			echo "FAILED_TEST_ARTIFACTS=${TEST_OUTPUT_DIRECTORY:t}/failed-test-artifacts" >>$GITHUB_ENV
> +			echo "FAILED_TEST_ARTIFACTS=${TEST_OUTPUT_DIRECTORY:-t}/failed-test-artifacts" >>$GITHUB_ENV
>  			cp "${TEST_EXIT%.exit}.out" failed-test-artifacts/
>  			tar czf failed-test-artifacts/"$test_name".trash.tar.gz "$trash_dir"
>  			continue

Oh, indeed. Thanks for catching the mistake, the patch looks obviously
good to me.

Patrick

Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C6E37D103
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 07:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775115976; cv=none; b=UJTLnhep3IR+DsEJNAUwGAU9TboarwI70kjyU82OQ/60hkgQ/jEUIRa5bdG0FfY2d2Fv9JPPjRv41SG11pf9yDGWLdZrOhGZSe/QhWSShCNzc4Amz/sagKVq0pdHU3elZDfbmrLclaTjPuGl5ZqjIKvjRZhTSQHbCvCpHU0m9Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775115976; c=relaxed/simple;
	bh=emwJ8RNsEQn7WQwwUQXRXjRuoRwo6hc5clvXUmdzXA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o8AGCMPKdhDfJqc63yK4yGHeFClfcW0li7MD++MwhBvpqkE3LSzilTpAt8T2GnbYXviyOwFpkkl42CLn9bz6AFIl9Lm9iyDXZ9ogmGGQgw8LuFgFN3Ay4ds8+nlgXS+MtVr3cHpC+rsBVjM764/5zCWZhn9p0F3jTWZTsYx2C+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CmyZjQWJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D7xFIzTk; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CmyZjQWJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D7xFIzTk"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 97A291D003CB;
	Thu,  2 Apr 2026 03:46:12 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 02 Apr 2026 03:46:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1775115972; x=1775202372; bh=t4TyM2mzXP
	VE80fosiMmIhyqRlHsVzuJIYHseMJ+cXs=; b=CmyZjQWJI4SK8pommi4RQDnFPH
	/EWBUQ25+PxKWph5a8rX2YyTkDbadO47OF6GtTUCTifODbx/013atfS60SW1z2YP
	AwlowftsmniSlnvHkYxWSLELDcbeS+zagY5t03lYqEYmZ5a73X9K0+cXiq+cQG9b
	XUz0mWeKl5jqcsGGS1nQvRVkjRcpY1hBtPW1HIFq8vc9rCe9hlaR14aLogNC8YXC
	PE0+eKwwHdzghi/ArXd7BrvsPUBLxq0UYwPjE2nbqgJsVRsrVvaxO+OV/w4sRyCz
	12YALGuvwfNghWGx4BrQa5eVo6Hn/2C1YXiYzW6+wrSP77LbcPvD4j4l9G1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775115972; x=1775202372; bh=t4TyM2mzXPVE80fosiMmIhyqRlHsVzuJIYH
	seMJ+cXs=; b=D7xFIzTkxGuRKkKXmwBBZQ2ea6d0vAcPK2ezxUrntGK2Figbenq
	8ucyea80Vh3nAHfiNA8cX5jz2Lwub7XEXiiuNymUXLmxf5oXXBBLpnqrRtBumr/C
	HVHzHfmmab2r3WHH8cmCsnDLVN8vd4B4kMBqnq/U1TGgMaLYg0ZF4BpsL15EZpZX
	em6ntWh7K+SNyWDHnafrQHe7qxNijbSPB9iVay0Pj1DvaS5zPr9bheRvkb2w36Hp
	GPiGYBKwL6XMQENuoMYFKU9uoQ9e3SzrST418YeQ3tTh633ZKdfk0mB80Y2DxMVY
	nuF23gO2Y+Pi+WF0Fbm/iW3SUNJW0b3HHtA==
X-ME-Sender: <xms:wx7OaZ2joE2C47_VA9z5fjvchnJUSHF-5vDC9LaMVJkEXtHPov3cXQ>
    <xme:wx7OaSW87lktO2n3rkpHrSVd0UodtxmpMETtTwNlbnqadIgq1JdIPBLalAzk512uN
    7ChJpVkwvB4ueAY6R_NQj3IE3kN6PTVLr_tIl8xFDDlCmf_qtSypA>
X-ME-Received: <xmr:wx7OacI1Dzs0pE3dnCcBQjAENazp2Jb0fzjgCC9sZxxEkZ7dKxASSqc6XYV8fa52I_q16Rt7HXtZOjuFRWrt3F7XSlBVKSU0GArYt0gftg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehgeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepve
    ekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhl
    hidrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhi
    shhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtth
    grhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:wx7Oac2dTSn22ny2ODc0FZXdvuofFNgIxSQlOz9U9sVwswFIVI0czw>
    <xmx:wx7Oaa4yg9i4niUrIXSFrsqWOVK9rCZ8we13ZXcsi0BWub-BoZxgGQ>
    <xmx:wx7Oad9HGv4r15SfwiiyAFC8rCuMZdphPE85OQlDdZVSKr7aBVOYug>
    <xmx:wx7OaZVPMeX7gep10V8BNMZ4cpjZGzePjxsVsl68bevmLhSko8gLWQ>
    <xmx:xB7OadGlgybC43dx-oc1DdV67kL-UaNQEj0o1xm-XLz4G7XLtvmomWqK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Apr 2026 03:46:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c27bf279 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 Apr 2026 07:46:08 +0000 (UTC)
Date: Thu, 2 Apr 2026 09:46:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 01/10] promisor-remote: try accepted remotes before
 others in get_direct()
Message-ID: <ac4evWK9k69LIV91@pks.im>
References: <20260402070613.85934-1-christian.couder@gmail.com>
 <20260402070613.85934-2-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402070613.85934-2-christian.couder@gmail.com>

On Thu, Apr 02, 2026 at 09:06:04AM +0200, Christian Couder wrote:
> diff --git a/Documentation/gitprotocol-v2.adoc b/Documentation/gitprotocol-v2.adoc
> index f985cb4c47..4fcb1a7bda 100644
> --- a/Documentation/gitprotocol-v2.adoc
> +++ b/Documentation/gitprotocol-v2.adoc
> @@ -848,6 +848,10 @@ advertised, it can reply with "promisor-remote=<pr-names>" where
>  where `pr-name` is the urlencoded name of a promisor remote the server
>  advertised and the client accepts.
>  
> +The promisor remotes that the client accepted will be tried before the
> +other configured promisor remotes when the client attempts to fetch
> +missing objects.
> +
>  Note that, everywhere in this document, the ';' and ',' characters
>  MUST be encoded if they appear in `pr-name` or `field-value`.

Makes sense, thanks for adding this blurb.

> diff --git a/t/t5710-promisor-remote-capability.sh b/t/t5710-promisor-remote-capability.sh
> index 357822c01a..bf0eed9f10 100755
> --- a/t/t5710-promisor-remote-capability.sh
> +++ b/t/t5710-promisor-remote-capability.sh
> @@ -166,6 +166,75 @@ test_expect_success "init + fetch with promisor.advertise set to 'true'" '
>  	check_missing_objects server 1 "$oid"
>  '
>  
> +test_expect_success "clone with two promisors but only one advertised" '
> +	git -C server config promisor.advertise true &&
> +	test_when_finished "rm -rf client unused_lop" &&
> +
> +	# Create a promisor that will be configured but not be used
> +	git init --bare unused_lop &&
> +
> +	# Clone from server to create a client
> +	GIT_TRACE="$(pwd)/trace" GIT_NO_LAZY_FETCH=0 git clone \
> +		-c remote.unused_lop.promisor=true \
> +		-c remote.unused_lop.fetch="+refs/heads/*:refs/remotes/unused_lop/*" \
> +		-c remote.unused_lop.url="file://$(pwd)/unused_lop" \
> +		-c remote.lop.promisor=true \
> +		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
> +		-c remote.lop.url="file://$(pwd)/lop" \
> +		-c promisor.acceptfromserver=All \
> +		--no-local --filter="blob:limit=5k" server client &&
> +
> +	# Check that "unused_lop" appears before "lop" in the config
> +	printf "remote.%s.promisor true\n" "unused_lop" "lop" "origin" >expect &&
> +	git -C client config get --all --show-names --regexp "^remote\..*\.promisor$" >actual &&
> +	test_cmp expect actual &&
> +
> +	# Check that "lop" was tried
> +	test_grep " fetch lop " trace &&
> +	# Check that "unused_lop" was not contacted
> +	# This means "lop", the accepted promisor, was tried first
> +	test_grep ! " fetch unused_lop " trace &&
> +
> +	# Check that the largest object is still missing on the server
> +	check_missing_objects server 1 "$oid"
> +'
> +
> +test_expect_success "init + fetch two promisors but only one advertised" '
> +	git -C server config promisor.advertise true &&
> +	test_when_finished "rm -rf client unused_lop" &&
> +
> +	# Create a promisor that will be configured but not be used
> +	git init --bare unused_lop &&
> +
> +	mkdir client &&
> +	git -C client init &&

Tiniest nit, not worth rerolling over: this could just be `git init client`.

Patrick

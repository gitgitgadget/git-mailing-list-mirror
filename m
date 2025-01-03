Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BB11CDA2F
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 11:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735904492; cv=none; b=HGGHd/rRCBIc8bTOpf6DPo1fTf1fNrn/xbwfxRv+t26ZJcM3W3fNk2MgpFjncxxV1FkY/fqnc6ukIuYqO8I6mPxxtEWhvJgu9uFrO8nYHb0c6PQMZj8lhsfPqYvJZ3ebaZ4rMcMT9D0gDAkp86CYqqquIzF5j87PkujxwG5wWHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735904492; c=relaxed/simple;
	bh=1CWJOaimB+H7+dhIFweU1EtRgaozauUN6hzgsNu4oZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gTEjZpJJLjlyXmiV1J9XdqUsgpXnRmXqHpJwBmuljFY0bfpPQmUMdfkLWOTPX7kiVnzz973yCowDt5U3GVMQcpTUfpjfJ2Q8myUR1qIhLDwWWST8+sKQ+fkSMD9CwBIREzzTh/5PMhNCU31bjhfQaetd/5j43kJ9dnqbW12HiSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rXtvKzVJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y6ys39tt; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rXtvKzVJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y6ys39tt"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 110B91140168;
	Fri,  3 Jan 2025 06:41:29 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 03 Jan 2025 06:41:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1735904489; x=1735990889; bh=j4whGboHmQ
	l/SIZSWydr4tRxVAPERfD5Bo8jluT/72U=; b=rXtvKzVJ9nY5y50UqeAYQhrRHJ
	HwRX3WiWrn+H6WrCrwUzUG8Pa/W9+PWcEffVX3mmu3OXms5SgkFStXs7t8pswy1N
	E+UsPk58ujD1yVCrp3262zqI0vLPCnLWkr6uZjvA0a8Ag33+HiOad1H2ux3xB2hU
	qPWze3TgFiOKF4ogMSxHtY1fiPqTz6NfatKUzAPRWxtaduk46dx2/wGBEJeAWRv5
	BQlH5Sr7Z4p1GuIwkdMsqG7OdX60nZ0Ua/6EvpXsXcN8xAYdsNNZFJanb2dpN+q6
	bUvoVQpspcdZ+EPhpChUTao4hRv7sJzxxYQ0BKUZ5lHRlHV2pYjUK/UQ3JVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735904489; x=1735990889; bh=j4whGboHmQl/SIZSWydr4tRxVAPERfD5Bo8
	jluT/72U=; b=Y6ys39ttDIPbHMuCHHbAbCFkhIrCN95CZqeP82Dv/xBY0sae7Q1
	eeEkIOY0SoeICpN0sMHrhxIDQXTLjCkDo+v++wPOZ6gt6+gwqUnS7im6w9M/De7c
	Nxu4WQC+tKNfZFARMCtgyKaC9p/Z1w0fIKgMDGWJdMNFuUBeeZ7ShusfVKA/iNTh
	VUg2oso/C82UfXRmx0PqPSiEp60Oxe8Wr77weLYK9SejhEHB9wXQDWJUGAUw4P/T
	hRVsDgMk3LlwJVj4Vm9BHu/pJ358kIBXkuL8iVPEkGMIy/31y2oVL6zxCs6ieRzC
	JeVdCN2BWiJnJ8i/mGf8PUr7JZkzt0gehvg==
X-ME-Sender: <xms:6Mx3Z84N-kaZV8WLDAU_o5aYnF9pRazgbPN2dLCh_EvndXTffOVnjw>
    <xme:6Mx3Z94QvYa3wDRaGkLDQ20MdZyhtpmhefXkJ2GmKiGhPC0y1DA2f-5YOC5nbIKoh
    kVqC1g1hKC02hkVeA>
X-ME-Received: <xmr:6Mx3Z7f6r0PNBp18w3V_tfH9scsd_f6hP7j7aIujZova84l2iVKC-HSrDOitWi2syNdHCFzT3UlkW6XPwATdhRRbPmChyWcYDhHP3zdyTyrRdxA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefgedgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehmrghtthgvohgsrghgnhholhhinhhivddttdefsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehjoh
    hhnhgtrghikeeisehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:6Mx3ZxKWxQQRbdna9I62m0im1l9sDYBnpu5LqRT0dwQ_xZdbWtTQ4g>
    <xmx:6Mx3ZwLW0L0tHLN8VQNjcOEuF4Vy4QtGttbaVPBI23nsMoWhE__XFw>
    <xmx:6Mx3ZyyH7_iIP47DoZsQe83ONCGk86ULFVRSGlzps2kRyLBuRSYYXw>
    <xmx:6Mx3Z0Knm2jEEGJZ9IcM2-ck_Yydj8lqgNH27rvBYRkKkz7tbJvYYg>
    <xmx:6cx3Z1EcbqixSwCDC3wy-aHKX2hjRzkS9xrgqQhjsNHMV61QByToXr1N>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jan 2025 06:41:27 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e08ba859 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 Jan 2025 11:41:25 +0000 (UTC)
Date: Fri, 3 Jan 2025 12:41:24 +0100
From: Patrick Steinhardt <ps@pks.im>
To: matteobagnolini <matteobagnolini2003@gmail.com>
Cc: git@vger.kernel.org, John Cai <johncai86@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t7110: Replace `test -f` and `! test -f` with
 `test_path_is_file` and `test_path_is_missing` for improved debuggability
 when failing.
Message-ID: <Z3fM1bT2Z_0GoD4w@pks.im>
References: <20250101225915.65185-1-matteobagnolini2003@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250101225915.65185-1-matteobagnolini2003@gmail.com>

On Wed, Jan 01, 2025 at 11:59:14PM +0100, matteobagnolini wrote:

The commit subject is overly long. We typically try to restrict them to
at most 72 characters. Furthermore, the part after the subsystem should
start with a lower-case letter. Suggestion:

    t7110: replace `test -f` with `test_path_is_*` helpers

> `test -f` and `! test -f` do not provide clear error messages when they fail.
> To enanche debuggability, use `test_path_is_file` and `test_path_is_missing`,

s/enanche/enhance

> which instead provides more informative error messages.

s/provides/provide

It looks like you intended to start a new paragraph here. These should
typically be separated by an empty line.

> Note that `! test -f` checks if a path is not a file, while
> `test_path_is_missing` verifies that a path does not exist. In this specific
> case the tests are meant to check the absence of the path, making
> `test_path_is_missing` a valid replacement.

Makes sense.

> Signed-off-by: matteobagnolini <matteobagnolini2003@gmail.com>

We typically prefer proper legal names in the SOB.

> diff --git a/t/t7110-reset-merge.sh b/t/t7110-reset-merge.sh
> index 61669a2d21..9a335071af 100755
> --- a/t/t7110-reset-merge.sh
> +++ b/t/t7110-reset-merge.sh
> @@ -270,13 +270,13 @@ test_expect_success '--merge is ok with added/deleted merge' '
>  	git reset --hard third &&
>  	rm -f file2 &&
>  	test_must_fail git merge branch3 &&
> -	! test -f file2 &&
> -	test -f file3 &&
> +	test_path_is_missing file2 &&
> +	test_path_is_file file3 &&
>  	git diff --exit-code file3 &&
>  	git diff --exit-code branch3 file3 &&
>  	git reset --merge HEAD &&
> -	! test -f file3 &&
> -	! test -f file2 &&
> +	test_path_is_missing file3 &&
> +	test_path_is_missing file2 &&
>  	git diff --exit-code --cached
>  '
>  
> @@ -284,8 +284,8 @@ test_expect_success '--keep fails with added/deleted merge' '
>  	git reset --hard third &&
>  	rm -f file2 &&
>  	test_must_fail git merge branch3 &&
> -	! test -f file2 &&
> -	test -f file3 &&
> +	test_path_is_missing file2 &&
> +	test_path_is_file file3 &&
>  	git diff --exit-code file3 &&
>  	git diff --exit-code branch3 file3 &&
>  	test_must_fail git reset --keep HEAD 2>err.log &&

The changes themselves look obviously good to me, thanks!

Patrick

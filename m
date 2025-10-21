Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E447227AC28
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 08:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761033965; cv=none; b=uob+YWO1UNoJ/cbIDrpzrca90z94jKCtd93ElFEcOoL5xjlSpKIplzx0D279EZICVJ+bQG/L0TcoOJ9XLmKjfft+fqSD3JuGBBzAD+KKWIcXwDmf2U1q4CJpWXWctFcQVATBWCZcXZ/LIPb8jui2A3KT4OLINJM7E38LRZAmVus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761033965; c=relaxed/simple;
	bh=Q5qTnOTT3tiPCGwBLYbiRLPT5nZPLqxFEYuftLC4IrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=io+Y426fJ5DHm8XzqdaYShjR6my54dRjFE/jlbI4MtXCGAfDvk+VWkX06NKwjq6l2fydKoG832LtwdjoArnO2RTtsQmryEK+rI1qk7aMGXEWA4WBKyIp/8XlVZJ+0Td7T/Zz+mLlaLxKvJyP7jH38zqhRGSw+MaXAKTChkD2Zi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=llF4Ie3c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gL+KwNEW; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="llF4Ie3c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gL+KwNEW"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1BB4914000DE;
	Tue, 21 Oct 2025 04:06:00 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 21 Oct 2025 04:06:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761033960; x=1761120360; bh=aIYarQtDl6
	toylM709FGHJvifYzGAv/OcCmu2NqJS2I=; b=llF4Ie3cqy/WgSTC6SsYHgUS4W
	5uYyCvSyKvZuu2sOujo16t36dcnDFXv866cURt2dn9P9bpI2EUTwX11hWTIvlmY+
	KQvZMjOuGWgkWtjYDZ2XYq5ThRsZAGVIB/ofMpENJSK0l/lXjdVb6L85Z5ySDIu5
	kuhulDO6ZofpowwgbO3ZIZ5vVFUZEum5LraNC6c4Kl/rqeEBI5bRo7XitKM2bWQc
	u7J57g4rqqGTU+PRUlrNCfhkcO+gzqn5NsqwtR80u8PFzmqaqI7xMSctOnAgqqZZ
	9vi07m5gJQ9e11N2U6kW6Nob78cushVSMLfEUPaozv672sjMFaHS+/Tb6Hvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761033960; x=1761120360; bh=aIYarQtDl6toylM709FGHJvifYzGAv/OcCm
	u2NqJS2I=; b=gL+KwNEWYCSBYpp8Jj+KVh66rVUCLtJo61XdoeEos5pKg8vkOfm
	xxCWhw9H9kaUPwrRMJUgOxjcu+tyvD0BynVBytgOxHj3xD5IhJylz9RSd2PK1JL0
	f52SJ1En8YJ+qx4ikPJOP9io1mUuUAsSYPr4buxb3c8jKHqaPahgSddwUcc4ERJb
	X6UBNEYFD4i48Eo7m3wuim0rvHOf8+64ZATlCZkLkCA+KG15URkHKkVcmwFdjVwu
	StGbOxYHuCZmOrdkpQs1hyusOzWwoOmDzHB+WEZdnktP7zH+2fL7t9ara+PL6y//
	cFy0hc+8kgW/ptUpzOvk3/Ov2gTKXpFFNog==
X-ME-Sender: <xms:5j73aKH44_26hi3qnTHbIAww1lghTONbtu6X0M-LfeXA1QpEmTZGpA>
    <xme:5j73aHLtDnuEDsTVgdW3P2BvIqC2Bj0EiZQw18zmn9TRMjz-mUriBa4Xyxg-Oq8we
    1BIxtMaWPi67sXSBSp5P3NdpPiW31odilrc0szvlPSOGeAClftR>
X-ME-Received: <xmr:5j73aPi-GFiOB2T5VE2NEvLhG72zM_B49LF3QuoZLMwH7QSHCf9hriieUnRp950CXhOYfDicfebCFx0eG5CWHPgyo1rn-c8iS4dqCW2xVBQV8Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedtudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepsghmfihilhhlsehgohhogh
    hlvgdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghp
    thhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtth
    hopegrughrihgrnhdrrhgrthhiuhestgholhhlrggsohhrrgdrtghomhdprhgtphhtthho
    pehruggrmhgriihiohesghhoohhglhgvrdgtohhmpdhrtghpthhtohepshhtvggrughmoh
    hnsehgohhoghhlvgdrtghomhdprhgtphhtthhopegrrghrohhnsehstghhrhgrsgdrtgho
    mhdprhgtphhtthhopegvmhhilhihshhhrghffhgvrhesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:5j73aNlcag3HQBBA2yrL2yT1T3iTr20M5GJk6ZMmpWl44uPRKDMvAw>
    <xmx:5j73aOUUS1I5gYVPhaH_ArpASU0tupv9GciPUnvwfc3B90hgjvhFRw>
    <xmx:5j73aCt12IIWStRS7-tqLTFqTazqCyEbzVYw-2YDHsqF2NjxMZvtww>
    <xmx:5j73aB6Tq0aW_0aCOAv0d1KPo71uWQYerXD46juLyrhrIEQahu9mIQ>
    <xmx:6D73aF5yo7BMU7dgBCAx8UHPUTAbqJn2sho6bWYmhcSTqvbdWG__TkEA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 04:05:57 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6a378d7a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 21 Oct 2025 08:05:55 +0000 (UTC)
Date: Tue, 21 Oct 2025 10:05:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Aaron Schrab <aaron@schrab.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH v3 2/5] submodule: add gitdir path config override
Message-ID: <aPc-4FHCpHYgQ9hs@pks.im>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251006112518.3764240-1-adrian.ratiu@collabora.com>
 <20251006112518.3764240-3-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006112518.3764240-3-adrian.ratiu@collabora.com>

On Mon, Oct 06, 2025 at 02:25:15PM +0300, Adrian Ratiu wrote:
> diff --git a/submodule.c b/submodule.c
> index 35c55155f7..7a2d7cd592 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -2604,6 +2604,18 @@ void submodule_name_to_gitdir(struct strbuf *buf, struct repository *r,
>  	 * administrators can explicitly set. Nothing has been decided,
>  	 * so for now, just append the name at the end of the path.
>  	 */
> +	char *gitdir_path, *key;
> +
> +	/* Allow config override. */
> +	key = xstrfmt("submodule.%s.gitdirpath", submodule_name);
> +	if (!repo_config_get_string(r, key, &gitdir_path)) {
> +		strbuf_addstr(buf, gitdir_path);
> +		free(key);
> +		free(gitdir_path);
> +		return;
> +	}
> +	free(key);
> +
>  	repo_git_path_append(r, buf, "modules/");
>  	strbuf_addstr(buf, submodule_name);
>  }

You can use `repo_config_get_string_tmp()` to avoid having to manage the
`gitdir_path` lifetime.

> diff --git a/t/lib-verify-submodule-gitdir-path.sh b/t/lib-verify-submodule-gitdir-path.sh
> new file mode 100644
> index 0000000000..3a83f2d975
> --- /dev/null
> +++ b/t/lib-verify-submodule-gitdir-path.sh
> @@ -0,0 +1,20 @@
> +# Helper to verify if repo $1 contains a submodule named $2 with gitdir path $3
> +
> +# This does not check filesystem existence. That is done in submodule.c via the
> +# submodule_name_to_gitdir() API which this helper ends up calling. The gitdirs
> +# might or might not exist (e.g. when adding a new submodule), so this only
> +# checks the expected configuration path, which might be overridden by the user.
> +
> +verify_submodule_gitdir_path() {
> +	repo="$1" &&
> +	name="$2" &&
> +	path="$3" &&
> +	(
> +		cd "$repo" &&
> +		cat >expect <<-EOF &&
> +			$(git rev-parse --git-common-dir)/$path
> +		EOF

Style nit: we typically don't indent the heredoc body.

> +		git submodule--helper gitdir "$name" >actual &&
> +		test_cmp expect actual
> +	)
> +}
> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index fd3e7e355e..11c84a7bdf 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -13,6 +13,7 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>  export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>  
>  . ./test-lib.sh
> +. "$TEST_DIRECTORY"/lib-verify-submodule-gitdir-path.sh
>  
>  test_expect_success 'setup - enable local submodules' '
>  	git config --global protocol.file.allow always
> @@ -1505,4 +1506,12 @@ test_expect_success 'submodule add fails when name is reused' '
>  	)
>  '
>  
> +test_expect_success 'submodule helper gitdir config overrides' '
> +	verify_submodule_gitdir_path test-submodule child modules/child &&
> +	test_config -C test-submodule submodule.child.gitdirpath ".git/modules/custom-child" &&
> +	verify_submodule_gitdir_path test-submodule child modules/custom-child &&
> +	test_unconfig -C test-submodule submodule.child.gitdirpath &&
> +	verify_submodule_gitdir_path test-submodule child modules/child
> +'
> +
>  test_done

I feel like it's a bit curious that we recognize the configuration even
though "extensions.submodulePath" hasn't been introduced yet. I would
expect that we ignore the config key if that extension is not set, as
the extension otherwise seems to not be doing its job, does it?

Patrick

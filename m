Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6B972615
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 12:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757074488; cv=none; b=SPGI1X3u2Wrn8VMAs5IL7fyZhNCuYB1ihz83b3LenQ/JEzUdjD9YpFe2JhEBjHG8wSB97gsbAiVyiO5xVz02g266VZNRB85DeDbn1SIWRnDpZ6QaaiAGZUdgEoZhtLDs3qVC+lFNCvkdQzCEfnooInmw5vyXazqop8dye5myWXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757074488; c=relaxed/simple;
	bh=RQWGbYCwuIoxwH0bq0ye1aB7ygh/hOPh3xhBZMNBYR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EgnBZRG+rvAP3wuN8QAfZyMll/U+Uti0H7Y86XHYEgMlfUUuKIc9bLOJqL6XxRVXMOTdUp7g6vmdhOkrsKwZ0X9rnfwYGinGzVn8yD6k9eNOryRLx3+IHCquzojOfKQhMvKplJdi3/JRgfM8h9USDopg1AbrkEIKHcS5lI+J3Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=p4tb/WxG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PKMLp3nF; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="p4tb/WxG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PKMLp3nF"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 7C7E2EC016F;
	Fri,  5 Sep 2025 08:14:45 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 05 Sep 2025 08:14:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1757074485; x=1757160885; bh=HZh1d7u1oa
	+VoRK6dS5zPOgxYFbCWgLXNVQZqSuQSTU=; b=p4tb/WxGtHv9OKRKB40eqldT7M
	6VG3mjEZ6wZtAuTBFbCT/d4EDrs1aywLG6la8aKrkxZCZQv1uRw5agbGVPl8BfRW
	DKtlMXK6xss6CNnipey4A34mfKCwVPMnCD2BlHXDiydj7eXF9KaRgzfWNdAom9hF
	JvmYb1UBh98QpabaEEcHkbY7VdNxshXVI/U0v6AKw97F/vOkg3hSH1wC/Cat2K5/
	yQoYRVFFH0crBiZNNmsIrsb3i9yBfHSCXqj6GUc1sF4/Ytwh2c2IpT76cNZ2c/av
	kVS9P5ET0DmK2TGyRqxSerBrDnLMjKIDNYnyf8F7bfwDoFt49w+Kw/bXVuFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757074485; x=1757160885; bh=HZh1d7u1oa+VoRK6dS5zPOgxYFbCWgLXNVQ
	ZqSuQSTU=; b=PKMLp3nF8+U7A8dxAhisupYqYUmgyv/Av31XLSGsgSYmVHiLyjt
	NH4L6yiVfUBGpNjxqUHz7w8Cge028THk17Y67mgitDWHu9gTs4MoYvpl9TNdAt6c
	lwSLA12N4K8fBXxP6bVTmp9nPgrUhIOAuKNKGWJITjvOaaucyNsNAaWgzKJATMXf
	48Bd2jnwfF/gFhVTLFbvxdd4VpNbDPj50/GdCpbVO1yl5adGSsF70wg1aEotmAeo
	Lm8zbfwCZ+Y323QGwyYaPMfiVSC4dS3lzyjIi7BTC/wuuUvY9r6Mr5wr19ByPOVw
	2t6Z8JcJ2siTxoUb4NK9YMWerKNhXuKFe6Q==
X-ME-Sender: <xms:NNS6aE6H8oiCtqMQsduL6N4LZiDvpB3Rj0oop6U3pGzt7gmkW8RFXg>
    <xme:NNS6aGp_MfvZURd286ceVvUhbfHqj1FopBdcgu7tIWvl1VvLUEHnnZcLRbaTRj4Cc
    YSFQ_Q6LTRH-udVhw>
X-ME-Received: <xmr:NNS6aPmadF1lb3_MjpDJLEAp5IUsybWOZveXVR9jEOTC6bBsWu1TfIgSBYblZlO7416aHpQZ0H4Jb6ZLPudknfj-bncQJvEEMDh2Hdocj65q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepve
    ekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    hhhurghnghhsvghnfeeiheesghhmrghilhdrtghomhdprhgtphhtthhopehjohhhrghnnh
    gvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehphhhilhhlihhp
    rdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:NNS6aKModmew8K4jiTfdujMvt1qJltRySn8wvuZPVsqf2resZCprdA>
    <xmx:NNS6aLPD4wRl6UE2xfsEWFxeCfh6aofVlYK-k3x7BZW2OpgiA4TWJw>
    <xmx:NNS6aDgBFUXImQNO9ujzyEVxWW9go7g54jItTv6DhnGH5ZpRk3RjJQ>
    <xmx:NNS6aAtDWYcXIN0mlWz4k8lCX5052xDDLq6VUil3NZU--xq5dulfNw>
    <xmx:NdS6aLHLR2sslpupO21AwU7I94gLT3q5CBGRJbFHdClUVhkmIsO5N7du>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Sep 2025 08:14:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ffaee22f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 5 Sep 2025 12:14:42 +0000 (UTC)
Date: Fri, 5 Sep 2025 14:14:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Wing Huang <huangsen365@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 3/4] t9902: switch default branch name to main
Message-ID: <aLrULt3p_sHvj8r0@pks.im>
References: <cover.1756308283.git.phillip.wood@dunelm.org.uk>
 <cover.1756992089.git.phillip.wood@dunelm.org.uk>
 <f1bf01e13226cf3f6ca0e811123278248e4eea6d.1756992089.git.phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1bf01e13226cf3f6ca0e811123278248e4eea6d.1756992089.git.phillip.wood@dunelm.org.uk>

On Thu, Sep 04, 2025 at 02:21:31PM +0100, Phillip Wood wrote:
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index 6650d33fba6..964e1f15693 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -11,9 +11,9 @@ test_description='test bash completion'
>  # untraceable with such ancient Bash versions.
>  test_untraceable=UnfortunatelyYes
>  
> -# Override environment and always use master for the default initial branch
> +# Override environment and always use main for the default initial branch
>  # name for these tests, so that rev completion candidates are as expected.
> -GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>  export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>  
>  . ./lib-bash.sh
> @@ -1453,7 +1453,7 @@ test_expect_success 'git bisect - start subcommand arguments before double-dash
>  		HEAD Z
>  		final Z
>  		initial Z
> -		master Z
> +		main Z
>  		EOF
>  	)
>  '

Hm. Wouldn't it be preferable to do something like the below patch
instead? We would potentially also have to sort the output, but like
this we don't care about the initial branch name at all.

Patrick

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 6650d33fba..321005a06a 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -11,11 +11,6 @@ test_description='test bash completion'
 # untraceable with such ancient Bash versions.
 test_untraceable=UnfortunatelyYes
 
-# Override environment and always use master for the default initial branch
-# name for these tests, so that rev completion candidates are as expected.
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
-export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
-
 . ./lib-bash.sh
 
 complete ()
@@ -1449,11 +1444,11 @@ test_expect_success 'setup for git-bisect tests requiring a repo' '
 test_expect_success 'git bisect - start subcommand arguments before double-dash are completed as revs' '
 	(
 		cd git-bisect &&
-		test_completion "git bisect start " <<-\EOF
+		test_completion "git bisect start " <<-EOF
 		HEAD Z
 		final Z
 		initial Z
-		master Z
+		$(git branch --show-current) Z
 		EOF
 	)
 '

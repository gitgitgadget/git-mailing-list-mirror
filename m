Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8883D1E378C
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 07:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742455316; cv=none; b=ffgYpHN6ZlkTQ7ui2o/1A1fPKaPA3ZOAdcYY6+4/TdX2RMyQKNyXu95kQFMm2/U/nhk7WkkNRrzK/75A/WuUIodtqv4tr+lG1Uyj/F2J5Omg6PZz2T+8zaZoZdc/qvR1cs4V5AMLtGgydZyt6VEk5akI/carEGh//c1YDl2D900=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742455316; c=relaxed/simple;
	bh=Tik8Jo3KFHmDFfpYrJgCBhbX8kObZOydQk3Y+6mv8fY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QnkbVXJDdUDdGhxCrcc4u1+nz2ixqpUWRHwePIpC18ERE3rkLsD76OQYxwB7MLYRLJyXtEsViCgq2elGuSX4/YX3u/m+4HYYaP+aNEOOc8BqRWYcpjmpJ5ZrZuxKTdMQJgVr9whjPua3qCANH/gTToDphw9XpTGX5ySiZvTTPlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=o3K9ibA0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sk366qok; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="o3K9ibA0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sk366qok"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3C222254010D;
	Thu, 20 Mar 2025 03:21:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 20 Mar 2025 03:21:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1742455312; x=1742541712; bh=FHxrRm6hct
	o8t5WiaMsXng9jv5YEkD/EzmH11yl4cyQ=; b=o3K9ibA0GK3lAKT82oyE8/Sx+I
	HT4kJba1ccwPS0oiCbfIhICofUX+UWcBUHhWb3hwRm2iP7n1OzJHkg2HnKb5LS+E
	aWH6qYeIbzNQB223+dHpo4gZQZ8MGbIIUbd2ylo2/WmeE/hK7uX7o+gjmXI6dBZA
	jXpnD04DYxuxB9QmlxGvAq4/SfpiZRzFGhj2aAnME4h5qQFYjNI2sYhBenD1Oh74
	+yqIeu71RHsOyKG1KxCtx7lP/MipwNq87DqyykJMIRw3qEVh39qOS8RHlDCD7yWs
	aonXQ9p7TARMXHU01HS5DcLsqfEOXu9kfEo5jJRNZw8SciohfyA4F32hrFRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742455312; x=1742541712; bh=FHxrRm6hcto8t5WiaMsXng9jv5YEkD/EzmH
	11yl4cyQ=; b=sk366qokqw8K0K9XiDikvcZfWYBOwUkxot9VS0AraMFpLj21zt5
	UYgKz2PsIh7FDApMdJWvypUM5jAYbDTGuC9VGaPmE8THQplH5ydXUIYZhZgjw4Ly
	iXSjBit7ICWg7yOwJvMb53TFmca66vtUEAR6qRbGz298vSX9O5iuQrXL3rA3MaVl
	PGXVnEg0yyU8wFZl4/hx6YUR8BhUonDsmFw0ZwO3wE23nYGfLti8Zd2LbtozsBPm
	7Mnf+VjnOxv3J4zvb8lg29nXWBqL1U//TkhMgmAJJhIt8GfpmoelvuMb6R/K38IH
	vYZMGPtFgZYuCyLKDc9rXVcqA1Zo5tdHqhg==
X-ME-Sender: <xms:D8LbZyuimm_R2azvewMg4EZxxZzsXe1YWwH2mEQlHsJ1jxFsstkPuw>
    <xme:D8LbZ3fKI4RRoV-0rmUJd7JhpoHvMHKKXUMKBR7hky3QeopeI8U7aDYK8QZpNtFKS
    zGF6MnYwIYdlvWbwQ>
X-ME-Received: <xmr:D8LbZ9x2ODoE663gpLbun5xE-G9TWtoBRYD3Zm2M6dxoWql_Um4q_jrLk8MB9oSADFjukgOzYzEv5GOg4ujSM6Hur5U62ejw-qQyists8_MsyA8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeejheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepledpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmh
    grihhlrdgtohhmpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidr
    ohhrghdprhgtphhtthhopehushhmrghnrghkihhnhigvmhhivddtvdesghhmrghilhdrtg
    homhdprhgtphhtthhopehjohhhnhgtrghikeeisehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlih
    hprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhvghjihgrlhhu
    ohesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:EMLbZ9OvhyQtYPqKCigrzYwPUiU3seu_O-cCP0WA6inbHXSbRcHVew>
    <xmx:EMLbZy8zhcKkv3nsaj2DYBUdEykAAUv7eY3ofACgdA1PhS76rWWoHw>
    <xmx:EMLbZ1Wh7fAZuCfCl0SA6mpLHjCxxsk-wVLlXke30ZD3XTXkjXwL-g>
    <xmx:EMLbZ7egGffNcbeRB1nyfX_MC6cK5p6EQ35bi2Qzbr4rdVhm2j-jcg>
    <xmx:EMLbZ1ZrhD5BIGC8dgMcCzzFD6TiiMJ-RG-ZodZzRCiSKjIGEO8RNY4W>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Mar 2025 03:21:50 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e225fb49 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Mar 2025 07:21:49 +0000 (UTC)
Date: Thu, 20 Mar 2025 08:21:48 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
	johncai86@gmail.com, me@ttaylorr.com, phillip.wood123@gmail.com,
	shejialuo@gmail.com, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/9] builtin/verify-tag: stop using `the_repository`
Message-ID: <Z9vCDFRUG7IzU_AG@pks.im>
References: <20250318115912.2978992-1-usmanakinyemi202@gmail.com>
 <20250318115912.2978992-3-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318115912.2978992-3-usmanakinyemi202@gmail.com>

On Tue, Mar 18, 2025 at 05:28:54PM +0530, Usman Akinyemi wrote:
> diff --git a/t/t7030-verify-tag.sh b/t/t7030-verify-tag.sh
> index 6f526c37c2..2c147072c1 100755
> --- a/t/t7030-verify-tag.sh
> +++ b/t/t7030-verify-tag.sh
> @@ -7,6 +7,13 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>  . ./test-lib.sh
>  . "$TEST_DIRECTORY/lib-gpg.sh"
>  
> +test_expect_success GPG 'verify-tag does not crash with -h' '
> +	test_expect_code 129 git verify-tag -h >usage &&
> +	test_grep "[Uu]sage: git verify-tag " usage &&
> +	test_expect_code 129 nongit git verify-tag -h >usage &&
> +	test_grep "[Uu]sage: git verify-tag " usage
> +'
> +
>  test_expect_success GPG 'create signed tags' '
>  	echo 1 >file && git add file &&
>  	test_tick && git commit -m initial &&

We have "t1517-outside-repo.sh". Maybe it would preferable to add tests
like these to that test suite instead?

Patrick

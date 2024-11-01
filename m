Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D8617C8D
	for <git@vger.kernel.org>; Fri,  1 Nov 2024 00:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730421266; cv=none; b=gUFuL3zEqt+iSCFCwk2MRfxY0nTBycKpOUnK89UAM2tP8kb6Vqh3+dvA4wlJXUaregZzRbTy9+BNcUpUh54DFOya1J/O7fad7Wb/rRABVmyHO2slAB/9BNdPtIrPn3uvH/w1cllyNF1VRnfOneeqe7r8bW/B1zQrslEHp/E2SGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730421266; c=relaxed/simple;
	bh=0XdFKNZo4z67IpvTqf4nGExxmFT3XBgLAHF73vKV2OY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Zj7/Q5Jo5ka9I808oT2mFP5GG3FOiebWtFpRdAy+eBPVj+Y9lD3bG00TMAOCCI5PLNneaqFBDtJL9bLwjpg+p+/7dVQ51w7o4lTdyIOakzAOfOhdInDWMyj8PkPEpITDqYNiJ92+yp2UBYvucT4hmE1ox0jrIAMPvcvXkHBwcBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=f0K4JRD1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T3/nuumk; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="f0K4JRD1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T3/nuumk"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 440D02540160;
	Thu, 31 Oct 2024 20:34:17 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 31 Oct 2024 20:34:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1730421257; x=1730507657; bh=mVEgOasqxy
	RNUqpDM0+MUMLWaMaaqha30ZR97XoaJa4=; b=f0K4JRD1JY3AzSZmnn9C+Uhe+0
	SDoHub4ppLbebj5x0xo/1l2J7+i7KSlS5Jkb4D8ajd8W371DMungrh5rbImSX0mn
	in3hsSlBkoZI/UOvb3qX6eQosPvCXWKHNC/Hu6GZg6YwLGX2AAX7UtFXHVaVSB+k
	EYvD9kupUL54/UPTW/4k/ysNSOizu6LWb4ypX4ZtkNvhXyiK6rTpQ6LPzvh7KDtE
	a+OhRehwHk8EkzPNJs6iNQCA5XXNaEmoZxXcsz42XhWpn8vexrX/0ZQ/bn9/+n8t
	bMDvhzDgWNH7maRRZp1KLdflC5rkCYtfNcx7fmKLdHk9WEMnDaMxxxSnSe5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730421257; x=1730507657; bh=mVEgOasqxyRNUqpDM0+MUMLWaMaaqha30ZR
	97XoaJa4=; b=T3/nuumk3Ubrcljku6iJ3/5+qSnSjmo8K7rJr3Nn6Bv9fF0Go1B
	1E+YjLaAWZvR7fsMYRrUH6ukmtQ9P9NZUGot87SYSz6aPpqda48AOf9r82Z6wmbw
	Vz/9X4U/prDcZgOuX0L0AwpqTTQxA3pYMyNjWLxUzLD6cCYYxPiPgFBgXv78REp8
	y2SjquBcnJkgPL5RtbMa1/wEt3RPOXwovphuCnEMn0If4/GtcUOfS1yM8CGNaWKC
	eTmjb2m9PXBk9pgqwqS4+5fsvKxw5QwOo5JatpqHq7TcylfEthlD7Pe1q0PqyNAa
	1JXOAbOcwVRnoWH3roDIIKjdTnsexa6H/Zg==
X-ME-Sender: <xms:CCIkZwKLEp5znBLhGAhj-i_cyvIuz53jDSTsPsaoC1i3kyggq6T2cQ>
    <xme:CCIkZwIYlyBZOluWUMxPPDrB4YIdwOT7KwZop6YvkHfrEmv_aojM1Jyn67mcj6AUY
    yhledtSVpZ_csxEPg>
X-ME-Received: <xmr:CCIkZwtdH3V_a_6s8v9h64889-daTKdczl5VOlM9A_ZpxYII85CGFYHVCEh1eww8ouC5W448b6pXku270i2D6fWadZARIv1uv-qM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekkedgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlshestg
    hruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpd
    hrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:CCIkZ9br-aCeFrkdKhA-tAPOryiL23-4MPZ88IwbWqZMNUY6XF7eyg>
    <xmx:CCIkZ3Zy101LGyCB3aZcAvR-7ZZeGAzo1tnnhG0F7djkJSXBSyABXw>
    <xmx:CCIkZ5BcQA9E2h56z6XXIIpexk72xMXwFdpPB8wtENbFYSah0_witA>
    <xmx:CCIkZ9Za7vj1ugDDgz8mgvr5vsCfyHC97VUpx5bUSX1w8CN0fy-vqw>
    <xmx:CSIkZyx12z9oh853rfXK5NnctZSnJ5mBgm6vLEWA2iHayPqgFhRkk8dV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Oct 2024 20:34:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Taylor Blau <me@ttaylorr.com>,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH 2/3] ci: remove clause for Ubuntu 16.04
In-Reply-To: <20241031234934.3451390-3-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Thu, 31 Oct 2024 23:49:33 +0000")
References: <20241031234934.3451390-1-sandals@crustytoothpaste.net>
	<20241031234934.3451390-3-sandals@crustytoothpaste.net>
Date: Thu, 31 Oct 2024 17:34:14 -0700
Message-ID: <xmqqv7x74ws9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> We're no longer testing this version and it's well beyond regular LTS
> support now, so remove the stanza for it from the case statement in our
> CI code.

Something like "we replaced it with 20.04 which does not need the
corresponding special casing" would be necessary to explain why this
is a good change, as opposed to an equally plausible-looking patch
that replaces 16.04 with 20.04 and otherwise keeps the "stanza".

> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  ci/install-dependencies.sh | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> index 126e570eb4..d30ae53a18 100755
> --- a/ci/install-dependencies.sh
> +++ b/ci/install-dependencies.sh
> @@ -55,11 +55,6 @@ ubuntu-*|ubuntu32-*)
>  		${CC_PACKAGE:-${CC:-gcc}} $PYTHON_PACKAGE
>  
>  	case "$distro" in
> -	ubuntu-16.04)
> -		# Does not support JGit, but we also don't really care about
> -		# the others. We rather care whether Git still compiles and
> -		# runs fine overall.
> -		;;
>  	ubuntu-*)
>  		mkdir --parents "$CUSTOM_PATH"
>  

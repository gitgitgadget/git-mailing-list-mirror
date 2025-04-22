Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D506B1EBFFC
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 07:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745307103; cv=none; b=QU80ST4SJOCe9GQRTAyc/N/naQkvC2mL2r+4d6NOcOaY2kkfLUc7AEx9pMkSUaGBcMSftlztWm9LVne5lTjVKkYVNJh1ZUHcyzK/6Sj3Ay1eqVAt16sU53u/jysmyqhDZTMg/g7Ytcf4OTOODO/cPupOC7vd24NaCpyPOMH3xHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745307103; c=relaxed/simple;
	bh=/f2ixQXqZFHDZwE8wctOS+KUEis16dlQjlKwrNyyz3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A09vOKz1uRvTJ2g3wuFmXpVLCCanX/CKbotSrndoe/V74fGJIlatmxOTQKY5dP5G8F2lW/2jtApNwqXRPQbWhQ1x2SYp+AwZdbkcNqFPWtdE4OE1RKNHCUtEVI8Yt8ylvhS66FAkZDQBaJDrByAdBT9zU49EdI2TUyRg7YsnkN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=I0nrUJOy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s8J9Sn1y; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="I0nrUJOy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s8J9Sn1y"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DA3E625401BD;
	Tue, 22 Apr 2025 03:31:40 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 22 Apr 2025 03:31:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745307100; x=1745393500; bh=bybEmJ12vk
	M2ATOXtrLTyH02zzkYb0DCZUf/Kacageg=; b=I0nrUJOy9U0oXTBd6lUDS1oJOn
	jU6INteXLwrUsi+HDiY82fQrb1VcOwPoG71TjQQ+junhKh2mRtwFmdDfi9HgKTGD
	Bwhb7Z25ofjCakaDeN1DyC02K9VQmQt0I6vMaFN1xso760w7Kpauyo9LGGA61neB
	PofzzkZjz33mLEyKpQP0f73ueMYUFW3YB37Wr79XEHsOp9e1n0qKgeZ0tUzk3J+z
	evSt95HS6PkGAtCM1/zjeO+upHS+pyIki4DHdkKlvATkaPEV0JamnbcoOgqYNURW
	/dTX+4itAhhL30gUEeUAOvsDKhbsG0WCdi4c5XNLeg+UkXcKdmcvKEIS2fpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745307100; x=1745393500; bh=bybEmJ12vkM2ATOXtrLTyH02zzkYb0DCZUf
	/Kacageg=; b=s8J9Sn1yttSkdCK4IEYzj8bBOnvc+3mCs4U+VRVV2+sSHCTnoQs
	rdgt5SVlfsj9cwsMwjizaOb52V17OTBPxn1xyAxvp6kKZ55kSy5kNnk+8DHqwpAM
	zT8vtscikzZhytJDPol3vIzHLGTZmEM2GuKB7A9F9VrTVu/BJGUobkEUF5fcsb6b
	YHX2ScZ6co8tHYGp1Ga7xk6mXvy4q1sxV0kJa59NZC0aA789bJHi/BkwjBOEZMlV
	aI7UyfpkdhY/nUwAgwcNBagylCyFlApu2WsBt9IyXF03IZKE2eHSOtBURyQ9hQfe
	7i5oKUveqxOoJkzuH82aXKuCN2c8lN201rQ==
X-ME-Sender: <xms:3EUHaCzA1ZhlxTq-NFtgHouGsW17qnPyL6p_q2bQ7B5EQOPaqHFv1A>
    <xme:3EUHaOR2MLZuwyAWLirg4dzcdrke6nagdLVSrQxQ1OcN86yau1zh7bVa-FSxqFohu
    Evex2_0j0rJmJRXJA>
X-ME-Received: <xmr:3EUHaEXPA2d3-9PHCYWhw5jdgRqsVyI39jODTS7BvvZuQZW8SXyUaD9THwDecUgsaNR_uUIyZab44n1hu3vNc_F_YmgBm85Fpm6nfgplkqk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeefudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepshgrmhesghgvnhhtohhordhorhhgpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvshgthhif
    rghrthiisehgvghnthhoohdrohhrgh
X-ME-Proxy: <xmx:3EUHaIiqVncHaOzch-JwXWFSMlGogj3zV4mfRLC2oQRzo1RD3nhF1g>
    <xmx:3EUHaECQwA61XJwjxX4MZvboy-MMBqFZv-pDDXVsm8zhOYkKGu_tew>
    <xmx:3EUHaJKHfUX0cn4uSKgTht5-QUewkHQnJZkvJrre_oebU4OgQlN7Bw>
    <xmx:3EUHaLB2dWdPFjl4fBit-LyLiX6BETge4TshsQvS73woDbOIehnLgQ>
    <xmx:3EUHaE0XNu6NL-ppLgsAltI6wf_lufzDByI8-Fjxomik7OCC3rpCeNky>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Apr 2025 03:31:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fa6c1118 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 22 Apr 2025 07:31:39 +0000 (UTC)
Date: Tue, 22 Apr 2025 09:31:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eli Schwartz <eschwartz@gentoo.org>
Cc: git@vger.kernel.org, Sam James <sam@gentoo.org>
Subject: Re: [PATCH 5/6] meson: fix typo in function check that prevented
 checking for hstrerror
Message-ID: <aAdF2tBnLihgx8zX@pks.im>
References: <20250421175247.240971-1-eschwartz@gentoo.org>
 <20250421175247.240971-5-eschwartz@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250421175247.240971-5-eschwartz@gentoo.org>

On Mon, Apr 21, 2025 at 01:51:49PM -0400, Eli Schwartz wrote:
> Nowhere in the codebase do we otherwise check for strerror. Nowhere in
> the codebase do we make use of -DNO_STRERROR. `strerror` is not a
> networking function at all.
> 
> We do utilize `hstrerror` though, which is a networking function we
> should have been checking here.
> 
> Signed-off-by: Eli Schwartz <eschwartz@gentoo.org>
> ---
>  meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/meson.build b/meson.build
> index 8fad10379a..1b7e55756b 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1088,7 +1088,7 @@ else
>  endif
>  libgit_dependencies += networking_dependencies
>  
> -foreach symbol : ['inet_ntop', 'inet_pton', 'strerror']
> +foreach symbol : ['inet_ntop', 'inet_pton', 'hstrerror']
>    if not compiler.has_function(symbol, dependencies: networking_dependencies)
>      libgit_c_args += '-DNO_' + symbol.to_upper()
>    endif

Good catch and obviously correct, thanks!

Patrick

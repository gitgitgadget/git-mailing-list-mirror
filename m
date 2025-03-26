Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64078192D9D
	for <git@vger.kernel.org>; Wed, 26 Mar 2025 08:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742977745; cv=none; b=QoFhpBltnVzM6GEma+z9XsFTPT/Hyr1OYjX3wXRHNg54IdGMLW5ES3aUFxjG29JWB0fPP3s9BPNrrYM8StGQSf5xKYG/mrTvbeAtbOP2ADvmcSJig0inkhRjcF0OA5X8NTkG00TO4fPt1jsL24GuMFyQmthMT6wegwABVj6dfD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742977745; c=relaxed/simple;
	bh=4L7IWKFxEXTSps5p7lrUoLxHfBLQIgIgT6EkmUnelvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NuIuJFLDkql+kRuOyEYVAjDFilKPUrquDUKebZq4puOdLagBTbCEQqztneLVFgW8KNx8WG2D66FBdungSViCKfSpgFaVCfwapTxl0b9XfpV947H6p/FGS5MRIK/eh906QtLl0dS4EcgQMtqAIAo1X7/VBJLnX2PCXD8M3cxU9XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pnVrpcmh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Nxr70pJR; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pnVrpcmh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nxr70pJR"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6318111401D2;
	Wed, 26 Mar 2025 04:29:02 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 26 Mar 2025 04:29:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1742977742; x=1743064142; bh=31etg3+6Aa
	1l+sYXGj2r2Ub20Zi8rdscL6sT59Xs34Q=; b=pnVrpcmhOK9Vd4IWEB3o9zJMUM
	lne7jHULyiZRE/6ciaGI5jLFGj2lx3iOFU1Ri6Kmf6piYrukfxTWIvRfgSFhHc8w
	GpoMr3Dxbn+HxTRc8kSGBnZFk7Q9uxciOBwn+taDJoHZmqFN83bpvzpblZ7njP5z
	xqvmyMkWou+bXVu2YZnJPVu4GXoX7JDZNpkZdshLNSROjJrsfQJQVOMEyveWmuO2
	CCMFtyWMDbJZh0QTF4/skGw1MGYo/AiRyQuzHCJp6EVWW88wxLnem6Dytw/bjT5P
	SX5jy+j+scFKtBfFGwxOfehGRTLHWfh5c0CbWJMrwIIyiBprwLFecJlaNTmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1742977742; x=1743064142; bh=31etg3+6Aa1l+sYXGj2r2Ub20Zi8rdscL6s
	T59Xs34Q=; b=Nxr70pJRW9vXYlks97YY9uM0Nb3G5sZO4vExP3Ncscv8KHRW3jC
	sULX16eHgFHE+H+8WhYXhWCZpq3we6YMvYZBjonayFlEIgjXEQ9NLIvtezFHzEbM
	yS+8x+XLCcFjskDZLhjJ6bQJRhhj1wR70/FJEfJq6mTXdDPYAoRA9AFaxlWTF1Ns
	5RtI9NiRxtyWhhNXsPRZOWZVJn7UvDK9Ykv2vdeKS8nhAL0ufbUW4nHg3sxIMenC
	b0KgCODe0sw2lnGh889JWAZoyBIWk3lI0vFeQptoPL/N/jWJCiluoTq6A+BAocLJ
	utg9qy9i4LFL6D+GXFb/4cfze2pk6r5lm8g==
X-ME-Sender: <xms:zrrjZwej5XAZGl4Ui403cMWXiqqUSs9ozsqYyuTWlSZdP9C1jCHdmA>
    <xme:zrrjZyPQqAYCD_SJk1F7SoafPDWqmQN7nHD-9KfoA-GIOFP00LJXWF6Rwzy3RDtqf
    _QOOMred3-LFxmmmA>
X-ME-Received: <xmr:zrrjZxhphLI83nYx-Jy6N2I60NtDtnZp_o9TJu8qJybbL0gQirn3ieZX86rISQLl7bm3iIYFPTmZQn-siI-B0vdovatGSQWFt8SABvhJHIjv0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieehtdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepshgrmhesghgvnhhtohhordhorhhgpdhrtghpth
    htohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:zrrjZ1-7z-97PGLOL_NUVkMHSAcdm01CDIQA0uojUn56G9O9dlScHA>
    <xmx:zrrjZ8vloRd8yhZWRRS9c-NoHlgejCR82P5hC7Q9REDKaTHUzGMlQw>
    <xmx:zrrjZ8HVbea0xV9BndA9lahPCyvsqSRs7SSJPmhQwH-8-TPQjHa0hQ>
    <xmx:zrrjZ7P6WKkFTK-ExQ7wFGiI1emk7NLOZ_JP7kF1JaMaXBECXJ9LXw>
    <xmx:zrrjZ4LSeJWaapay8D1Y-wmRTtMZoaJOTWgwI_bBvInmu1oCjIKmKR4Y>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Mar 2025 04:29:01 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 08758931 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 26 Mar 2025 08:28:59 +0000 (UTC)
Date: Wed, 26 Mar 2025 09:28:54 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Eli Schwartz <eschwartz@gentoo.org>
Cc: git@vger.kernel.org, Sam James <sam@gentoo.org>
Subject: Re: [PATCH v2] meson: disable coccinelle configuration when building
 from a tarball
Message-ID: <Z-O6xqjGmASjTZ9U@pks.im>
References: <20250325200542.197687-1-eschwartz@gentoo.org>
 <20250325200920.198057-1-eschwartz@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325200920.198057-1-eschwartz@gentoo.org>

On Tue, Mar 25, 2025 at 04:08:48PM -0400, Eli Schwartz wrote:
> Wiring up coccinelle in the build, depends on running git commands to
> get the list of files to operate on. Reasonable, for a feature mainly
> used by people developing on git. If building git itself from a tarball
> distribution of git's own source code, one likely does not need to run
> coccinelle.
> 
> But running those git commands failed, and caused the build to error
> out, if `spatch` was installed -- because the build assumed that its
> presence indicated a desire to use it on this source tree. Instead, we
> can expand the conditional to check for both `spatch` and the `.git`
> file or directory.
> 
> Meson's `opt.require()` method allows us to add a prerequisite for the
> feature option. If the prerequisite fails, then the option either:
> 
> - converts autodetection to disabled
> 
> - emits an informative error if the feature was set to enabled:
>   ```
>   ERROR: Feature coccinelle cannot be enabled: coccinelle can only be run from a git checkout
>   ```

Makes sense.

> Signed-off-by: Eli Schwartz <eschwartz@gentoo.org>
> ---
> 
> v2: accidentally chopped off part of the commit message, sorry...
> 
>  contrib/coccinelle/meson.build | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/contrib/coccinelle/meson.build b/contrib/coccinelle/meson.build
> index 5d76a7fee6..ea054c924f 100644
> --- a/contrib/coccinelle/meson.build
> +++ b/contrib/coccinelle/meson.build
> @@ -1,4 +1,9 @@
> -spatch = find_program('spatch', required: get_option('coccinelle'))
> +coccinelle_opt = get_option('coccinelle').require(
> +  fs.exists(meson.project_source_root() / '.git'),
> +  error_message: 'coccinelle can only be run from a git checkout',
> +)
> +
> +spatch = find_program('spatch', required: coccinelle_opt)
>  if not spatch.found()
>    subdir_done()
>  endif
> 
> base-commit: c1d6628c9433c09ff62f916f2b933ee12995e9d8

Yup, makes sense, as well.

Thank you for the patch, looks good!

Patrick

Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6EA18D
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 07:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737963588; cv=none; b=VXn6KiCUNHsReWx0ucD6NHhU5yGq7F8f6/yujzIEEBGSgTgrQKBrS7FAnS2aq9+kWuYsibNkl/RoaCn2jwXqWgjlPzGO8PkQknwMZY5opAeIRvoBK+iSxERIuY+Kuup1etlQr16dUJLMnRlV9AU7yuau/nvtRsNL92lF+R9lNWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737963588; c=relaxed/simple;
	bh=WMew3E8JoH0gfnPTo8yUisTrmFnGDb5F9avI/8Aparo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qRjdYpf36YXZ/hePBPkHjbWw3zEtbTZL1Nq8JRxdCiAXtS9iMCel6+HxddjLhw7DbAcd/znQtnrusfYgzs4lhhec1pRLU3YTvfv16UOYbz3vVo20rCuqOzaLqlGQ4UhAf1jhnrTQhRw5M3NlSy+fPpaYMLOQDbe/zFQvPLVYtnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RyIZ0Ax8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u4/+JgjG; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RyIZ0Ax8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u4/+JgjG"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id AAAD8114013A;
	Mon, 27 Jan 2025 02:39:44 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 27 Jan 2025 02:39:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1737963584; x=1738049984; bh=9AMNnN9kIG
	VhJT4G0uS4+C4kWxEIQF3aLppAyZ455pw=; b=RyIZ0Ax8y+bIixepJw/P4dKlAz
	NsTMrhOUINSSaePnpn6w/glFpOnhWjyvfNRnrLhlAqtOoy9TXjK1c2M6kAatpCmo
	SQ/RRG8DXlQQPh9a1gzA9tJ3eNmcxA7CCbu7Owvr8nnj6ZS5yqZGGrcpqnTvKxZJ
	+Rm0k+4YZhTqY60eQhtFdzvAH/FyId34RaABhY5O2RnTIFWy5yuXKi5mekdGmUxF
	flSeqTj1MyUIQtcGCrT6kgGQLYj6d8GPRlJRSSMf8Q6uG2bNtIiBuzXIzo5wnjR2
	GTX7h/oStG9QiVdor/SaRj68BM2on1ek0idQWT3Nv112BEqWo7liJBPox/iQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737963584; x=1738049984; bh=9AMNnN9kIGVhJT4G0uS4+C4kWxEIQF3aLpp
	AyZ455pw=; b=u4/+JgjGM2atCSLeH+mlIIUz2MJzfMbcOneMxSHwCIMTdT4ffsX
	t/6mGssiXsEbgVjIUCBqzKtK9yDZc4F+BBh6E5sydeaCsv/N/AxitZ5EmpMZxWXm
	K+WN++uQTzi8SEiP40HqYiNpId7BGE9VCAnsQprAyeZtN9eCepg/NeKjjBSra3K5
	BWGQ8zkwR1dYTuvKYdye2tMqpLN55gidFrV6prxTiKKDaNAmmyP0WpN95GxeOnWw
	GYHfQpseWTqLpZMrZIhqVj1X13GNzDWzAv0deEoUZijuG2un/tJuS2fraBRSPWHZ
	8PvC1ftcZcX9zLkDJPScNs91rRvpSZPre7Q==
X-ME-Sender: <xms:QDiXZzdqWgY2x-11DoePPaIQvENfOkV2t3j1vI9-F18xG9BFNM01JQ>
    <xme:QDiXZ5O_ltQ1Ia46T_ba9l73eTHsLbwp-sb1DZmjVQTN0jB_Yq13a2KCKHT7JoOlw
    8rjt0Vc4Kk9FOblKA>
X-ME-Received: <xmr:QDiXZ8j7MQEuvliXRzV_cEiJq8IZMmtNgJRa6DznQUdI5GL9Ikf3to8sYYuyfDD6TqLpZRXknqnYe7KCJxb6P4S-KmPgXuGm3zBs_ZYSt3w->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedguddvheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepphdrugdrohhlihhvvghrsehmrghvihhtrdhorh
    hgrdhukhdprhgtphhtthhopehgihhtsehmrghvihhtrdhorhhgrdhukhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:QDiXZ09QwTvRbYn4kY61XqBDgcEJDwxJfL8niiUJhB_REHrryIglSA>
    <xmx:QDiXZ_vvjeaqDfju7w6qv1HI78QK3OpxT3NHw3gRFlkXjnwu9Tax1g>
    <xmx:QDiXZzFMVRaHROilTQk9jQuerb0_qhuIoPGfoAifsxd6KnPx45nHsw>
    <xmx:QDiXZ2MIj1IzGAE6rXWXgz8BXzMia7nyUN4jylavxRYyvk7N_Y9Ksw>
    <xmx:QDiXZ_KmDjM2quvKWoJcgISG8kZuVbOz1yE2wyKT6orqCmbB6rltRpta>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jan 2025 02:39:43 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9fc671ee (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 27 Jan 2025 07:39:41 +0000 (UTC)
Date: Mon, 27 Jan 2025 08:39:39 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Peter Oliver <p.d.oliver@mavit.org.uk>
Cc: git@vger.kernel.org, Peter Oliver <git@mavit.org.uk>
Subject: Re: [PATCH v2 2/2] meson: fix Perl version check for Meson versions
 before 1.7.0
Message-ID: <Z5c4OzzHWOo30Hu6@pks.im>
References: <20250120160301.121245-1-git@mavit.org.uk>
 <20250124163049.23965-1-git@mavit.org.uk>
 <20250124163049.23965-3-git@mavit.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124163049.23965-3-git@mavit.org.uk>

On Fri, Jan 24, 2025 at 04:30:49PM +0000, Peter Oliver wrote:
> diff --git a/meson.build b/meson.build
> index f01d81b39f..80af578d36 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -755,7 +755,11 @@ endif
>  
>  # Note that we only set NO_PERL if the Perl features were disabled by the user.
>  # It may not be set when we have found Perl, but only use it to run tests.
> -perl = find_program('perl', version: '>=5.26.0', dirs: program_path, required: perl_required)
> +if meson.version().version_compare('>=1.5.0')
> +  perl = find_program('perl', dirs: program_path, required: perl_required, version: '>=5.26.0', version_argument: '-V:version')
> +else
> +  perl = find_program('perl', dirs: program_path, required: perl_required, version: '>=26')

I'm still a bit sceptical whether we should adapt this second line to
match against `>=26`. I guess as long as it doesn't break anything out
there it's okayish, and if we do see breakage we can in the worst case
revert it.

In any case, it deserves a comment why we're matching against the minor
version and not the whole version. E.g. something like this:

    # Executing `perl --version` results in a string similar to the
    # following output:
    #
    #     This is perl 5, version 40, subversion 0 (v5.40.0) built for x86_64-linux-thread-multi
    #
    # Meson picks up the "40" as version number instead of using "v5.40.0"
    # due to the regular expression it uses. This got fixed in Meson 1.7.0,
    # but meanwhile we have to either use `-V:version` instead of `--version`,
    # which we can do starting with Meson 1.5.0 and newer, or we have to
    # match against the minor version.

Thanks!

Patrick

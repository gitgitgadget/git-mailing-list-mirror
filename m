Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616D477111
	for <git@vger.kernel.org>; Thu, 24 Apr 2025 23:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745538502; cv=none; b=V2wQ3OXreYyIg88FbzPfzzlUByOaVbJ78BI6cStRT79sFhhZUWwDFiDbJlDQtuBPS1ZCyGTBU/q4GUhMlII8AM+/c+ulqrhSUUfpsUUqqUJUmD13cO1c1VPX5MagRbKpy42kDR3qvQqs8Uf6XLVsnk4F9QqSwQjUOvo2j64CDyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745538502; c=relaxed/simple;
	bh=AeoVjTTNca0JBXhFtpPLVGaxnmITRViiV0Kkgrhd2JY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t8YHuRIiyAJZxQd3+KvY/gAh7jlPZfDe33K6aoJ7ZcckypVWvQy6YN107trkT7Cd1z5S5KPouh/5DHwaVznQrlEjyS9oDfONnRoI4zUEcYIhbahyrB1PbXsmfk8sWKxgb4erSZ5tQOdw6vvlQh/4E9x0kenu3utzNkLgG8QzvEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RfdA9ylP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ipy+pa6z; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RfdA9ylP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ipy+pa6z"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 5AE5013801CA;
	Thu, 24 Apr 2025 19:48:19 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Thu, 24 Apr 2025 19:48:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745538499; x=1745624899; bh=JeNS60Y+XI
	IUlqPYveuNzMpLD/ooE7+DIS0HNdmGlKo=; b=RfdA9ylPCLRCxj/c/Xg9VykufP
	yO987SWJbitIQv0Ol5fAEvGOqU/NrkN1pNAVjVk0D2htiY3ASs9NJ8RSIquz4iBQ
	JKsXxqERsyY35CDRSr45BKqXbImQcyVU3zMfybtKICFHLiyI/ls5eD8Cf2W1svY6
	+Dce+vPYDU+YG19rHXllkD7p94OARRUJwmRFu+nwh+QdgQJuqW15x84dF488oaZs
	KNJq42ro1VAtWJ0XYij9pgPAxop8NBfNTyD9grDLt4+BAkrbBj187qeC4WDqRbx+
	cEHPn+NS5oHVh3u8rr7V75AnUGPLMErz+MV1EtQE5/xmL/wzYqX2G26mBV5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745538499; x=1745624899; bh=JeNS60Y+XIIUlqPYveuNzMpLD/ooE7+DIS0
	HNdmGlKo=; b=ipy+pa6zD/Unk3vvAOpct+2ggsxziiQHWK1RmRsbL47MpyHlpbH
	twxeFpCouJxCf16QsUbEST6oy3OuMv4pinB1H/IMlNR6wj91vDE4HTropsM1403Y
	5hTqCB/k2Y01oDJXZc3N6uijsst/EpkzhSAWzO7D0M32q5hbrDMTNgQqgZGZlEpt
	2vhtj3krnOB0j16koj1AdFHTNSahccsxItnMOzE1cgutJytQT++T2LmNEcYu6n+U
	RIhr4nWdHDNIOtsO8RIxsiEHkKLwuxG31kqtqFQ+09KD+3dg6KbYA6XBgrxFFB5F
	KZZSNR6MwEcl4Waj52XUoHvKI2OCCVAos5w==
X-ME-Sender: <xms:ws0KaHHfHmpZYceiUOPWNuhV0V4_WB9j95wIZlRzAzBuTv5P3dpnow>
    <xme:ws0KaEXFBi5wTo9zS1X38Jrp226Emh7OYsiycnY77Hm3u0d3aq6TwiHXuXxTv1L2N
    k8ZTBPgEDbUqphahQ>
X-ME-Received: <xmr:ws0KaJJUGld_elI8ueJVfBDAuE57jfgOJQYhNyT7-98P9w8ws9CBSlqplmL2t3pW-29nfmRmc_MfKM9z42c_jC0Zor9pcP2lKoQC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedtkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepjeekueejgeetveejteegieelueejieej
    feeugeeiteeitdelffdvffehieehudefnecuffhomhgrihhnpehgihhthhhusgdrtghomh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrmh
    esghgvnhhtohhordhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:w80KaFGarJWLAD5AVeyZhGZxbuyD5Ckr4nKtBiYn_GnPKaCa7TO5kw>
    <xmx:w80KaNU-EorgqUcLRhV6GUCR7DrgJJXJg-v7_JDJcAIjZ6BunF434A>
    <xmx:w80KaAO7elHfycQlqsZ-POA7NqXm96ligqaKaS-C6jAxu0URUziR1A>
    <xmx:w80KaM3jp2jh45sVq1r23Sb7bJljmXEeHwJmAjlwxVfR7rIDVW230Q>
    <xmx:w80KaExQNHLpYKxZ9FQF6RP7AHClTIkb_wv6wDdZgmRZxioSwoa-E3C5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Apr 2025 19:48:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Eli Schwartz <eschwartz@gentoo.org>
Cc: git@vger.kernel.org,  Sam James <sam@gentoo.org>,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH 2/6] meson: check for getpagesize before using it
In-Reply-To: <20250421175247.240971-2-eschwartz@gentoo.org> (Eli Schwartz's
	message of "Mon, 21 Apr 2025 13:51:46 -0400")
References: <20250421175247.240971-1-eschwartz@gentoo.org>
	<20250421175247.240971-2-eschwartz@gentoo.org>
Date: Thu, 24 Apr 2025 16:48:16 -0700
Message-ID: <xmqqecxhruin.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eli Schwartz <eschwartz@gentoo.org> writes:

> It is deprecated and removed in SUS v3 / POSIX 2001, so various systems
> may not include it. Solaris, in particular, carefully refrains from
> defining it except inside of a maze of `#ifdef` to make sure you have
> kept your nose clean and only used it in code that *targets* SUS v2 or
> earlier.
>
> config.mak.uname defines this automatically, though only for QNX.
>
> Signed-off-by: Eli Schwartz <eschwartz@gentoo.org>
> ---
>  meson.build | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/meson.build b/meson.build
> index 6c147c22a4..f5d9ffcd7f 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1300,6 +1300,8 @@ checkfuncs = [
>    'mkdtemp',
>    # no compat
>    'initgroups',
> +  # no compat
> +  'getpagesize',
>  ]
>  
>  if host_machine.system() == 'windows'

Is this related to this breakge we started seeing for 'seen'
recently?

https://github.com/git/git/actions/runs/14653573748/job/41124519642


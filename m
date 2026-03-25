Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72311358389
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 10:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774432900; cv=none; b=Mpnu7Z+LVqRetBVuGNuBl8V3xz/Sz7G+jB/uRRBIFXSSRvW7EN7MCDbcxsfiS+PbSld0CSDmMWSq4Rj1KExa4TgKsH0NrJ+v6d4LgsVqp/TAd+BhdUxM7ZiqUvieJLjSgGuCwPJy0NX8fu8FemjXah0vDvdu+WTvLfCly9weADY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774432900; c=relaxed/simple;
	bh=CgeaTGHRm1bQuZi2DxYlLjPaFbS2L3KsX24rDP8bDL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LFGmlh+qB+vCbBi3gUQIxxD+JhCOa03oD20BjXA1EAZB9jODuJuyLEx0lBGy0U3cTUT5+T8gsOExETOtJ5vsoBum0eHDfqAuVeGTXuPkFXMvb1DBHNfEKlKKI1APU9KHnv8RujujGpfjkSK+0zRaYyDnVmZwCEtVbJect4xCW4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=T1AKjpHA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aLXyW6LJ; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="T1AKjpHA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aLXyW6LJ"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A2DE8140002A;
	Wed, 25 Mar 2026 06:01:37 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 25 Mar 2026 06:01:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774432897; x=1774519297; bh=sEFK/Fsmfh
	8L8uS2QOl353VwwQjegRNfjnp67DPCPd4=; b=T1AKjpHAtsuhFGfkEF/VC+byBB
	Li82Q49CRJBdGsdfzcUwRveWYWnuBHj68RlSapXfBZN6oy6V4Kcxu/wit9EvvCs8
	CdosYUjW/zAIIvL4WG45b4naYmLOmG7M1cNFDDEzSj9fVOMj2c2xtPyhhz8yDnqQ
	V5RV9E05VELudB/TAdZypU6f40Ki0c/HYW30mw8NQdDRa6NLCd07lJFuZno7aTZA
	/8fteXS47B1MQUJ1wfs/TKnfigyrIR5gofADzR9EqRV5EP7/STl2qb7K4Bcmztn3
	snopPGi60s/sGbSM4LRXqbj8m8whL3KxnEAdGuQVB6fXpSI00btKZn/IjH3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774432897; x=1774519297; bh=sEFK/Fsmfh8L8uS2QOl353VwwQjegRNfjnp
	67DPCPd4=; b=aLXyW6LJ3l56KZthUqcT+mr6WPJr1TGYva3wjscXJUnnsQ7AHdO
	k7/wMS5NNijrJNeFL+A1+w0XxYQcDRnYUE0JVQ1rkixHT4kSEoVqzsbxYbZxglyQ
	mwm3/Lrur0PZWpFovRAK698E/TarmmBy/3OZcsV/oWMaMe715EKYL74jwZVJuTqG
	U75D75zTy9E+KOh6PDFx9VNSvA+vV7tD87RsPbrW6aORcvGAj+aLgo1RZgDJnom9
	PiS8ljsnQyvwSyALCkV8R17MBl5AZB7VMpMTNt7vXig1VCh/twiqzY/VccCFw9Fy
	y1A7851RUdLviA2c/y73Po4wx1jMf/yUMLQ==
X-ME-Sender: <xms:gbLDaVnm5BcDF8pge6Lcyj-66DhO4SS15yAkmzP_7NgKJYH1o2yTVw>
    <xme:gbLDaXvwonY6Ny13GvXdENX5yInoz6bzc9Xlh7QaJfqGJxstw0Zo-my0H-TXukhuz
    aucMd9KBRW6wra96Afo9nHtr1mh0Z4BHH29ADiPiAOQr2fI6bxP>
X-ME-Received: <xmr:gbLDaT955eUX3iuig59vva-aBdirqquBKGhtzCKzx05EDUzTMc98UJPPFxmItLSVaSUBdnmrQT7hnE7EuIU7wUYednNH-4z5O8tIOskI8xk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdegudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehmrghhlhgvthdrthgrkhgrshhsrgesghhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheplhhutggrshhsvghikhhiohhshhhirhhosehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:gbLDaRNkWPtZ35ZMYo9e10KsjEeZluvaf7a1A6lJoRzeibsvHq-XYg>
    <xmx:gbLDaRFrJV8I1GjTR29O_jbbQ_LYcuNCAheAtyw2YrPH1p77ex4u5g>
    <xmx:gbLDafQ1yJac5RPLv-CP_8BaYXJJhwfsgSg8ClQPjg_iqhM6SXPq6A>
    <xmx:gbLDaet44b6M0n2pBWFXiZC6Yp00FkZLTDK8sSvfdZONwLoqiBSBKQ>
    <xmx:gbLDaQd8Yv0nz1ZloIPEQTrQpyGhAvGIRMfeq8h3GoYFfr7fCLXNF13M>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Mar 2026 06:01:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ca166a81 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 25 Mar 2026 10:01:34 +0000 (UTC)
Date: Wed, 25 Mar 2026 11:01:31 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Mahi Kassa <mahlet.takassa@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, lucasseikioshiro@gmail.com,
	jltobler@gmail.com
Subject: Re: [PATCH v3] repo: show subcommand-specific help text
Message-ID: <acOye5MbsFVOa1vJ@pks.im>
References: <20260323152937.257406-1-mahlet.takassa@gmail.com>
 <20260324184843.299223-1-mahlet.takassa@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324184843.299223-1-mahlet.takassa@gmail.com>

On Tue, Mar 24, 2026 at 07:48:43PM +0100, Mahi Kassa wrote:
> Use subcommand-specific usage arrays for "git repo info" and
> "git repo structure" so that each command shows only its own
> synopsis in help output.
> 
> Factor the shared usage strings into macros to avoid
> duplicating the same synopsis text in multiple arrays.
> 
> Add tests to cover the subcommand help behavior.
> 
> The previous reroll mistakenly omitted the requested code
> changes; this version includes them.
> 
> ---
> v3:
> - include the requested code changes that were missing from v2
> - factor shared usage strings into macros to avoid duplication
> - restore blank lines between tests and before test_done

By the way, it is highly recommended to respond to some of the review
mails directly, as it helps to create a dialog between submitter and
reviewer. Otherwise reviewers may feel as if they are talking to a code
emitting entity :)

It's not necessary to reply to every single mail, but going like "Oops,
yes, I indeed forgot to add the request code changes. Will fix in the
next version" can go a long way to make the interaction more social.

> diff --git a/builtin/repo.c b/builtin/repo.c
> index 55f9b9095c..71a5c1c29c 100644
> --- a/builtin/repo.c
> +++ b/builtin/repo.c
> @@ -20,11 +20,27 @@
>  #include "tree-walk.h"
>  #include "utf8.h"
>  
> +#define REPO_INFO_USAGE \
> +	"git repo info [--format=(lines|nul) | -z] [--all | <key>...]", \
> +	"git repo info --keys [--format=(lines|nul) | -z]"
> +
> +#define REPO_STRUCTURE_USAGE \
> +	"git repo structure [--format=(table|lines|nul) | -z]"
> +
>  static const char *const repo_usage[] = {
> -	"git repo info [--format=(lines|nul) | -z] [--all | <key>...]",
> -	"git repo info --keys [--format=(lines|nul) | -z]",
> -	"git repo structure [--format=(table|lines|nul) | -z]",
> -	NULL
> +	REPO_INFO_USAGE,
> +	REPO_STRUCTURE_USAGE,
> +	NULL,
> +};
> +
> +static const char *const repo_info_usage[] = {
> +	REPO_INFO_USAGE,
> +	NULL,
> +};
> +
> +static const char *const repo_structure_usage[] = {
> +	REPO_STRUCTURE_USAGE,
> +	NULL,
>  };
>  
>  typedef int get_value_fn(struct repository *repo, struct strbuf *buf);

I think it would make sense to split this out into two commits: one
where you introduce the macros as a preparatory refactoring, and then
the next one where you start to differentiate the different usage
strings.

Otherwise this looks good to me now, thanks!

Patrick

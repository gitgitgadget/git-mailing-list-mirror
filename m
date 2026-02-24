Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434D02DCF74
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 06:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771914312; cv=none; b=cAaTXQOqxg6rOhcPQl51WjFj/KoPBFeHTgCJkWoVQ5hbRl2BSOi+4sIEUMF/uRsnQ76dKnspbQx2Epz5eO+Ewap8yu+YS3SMeZHqRoSAmrNkLwakelNuw+sVlfkQZz7GwoN7UEloAtdNk4GVg7ir90pNJ+BC6Lm8HQUfhsYw35w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771914312; c=relaxed/simple;
	bh=e5uSshMvmgDEuj7Bl+KlWlpveF+R9htKFMyMwalX2BY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VaDvrNlQ5U2viYRcgh3MEyAwRjiiYkRgfRaQig5e0lnIIC5+S8n6xSowUxk0i/SPHufwsvXr2MgvuiQ2NuPVirXPSXdHQRigQZBGXQZ5VRZQ6/vsTYP47i3DDqSUCVwktuGmcqsNOBhNYGNenp5r0N4fzZtzRYpUESzcrJ+k9ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fWBe+iVG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LDbiYv2d; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fWBe+iVG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LDbiYv2d"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 647807A01C8;
	Tue, 24 Feb 2026 01:25:09 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 24 Feb 2026 01:25:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771914309; x=1772000709; bh=EEQ2QEmD6h
	pTvrvBa0XuCjIjvGF8ln9NtmTph4QYxKU=; b=fWBe+iVGvViC9Fb8foYms4iUrx
	oFk98tIPuVsYpmjNExVNLiD8n7epM+3h5m7kkbdwtYJ7WJXRrv58JUjB2daqymU/
	5omYHCISbf6vDz2tpuZtF8MLgMxnm7Rw3pGu4UKkXzY/EnAqki3TgyaP6+7I6RmI
	actSsbZ0F6MhreQe4rI3Ep/a3qa0qHYhJPHbORwr2idrw7pI00dhtBQC6NqTXvZP
	Rlj76KFNsGSz8k+6HBPSwDu7NL1/dNXCcwVtvioj+B0K+BoNxfOklRm/cjlwwqo1
	pLa4nSDWpJ8TsPMtho2MflJf+Fj9Dw8Ec5xvK7l4OkdULtBjP0yTqtBlvRww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771914309; x=1772000709; bh=EEQ2QEmD6hpTvrvBa0XuCjIjvGF8ln9NtmT
	ph4QYxKU=; b=LDbiYv2dvLRCy7NUqzyuFbPlRZNQuHUzRLEd9d/bgMvLj1sxx/A
	jOZPUUZf/EmStkK6Tb2IHxW7i4PA/rNY55C3xVkfTWTaz+lRTUj12qWQcSt9q0cr
	4xCkdDauV1oNZaa6DzP+Oc4QqjG7ZuPXhNNE7ml5Oz47FsfPMh7zBGD4LHu5KwGz
	GuL4JcPp3m6TyfxHL9xtLW1r1pug6RoeUN6+IeqkJfDdOvRS/WKJ/ZO4eM6iwMPB
	FaV/afdf7H+Yskg8tWuiOYxZ3rlJBjoRNEYwwQoAqRIfuMAY9kz8+VtJm9koiALn
	8IdyrteVoXHZF+y96JSviDvNXxpB+v55SAQ==
X-ME-Sender: <xms:RUSdaSWtONJCsUuXoQkcNuNkOgbSh00gbHC_zmaQqSoiX5k0arpGhg>
    <xme:RUSdaWDuntN5livKRf5E8AmfDVRtEYce2a5IANlzA_z6uEIITY5t6nKY0cfELul9V
    toZLA8E5E_miiol9ABh6GzFrIAmIFY2aef1oL2_tbg_53a8z7uzGQ>
X-ME-Received: <xmr:RUSdaTzH0xnWZui_CRIPwyDFQZpH56JQjMnWC-YFaNasyWXkUJiBME5BaXLP5Wi1vSzeaD6NyUzvJuH47tyyHQZCiLNMpQEbVA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeelgeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrhhoihhk
    seguvghlrgihvggurdhsphgrtggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:RUSdaTBARuBRsTiLFFhYQ33k9veDVRjM533vvTpyNO8anhs6oZztmg>
    <xmx:RUSdaQbwNdLDhtqzArvRr6SCQGfD2uGRZWRXqSVuhrzOsgiLaRmzZg>
    <xmx:RUSdabgXtnpuRMv4OncEJIKKGqGB53dMN_br-MhdKU-AjLhnNTxEug>
    <xmx:RUSdaS5zSrQw4mOUcwgCdE6WRH6v0m9NRpuZcQgYFeBqMT6ACcTrYQ>
    <xmx:RUSdaRv76xBP1Gy8f6VsX5jhm13xFoT_nBOmEOBqneawTihLUvxd4f0->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Feb 2026 01:25:08 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/3] pretty.c: fix null pointer dereference
In-Reply-To: <20260224040400.751247-2-mroik@delayed.space> (Mirko Faina's
	message of "Tue, 24 Feb 2026 05:03:56 +0100")
References: <20260220230633.132213-1-mroik@delayed.space>
	<20260224040400.751247-2-mroik@delayed.space>
Date: Mon, 23 Feb 2026 22:25:07 -0800
Message-ID: <xmqqcy1uk69o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mirko Faina <mroik@delayed.space> writes:

> commit_format_is_empty() is used to check whether "user_format" is set
> to a value. Unfortunately this function crashes the program if no
> user_format is set. This is because instead of checking for the pointer
> value it checks for its dereferenced value, this being NULL if
> user_format is not set.
>
> Teach the proper condition to check if user_format is set.
>
> Signed-off-by: Mirko Faina <mroik@delayed.space>
> ---
>  pretty.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Interesting.

Are any of the existing calls to this function that passes
CMIT_FMT_USERFORMAT trigger a segfault with certain condition?

For example, there are only two places where CMIT_FMT_USERFORMAT is
assigned to something.  One is save_user_format() where user_format
gets a non NULL string before rev->commit_format gets assigned
CMIT_FMT_USERFORMAT.  Another is git_pretty_formats_config() that
parses configuration variables "pretty.*" and populate
commit_formats map.  This is later used in get_commit_format() and
that function always calls save_user_format() we just saw when the
format used is CMIT_FMT_USERFORMAT.  So the existing code paths seem
to be safe by design.

What I am wondering is if a NULL user_format should be flagged as a
programming error, instead of getting swept under the rug like this
patch does.  IOW,

	int commit_format_is_empty(enum cmit_fmt fmt)
	{
		if (fmt != CMIT_FMT_USERFORMAT)
			return 0;
		if (!user_format)
			BUG("never called save_user_format() and using USERFORMAT?");
		return !*user_format;
	}





>
> diff --git a/pretty.c b/pretty.c
> index e0646bbc5d..cdb8bf559d 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -47,7 +47,7 @@ static struct cmt_fmt_map *find_commit_format(const char *sought);
>  
>  int commit_format_is_empty(enum cmit_fmt fmt)
>  {
> -	return fmt == CMIT_FMT_USERFORMAT && !*user_format;
> +	return fmt == CMIT_FMT_USERFORMAT && !user_format;
>  }
>  
>  static void save_user_format(struct rev_info *rev, const char *cp, int is_tformat)

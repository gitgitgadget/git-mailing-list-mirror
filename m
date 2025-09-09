Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672F528E7
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 06:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757400191; cv=none; b=hbg8AAWz2KnuOY3Y3AWo9dYH3utwsJ2/Y/Ng4EdM9T3dYUP/X18vjYeUTiPjkTvhGCZtER22mM/JD13I6OCB830j1PJuiDO09bNXgnpN0xS+jnzFi/DIK39CBOAssHSit0t25lhggmRdi+GEvnF/9G2OdNrGAfhYyq3GDx0oeFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757400191; c=relaxed/simple;
	bh=KAvj4hU0BALYwXK3/6T4ryJ2azOvY/L1D7buIMZoQNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HpOC+1GatIX0pkmVoVideqLfs7ZrGMXN5gRmOOWMNPg1nDMKIC2oV7/KujDTmnvzpeUpOrPiNcglxuIYFTMcNM2xvgfFPzOZQaAQ/Hp2B7uSrE0Ro+pZ1dvFyBHjf0pr32ADaDUb3NV0YJgKLPR/xUcSHgZt3GVrHxe3VX3AfGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gin0os6V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WtTIDeqr; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gin0os6V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WtTIDeqr"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8248514000F8;
	Tue,  9 Sep 2025 02:43:08 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 09 Sep 2025 02:43:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757400188;
	 x=1757486588; bh=4CPCe79ItRzjefgX51t5mr30vDzrLkMuGmgM9QfpHM4=; b=
	gin0os6V5XOUm1Upj6gx7J7ZSsnKOMbDKJVKQWEPsKm+g8InaQFxU7y31KCd2jQ1
	RYKY+wO++3B0ijND9nJlD+BHf43dAJ/dH3ApjhjkmFGzZE69muFI5n0gl2THL2mk
	g4NDxSraeVwVqWSayLy1yH347q6do66ee2wCpQmCKFHM0MP4dOW/kKrhhpqrM8zU
	2WvnptKKtp+lt599ammJ0GX58N2HWrkzyZ15VwO/4Ug3QSkVFnk/BkbI1+P0Xc4R
	cG4rLawDEbccgYyr9cjkA09sOG/mODqIe4mU3f+pL7gm9pD2DwF7GrB/K/8anerE
	qZ5gHqN5evOe/bRJObqrow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757400188; x=
	1757486588; bh=4CPCe79ItRzjefgX51t5mr30vDzrLkMuGmgM9QfpHM4=; b=W
	tTIDeqrp1VFh816ta9qLOSpfT7GKFuO46p5l3R7nzkuL433GZ25fma2qn+YsLZq3
	JnOCiZJ9Av+c6DS8irRrO+1UYuWjaraP3nfXEqgcNBQftuhYUuuUSbecQRRpVcm6
	HEWtNNGgF/kZmKG0o3eFglA0Y3//spREEsDoBp/FQFDzs/hiM262jqcBFhmB3H69
	LZnrJwH9Ip+JmTKoo8DrTdqfnZPR9A+iqTJEtnwcvGamk96Wv85BskU0goOwSP8o
	BLuod0M3OO/AM83SDCwMd2RNWZhHX+NVD6ZbYSlcXjtSpuSR/P2jBmPVaA9VJzKV
	rdfsNVxWwa7oG9H3JpQ1Q==
X-ME-Sender: <xms:fMy_aCk1iZMm9vT2IqG4P4iEvQJxs5HInVwqnk1QfvkT8jKqJPbTuQ>
    <xme:fMy_aFULDUrwggLXQ79z3DE0TkCeqhOXzyv9d6qwbO-bttXE1lWXAMMsA5P8ZMQqj
    kz_W8vp5Jw9SKe7cQ>
X-ME-Received: <xmr:fMy_aHFbue1Cp30jx1qSZInn05sJ6mjSnMvwd1lCGwsUCG5j7OesY7I1Pz2OVqzuFbARvAmfVjx0SvgN4_EYLlynL7jBy8cskfx7k0wEQOU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleejvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epvdefjeeitdetleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehs
    uhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepphgvfhhfse
    hpvghffhdrnhgvthdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghm
    vg
X-ME-Proxy: <xmx:fMy_aBcyVT95u_9xa6xI4Qp6IYhGhT7UYB9rVow96_iXQVzMt9bvyw>
    <xmx:fMy_aIJXd6UqJluaNou8Fe3ofGegQ0Jbp7OvVeexhsdTx1H4rNumAA>
    <xmx:fMy_aGFWgGphYe62ti4MxhVJvw8yvm5IcaIqyeC4a1a86EWNNHjDtg>
    <xmx:fMy_aLAuHV1KxVyHuEmPahSoyota3Uva1JLFOOqFO_tyPv4BhaEPqQ>
    <xmx:fMy_aFMi7jbk-ofQ3vO87eXogPMdI7AYMJe7U9JSWU0QZqFoXDsNEY9M>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 02:43:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 10615f17 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 9 Sep 2025 06:43:05 +0000 (UTC)
Date: Tue, 9 Sep 2025 08:43:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Eric Sunshine <sunshine@sunshineco.com>, peff@peff.net
Subject: Re: [PATCH v3 1/8] git: add `deprecated` category to --list-cmds
Message-ID: <aL_MdiBLx9sssBwc@pks.im>
References: <cover.1756480827.git.code@khaugsbakk.name>
 <cover.1757345711.git.code@khaugsbakk.name>
 <bdc683a92b38884e9428cd4bade1f86960ef432b.1757345711.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bdc683a92b38884e9428cd4bade1f86960ef432b.1757345711.git.code@khaugsbakk.name>

On Mon, Sep 08, 2025 at 05:36:12PM +0200, kristofferhaugsbakk@fastmail.com wrote:
> Notes (series):
>     v3 (new):
>     
>     This is something I wanted to submit independently until the point about
>     aliasing builtins was brought up.[1]  It will help (in a small way) with
>     the upcoming patch “git: allow alias-shadowing deprecated builtins”.
>     
>     By the way: should `command-list.txt` be updated in some way (I didn’t
>     know what way?)

I think it would be a good idea to introduce a new category for
deprecated commands. After all, next to planning for the removal we
should also actively discourage the use of such commands. But if they
are still prominently featured in git(1) then people might be misled and
use them, only to get a deprecation warning thrown at them.

> diff --git a/git.c b/git.c
> index 83eac0aeab7..87d61f12594 100644
> --- a/git.c
> +++ b/git.c
> @@ -51,7 +52,13 @@ const char git_more_info_string[] =
>  
>  static int use_pager = -1;
>  
> -static void list_builtins(struct string_list *list, unsigned int exclude_option);
> +/*
> + * 'include_option' and 'exclude_option' are mutually exclusive.
> + *
> + * The default ('!include_option') is to include everything
> + * except those filtered out by 'exclude_option'.
> + */
> +static void list_builtins(struct string_list *list, unsigned int include_option, unsigned int exclude_option);

Nit: let's wrap this overly long line.

> @@ -668,13 +677,20 @@ int is_builtin(const char *s)
>  	return !!get_builtin(s);
>  }
>  
> -static void list_builtins(struct string_list *out, unsigned int exclude_option)
> +static void list_builtins(struct string_list *out, unsigned int include_option, unsigned int exclude_option)

Same here.

>  {
> -	for (size_t i = 0; i < ARRAY_SIZE(commands); i++) {
> -		if (exclude_option &&
> -		    (commands[i].option & exclude_option))
> -			continue;
> -		string_list_append(out, commands[i].cmd);
> +	if (include_option && exclude_option)
> +		BUG("'include_option' and 'exclude_option' are mutually exclusive");
> +	if (include_option) {
> +		for (size_t i = 0; i < ARRAY_SIZE(commands); i++)
> +			if (commands[i].option & include_option)
> +				string_list_append(out, commands[i].cmd);
> +	} else {
> +		for (size_t i = 0; i < ARRAY_SIZE(commands); i++) {
> +			if (commands[i].option & exclude_option)
> +				continue;
> +			string_list_append(out, commands[i].cmd);
> +		}
>  	}
>  }

We could combine these two loops into one:

    for (size_t i = 0; i < ARRAY_SIZE(commands); i++) {
        if (include_option && !(commands[i].option & include_option))
            continue;
        if (exclude_option && (commands[i].option & exclude_option))
            continue;
        string_list_append(out, commands[i].cmd);
    }

Which results in a bit less code duplication.

patrick

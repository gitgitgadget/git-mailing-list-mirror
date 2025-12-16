Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3A2261B9C
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 08:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765873533; cv=none; b=p2aOzJn3z0bucjh0eBjCzJhCaXA3u/BaAWaiQLv1Z14xoUE1guYIsgf5MsZ8cflXZ7k9UFppp5uboaN0F0EpUTQajCVg2Usv9/d0n5vRtN2KAc5nG7/Z49wXfc4aKJ/tM/lYBnHejlbKFGUE7nhbrU7ChERy8hAR+iWc9IBbVHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765873533; c=relaxed/simple;
	bh=njDPuIhsKoGF5uKuTDA1pvXDClQ9k1f9xChKntdq5Pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RM7v2dy0AxJa6apK0PtAzPHRYJYks01PfJdhnuJvfsPaIaDJvhT6H1fD5K+qWRid6pyPVUqNpJnHP0acdXA9CWxIq1S2kTfch/jnBiNgiAwdfvQpD9q3KkXNa0T4kGnWoPC0mISWvnF7mR8xmzBbPoZGIWBm+gBBcDSZRVCVeuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OuNLH7kE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YRau6S8o; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OuNLH7kE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YRau6S8o"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id D5CD01D000ED;
	Tue, 16 Dec 2025 03:25:29 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Tue, 16 Dec 2025 03:25:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1765873529; x=1765959929; bh=vnr13x+1jc
	uXTXP3il8HRdU7mNhgHciFKY7bbGcICgI=; b=OuNLH7kEhfTOHgcQyouwBM5XjV
	daNKGab6pIwsr3+5K/gGYWP78NzqCYEt+/1adFHBMuos5REX4/CwVd9oyRRaDA30
	aScaRMAs75+trf+lHrcaPtUTSb70ceXxQfwpycGvTI0EuHKC9nK15mna3FgDLb/3
	U+D8uwS/2k+EZPz1KN5rcvRzpPa+Rj1QyqreF7AK/+NQDWM95JoMlOAxq9fmYsdK
	B3E9C0zCz7OTf5mKZUwi6Got3ThGaaCwG31+TbNRnecnABbKpoPu+920QN8EtzkQ
	/rzC0RieJ+y5xwmrFxIoNp371nYNfb5meN6jS6HaX1PT791MefrV9EfiiOxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765873529; x=1765959929; bh=vnr13x+1jcuXTXP3il8HRdU7mNhgHciFKY7
	bbGcICgI=; b=YRau6S8oOOKl4JPvz79s8gHcZIH17o/1vIAT1Z1EOlXY+xVuoWz
	D/D7FaPGgqOT+epYlwY5YJmkujgOXYod22YXKwu+70Y+MKU/+943ZyuWnnSxxc/j
	L9V5UJyz9Zufj2lcehTJ8YNr80M412Tl0I0P246YWCgvBtMneqh3kJ7F7TnapuoC
	PJNK2QXlXrduw5efBRYt+D34VDKF7/vhZ7M4Z/E6xUlqa6QSCP4GCZyBBE1DwtwK
	MbxzNFUnp6Zm0+8bqqkByUuSxVyYjG4dZATMsjh+h0qMnZkPnT2l90iv1qT0rPMC
	tWyRi7BUO9J6N7QFSEh6zNFHn/Ld92lDy/w==
X-ME-Sender: <xms:eRdBaaRT8a5zx0YJ-64OEjf0xUl9pgjcdghRERkJfBxaR8SKkwGXHg>
    <xme:eRdBaXPs51L8RrZ10U_Px73q4mWqWGSJVmpktAUg_iDIq7oP-fwoOclvwqGe92TQu
    5U1Exrpng3qm0TsfhW5pOsYXCxCM_gt2gQ7fGgEPEGPSEoEG0JW>
X-ME-Received: <xmr:eRdBaVMHsZOvgunO_VeZwqCNfFWdcFe7mHXs6E5l63hHy28gatqvtBAmdf42Uor7HBDfndENKTNObWTwGM8jpW7slbqbRB3MMD28E6DbAA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefledulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtgho
    mh
X-ME-Proxy: <xmx:eRdBafszQ5I2ivTbtOCR8-BREYLVUFTsENax1stpprycuE3QbHigQA>
    <xmx:eRdBaXUfFqfm4kRV3PQfyfUOf7_E-JQf_dGCS9e4kDeDfmk6um4Tdg>
    <xmx:eRdBafsDHIXBoO23PFoG8xlGlS6wfFceFnEwH9W8vH7pI461tuK8ew>
    <xmx:eRdBabU9uJsr-uXOW2HsUGKDXh7fbP_DwQWE1aSCMurEkkdEREYJ-g>
    <xmx:eRdBaXOEOyPFlJBDdv_FKZc0ZAjz8eIKD7MhUALLLMIZW_gQSmPVXHD2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Dec 2025 03:25:28 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c2c4cc8a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 16 Dec 2025 08:25:27 +0000 (UTC)
Date: Tue, 16 Dec 2025 09:25:24 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v3 3/7] builtin/repo: humanise count values in structure
 output
Message-ID: <aUEXdE7qxy8TfUJR@pks.im>
References: <20251212223644.3090879-1-jltobler@gmail.com>
 <20251215205639.2700270-1-jltobler@gmail.com>
 <20251215205639.2700270-4-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215205639.2700270-4-jltobler@gmail.com>

On Mon, Dec 15, 2025 at 02:56:35PM -0600, Justin Tobler wrote:
> diff --git a/strbuf.c b/strbuf.c
> index bb8e98872f..662edd4d19 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -836,6 +836,29 @@ void strbuf_addstr_urlencode(struct strbuf *sb, const char *s,
>  	strbuf_add_urlencode(sb, s, strlen(s), allow_unencoded_fn);
>  }
>  
> +void humanise_count(size_t count, char **value, const char **unit)
> +{
> +	if (count >= 1000000000) {
> +		size_t x = count + 5000000; /* for rounding */
> +		*value = xstrfmt(_("%u.%2.2u"), (unsigned)(x / 1000000000),
> +				 (unsigned)(x % 1000000000 / 10000000));
> +		*unit = _("G");
> +	} else if (count >= 1000000) {
> +		size_t x = count + 5000; /* for rounding */
> +		*value = xstrfmt(_("%u.%2.2u"), (unsigned)(x / 1000000),
> +				 (unsigned)(x % 1000000 / 10000));
> +		*unit = _("M");
> +	} else if (count >= 1000) {
> +		size_t x = count + 5; /* for rounding */
> +		*value = xstrfmt(_("%u.%2.2u"), (unsigned)(x / 1000),
> +				 (unsigned)(x % 1000 / 10));
> +		*unit = _("k");
> +	} else {
> +		*value = xstrfmt(_("%u"), (unsigned)count);
> +		*unit = NULL;
> +	}
> +}

I guess these here could also all use TRANSLATOR comments.

Patrick

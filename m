Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E811721B8F6
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 07:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749022573; cv=none; b=pqJSsntsm9Ah1fqg8WxHA5RabNdJGeCaDV6+5HO2K9nJANFeeB/0fXf2X+msaqcPIGqskR1cAhNLvdBGuj6uFvaOdg1SWVFaTdOnGBGuop8IjsLsgRwCXUKw7SdL9uFVdqpm4/gyJX41VNqVq3EYkAtBCSa2sLlgwbA+IaIUepQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749022573; c=relaxed/simple;
	bh=ODFLuxOyxJq8JdRIQ8yC5qLuXoyb9FRuf5EnQs2lhfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGikRZWkf7UxycuHjW604ryAu+Bym3g3kkpgd3XTN0dZLwlQJTJlhJ5sdCUSqBky7P5A4/EItnm4SCbELjZaQGyQWKzzyurZLodGArVTgVIGbO26COMo6IRSY6zyq//CTLeFuoMKpIyV9lbppwJ9i7CtQ9t+YifWkz2dnKwK380=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=H+53fXnE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E+TXtkbd; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="H+53fXnE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E+TXtkbd"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id CF7501380333;
	Wed,  4 Jun 2025 03:36:09 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 04 Jun 2025 03:36:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1749022569;
	 x=1749108969; bh=TwLFB88FvY7EgVr63aI5aWuLXDGyzzD8lf4FImRd66I=; b=
	H+53fXnEVVyvkY9LfePzCgqHe2Mt/WOrVJmRap6r9gbZpSNFm5cT702Gl+s7O2jW
	9uYSM3CBI1iQleyNS7OkUcSIzmKvlJI2PvoTrXUkTY2ghofCoiBkHLBUs0TXWRY3
	L0LHrMRLsaoWReDflTgYkuuu2EF5GGzHTzYGt9CrEq4Kjv8OeRVS2GnaMZE1kMQ/
	0GZklXXZPW2mYnSxhw7+eE+oUY+Dqo6g49U+enqAIWtqdPGQnSibkCTNmHJ6mXj+
	UQUwzSLJFq03h2YXr6IRZrCw6iH4+huocZ5swL6/0CVo/n0QuN71Qc2nFo2eLJhj
	dJWydPiAMJqUT97LAKl1mA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749022569; x=
	1749108969; bh=TwLFB88FvY7EgVr63aI5aWuLXDGyzzD8lf4FImRd66I=; b=E
	+TXtkbdLiMXmUCfafwXnSzc4GksecNsFdZgd3S0jBzJ/ZKmYheKpOvua8fxpbHC3
	MFoaPtFhLBuPn1z+mpFu8QZLLhVNeymAdiBcJ6/0FunXdcmfrSiYIL5r4yHKmNJo
	OkkByKXVxFFuetRCZ1OKC0kyg/Uvc4TbZDKShMC32so//NTodiuAhPaWyhMD6JxT
	zovdwWbM+qn7DugHajdPX9FTmCDVtjpE0FHprPNa7CEy0Iwv0QP5SmX4GPvHWcNY
	LhdckW1J+cgeOuSNfhNLbTIuSGJA+d/vqkVCoy0m1L0984p2bcm/SJRht1LvmlKl
	F+qDDobPwliYr7RT+Wsyw==
X-ME-Sender: <xms:afc_aN98fl6vNhzq9yl2T_iCxWv0PtX38P7_vHYJAu0yVV7AhsbURQ>
    <xme:afc_aBuhlafeBBdz9iEAiNSAkHMprhkC4d6MuLUWYf1KH1NBP8R3n0c3EamxDSrW-
    mPa6eDuzGd_HjXekw>
X-ME-Received: <xmr:afc_aLAyuK9KoMTbbMu0vsBLZwVyZV3cSxpPOvf3VNmovXfQGIleHDlKjdrzVj0KaWS__VVTpPYgkH-jYf-8Z3hwSlga5WpoiBEPzvwbN70f>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddujeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedvveet
    ffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepmhhhsehglhgrnhguihhumhdrohhrghdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:afc_aBchG-4mKi5a5ONWkAFzpEglgNPES-4wxUjwepiRgHvVJgXW-Q>
    <xmx:afc_aCOFv3BJIM-NdoFE4toN4ywb5r8enLZGo3vdF7TkcshF2MUJvg>
    <xmx:afc_aDm-U6oOM4bjfrjXqwId8Pb49s23uFbPLXMIrG7guQDXFdwBww>
    <xmx:afc_aMvFuP_qS7fyEBBeyZ7YyvbvAMyb-w0HyZuTcWYrzo1Zpu19rQ>
    <xmx:afc_aO3AKvb8_d-C24FvscoCmOsClEoAZMqNE15cUzFQ3iZr7PhA1i3A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Jun 2025 03:36:09 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 52017fef (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 4 Jun 2025 07:36:08 +0000 (UTC)
Date: Wed, 4 Jun 2025 09:36:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Mike Hommey <mh@glandium.org>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 2/4] Fix use-after-free warning with GCC at -O3
Message-ID: <aD_3ZzWSbyXIk81_@pks.im>
References: <20250603230646.2322671-1-mh@glandium.org>
 <20250603230646.2322671-2-mh@glandium.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250603230646.2322671-2-mh@glandium.org>

On Wed, Jun 04, 2025 at 08:06:44AM +0900, Mike Hommey wrote:
> ```
> reftable/basics.c: In function ‘parse_names’:
> reftable/basics.c:233:17: error: pointer ‘names’ may be used after ‘free’ [-Werror=use-after-free]
>   233 |                 reftable_free(names[i]);
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~
> In function ‘reftable_free’,
>     inlined from ‘reftable_realloc’ at reftable/basics.c:30:3,
>     inlined from ‘reftable_realloc’ at reftable/basics.c:27:7,
>     inlined from ‘reftable_alloc_grow’ at reftable/basics.h:228:10,
>     inlined from ‘parse_names’ at reftable/basics.c:214:8:
> reftable/basics.c:44:17: note: call to ‘free’ here
>    44 |                 free(p);
>       |                 ^~~~~~~
> ```

Same here, only posting the warning isn't sufficient to explain what's
going on.

> diff --git a/reftable/basics.c b/reftable/basics.c
> index 9988ebd635..de21fe6ef7 100644
> --- a/reftable/basics.c
> +++ b/reftable/basics.c
> @@ -229,9 +229,11 @@ char **parse_names(char *buf, int size)
>  	return names;
>  
>  err:
> -	for (size_t i = 0; i < names_len; i++)
> -		reftable_free(names[i]);
> -	reftable_free(names);
> +	if (names) {
> +		for (size_t i = 0; i < names_len; i++)
> +			reftable_free(names[i]);
> +		reftable_free(names);
> +	}
>  	return NULL;
>  }

This change shouldn't be needed in theory: `names_len` has a positive
value if and only if `names` is non-NULL. So the warning is a false
positive.

That being said I'm not opposed to squelching this warning. But details
like this should be explained in the commit message.

Patrick

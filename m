Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5436E382388
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 07:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789023858; cv=none; b=peFoGgqh84M0TNUPgWJs5P+elYDVD21SUHz384ohiU6ASmoMRkElS7M6Ef+KUw/2/HWD20meSyzJgLhe0bTZzRaT3V65H2gLzGdQgaFJN5TSSV0YjcYGPzecg8KumBjIwMyxsln1ERip0V21Jpqes5GVMJ8e3tijEPIol9mOOZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789023858; c=relaxed/simple;
	bh=zrDrC/xXJN+lAThUDwoe0GKeg/QyHPNG5ey+EyP9wc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CW6pivRA5TmFuovDP47CfkiXadlD01Qy/IZcNU6WndQ65lQ5fL7oXPl4PdZYZElqBN/F7gqDCu8ovDckbhUEKM6dTcvWDmyMfdG5+1QHl18r4AHO6QDLEPCzyFR2Kt/fRl0BibQisMcauhYYVW7l/J4MFy/96dOuz3mQUHd3KRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nZ3pzriO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZEPR1364; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nZ3pzriO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZEPR1364"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 498541D00128;
	Thu, 10 Sep 2026 03:04:14 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 10 Sep 2026 03:04:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1789023854; x=1789110254; bh=hEjyYXeRqX
	BCRkO7Ov1/0mvMwuzb4SXpbjT7SSYZbhY=; b=nZ3pzriO/vAwzDyVe9CkOPTrvK
	Pg+XEg00S3pppp4wXuasBmdJDMTbOvj3tqvhs4uWK7r0gKPEUcFKC/GKIW2yfsrK
	SfCK/EQuNVjeSxfJJk31mm+gZGLcmWuaj17wzcF8aE7FxUOhrRHWKL7cL7v0Ap85
	7z52YcnVEE5CiiqGsnx8QM0t0lgKb8aIVVBD16KKV9Q6CsCHs87ABGfza+TiOoQB
	EDZ9YP0akbzHzYY2058oNdy6quCtdvnxt+nwu6mmoxFYSDrb7R3Fswk7yUuqEjc7
	0HShVBq5JfJw3xt0jMDegikRSRSdLJhqrlBo0xajwPlNUS5kAgWPBi1oyJag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789023854; x=1789110254; bh=hEjyYXeRqXBCRkO7Ov1/0mvMwuzb4SXpbjT
	7SSYZbhY=; b=ZEPR1364eOA2EatUI7CyyC8BkPTPqFhk4ID0tETcAJ8uhEcj9b/
	QKH3zMMno6Fm8c0KqoRe0VTuNDttRu2EzCvMWTXctRT/Kb3qbZfKl1cMsV2guTeK
	JdMpEQphVEgqHsBzL08azm2qerjC3qgZ8EONK6273CqE5+0IAPWI3I4AeFWQrvcv
	aPdHfFYf6tR7/h18xFC1WupL6fpMGtjtsJEdnzcUtZby4XZdTdngoFKxxNqklRVj
	2AMtYOdPvUUWmIUNNFX/yWQ+I8j+x22g+HMccjV1mQLB3AeqClj4Y4CeV+dgXWUS
	pqsb0tE5EFKSMzZUqKvN1ZU+YckTTI3YsMw==
X-ME-Sender: <xms:bVaiapuZq1die9dFokIXm961CCIkckCfrBm9if4DDzkfWFrIOjoReg>
    <xme:bVaiapWPIqDAvFjiUaw0TP1nsNnmPnNMqVOu2iabbKcsO4NYhJRwUVzKU11SdGcHW
    hseOdWBh-A_dCmrWrWcOBtvvWyEsohqvKS1kJMtn4b0LN4IcnPGnl0>
X-ME-Received: <xmr:bVaialGTJXKCJmRNiFmSR-qwkCX3bT8nOuT8vRzWZL83thXraEI8Jw>
X-ME-Proxy-Cause: dmFkZTEk0L3HpALCiE6TtBb2I5fX0Zczcp8mWSvz9GNppDuMaOOnFDKAGvua+JfzvLj2YV
    4AERTVSa891OlpMUszD3VICN4plONrXhxLC5O9Z3nt7GIZxpo9EdZ/FMubPvVkIcMB3Oie
    yI6+bYbEh6GUb/uk987wiRp5J12vLFwNZYObzHi7s1mXlKhLRofb8OjikDx/msYLz8JWWC
    lH5CkPgQF0ndWDNJJd2J+hKmZczCnC2rFplQ9BQvFsKHTIkO3xvcDzQjs6rW2iQhjKL1Vc
    AhdEp4LKJD3kYswbSL67jDHBPg/2G4rQFCBh+esst8hnYb/Ba86kmeIkI/DwOM4atuFXAC
    HQPzSTH7Wdktjno7DI2VHoRO98eh0TIZZSaQQ61LGZVlsok5NWHjksXXtHwxYxd3zjEqcI
    7VMAy7yfoWWXcwL+YIg4B+zHFbqTfsYhvIvpDk3ZFFT2VAjHxIX2Z22HQk8EsN+CZ8BaSf
    SMyQuUB1absPppXqBLi31SFX1EdXZpCimLnucoY3gnvnGWpRFw0N1YwzAVx8QT0VmbXYVO
    URUWK+82r0Q/U+12xoakuGcCE4PxPMdjzpK+2vkrY1ZlmO9wVGhHvSodlBCrbkC4nVXDgb
    TWYfd5U0L1RZOAd6SYQ7VAFwRZC0/zxwN9kTx3QGsG4cVVwz0w/XRQy4kaAQ
X-ME-Proxy: <xmx:bVaiar2pp-5kHQPVqjMwLs95mb0PDyhYYL1nWuOb4x8GFWvg_zujRQ>
    <xmx:bVaianPQNNVNlb9swGag9Fhk-qKAi0OlUFTem6j9BhW0vMSQt3XGkQ>
    <xmx:bVaiaq5sxCKkFL5hj_gNYpHBgKS-9ZpOIiQJbLzsBQhRDuSG_sd0ig>
    <xmx:bVaiah3i57FZllFvTzJnbey62ZloTU-PKWjRn1wA0Zo2u9tOE88kHg>
    <xmx:blaiaqlH4PHRlcPAyTlAO2Xsk4atoou73Z4ptvJyJw43lq4xxWAJeKSw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Sep 2026 03:04:12 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f0a8dedd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 10 Sep 2026 07:04:12 +0000 (UTC)
Date: Thu, 10 Sep 2026 09:04:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Gusted <gusted@codeberg.org>,
	Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v4 4/6] revision: add Bloom check that includes parent
 directories
Message-ID: <aqJWasW9IKXhjfd7@pks.im>
References: <20260901-toon-speed-up-last-modified-v4-0-a09949800404@iotcl.com>
 <20260901-toon-speed-up-last-modified-v4-4-a09949800404@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901-toon-speed-up-last-modified-v4-4-a09949800404@iotcl.com>

On Tue, Sep 01, 2026 at 11:10:24AM +0200, Toon Claes wrote:
> diff --git a/revision.c b/revision.c
> index ed46b90b00..a560146b4d 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -789,6 +789,21 @@ bool revs_maybe_changed_in_bloom(struct rev_info *revs,
>  	return false;
>  }
>  
> +bool revs_maybe_changed_in_bloom_with_parents(struct rev_info *revs,
> +					      struct bloom_filter *filter)

In "revision.c", "parents" would immediately read as "commit parent" to
me. Would `revs_maybe_changed_in_bloom_with_leading_dirs()` be a better
name to clarify that this is about directories, only?

> +{
> +	if (!revs->bloom_keyvecs_nr || !filter)
> +		return true;
> +
> +	for (size_t nr = 0; nr < revs->bloom_keyvecs_nr; nr++)
> +		if (bloom_filter_contains_any_vec(filter,
> +						  revs->bloom_keyvecs[nr],
> +						  revs->bloom_filter_settings))
> +			return true;
> +
> +	return false;
> +}
> +
>  static int rev_compare_tree(struct rev_info *revs,
>  			    struct commit *parent, struct commit *commit, int nth_parent)
>  {
> diff --git a/revision.h b/revision.h
> index 67778558e1..192001ff79 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -507,6 +507,14 @@ int prepare_revision_walk(struct rev_info *revs);
>  bool revs_maybe_changed_in_bloom(struct rev_info *revs,
>  				 struct bloom_filter *filter);
>  
> +/**
> + * Same as revs_maybe_changed_in_bloom(), but a change to any of the directories
> + * leading up to a path counts as well. Callers that track the tree entries
> + * containing the paths, and not just the paths themselves, need this.
> + */

This comment also talks about leading directories, not parent
directories.

> +bool revs_maybe_changed_in_bloom_with_parents(struct rev_info *revs,
> +					      struct bloom_filter *filter);
> +

Patrick

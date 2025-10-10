Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610523F9D2
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 05:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760074247; cv=none; b=JGX7sfZALTjPAk9A9e/n0WjtLDokQgA+jeVkhP9kbuv4UeWO+yIzF3Tr+Pkpthk30Ux2VioeFsSl5AuFDzbXrV+uDxP6cvvnpk7e7uX2Wh0aU6K1H6qo8udEBiz+LnYfeGsTdwyzJayfb6zTVza4OxUTD7JM2uKMZJlSNcJ6zoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760074247; c=relaxed/simple;
	bh=ujrseyQ/Hrj0V3qmmRJuCO9jcRRKZ7BiKFkLlNIev+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVZ4Ed3zbQkOuNScmGzf35KqIBr3gW1pKl63gtrlAp9sjZ1DXFByYEvMfLgmqZuDwAioZWcQZsJMVLHIJpPdFuZYlGsOdIRW8x9Pd/aamTNJQzk6pt36T8HiOOfyjZkq5KC4WuInRDLhP2GsS0Qfw0UlSI1fy6LKErGMySEdhYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jEPd5xtc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Nee4e0vK; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jEPd5xtc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nee4e0vK"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 49C7214001E8;
	Fri, 10 Oct 2025 01:30:44 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 10 Oct 2025 01:30:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1760074244; x=1760160644; bh=+Nm4iwcnZZ
	OnxsLekxBuwaSNcEzrGKa9+/J6CyFjIyo=; b=jEPd5xtcyu7vlcRswlq3gHXJBR
	olwEACr4GOPIX1zje7kHH3hXtsSZTkX8niQ/DkjE6GmpArF55U6BjO+jainO+c/z
	Uri+IiSAuNhqUkAXxB4nFluKICvA7IOfThywRhBpl+ZrNAWRRZeAaRb1vHWSb7GH
	W00Z1p6s9SyIaYccTVR46gQpPjW5zif0eyjfVja/c0Ildl2PkrqiVDeoiSjjmtgN
	dPidNIwe5NE4npHS9NGsJIx6G9D5Z5wzzfgPQeReleRky+M1oXskpxF8adIdEfIm
	tbQDrsThnWem0Kl7uXXxHdew5+FzHlAvUzDtCpeFpREeFe2AsnKRkgwgMCgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760074244; x=1760160644; bh=+Nm4iwcnZZOnxsLekxBuwaSNcEzrGKa9+/J
	6CyFjIyo=; b=Nee4e0vKKAYw5UiARVXBB+Kv4/bTIJFRJ/Ilg32gPn0SQbyktFJ
	o1Y8hsXwYNNCi1dp01w2uNcWG7hnjaa510VRi20tXL/XRCkN9Bul8Mv0fm8pUQp5
	Iceibwmg1nqzwmDagIkDHcq/VmHxEGzhLgvJ36jTRJb1pPm+4rqcLEerR3Tqe/QU
	Rlitb31AqNqBvNa8qKWoteoq0ULGa3L5RR0sKGMEWLzOvjHXuQDauS5al+e7q5W6
	K2w5o9jRbqDXOfWyREWERG1JrFHWbb55VBNc23nsxEHtGgtQEMdIb53btPLeaUDu
	lQlPpBECtKfrEFXF/UM9UW+QwOWkFBNzpuQ==
X-ME-Sender: <xms:BJroaD9JTHfCkAChi0PCoeRZ8iUoc5-bv8wZxke3nGenPsPJIsS4Rw>
    <xme:BJroaFtp8VV-ox059-4FqwLvAiv9Vx7FUOD6pdRXMdTCqUoRzXp8p9tZ2yNpJbD78
    QledwhFJiwiLCCVRSzOjFwYIulSEzKEs1ywN6_2oiAWTg2qtW44JA>
X-ME-Received: <xmr:BJroaOqTnroNApfa-AG0pJ-qwVFGxyOormxyxz5CaahV_QlmXygkQp3TiDY8-cilx6EtJ2X6Dp0BLsORkj8KLwJi5NnE4dyAaxFQNAxB8g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdekvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehokhhhuhhomh
    honhgrjhgrhihiheegsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:BJroaKl_-11DrAhP0BpZSnyAV1qshEF53VBoMXHjt8rv6f-f1pa_Ew>
    <xmx:BJroaKyuWSBz4twcJKgJXjfYBzteDTTfxq8VdXpjZyQcO9r7pLNhWw>
    <xmx:BJroaKnSRSVgZ6vcnsE7BnjgU0jCiqiGXx6gemJg8uHXsG7Ita1wSQ>
    <xmx:BJroaLc6Xzfqa-yyMcz5w_s9bNKD099XwbLzlLHBn-eahDXa9LZKJw>
    <xmx:BJroaCuAzVnDRlE30C0eSS3d_Sf-XjlyNr3TDIxtBsJUboZdrj6knIIl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Oct 2025 01:30:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 61886f46 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 10 Oct 2025 05:30:42 +0000 (UTC)
Date: Fri, 10 Oct 2025 07:30:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] [Outreachy] patch-ids: fix NEEDSWORK timezone parsing in
 fast-import.c
Message-ID: <aOiZ_v3bO35oVWf-@pks.im>
References: <20251009234957.1789543-1-okhuomonajayi54@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009234957.1789543-1-okhuomonajayi54@gmail.com>

On Fri, Oct 10, 2025 at 12:49:57AM +0100, Okhuomon Ajayi wrote:
> Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
> ---

For a change like this it is important to explain what the problem is,
why it is a problem and how your change improves the code for the
better. All of this needs to be patr of the commit message so that the
reader can understand what you're actually doing.

Also, if this fixes a real issue, is it possible to demonstrate the
issue and the fix with a test?

> diff --git a/builtin/fast-import.c b/builtin/fast-import.c
> index 606c6aea82..695e1a0ae1 100644
> --- a/builtin/fast-import.c
> +++ b/builtin/fast-import.c
> @@ -1959,14 +1959,15 @@ static int validate_raw_date(const char *src, struct strbuf *result, int strict)
>  		return -1;
>  
>  	num = strtoul(src + 1, &endp, 10);
> -	/*
> -	 * NEEDSWORK: check for brokenness other than num > 1400, such as
> -	 *            (num % 100) >= 60, or ((num % 100) % 15) != 0 ?
> -	 */
> -	if (errno || endp == src + 1 || *endp || /* did not parse */
> -	    (strict && (1400 < num))             /* parsed a broken timezone */
> -	   )
> +	
> +
> +        unsigned int hours = num / 100;
> +        unsigned int minutes = num % 100;
> +
> +	if (errno || endp == src + 1 || *endp || 
> +	    (strict && (num > 1400 || minutes >=60 || minutes % 15 != 0))){
>  		return -1;
> +	}

Despite the formatting issues I also think that this here is becoming
hard to read. It may make sense to split this up into multiple
conditions.

Thanks!

Patrick

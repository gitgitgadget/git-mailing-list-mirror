Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929623655F1
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 06:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782714128; cv=none; b=MInStzxytlPWnZkMWzZ0dLXUDBma/dc3PK9HrbeScyIld4oSEulKCXfSPOA9+wqF3lUj+QFhxgbuXpT9IiZvdz+se2Ps+WvIhoh7xRp6WVP1OED9s1NVrMrEiH1QxoFz8icEPf31RaJ9roFT7TUzLcGDZ0jhZyQ0IIIqCPfgnNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782714128; c=relaxed/simple;
	bh=Y2QIMbKFKM4+1OTAY5eL4NFLiBapbcteGh6/+t2dV4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tObCoElIlQc8q/0ahQQ3FxwYL4qJP37vPJxzTYE3JqconjnqvUsqCYoL7hwP+nIcwmUTDWFMM0wLa494NYguUeUZX/op4F7Fpu289NTLTBlYPepOWzzkyWMMFnlcVO5B0sRm5XUFTGCvh74GXEVABUDRdJDy0ODn1hqGjScei+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lgMQAOSS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FaSCSQ6+; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lgMQAOSS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FaSCSQ6+"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6F4C17A0036;
	Mon, 29 Jun 2026 02:22:02 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 29 Jun 2026 02:22:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782714122; x=1782800522; bh=iENE9sIw9W
	wUO9jjlojMQjnwrxSIxVH/DUqeHpwYZ5M=; b=lgMQAOSS8+cVkC0vQxltZtgthq
	ce53/Ubs8UO8pUfC3/Gl511O1XpB0wvDeULL6qd/AwqgsEX1YmlTXNr+2m+Jf8VG
	QOuhJFG9WoOyzCnR0jM3ngt4Wg2D2aFnW2uv4fLYSZUKMa+Pyv2eJ/QRDM7Vyjv5
	5ZJOPPimJQ7W68aFEDT8EL2Rt04YrQxC/WDckCo1+cVVPr3NsPQPXQuk0tQeoV08
	V3Ofe1RRvIsi8vU7H0SUJFpY55fG5IQWpzWcFo2qm85XIsiLaKDuDEy59xC4qwX8
	lTQQ4G6D1n7i8a/tSrhYuca064UKEAeiR4xHZ7D40zQbxqyM/nCrzEjMcnaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782714122; x=1782800522; bh=iENE9sIw9WwUO9jjlojMQjnwrxSIxVH/DUq
	eHpwYZ5M=; b=FaSCSQ6+yVqPl7ssMaadg0gH2BMCm9XdzQEVSqdhUVNoH/miCMz
	S9MqCW+aSex9ObsBpkW/98L53eeBRChZwfULLYtuD6vIQyYkQvXo06o1jDWPsc6T
	HZq10+6QnaG6iBpst1BGzD4qR7FFlIbx7u5HsWjVA7Z97k6FRg8KbyJi8urNst0h
	dgTi1WPP8QS2IUJYXwrJo5rp2nUwb/SBBJhqjShEj+UhBtiF/PzQoIGGfPwjvFUz
	M1Jt+yK2vwRBZPAB6vQse8N79DwBnZMrAStTJeXEDTHlParzBzCkHRr2V2QKPIse
	2Q9rL0wPVY+gtYwB5TV0so+EMIIgAO8fS/Q==
X-ME-Sender: <xms:Cg9Cat_VdFaGUvlGrpc1zKUd9SoyQFYLDGk-qVSL_FP2VUDVC1QlcA>
    <xme:Cg9CansJDSxfrg-V40uniS7M5pCRikTj7M4dDWDo4ZfVZ1W3XhiecmEZ4cNpvXJjJ
    zE4IngwL3_n7gZU69tbvu8UMqoyWHODbE8INFhBg5wGnsCv0bDvrA>
X-ME-Received: <xmr:Cg9CaoqBvhO_d179KY97EhuTmFEntsu54gfuCFz8dwPpbRYpIx8TxnOBQOHRaf0TcdJrePl3lYKkUG-pdAk_8D25I_QJ8gSV_unlPFazoIfD>
X-ME-Proxy-Cause: dmFkZTE/R/3mHUO/GV48zDjj45mKZ2SS3Bddrk5QWsMcMmrKb+6ODPQ0N9FVW4dgouZIFQ
    Qr+u0leiXxtdCN3t1d6FM557F3EGeLpQkh6DZih54eNyfqYOYftMveYK1OzRNb/Hh4DwTs
    LQmtznCunFNyDLmZHhho587/TeRmb/aZkPrYU6knYZNkU9RHBk4yLsEFMgSufx+af/W5nf
    BUnaJY/lMsgfvV+7Gf6ObcgycFjUnu5cBTQLEyuO6i7NI4xrYsYzhzdfJrDcUtO+OvkPkL
    EE+VFWNDl6pPL12BnslcQCPGh3/ruGtLUJjkE2f1V+IaYL3N+EVbgIA7wkN0pSBSYIH8rf
    jSI0USKseZlLh9dP7WEYZzhh3jnLC3AXKDlKUcUaRZ+PGX4T0AqJCQeZ1e3dzerTNGwFZq
    h7JXYXGQCdtIx1mxowb2EJuQW9dPorewjw1wk9tnLBMB1IocNCB2XAST/DyD9KNF6M6zcq
    QAy6mqkkZ/woKWh3jzn1qS2gSy/Vt4q8tixPd6bZV6iTzmJXYf0azBcLfBpiTPO5emR1Pc
    GGGK8KxfvHWLb5zpBLVV2PthoNkq6AtW0aVdZZNXoedByGHD+5GpDxps5w//JYsnV7ThKn
    9eSXuRTBgkWmgOGCnvBtSlHpsW7brhGnxV/nJgXs1ntNoygJ1tn8i0ajP+IA
X-ME-Proxy: <xmx:Cg9Caslskc9AUkvG1NM_ayMG9vuQdp5sZh5rp_9fVfPjfWubS8VTjQ>
    <xmx:Cg9CakxluonKvDhpKZc9d-f8aHlVY0UxMEyAOKga2JqYZvvOlhocSQ>
    <xmx:Cg9CaslUBwNRGk5-Rwxvrb1Rh7DUWYDESUlGcU9v1QwB9Owk-JTA9w>
    <xmx:Cg9CaldiLDNtW7nWc2KddodhwjmHxDYBFX3G6Fi9GBVQyJqn2cW0HQ>
    <xmx:Cg9CavdBL737EfcVDBmFH7aL8oBFR2wish3ymU_MaAQopRV16TSxeWv1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 02:22:01 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ffa0339a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Jun 2026 06:21:59 +0000 (UTC)
Date: Mon, 29 Jun 2026 08:21:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] reftable: fix unlikely leak on API error
Message-ID: <akIPBJLtPqDjQt-A@pks.im>
References: <20260628090314.GA661068@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260628090314.GA661068@coredump.intra.peff.net>

On Sun, Jun 28, 2026 at 05:03:14AM -0400, Jeff King wrote:
> If the reftable writer sees a bogus block size, we return with
> REFTABLE_API_ERROR, leaking the reftable_writer struct we previously
> allocated. Originally this case was a BUG(), but it became a regular
> return in 445f9f4f35 (reftable: stop using `BUG()` in trivial cases,
> 2025-02-18).
> 
> We could obviously fix it by calling "reftable_free(wp)". But we can
> observe that we never use the allocated "wp" until after we've validated
> the input options. So let's just bump the allocation down. That fixes
> the leak, and I think makes the flow of the function more logical
> (we validate our inputs before doing any work).

Another alternative would be to create a common exit path where we free
the structure when we're about to return an error. But that might not
even be worth it.

> diff --git a/reftable/writer.c b/reftable/writer.c
> index 0133b64975..1bd4aa388b 100644
> --- a/reftable/writer.c
> +++ b/reftable/writer.c
> @@ -152,16 +152,16 @@ int reftable_writer_new(struct reftable_writer **out,
>  	struct reftable_write_options opts = {0};
>  	struct reftable_writer *wp;
>  
> -	wp = reftable_calloc(1, sizeof(*wp));
> -	if (!wp)
> -		return REFTABLE_OUT_OF_MEMORY_ERROR;
> -
>  	if (_opts)
>  		opts = *_opts;
>  	options_set_defaults(&opts);
>  	if (opts.block_size >= (1 << 24))
>  		return REFTABLE_API_ERROR;
>  
> +	wp = reftable_calloc(1, sizeof(*wp));
> +	if (!wp)
> +		return REFTABLE_OUT_OF_MEMORY_ERROR;
> +
>  	reftable_buf_init(&wp->block_writer_data.last_key);
>  	reftable_buf_init(&wp->last_key);
>  	reftable_buf_init(&wp->scratch);

Makes sense. There's another early return in this function, but there we
already know to free the writer.

Thanks!

Patrick

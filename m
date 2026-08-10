Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F941339368
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 05:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786338953; cv=none; b=KUUv/8vNHuKHfmRf68OIguPX7dyeb31ioi/1wqkPdlO820H/ZqcZyVUCCs0zUpDenx24Gl1ND42S5jHDe/uONjdpfXzz+5jEhRokMxzdBLerEp/elwMzE/rdMG4PyUO2nknpeFkbyis3ITIDujySSbtqFHgMiJAIJCD0MEzVkJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786338953; c=relaxed/simple;
	bh=Zx6ZgCZi+C88pMEFQCtO7LhF+nkPTkHgCyKwHe1iypI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K2bSdjecODBjyqtIJF3JplB0H4LagxNiflveqoArYA48kbjs5OWqxTo40Z0pGd7VtU3YJw7eYExZZ+zKOWIXips9B4VsKSf+/b8gfWzyL/NSEl3e4+lFGtMc4zyVUMJPPF21SnIC3JTlFBztQGP9QRvqDInEWl3BzCBhSGdH3sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eYIAbzfP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UH8jVk8a; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eYIAbzfP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UH8jVk8a"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C0B53140005F;
	Mon, 10 Aug 2026 01:15:50 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 10 Aug 2026 01:15:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786338950; x=1786425350; bh=lJ/94eW/Bl
	zfzg80zYO0lKDZpW14B4E7g133SjTGhcg=; b=eYIAbzfPOBipHQB5I0Hm30xj5l
	pt3qWkCvb70dZSH+Masjxz82EAuG/Laa18jahWiIbDObl9MbIUlKPuCAZTWBhkkV
	UCtlS4g9i4C38X3m60zCHN+UtSbPxhQwVFNq4/979neqEnfwz5CS4IzW7XNYPQti
	KlzIqhfCNVGHw4U0809YumGTkbQ4avy178ZRuro04u0dTIiRxpqAAZKda0BX265S
	mC0psbzZfkyj/mO+T9ruC5iHygBZvCTJUkoAhtPJ/ozjTGMxzk40YWmD+m1euOuF
	JSBMXrQUlkDKVZicmQWRjNqcr6uAXjoYmXEQIkNowXSv1/25kgNui/8mAySA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786338950; x=1786425350; bh=lJ/94eW/Blzfzg80zYO0lKDZpW14B4E7g13
	3SjTGhcg=; b=UH8jVk8a40pm/m88xCgsX2gtK18KmexWWnO/8078Mm+mutDXk6q
	l6S52A+y1aM0azMy699kKIPyHcadhpe8G4EsSikawHEf1cU2WzRm7IK/cEjfhogl
	kqClNp9YskZeBRfnTICB5kKloZT8vVsZ3a48iDMw+95frCMTy7wpQIDgSrojzSdQ
	9glrfZg0boE1aAY6Va0yQVPyrwBwv4pZhE/u5MGfas+vvxIXF2f+A2QmwBWhqS7n
	UGv9WWFk1lhlATolI6sKdn8ujv0rfjAGJnVowTOw7dRYNKOMHkhBUuS2xxZ/TeNr
	VhP7hDYK6+HazNrokR19np7yv/oRworg3sg==
X-ME-Sender: <xms:hl55akZbBhaWBA_WWxfUB04hNBC5g8beZC7G7Y59chwrPPqOrKDMAQ>
    <xme:hl55alZg0ceoInUSOFgfC10AfnmzyVK9A2F35QYdPR8EjWwCRPO9Bl-gGTYeHoLC9
    lDNjSpL3zmvBE95lLqUrFdB6k4qlDGAdxwFuD5Q5N9_jnMoEeKc>
X-ME-Received: <xmr:hl55ask-RMjMk4hel6K3YNLPA12NeWGwuuoKNeWLt4f--d1rnXgGOdEwBnVGx1tZVjPtJar5VMIyy-ouacjriKgx3AvmYrtSZ16rmwMZnQ>
X-ME-Proxy-Cause: dmFkZTGWVFP3PcYEuq0QyDQo+nAlZ+DQqsx3Lin0fKC8Dj7HYg2X0YgiUmpXN5pXGIPBMy
    NAYTshknin28qklMpGxPEs9eYsLh2mxi9KUrfxfHiG3PqY+B8Hu4cl4OIU5nWLAR2p/Cw/
    vZJ2wqa38k8WOxWH1gCdaBGSUQ+jrs/GXeGYp7MzicD+Ty1R/6lLyrEZkkCpKxqYs7j7M0
    MmQGWnqGJpDV4lx4QKeT3hMmrGjJ5sJTzX1N9NEoF0RAQtvrrZkFLoR7emhj9YSh4FRyuw
    6AF/aGFtoy908UoyFbn/p2vQUEQuTBTT0Jcc4VPYUi+YIz+Qh0SxyOGccDsCdh2JPHxnZy
    ZkK/lB1XhddBAuffAH/3vqRBwbzm/yLKYoDrLxoC5yiWBKHxd/u0h5FVOj/csbcpnbWOhW
    CZlwQSO9BSetXWTWuSuFEsVSnpuqXdi5XkaMULy+PNVZhi2fNB5n6W0xF0bmpY/fSTFoMX
    6KnV02etkwUVuHtxd0q/z97+igtAdZ6EoR+pjuyKbbB5pPo9kfeOA2Chb272yieLsk9rH2
    ezb97XMz9+oLPfOSGTzcC/4x72BBgtJp990MbwY8qlJ3FAMwy0w3KdyjxfzJsF+bTv1FPu
    GAdQ0Y7imoheqWAlttMPiKmsG0d/qXx2L6i725EQd/3D/sERoEPTgvlKr+Jg
X-ME-Proxy: <xmx:hl55apyanexSHr9X_PObRndAKqFOzTjPzyo-DYw1mnWS5I-z1mUeLw>
    <xmx:hl55aiN6mRFRvUJAGqmLRJKunADmrYRNfbxV4j41_UWm8irPHJ6byw>
    <xmx:hl55alRe8PG4qpWlI-Mi-t5eybmUl1Zi0FcI5YBWvGv_O5Hvb8ZNgg>
    <xmx:hl55aoZUHKGJUtD7MCsGXe2cf9awxVE2NjyeAJeRgEyxkKCb-jm8AA>
    <xmx:hl55aqIaE66nkMclDzO75xvkMPYDAffnlvDFRuYZKdSF0Ht5BmijnNWi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Aug 2026 01:15:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4f8b1a84 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 10 Aug 2026 05:15:49 +0000 (UTC)
Date: Mon, 10 Aug 2026 07:15:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 3/7] builtin/receive-pack: read unpack limit config
 lazily
Message-ID: <anlegs6zfUysbx0C@pks.im>
References: <20260806213859.816157-1-jltobler@gmail.com>
 <20260809190106.1565882-1-jltobler@gmail.com>
 <20260809190106.1565882-4-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260809190106.1565882-4-jltobler@gmail.com>

On Sun, Aug 09, 2026 at 02:01:02PM -0500, Justin Tobler wrote:
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 78d2911c00..5264d70467 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -2333,6 +2320,30 @@ static void push_header_arg(struct strvec *args, struct pack_header *hdr)
>  		     ntohl(hdr->hdr_version), ntohl(hdr->hdr_entries));
>  }
>  
> +static int get_unpack_limit(struct repository *repo)

Shouldn't the function return `unsigned int`? We always expect it to be
a positiv value, and in the final commit we have to add a cast because
of that.

> +{
> +	static int limit = -1;

Is it really necessary to have this be a static variable? As far as I
can see we'd only call `unpack()` once. Also, the cache would become
stale if we ever tried to read the limit for multiple different repos.

> +	if (limit < 0) {
> +		int receive_limit = -1;
> +		int transfer_limit = -1;
> +
> +		repo_config_get_int(repo, "receive.unpacklimit",
> +				    &receive_limit);
> +		repo_config_get_int(repo, "transfer.unpacklimit",
> +				    &transfer_limit);
> +
> +		if (receive_limit >= 0)
> +			limit = receive_limit;
> +		else if (transfer_limit >= 0)
> +			limit = transfer_limit;
> +		else
> +			limit = 100;
> +	}
> +
> +	return limit;
> +}

So how about something like this instead?

	static unsigned int get_unpack_limit(struct repository *repo)
	{
		unsigned int limit = 100;
		if (!repo_config_get_uint(repo, "receive.unpacklimit", &receive_limit) ||
		    !repo_config_get_uint(repo, "receive.unpacklimit", &receive_limit))
			/* do nothing */;
		return limit;
	}

Patrick

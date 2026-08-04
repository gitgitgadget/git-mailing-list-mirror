Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7F8431A57
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 20:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785876019; cv=none; b=sD8e9bqFo8Zr/Wzpb5xMCIyE7Rb0KvoT2Vsu9sAr3sMSY6idXfPdv4iVt5dKjzxgDrZ5Q/4ycThoIuZSuyHSNARZMTRJxKRz4cEw8F9rep5nF1i7t9+te0TWjkZlJEQKgMACwTZnHarlKUwhM8jd0aLCfce7VMN5fZsaCbGghcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785876019; c=relaxed/simple;
	bh=k/x04YAny7xYFq8aLXsEWjHcH5HYVTW077xWSPTxxbo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WAvapWdwgpLQsxND0L5usiDlvfJv6hNDpjP92PsrLQJx8M+Vf+/qwYLsxblRcRGzNk43KAjS5ZSiQTNbSqfbQGHt5VAODZwJWb6RJSdFSlr62XhGwGXgZal7YJnLdUMsvBGFNTekyDZNdzhpaFR+hVwW30F7s41dq+tkKMvp7KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=S29Secf+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VNPnmqNq; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="S29Secf+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VNPnmqNq"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 87BEB14000EC;
	Tue,  4 Aug 2026 16:40:13 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 04 Aug 2026 16:40:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1785876013; x=1785962413; bh=8nyroDYXeC
	kcyhs9Xqj8gDsbNkywch7xjjpOllwbLQU=; b=S29Secf+84JkqFegFyHJ5fUtq9
	PhUZJwAKrRDp7fd0Goq4mnDaGh49wXUOqMQf74tJG0yRL2WwOqI4ydIeUJ98hGsr
	7yeen4/05lt8tF3MCSotBW7Pt+FzEVclw32KiHtQF1HNDCxva2FYndHiF+KTmFbG
	3cRfmHveOE8hGW2aBd4quE+b+OyoXdbYXK0MVyZFuXvbnJCyBtJhWhc3v71zQ/0g
	zCLbv9dUNxR+n0NvB3UgEgUwdMGH5fD6u2ElcSC6T+qdFia43E3CI0Q9DGTZOS6B
	v7kua0AxOgokmAe90BwIyUVb3uKgSpOzmy2Yv+S7hyN293bJDZLWAQJJ6/lQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785876013; x=1785962413; bh=8nyroDYXeCkcyhs9Xqj8gDsbNkywch7xjjp
	OllwbLQU=; b=VNPnmqNqsXegZRYIvas1VU2knYuEO8AB9vJcTS3P9lwXdfeuwLT
	zOscNvgWaJn77cEtdE6h316kHh0ccMd6n+dPTMrAwn+E8AOYUdAFHS1N+v3DrLXQ
	KjgYs3NM7vzBNgiWdKAzYxLLj+8aJpIIVlTyzHw+ISIG+udFs928mXZ0FWVpxNCH
	Ly2SjByaZoi9PpugZPYdCbb57VqoYTIyFEAHcVZVGatJs3T1Lwqn4PRALrRLBToq
	+lJ2JPZ64UD4zXwc2MQRQvTohhrSDhcbODJKCKpgfV/qGQvc+5Epcmu/T32HzQQC
	nOMGU4bYU8nrHA8+pykhGWU63/672N6kBMw==
X-ME-Sender: <xms:LU5yasY4Njv3cxjvl1uELSzlBczFYDIdzAyLlO3JId-EImsOARschQ>
    <xme:LU5yarFREe-DJqwqtvw_B-NcO5L6jRqRMP9xA5YaEEtRY_ojHt1aKGC9uXnW-AS9P
    q_PEjOuihoUGAUs4z-9eh6T7ULEbHkRfbzBko-h9nz6vd4VtcPz2G8>
X-ME-Received: <xmr:LU5yagwptG8RRU9qGkQtgkKY6db1Nz_jDZSGYGpT1qM5Sya1kNh6Lwni9RJmpvvWawZYukB3Z-loT-Sbh644fwlb1ocoSik2PA>
X-ME-Proxy-Cause: dmFkZTEHyByB66VMz17eShDFcFw0aqybwDwbKaaquRsxituPG696jwoa2MUK1tvDY8T1/7
    Kw1uA9tJ8iU7qUBqOxL7KFdY97voeA7tGP4vI/hGeH3ipp2ur47HkEszarTa44g3Sxbjvu
    H52RqVvCbPjaAbv3qfwMuQCGxuZ4BlP/ALI0UB6drV7hso1s0FSj+PtC7KluD4ghSONN1d
    k89qSnghDMnhSIYuRyg72jt7lroBpiXUj3bDVC2Rylt6FauXxRdUoSMMytVdDXH5ijkSm5
    PBDTJxhnXV/XiyOYSQx4VPq3XQIs53FsIZ6BHgejDq2MITRaUs1Xa6ieDgblfHV9Zphyc0
    SeoLYIlr52P+f385LVYje6FKacsaXz8QPaTm943iAo3JkoBY6EFIcKKztPxCJJlSMq0BSB
    ma+6QQ+trRfdPQEQch/H1W+ZCEft/bfwMD4OB/lpirsPgv58Kj5nGqgLEMjPa019CU3iSh
    DsoBR0QHtz9bPuaNvVkP1qVAcgeIyJEJjdeRu0rHqSXR3eiL8k4AwhQNjW7p/tCnSjWkul
    XmmCVVghCfnHM4vZFjeAPF+6RUiWcCEtbIrIPOZd48rMIFSwF7yJeIbupo2yJv4XI0WzJQ
    a+4AS0vgCPRs3uBGzK+BPLDc2Cd/YYP6a5enF1iXla5/AjlFZVDocbTn7THQ
X-ME-Proxy: <xmx:LU5yatmxk4_DReteOaZcAcobgaHZ37rzaAPYZ5bhA_Kn0_0ufY9HEQ>
    <xmx:LU5yapl-LVz4DvC7LvGYxyucN1Y5s4SZopmmlf7367ivIO_HAFZtJA>
    <xmx:LU5yavx7WBFna1NMb1g4pCYjDJ9_LsKR9lqA1K3fAOnh1Q_zXY0ANw>
    <xmx:LU5yauqoacQ_epIbs8po47gVgxhVDqfMEE4GM0FloNWs35z-YpX59A>
    <xmx:LU5yamIuCnopor8kRm1EmtlLPMTwN5A2Ha9Xg-kBoTDr1cIl7Uutw8ch>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Aug 2026 16:40:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org,  chandrapratap3519@gmail.com,
  karthik.188@gmail.com,  peff@peff.net
Subject: Re: [PATCH GSoC v4 2/9] fetch-object-info: detect malformed server
 responses
In-Reply-To: <20260804-objecttype-support-v4-2-31511b0231be@gmail.com> (Pablo
	Sabater's message of "Tue, 04 Aug 2026 20:42:56 +0200")
References: <20260804-objecttype-support-v4-0-31511b0231be@gmail.com>
	<20260804-objecttype-support-v4-2-31511b0231be@gmail.com>
Date: Tue, 04 Aug 2026 13:40:11 -0700
Message-ID: <xmqqpkzxtyac.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pablo Sabater <pabloosabaterr@gmail.com> writes:

> The loop reading the object-info response stops as soon as the reader
> returns something other than PACKET_READ_NORMAL, or once it has read as
> many lines as we requested. Neither end is checked.
>
> A server that answers with fewer objects leaves the end of the result
> arrays empty, and the caller trusts that every requested object was
> filled in. A server that answers with more leaves the extra packets
> unread. On stateless transports check_stateless_delimiter() notices, but
> on the others it passes unnoticed.
>
> Check both limits by extracting the packet_reader_read() from the loop
> condition, so the loop no longer consumes the last packet (flush). If
> while looping the read is different from a PACKET_READ_NORMAL, die()
> meaning there are fewer objects than expected. After iterating, we only
> expect a flush, so if the last packet is not a flush, die().

OK.

After looking at "if (i != oids->nr)" now gone from the end of the
function, but before looking at how the loop terminates its
iterations, I wondered how the "there are too few" detection went.
It now not just stops iterating when seeing a status other than
PACKET_READ_NORMAL, but it actively barfs by dying, to detect a
short read.  So the only thing we need to check after the loop is if
we are truly at the end of the "list of oids->nr things".

Makes sense.

> Helped-by: Junio C Hamano <gitster@pobox.com>
> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
> Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
> ---
>  fetch-object-info.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/fetch-object-info.c b/fetch-object-info.c
> index ba7e179c44..c2d4bf9403 100644
> --- a/fetch-object-info.c
> +++ b/fetch-object-info.c
> @@ -106,12 +106,13 @@ int fetch_object_info(const enum protocol_version version, struct object_info_ar
>  		}
>  	}
>  
> -	for (size_t i = 0;
> -	     packet_reader_read(reader) == PACKET_READ_NORMAL &&
> -	     i < args->oids->nr;
> -	     i++) {
> +	for (size_t i = 0; i < args->oids->nr; i++) {
>  		struct string_list object_info_values = STRING_LIST_INIT_DUP;
>  
> +		if (packet_reader_read(reader) != PACKET_READ_NORMAL)
> +			die(_("object-info: expected %" PRIuMAX " objects, got %" PRIuMAX),
> +			    (uintmax_t)args->oids->nr, (uintmax_t)i);
> +
>  		string_list_split(&object_info_values, reader->line, " ", -1);
>  
>  		if (strcmp(object_info_values.items[0].string,
> @@ -150,6 +151,11 @@ int fetch_object_info(const enum protocol_version version, struct object_info_ar
>  
>  		string_list_clear(&object_info_values, 0);
>  	}
> +
> +	if (packet_reader_read(reader) != PACKET_READ_FLUSH)
> +		die(_("object-info: expected flush after %"PRIuMAX" objects"),
> +		    (uintmax_t)args->oids->nr);
> +
>  	check_stateless_delimiter(stateless_rpc, reader, "stateless delimiter expected");
>  
>  	return 0;

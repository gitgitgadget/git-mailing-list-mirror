Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4815B3346BE
	for <git@vger.kernel.org>; Sun,  2 Aug 2026 22:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785710168; cv=none; b=cEPc4NkRQ9rsWh8e/0/sq8LxZgKeSD3WujxAYQRCzVA1nVijAJCvPgBSYSya8iQF/3Bz296RO/qh/JJCF/1L7m9CeUw6GHPu0DK/eyOuRAppBcb411y2mxuryDIxKDfXhy5l1sf45nggfRQh+4Wi0Mb9ZyTQfWxdn6AfKIQ5X68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785710168; c=relaxed/simple;
	bh=o0ThFZCggaRj+jTd3lfEgRIJ4NNN0Xw5qd0HArSZyPg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MGjz8l3Wp8B9cyP0J7HPP4zMjfp/1GRMvVApEtRJF1KIbmqnt9XW+k/S5RiQ3X43eH1CiAl35ceGuvb2llLMxbVP8DalbS5gq1tyjCkYkR221pGNql3m/qmBGmHGS60KQemaDd1UUOGs3Y7gHAC9Cv0EGaev+Az9QrvrXY4EdO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=sd/4wcbC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bdzkrNsS; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="sd/4wcbC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bdzkrNsS"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7579D7A0078;
	Sun,  2 Aug 2026 18:36:05 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Sun, 02 Aug 2026 18:36:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785710165;
	 x=1785796565; bh=M7Dc8GujBj85PtZxuWEvMQc7vLRrqPMy/ifrnTckJGU=; b=
	sd/4wcbCgqmh9RVnZvs+ctQGCMP8BCO9Eb0GSjQKbcwpceUQpkxQYV4VDcM8qHvI
	nNr3LwWV/vwVSQiwQ/9iApabJRvN5zVNFdh//6+ShCscpnJn1JmY3zBEdgo+k5Mc
	yh55Rw0xUR/Oq7WGTHQOHewnFZdI7+P4c2ys2iYvh0idXMadO/4HspKlpFCuiwZz
	KRWEksXrLAUJmdR5euRqTCcyuQH3Shk+T3QKr/QWbJzx/X/HYnn2D59pUGNdi3K6
	XKHPNkXWlQNNvQZGPXGho1Wa/x5UWqEf+pQDnll+6WMFtfRwTQ7Z52qvExZ7FxiR
	5JVu2kulZhsa+7RWU1we6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785710165; x=
	1785796565; bh=M7Dc8GujBj85PtZxuWEvMQc7vLRrqPMy/ifrnTckJGU=; b=b
	dzkrNsSGoyNnuQKY3KZ/s2/sP8RMSot90v5baib8bOqHeaX1uwYSZpfDEvSZ9Yzs
	eRc24xZdeVMqtSvVmSr6dkIXXGnh0MB7j2ardd0qn5rlxIZUhmHoS4+PmAimSjy0
	jGVq+eFggKlBxpIvHUO8NEPrcIe2qHRro7aOy6V785MFS5PwkghTmH0pA0dMTreI
	a0Nhswbq8FbxE4EEL7qYyGLD/u2JMbDXi+4iEgBpN64ZqvUKvM8mWe5gFdMuMVZW
	vV9MKPIGs7Sb92Wbrs3XBGPtJCs/q/1UaF3OzyBgpaSvgY/O/nVFw0Fa8Ag5afRb
	yO4inungnhzPF/ja2JSMA==
X-ME-Sender: <xms:VcZvaldhsmae91A4E9y4C1ndjvay5J5dVfGlRI8Tc_Btjfv9ecCPpg>
    <xme:VcZvaqGCyEbDvbVG9HFARD8OQmKBFH1_HhMwcTlm5xOlARsZqe66p6sca4GpKMEiH
    k0lHxDMJXUQD4VMo0NVokvkm5ijl5-4XXrtiJNrCww63P-5ZcXtQs8>
X-ME-Received: <xmr:VcZvam3XOvYGWh0DBG48bm8bXmoMtveKGAZEXDBvbaMMslNpwUgeQ8HHnD-RvR9CPKAU3o9wLIZw7iRoDhnQx_AP2oZLy1wXNQ>
X-ME-Proxy-Cause: dmFkZTGliHuygxotQP9M269HzEINuBao3VBijk06do7QARTwMcZ/rbzh4EsH6d+fZmUdnT
    kn3EMQ33B8SzWhXpcOcB2g0jD8eKJAViJikE+NQbQB8MpT96w9HSe/PXC7QT1Mblk5fbi/
    R7RltpfA6Ia4NuOZXpB5gWLkozJzTiSa6UsRV4pH7v6DRN2zA+roU619WzemGW9j+pVtZ9
    3bcTtVAPdE6zk/2GHQQVQHbGocz91qGB0dZuryPcU9AXSdJe0ksiMkG0gxMito4B4KlB4c
    Z7bwJsX/bt3UytDJCMyttlNpsy6SUdBDupBL1VOXCIMyGmt//t49Coa+rOf6CPFESb/aaO
    y1/ICe+bujjQ96jhLC1o+L/InouIFfhy3WkNSF/y9v5R2sAXNHOYZyZDifGJ76H9zRSwyp
    QzMuvIeLmcRTFj6iG2ZlsL8PE8IWTHKN4+/IIp0Hf+lMQIN6FV5ToqftUFqB5PRV27qVVx
    ukBNV7O9KkMUpUTHS6NQFogLi8XFQh/g8Z5Y4o8UZGnWF5JtFWvswMOTnGhURz1hDzaGbz
    xMuud1HjRF6C1SmaK9JwyqOc/MIl+5N0XIqeDICw7pdaeHscyCIHPKrbprzktheYaq4dv+
    UNIzv2FcRbRKoz8N/ZJPN17pgiH2yt0p9LZp0q3JNeeJZ2bPKEGlk6yjdQ+g
X-ME-Proxy: <xmx:VcZvaqnRtljF-RXEx6JbMEEhUmUDEYiy2sJV6Jymcp9FRRAULhbbkw>
    <xmx:VcZvau_XFhEKxyFcDNlBGsejC_SeoifuWkm9udlDKvfeViq6hWxEMw>
    <xmx:VcZvanoECyPZy5C9hLMWRsCikUInk9RgCRcwb_d2kcmCbSt2tdq-2w>
    <xmx:VcZvavnLZxTsBCsxRNq_FHBNQnvOJ5s87aHGt2e1UudWQPSX-vRSyw>
    <xmx:VcZvapPnFbKIMiGl5l3d4QtxhPItIlzQXmv2gcTbjZZAH9JLIddLoi7A>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 2 Aug 2026 18:36:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,  Jeff
 King <peff@peff.net>
Subject: Re: [PATCH] trailers: stop recognizing URLs as trailers
In-Reply-To: <URLs_not_trailers.b13@msgid.xyz>
	(kristofferhaugsbakk@fastmail.com's message of "Sun, 2 Aug 2026
	21:57:17 +0200")
References: <20260609004340.GF358144@coredump.intra.peff.net>
	<URLs_not_trailers.b13@msgid.xyz>
Date: Sun, 02 Aug 2026 15:36:03 -0700
Message-ID: <xmqqmrv42lrg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

kristofferhaugsbakk@fastmail.com writes:

> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> An HTTPS URL starts with an alphanumeric scheme followed by a colon.
> That means that they will be recognized as trailers in a trailer block.
> That turns out to be a problem in practice. Let’s stop recognizing these
> as trailers by failing the trailer parsing when we:
>
> 1. find the separator;
> 2. the separator and the next two characters form `://`; and
> 3. we haven’t parsed any whitespace yet.

When I read the problem description, I would have expected you to
say "If we find <token>: at the beginning of the line, check <token>
against known URL schemes like https, ftp, etc. and declare that the
line is not a trailer, if it matches".  Checking against "://" is
much more robust, as it is less likely to happen in random text, and
we avoid maintaining a whitelist of scheme names.  You are certainly
smarter than I am ;-).

Shouldn't we restrict the token preceding "://" more strictly than
simply prohibiting whitespace?

> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---

> diff --git a/trailer.c b/trailer.c
> index 6d8ec7fa8d8..971ae459596 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -635,8 +635,13 @@ static ssize_t find_separator(const char *line, const char *separators)
>  	int whitespace_found = 0;
>  	const char *c;
>  	for (c = line; *c; c++) {
> -		if (strchr(separators, *c))
> +		if (strchr(separators, *c)) {
> +			/* avoid accidental URL matches (://) */
> +			if (*c == ':' && c[1] == '/' && c[2] == '/' &&

How do we know the references to c[1] and c[2] do not access an
unmapped piece of memory?  The answer is that line[] is NUL
terminated, so c[0] == ':' guarantees that c[1] is safe to read and
unless it is NUL (and c[1] =='/' certainly means it is not NUL),
c[2] is safe to read.

OK.  Makes sense to me.

Thanks.

> +			    !whitespace_found)
> +				return -1;
>  			return c - line;
> +		}
>  		if (!whitespace_found && (isalnum(*c) || *c == '-'))
>  			continue;
>  		if (c != line && (*c == ' ' || *c == '\t')) {

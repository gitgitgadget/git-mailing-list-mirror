Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACDA3E92A5
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 08:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792139927; cv=none; b=LWFUdq844kHgSDP3A2ILzw+BVkTQNxlhHqAUGOTs4eeUZOLvsTBVAduxTZbts9KT6lFoCs9aNufsMqs2JaDXrS7/8DUiJRVM7h2oMxtJiwOmTYRFY/0F9AbkgFPHj6xwQJfN1bxN7HpMpAxvemfVlbzsas5tLPzC55QTHj2zyZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792139927; c=relaxed/simple;
	bh=UF7v2EOHCG/rpbamV7J2RAn28A1rdM59EkAG8rmO7lM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WWbAD+Ym107/Wm9sSFHJwea1DlQiYQQe9U6DMNXRNhpwxXMuWtPRvkKPtzUhHGNrmRYK+sxN7IzaiuNRoaOpp7+zs2K3rPx+nJDktiswfSbUQDsU0qS8n+mZAHO9vchz9iZjkWeo0X2lwn7Y1FzqkyBQYudnnib+CGLEPX00NrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QFCTeaUF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E1fW7J5p; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QFCTeaUF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E1fW7J5p"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 771FE1400042
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 04:38:45 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 16 Oct 2026 04:38:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792139925; x=1792226325; bh=aFI4kEUp1O
	Jzk30NlV9x1yaSUGkR9IElrEClxnb1KOc=; b=QFCTeaUF8xcKw6VqSuqPPchnrk
	CBMhmvHARS4nllMEhIXBd9KjupyFul3uL+nC1lG5HpqLgi0QfStwTd3xCz86DW8o
	7XrFuu5OuMCflcmarDWJNuPw+iQTDXbkp1HJFMwQeLsvWHRwJ3Wx4hp9sKqXDT7w
	jk188wVXMkve59dZi9h5T8QEqqPoOmOXdz4gJrinAvPrwo+Xz8Dv1e8bXqIILUlo
	gRsyoXLvnT5oKytY160z5uduzq8a7bprlcfmUKflZYGF6qpLcNI9VQ5izFBkIo97
	jyDmHG/dMz5PhLsHeW+8q1RI1XJRhKfF1LpZsl16+KVJfiU8pMyFDBenb2Pw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792139925; x=1792226325; bh=aFI4kEUp1OJzk30NlV9x1yaSUGkR9IElrEC
	lxnb1KOc=; b=E1fW7J5pwA9/fmyWUvsyV67X6e/R6vYiToANy3i2w/g2nYNqViu
	2oRamOQH0cX0HZO5ATNQMU5vRzTh/27MARBxNUVxD89hu/tkCN153hlLu00PTDlO
	OhIhYd+Xx5TD3Vf1uOYv6KT0YF4yPAcFVB/2CtIWQOXicRrVbpDbb5TwQ31d3dNd
	9kLM/1F76p4H2HERVGVNGDvCQ4vEsaI32DyHLs7PFmnRBPsT4BNa90RYNFMr3y1R
	JhU4UaoKd20qq93vmMh8Vi7wTEiHE1RPIW6iMPX1Mzy8H+xorfeis8woHwWQZrO7
	Ber2DUthN6SiEprtFuKSg+6yMCwv7uLHT+g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792139925; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:focsOlI9JM2sVLG+SHPm/z7s/WL7s8fsEwjtjVAfU2CHV5n
	weRX9xXBLXh38Ozqmwk+3pzrW/SQDunLtdMVkUU6v+zpAYH8aFFsF6eEMq+qsyHa
	aMGdgiSv7pbYPqnoRl8CHgBxIH0pd3vEgNY8mjsGSEPRbHYnmr1xRVo7KFYpQw0s
	0rbNiCS1cic7k7EJu7XcCF6VQlUG6TZREtN5J+61kR4C5ID5G42Mm0S+ZNUWTJcZ
	MN4Learu+CIGbjOqWgtQu+pDgX7uT5GkkmnvvUxDHzjGt7HBN51He/B5QL65+Hax
	ESV8XcFmBdDeLWe7EOQi/lBES5CSKNKks6UftDQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Q8QjKFySqnsEC1jafFw3DEwZSJevhFUZI72bVbxqq0Q=:UF7v2EOHCG/rpbamV7J2RAn28A1rdM59EkAG8rmO7lM=;
X-ME-Sender: <xms:leLRasK_fKqjcDqqTjEC8oSsPOOCWpX_SCbDs0DupDSk8H0jfqDPaA>
    <xme:leLRajnpD2Af80AFfsxMtpk0SSEsBqnw6gGIlh417Z71IBj6WuyIrg3pDKmVBHO3A
    dPYBmm24kwThmCPdiPdn8rjlfUEJVltuii6_N3DNtje8yEM8Q0LpvE>
X-ME-Received: <xmr:leLRaqGLWdV7grXRDytkiIwKb9q_S3-B_8fuyZzUJ_r-_TjGfVAsbQ>
X-ME-Proxy-Cause: dmFkZTF6rNE5iOwk5rXI/cqNsH/4LUlpNtx5e71IQKHhaAhUk9qWj/uQR3Qwn60IbH54V4
    FJ+rN7YY7jlQENP1yVq5PZcEHNX7ZjKNUYafhX+kY5JrIXE0/mzrotOvp1B25q9L05elMg
    qJ7jhynwPxh+4yv4MaZaX+gyWFB3LvIwUmHqhQ0jjzirFV5gjx9MHRhKcqH1beMlMoE3OG
    Xw8gzVGxLDCWikZWUiLumhxGI1sPY00kayINe3CDU4QDsA0BUoWkitWaGOyo9E+3NVF9ia
    nePsA3EM8RM1rg3hSI6p3eL86fkFXkBI9Q2F/aCxoDT3tycBUhavfUCDrc0zVrslwm71Lp
    YU/F9IkbR1JrLaGkqv0iKfbg94ctMGKphuUOywdx1sPK93LofCmVfK7pIPkB4bi2VTJTji
    cmOVoGb20SEe/5h9l73YWi9Ay9zn4njat61vtresYFwhoWRc2rIx72LxAnvUMEhkuBxwgl
    ev84MoQiaDNqvPIICcj627gExApjffiVUrkrkSGyjE0thXuZRO4cw5dpHfU4gp8VL1aewz
    3h0CHkV6cNAPFQzXeNepXFTd0x2mNqTgJDJOXjhF7nhVqdAlIi3Y1eIPkg0tWQk2x2iMu/
    iPjL3dYPbmNB+DqQLCeSkjTePdZpnhzU4k+ZxsYOgkRZ0Xstl/5M1Ivz5gzQ
X-ME-Proxy: <xmx:leLRajGdyYls-Pmr9zsoIPk2AziPli5Ne-6_s_KgUNrCEOjkj9yD6g>
    <xmx:leLRanNvn5-GDOtLNgUMUJs1D7Iw7qXM72RGaSbHjESZTzpo3C2OBw>
    <xmx:leLRaiFHmbdrGDT_6guVYlRiLtIE_o209FgxFdTgmDWHfukLDNLLRQ>
    <xmx:leLRauP4aYBUTabuIQIbMVFpupLj-Hp4GAaR9uY_WSxvt-HKaw_4og>
    <xmx:leLRaiGVKr9xRUAYVKGR867MZN4aIkpqL2iZg2_6yMXX2-WOgln8e7ZL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Oct 2026 04:38:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4e1b7cf1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 16 Oct 2026 08:38:43 +0000 (UTC)
Date: Fri, 16 Oct 2026 10:38:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/5] http: use `size_t` for byte position in
 fwrite_sha1_file
Message-ID: <atHiiye4oi_lF5FP@pks.im>
References: <pull.2253.git.1791958171.gitgitgadget@gmail.com>
 <70a909de18e8cd8d282439fb51a9399baa8c7be8.1791958171.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70a909de18e8cd8d282439fb51a9399baa8c7be8.1791958171.git.gitgitgadget@gmail.com>

On Wed, Oct 14, 2026 at 06:09:28AM +0000, Johannes Schindelin via GitGitGadget wrote:
> diff --git a/http.c b/http.c
> index 4af3c29c76..809471f436 100644
> --- a/http.c
> +++ b/http.c
> @@ -2848,7 +2848,7 @@ static size_t fwrite_sha1_file(char *ptr, size_t eltsize, size_t nmemb,
>  {
>  	unsigned char expn[4096];
>  	size_t size = eltsize * nmemb;
> -	int posn = 0;
> +	size_t posn = 0;
>  	struct http_object_request *freq = data;
>  	struct active_request_slot *slot = freq->slot;

Right. This is how we access the variable:

	do {
		ssize_t retval = xwrite(freq->localfile,
					(char *) ptr + posn, size - posn);
		if (retval < 0)
			return posn / eltsize;
		posn += retval;
	} while (posn < size);

So it's clear that it doesn't have to be signed either, as we only ever
add positive values to it.

Patrick

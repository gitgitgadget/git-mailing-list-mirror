Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CD835950
	for <git@vger.kernel.org>; Sun, 28 Jun 2026 01:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782611680; cv=none; b=u1esnZQUbXEhixITF6A4sCG+dYAwm2SZqYtdTXBWgyEg3hQZ6xEUlzUWZkuNgt1SIORzC8BVIwrtMTAWYfEn6uqvV1BA3kkXh/2SdGV27/XESWnc+nQ+jPLPrs9DkaUtkoZ7zRErFcjIc4/NLgu+db1/usZHD7tEOF6l216YEyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782611680; c=relaxed/simple;
	bh=Xwb60vMaf7WwNBCUD1J/SFdRhnaqwKvjUfIntJVUB34=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZcYTLYw/LR/wPpseOPrGs/qA8Cd+WBo1ARsnAbDjDLYa9I74chGU+XLKsyw9mHgNOZqIUsgz5b4WH4fftFp5lNxaXwQtSimLcPDxC0tssfnyllfPrtDWoYKj9c9+kmKf/ecytmmspQZogT7S59HVO7O9oDG7lXMbQED1NAXOUCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EFM9GYuD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fG0ded6S; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EFM9GYuD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fG0ded6S"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6C9EA14000AE;
	Sat, 27 Jun 2026 21:54:38 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Sat, 27 Jun 2026 21:54:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782611678; x=1782698078; bh=KVcXBJTcc1
	JaJJgwoa1jeH83pnMozg6c/pDsaWIQLeU=; b=EFM9GYuDdocvY7fZkY620leZYs
	bq2z2ghnqIgxjIAEJ2a6F7SsQ5CKeGpSRhCL3eCvsSlFdeOaQNjOlHSWnuIqa4oO
	Jorkn/HV/+7VA861+NKtzY/3iapJ3k6JtXj0IkzkQrIgrcm9sR2yB6gi8/bBZ2qJ
	kgMj/zfGHk6rzciLwJ9T/mUgE1EwUNkrK6FSC8ssqy02H9SwtXkV1g46c0Rxkft/
	72swF9vnO3Iv+VCL4KiHf3namSMoGboa/h12JzhF1iP9gOVXHy6FVDl1DNRqOCXB
	DRePX9h2Ax3qfl75PEDyLD28qcm/6gQHaL+B+ICI4vuOMVzYzH1mUxkbqp/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782611678; x=1782698078; bh=KVcXBJTcc1JaJJgwoa1jeH83pnMozg6c/pD
	saWIQLeU=; b=fG0ded6S5Ip7WirAjy2jNCnRNBOKSMf5smP+EW0O46GY77IyFtN
	KvN6dWT5Sb47hzcO7nV4p8s/FzulQ65newKRSllp367AbRUiVOneE+k28sELgZy6
	OuZ1Vtve/H3YWq5+9oN7YdpWPA6u8euJowmsyp2lwc8azLUholrniuDOYaYf31vR
	gfQ2fWucR/MlBbaMWiiN6JtO3T3fDRXGlqZGIxaAabT4dIPbeVXGIi1eD6Sppf/s
	3WrU26Kk6a8qODK9wEBou1A0Qq8Z8czBOurJb/kTkB+lq7s5y7Dy1JBkS99sZ2oZ
	u7TLEYU7eskOaDKVgD51srJAcLnRBud5hhg==
X-ME-Sender: <xms:3n5AapaqHzSBI29BlMRRP56G3XVBAjMCpHGCzBnDWJQtgiovF2VQEw>
    <xme:3n5AanRMMxZPBrcq4I3hmEkjpCrDQoF3-6Th_wFD2qjrDUT6Zquh_Wya4EipLzPuC
    ZbKi8ccY93J9lF5kd7-fNTDLeobNgOJ5nFEr13zT9SNcbQLXYh9PDc>
X-ME-Received: <xmr:3n5AakRYikBVUG3WM6X0JSMH6fNlA6ugIp1mCN5YxaYhGgYtgCPLORulhEAZWaBE1Om005iukptvmiFX8mUrr1RLpGZewXwrPTBVOuU>
X-ME-Proxy-Cause: dmFkZTFfivGYPwLvImrit12BxsWxQ0o+N7Xxw02Lw87XLGdz8QRLHe6aGPimHw4cO4dGRm
    YuwYJ3TvIU21+zeN9pG03gmoL8HXfuatlYKL/MiYqSyYc5MvEGcz2fu5hb9O2xb44dyS0X
    h/UO5rvlb333Kuzkw66HaXqIJeB10ml+KcEOKc5o9fABnYINzq4ylRE0teGKS33E9YoUWx
    CKCESZnNE0vy7YFndYCgZ3WZmjnd+EmqPgeZZ8JRaBta48hhDsp6LJjOKP16hi3CsaV4E4
    96sjdjVUJ+y6EQ8PONO6K8Qlet8rHzZPH96b5h5QqdKGveIxDh0aoydNvs/ifDtxJEcgfr
    CABRs90E6tc1mBqQ+w/S9ZOfUG3xH0mkV8+929faH+hv99Em18ERggCS1FBfHxjsZrZLCv
    4uDXjAmi+9p1lLqbQ2vHTx1bLtx0z3wBku7e093/Umx5LAg5vmrJ2BGs9+aR1z8YzL6ugM
    +U679Z8aqNKzpvTC+oQp+PXeuLYdQtIwChtgtZEOnGJkeptWioFFatItTUTxG6RDBC3mVn
    POqC3JOcJvZOQczMXh5qYvQnKn+FfJKBPIlC+AoUEEcnllOtURs6Fh1FKdxmiVP3ppNmSg
    pQ1wKz5+TCVMgYO9aMCXTwlzsZlhXGlbLb6w+cI2+cdHNYWa13f0pk0xyagw
X-ME-Proxy: <xmx:3n5AajTXhaIAyMWXI0W0a9QZ6FCqpreiDeVhDO-I3i3aJrXtWPRtkQ>
    <xmx:3n5Aah4WWyNN9-SgDuCsGuiPbAsxTrfvTJwHmSEy68lb5PixMhdYYA>
    <xmx:3n5Aan24S0-Ar_OBXydhGW2bfNhsn2O9wMeHvKoHTddueE1qC64pTQ>
    <xmx:3n5AakAjc5oyXy-aeMr4gefPFX_Lq2somwbV1tEKBdCBXSfSr0rSVA>
    <xmx:3n5Aapq_-6qh32LwBbCp6_tn4itdpysBlaBXJcG1olx7lUaObBOkWUfN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 27 Jun 2026 21:54:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Aliwoto <aminnimaj@gmail.com>,  Johannes
 Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] http: accept https:// proxies again
In-Reply-To: <pull.2161.git.1782580676734.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Sat, 27 Jun 2026 17:17:56
	+0000")
References: <pull.2161.git.1782580676734.gitgitgadget@gmail.com>
Date: Sat, 27 Jun 2026 18:54:36 -0700
Message-ID: <xmqq8q7z4eg3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

>  http.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/http.c b/http.c
> index 8e5a4d8bcf..8c0f831365 100644
> --- a/http.c
> +++ b/http.c
> @@ -802,6 +802,8 @@ static int set_curl_proxy_type(CURL *result, const char *protocol)
>  		if (has_proxy_cert_password())
>  			curl_easy_setopt(result, CURLOPT_PROXY_KEYPASSWD,
>  					 proxy_cert_auth.password);
> +
> +		return 0;
>  	}
>  
>  	return -1;

That lack of "return 0" is so glaringly obvious when you point it
out like this patch does, and it is surprising it has been missed
initially.

From this function nothing returns an error anymore, and looking at
the preimage of 663d7abe (http: reject unsupported proxy URL
schemes, 2026-05-05) that is the source of the bug, the original did
not do anything when the corresponding code did not find and set any
proxy settings, either.

So perhaps it is a better fix to make it just a function that
returns void with early returns?

Thanks.

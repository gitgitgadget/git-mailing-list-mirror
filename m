Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7C7253340
	for <git@vger.kernel.org>; Fri, 31 Jul 2026 07:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785483501; cv=none; b=M+iz8fUprZD/4ekcGVJ07U1H8I1XrP84fOQc2baxYUtsP1Ge/gJdtO1tcPZ5b32Ca9JlgYxbAB6aHNsXbYghoAA/q+XizvQaf7m7/jr0YxU5HFe4kd6xmV1yOGsWid92hWdDyfOnAQGiTuNW0CHn/qFwaUPjyoIFxfyKV8LGQx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785483501; c=relaxed/simple;
	bh=oT2Pg2T5GWQsQthIFBLd93BEHFfiD3WcArNTAfLhA6w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fv+vS5dUrlLp5T7DWT84/1+d+GXFJVNDwWbcg0PsB0b9BIG6KX2LdWnzj/m/cuFSFh4yg5ee+fYty3p76n6jdV8rb/oT1nUPMieHKze4Iub5EcwHthm268FotUeqHAKZio0lIkdf7dZjL6Kn+utukh59sVtGICA6BheSYPtBm2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ju2rTXBb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kP893hoV; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ju2rTXBb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kP893hoV"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4755F7A0122;
	Fri, 31 Jul 2026 03:38:19 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 31 Jul 2026 03:38:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785483499; x=1785569899; bh=E6aYLwVqUF
	fycvabJzagMgon610BqFuTLfvYD8QucZA=; b=Ju2rTXBb1jnxhwwaJpRBK0oxs3
	2qdLgw1scjnfU0afbIPtMzD7NTII4zVkMXES9UAw8Y+nlPWdk1i0+eUKoXPt1cCn
	HnwDsAQAH78PUHiSLpEb6BGIgq7IIi6w4SMtZxeuSP0xeqTxMH4BOi63+06plF65
	Uudbzbe32iwW5xNEugehQUbAGt8CBJX0Jr05ltLgTVNNDhE/NeAVwdFd59hMWX0m
	nP9JoUqlznWakSg6Yv+4VVzm37VeDKCFcBtmprGeUdjIvu78Inw80mHkjyxaxQ4g
	vbWHCHqP/uevjM2j1HQfdwphOyVzJcwswIbcrfv9Jgvv2xK5IZ3ZMUeOiEXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785483499; x=1785569899; bh=E6aYLwVqUFfycvabJzagMgon610BqFuTLfv
	YD8QucZA=; b=kP893hoVxw/YPQQA5CE+CyeZ4JI0iHIVF3QMKiz1EPPNgfp2mwN
	hzIjib2nemHMGSqXJy2TTPkucmzIb+0iCaflJNhgVUU0nQ9pC2DAWN4dabaOK/m+
	LKcv9P7KTHFnGjKqCXVtj26WY+XPtyyR6ELME2cxutThMdhe0cHyn7hYsgT8ZnSy
	Uk6a8aUwMsPOZwKFZxxZMNjyco7XCEcVX7rPUt17ySoWAtbRYgYgpo1X4mPE/54t
	cd0Cd1TUNKFz4x+wV3G9rvcpYIoWaYvEIuEyTztaDOT84hu4kjSz+OuGQCULidCw
	YeHJ5UEJrFbHVYDA1XSTMOlh6emPcV7P/aA==
X-ME-Sender: <xms:6lBsagNLhSDNZue7RUdXcjxzZNsqYASwfAYj7KI97fWycLqME_tVYg>
    <xme:6lBsauaZuwyUTFYL3Sm4pV4CdkeakL3s96MRslKtrh0aRQHuoDc9964xZNelhtPZP
    3wPWsu58A49Lhlvno7sZRdwZ3gVTML4W-LUKpc_pLOjkzEn5AHDe1k>
X-ME-Received: <xmr:6lBsakozq4DHCUWIQKMuJZcgfn-uhwXHrApGY5LTxqZF3BSIewHxPAIFBreuOvfR2ibRsBgZVt0cEEvX0_KofCnq3GQzVnpV-A>
X-ME-Proxy-Cause: dmFkZTGj0GTUdTl6CIQp35mwmzM361pUXpoawQ1bW7EvrP6j3Wo1oDhVoAgtB79lyu4MIk
    gJPI+tyjQG/oXb8iikGSCvUtZDgZGu7DYME+6kQ9ITYtmEJ4ZV8Yvgdp3hbf5+E6yB4LDS
    mLsp4+89zPOjOw3W5SlnN6rrkyDvnEe6rZaFdfeSrKg9Qyb2thgMs1sPTsUlJA8bokxFie
    3DE7I+7PgM35eoif80rZ1sROKtfxdB+klOHdktsTglqClaV5uf+4YZzVExN9HgPemeka8W
    MqCrqR7fH9LJdxcsfJ2KuV0FOXAF3rlIyOttUASNgHldSOmPu38LG9VnZxAw+R2CIMhpd2
    6h7CrfGT7+jFBOZxXeLLXUXUVWFXWaHexyEvmfFpRlyWpvd8Seu5JSHQL9gvu5T9j/13TF
    4YN959IFpeHv9qrgM2NwhkHFpQ/Rl9XBIfjKBRp19RrqbstTt5HCQsCEsnmKUooTK2e7XE
    QzRj67zQMFF1BtPPej5gf+HCdrF4+GeKpjYiBsdtYv8KIFbeoKLKiSN3+DhvnPaM3WBUvb
    cry4v4HSbP5c/ExSAmA6cVU2P/JbC68wqJKkim5zUAoas7nliFm5a6CyQAXydoCzGDvoL1
    YChetKlQkdHFVyHBcu45uD7sgpyd3+YpRxCFNaicx++JUkQdnx0d3XuAMLDQ
X-ME-Proxy: <xmx:6lBsaibW-_WMcYHtkJ-dUckdKtVwKh0hhl7LLzbw3s709Cr_nv5lJw>
    <xmx:6lBsasTNCch0GFV2vxNlS4zER05msTd0G7N_TAHQ9yGwgfwBJKRAww>
    <xmx:6lBsap41TK5kANWp8hpLxOdT4rk3i7ydy5yN4mE2JlTwB5fISqRDJg>
    <xmx:6lBsahzSGY4pxhxGhOBwwDdmtcYY78xEeG2tQS5miNxr7v4TetKuQA>
    <xmx:61BsanGdGUsWX1CdFfktb6hgNwSZ1bEfR6fNVKOxFyWOXQFhWiV_kkq8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jul 2026 03:38:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>
Subject: Re: [RFC PATCH 3/6] hex: make hex_to_bytes accept kind of hex to use
In-Reply-To: <20260729233215.398654-4-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Wed, 29 Jul 2026 23:32:12 +0000")
References: <20260729233215.398654-1-sandals@crustytoothpaste.net>
	<20260729233215.398654-4-sandals@crustytoothpaste.net>
Date: Fri, 31 Jul 2026 00:38:17 -0700
Message-ID: <xmqqzez7hamu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> -int hex_to_bytes(unsigned char *binary, const char *hex, size_t len)
> +int hex_to_bytes(unsigned char *binary, const char *hex, size_t len, enum hexkind kind)
>  {
>  	for (; len; len--, hex += 2) {
> -		unsigned int val = (hexval(hex[0], HEX_KIND_MIXED) << 4) | hexval(hex[1], HEX_KIND_MIXED);
> +		unsigned int val = (hexval(hex[0], kind) << 4) | hexval(hex[1], kind);
>  
>  		if (val & ~0xff)
>  			return -1;

It depends on how big 'len' would be to matter, but if we are
looping for a long stretch, choosing which one of the two hexval
tables to use outside the loop and using that inside may of course
be more performant.

I wondered how ugly such a restructure of the API would look like,
and it does not look _too_ bad.

	void *hextable = hex_table(HEX_KIND_MIXED);

	for (; len; len--, hex += 2) {
		unsigned int val =
			(hexval(hex[0], hextable) << 4) | hexval(hex[1], hextable);
		...
	}

The true type of hextable would be "signed char [256]", but the
callers of the hexval() function do not need to know it, hence I
chose "void *" here.

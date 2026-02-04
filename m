Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AA52F99B8
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 17:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770225973; cv=none; b=WmLpMHJqgJ5IlMSuzILi8WN6wCL1U2SXWouGg6SoOWvVuw/oiGG4mdq4KK1GkZcz9oQKwECSv/b7IqxrTHILrsm6sOSlfzbqc5n/Wzk5S9+4As37OkKo8UgLzwBMVfpZo9RW5F6YaGCgJvqnZCjYhszMO8LpazHMv8HIxaDPkTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770225973; c=relaxed/simple;
	bh=WYEr82azxoMtoD04MFTxgFZwa+HKJlPGyVg9rYazBU8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XQxQ1xQhW130E+fjL7TUai7Xp0ZsNWNwoCMz9zeS/1AMn5JGBYy09Mub8FmXB0rMBLSb3Tl3xLU/D+ISQXhvXj7ZeC1YMt1SJVCffWp6o2rOqgAbvUpImHfzgghh/RqQFV5DLS4qi4D/qg7Cn6zInYcG01YR8Wo+u30bkSUIE+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rjj5XGve; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y3zD4CIB; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rjj5XGve";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y3zD4CIB"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AC69C7A014E;
	Wed,  4 Feb 2026 12:26:11 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Wed, 04 Feb 2026 12:26:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1770225971;
	 x=1770312371; bh=+pPmU9mYuc9zubhjdlNOJb0wzQ/wQ4j3SgzKz+Xer6Y=; b=
	rjj5XGve14WY7V/RgM34K6xMzy6YapQKdhzcAe8AFjrgAJvEdIy3OpIpLNbRtZ8P
	MLtOYpNMVO0IgN9geWR6gNY3f7SxLs70UO4TwWOfJzZP7Y7a7vhb2Fztj/qPpsJb
	MmdAVdu/r/WuX3yymYB4nbRT0ameH2gDuZq+5hw6vT7F+GEWdlJDR1EDs4zi6Wpm
	9Uxnfj60UQFaJZ2gNnr4HR7z81OQ3MvSllbrSAUY/G8YUNkS0qdbZsmYJJwfnVQE
	RtA7UqEqX2Vv12zHWKlEAgujGYNB69MN//yDgD8wJgtPIsuNZgOyt1h6yq4oGfj4
	pCk1Hm305hTdmft9vRQpkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770225971; x=
	1770312371; bh=+pPmU9mYuc9zubhjdlNOJb0wzQ/wQ4j3SgzKz+Xer6Y=; b=Y
	3zD4CIBzq2zH1UiFZsC3925Gp23lx7pYsGrZ2CBQA/Zp2L0VtZpoLL3rcOMrmSnE
	7xZsE97bZBpdv2hltF5t3XMcs/FXtPKnEXkeTcYaJjanE7H9kR6zCl4DGkqKgogu
	SJrW78BkSwW+nwlB5R2zjtkNgzGq7ySgw98HD7nBCm/4PrUMn8+vCxcNbRD6BHpg
	36mGSGbzCU8F6bEv4aP645DZBQDKFFrp+lD6iFXJaIk63MqiBQ1FljWlLmGGc/n7
	k53kf8QdHV1/Ro4jwVi/Cz3rz94IHinaBL70/AeE7yhyflvUP0rb+gxJgTuAjIJJ
	TMgWRmUEg4SAq5IHPhsGw==
X-ME-Sender: <xms:M4GDaWb1FAxfq5csbtXKVGPEE5mNrJPZc2Bz62cqwmyXWEw3nEQN3w>
    <xme:M4GDaQQHm8J4soNB_ybxo8vjtqITFT0gDAIp3_-Rt_r7xq-P7bcIcSIX-5jt9wLVz
    sOS6xWZDk5m86c7UM-s2vtCFz-gQS5nU7-9yXTN3u7euyF4kqfXog>
X-ME-Received: <xmr:M4GDaZQnErf-yVF96cHOTPv_DI2uU0MRQqeQ5BIfUAOskdCgxDVZMiXMb0dmGUGluBZE5HSyX-XTeM36LqqyQ9pXZ1HWjsIBSA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeeftdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehukhhlvghinhgvkheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeht
    ohhrvhgrlhgusheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoh
    epnhgvrghlseifrghlfhhivghlugdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:M4GDaUT8Wpw3GxlWZ6f1Bid2psdvyYYsGnnod4r1NZnlepIrSytpLA>
    <xmx:M4GDae49KA09WPE_TbIWxOFJBIcQGxu9ovud28kWaFmetznWXfqvWA>
    <xmx:M4GDaQ2MKkEAsgzLrbtfPydPCfrNJ5L6-vpeJ-3nHYfXzPySPW-fXQ>
    <xmx:M4GDaZCXJrFz9yyQtHvDSfN0EuLlyv25ExwZ10INepkIFlg8RaFI6Q>
    <xmx:M4GDaXszRmxpGGX_7QFv1DcYDRftTrs7ye6Q2DWCBsF3QMMW--GqCUx5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Feb 2026 12:26:10 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: git@vger.kernel.org,  Linus Torvalds <torvalds@linux-foundation.org>,
  "Neal H. Walfield" <neal@walfield.org>
Subject: Re: [PATCH v1] gpg-interface: Signatures by expired keys are fine
In-Reply-To: <20260204152306.1767112-2-ukleinek@kernel.org> ("Uwe
	=?utf-8?Q?Kleine-K=C3=B6nig=22's?= message of "Wed, 4 Feb 2026 16:23:06
 +0100")
References: <20260204152306.1767112-2-ukleinek@kernel.org>
Date: Wed, 04 Feb 2026 09:26:09 -0800
Message-ID: <xmqqjywspgi6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Uwe Kleine-König <ukleinek@kernel.org> writes:

> If a signature is done with a valid key and that key later expires, the
> signature should still be considered good.
>
> GnuPG exmits in this case something like:

"emits".

> diff --git a/gpg-interface.c b/gpg-interface.c
> index 47222bf31b6e..6635c6c8e16f 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -382,7 +382,7 @@ static int verify_gpg_signed_buffer(struct signature_check *sigc,
>  
>  	delete_tempfile(&temp);
>  
> -	ret |= !strstr(gpg_stdout.buf, "\n[GNUPG:] GOODSIG ");
> +	ret |= !strstr(gpg_stdout.buf, "\n[GNUPG:] GOODSIG ") && !strstr(gpg_stdout.buf, "\n[GNUPG:] EXPKEYSIG ");

Makes sense; I'll wrap this overlong line while queuing, though.

>  	sigc->output = strbuf_detach(&gpg_stderr, NULL);
>  	sigc->gpg_status = strbuf_detach(&gpg_stdout, NULL);
>  
> @@ -680,7 +680,7 @@ int check_signature(struct signature_check *sigc,
>  	if (status && !sigc->output)
>  		return !!status;
>  
> -	status |= sigc->result != 'G';
> +	status |= sigc->result != 'G' && sigc->result != 'Y';
>  	status |= sigc->trust_level < configured_min_trust_level;
>  
>  	return !!status;
>
> base-commit: b2826b52eb7caff9f4ed6e85ec45e338bf02ad09

Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AAC33F383
	for <git@vger.kernel.org>; Mon, 25 May 2026 06:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779691918; cv=none; b=pWxXU0P1/9veHlQFVLYlP6tZ8jgOcJa1B47E1yhdcR8jBNA7B840aVc8Emr2n/VVmTGpCL1MW0LxpwFkd402AyWyTUszgya22S5wbLbNBMPnO69U+EjgJ32c9fmNY/qn0mkjPhW3TJSoHvDfJp3UwKpazmnxLH1JcSPup9VVeSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779691918; c=relaxed/simple;
	bh=2a0IBfOSQQVhRiAAoqg6SzrGQRT0N3k/XtpJDRRRoRw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=qVgF2mju2lB/00daT2oyAgGOs3tq1ptFPANT7mcSa8YJtP2eUPLpYnWJEAhpIjn4ErWlj84NvRTLQ5RHIl9//pYnKxGv56KK64Gi/mDXUhGCtKGnmLMSsYfmN+NeyL3//vHrHNUpL47aIAHhJ+u4fRkSue3DXgm2TY6qxFi5ABE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ii5XQySj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DPSUwl2I; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ii5XQySj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DPSUwl2I"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C122B1400187;
	Mon, 25 May 2026 02:51:45 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 25 May 2026 02:51:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779691905;
	 x=1779778305; bh=ADM/NE/5MMs/jhlY675P88OS7n9aFDyEOXGO5Neztug=; b=
	Ii5XQySj+rIb9RdUdDSyvwMV90njdpcioUbSN1IMlpw+MnjBOTMxbyJ7bWDaiKrb
	f1yzVmWcDs+zVZX4vZ7XT48GHKRTgjE5G8HWuk4y1W0b19gBFP5/Hvi4Phlwvyzd
	HthmON7pOyz5IRseyYx9+hsbuNeZha/t8pW0KIngNTs99wnUV8nwNQxNDqzs+Qi6
	O8DoYtaf3sa/+ciX/k49v3vMVfSoIA4WeTgAbRz05NrGL36ScjTlmkv9eCOs1vfc
	xN74nyzb+6+h8JaTbvTDncv7X2kY0pwYfE+XcCS+CeR+izTbGnhA2FhGCIJygABc
	tFv9hoNvUtDNFiNUSewMKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779691905; x=
	1779778305; bh=ADM/NE/5MMs/jhlY675P88OS7n9aFDyEOXGO5Neztug=; b=D
	PSUwl2IZ4IBr2L44lOQTXE12VE5UB3ySfXfq8Skl48L5y77zpRCJ6COamcUifkyq
	FqOELb9WupYr3iOzpGZxRIV3S5lJHOoirZLdFIpgJWNU+5xnSNbdZ2+fc5aaxuwT
	OaS7ck90en3gFULdNpSOrbuoYuhgJiQ8th/kkerkIFO+1kmGSwS+SOsP7N8jXyig
	8QUqJ68Q+oQ1ZSTGmx+8237Rla3YpuSccz2dXlM6S/NXbfBRA8+fK1W3cvpxpOUU
	FbeBJD2ChhtvDiYhFLzMbfd0ZuWHTCsJv+Y45d7kJvGqjpWBiO1ZlCrF3gdPWnZH
	odoZJ43RCX8ic7crF8f0g==
X-ME-Sender: <xms:gfETamLvYBiBQ6WAPD6xNvgxv9XHqODQh2dKDn026nt29B5zcyg2Tw>
    <xme:gfETalnwgdSFlGxkZpDMyocxCm1HGuYYu_ZVkzgAy3I7hgcdmAtVTdIMp7YbPkxBQ
    wipNURIbQRj7qXsi98BU8Wi3bAZQKzwtYqKFj367omdBolamdAXmA>
X-ME-Received: <xmr:gfETakFUzS2o7ZNECEApvWcMg3noE189Vqbt_wyRDz6ym_6JNqplE5Xseoay>
X-ME-Proxy-Cause: dmFkZTGrM/Eky05G5QDYghC/5RHXnerlDKDQjwwgft5zz4GZYgKAROoeOnU8HOedg219Op
    Vj0zHGhKLpn4jwo7ZqNvHnSZe9Bc4wKPCCdP7K9eiJvDtUxo6IDVHl5nnWIFq2fJYBpxrx
    RYF9GekbPCzZx5xdVVOqe66wY4zBgHTWqPy/YM3nGHknEJBWp1wtU2X49gHI5GXWsnit0V
    A3GiwYSEFk9Ie6o60mMAA1EuqUfiqPJIUE3U0s/1Lr46pAbMgZ5hW4g8anOQuw4eIZRpRR
    763/f52s16kDblypjbvQizIks//ENlg8k6/ksFxQyV95NimLnGGxGgEzL9FI94jcwKcCRx
    hL+pze8+29QOKWRGn/wuDWZvycVkqTCKEskonxV9lgBbDg7if6JJFNyPlgcAsIDAXjyTX/
    3hoBApl8wLDRVWMqBCjkYTRwjQH/8qlH2cx130hLIfCY5pHEQKBV1uCyyPAVbrtL/u/OcP
    lme4FPSaLoGMLvFy29FlnuOmOThnv+qs9oeYeoEz3Yap5ULjYcok4FqHOd+QOGLeErNozX
    oRkJ8bvT4iOFGzPSRemf8LuA2xcSkCrQIB03aa6Wz3WgEw6UDsdIPFrl5jXA0rAuOzL1kk
    OjF3Gfx2k2Sz41ueFFA/k6EGvALMOSU/atyzJUJ7rWggWNS6NknGSzV8e6sw
X-ME-Proxy: <xmx:gfETalHJ1exjfblkmlMd-edXplwAN619Jdc_F5gMnSRbdXRgXklhUg>
    <xmx:gfETahP58ihagvHhEVs9yhfZhjOqwm7y4tmgDuhMz3Y7CnkKvHsuxw>
    <xmx:gfETakGgUN0LaAgXl_a6CuFNCqcnA1iJdsj1Yhxt3pBcKgwqftKcWA>
    <xmx:gfETaoOrDTO4xlWgzCyPz9LJ7NTsbK6gGgVVGn8xtxZ8rNsh5VAPnQ>
    <xmx:gfETamPv_olS569uP6brEebAypvv36GECDVyM4F6xbeQ4QcRwIKZMa9P>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 May 2026 02:51:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jens =?utf-8?Q?Tr=C3=B6ger?= <jens.troeger@light-speed.de>
Cc: git@vger.kernel.org
Subject: Re: How does git track history overwrites?
References: <089615C1-6526-4ADC-926A-6A232F330DA2@light-speed.de>
Date: Mon, 25 May 2026 15:51:39 +0900
In-Reply-To: <089615C1-6526-4ADC-926A-6A232F330DA2@light-speed.de> ("Jens
	=?utf-8?Q?Tr=C3=B6ger=22's?= message of "Mon, 25 May 2026 09:41:50 +1000")
Message-ID: <87se7gasn8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Jens Tröger <jens.troeger@light-speed.de> writes:

> Hello,
>
> I’m looking for details and some clarification on a `git fetch` behavior I observed, but can’t quite explain. More context is in this Github comment:
>
>   https://github.com/jenstroeger/python-package-template/pull/1190#discussion_r3288253713
>
> but it boils down to this:
>
>   /tmp/bla > git -c protocol.version=2 fetch origin dda8db18cfc68df532abf33b185ecd12d5b7b326 --depth=1
>
> It seems that sha dda8db1 (tag 1.20.0 previously pointed at it) was replaced due to a suspected history overwrite with fda7769 (tag 1.20.0 now points at it) and git figures that out:
>
>   ...
>
>   From https://github.com/adamchainz/blacken-docs
>   * branch dda8db18cfc68df532abf33b185ecd12d5b7b326 -> FETCH_HEAD
>
> And then:
>
>   /tmp/bla > git checkout FETCH_HEAD
>   Note: switching to 'FETCH_HEAD’
>
>   ...
>
>   HEAD is now at fda7769 Version 1.20.0
>
> And:
>
>   /tmp/bla > cat .git/HEAD 
>   fda77690955e9b63c6687d8806bafd56a526e45f
>   /tmp/bla > cat .git/FETCH_HEAD 
>   dda8db18cfc68df532abf33b185ecd12d5b7b326 'dda8db18cfc68df532abf33b185ecd12d5b7b326' of https://github.com/adamchainz/blacken-docs
>
> I’d like to understand the details some more, and how I could manually make that connection?

Where does this line in your discussion page at GitHub (which is
omitted from the post to this list) come from?

    commit fda77690955e9b63c6687d8806bafd56a526e45f (grafted, HEAD)

Are you doing anything funky with .git/info/grafts by any chance?

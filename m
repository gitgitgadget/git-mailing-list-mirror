Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829992EBBB9
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 18:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786557868; cv=none; b=kciCDZSv2KBo5uMAso18ffjCzEzmIuSzRmCwB/TTJgxXOvSi3p0ABycYZR0LR/Zf8gGXZwSVetrUKBbOzTw0x2gamoDbYckvl6UoiVGGwYnIAUKZnkKTl7VDZHzrVuV6tAktt8F9hC1ebcRHHk78rKBLmdlL6UViojhMPoupWfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786557868; c=relaxed/simple;
	bh=jHhrCsuVj6AaZ5B4/3/OUDzwRXgbdVvszy/tr9vfxNU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gwb8U6499K4C65S5DT/RYDrUAdzOuNyh/lOu6TEoaBTTJvxPoAYJHnoPD0+Jd3pFunOff2ZxMH+c7/vZGHxn0yfBhKX3mgBmZUkQHfC+BD/6YU7mtxlDcPkuxSxNBJHh8sY6OQ8GJ9T3CDSeG+BrHWR1f8nYTPdiIdZZp/fR4JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ag9EhNRF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LowgCgll; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ag9EhNRF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LowgCgll"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 1AB2F1D000F7;
	Wed, 12 Aug 2026 14:04:24 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Wed, 12 Aug 2026 14:04:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786557863; x=1786644263; bh=5cyUf8Ayao
	ZN3/Ax3jG+Nnqg+age0kgHm0yi5L0BBqg=; b=Ag9EhNRFtyJ/qgfvpmXqhQOtmz
	KW75Qf+C0yg5+F7CEhD41S7To8SRsWQLDNl1uSuo5kjA+JKCMUt7fvOP/0xexZk8
	xLLlS/bLubdNKorvFYuJnzhznfL3LaJFbFFC3CIAD/chS++nr2RsY47h3rHHLi8r
	Ann2L9uDQzTQi0QufLE/5u5j8ekyTG/2GzdBeWZS5eBiw4R2tENTF0ovBrIbsCni
	ioj0yeE/fqQJUbmpl/jhp4gAEDkLZWqvKb2Ocl4jIbGZZt3g2GCt9QyGv7TMIPMd
	ZMA7rzJDXvH1WAJQDPWR56CuIuihyrTqZbuHJfci95YSHiBI+BgZlp5bdKCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786557863; x=1786644263; bh=5cyUf8AyaoZN3/Ax3jG+Nnqg+age0kgHm0y
	i5L0BBqg=; b=LowgCgllYu1UwMeVVVP5kXVyrwMVypZlp9LzgxvTzXSBPwjVVbF
	DejeCj99F44ITpJbr14Vc1DwSpTOFDoya4LwL2/9VHZ2CvRoGmox7KzyhJBVkGZl
	+6jDEbbToj8IbhulPH0UPbI2olAXQGe8U9qYEVMxjIxOvZtG3IC+jvOgjwyFqZlK
	rJXdtii3tw1TAR2c4dMB66CzxxnnYAsRexrDU8InNX1e5jYzPjuICpzd8yNJ53Zw
	AQLgIg0LAf1hS4Uxilxx+U/eD6QPDCqs8lSCXX4FQHHXQVhFnGbUB58r5V9FCFGD
	ujGJ80/oDojQ7B8Du2N04RAzMPIXzvqHF9g==
X-ME-Sender: <xms:p7V8apGcdczo3IdbOnblPJ4Ueh9DdrSmv36hNy7-pRe3091587SmOA>
    <xme:p7V8ag7QHf_k0t1oJq_MoJOrsmHxmR76nmrUUMhczjBiTRblL_-FSSEwakNsRnaza
    0xPQD_qfRAj4AasU-BkdMt_L6aJ2S8STyWLDCINITOx0dZbeVOXOQ>
X-ME-Received: <xmr:p7V8auz-o-CB1f5RVVbQJg85fnc0XjoSmcN1Dywzl92xN7CH6-xxVr6X45OmYQYRQihQ-uW6Tpt0wzM0pEhjXvVl1algFPEccA>
X-ME-Proxy-Cause: dmFkZTFOg87gIFH2eIJqEqhzCT0cU3jBoi8HP0QYvqRYEWXTdoKONdnWTsA1O382fwZNnk
    FeglRRe5PBF7QxH98rzYlg9ZArBItBO/rMu4Pu+AL79nwbi0cMK8eW3BAQIn5OL3WFVkxF
    z3R+wFV4n1bSfacw39nKzh3aj2SXsF1iGXSZZ5ubjY+65LEVBWNG/WDpIaxjmw6yGknrbq
    CuPPRwVa2TemG0OYBgB5jsXXIv5TBzeHhF+iYQmZ2b4hPaGc5XgVjfzXpkiUERNldVM9J+
    rOReYhu3O7ErHv9SFrIXUCRgpKs+okKXjAuRpoXx7BdDs9WUbU0BBImb7bqAW+uAGTPKPb
    6x9gmh0y+RSEq+mGE6Bgfd4xnnoIijZct4Yk+gB1PBSfBh0zOR+r/ig99lBc84NJcEDedc
    XXlK10HOhf4UQ4Hm58nGd9Hvg/PFB0iCrLjxVGp3RN1xn6XNbQWoPTHDn0ZCgtsk4XmKPA
    SkANLyNrhEPDnEirZKhME+Hs4q/PNC/POuoKLJ4fopITneFYpZf9xpIsQyKAUQ4f5carz1
    DaBT5Taohm89rl3l047rU2Vgi3Vmeap3zEfvw8ElUfYee46KkH/A2z3V9gz2TpH4cRX2m6
    loGNoGrQiNjtm+Nc/EmCkQG71v5FcofZUunGapQL/0WOdYZ9IMjEOl4egIJA
X-ME-Proxy: <xmx:p7V8avNH-LP-yrYlzRs9WsMGfAHC37YlEBF9cKV8nF3n2-HqQRAZFw>
    <xmx:p7V8akkk30B8WTY5ShODnh3H9icyTVN81DAtTTK7LoXzuAJpavogJg>
    <xmx:p7V8akS_ieywMnkA0CSO2osbwrAjLw509t3K12rQ9xKv07a7B33wLA>
    <xmx:p7V8ajWENIybRxLI1opZwIfjWejn0JfT9QBVbYJPWELpPElWACXQDg>
    <xmx:p7V8alNrOsqCynHWixQXYWPUdZZbis9vGcgUga-j_vl4VHYdljskqhhJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 14:04:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  siddharthasthana31@gmail.com,  ttaylorr@openai.com,  ps@pks.im,
  johannes.schindelin@gmx.de,  l.s.r@web.de
Subject: Re: [GSoC PATCH v4 2/7] list-objects-filter: add
 list_objects_filter__filter_oidset()
In-Reply-To: <20260810174047.6524-3-r.siddharth.shrimali@gmail.com> (Siddharth
	Shrimali's message of "Mon, 10 Aug 2026 23:10:42 +0530")
References: <20260806112202.75067-1-r.siddharth.shrimali@gmail.com>
	<20260810174047.6524-1-r.siddharth.shrimali@gmail.com>
	<20260810174047.6524-3-r.siddharth.shrimali@gmail.com>
Date: Wed, 12 Aug 2026 11:04:21 -0700
Message-ID: <xmqq1pc3xlju.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Siddharth Shrimali <r.siddharth.shrimali@gmail.com> writes:

> diff --git a/list-objects-filter.c b/list-objects-filter.c
> index c912ff3079..6a2e9d5b24 100644
> --- a/list-objects-filter.c
> +++ b/list-objects-filter.c
> @@ -828,3 +828,48 @@ void list_objects_filter__free(struct filter *filter)
> ...
> +	while ((oid = oidset_iter_next(&iter))) {
> +		struct object_info info = OBJECT_INFO_INIT;
> +		enum object_type type;
> +		unsigned long size;
> +
> +		info.typep = &type;
> +		info.sizep = &size;

Here "struct object_info" is defined as

        struct object_info {
                /* The object type. */
                enum object_type *typep;

                /* The inflated object size in bytes. */
                size_t *sizep;
                ...

but local "size" whose address is assigned to is of type "unsigned
long".

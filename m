Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D593793B6
	for <git@vger.kernel.org>; Sat, 30 May 2026 22:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780180649; cv=none; b=cUgHfqM80lkPcwh2gYShVHJad+S4LTiikHCKuuFgeeMPfDJ81KVNsP59x1reJ8kKbAokt3CK86Lt+XAhHzKBV8a2oCc2SnXoiqFXcYPs6IQYR6s8M2tb+nGb83fAT6bVyz6WnWIgUvYuzgwfUcrORAJfmCY3orLfX//M58VO0+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780180649; c=relaxed/simple;
	bh=o0fKtV7YtU3wu8Knugd++2pUJsSnzGZqmClVZ5OViFk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ncanVpAThnZeiNjVhJ5TxhhaKgU0fhnaKPIIA80Or+m7bZ0QDetBkJqFkKUVtOvEiexhK+TRya0cJhAf+uOFPa/isz8LGXQcer9149twWEwwZou4DMNZIb5W2HumHGR1qu1sIRwFrmaPnv004OW5ylcMdUQXuE4RA7V5czU6MR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZvmN9Ctt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WT6X8TIG; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZvmN9Ctt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WT6X8TIG"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 4BA391D00061;
	Sat, 30 May 2026 18:37:28 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Sat, 30 May 2026 18:37:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1780180648; x=1780267048; bh=VRk5WpbnAt
	zx0UuYOMcP37xdE7BdVNfSnxYlddLHLtA=; b=ZvmN9Ctt+cHybzDHVUfyw1iE57
	xG2bf4G/sw4Uuai1cUXKz4FMYz5wIgAHDWKDm4dX99O5gXrw/vBDtrauxXN2FuwV
	rHaV78obcbp/zcNERIss3C3WkDV5hMtQglVifi4L/3xz/Cru2DTDW1apWuDRAWua
	fZ++ZOdeViCji9r2JuaFke6tyjiTiyaVitsgGwbPqQ78llm+/ZdXbZLiklNCWCVH
	v9XPvBLASxlDYHDzzBDgYBhy2t/5OsfJ4iAD2XawRihKF/UPtp+HH57JnNeYek/7
	uimzzaNW4DIxSKiaI0OtY1w0SB0i2hh/Xv1Vet+hYNkEexkwMN18kiqG8L4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1780180648; x=1780267048; bh=VRk5WpbnAtzx0UuYOMcP37xdE7BdVNfSnxY
	lddLHLtA=; b=WT6X8TIGRxbNwQHzt0SMpKtpPIlHFrpTk9GTFOtVpF7J/ihdlLw
	Yn06lgP9azOCoNfhZ+4dqTClcY4q5qV2Fs/ofDu7bk/eC995wKmKd8en4iuyl3wh
	3zYhtGRUTOlJpeRF1fxMQsr8MXAScXCEsyIuh9K/V82KIB59d8pbGY8W4pxbczJ4
	5a/iHJYYXia3bwvx6yjSl764t9EXYcfYM/nhi02sQaCRwD0KrqGZtbIEoa4ZgfkA
	G6iNOneOwFvAyON1BeFgO9lXajVOaVaMuNOKYMIhJvSC1shvgmkUc03X7nj4i9gE
	bvDG/+gaiuilXzKsiVikr9lnM2zD12ePcNQ==
X-ME-Sender: <xms:qGYbasSfVTPybtc9C-4DFg5atSLK1lUD3YUr7DShL3ZnGCPTEpePlQ>
    <xme:qGYbagoF3CT13oqoSoo3vZoGmJwp4Ttlaa97cNm-IUjbXVRrnfdRzP9SiH2aOJGY5
    KYa4QYfW_FIZrHwyXhSCmiU-1tmMF4bs68Nn3PRCttskV_UMapbDQ>
X-ME-Received: <xmr:qGYbaiK0f1LtJQteD61cpqhoMrCF3WYwL1ZPEA4tG_9BxnWLro5fivuFjyD3mElayy_N0DH1O1aBLC2k1AnBQ3d18n1krCiq19VF>
X-ME-Proxy-Cause: dmFkZTEa3p5vD+X0RnnfYpdCcILkVBgXfHY0VuGEoLeFf2w5XvHBJt8FX6eNoDPLTqyhOL
    hPlUANB6/gw90eZjch7iQMkHFKWu7RzCYtEf0SH839MOmECPHyA1A83kyI5PJNWC8OaYb3
    9AyuIKcYWZ80yEvIfDAxaicqpzvGbmnqWohhwqjVmQm03zIzXD6qCL8xPMxl1TZ7i+KfIr
    0NuunNDC7iLPT20iZgp/ekhaaEC3Fb3uy/k6IicvsRChPxfmww+SnVdvhUi4ApcfwEq0Oj
    ahThcqWL0PcVhzYm4eSpFqqdu1iuajVfDJgBV0rcl1TFZ7tPWiGajJmemffLIBS51h/dtn
    43Vq+mNoqAk722iHFXe7u9B0n751KnKFMFWJ7NSbSuNLnNFiXYp4POqIXV58OHP0RYfZBk
    aDWY1F59hut2MA1zSQta8MDmKSJegdkxNYwvjN6cBUG85uigIK4MKHbbxAKsgi8JtN/TRG
    a36yJARtdV9LPnvzBkp3jnCt2zgg+CHs/xqRROCpv6Fk6zMFOYo8RpuTEsB3xqAtVyknNu
    YGMyOOXhr1UUWWDbya7AZPtYIdh+NMRBwd9TJHOrZ59pFPQtUXAdkCy9suFAHjoTYWXYHA
    OTKMaLP0hw/2ArGuWQeVkSGEpeMGIxoNlZXDb7lzFM2K/yzHKA6rUbOcLH8w
X-ME-Proxy: <xmx:qGYbarpoL-09WtG0_cddSU8ghiDOLAas_olaBTf3RizHd0BoXJDjig>
    <xmx:qGYbaixw1KE1w9XQf3bAmX6N373Vg51Td4OqEI0ne5qn850FFrE_Aw>
    <xmx:qGYbanOkx1iGDZmxxlOfGZWozSQXkZVI6WVlYxDDOC940c81zrhnHA>
    <xmx:qGYbav6e_dSETpvC3ew7E2JPd_J5dsqpDDf-ZvWcuci6bikgthDoFg>
    <xmx:qGYbam43aCX1VNkYyB-HmKHcH4SBJLUqw12ys5ysoVUZ6zOC_ylECpb2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 30 May 2026 18:37:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,
  Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: Re: [PATCH 4/4] doc: replay: move =?utf-8?B?4oCcZGVmYXVsdOKAnQ==?=
 to the right-hand-side
In-Reply-To: <default_RHS.70d@msgid.xyz> (kristofferhaugsbakk@fastmail.com's
	message of "Thu, 21 May 2026 20:02:01 +0200")
References: <CV_doc_replay_config.709@msgid.xyz> <default_RHS.70d@msgid.xyz>
Date: Sun, 31 May 2026 07:37:26 +0900
Message-ID: <xmqqpl2ced7d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

kristofferhaugsbakk@fastmail.com writes:

> -`update` (default);; Update refs directly using an atomic transaction.
> +`update`;; (default) Update refs directly using an atomic transaction.

This looks sensible.  Nice.

>  	All refs are updated or none are (all-or-nothing behavior).
>  `print`;; Output update-ref commands for pipeline use. This is the
>  	traditional behavior where output can be piped to `git update-ref --stdin`.

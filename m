Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DBB305E28
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 22:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785278802; cv=none; b=GZnM4rcB7BBeh4330wBHIYA9PQVO9KJOWs0QVnrNo04JMZWayRyask0YK/KtnMkBeaOZo274+8fThgi5+Izn5/ubERjUEhZTZ4hEdfv/3n4JRvUDShyZMLUgPpbna3kcB5IK2nvfNc5F0uNIM2E+KKK0GAgsYJvxghlEDOIwbN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785278802; c=relaxed/simple;
	bh=1gc5u84DrAbECIdR+LC6gVYqegN+OHP+RXy94CUGrUY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XWu3tyRRl1TMliCWGg1g3AQzsiD3VcRC3NPie5WVaN7P3ANvkADcP8IAxtboLgiJA6vGKqabZNuV+yXUtn26Kbcudi0ITHjl6xPW9Nkjw2L4p1EzcvDmdK98kpnXSQF63MG9cNKqIctSrASfz3EK7NN/A45U+jfShlRDz/ZI0jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kLTt0oiN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZtOQ1Egs; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kLTt0oiN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZtOQ1Egs"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id C70C71D000C6;
	Tue, 28 Jul 2026 18:46:40 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 28 Jul 2026 18:46:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785278800; x=1785365200; bh=uDTqiZHSuf
	RDU6/8kItSH+axDO/tn6kctHqYXmNyOhQ=; b=kLTt0oiNxs4ZC2Ke0/6Vq5RkXC
	hmvcLhr0TsujEaSEYPSTmY8acqB3Tztv2PzUC1qPPqMen3BsajxpB4PLnwWH3uSY
	Wd1d8OwwVW8qCvQK2jyPaQgHsVn8p0+ng3YJlt/KrtTsgKiW2jV/adwAGYiR+HuB
	sj1ersm1IJbBIkk5j5N24GesXhvtRYeCrIMIZpf4yQq/gJaTXTwC+H34B8I8y0rz
	tTMIuYLS5zKhbdFQG//wSB8va8nontekuhZIRW44x+riGU+DwSSGosZWBk+CF5EG
	YlGdZJ95pcG0/ag9yp4EIFHie4Ww39N+7RjkBjTLBZDuXmEPlf7koSJXJhBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785278800; x=1785365200; bh=uDTqiZHSufRDU6/8kItSH+axDO/tn6kctHq
	YXmNyOhQ=; b=ZtOQ1EgsfAXKNJBVxlNuTdTWAlc7YFOkKEceFa5cO1fFYbPv1HT
	U5KcP3XRaqKICtfJMvGXEZVwfvfIYxj3vBk4jQS+pJIO4RWLaB0qR+cZjF7enmSh
	vXU2abiCzr7WXqhD8BoeLk668v2SruHgTRn+wY6ZSb7AUiLuyY2XlzLl5rKukuTX
	InEFIqFM2A9kQC3PzaHe5Zjb2zjFkqZk1MWtqBA/AO67ovyMucJD+AG+Kc5gQhDP
	EwbOsQuL0Sm19PRTu+T0nU+Vn0Tb25qQe5dXRrfgLx8JpNTObtyCrZIxikr4SE7L
	L+i9bPoWtODlt+bllyL+tHABUXhh5tIK+lA==
X-ME-Sender: <xms:UDFpaiRmEiRUDfT36gzy6g0-rxl3KnotsJCIa4DqKkzdanKA-a7pZg>
    <xme:UDFpauq79l8BDCnLoo61QGcoShgeuuXbrw98tI9yuAdDgIBzvgOdpasB7Ao5u3uzw
    ZGGHX28watr5g2BXoo8cO981tIZQUeT3tuL2MdP-ZBiCaHbOZJZRA>
X-ME-Received: <xmr:UDFpaoLRrFOOuqhwK0IRK6DmoD0rmXPr5AwMrU0F_p62mdjsMW8Y9RU4QNqcK8UObAmY4wyqnrOxfqp5XS2bAdwQlyBMtSHpvw>
X-ME-Proxy-Cause: dmFkZTEnHx4o2bOH7IWco/Ey0SeIm14ntGS5rmcN1b5MNW/Av8cbpVQqkxascLllWDEpDP
    ksVbOXbnPuOi8/7FDrlQ7EieFh4GMEhQBtBOPTWnn7/TDc8MPdoBTFvhKbjSKVVNJZOpNJ
    VU4I/1KH82fUl49TmWYA27AV3r55H4Xq/VVToWEuoC8KWQeH8D75H8PpbhlhM18dfwJ4jC
    n9a6A73QcdqtoGfp5L5n1/X8/AOVEqKI3ExgPVBYdfogQW3cVNgbHFjBkd54+vlKZQkDez
    8vROptRLpQBunJSH8kDXU6Lefpid/PtYwIc2nOzboDxIV0qhQ2ZYzufkIAtr+2TsF3EmPF
    c5O8y47zpOnbKioE4pA/431BkaiBPOAlNtD9t1kuWUs5iWo01IHU8hqlI/oURo8y8qOd86
    MjQB9raETApSXCdpjRwiNTDAU6quj6+B5Gb0NlwtQxbd9UNyyUPkFwsAB89jsU80JStCUI
    TdoWzQ32xTr4o++c5Vgg+o2c8HzG0XvNBN7z6azi1ca4oCMK7ho+gOQsBMe3KNnugisVHH
    ns8QglwChOHDNdTv6w5dzKJOUyzrrbRHtF6cSQ6asCE5iFv5MmNTvHew2VXvx7GlxEryCD
    hooqZ26+K7CZWuFoQ4JXy4asa+fr2RxPheC81Xmbpw3uZSiBnARs5CZloK8w
X-ME-Proxy: <xmx:UDFpapoqSUoto2Ryv58xXlEYBDuBmqofknrOGH1h3SCMNJaIpQStFA>
    <xmx:UDFpaow8e2SJDrwelIDkbMSvyfSLUlhjjnhSDQv1A-xbl6pvyn0N2A>
    <xmx:UDFpalPp6r1SIglgel-UoWSM5y6K0yYxHz_AWBym1FY_gnMxiS5fQw>
    <xmx:UDFpal4yY1Mdi-CfjRdR01qJpSi_ysuQzsK2XoRBFBd_j1YroO7QCQ>
    <xmx:UDFpapTz6aiWCxlM6Sxxixhjg___dcM9u8nSP2pAo9NdC9LwqrTtN0hQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jul 2026 18:46:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: David Lin <davidzylin@gmail.com>
Cc: git@vger.kernel.org,  ttaylorr@openai.com,  David Lin <davidlin@stripe.com>
Subject: Re: [PATCH v2] pack-bitmap: handle objects at bitmap position zero
In-Reply-To: <20260728135248.61304-1-davidlin@stripe.com> (David Lin's message
	of "Tue, 28 Jul 2026 09:52:48 -0400")
References: <20260727171331.21088-1-davidlin@stripe.com>
	<20260728135248.61304-1-davidlin@stripe.com>
Date: Tue, 28 Jul 2026 15:46:39 -0700
Message-ID: <xmqq5x1yd968.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

David Lin <davidzylin@gmail.com> writes:

> `bitmap_position()` only returns a negative value when an object is not
> present in the bitmap index.
> ...
> Also cover the non-pseudo-merge case by passing `HEAD` twice. The first
> occurrence initializes the base from its stored bitmap, and the second
> must recognize that position zero is already present.
>
> Helped-by: Taylor Blau <ttaylorr@openai.com>
> Signed-off-by: David Lin <davidlin@stripe.com>
> ---
> Changes since v1:
> - Clarify the bitmap disk load wordings.
> - Add coverage for the non-pseudo-merge case.

Thanks, both of you.  Will queue.

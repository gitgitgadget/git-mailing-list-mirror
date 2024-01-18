Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8CF2E836
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 20:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705611029; cv=none; b=P1giqqZdxA82UoUaCLwvMy8ONNBY0lRG2xuZb+3ruQh767g8/WW54oqV8NvTsBE5JLNYJ0n9WZLn/mroFWDPM8RAZxOgRIzzWpxHP6ea4s8dcN7oXPKYytDh0olUvXeID6Dl18877PXcpCNWORQTXaVlb79VwKB0UQoYI66I/CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705611029; c=relaxed/simple;
	bh=N1gykCMmwx7Emut93kypE8wah67pzedqbyYWXsAUB5w=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=kqMbFQ2iWHbUkKpgLfWzlztNbp7Ux6S9ETPujW1ZCQjRQyT0TrM1oybkQ7BSeO7USsHoTmxY+otlY7whqgOavqBUgE2QaBpg1IY1TKgkfjVLhHGac8G/yN6gvRBv52sq4ZJS5L1qhNurUxU1Hzet1T+uDZ1nPGL3H1pIhvahvvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=I9QWaxuL; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="I9QWaxuL"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1705611024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G/loxS8H4yWeMOiP79OmwaNzL5y9ZTqZQZ1xPxdU+9Q=;
	b=I9QWaxuLy+NIHCpSVWTw43jUFZ1KJilYuRXSl2OYd9Ck8Kj5U2focK/m7rwvykh7/87pAY
	J8UDkCKKOMjHawyOc3QTXzK/F9iKFbcnsXmCcASmWIQpSpgQj73jpnbfcbfXx53FIc5qZm
	CuI7R7bDJLRrWYfBjTs8unDonvHi/B3VgP3IRhkQyd/Sd9tnEjNjKzHUYBg+y4Xc9x8H4H
	Tptao4BbTmy2C+ZscgnLs6Tlg+ed3Cs0GYlnvlhuJXuREto16vB0+eVj6FqctqfHxPJ7RO
	8mFapoarTmjim8vm1wgQTs7bMxBZSTXWu0IZ0d9jvnO4Z9ANsKm+tJQtfkkMEg==
Date: Thu, 18 Jan 2024 21:50:23 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, =?UTF-8?Q?Rub=C3=A9n_Justo?=
 <rjusto@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] advice: allow disabling the automatic hint in
 advise_if_enabled()
In-Reply-To: <xmqqwms6pf72.fsf@gitster.g>
References: <7c68392c-af2f-4999-ae64-63221bf7833a@gmail.com>
 <d6099d78-43c6-4709-9121-11f84228cf91@gmail.com>
 <20240110110226.GC16674@coredump.intra.peff.net>
 <aaf59fc82ef3132ece8e1f70623570a2@manjaro.org>
 <97fdf6d4-1403-4fe9-b912-a85342a9fa56@gmail.com>
 <a97b03a305a7b8b95341b63af1de0271@manjaro.org> <xmqqil41duov.fsf@gitster.g>
 <d6d72ec5431ad1ca775e6e4e9921f94c@manjaro.org>
 <20240111080429.GG48154@coredump.intra.peff.net>
 <5f322b3e6053c27dda58ef1c1f025d11@manjaro.org> <xmqqil3qsdkv.fsf@gitster.g>
 <bfded0571f133ffc1612fcbca1811a43@manjaro.org> <xmqqwms6pf72.fsf@gitster.g>
Message-ID: <dd82bef87fd82f7c4bf7cbff5f873141@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-01-18 21:19, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
>> On 2024-01-18 19:26, Junio C Hamano wrote:
>>> Dragan Simic <dsimic@manjaro.org> writes:
>>> 
>>>> Perhaps having both options available could be a good thing.  
>>>> Though,
>>>> adding quite a few knobs may end up confusing the users, so we 
>>>> should
>>>> make sure to document it well.
>>> 
>>> I agree there is a need for documentation, but we are not increasing
>>> the number of knobs, are we?
>> 
>> Perhaps there would be one more knob if we end up deciding to 
>> implement
>> support for both approaches, as previously discussed.
> 
> But that would be just one knob (which I personally do not quite see
> the need for), not "quite a few knobs" as you said, no?

I'm sorry for being imprecise.  Regarding the need for that additional
"global" knob, I think it can't hurt.  Some people might even find it
quite useful, and the good thing is that it wouldn't make the internal
logic significantly more complicated.

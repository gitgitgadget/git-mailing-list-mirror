Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50CC379C28
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 14:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787237305; cv=none; b=P54CE5gJ6UFfjpo+ImBk5rTB1jbkdJdfLmm3mgqFRbDZVNilSotnfco7NQ3o46FKbTNsRIae3DtutsgFNV3MWI/udcEBIp7L/pyn3qMZz+n+U1yH5Vwobt/D+FR6Vd3kafQFXDogvWDg00Y+j1dB/bw3ERLNnvyp5ucFONhbHRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787237305; c=relaxed/simple;
	bh=+bImszSgb6fGqA9wYMKyH24lS/T66iKz+y/cyaezwgI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=tAqQCOoLacd0bqzhBd8W4WZ91WKaNj/95W7RoqSYVNfjHU99VkzilNttACPPckFnlvK5ROW0HLeaRa4LnP0gekl1tUeWVtRnWF598DCYPqVprF9fkZhVmvt/lXMV6MPRk1TNlZbGFFti1kTRzKrh5K5grPex66uqybRMZ18512w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=JNuhSHqt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JbUuA71+; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="JNuhSHqt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JbUuA71+"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2C3FE7A00AF;
	Thu, 20 Aug 2026 10:48:17 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Thu, 20 Aug 2026 10:48:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787237296;
	 x=1787323696; bh=F/lfOD4h+5PQ11bk7pm2wGTVKEywsUCaRo9lBEGa3tM=; b=
	JNuhSHqtjxAkNj3puAyA3yTamwFiDKBGRXLAZwU4wrFKKRATM7n6ZBc4wzZLE5lV
	R26GJqCUGhy7HD8XaiysZCZeHlvTfrp6f4tYoqE3AlNXdQXoDXuU4zQzj0nWgb6P
	sr6ht4MsmgBbU2MkFOOIayNRDKGc0ntm3U7Exvj6xuaZOucn2FuoPQC4mHy2LO3C
	guUjfiEknYvUyxlmdaQdtdfZudij27sq7AMMgK+CV4eN6vCYFRHDET0FRYT7irK4
	sY3aCYDuDBVbJnauwr28ns9+O/zIx8VVJdn9bMo3ADy9xJVkAzwDaG1uZg0M8bci
	Gf9XiNPrS2wA2p1ZTVn3+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787237296; x=
	1787323696; bh=F/lfOD4h+5PQ11bk7pm2wGTVKEywsUCaRo9lBEGa3tM=; b=J
	bUuA71+Z332HF1gKSFaLa5E27vZ+EiU6X4RbfWIt1wiv/9Eh61xYteuEOjz8rW3Y
	wx2Ix57u+kY5S96yGSRMYCLgDblp4W8HB6WbRzDaqu4RnPxD3M4tGtorayG2fF7v
	efrWcA3xIBpRQBbshErTdqcmL8976ldbOAJUE/t3iHMhcJYRqkuSh2UiYQnpD2Fs
	5S/l8WbWvFKaACkErDe6XFgRZ8MZCwktYTn38hhR/MX0TE4ZEaNZzTypljNzxy1Z
	mgNZ/qu6pi5P4/3f4AxQWE4pfgPQkqw9lNzDhh/Sm6lKBj1KW/PLPbufF4njafvY
	vkp3wJUE+DQ3xNQUJarhQ==
X-ME-Sender: <xms:rROHalAUrE0edPBhjEX89CErQcHxCoREeMzc8RwOME31Ou5TGE91M7Q>
    <xme:rROHauVZ06Eb265kf8zSGg9-Y8fXkpxOQFUYK80SZX_5q57hLQjFWSXAIp9fsALjg
    oi3As2oWnBWApij0pJYf2-fsYqLAGSB3YEJqU-hDK96IzCW7qBBmcE>
X-ME-Proxy-Cause: dmFkZTF7rGPnA5qWjcLYRb6qCjKnq+OiOmntyYDZkDGbHhEI7NXGvZceClszZSWcJvquBQ
    PvIFprSua5WJ2xAv8yu9u3IJhd6hnN8kCmF/5vbTVl0ks7YC8vydqR1HdBQFLeTqpYAn0C
    6N72e69gthy5MmgiXe5+YhWGhbTNarkhrv9OdYlL9bfjnP4dz2n+HtvT9FB9Xnm05GYOjk
    VTfEOf6Oz8kXmYdvNP1+5mjNm5TwGxkvnm2I48DKcjGb1sWg55BI9W2OfLtZ5AOQq7xIyX
    PAKU5cF24Db8q9/jlzUQVZ9CLbOmOO/72svLSh725nycPXgn49IWy4WGehwOcCObr13HNe
    /mwD3YJcbfhrmzU4zPM1hPGLqxG4NayWQ94V8phpdBk8fubLXZJi+C0syBOq+9hikirj8E
    L9+mY/8plQ24q2AhKh26Mv8oIjF22Qr9Cvmh0f1Hya/rx93EA/kZXDJKbfWz7ImifunWAS
    qgNHM1cKe6/Xgxrt5SNFJC8Y75jNKb7CKzHFtF8pVfGr5VlBE3QnKlbBVbp0vJoDWaIFVP
    HJuseRwt1bkwCs9s4SCBFhaewBB67EAop+ryu6HHb3B+VoNL7JHKllidJatLIs9qWouXog
    NekFL06rbz+otRRUr6PKqTWlHFjT3WzjCdlR4AmaA5KPJchdBGvIp2QeudPg
X-ME-Proxy: <xmx:rhOHaidz9F9wt5n1GEaMi4Dq9YsxdpuwBUrkKGMWvm97Rxu4YFiHDQ>
    <xmx:rhOHaj-VSF0QldQIF182lgy82ursbERr19orJUQsyAC6BakIsY43vg>
    <xmx:rhOHammhc5AtHM7cgdOuM-xw8QizliDu7Vbvckvai6eoBpM9_lJ8YQ>
    <xmx:rhOHat-QnUl9lAR7los873GDuhKWoZVPj15JbXNWhFmzxh5XhIqv6w>
    <xmx:sBOHamSmHaa2AL8c6s09bT-uKgSjnXj7huI0XePk7liNJ26ta_xcF8XS>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id EC82122C007A; Thu, 20 Aug 2026 10:48:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ad5igGGZDhxo
Date: Thu, 20 Aug 2026 16:47:52 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org, "Jeff King" <peff@peff.net>
Message-Id: <c097cc44-3033-4f22-8c48-859de8353f99@app.fastmail.com>
In-Reply-To: <xmqqcxvcuaak.fsf@gitster.g>
References: <20260609004340.GF358144@coredump.intra.peff.net>
 <URLs_not_trailers.b13@msgid.xyz> <xmqqcxvcuaak.fsf@gitster.g>
Subject: Re: [PATCH] trailers: stop recognizing URLs as trailers
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026, at 16:38, Junio C Hamano wrote:
> kristofferhaugsbakk@fastmail.com writes:
>
>> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>>
>> An HTTPS URL starts with an alphanumeric scheme followed by a colon.
>> That means that they will be recognized as trailers in a trailer bloc=
k.
>> That turns out to be a problem in practice. Let=E2=80=99s stop recogn=
izing these
>> as trailers by failing the trailer parsing when we:
>> ...
>> Helped-by: Jeff King <peff@peff.net>
>> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> This has been on hold waiting for the base topic to settle, but now
> that the base topic has graduated, the effort can be rebooted.

Thanks!

> Can somebody summarize the outstanding issues on this topic (if
> any)?

I have version 2 ready. The only code change is using `starts_with` like
Peff mentioned. What I wrote about the changes:

    =E2=80=A2 Use `starts_with` for readability:
        https://lore.kernel.org/git/20260609004340.GF358144@coredump.int=
ra.peff.net/T/#m74203c474c34f1028a7e3d389ff46fb7e579444c
    =E2=80=A2 Explain in the commit message that you can technically get=
 false positive
      =E2=80=9CURL=E2=80=9D start fragments:

          https://lore.kernel.org/git/20260609004340.GF358144@coredump.i=
ntra.peff.net/T/#m35047d5c7a79abd23c11f97e6b6a0364409805e3

I just have to dust it off.

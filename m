Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704AC39FCCE
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 16:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772727897; cv=none; b=Q54BiFm2OninvNKHsnNRUUjUKnCmEIY/zZDZSFCVuPyFrMhb22Wi7eUTomvzos1LLW81xTe9M6nQ0p7/IPGAN0YkioIp93JEUJON2IFXdM/AHIddv25Nu/+GLwNWG0qa31jpIZyeCKpViWqY3/eesIuT09wI4YfBZNdPxz2qL3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772727897; c=relaxed/simple;
	bh=imm3I4zTdmVL9MGOx/batIsv27KpUDiotnyoTRpp3kE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uK95pcXlP/M5sLXwO+LFu/FHTHSPIF+qr6jtSduWm3orvaVRBhiryS1Sh1fBIV9GDqn3KItN003VlM6/h1m8nBS5SCULgqqUHvkwmJkgq5clLyTJUiL4ukNzFfA9P3UmB20nd4F+/T1scaORQav6way/3g7iRbAGNFGv3eVrkFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PkSfzoMu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pztzgDl2; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PkSfzoMu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pztzgDl2"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6DA7D7A0262;
	Thu,  5 Mar 2026 11:24:55 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Thu, 05 Mar 2026 11:24:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1772727895;
	 x=1772814295; bh=g46M6pPlzIKppZCOn7eGszvKSI27oWyA/mSnO76Ap7I=; b=
	PkSfzoMuLQvG34Rwu6M+GN7SIxFZ9edlq9cctpcRyg1CdbdhPGPudhd8qnVAaReP
	ZmHMCsfc9Qee9BKhgJNvRwMotBK4mlNodE/zekatSingQ8Y07SwRK421AgnU8pmw
	fhtM5bVQFC+dVJE/p1i/BTedD4AxVQcWArPFWKGf9gAOQWbUuNhmGkMnP/uJqXwC
	HHr4rcsOxoXkOi0zddzfsI4qUDZ8hBz0YyF9FkX8aHGdD3rFccoVnwO6vv0D1T6s
	b3DAWQ7WsZeUIjQOI9clQSCC+3MzfbmzvTDYLEQfURB0sbvkUQApbbQuXH/vvOSL
	GuiWvCd0X2wcKym7+KOQzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772727895; x=
	1772814295; bh=g46M6pPlzIKppZCOn7eGszvKSI27oWyA/mSnO76Ap7I=; b=p
	ztzgDl2PNUSSKZzhwkKLmtTOlMmUrA6XJKfGWGdN59GFA+iXyHrY0n0uj/ipRgg+
	nQcp+RhUTBzFnbOy6+WJsjIEQCQL7Jp5z4RGEGxbgZMhYAwhXb/B0Y2XaSECE4cx
	aUqhA7mK2GOHDjJIDmwnZbLrcb1arJOAtCV0t/kPeYxEJO9F6wXAvOYGYzv5KE/y
	g5x901Kq2ZBBPKHSjZEce4Mgggu2DG9Mbnlp0+Srsj9izbb8bd/VjSjcsEPOHa0f
	WgDtaYDckxli2R7qa+95uXiYLq3G5W0wmN0TWbQD2PWh9UXdLzpN7+WYHsQF1WSp
	y5iGz19601mmpkrPcJkLA==
X-ME-Sender: <xms:V66paSw0q9enH5S8s2zlEOs4Dvr5Kr1XaFywuWDsaA7LPyEwZqMoLw>
    <xme:V66paVu2JpcIwXqAFy4F2q7PNtRpr7dW8Z8VasnXHwUZ3hoAWVFydpnsh9H98irM4
    uBumCdUFcITTPAXQU6SXAp1wBVn-gRcrxXVSXBN-k-Vptk5cWh8mg>
X-ME-Received: <xmr:V66paRtvs10bPxy8IM8Pl4xe2Ef5amlh1GkS53PBxBFsN5wQ5keJ_wBsGuBN1cEsHMqk8XRXGW7LbeZgCSxyEzoSnbDP8o7lwQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieeikeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgrghrghgrughithihrgdtkeeslhhivhgvrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:V66paSMU59o-pqU11_X1vfZnWoy42d7p5Ce6JDaMS5yLEmDH-I0YKw>
    <xmx:V66paX2AICW04s_ejqUbHkldPPE4kv6E-YW5lQEoN54eGRnegJ9mhQ>
    <xmx:V66paWOEFOZ_VLw6StA0LbD9YhFfNqIJ0R1Js-RBF855CFtsOoGFDA>
    <xmx:V66paf1ZxLjQO8SF6-skJ1Lyl_VEUrbafzaqhuPC924vzB2BgDaQow>
    <xmx:V66paf3xvanae5-btvNnLtWM6yVri44lndG_WjjIYyMdPmpstCVbkdQj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Mar 2026 11:24:54 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] send-email: pass smtp hostname and port to Authen::SASL
In-Reply-To: <MAUPR01MB115467BA486F4F9B4E6829D64B87DA@MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM>
	(Aditya Garg's message of "Thu, 5 Mar 2026 15:14:44 +0000")
References: <MAUPR01MB11546AED093D8641767AACEFCB87DA@MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM>
	<87ldg6jpy0.fsf@gitster.g>
	<MAUPR01MB115467BA486F4F9B4E6829D64B87DA@MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM>
Date: Thu, 05 Mar 2026 08:24:53 -0800
Message-ID: <xmqqms0m452i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Aditya Garg <gargaditya08@live.com> writes:

>> On 5 Mar 2026, at 8:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> 
>> ﻿Aditya Garg <gargaditya08@live.com> writes:
>> 
>> [administrivia]
>> 
>>    Please do not send patch e-mails directly at me, unless you know
>>    that I am the area authority.  Initial submissions are better
>>    sent to the list on To: list, with area experts on Cc: if you
>>    know or found out who they are.
>
> Oh sorry. I just did whatever I did in my previous contributions. I didn't know the rules changed.

No rule changes as far as I know.

>>> Starting from version 2.2000, Authen::SASL supports passing the SMTP
>>> server hostname and port to the OAUTHBEARER string passed via SMTP AUTH.
>>> Add support for the same in git-send-email.
>> 
>> The proposed log message should answer these questions as well:
>> 
>>   What happens with version before 2.2000?  Is it safe to
>>   unconditionally add parameters like this patch does, and why?
>
> It's safe to add parameters unconditionally because the library
> will simply reject them without any error. It's basically like
> declaring a variable and not using it anywhere for older
> versions. I have tested this with old libraries as well.
>
> Consider the fact that the authname variable is also not in every
> authentication method used by Authen SASL, still its declared
> unconditionally before.

These are good to have in the proposed log message.

Thanks.

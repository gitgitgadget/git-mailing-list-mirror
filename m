Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C32494293
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 18:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792174970; cv=none; b=RHhc+nt5VxpIdo/+afg9VQ2b7ZqU0AV4U3tXUjuo7+IgZu1Cy3hiqcsjpK7qjoNW5YNWoVwvFvTiRoWWQEAGhnfk2Gze4qJFt5owTjBphiOAcWjxMvCzH01+kbqOtazXZ5GWSU+FmSmS3WoOg+kfsJuSjldCsV2S1VUnh3ZYtPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792174970; c=relaxed/simple;
	bh=XzEHldfptmBXqNI/LyLNNJLMcWKgtiinzpUsUkbavjA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=hqmk0XlkZrILELs6KhoEBCxZKB+iNMjDtx3h54fVGGfIKBxm5dPF9ApzJ8NXLFWS62yTTaGwxUiUQt6bcPCqrw0JSWiDcwDm/rzmigqJuhi6YcmT6JdG50r86m+0xZJknPdAcUqgjX6wLyKqyuoEkm1NQsY6l0PR3xxIUKxLcjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=kNZsf9DM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SEA8fvIh; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="kNZsf9DM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SEA8fvIh"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9E5D014000B1
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 14:22:47 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Fri, 16 Oct 2026 14:22:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792174965;
	 x=1792261365; bh=zd68FHoPn02U/oRT+Z1aySfAXBCBUe9rrm8z8jA0M24=; b=
	kNZsf9DMeOHAsMeHoaFTm+Tza6Si5NBmw5wB1NC716OCdXv5KN3UjrSGfySv+UCo
	OzDwE8fy+MROXYmGZtlF8lzcUbaXmseUHP+/C14fycJ0+t1H1iuah+Qa2adZc9PO
	xj1TVLHeg7Sm3hsS9YaJLuDU7TDnBgrPmiweMQJZlwjmSj+ukGc/OVVE/ED5G+HV
	V28+codNSrwx/1VnX0IobBITbieOgeGwJ2N/m9lME7I27+yFGm78g4Lg7E9/2QRd
	Q3wWisigER3rHEtK4DehEF15+p8WzQTIozoX/YCQcf59KD+jPUHERwqh1/C2/UdV
	5URizbCed1JeJuEFnn6zUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792174965; x=
	1792261365; bh=zd68FHoPn02U/oRT+Z1aySfAXBCBUe9rrm8z8jA0M24=; b=S
	EA8fvIhIEVO/m7vI2Clt+osytQA//hl6et+B2M03HEn7/TfaYnmvYpEt90vzaPoT
	fzje2H4wKVY/XCn+XCeQ1OasdZUtfhrG2PEiD1t0XJpoMlm/t8p/wN/lQSFihr7p
	EKVAUna4XvoI4WzUPMXjHeN4do/H8t84o8rzB2dHcYRBosbQvN2evT+vHWDe4ann
	9UPho0x4k4OAinRwlTvVbbyTrs0vILJLupfvrWL80DhIBAF+uWQmoe914UvJ2H9f
	m8nfJE15uM9JIVcrnSVxV6CNrUTiRmHBCcGpliUFaRl7Ygs1JGmABYlzdWnCxeOy
	da109Sj9Ugxbh9tXlOTNQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792174965; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:bVn57OvSZ9vRQ+bV4/E7Lj/02kL925Nhs8JkclMwDU7x4vx
	hvQ/WRrkKxls1Ck8oqjQeT9TiX3UenIP9l3oCedUntB5eyLweUxFu4hY8Nd98uBT
	dBc4ZxfeY2tpTaDmFz7ztq9Bb/dh9bYFqNj1FBp3xstoga8J09XNhfGdclDNjtul
	o5FMKybq4uDo89epLQhUNcZgSVf9sAIXXE3N1RF2ZVhsh03zxTHGJxyn5h2SdBKQ
	iUVs6HZLavw2rsOMq2PCfO+jn9Y2zBcJJXM2+i1zY8p4oNTOtuVq+v5TSD2ufngj
	biKmNEogtgvpp6y69gKUwM69biLlovNxk1NQ4dQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:KaACrNlRd0Rdqz0CAn2ygjzltQ0bMeEWL+b0OqNnu2s=:XzEHldfptmBXqNI/LyLNNJLMcWKgtiinzpUsUkbavjA=;
X-ME-Sender: <xms:cmvSalzEzMqsjhiMp1qnnHRT575I1FJt49vn9tlJ1vhG-p664jgl5_8>
    <xme:cmvSagEX-fmK11Tv0RonoRMMyexSKeJRbQvtKdUDdcLaJwUPd2SsPFqT5OjKxZ1Lk
    wUF4oWZ5DhV9yTcQQVdcF2m6tLiLFeDmXly1T5SLaFzC0IIxAhdpd0>
X-ME-Proxy-Cause: dmFkZTFwXF6OADjnZI6laQ81b91zvnxchYGqzNfPN965otTzjHpxnBj3WoxPKI+szQyAwG
    8DOGvnhk8bolNZZsP8y13CAJXmDVebo0hZZNiI5XqfCabbs4pshZ6lzdLFq7qz22gWPAD8
    L9+PSXa2fLdRu97NI33y1zuvqqyFl8JUamGnVjwr4fT3hGqRhDaIWu2n6dliwE9bbwZSFV
    AddOOaVnet5DzDKMx7hSC933/Vo3dXyBUWLvrZni+CFxeSnGia4txqpBWq4sB4rlzExW1w
    6soGNWbXqIc0S6VSmB+9VGgRxqN1E1briYWwKELE2KRyR/cOn63kpPiOaXaSrfnT9lqVBQ
    OcDZITlwiu2EANrYY0t4W5DIuOFlJOnfhv6NkiZtrGB3c22a05AWCkFGwq+ouk7R3yUndk
    nTUF0feib2pnWXD8/X9Mmzzrscz33II8Ruyrj+rTnsjUc7PdOeAs4rt/P6Llca2iRuUiKE
    IOQzqqBQA/MXeWWborl6ao7xQxvbjno0axlySts3jNS1ENEDrNoeeM64+1TLKuPw7zXzXn
    aU71Cdnn10YKh5RJiXLs/5OE6RSodXmVvxayMbddcs50S1GsnGXqDh9HxmrEoKKOlw31a1
    Su1Nx4BGPv6QlGeGXONVa8Eo+LR5iDm5zH6VwY6QC1KoU915zwXr3z5JRTWg
X-ME-Proxy: <xmx:c2vSag0sSPjxcXtwPSBvjef87K0OGMvF5EqDIvgWCZZNWY5F_ox2FA>
    <xmx:c2vSasmZ6_XrKLbZKHsrvvj4XichpnhRbWj5gOxtiEF_WFpTtJiViQ>
    <xmx:c2vSao_N3Knv3RcJaBYcHl0w8SXJEMK4lj_TUgiKn1nMfnocSLke1w>
    <xmx:c2vSappZgjnxTBrCQSn3Ln-OhZTqxoe6s5R4L3Yg0SW4dZ-gXh8B6w>
    <xmx:dWvSaobGg0vaOtHnwypvZm39odrng2xVmx-TS0uox8OZqyrOjACFYd6w>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 5406F22C009D; Fri, 16 Oct 2026 14:22:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AdFTpIy9UMIo
Date: Fri, 16 Oct 2026 20:21:40 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Junio C Hamano" <gitster@pobox.com>
Cc: =?UTF-8?Q?Bence_Cs=C3=B3k=C3=A1s?= <bence.csokas@arm.com>,
 git@vger.kernel.org, "Jeff King" <peff@peff.net>
Message-Id: <d7450b0c-89ad-4963-9229-198f40cf72c1@app.fastmail.com>
In-Reply-To: 
 <CALnO6CA7vxpmhVB3pi3gpVcbtCS_yHtA+a1Ud25P00JDAqboAA@mail.gmail.com>
References: <4e8d8b75-ddf4-4602-a2a8-26e5214c65f0@arm.com>
 <CALnO6CCph_xC394v_BetLPyoriYc9dLZY42LsXhjVNdvt2e-cQ@mail.gmail.com>
 <958622c0-e0a5-4e27-9815-cd1fff2ed111@app.fastmail.com>
 <2006115b-bcf2-486a-ac7a-681caae686b4@arm.com>
 <fc3de093-a051-415c-b40e-f9df5c914704@arm.com> <xmqq4ielirpr.fsf@gitster.g>
 <CALnO6CA7vxpmhVB3pi3gpVcbtCS_yHtA+a1Ud25P00JDAqboAA@mail.gmail.com>
Subject: Re: [Bug] Porcelain allows creation of '@' branch
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026, at 20:09, D. Ben Knoble wrote:
> On Fri, Oct 16, 2026 at 11:35=E2=80=AFAM Junio C Hamano <gitster@pobox=
.com> wrote:
>>
>> Bence Cs=C3=B3k=C3=A1s <bence.csokas@arm.com> writes:
>>
>> > On 2026. 09. 03. 14:35, Bence Cs=C3=B3k=C3=A1s wrote:
>>>>>[snip]
>> >> Bence
>> >
>> > P.S.:
>> >
>> > $  history | grep 'git .*@' | wc -l
>> > 74
>> > $  history | grep HEAD | wc -l
>> > 0
>> >
>> > ;)
>>
>> You have some unlearning of a bad habit to do, then ;-)
>
> Phaw! What's good (short and easy to type) for interactive use may not
> be great for scripts, sure, (in which case spelling out long options,
> writing HEAD, etc., is advisable).
>
> But shorthands are convenient day-to-day. What's a bad habit about tha=
t?
>
> (Besides, the OP's grep also counts uses of
> @{upstream}/@{u}/@{push}/reflog syntax/etc.)

I set up `git symbolic-ref refs/H HEAD` after my first `@`
conversation.[1]

=F0=9F=94=97 1: https://lore.kernel.org/git/xmqqy12z7eti.fsf@gitster.g/

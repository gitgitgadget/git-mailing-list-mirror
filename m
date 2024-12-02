Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2ACD1632E6
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 21:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733173823; cv=none; b=bNowubiqh4jGCocmkkiB091b0eAVtUaadCuzrY4Ql3Ksjdaah6qKXXN3TYQsBteucgz4X9/ydUWN6UYjoybwVeESkDVDYN27lLvLyYZ28z5uz1rmtKW/ceOM7/RKApk3vtowaRt8j9qwFE5xXefTkBmCh2PiYgSf4CDvtv61Kng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733173823; c=relaxed/simple;
	bh=M2/wNnKIEpUGKyXwcRtRHPjwC8eZjriqcwAaLlTZFcg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=QHQ8tTA0Z4hnx9h11r5ETp5INsMyVKWeYh6vvpQTDzLcIyFlcx8jYs1JKEljYJY4nLA+UNOLuh2KnJiLUQSDwdQsy97X1FsKsp8oqECVsLRuMYXCdD8rgW92GyFUeMsCiKZnOxoIS1ObhKNt4EFb6Ewlm3l5CzwEKClf3LXwnC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Yrs3zsl7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iYFkK5W/; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Yrs3zsl7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iYFkK5W/"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0A886114021C;
	Mon,  2 Dec 2024 16:10:20 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Mon, 02 Dec 2024 16:10:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733173820;
	 x=1733260220; bh=cNGjsjvoKrb72S2FtbiNzOMDaziK+dfH4Jx+Lk0kiDo=; b=
	Yrs3zsl7TIsLAsiR1Wmsg0hGxU57rBcgV4j2VCWXrPBRo4W6drK+3HL2L3M6EVRy
	WXJZRF0ABIp2NWIVtavv6Idwq3jrngL11W8eIBh78z7NUWA/qILcnhukoIElXhSR
	tz5P1Zb6Va9TGdRI7HGIBfQqItS/CL9bslNVbiitNobcYYbegaArKqyRZK1tYz8E
	UU8nSV7WkkmjLjE3dvJD9KPayVzbB70Sreja1NkhV7bzY/2+uE+SKxzbiJaIaA9c
	40rZg5v1q3OFnQIEjvHyIJZqpqxhyKhB+6Hnx2jlk/62TJtkR5w/TkVTiVD5UcNS
	/HdtnZk1rQD8zn/TSWXwAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733173820; x=
	1733260220; bh=cNGjsjvoKrb72S2FtbiNzOMDaziK+dfH4Jx+Lk0kiDo=; b=i
	YFkK5W/rUJDJU0wR4cIUti49pPEPqZUf5iJhTgyR9FPoQKPwswC0faFDN7nLhDpF
	2Qiy92gSTWEFrlcoGruTeiIkzcRD2Rl9vEDI+EJ9YlM3QkbmRZKkLacMqB5xe3ka
	6Fmf+o5+XJvTxCA5XuQdiQs//B8+q2eqL/n3W7YEo6nzvMtlwV2sxkzMatQ4yNas
	pAf4gUqvaqhGEUrLvSR9JJuaf6ZMXpte8Sk5RVbNW4npLBxTyGcuRrfVETxZ1zYJ
	1o37iO+aTYuunvYatW765S9ZatOr7Aw9H05ILYoTTNHK4dB3+J8Q3z6ghJuaDvHX
	qQp0mJAXOhQqHDAyQuctA==
X-ME-Sender: <xms:OyJOZ0MIwqLLz_2KQyl2Ix96WSMCPvrAspP2kglbGJeIX_szn5zEFUk>
    <xme:OyJOZ6_Sw5_DB9NQv_w8-bPB2ZKP7RdFQivA1L4veO58QzE_KOcRFs84fL-xvMKsf
    SixaL2vFqjudHIlSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrheelgddugeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefoggffhf
    fvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcu
    jfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrsh
    htmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedulefhveefueehueevteelueeh
    keeljeefhefgkeejvdefvefgtdejffevffelfeenucffohhmrghinhepghhithdrihhtne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhs
    thhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtph
    htthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehjohifihhl
    rdguvgdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:OyJOZ7RGXuiA40Ng7Ovp9cXXHPNHFlQEEi1k-7KBmCKxEQSOZmLcbA>
    <xmx:OyJOZ8s-fS4W-JhveibktjsacpuD_d3Gs54cgZZE6RqV5aTga9-RtQ>
    <xmx:OyJOZ8fiJXs-gQU3VlRTb5dUORHFR7azve8S3sw1IayQtbtlp3PY4A>
    <xmx:OyJOZw31OpssIOsHx5PpLOuXnZZi8ftDcIU9TRsuvaYaZVjyUh4alg>
    <xmx:PCJOZ04PVgRP6Nw_3oqBXKHkIcB7XYpDNBWAymTu8FzXRZfa_MXYAyFE>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8C216780068; Mon,  2 Dec 2024 16:10:19 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 02 Dec 2024 22:09:57 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Jeff King" <peff@peff.net>
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org, git@jowil.de
Message-Id: <be4dccb2-70f1-4687-a052-caeb86e4e1c7@app.fastmail.com>
In-Reply-To: <20241202210006.GE776185@coredump.intra.peff.net>
References: <20241202070714.3028549-1-gitster@pobox.com>
 <20241202070714.3028549-4-gitster@pobox.com>
 <477f0dbd-60ed-4f73-b945-cdbdaf9f510a@app.fastmail.com>
 <20241202210006.GE776185@coredump.intra.peff.net>
Subject: Re: [PATCH 3/4] t5604: do not expect that HEAD is a valid tagname
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024, at 22:00, Jeff King wrote:
> On Mon, Dec 02, 2024 at 01:19:56PM +0100, Kristoffer Haugsbakk wrote:
>
>> On Mon, Dec 2, 2024, at 08:07, Junio C Hamano wrote:
>> > 09116a1c (refs: loosen over-strict "format" check, 2011-11-16)
>>
>> Nit/confusion: the abbreviated hash is only eight hexes long.  I=E2=80=
=99m used to it
>> being 11 for this project?
>
> It's not a fixed size. Long ago, the rule was "enough to be unique, but
> at least 7 (or whatever you set core.abbrev to)". These days that "7" =
is
> scaled based on the number of objects in the repo. See e6c587c733
> (abbrev: auto size the default abbreviation, 2016-09-30).

Yes.  11 was based on the output I get as well as what seemed normal in =
the
recent git log.

>
> So I'd expect 10 digits in a fresh clone of git.git. It's possible Jun=
io
> has set core.abbrev to something fixed, though.
>
>> Does the age of the commit matter?
>
> Nope, it shouldn't.

Makes sense.  Thanks.

--=20
Kristoffer Haugsbakk

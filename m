Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC17274B3B
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 15:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770823405; cv=none; b=E0KHRGjzMGAmQD5yFYWE5rUw9kJQogXDI1Z633kF4TFshavH1HNItsqFkeB5S9zt159xEmae97Tq2t4OHXbO/GuV0j73k4fl9ZrhDwiih5/Yow4ds7vG0yOF89XLes1loX8cEZdrSABWq8EU7PZRdKuXq039EBVJbwOlaSgw4M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770823405; c=relaxed/simple;
	bh=6MFBwmwBZQxZ/F6uQU8sU5C7cErhnFxJv3vCHjYlYrU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=fVb7pnye99mD0xvv6Y/NGOZUWbZhI1b6jScbY6VE9Cw+soFi8cbRM0DY+dWpOAKs7YH7gsEXp3ShBC9wVWai5443Ts8w8VK2TBuRslzXsVC/7AUzzSsD58uvSbMNvQYZf+jrssSXqjQhljhsUhA2+TMth3RiwbZc9KOArw39+pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=rZrGRgPq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uRccyPQ/; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="rZrGRgPq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uRccyPQ/"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 2F31DEC0580;
	Wed, 11 Feb 2026 10:23:23 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Wed, 11 Feb 2026 10:23:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770823403;
	 x=1770909803; bh=6MFBwmwBZQxZ/F6uQU8sU5C7cErhnFxJv3vCHjYlYrU=; b=
	rZrGRgPqEJEiGPi/8Bl7HEndJO9oXH1ozeyt+Ei+uUymToVSiRe5RXs2+FsZCDUd
	GPAjPJmEj73USGz2DmZ0Jr2cKozH6Sn8dSgJK+vIpghGO8WHnZNFmtZwlHWq80wP
	khm96V5aSL4B9CTnrgAdp0DuNw88MudpYQ5zu0EeWSkUpA5+Y0rTpHETjUHZHpEu
	yzpymbVHmZfYK2n9MMiTjhNugBcDMRJ06EUNNP8WxSntPeXca8Pz9tFi+pypJE2F
	HSWTjn0W9A3Dl+PBu/n9bDM0zG5/MuNtC9O03AP/PHDMbyI6NM+dCEYngzV73ATR
	I21wNN0WXVcA3xeyoc/ozQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770823403; x=
	1770909803; bh=6MFBwmwBZQxZ/F6uQU8sU5C7cErhnFxJv3vCHjYlYrU=; b=u
	RccyPQ/yCcmzULdTGodnY9Gg+5UZEoVoGiSzQ+gwydMyMEJXBc+zDKIPfkE8pbS/
	eIiZNapS9mbjLbWa4IEuhThGsM0ynmryM4nMcopuzD3d11iN2Nt48tl7Mt2RQAAf
	wY3Aq/Rm2GIaWdysrdLZRZ0mo9csb4MdVuaWTdOxgOJghEFURv3t4ZAltGZLn1J9
	L2ppJlmNRQNBYgRQc4pMK5m2vHWnTiUg/45LEmBzpyfSwTUY7YcQLxcQJc6D6Y23
	vckMWkmhifmnTidAReC8RGI5Z+/BGXBdItEK7nVEDKmIhlsW4wD/GMmkbiJm3iJU
	DCuds7zAJUKB424j/Uw3Q==
X-ME-Sender: <xms:6p6MaTLWosW4a7w6bxiOijZv9-cwTp_rdf7zO8ln6c_ZXYRNjVkNef0>
    <xme:6p6MaR_zbCD-AwrMDmGfanBXz9mBnmzD-qV0JRyzTKY3XPzt2HcF6CS_CIYCkYaxL
    rprrJ0socDQKgYyUWB1dENF7JvZo7bENMQ1Rst60yIg_G-d4JjicyI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddvledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeejpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehmrghilhessggvhigvrhhmrghtthhhihgr
    shdruggvpdhrtghpthhtohepjhgrtghosgdrkhgvlhhlvghrsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepphihohhkrghgrghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgv
    fhhfsehpvghffhdrnhgvthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:6p6MaXAaxBvBPk1t1HmocOl1a_crxmWflVSNw6aL4gRhfqgv_jEreQ>
    <xmx:6p6MaeNPLxBqprynD4vJRpPcopmrYxElXDLXuGTrDBrh131x_ncSDg>
    <xmx:6p6MaQzK4yxuyAeArvmPJvRl8J2s9tqT1iUCOmND5zcTHZT4f7W8zw>
    <xmx:6p6MaeUu4cHmIuD1HoelVlWwZOUlgvxigQrK-BFLnVJxAhc878Boag>
    <xmx:656MaU4HvdDJfeHPUzj5hpr9eJf-SzpRU1WBTOUgXQLDmFdKzTX1x7Rh>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6E00C1EA006B; Wed, 11 Feb 2026 10:23:22 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A2RKoXrlnTsZ
Date: Wed, 11 Feb 2026 16:23:02 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Jeff King" <peff@peff.net>, "Jacob Keller" <jacob.keller@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>, "Patrick Steinhardt" <ps@pks.im>,
 "Matthias Beyer" <mail@beyermatthias.de>, git@vger.kernel.org,
 pyokagan@gmail.com
Message-Id: <958c4cb1-8ca0-4559-abfc-b50d009cc680@app.fastmail.com>
In-Reply-To: <20260211074751.GB1867915@coredump.intra.peff.net>
References: <bcqvh7ahjjgzpgxwnr4kh3hfkksfruf54refyry3ha7qk7dldf@fij5calmscvm>
 <CA+P7+xqcBcV8uySGgDfvt2ruAnFmfgaUy6aRbUC2zCzmCgPubw@mail.gmail.com>
 <hn6q2mdjdqezzvtxfxffmatctnlf4ttvwedfk7wnw7xw75gy4g@hetctv53f7bh>
 <20260206090358.GA2761602@coredump.intra.peff.net> <aYoEO0CcVt2Qjgnb@pks.im>
 <CA+P7+xrNycJHTyJwn9AQcJLG0dDAE7KrTvWTHBi+CiQUqK8p5A@mail.gmail.com>
 <aYs_P8QujA6mL81-@pks.im> <xmqq34381tze.fsf@gitster.g>
 <CA+P7+xo0-9h_V8xGQaEdgBEaxjrbrNOdPfmFmhKup+Z-7w0zUw@mail.gmail.com>
 <CA+P7+xpYSyhBoC23RLycVXFSBB2=dgsQrnvLkk0D7afOqWyafA@mail.gmail.com>
 <20260211074751.GB1867915@coredump.intra.peff.net>
Subject: Re: git-am applies commit message diffs
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 11, 2026, at 08:47, Jeff King wrote:
> On Tue, Feb 10, 2026 at 06:34:05PM -0800, Jacob Keller wrote:
>
>> > Hmm. If we add a new unambiguous marker after the ---, old versions
>> > would see '...' and know to cut the description. New versions would
>> > wait for <NEW MARKER> and properly ignore any diff/etc prior to thi=
s.
>> >
>> > Since <NEW MARKER> is after a ---, it would be ignored and not
>> > inserted as part of the commit message, and because all versions
>> > universally accept cruft between --- and the diff start, this should
>> > be acceptable right?
>>
>> Keeping in mind we'd have to use <NEW MARKER> as something that we
>> somehow reject as being a valid part of a commit message somehow, so
>> that you can't accidentally insert it, and we'd need to be careful
>> about rejecting formatting such a patch, and probably complaining on
>> the receiving end if we see multiple markers.. Trickier than it sounds
>> I imagine.
>
> Yeah, on reading your first message, I wondered if we would run into a
> commit message adding "---" followed by the new marker. If the new
> marker is forbidden, I guess that works. But how ugly is that new mark=
er
> going to be, then? ;) We'll now see it in every email.

Maybe it could be something like `<symbols><space>`? It=E2=80=99s diffic=
ult to accidentally=20
get a trailing whitespace into a commit.

> If we are going to modify what format-patch produces, I'd be more
> inclined to have it perform some reversible quoting on the commit
> message so that "---" and "diff" lines are not recognized. And then th=
at
> quoting only has to kick in when a message would be ambiguous, so most
> people wouldn't even see it.

This sounds better anyway.

>[snip]

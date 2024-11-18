Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F262914D2B7
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 20:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731960273; cv=none; b=DNjJ7ByY2XHq16uWbi7Bb9rq0PfjYqJag0wH1S2J0WaDpvTHXHltuC75wPjo5WCiGu3HcytD6MtkYOwLcNhsTIUjssVeg5xnGg4wxmuk0xZDxXtqKdmf/n9rClM48zPyuz2fTqRxZa/Q1HlSQm0WxJL6yODmQcKQ56B/xI1NPLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731960273; c=relaxed/simple;
	bh=i/I9RGJIwehxIbqXqntMGSeqGwk5IyPUTfBYoOZCMgk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=dPAzlnrBKm5LsZrIwUzSYFDUIW/yJSPlkOkAi06Dnrgald61xdHFKHB1Pnv8oO5zcagi+/QT2tQOwpZ/nuRc7By8EL8cAMJOXBcRukvLdQF7tspwWLA0BEgXnYEIKv3lSueHrKrsLcYV/N7XK42KiCdN3M1ZoaLjogA/H5ZHbwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=revi.email; spf=pass smtp.mailfrom=revi.email; dkim=pass (2048-bit key) header.d=revi.email header.i=@revi.email header.b=mwhlSXqk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eQcFei55; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=revi.email
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=revi.email
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=revi.email header.i=@revi.email header.b="mwhlSXqk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eQcFei55"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EB14325401C2;
	Mon, 18 Nov 2024 15:04:29 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-01.internal (MEProxy); Mon, 18 Nov 2024 15:04:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=revi.email; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1731960269;
	 x=1732046669; bh=4bpBq38ZlPxrijwvPjvggiKxhWAsK51cxILpkD/qxtg=; b=
	mwhlSXqk2j7c563jAvdb5cHA0VqRmyIQVCfnVU13rMO8S1pFz8yquSpLhEbRH1Vt
	1tsEMQPkMUys14Iz2e3QuE+Rcq2D1Ir7LwFkvmuHxAfk4Nt3dggmxDy/P6PSL6J7
	q5tv2O5TfIw7sAvigzJzMosHVo/0/ThFh9+ZXdMs06gzYhAIMswbkK682HpePtjs
	69VVr/VcPSDukq9GG6HyftFgW8EsFf/XJ2AZSCzJGqtiJ92na90RFRENn+Vxb4KU
	93KeJF9uhmfcWs0/PdILrHqdmdQ092UgBQsijZqx4pskg47CZ6DLR+ajvCZyB04G
	AM7vkQUA2e8ZzHQOEapFOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731960269; x=
	1732046669; bh=4bpBq38ZlPxrijwvPjvggiKxhWAsK51cxILpkD/qxtg=; b=e
	QcFei553GXS5AMFGwS8N2+mBJDHixeMoQptFD/MSmSD3lk132+F+X29aboAF5cgl
	tEkorVPikM7jKNqzFwKuXBPidRw8lilacBx6vekMaj1SjjkXH+aWE9b6g9uF7GS5
	uBpUEqS181B3p/6MWrkrpUy2Mb7ckPM5Z4el3Y8Ncf91FkM/lP2KbK0cYQk/BhED
	45rhpehL8GKk8t5LSPN4UakAfkqS7LLfEPZ3A1YYqKiOTDVB86lTnDvZo0drlEwT
	qSh2R7NybpYgWrpKkyVzkvmeA5/NHj2J8WC7m8rQXERnv2Mx61Tz2NmH9Af05RwM
	8HBYENjBL6frS+ya6ELBA==
X-ME-Sender: <xms:zZ07Z2Tt_NcDPKrqM12vJgTe5bS22LRqShS6T8T4Tmuzg3A_Th5RWw>
    <xme:zZ07Z7wHHwwUC0mEjyMuvp2ZGUtfb3rpiAYNpeYNSWQ_031oVxthpuaA8j2GqUUwa
    jfu84Rm9VYeD-khDNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfedtgddufeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnegoufhushhpvggtthffohhmrghinhculdegledmnegfrhhlucfv
    nfffucdludejmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenuc
    fhrhhomhepjghonhhgmhhinhcuoeihvgifohhnsehrvghvihdrvghmrghilheqnecuggft
    rfgrthhtvghrnhepteffhfetledtgfffgfeuteeljeekkeejuddtffdtteetieffleetfe
    fhheetvdefnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpphhrohhtohhnrdhmvgdp
    rhgvvhhirdighiiipdifihhkihhpvgguihgrrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhephigvfihonhesrhgvvhhirdgvmhgrihhl
    pdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrpg
    gsuhhghhhunhhtvghrsehprhhothhonhdrmhgvpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:zZ07Zz2L2Sodus4aunDFg0Cna_PjBCw6BeW7bC6hyjzufV94cAQX9g>
    <xmx:zZ07ZyCD2DhCnaSl1smMHWpW_Gyo34D6fzmgkAr79zNz1j7O2aLzxw>
    <xmx:zZ07Z_hYwpfL7zvmdRRf8YXjT-9VDAMhygUvNRXlFceCY6s1kiet9g>
    <xmx:zZ07Z-pNNc-l3PctbLAdcbV1SQxoXerFxXJRaLVC8zGxAJ4ENSU9bA>
    <xmx:zZ07Z3bSULybst9S83d_2KbkvKbZDNDIMH5aMakb2IBWEWrq8lmRVcXj>
Feedback-ID: ie2a949ef:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 084BD780068; Mon, 18 Nov 2024 15:04:28 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 19 Nov 2024 05:04:07 +0900
From: Yongmin <yewon@revi.email>
To: "A bughunter" <A_bughunter@proton.me>
Cc: "git.vger.kernel" <git@vger.kernel.org>
Message-Id: <055a53b5-2107-4547-8a64-e269705de80a@app.fastmail.com>
In-Reply-To: 
 <lLSbsbSEi1ltdY3N1MKhGPVHTPeII5XsqVcYwmh_WHIjVAlNyktnNEaLgBUkh6stvHLE371tlmlhOTdoFloVic-Wq0wE0pQYLBeeVuvA_oA=@proton.me>
References: 
 <Sj2qFJa5yPRxluqhZvXlMwgfLuX9n6Um4OOS9IHNXCJU3jjE0YblQDUt0rOpEzY-fUHs5CiognunZO-ddQN-1IVVBEyxLz_2hl936VBW-JU=@proton.me>
 <lLSbsbSEi1ltdY3N1MKhGPVHTPeII5XsqVcYwmh_WHIjVAlNyktnNEaLgBUkh6stvHLE371tlmlhOTdoFloVic-Wq0wE0pQYLBeeVuvA_oA=@proton.me>
Subject: Re: How do you hyperlink a thread
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2024-11-19 (Tue) 04:51:49+09:00, A bughunter <A_bughunter@proton.me> =
wrote:
>
> Hello, why isn't anybody answering me? I see an active list.

Because, when you display aggressive attitude[1][2] for those who try to=
 help you on their (mostly) free time, you do not want to involve yourse=
lf with them.

Anyway, check out https://lore.kernel.org/git/ . (You see an example bel=
ow.)

[1]: https://lore.kernel.org/all/82f3cj_ASv_HNkdAe-1doxp6Vii0saBTB2wYbcw=
CEC3vDJpiwXvN6a6Agw7qNhKsGpBD8EbDC2u4VipTDJNr19nYcVV4BqV4GgNG9ysr5y4=3D@=
proton.me/
[2]: https://lore.kernel.org/all/xDO5bMcFOIbJ5FhdpoxteVDBBjf5xXcVxQ5HboX=
dp-l_JojbIZ5gKERafNA0DdIFubVEupPQ3NqyoovEgsFJannL8A-9WqpzJIq-5sC0chI=3D@=
proton.me/

--=20
----
revi | =EB=A0=88=EB=B9=84 (IPA: l=C9=9Bbi)
- https://revi.xyz
- he/him <https://revi.xyz/pronoun-is/>
- What time is it in my timezone? <https://issuetracker.revi.xyz/u/time>
- OpenPGP <https://revi.xyz/pgp/>
- In this Korean name <https://en.wikipedia.org/wiki/Korean_name>, the f=
amily name is Hong <https://en.wikipedia.org/wiki/Hong_(Korean_surname)>,
  which makes my name HONG Yongmin.
- I reply when my time permits. Don't feel pressured to reply ASAP;
  take your time and respond at your schedule.

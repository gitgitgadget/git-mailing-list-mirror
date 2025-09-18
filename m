Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D832F3600
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 20:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758229127; cv=none; b=ZcKFXJh3DpYM9XEAgUqyBV8uKOxoktSnF1ufL7nXU907xqpTD0TvZYnEdLf1fs6t/zbLfgBvAxFjG6Diwj4Qry8OcsKRxS3jlkh5/YN6f7e8LAhIujl6SiGH7gl9nN1dqD8yaLf4TkVtEmSqLt1yGDgdu0n+tBw+VSx1Yd27gUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758229127; c=relaxed/simple;
	bh=E86Q1GQDCbPVAz3MOn89bNRLfo/8euBMf3DBNrr7FGA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=UdarqhokqzPBjYOqZ5aNqKNWhuOA4oMiuq4PlvF8L1y0MLzgVUO7hEt1MCIkrHKMqgSvq4lW+m7Pzua/s/A7Q4azwqmmPXblfuNwaQJW50FPQFzJjIk/ODzEzTjFVoOi9yXnknPyI38y+Y3amBHiU+iIjF9E2Rn4Kv6LI0RwNrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=CsivL0ZP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bXVdYLIE; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="CsivL0ZP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bXVdYLIE"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id C4B5A1D002F0;
	Thu, 18 Sep 2025 16:58:43 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Thu, 18 Sep 2025 16:58:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758229123;
	 x=1758315523; bh=S1Qa5jH63wOdie8XSRAlVyWMV/a9u227ItwZQvlp2T0=; b=
	CsivL0ZP2ov7Fv4uhqoPUHCSNj5FS9ThSYChmjQfR3B5vwubKdFahjUSa+fWW2BN
	JmuOYe033lSyepZumayR2lOTa34Dj0NLNKt6iJENmBqwZC5mATvqPyDt7pAQh0IV
	imL0a1kTxWwOKI2y3PWjpQ7x7+N7D4/p7RpaVEPZ0aFkxl031aqPbyJnUhCqgJFm
	4inW+BVdR6LILR8OAGuBW9tuGZ1968SNo6l8V0J6l0O4oA++dYmabdtDPNEnsl4j
	EB1O83+az5oyoTOdA3R53BSeyewlE+Uafzj6GykBw1q1c2QkUgY66lm2VX3wCl9v
	XV2zRQYbZ0Yoa7Rc5iZWzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758229123; x=
	1758315523; bh=S1Qa5jH63wOdie8XSRAlVyWMV/a9u227ItwZQvlp2T0=; b=b
	XVdYLIEImhykYKfKOhuoQnqM0aIpoA+g8CbmJDCHwEWOxENfvDapRAcYn6YAfHSd
	FP6+JYdipx4znFByJnY1GyO6lHG3qrWqg9F8qaT5/tkYXOi8qgbqUP6F2rO+YTn2
	DtJOjkpF4KRLRSeQhn/jfIv5k7TN3i6KHvHzGmSXV4UlblSVpx+vsyutl/lLNyVA
	4u4/HFpsRDzIbiiifOaDZ0WMreQ5duv7QAmlq49BQM298+IP1MHiNle/+icTyPhZ
	4y5IeG9Lft8sN5Py7kx3OKpU+DLrKyQV3aqpYGgk5O2ERG4ggXmnpmsBdBigKqkO
	j/XM8mxtNdMgOa1Irch0w==
X-ME-Sender: <xms:g3LMaEqB8BcN1ndv_6rutDk30exp8v8f3nuPco1ERYxmgVQCLL-o4To>
    <xme:g3LMaKqkvemMgugcAyZacn3y_atk0vZ6cD5lNZTLvtrekWZfwvgHnU2Upcmsgj1wz
    vVSeJY2Hy1C7rSwyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegjeefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeehudfgvefgfefg
    ffdvhfffvdevveegheehudetvdfgueffjeevjedugeevfedvfeenucffohhmrghinhepkh
    gvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehguhhsth
    grvhhordhvvghlrghstghohhesghhmrghilhdrtghomhdprhgtphhtthhopehguhhsthgr
    vhhordhvvghlrghstghoqdhhvghrnhgrnhguvgiisehnvghtrghpphdrtghomhdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:g3LMaDrYqd0152tIUsGZF4J73CyMDC2k_kuVdUSL93Frm7UQC4APVw>
    <xmx:g3LMaKzpItB6sCz6SHIX5ZNJTulUNIOB0hdU3hsDU6sHZwLB8kLg3A>
    <xmx:g3LMaPNfWpMT-lEXsyJjSh9kUK781BwNA1UNLU3p0XxasdDHBCdB2A>
    <xmx:g3LMaH507HMjFFaCPD40UVl9JORmmuVmjCNdF9_YktcKxzRGp-dpsA>
    <xmx:g3LMaKAxFec3A4EGkwt1xJ7IqD7MautteONMktsS2Y21hcYeOgfC31fr>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 24E961EA0068; Thu, 18 Sep 2025 16:58:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A4llZu9Ahe03
Date: Thu, 18 Sep 2025 22:58:22 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Josh Soref" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
 =?UTF-8?Q?Gustavo_Velasco-Hern=C3=A1ndez?= <gustavo.velascoh@gmail.com>,
 "Gustavo Velasco-Hernandez" <Gustavo.Velasco-Hernandez@netapp.com>
Message-Id: <78b4ca8a-0440-46a6-8281-a369cb73c304@app.fastmail.com>
In-Reply-To: <97770221-63b8-4375-9787-991717594938@app.fastmail.com>
References: <pull.2028.git.git.1754922884439.gitgitgadget@gmail.com>
 <pull.2028.v2.git.git.1758038628948.gitgitgadget@gmail.com>
 <xmqqzfaumi2b.fsf@gitster.g>
 <97770221-63b8-4375-9787-991717594938@app.fastmail.com>
Subject: Re: [PATCH v2] docs: update description for '--mirror' option for 'git push'
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025, at 22:04, Kristoffer Haugsbakk wrote:
>>[snip]
>> just before your own sign-off.  See an example like
>>
>> https://lore.kernel.org/git/2f78ab2e28c64f05d807cb9460fa62eb1011a57f.=
1757879060.git.code@khaugsbakk.name/
>>
>> (by the way, oh, gee, that's an unwieldy long message ID).
>
> It is.  Considering I only send out (git send-)emails at most
> every 15 seconds. ;=E2=80=93(

And I don=E2=80=99t understand why there=E2=80=99s a full SHA1 plus the =
Unix time.[1]
The Unix time ends up being the same on all patches.  So you need
something more.  But the abbreviated SHA1 for each commit guarantees
that each Message-ID (msgid) will be unique, no?  Why the whole thing?

With an abbreviated SHA1 + Unix time you get:

1. Unique substrings within series from the SHA1s
2. Unique substring among other series from the Unix time unless you
   generate and send out emails very fast

It wouldn=E2=80=99t surprise me if there are people who have taken advan=
tage of
the format to harvest the SHA1 from the message id, even though it isn=E2=
=80=99t
documented (seems like).  But I think I=E2=80=99ll be fine with an abbre=
viated
hash in my own tree.

=E2=80=A0 1: I did some spelunking and it seems like it has always had t=
his
    format.[2] Or at least in the C form.  I don=E2=80=99t know if there=
 was a
    previous shell or Perl form.
=E2=80=A0 2: See d1566f7883f (git-format-patch: Make the second and subs=
equent mails
    replies to the first, 2006-07-14)

--=20
KriHau


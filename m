Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DC0364E9D
	for <git@vger.kernel.org>; Thu, 20 Nov 2025 15:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763651878; cv=none; b=c/jeWWsNbdid5HRkGuPGYWvg/E+jU6RudVhw/iLtUyoYgwFjfTTTP4G4xRDBqfhiJXHnG/jJEgsNYzljCuAM5KNW9vhRuZA1SsglHc4J9psQ6P5MRqL8EVNp5YTPig+OthK0zw6NtiYAX48AUqCbbzX8O32nl3h7qp4zXfe1aA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763651878; c=relaxed/simple;
	bh=gWXGC9dXPeejvI/w8ANcTiIDjbdPKNlWWkobI1nFIzg=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=tJZHwNq4gcRG8r7yndxDgcjLfLAgW6SaD2RzG2UhLnZQQ/17ruqnQpBNYnfIXhVzPcC+WSLlHeqGkqgfhzaW/LYpgf9Zpf/D9VsMCuOd2f36xhotAhu+ChoAbayaZYjzZl2edYGM9Kcipgtewqpls+tdaPneT4ySvHJpkGZ1L1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=AGdfmWdh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0/IyCCsf; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="AGdfmWdh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0/IyCCsf"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 97C111D00161;
	Thu, 20 Nov 2025 10:17:54 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Thu, 20 Nov 2025 10:17:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763651874;
	 x=1763738274; bh=vayJDX3nMgmCyBe6doRcs5awIdkOwBacRHqhcuyW++A=; b=
	AGdfmWdhjLI+a/6rEKn2spbYMMKsaA17UouFq4pUdmYrT01WQjyJ6Rz5tebW2VaD
	FsfCGGz+ZZ2VYvs21aEWac8Yx5Vv7SGnI5oQWkQFA2QMVwrUEGQkCEdMbCa4mO+F
	PfRDZYTyRfjm1jMMg+t35sqUhZr9KaY6kr8BWaSw/susUY8Ld1z4eXEX12Loeojz
	iqg1W0uOoHWOKNK9hKMt07jiFiuxO0VtWPM5dJfgqu0FH88+VnqRtQmm1IIap3Fp
	WmLXwiwTzEDyLhc1GkWUxxQAztWk07rDR1ofDiixKxQxcRX7nSL5ByAAcsLirF9i
	F4MLC6XZkcgfit4BFR4njQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1763651874; x=1763738274; bh=v
	ayJDX3nMgmCyBe6doRcs5awIdkOwBacRHqhcuyW++A=; b=0/IyCCsf+BARQNPHz
	mfO8r+QXDqBuigrU2OBuFkCJHBkvxkgcfG+V512XJ+Ih5uS47DrwpDbMrrUu3LTI
	7FQEB+VKqYvZNsAWXloYph9AsgzY3cGzRp5ouZ7RN49u7olTtQ/8vYgSjTIUX7Kk
	mElA48nV6sI8TKxyn0VH3qyaGqPclAEBpXRaehia8rOgA6zJ+M1mxjDvMbyhQ19t
	+Qo6241+qrmFcnN7Z91+3GMnnwJgz11Yv3Rz7f2EswRyCXBQiTnW5lhVHbnYO0tb
	AaMh46g3kWEn6NTs8DfwATr6nkSJ9cunRj5SETXJ2aNmH73NxaVPJTuMYCjr4hXF
	WPp1w==
X-ME-Sender: <xms:IjEfaf0bzhHTm96zaIVGiJnkbTonWV9UnqoUTYbYp47ZX4Sapg9NAyA>
    <xme:IjEfaY4MstDIQ75BHd6wxirjFTxMfqgUgv83_CetHmvba87p8IjSqdFjlu3ca32XP
    RACDusj1KBqW9pTWppgnAuiUfWdrE7X2RabuJrC2VNybBlcL5QZmw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdejgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtgfffteetudel
    hfefkeehtefggeefjeevieekfeefieekkefhveeiledtkefgueenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrrhhtihhnfihguhihsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:IjEfaWh8e6vaIqcdvImH93tR4ikQwPguxNeHP0CZlevW1C_HPomPVA>
    <xmx:IjEfaU-xE_1jvaW61k0RSZrbkzosCU_3-1co09ZANEd7h7DzGA-l2g>
    <xmx:IjEfaVr2SVMaUUImv4bMPpn0VmGEN521wvr0_ihucwIwe3iStwVxgA>
    <xmx:IjEfab-rYq4KfEGkjh8L8eA3ujvqAQusGZN110vfdJjp1mf_95au1g>
    <xmx:IjEfaVrKkayqM57gscrhBZw0bJhzM6C7YyGaQiJeVOGggnS8CbbfPVk4>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2DB091EA0066; Thu, 20 Nov 2025 10:17:54 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AuwXIgXhQxCw
Date: Thu, 20 Nov 2025 16:17:33 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Martin Guy" <martinwguy@gmail.com>, git@vger.kernel.org
Message-Id: <0e971281-d1c4-4030-9297-f5e2c0765431@app.fastmail.com>
In-Reply-To: 
 <CAL4-wQrgD3nnW2BfNf6e9d7tDANE60dYBRRP_0FW3Z-LvQrZmg@mail.gmail.com>
References: 
 <CAL4-wQrgD3nnW2BfNf6e9d7tDANE60dYBRRP_0FW3Z-LvQrZmg@mail.gmail.com>
Subject: Re: Feature request: git cp
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025, at 15:56, Martin Guy wrote:
> I am splitting a large source file into three smaller ones (mp3.c into
> mad.c, lame.c and twolame.c)
> and would like the history to track the relevant lines in each file,
> like "git mv" does,
> but I only seem able to do this with one file by "git mv"ing it and
> copying that to the other
> as a new file.
>
> So what I'd like is "git cp" that is like "git mv" but where blame for
> both the resulting files
> goes back the original one, if that's possible and unless there's a
> way to achieve the same
> effect that I haven't figured out.
>
> A fairly rare thing to wish to do, but may be useful in this case.

Copies and file moves are detected dynamically when you use things like
`git log`.

Try `git log --stat --find-copies-harder`.  I get this output after copy=
ing a file three times.

     README.md =3D> rm1.md | 0
     README.md =3D> rm2.md | 0
     README.md =3D> rm3.md | 0
     3 files changed, 0 insertions(+), 0 deletions(-)

I get this output when I change one of the lines in the same commit on o=
ne of the files.

     README.md =3D> rm1.md | 2 +-
     README.md =3D> rm2.md | 0
     README.md =3D> rm3.md | 0
     3 files changed, 1 insertion(+), 1 deletion(-)

This is the first time I=E2=80=99ve tried this option so I don=E2=80=99t=
 know
more about it.

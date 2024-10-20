Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A871370
	for <git@vger.kernel.org>; Sun, 20 Oct 2024 16:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729441473; cv=none; b=Q8aTt4nNeaAm5GNBWYdDqpasrhOOuCGurJ0zYI6EeaZCkwtAbYaXFrNQAm3e9O7srQFY+Cb5vdRfNQvqKLc0EfwGVVh82o6DQDZ/3EJk3TxFQ/tnpv0D+eLE6pjbracMncIjwimskMr3bgYyPIvkjACDe2yJvfV6TEY6Y2TzfOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729441473; c=relaxed/simple;
	bh=4KhskOBvXF2yxunRIWfoX741REw0BqHuDn6SIDilDV8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=AQjOXI7MqQxweLafNENfX2hSwt3tUuBZpFlsrEPMmBbEBfmCxiX2i66L+UFc2sImZ5BJ1dvhnNo9kr17kt/J3Hsz0y0WDhlmJGqey5DHSmcoE2tYG/ZzclaUDwjVylmski2XYrZMTwXPPSufzre1yCJ60ZOiBCtYILb32qItMaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=p83r0y1H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X7S8ak4d; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="p83r0y1H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X7S8ak4d"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 619E8138020A;
	Sun, 20 Oct 2024 12:24:30 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Sun, 20 Oct 2024 12:24:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1729441470;
	 x=1729527870; bh=QEIsjuOFB+ghr/Iji+I3AvgzUWvBOhx6WoMyi1db3Kc=; b=
	p83r0y1Hd+Xq/KjtlJNIlOnlGxtQ1divWtTt9bEYRBIdafRNMe3Wcna785mbrPga
	j9JuQg0DUbRenx5Am7tKjmPpzjaN94naiRYidSxCaUHywv/e+ozaHb0H76pJ/oDJ
	kRTeGoh4Y7e4fmyBwDQEVGYQ/NTWKjArCOGu4wBS1XZNTI/mDqDGBv+7meanh6Yh
	9euZ5nXnb6+ecDluYi6FjN72+W4kJqK0pzFnuUgO+iPJ/AnnMqW3EWKXuMev8fEw
	Ava//yUCtOhyN3Xyzib4VtbS2xS5LxLt8gv07PY78hCmsMeXqIn1t+4liQB5BOS/
	Jv3CB3KsCBeSOfQYpVEv5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729441470; x=
	1729527870; bh=QEIsjuOFB+ghr/Iji+I3AvgzUWvBOhx6WoMyi1db3Kc=; b=X
	7S8ak4dzAXLUNdsy9D4P9k8RsO/Y0U9V9GeCj61PVEkKntj7fcaQak/nUIr3GvL3
	i1CS+4tTsqJP1DrkOqp4cyF7fLq5SFn734uV9jAkx8Zry9seDMH/SzG3mj2U8bU2
	IelaIfxCLtSqzqIosMk3hsBqcEQZJKrlFSYGX4eorh577A/KpNAIlwRQbxcc5Exh
	QuaayHoqswi6t1FyhMXvsiBL1oLadWZJMiPr9sYEhptGCFICbbDjSzf9c/ktr79n
	rJrf1Ptb6SFLUpTIUAW4/YIUn8Cx30JYEHpYBtFjlduWJzb99YjunxQEtfz5vuNT
	euVmnpAOCc00qO3GDZrZA==
X-ME-Sender: <xms:vS4VZ1gd7IO1Y0rBYdz-Z7P7_AuQ9BUQiHwPME5ZRouixD4WNf0XZdo>
    <xme:vS4VZ6Cq-_JgRG-3-WFWM49SaNQTO856uYa8i_WvQZiIEN6sZcLd1ipkGNBgrFsJv
    I1QohvLIDNnsId9ww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehjedguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrih
    hsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffr
    rghtthgvrhhnpedtiefggeejgeejhfehuedvgeejkeelgeduudekleejkedtveejgfeigf
    efkedugfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnh
    gspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhl
    lhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepsggvnhgtvg
    esfhgvrhguihhnrghnugihrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkees
    ghhmrghilhdrtghomhdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrg
    hmvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohep
    shhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehmvgesth
    htrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:vS4VZ1G-U5PMuolCE4W8tcQQyBXnmeYj5X6r2Ltzw0Kg1GCQ6ime3Q>
    <xmx:vS4VZ6Q6NO2yk9UYmE9cCpiXvHvRMdoKxXog0YmhzT_iypvpsYpRuw>
    <xmx:vS4VZywUYG8VcjgghOY5Ycw_nQt8BJ689_2L8bMo39BNx0SufCwdpA>
    <xmx:vS4VZw67fv9zZzdsVGS28PU2_R6ZX0OcGXa9LrdBIx6P2a9YLLeRAA>
    <xmx:vi4VZ9wcJezo1jGmcIvYlyRgybGtfgR6omu4SC035ksffLzIbFyU4YXp>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id BD346780068; Sun, 20 Oct 2024 12:24:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 20 Oct 2024 18:24:08 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Karthik Nayak" <karthik.188@gmail.com>, git@vger.kernel.org
Cc: "Kristoffer Haugsbakk" <code@khaugsbakk.name>,
 "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 "Junio C Hamano" <gitster@pobox.com>,
 "Bence Ferdinandy" <bence@ferdinandy.com>, "Taylor Blau" <me@ttaylorr.com>,
 "Eric Sunshine" <sunshine@sunshineco.com>
Message-Id: <cfa378cd-2724-4c7e-9a86-68f4859d2d65@app.fastmail.com>
In-Reply-To: 
 <CAOLa=ZRAGmgfSHjAx6-1q9qV-aJ_Ciw=RZ6kpygqbSO+yAUEeg@mail.gmail.com>
References: <cover.1729017728.git.code@khaugsbakk.name>
 <cover.1729367469.git.code@khaugsbakk.name>
 <71d1e6364a21767a8d80c96a30282e6557fec426.1729367469.git.code@khaugsbakk.name>
 <CAOLa=ZRAGmgfSHjAx6-1q9qV-aJ_Ciw=RZ6kpygqbSO+yAUEeg@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] Documentation/git-update-ref.txt: remove safety paragraphs
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 20, 2024, at 13:13, karthik nayak wrote:
> kristofferhaugsbakk@fastmail.com writes:
>> [=E2=80=A6]
>> Such a safety warning is also much less relevant now, considering that
>> everyone who isn=E2=80=99t intentionally poking at the internal imple=
mentation
>> is using porcelain commands to manage `HEAD`.
>>
>> [=E2=80=A6]
>
> In the new reftable backend, HEAD would simply exist as a placeholder.
> So either we do as you did and remove this entirely or double down to
> say that writing to HEAD directly is not supported. I don't have a
> preference here, so this looks good!

I see now that I misread you.  I thought you were talking about the
commit message.  But you=E2=80=99re talking about the doc text.

I don=E2=80=99t think that this text needs to say that writing to `HEAD`=
 is not
supported.  Now the doc has implied that writing to `HEAD` is an option
since 2005.  But I think that implication has been irrelevant for a long
time.  We=E2=80=99re far away from the time when people had to update `H=
EAD`
manually.

--=20
Kristoffer Haugsbakk


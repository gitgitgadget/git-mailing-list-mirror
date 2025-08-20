Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202A9304BD5
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 20:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755723526; cv=none; b=nYF4EK16gp6QrwnQTvXE+lzNJ9LJEx1YMyhWbkmEC2PILEbnzuQ1+OQikMorJWGYjQ/xZJms0U3zf/od78LS4Y+wFGV1V/RiFS25RaSiunPsWb6BnnpalhEd8QbO6rsaWZVTbS1aXw9K1LiNQvJy+AhSIJmBrwyNVxQWK51U2qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755723526; c=relaxed/simple;
	bh=GoC00JkeMez6UHCvi/0e1yqEfFX4Y/n9adzf84lZptY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=VJvhoFpV8gzTES60RVN0lkeSc4Xul+9prVd6c5GcRmFpLjcLbX5fr4uzsNlPFBQ440QsuLQb1bMcBUvuJnfqnXLKsg4Om6dGGzM9b8Vn6pUIKWRlklz+bhkSd4oHRcWgWmKeTrZV+hQMXIqj3JKKKeguUuv2udeKbbkC5gqk9xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Xygntjvg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F2u/ymKN; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Xygntjvg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F2u/ymKN"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 270F37A002B;
	Wed, 20 Aug 2025 16:58:43 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Wed, 20 Aug 2025 16:58:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755723523;
	 x=1755809923; bh=GoC00JkeMez6UHCvi/0e1yqEfFX4Y/n9adzf84lZptY=; b=
	Xygntjvgo6lLzfG3icHJa32KjZFH//1Cxgyl9ajTI1drKgUM8alfU19+4xEFUmxG
	ygyAHpOW9GviProxoo7TMHWBVAFdqvy1P3QOpJ3juwzvjkTQufUhJx0XbSE9Gay8
	MqBlxzcHR30SjGqFVfQOOswzMshibgfeQ4oXxAHyqv9HmHj+ag9/s6lpJueQXPX5
	/wPywmy43TehyOk2n/r4cAj0Ww8p3LuNQs0byfgxg1YElI1xTti0c7j1qzMNFgPG
	fHkYT5EEpT0LoxCRIz1LOU77fJ+QAoOYNlyQEzIvDGcVGl3SOxNH5v3zw4ajNlp+
	hdLt2+HYrE9fuLK80qFWdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755723523; x=
	1755809923; bh=GoC00JkeMez6UHCvi/0e1yqEfFX4Y/n9adzf84lZptY=; b=F
	2u/ymKN85xVHjW20zjx1VxR8HWixfMD2fyijXUzafJO6+P6XgwAbSwlK1ODSBNaO
	vZuvoRRIhSLTjFFqqnuXXrDzzvUmjRHvgbsQwMTs5poPYvZGSMbqt/p27ht6y6Nt
	pTusoBYfo6kvwL6t8arxIFqxVLSSnWWs1Ay1Cax4tPRFmdUiju3cV/1MAst5gI0U
	l+4juYEZYSt70wicM+aMxQcoH4XKx5Y3O2CUwrwEapEARmBX4yCJp2giWsUYJVi3
	FIoQ8Ovdj1lzdR4JguJcORPwzVAkcLUDrv3ojoGMxGTJjBAj8TRP20BUdE+aeQqO
	hDtnvDt4cOB+Xp1OlnEJw==
X-ME-Sender: <xms:AjemaDmaqyo3c8hfTdV2q8lCIzVdEwIu0phOjGiD9FU_kuEN2ITD-ss>
    <xme:AjemaG38IToe5Uxz9CAhA73GHGv4a8O6b24rfIsHkcfB_ye3yQ76lAkGOZwASLtqj
    Mzdky_abdctLEek9w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheelfeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopegthhhrihhsrdhjuhgukhhinhhsqdhfihhs
    hhgvrhesughonhhorhhstghhohhoshgvrdhorhhgpdhrtghpthhtoheprhhssggvtghkvg
    hrsehnvgigsghrihgughgvrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:AjemaIuNlD05kcYnCVBMBdo35XcCxjr1iK-oU38P0soTDD1O0CgvAA>
    <xmx:AjemaO5b0GKDA53ahprFDv344do_bfqqJwSzI4msgMwmAWkqX_xkZQ>
    <xmx:AjemaDVGTbfpH8zyWkhO3eov1Iu3Mg8Qz2kVEbJgWBA-yDu5sJoeXw>
    <xmx:AjemaA-Wwa_FL7U2kdEgoVbFtDccEIWKeOP5PYRMLTawyd3-2zu5Aw>
    <xmx:AjemaKq4I1o12eA7mvz9zMywImerdU1fR0nRkpzqDGNZ4ebINlbVXUHd>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id BB6281EA0066; Wed, 20 Aug 2025 16:58:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ATa01O-RMF1w
Date: Wed, 20 Aug 2025 22:58:18 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: rsbecker <rsbecker@nexbridge.com>,
 "'Chris Judkins-Fisher'" <chris.judkins-fisher@donorschoose.org>,
 git@vger.kernel.org
Message-Id: <790a24b0-a799-44dd-b97d-c4c24e5d23a8@app.fastmail.com>
In-Reply-To: <xmqqfrdmaqg4.fsf@gitster.g>
References: 
 <CAAn3O_2n75RGpvxv1o14BE3KFdwiJW9OOKaHp6_c0rd_MqxC2Q@mail.gmail.com>
 <011801dc114b$f38bb130$daa31390$@nexbridge.com>
 <37da14fb-fead-448b-b6a0-853c9fbea653@app.fastmail.com>
 <xmqqfrdmaqg4.fsf@gitster.g>
Subject: Re: git whatchanged
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025, at 18:49, Junio C Hamano wrote:
> Your alias with the same name as a real command is silently ignored,
> and when the real command disappears, it will start working.

That=E2=80=99s what I intended to mean.

> Having said that, as "log --raw" is even shorter to type than
> "whatchanged", these people are really better off without such an
> alias.

I=E2=80=99m wondering based on the emails so far if the error message sh=
ould
spell out that (1) you can help yourself beyond reporting
i-still-use-this and specifically that (2) there is a git-log(1)
equivalent (like git-whatchanged(1) says).

The message itself reads like it could be read like: tell us and we
might put the brakes on removing it (and that=E2=80=99s it).

--=20
still my

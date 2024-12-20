Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87171304B0
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 07:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734680418; cv=none; b=BR1DSy0V0CnZBmra/fEkb9ZbK7g0B79NglFRsRKESXil8uVITN1JRDsD0yTScu4/2xOISVBttgCP6UNw+P7NlEoSNK21whuD5NuhTstM8SnwkfcVnQU8dTDfjd7NT7qexqJ8h1zh/9gDUJc34l+q5UGM60JG5bXxYdM0p+mENeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734680418; c=relaxed/simple;
	bh=rSmaEw21+4A5yoiCi013L9RpdAhr/wG7vSzScDyg74o=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=hwAgqhb+UjMDA14wdXLWn/XJcgBs0jEEMWFmR++axXxhoQAU7rPqDayP+tI5COj9RNt/tcpBPEF3Dmc/TEOP7vkcD4U6JtSxGthhRSGqCio4gsmI76uluas9WHJDPBo9cGVOlGn/Vg5F0FdBN9VO/yJQqxEwz1rqQA/IS9tmVAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=fYOXQuBX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jLfLSPox; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="fYOXQuBX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jLfLSPox"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id CE83613801CA;
	Fri, 20 Dec 2024 02:40:14 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Fri, 20 Dec 2024 02:40:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734680414;
	 x=1734766814; bh=rSmaEw21+4A5yoiCi013L9RpdAhr/wG7vSzScDyg74o=; b=
	fYOXQuBXWftJZ54b5BW6nkqtzs2KJg5354phBkB3HjKqKTcepvMceb+pznIv/rJm
	tcZEO5RkzSDS369KeRueY52n9hEb3BLlQE1/MIQprDuP0i7yDp+kyw/uK1VXhyZV
	Ob+/26VfDpo4HSIyafvMkofZnUrRoR748CsFSoq4fCNkn2O7gt0/aIuSlwUOVuNb
	N9dX21g9hpexgkfYE3abxfXm3StaCNREaFPmrNih/aW8NkLmkbU//XqnuRqheeT3
	5d36Kaeb/MeEMgVKPs/B4PhfSqoDfk7jOBpGwm2glGlrigcdNtIA0XTW7m3yCzc+
	5wLxurORIl+W1vId2iy7+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734680414; x=
	1734766814; bh=rSmaEw21+4A5yoiCi013L9RpdAhr/wG7vSzScDyg74o=; b=j
	LfLSPoxippjG+wqtGZMj1hLhSqJlHdiSkxDZfJISAELAdCymqPNtIq/eGQq1poS0
	5j1HZT3s3uJ3I/qp8FWX5PDdanihw7eHzP85eHFLa0vpMD8aY9zBKmHO7y6oEDQY
	U5SlXPkP70qhL7lOR2Xgbhc9uaFPojwXrkJwMzI0jTLSGXf22H6ZgJBj33gxxS+l
	ikUEjedGue5utv7S0mJrQQwAazDWHeAjxpRWPbRAvty8oXBeJEkw8FJsSvuJjbnh
	xlilgKK+zkWX1aIVb5L2nfI4WKLby7o8xpfJAAOAAHB6rLotv6282Vz27voPSHSF
	MFpWESegWXpB0uYbb8EZg==
X-ME-Sender: <xms:Xh9lZ4ZFq_9BYMuLhJgI5wRtR2H7TmebbImg9Njhicktb8VWoO54ofU>
    <xme:Xh9lZzYa4U9hj5-2Ab78OS6HZqLQZnDq_D1tJPFxrNhc2bf8d3JeyG3R6f0S3ov9_
    j9PjBE_dZ2Tkz5cfw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtuddguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrih
    hsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffr
    rghtthgvrhhnpeelfeejudejfffgleduheegheeufeeffedtgfeffeevudeuleffgeektd
    elueekieenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgsh
    gsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegsrghgrghsughothhmvgesghhmrghilhdrtghomh
    dprhgtphhtthhopeifohhrlhguhhgvlhhlohdrnhgvthesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtqdhluddtnhesghhoohhglhgvghhrohhuphhsrdgtohhmpdhrtghpth
    htoheptggufihhihhtvgefsehpmhdrmhgvpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Xh9lZy8FjTVes_l51b2vp7f9agtQzKuLrfj4jwtt7vvlUdAogugWRg>
    <xmx:Xh9lZyrb6k1fwUh0redLROeTT-kjkX8Mww9E7CE_MhVadLKUyAm8vw>
    <xmx:Xh9lZzrR4uB-gI3va5fb9Lge6Xg6UvDGrP3MEhh3PYBeFP6_EPUqNg>
    <xmx:Xh9lZwTO6zZMOnKh1GaJmdCi_H7Kmb33IzS_26ILKwB8_wuC5NF2Hg>
    <xmx:Xh9lZ0CEzdbiY2EbdmwXiyIwCEDCiQ_9SfY1t1Z9e_3fVmq-cMPfxdWr>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 970C1780068; Fri, 20 Dec 2024 02:40:14 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 20 Dec 2024 08:39:53 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Caleb White" <cdwhite3@pm.me>, "Bagas Sanjaya" <bagasdotme@gmail.com>,
 "Git Mailing List" <git@vger.kernel.org>,
 "Git l10n discussion group" <git-l10n@googlegroups.com>,
 "Junio C Hamano" <gitster@pobox.com>
Cc: "Jiang Xin" <worldhello.net@gmail.com>
Message-Id: <f27869ba-b611-4a1e-b141-dd7a14518d51@app.fastmail.com>
In-Reply-To: <f0b52b6f-339f-4641-8c15-7bd93b03b24e@app.fastmail.com>
References: <D6FUAW0WHD9P.EKNH75JAR157@pm.me>
 <f0b52b6f-339f-4641-8c15-7bd93b03b24e@app.fastmail.com>
Subject: Re: OK to submit l10n PR with signed commits?
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

(Adding back To/CC)

On Thu, Dec 19, 2024, at 19:35, Junio C Hamano wrote:
> "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:
>
>>> The GPG signature is lost when emailing patches---so unless the PR is
>>> actually being merged directly (and not using GGG) then it doesn't
>>> matter.
>>
>> The i10n project takes PRs on GitHub. That project is then later merg=
ed into
>> Junio=E2=80=99s tree. That=E2=80=99s how it=E2=80=99s relevant.
>
> Both of you are correct ;-)
>
>> https://github.com/git-l10n/git-po/
>
> I see l10n here; where did i10n come from (I know what i18n is).
> Sorry, I couldn't resist.

I thought we were talking about the incineration subproject. ;)

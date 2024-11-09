Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4793529CF4
	for <git@vger.kernel.org>; Sat,  9 Nov 2024 17:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731172420; cv=none; b=NhnHLFv3prJnnOWfCXOgW1S79yPNujZS9rVZw0xJnxraqRSOhmbIWLHwCAwHhwTssondmlBGHVEcR0NeretM+GPQf/BV9AWkf4NrBod/pvjCVPFlaATDhoN/OOsCzk0Pa9yKC1OpdXv0V1DM8BVYplW5HUJ1FRMVQJR7iOokbUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731172420; c=relaxed/simple;
	bh=3JWXR3lc0GzvHEijalxm+0hOat7YCvbGSI6hSPe+0Ys=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=MOH4fkWYqCzVBox6mVezCTU7PqjwJNHtQYg5fmAtVee47KOhqB701a5rWiXPOLUbccwGbejUEPR0Dc3VigPajbE+TD3lLKJORdt0iJ2+KLhb7vv0qkgVpuiRYpgPAxcLaA8m57xFBarKPIz28wSfj6B3KC37w+G4CnaLF8Zy6Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=nZZoPPVL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FzvzgUR3; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="nZZoPPVL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FzvzgUR3"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 70639114009E;
	Sat,  9 Nov 2024 12:13:37 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Sat, 09 Nov 2024 12:13:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731172417;
	 x=1731258817; bh=u/vP/4+zGz6z+vjUe1uxCj7fINzl6k9DZTIfpyLOjKw=; b=
	nZZoPPVL6oIB8dxLc7CzDNXH2l5/XLIdqPebDm/E8TQ92pXO3n4bsr0lnR7ADCru
	wicvx70yIHXWYFVEEv5rqrgG29rVw2Vf2SIBhJ78XrNynUkLdhuvtCB2YZBjJJRX
	wi60ticEbMUJvU478CTwKWVUOUusyAX8HzO5jitEQ6Izzros5kWqUcDkE6WSvZO4
	hi9Ubi+TMcaSJw1sHp77OaPrbz8IueTRtW2fLvpaWARbUUd+Iz5GwG6gAqMu1dUb
	rO7GWkXN4SBInTBB7fZWe39en5VS1fAo1KX4cvx/iYiog4WobM4NU6uepx0t1oru
	2PhdQ9CREdydZZVcgebH/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1731172417; x=1731258817; bh=u
	/vP/4+zGz6z+vjUe1uxCj7fINzl6k9DZTIfpyLOjKw=; b=FzvzgUR3Xff+uHEAd
	a74G2zwPTiaPm8fFe7fbq5dIRQRhC5uzyfrYCQe3HF9fWebavavtGhsE9PwY9Vc5
	EG11UgZbo2CcrtfmiHeb5ER97uKzQwSgsV3y9QJ3CJOPwpYMeZ/u6YfyXHfpgLxB
	aDAeoaDVBUMTQ2+4K/vNRqs7wpeECD4OCUnf2m3FLiKez471WEmd0GnzoU5jCLcL
	xUJ0SnEAVIXmue6lrECt+6PtEmlAnJ+y1GZ+OJuM65zK2IovE1b3Q4J20xxwb1Yr
	wfZPtaXBYcpQnnLLuwkAaSqv5kJWCw9HgZOvr2LudHUV7eic83+BmnRCOlt7wKeh
	a2YRQ==
X-ME-Sender: <xms:QJgvZ-Xph2zv5-qR3FKkNVYJb3A0s4hPpwOtcYTgeLm5ZlBwTYW3LtA>
    <xme:QJgvZ6lwFM-qAeG_Au6WU1fJkbe6mqXD_hAgL8h4B3nRPPM7OKlUUYpTR9dVAM1d-
    4fI_YqmXjR56c0xHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdekgdeljecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvkfgjfhfutgfgsehtqhertdertdejnecu
    hfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtoh
    hffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthht
    vghrnhepffejkedvjeegieegfeejkeegleevheeiteettddvvdeghfegheegleelleevff
    dunecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkh
    hksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepmhgtvghplhestggvphhlrdgvuhdprhgtphhtthhopehmrg
    hrthhinhhimhhrvgdvheesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:QJgvZyYmGOruH0r51jMi07adGt3dh3JZykGDbPaSZ0UDnYsGtgmPeg>
    <xmx:QJgvZ1XOecLou79Ro0-reX5DbjS10aDe1gy086US533teWddCRcPnQ>
    <xmx:QJgvZ4n83GX6R79f5p2BmqlQNKd-flM_merPHqyhsrZoePCLLBXiTQ>
    <xmx:QJgvZ6c4LQeKEirHw0nl7tBjLTj6vmeqF-qtxzSaHXf1liGdMQl12g>
    <xmx:QZgvZ9yx7bXVGJq9ryCK3ZxjYiHwwmbQfNIGjEjLk2x0_jPPfersRc4_>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D399C780068; Sat,  9 Nov 2024 12:13:36 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 09 Nov 2024 18:13:16 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: =?UTF-8?Q?Mat=C4=9Bj_Cepl?= <mcepl@cepl.eu>,
 "Martin Imre" <martinimre25@gmail.com>, git@vger.kernel.org
Message-Id: <debabf92-7d23-4d17-bb0e-36691c94430a@app.fastmail.com>
In-Reply-To: <D5HQH12Y4SWF.2W70SKEDB7HBF@cepl.eu>
References: 
 <CABg7He2asYQbdRvSvfh1YZ2FRPchVfvta8yBv4PFdVNnhzX6Ow@mail.gmail.com>
 <D5HQH12Y4SWF.2W70SKEDB7HBF@cepl.eu>
Subject: Re: Feature Request: Interactively pick fixup revision
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 9, 2024, at 15:55, Mat=C4=9Bj Cepl wrote:
> On Sat Nov 9, 2024 at 12:41 PM CET, Martin Imre wrote:
>> My usual workflow is using `git commit --fixup <revision>` quite
>> frequently, as it eases the code reviewing process and allows for a
>> clean history later on.
>
> https://github.com/keis/git-fixup/
>
> but at least as a minimal improvement, I would limit list of
> commits to those which are touched in the staging area:
>
>   ref=3D$(git log --oneline -- $(git diff --cached|lsdiff --strip
> 1)|fzf|cut -d ' ' -f1)
>
> (lsdiff is from patchutils)

This or git-absorb(1) (I have only tried the latter) is good if you want
to fixup previously touched lines.  That is likely to be the case for a
fixup command.  But maybe you for example want to add a test to some
change which is in a different file.  In which case you want to pick the
commit manually.

I haven=E2=80=99t heard of lsdiff(1) though.  That=E2=80=99s something I=
 have been
wanting lately.  Thanks.

--=20
Kristoffer Haugsbakk


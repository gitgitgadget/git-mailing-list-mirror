Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB07435FF45
	for <git@vger.kernel.org>; Wed,  3 Dec 2025 16:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764779294; cv=none; b=Us2+NIxKjgkfOCmubiUHbJ6dynWs6SjQu9wpXSnD8TNhgRI36mj2+TXfD4Ga7H7RWD+puCq344J3XSoT/cbtqqIcWJKYroeEFuMoi9mqA2Hxzn0OkDWPfzQDk1eW4PkxUX6hFzDV4Bl+uAolhS10aLr4pJ6J97KGNofIRbSSBGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764779294; c=relaxed/simple;
	bh=4nBwlVnO+C0Fy18XVaaaGooNWiND9iCAe9RtJxqv07Q=;
	h=MIME-Version:Date:From:To:Message-Id:Subject:Content-Type; b=rjIid4C5ePS8+kd3vOhtXlwIFL7sKu+X/t0QQdgXfnbGYzdPSTEc2PJJ8xZ4hGaHEmZXUJYDyQXC391k0Z2awg1LY8sdjWQD6oDeEvr42kIXdhXDvn7z3w1LtuSWUuWeB25AlRn7BTGxvS/hN2gemZSooTfFW7sdzWgClA3TySI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=KVjmyeyL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TZupPNMz; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="KVjmyeyL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TZupPNMz"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B07997A01A5
	for <git@vger.kernel.org>; Wed,  3 Dec 2025 11:28:10 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Wed, 03 Dec 2025 11:28:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1764779290; x=1764865690; bh=bron4g//at
	IxXk0ffvGOsUOQgOqunwAtM//1H28LYLQ=; b=KVjmyeyLWQepTXgEdPlRadEFQR
	c0GGcOcZl/gbIzpFf8KoJ1ZpCV4xrYg29RSh+KxvPHZSpeJ9YGWTn9M5XXiasaFx
	kT+Hcn1mSmc6kpNBGYAKWZUeHXJfwcj7UXiu1Gs+MN88oUPz/dXRCs1XXMgojrCy
	9dxVoOcNUqM+wgv2vbiZJOdTeGBrCS2B9MyZU1P5fuszU3bRJBgFk2ZDYBORxcMI
	HrYfQ77XKeVeKCWyWX00OB9pkpk0JUPHClDzFqiCDloSurvqt/DZYqoGwkNBNA0c
	b/l7QHziKWYoYxcKKgbx447X0oYA/RX984kCQOiNSX8DY2vDTdEa1BejaZng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764779290; x=1764865690; bh=bron4g//atIxXk0ffvGOsUOQgOqunwAtM//
	1H28LYLQ=; b=TZupPNMzdDH2luxV5We8iomfHbILW7RpF51rP1GzPDCypGOs8xV
	4O9Qj5reYoQa3VzVZniMzC+BcHMh6jrZjLrgmBXAT2RhJbHXPWbykgpLuRo8nZLA
	hS4QV78E52g16ETmabJDIFJYeFFWR30UKV/f5s5P0T5eaz4hb7FmsI12srggGFFD
	KNq/t1fBpZ98ChbHTJCUAk5dU6KOZ80YbF9DEExpx9hU88GOk+bqg8Mv++WSuwND
	DFBEoMon+S8piht+v04GHFpb88rRiCIWOH29Ug4KdGOGvtf/LfSJLb4HPdojVGVj
	Q2mouBMEvlpYOulP1hMlAS/GdziVr1dXDow==
X-ME-Sender: <xms:GmUwaX8UQZZ4_WSq_fvpZ77vCpCsnkcIgPqNnMIFj39XKCFuMYzzMD4>
    <xme:GmUwaeinwlQZ66p3h_XZ33UUFbck0VPULGp-uMHTsm8D1Copa4_k52OsuVyET2MjR
    NvE_3KUm1EYBxXthqusCIq852MUIpfR7r7dwBZuMDyKM866__Tq5KQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefoggffhffvkffutgfgsehtqhertdertdejne
    cuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishht
    ohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepgeeulefffeduvddtgedtleekueeuueektddvleehhefggfffieekjeeuueff
    iefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkh
    hrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggp
    rhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:GmUwacuKc1FQgDJwrErmRsemCNo9XS7m9UYrm7RmGD9zMkjQr8LGVA>
    <xmx:GmUwaZb7feJFE2nDgmOxCPqd2EugAjcdx_JcmqrgwuhXAQyvoyvJXQ>
    <xmx:GmUwaUrYGUNjaw1XGb1KjtuVy78kNieFnJolxQXy4MsXycoGqvS5XQ>
    <xmx:GmUwaW-ANhwy9DKcny_68I8FYATlRcmMI0xt2Oj2Nmged6IIBA9iEQ>
    <xmx:GmUwabBV9ZeFAjBy-qmSZAHaOZ3rtbdus7X76o7pTPx-HI-z0WSIYaxR>
Feedback-ID: i83a1424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 728311EA0066; Wed,  3 Dec 2025 11:28:10 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 03 Dec 2025 17:26:49 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: git@vger.kernel.org
Message-Id: <03643900-db0b-48b7-93a7-4d96632af57c@app.fastmail.com>
Subject: diff: should warn about EOL when --no-index ?
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

When using `git diff --no-index` on some CRLF files with my setup=20
and config:

    warning: in the working copy of '<something>.csv', CRLF will be repl=
aced by LF the next time Git touches it

To my mind, I=E2=80=99m saying that I don=E2=80=99t care about the worki=
ng tree per
se. In particular, in this case, I=E2=80=99m just using git-diff(1) as a
difference utility on some non-Git files (this happens to be outside a
Git repository).

--=20
Kristoffer Haugsbakk

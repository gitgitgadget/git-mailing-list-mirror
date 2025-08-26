Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4155234A315
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 13:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756216633; cv=none; b=cNPyqQwJQv2roZNjzNjzhYGEWbcb3kEFvYz3RgcO5i28VzpL1um5C3tE9NwTRTNHFcfWkCh5EQIf2AujV3zaN210XDylVG7+DR8ll/xAjqBdFUj44PUcV+eij+GpvXsV41Ma8Ec7jddqKl5Tx88A6CC+PTF5TYb2qL1KGYrtYhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756216633; c=relaxed/simple;
	bh=cslLyBNBvOdL2FlEV/Tx2zwQxeOiSIR95FkRx7wRHEQ=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=IWVapQG1iqk+iZL6sEG/Rnun+sLR2F7j+hS7CrfdO0CBppn/cVfN19CnunSFj9z5LeUMft9poaePVqLAzKB6dTbrxUGhlREwa1dbU0dYt4ZiShvaxoqQnm2YoyAzMfMizs2nWjVtNpRRv+qM9/G9boJYfzicP+xZxKRdoR6Gtyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=PLuIDl+S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N7Vxu/O1; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="PLuIDl+S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N7Vxu/O1"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5FBAB7A014C;
	Tue, 26 Aug 2025 09:57:09 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Tue, 26 Aug 2025 09:57:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756216629;
	 x=1756303029; bh=cslLyBNBvOdL2FlEV/Tx2zwQxeOiSIR95FkRx7wRHEQ=; b=
	PLuIDl+SRQQ8lu2ejJ6qprxA6ofTG3tPAzsrmRftVIIzwugdK4gY6q5sYIN4hjIJ
	MQUI1jq1o8y51kZvBsIJUWAHhOv2my2ZKociXwEKrl0H4TQVGg7o4OA+WT+izvq3
	FzE0H5nIHNDbi20sHDIxq7RPqrA0Pwg+PLv95bsBTIumIODWD/0qUtOE+BqACb50
	vyE100CqWE+iuy7Db4AU+e0a3STnsK6So/3PZPEuMDJpSOEC0dDxCI2Mi1I2AedP
	cH5boywzCWi/rph5m3F+0x9OrN0Fic/lYCVwCwBazezfuUDqOK1UnpSyOCw7eTkI
	LiW7y4uubXDVQ50xvQ5abw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1756216629; x=1756303029; bh=c
	slLyBNBvOdL2FlEV/Tx2zwQxeOiSIR95FkRx7wRHEQ=; b=N7Vxu/O1zQL8GT6Ha
	olvILQhR/rtgi10m2a2Nw9MkRCimEUU1DJbccni9b26xkMLRiz4/WHYcXmOx4yu1
	B7nI8YLQ2m94n956+2ThEskxHdjvxTVpge0HA39lfzrd5PnXPAyZjaZh7xNU17xR
	yvwjK17Cn47s/wrKeavUd5T0qY2d2ByWpHihhOtCd6NfA1AjT3OOHy/cEXB68CkX
	joJF+suhBg3coyg6GCRe1zqh/i7B/ETGsIJgeTJnq37qVT/xC52Wpx7kO3Y8swHy
	v1Aec66NuQCHitb1GYVgjugzZlq31ZrORyqjkQ7vjBrql6iHcxRBqDQM0K7jzBgq
	vBmUA==
X-ME-Sender: <xms:NL2taAPuOAqhsQXzdbMNnbE62es0hsd8aoFI9RdTuVCUh75rEdqCRsY>
    <xme:NL2taG8lzsznrBMy_ZzZybhDffwy_g10LsQm-cEZ8sxrbOCi2UKcQH2PPn2Qm6QnS
    fQliZjP-z_DasjCNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeehgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeffieeftefgheek
    geeitedujefgveehvdevieelfeeiiedttedtgfduhfejiefggfenucffohhmrghinhepkh
    gvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehmihhrrgesheihhedrohhnvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:Nb2taATaGa-JcNa2bdqK9QPF5zzHH2b_WGecgkh9MpLPOaHklU3Pwg>
    <xmx:Nb2taGvpVyWw7L49MU18ZEj0CZ-YBDUpuTNRpZQJPkeXouy2WHWB7w>
    <xmx:Nb2taPxvYHg1J2Ao8AjoLYp89JM_5XH3XlwDKpNwrW3zINeVKOWdIw>
    <xmx:Nb2taA7JkIVDsPn4M1HsYPtGdX6nl6jVVCvFQKL-NwSjaFQulNwzRg>
    <xmx:Nb2taKEs8QFrRhPRQGGPODxGZBTmR-PsLPlfHmjY73l-Hdzw4N9MPena>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E64A61EA0066; Tue, 26 Aug 2025 09:57:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AjMfhHeS2_kk
Date: Tue, 26 Aug 2025 15:56:31 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Mira Skwar" <mira@5y5.one>, git@vger.kernel.org
Message-Id: <65cff8a3-4fec-4e1e-86e0-319a25e63366@app.fastmail.com>
In-Reply-To: <e1a69dea-bcb6-45fc-83d3-9e50d32c410b@5y5.one>
References: <e1a69dea-bcb6-45fc-83d3-9e50d32c410b@5y5.one>
Subject: Re: I still use git whatchanged
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi

On Tue, Aug 26, 2025, at 14:42, Mira Skwar wrote:
> Hello,
>
> I just wanted to let you know that I still actively use the |git
> whatchanged| command, so I=E2=80=99d appreciate if it remains availabl=
e.
>
> Thank you for maintaining Git!
>
> Best regards,
>
> Mira Skwar

You can replace it with `git log`:

=E2=80=A2 Given: `git whatchanged <opts>`
=E2=80=A2 Replace with: `git log <opts> --no-merges --raw`

... with some minor output caveats about empty commits (commits with
no changes).[1]

=F0=9F=94=97 1: https://lore.kernel.org/git/20250825085428.GA367101@core=
dump.intra.peff.net/

--=20
Kristoffer Haugsbakk

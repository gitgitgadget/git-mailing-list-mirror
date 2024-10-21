Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C68194C79
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 09:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729504516; cv=none; b=uIGKIyGNmJexOtSG4zxbFuN+gJqZPB1o/+umToOdU4q/K+FdqeAZCl/FB+MEPdj3RZOZR8NAgt7krbi03cZZIf6aKAO8r7Z/Sg2WASM+iHwSEIg2TVi5/M1bD+sBO6jJfKAremYr2ynnxMWbCuupmOWFWCB/gP6dY6gVMOul2qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729504516; c=relaxed/simple;
	bh=9O/QC3jl5F3KpRIDSzfK45fLYP7z95ye9gBtp+3Yl5I=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=VoP4eiJamigGBnbbcQ903mP0T3Xvp/HQr7nvR3+u16XKWsIuDDx7PXqxwSPxb1p9F9WO3kxkUL8pzoA7pmqTZFXfecjVjvFVTv/NANRhRs2+mj8qXZkEsbGHCDIGrupA8BJJ2ECJnWCsBZl+x3ZH/hXab9yj8VZhNmlVIoja7sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=AadZOuwc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HLCanetn; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="AadZOuwc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HLCanetn"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 615A513805D8;
	Mon, 21 Oct 2024 05:55:13 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Mon, 21 Oct 2024 05:55:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1729504513;
	 x=1729590913; bh=0goCnYIHd0p4/uMTgVWur/Tq4Xa3JzAuYNiac4Lv/Jg=; b=
	AadZOuwcQCuMTDo6P9m561fWhkrMJqFyPYn6qV2Bydews6ODOVlBSMW8W92jCQWQ
	iq1V0rB6BrAHV8wV1bCM5fAp2l03vbkDsyAcwYFgKts8KRAd2bbGmUtookQRYbvp
	3p6Tg6D3ABplzN5Ae0Q3qByspGYtf33Eg37yLSP0UNj2vxmIT8Ty75Ap8xi9bizo
	o9BhwSdHOhy20JHIVd3RdEmISfQNjwkbUxjSztgFHBlLFCh3G0eq5Q6QCoLW+6wW
	1nbYAS+xmoMbbHIamfYVKyHW1ER/15YhGgXoPnjHfezpNlTPu2CQ+QiKvmHrlk5q
	mEM7w34ht96i8zYzmrhauQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729504513; x=
	1729590913; bh=0goCnYIHd0p4/uMTgVWur/Tq4Xa3JzAuYNiac4Lv/Jg=; b=H
	LCanetnRjM7DoWh958eNaFaqoyCSCz4HjTEEM8xClUURtLomboZ0amAOf5Z/SWmB
	WYFPlA9bVRIGRFxj94MBhkpiXDr+W4QxP7R7Yn4qN/tge63E9vgQop7FuzGdevRb
	nAH65yYUO0M9AJmgT7i8/7EJ4s62ZKbSk4hHNTbM8Nx/7rRjxH3aNc0M9nKUoTGA
	MQW0Yhcm6cvjwo+iAOOWGkFREF05oOrf5fqPc6f8ZAtJQiayw4vp4ucmkaSF/eOU
	snMjoxT0DYjGPsa8RUuQWsmeZ1hgn7OZ1nBPvieKkTl71He+jH1Jtgo+NV1w1YYr
	B2bZv3rtUEML5NV0/+yIA==
X-ME-Sender: <xms:ACUWZyGINI5RrZHrm3w61mq6y3reNjzWGblYKDFkNDEBnRFk70RyTrs>
    <xme:ACUWZzW4DSPHwV2GzmjMxcmeCi-9xp0dQacQKKgQ3U9zowa8vkXpF0jUerWGQCmvP
    T43KRy62NQ4l9_qvA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgr
    thhtvghrnheptdeigfegjeegjefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfe
    ekudfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtohhonhes
    ihhothgtlhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepmh
    gvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:ASUWZ8Jkk_7_e0FlkaD34J5Zisv8fqBNXa1AIK5zlkMrGtPv49y3Vw>
    <xmx:ASUWZ8GeAzUg4D58yE9chH8ueYP4cmleAkQyJvA3d2_lQA-PJSVdBA>
    <xmx:ASUWZ4XCW8d3CDbDkiejWqAoJW2CjCBY1pUvZKzqY7hStpQfR6byzw>
    <xmx:ASUWZ_PsV3w7HygkAoJ3N3jPPKAq3ONo1r4JPpgThJb2q0wblkmScw>
    <xmx:ASUWZ_TdR7UT8DJndlnb9V9MtEoGz4zeCP_X0why7n_V5Hcg1h9CH1ZG>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id DFA80780068; Mon, 21 Oct 2024 05:55:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 21 Oct 2024 11:54:52 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>, git@vger.kernel.org
Cc: "Taylor Blau" <me@ttaylorr.com>, "Toon Claes" <toon@iotcl.com>
Message-Id: <c1d3d038-4d5d-4904-b2c1-47b98d20a2df@app.fastmail.com>
In-Reply-To: <cover.1729502823.git.ps@pks.im>
References: <cover.1728624670.git.ps@pks.im> <cover.1729502823.git.ps@pks.im>
Subject: Re: [PATCH v2 00/22] Memory leak fixes (pt.9)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024, at 11:27, Patrick Steinhardt wrote:
> Hi,
>
> this is the second version of my 9th series of memory leak fixes.

I can=E2=80=99t even imagine the amount of effort it takes to plug all t=
hese
leaks in parallel with the stuff that everyone else is doing in the
code.  Nice work.  :)

Of course all the comments that I left just now are nitpicks.

--=20
Kristoffer Haugsbakk

Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEBB1D097C
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 08:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729154324; cv=none; b=kZ+v3YmhhZPWE325UmxPwcwnjH5UseYSxuYslhgohn+I4ApMBwyWUhxvWr0hDnWNWhPOdu5NqHK0ioHAZ/sP5+LZMpcUuGs4O2HAxTsHeL2gcfNvLhufhSmF22EmWzIXUrO2ljP8cd2wMm271dHPxPgTgxQ1ZT8eVEH/krEyT/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729154324; c=relaxed/simple;
	bh=HbtAl7/d92IhbwFrbLsF+DB+03UuWtpoAf6y66xjw0s=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=F3AYvERvH25/lb2a7yiqF1SRJ3KLUNpCRLBKD5VmdllenI4Km04Zs1vM+Y8zsJCZxNUViPG3rh7PpZOY9CoeWE60cM/VyU9e2TDkzJs7fRHd3tSCiYm2zZ/5WVHXzgoH3H7LBgWUDBuMMinYqUpkX6RvHfxno+qkiAtv+bYUSFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=ln5nRjKd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JoyNMS7V; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="ln5nRjKd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JoyNMS7V"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 583841380139;
	Thu, 17 Oct 2024 04:38:41 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Thu, 17 Oct 2024 04:38:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1729154321;
	 x=1729240721; bh=H8lbxphnEfS9/QbyC+V3+L7yA6judNzvHUn1oplkhEA=; b=
	ln5nRjKdC56vlWmipz3ks9fzKb5PvsUS+1X9/b5C7wBTMh2iKquZK0HOUZYLP8Mn
	6Gu1U3RjXzDM/g6kA4AhxSWR3a0YzCTwGyrqoXMnNnLG0jwzEgJrVBZdoKotkNge
	kcYvSY2jhKKgma3obU7mPB72b6X+KZ8UPbuIAjxfGrbJL9wxhNU7dEtO/JzPmWGu
	5m+PD5svO383+mST/kDmT6wxwmcfBR7HhkAYjh9Dv9ZmzybeIYTELq6uMbGN0vQn
	I+/oUKWRyUr7AQ/XxkxNw32DrQKtMBEC3VAo///ivb7lM7PcwjERJvF2JmjKwmsJ
	voWlaDWI4P+ddEEFllDm6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1729154321; x=
	1729240721; bh=H8lbxphnEfS9/QbyC+V3+L7yA6judNzvHUn1oplkhEA=; b=J
	oyNMS7VJ8enUYk3uJeA2SYxcaxJuC3QlvioPzsWY7GSWKzWvsD7R+Fxi9Sqi3ymA
	5ilg86RsRBMdO/Y+QBP8liiQqYU/ObzD1FaQygAAvFjsJyvMsqokr5x9AzX7otOI
	tdrJq7Ucdrlp2IacTm7NGCeePv+s879TWKd8kvB7BFiMdXrZBh/SV7/9M45DH24u
	oip7sS95VroPwCXIOfQWMo9wCi1iMNm/DqVV8H/1WrXxRBnMof94p3GBa0iEtPVc
	AFlTbnLmLECICfW4/FN4Rm146gDYD2wHszudYKRetewZd8rbsTuTSOs7I1p/yPre
	GZpR3FxFwEHCjJHa8yHOg==
X-ME-Sender: <xms:Ec0QZ_j_bJKSf1v-Uwj3LfTfPULM17phTSCXPwZYOdjBywA2GbL8yCg>
    <xme:Ec0QZ8Do95ZHiUNfMndQiCfke9inJ---rz28wi2Ec3vEGHzilF0JzVNRkUhGEOJya
    zC52b3OVIrnKm561g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehuddgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgr
    thhtvghrnheptdeigfegjeegjefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfe
    ekudfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeguihhmrghq
    qhesghhmrghilhdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinh
    gvtghordgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Ec0QZ_HxCgutqDjIqEMvSwC0KI9IrLPIjVB4Q_vuXAO5h5TYIl_QOA>
    <xmx:Ec0QZ8T1FtbSqplO9aH3w1a6MMYbyOc77-ZxiO6mwYDmycN101aHog>
    <xmx:Ec0QZ8yAiI0SQm1_vsYnJcI1rwMKKtzGHPIRkG1yRQFQyh2AJI1HbA>
    <xmx:Ec0QZy67zAtMBM4jgc7YsUo1YEU6SM31d57YYo2_gdbkMf0NsYp0pA>
    <xmx:Ec0QZ39b3hSg_5JOkT8Fs0TCq1FbJVcVDGEb0uI-yzm6vbg4uNvsi7b4>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0C6BE780068; Thu, 17 Oct 2024 04:38:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 17 Oct 2024 10:38:20 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Eric Sunshine" <sunshine@sunshineco.com>,
 "Dima Tisnek" <dimaqq@gmail.com>
Cc: git@vger.kernel.org
Message-Id: <8575821f-20b9-4c94-b0ab-bb2ac7c351b7@app.fastmail.com>
In-Reply-To: 
 <CAPig+cTNUNCftpr28F6USxVDm-2UZt+x9NxHJ+zbX3Daf5thBg@mail.gmail.com>
References: 
 <CAGGBzXLN6eFZmgEE=KBp9vbcgYGGEbDJDUrfyVeYjuCrRiYcXA@mail.gmail.com>
 <CAPig+cTNUNCftpr28F6USxVDm-2UZt+x9NxHJ+zbX3Daf5thBg@mail.gmail.com>
Subject: Re: Unitialised pointer free in is_crontab_available
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> Unitialised pointer free in is_crontab_available
> [=E2=80=A6]
> Reproduce:
> run `git maintenance start` on a mac in some git repo

I think it=E2=80=99s useful to start in the subject and the opening para=
graphs
with the user-visible bug and then go into the concrete code.
Presumably

    `git maintenance start` segfaults on macOS

Assuming that=E2=80=99s how you found the bug.

When I saw the subject I suspected (before I saw Eric=E2=80=99s email) t=
hat it
was about that `git maintenance start` regression.  Because crontab
sounds like something that git-maintance(1) would care about.  But that
was the only hint I think.

On Thu, Oct 17, 2024, at 08:57, Eric Sunshine wrote:
> [=E2=80=A6]

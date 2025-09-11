Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472701DD525
	for <git@vger.kernel.org>; Thu, 11 Sep 2025 16:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757609384; cv=none; b=gH/HWegEXsn8kwsKX41fRD0TSYi9mUI9Q+AsCxrWE2TcILTAYnobPjf9DFw78t1/Hr8RFyZFrYpFudtox8Zw/i/Xr4pgebFSFZ+at2TA8h332D+TH2Sf6pXM7zbn/dibfIpv7iSgS2SHnQ8X+8olRPk4ohcT4Pa+M0C82QppY9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757609384; c=relaxed/simple;
	bh=t39w23biJBgql2vCIPs+G9LAWQ0Fmm4/XqoQcFGcl5s=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=AJlEzTobuE6t9riSfn71B7Rouj2VRGkP3DhVRvXn4mAZigahKuuPqMMJmlj8bjH+hK2vipBjeg0bo8n9jlqULeFg7GuOpDyemLmB7Yca5jdljA3gImTww8v9z+aAeKWzX0GxmjSG30CHbHrVrIzs2yeQyTqnRjD/2wkZQKpVQLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=i8uiOiw2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eMPcnPxW; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="i8uiOiw2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eMPcnPxW"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 631CF1D00432;
	Thu, 11 Sep 2025 12:49:41 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Thu, 11 Sep 2025 12:49:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757609381;
	 x=1757695781; bh=t39w23biJBgql2vCIPs+G9LAWQ0Fmm4/XqoQcFGcl5s=; b=
	i8uiOiw2Cm4mPR33Qf400knpupifjhjWoT8XvxEV/kyccNMU6UcRX/mnO4eyshu5
	UrvBxIinoD3RTxXyO7BhtW21B1KscYXf3slzt0YOt0ZlomFHhhwkgxYlRLMaYlWc
	KyYfeOhImTOGJ79gNfi5p0S1lRsgHW9gCMKBYJiRz7+9X+stKrolage0ViJvlD6z
	EwkXqnBf+uoRCThn/qBeD9eSMwVsmpdMyhvnC32IVdUzb38Oy9FJHT/OKpE/qStr
	yzSJwbnGHGxVKCV/aMvmaO425Gz8ohPtjiaHCT8T8hf7kMhddnjmEAalMkYuYP3a
	J7+xYwQX2S48B84wpf5ffQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757609381; x=
	1757695781; bh=t39w23biJBgql2vCIPs+G9LAWQ0Fmm4/XqoQcFGcl5s=; b=e
	MPcnPxWAcbQM0xnr9bggRVo3XO3oM4YJkpFX3PXzKFk0D1zN6C1d2nD61vOKW+4B
	8EuuRweDJCnajYKb/nJJbv9MmAYp2PB9ykanzsa/a3gV8ZKOhzLV9ktNSb4f88AA
	DBBSGh7IvIIZTHfhPLHGtAu9no6hkHvGLLTrzcW6yT+7vdP0EL6vbDQz7a+IzgfW
	AIp6vlJbLJK4J2Fg8lH6GepyKMEOkgLee/UPdwQgHeL0QGvhbpdGzg/nMWukH2DC
	ekdpwNUrT8bxEThBjUVP3kVuxkpPphUFyxif8UF3HUjb9k3b7vRFPgZk81GohM2P
	tzJqupOO4kE6WRsbbkrTg==
X-ME-Sender: <xms:pf3CaIolSwBbKgCrKsoK67WVGdEO9O3vxHmmRD2ZH7PPWmzixLyZ_T0>
    <xme:pf3CaOoT5zJ8Fkd4lyOXRIPj3LwbDmkHIQEzUBJFizRVSxkvz7BCjRV-mnsYZamD6
    PN1FtRgjyjclt-ggA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvieeilecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtiefggeejgeej
    hfehuedvgeejkeelgeduudekleejkedtveejgfeigfefkedugfenucevlhhushhtvghruf
    hiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepgedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:pf3CaEyqT1oIebMtaeP-evonKWCTJwJPd0WlYqmiYwEGSFAliN_ofw>
    <xmx:pf3CaBsAPZrdvNZFmXsSKl9u7uXr_vk4a5btcud2JJB7oEFFHa025g>
    <xmx:pf3CaF6bi0uUjp1kQY_r2U9f3TwfPRcU2Sgxe_n2ITiRb7eKTJtL-g>
    <xmx:pf3CaISumt44HRYkwEtLFiCsoCsGyW3CF_Qzhfc2GwONTIut0T1pHQ>
    <xmx:pf3CaPtUeCYOj2INNPv1SdamhHC6qbcBLyvXB7R5rkg8ekybPTEJ1Jzl>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 04E2F1EA0068; Thu, 11 Sep 2025 12:49:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AfRgkLjENtTo
Date: Thu, 11 Sep 2025 18:49:20 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>, git@vger.kernel.org
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
 "Junio C Hamano" <gitster@pobox.com>
Message-Id: <e3ad63d7-7ad6-4a35-b340-0643a49bc143@app.fastmail.com>
In-Reply-To: <20250911-pks-config-color-v1-5-3a7c79df65b1@pks.im>
References: <20250911-pks-config-color-v1-0-3a7c79df65b1@pks.im>
 <20250911-pks-config-color-v1-5-3a7c79df65b1@pks.im>
Subject: Re: [PATCH 5/5] builtin/config: do not spawn pager when printing color codes
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025, at 15:24, Patrick Steinhardt wrote:
> With `git config get --type=3Dcolor` the user asks us to parse a speci=
fic
> configuration key and turn the value into an ANSI color escape sequenc=
e.
> The printed string can then for example be used as part of shell scrip=
ts
> to reuse the same colors as Git.
>
> Right now though we set up the auto-pager though, which means that the

Double =E2=80=9Cthough=E2=80=9D.

> string may instead be written to the pager command. This is of course
> quite nonsensical: there shouldn't be any use case where the color code

IMO s/:/;/

s/use case/use-case/

> should end up in the pager instead of in the TTY.
>
> Fix this by disabling the pager in case the user is asking us to print
> color sequences.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
>[snip the diff]

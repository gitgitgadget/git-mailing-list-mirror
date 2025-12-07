Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19FC199230
	for <git@vger.kernel.org>; Sun,  7 Dec 2025 11:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765108706; cv=none; b=u3ZwR8nM/bHcQ+YiEnX9xFkeyuYdkUTwCAvW245nhq3deeSNX6cR5AK0c/7PDXRc14C3esI69cmDDW4fNWtr9FcyVEuV6TUepmVCTR448tqEmyv+CyblIsIuTQCz/il6ocoXDGmE06kGvMg9bsgBmHKUqSD6vbokUkd11FRh2zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765108706; c=relaxed/simple;
	bh=G38HtQWJqFM3+lAY2paDhMhSkP71KZYAy8UCds3ZtjE=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=UduYm3l6rrtatpGxZzcqJtDdFqDVwEoL+Mtvqp50DBFv+0Z7MtGO1j0KGkqtpVWQoW6lrqntOnugNZEmAHGRqrczhdErmq5C2XR0J4rzPn/dPErHgdi2CA0CL78+W19QIto0idI84qL7GWlAE1t3bcyZs5lfaYRFgF/4ad8SN24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Z5gvfjBt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q0M6F4yg; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Z5gvfjBt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q0M6F4yg"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D4B587A01A5;
	Sun,  7 Dec 2025 06:58:22 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Sun, 07 Dec 2025 06:58:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1765108702;
	 x=1765195102; bh=gWkXhJhuHtZGPnwv7nwys1oQd2shxh/+AYn9kMs1Izg=; b=
	Z5gvfjBtOtYA4JZcCsJpmNoqXo9OwECeKQxR72jZGSAPnIcKIR49zkeXmkvOzsrE
	H4Apu+dgy7axYOceTh7T67XthxwXfYVZ3W5ggRj/6hDBc04j4GtXCSiHwvDaT8Wt
	+sc/qsa3oYDqNc5rJb1lwxs1W04guDfgMy1uCAXQ/cdM2W53X2vhQpgr3B6QKufO
	fBEo8y3gMEA9Tj0+MPFgDVjoVWbpBUrB7f8xJAhOpnWq1xyhz7W1/PVtQp/4KU+9
	WnCqHQgzSNCfE7yXx3FhjV43h2XX3mik5B95p1FPsqmQw8UXuqxZDqNenAccxMx9
	sP/Hhs0dviBYCwDJS+8FIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1765108702; x=1765195102; bh=g
	WkXhJhuHtZGPnwv7nwys1oQd2shxh/+AYn9kMs1Izg=; b=q0M6F4ygIr95UcNlC
	QLb1fK/anQjqKPkoKt1VI1nwo7134AhDxTFFfHWQIWcA4p1tTqbjjmwk7opS50Rr
	js971VHp7nfwZDYkzkwLBQe7uIERpYOJVL0J8VfS6zoCQ3ucJK4uKd4urq/X4oA8
	HukSCZx4/1iGZX7DVZ6Zut0GQPFlP1knf0sbDUqLCTgb1sIND3qgr3qzzZ/EA9e4
	vGpWYV99ZpvDU0nKbt5t3K9CWdyUyZuSVEMFM1THNl3Maib8YF1GepnSDEihSjnK
	okxVwlgQbivM/bUBXihdOJPRXJkzU8+tkiHsDU/vg2I/xsCYnyUU3CEXgYBoJm83
	R8bxQ==
X-ME-Sender: <xms:3ms1abU7PwAY33o-xL4e_6F0ppSQGaECHjm6zBd5ClRqhoOhrJ5v3aU>
    <xme:3ms1aebd-8YVFKYnK70l_WcB7_7LI2wIt7CWUzOSP8CyiwHJuUiT5qN5_f5N78m9j
    j-M19m1gz-dDfRmZzmTa9JoUriockldSzpGr854bkAHLycvPsP3EZU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufeejhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepofggfffhvffkjghfufgtgfesthhqredtre
    dtjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhr
    ihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtf
    frrghtthgvrhhnpedtgfffteetudelhfefkeehtefggeefjeevieekfeefieekkefhveei
    ledtkefgueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdp
    nhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhgvvg
    esughjqdgujhhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:3ms1aSD603e49oJrmvSo_sLspJfkSsHHgvgG4nxaT5vhCyJ3eY4N7w>
    <xmx:3ms1aaeIVPVwkoY5sbBWDamItabxUTipAb0M9mmQ04YCIht79U2INA>
    <xmx:3ms1adK2fh1o31mz38Q4zD6hNpa3t6ULV4D3Rxt0pHHfMY0Wi5XZjQ>
    <xmx:3ms1adduZKqtcHwu_nIfwEQVkUqoc57AsxuJUyr3FXOuHX9MQvDqKg>
    <xmx:3ms1abT1mVVas8OIFf2-C1N7aUPQZ0ZYnPNqDpIgRLYY-m2AKiei5xuH>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4B8781EA0066; Sun,  7 Dec 2025 06:58:22 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AYTeX0PtnPXV
Date: Sun, 07 Dec 2025 12:56:45 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Lee Smith" <lee@dj-djl.com>, git@vger.kernel.org
Message-Id: <d5336a22-087e-41ab-abb5-900a45054ef4@app.fastmail.com>
In-Reply-To: 
 <CAOFvV7=DjmWhdoRK=f7ON7gRzaHSGWct25SCo8T_34XBj6XFHw@mail.gmail.com>
References: 
 <CAOFvV7kFm-A2_i2URg-2wgfTet8Dv9SMAD0Aw1AwStCJm5WOLA@mail.gmail.com>
 <CAOFvV7=DjmWhdoRK=f7ON7gRzaHSGWct25SCo8T_34XBj6XFHw@mail.gmail.com>
Subject: Re: I still use git whatchanged
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 7, 2025, at 11:12, Lee Smith wrote:
> I use this regularly, despite learning git after git log was added.

The closest equivalent is `git log --raw --no-merges`.

> Remembering all the different options is hard so it's useful to have
> shortcuts.

The thing about this command is that the `--raw` output is pretty noisy
for interactive use. Why not something =E2=80=9Cprettier=E2=80=9D like `=
--stat` or
`--name-only`?

Well, anyway. It=E2=80=99s not like any workflow or preference is wrong.

> If it's difficult to maintain I can understand why you might want to
> remove it but I recommend adjusting the message that is shown to
> suggest adding an alias instead.

Sure. You can use the command name as an alias on Git 2.51.2 and 2.52.0.

    git config set --global alias.whatchanged 'log --raw --no-merges'

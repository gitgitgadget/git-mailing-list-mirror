Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA59D30B500
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 18:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770317944; cv=none; b=KjU9RijKaWp/B2Uwe8u//NYbiII55FP+ISdhfWWiuzox8VutRz2AH/isMAigkU/DrhgH2nVXlRAGs9duhbK2iWHlnxt4j2vh/unPOM+WMDPib62xmxQ7JjiB/6abMLViFYOSMLmQieHkqgpaCppP5PgVVGAQ0eHtQlTn5FcJQAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770317944; c=relaxed/simple;
	bh=IpJSe60Etd/t6VI0ajJEyhbH5KvAiSoL4kj0Q4Qv050=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=uhTzVK9G0P8/Ec96i1WJOfaaci8IHNp7nqnx3yWAFny+oymirKoRGU69aOoQyo2KXzlN7xR5cFuE0ObEUijGBf24/pL3/xaHJL6WGQ1vdBLtNIgl2Zaor4kqik9ACh0VBlWabi9b8mqaYo7x3muocWqehqWoiCb4F/XVLb3XYQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=om3+x/TH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qZo/+qUe; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="om3+x/TH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qZo/+qUe"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 0CF1DEC010B;
	Thu,  5 Feb 2026 13:59:03 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Thu, 05 Feb 2026 13:59:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770317943;
	 x=1770404343; bh=IpJSe60Etd/t6VI0ajJEyhbH5KvAiSoL4kj0Q4Qv050=; b=
	om3+x/THGOTsjiTL7wAZXv8nVor8/dGum4J+Pf+sCE30zJ32oC5eJ1gm/leGc9lv
	f6Cq+nP5B7xt61Xql+kacnDTdiHH4qRVWx+P44qzrChKwue2sFoJuLWHURQB9zRS
	4eWKvjca9CGHERHlOjPIsOTcHKZlz+FqbPt3uzFMoJaFu1/92OU80pdZaWBZko70
	3YsnaMMiu1rp9qvmsM2q5QvJKAt0aif864t423AOxqzKkVnqLv2Zp8iqsrlaqaFu
	XJMBHErw1KhkluGQRacliE/5bTfD4FPvaiIcO1a0R0FNtvT36G8YCRDgjOzEfwBD
	fJryOhI3Mqd4/u3WEeuiZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770317943; x=
	1770404343; bh=IpJSe60Etd/t6VI0ajJEyhbH5KvAiSoL4kj0Q4Qv050=; b=q
	Zo/+qUezXgao8GEnrkB3CDk/EyfpTnXBb4PqlvALPFBJOsliGCW244n+UtnkvcNf
	x5CUh30hZvAcQ4tgiOeZPe18ewx9QytUgZtlt978XY+d7fcZWOhD6YWJ3YUYLjsQ
	2ICwIUZvmY8Hb5BKTIMtAmNYcCbjBcCK98BwYF5eM+CwMhkariO6rtLfO8YEStFj
	yrW5A5lOqsmZ0FHqKKOV5BuUH1z047FT96oC3gQX5uBQveVMTn+KFIeFXN1C8HkG
	70/Ii7r6oWz9ZZKCXAyYGhHt2oQGq5rjMcBdndaDtBMIy7Ml4SsmUaMDYUeuY+Oj
	8DDV+QCV7wXUywAkz+URw==
X-ME-Sender: <xms:duiEaRKstunYQyo06dXZl1oWsShfHXI03IvbGdutm9VgyA0kei31t2c>
    <xme:duiEaX9Dhrkqr0A4OxoRVR3RjrAEzfOnuohN5AVUEGAfoUkXdeFQxKBtEh9D2z1Tw
    YS11u7okaSgtGt6eOZ8m5LWJS2LAtFm6hGaNTsYw354YdkL1975DQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeeitdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghi
    lhdrtghomhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:duiEaZwl5MgpZQxFjMqpqpsp-yGKKyVsQ8Yrgg_-E2FWxPqZbWJNBw>
    <xmx:duiEaXE53k_De6GGrKFtctW9eSMQNBGoxQZZaZKxRuFxXOJLUWX1rA>
    <xmx:duiEadwwp0gacgNF4oWi-ZIGqx_tqSM9fgsUKZNjuSGGEa1CsHV-Ig>
    <xmx:duiEaYvDe0b4se52eQkr4FMl07ugDQtU4Xz8sn41Gilc2CbytSxuNA>
    <xmx:d-iEaT0lGPNIKamyoaSVqBVXgbfTiaO7g_D_Kh1clivvTyv5I_jfdmje>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D69261EA006C; Thu,  5 Feb 2026 13:59:02 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A478TlyV4oB-
Date: Thu, 05 Feb 2026 19:58:41 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: "Junio C Hamano" <gitster@pobox.com>, "Derrick Stolee" <stolee@gmail.com>
Message-Id: <826b18cf-bf75-4d60-9feb-c8e6662d2b6d@app.fastmail.com>
In-Reply-To: <9143e1ba-38f9-471c-a241-5505fe33bb99@app.fastmail.com>
References: <pull.2033.git.1770214803.gitgitgadget@gmail.com>
 <fdeef536f649bec811e8335d1c7151be8e352ff0.1770214803.git.gitgitgadget@gmail.com>
 <9143e1ba-38f9-471c-a241-5505fe33bb99@app.fastmail.com>
Subject: Re: [PATCH 09/11] config-batch: add 'set' v1 command
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 5, 2026, at 18:21, Kristoffer Haugsbakk wrote:
> On Wed, Feb 4, 2026, at 15:19, Derrick Stolee via GitGitGadget wrote:
>>[snip]
>> +git-config-batch(1)
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +NAME
>> +----
>> +git-config-batch - Get and set options using machine-parseable
>> interface
>> +
>> +
>> +SYNOPSIS
>> +--------
>> +[verse]
>
> There=E2=80=99s work lead by Jean-No=C3=ABl Avila to use `[synopsis]` =
instead of
> `[verse]`.[1] Would it make sense to start off with that?
>
> =E2=80=A0 1: E.g. acffc5e9 (doc: convert git-remote to synopsis style,=
 2025-12-20)
>
>> +'git config-batch' <options>
>> +
>> +DESCRIPTION
>> +-----------
>>[snip]

(sorry for replying to the wrong email)

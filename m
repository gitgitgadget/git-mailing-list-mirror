Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19E417A2E0
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 18:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761676978; cv=none; b=FbsSGah5tOZn0VjNQ/RAC932RQ073CzkXDYoYtcVjzICR9vbNKNquMMXdXgXCurFdxtwmcURsDiAAs6eY51CgoSwREfrJRxdv5uhRXW4NuJ/hF+cNEUZA3efZFt8MslmExZMSATu3Y5GMtNYIKhaSbGMXxVteuGZLqHuJw14gpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761676978; c=relaxed/simple;
	bh=O7OeoP9ZC1gI/FzP0ZwkWpUTA6z2TIbCyup9ZWLV8hQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=NTlMnP/iJ6LgOvVEBkJpOB/AVIS5KrXNRs+5w3SLyE6L2Q5HkkyTVSQGMT+VSNx9AfYjHtvNV+/NH7vHztyPqoqbAWPuhDeoZAYljL976cszx2poG82dqMG0CB9ZRx6JYPNA7hz6YIanq4LIVhjkUnnVLdMWcTR/95WUyjgXh40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=riqWa+7a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BSEmc3nG; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="riqWa+7a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BSEmc3nG"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F22427A0069;
	Tue, 28 Oct 2025 14:42:55 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Tue, 28 Oct 2025 14:42:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1761676975;
	 x=1761763375; bh=O7OeoP9ZC1gI/FzP0ZwkWpUTA6z2TIbCyup9ZWLV8hQ=; b=
	riqWa+7aNRuad/knENo7yrinrGN2+NB7Fneii4cecB8pooFQoeqMLBv8fL2WeWm8
	AW3BNipC3t+WzRMmd+xEs08V7KNtM0fuqHmT4NEXnOIFFwRWrwbb+o+U2fR8aSgL
	ePFk15Cc9j0TiNJtqmQHkMuefPnEfkud0KtQ7M82C2pcKzgnnfcs0rr0v5kwY4mR
	anv+VcCk1WiJdb/O84ylxSVouWjKaG+spUcZ99LUBj4JihooUSQWFU8YatkzIIVf
	ThwTee88oZw3L87BUSIcNCNwNvpG9p7TX8Vzw+MPaKqpmx8bF2FxNll9+gaQTc1I
	66ZDaf/fv+TSlTozmSy2Uw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761676975; x=
	1761763375; bh=O7OeoP9ZC1gI/FzP0ZwkWpUTA6z2TIbCyup9ZWLV8hQ=; b=B
	SEmc3nGB5TAzDRd/RkzxyJVpDnK4MkBc+Hz0eXrxQeRqM5A6snWKFoikgChZdbaz
	03hDfbaeGY/mKLpiz7iPQw1nedf1DKDWiW05BUjnDz0er/CDX4b6/4y3lEMDtXS8
	MH/zBKfnzVtG7rBixyI7lRL71uHxbwHj2wCvBqnIIXOx2QyCoAkDTpRQZApUYWP5
	ue8yloYX6fZJfDPYA5e7AWD+XO1mcrWOxemeK+EeZoEMhwFZpGKwL168LFK+FeVR
	XijIM7JqSSOPFdmA/vXFPGfi6OvOiHUkRD6pws0BUJFWKNm+s/XfJyssufcdeQ6X
	4AXqZV2WSD+QNhlXV1j3Q==
X-ME-Sender: <xms:rw4BaXcs1HNNH5vaJHy2sXlrKU1lxd-n1n2HkcQoh7aCqKPOst29Y08>
    <xme:rw4BaYCsjPz7ElmuiUQ97Y1baLDA6t-GzRxjYZK5a7qJieO7_Epgst4SWEKtPe7q3
    -B9SvpU55aQ5cteJrSDuhkaBuUePGwLPqLHdG4zNm26ct-tflEZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieduiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedutddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtoheprggurhhirghnrdhrrghtihhusegtohhl
    lhgrsghorhgrrdgtohhmpdhrtghpthhtoheprghvrghrrggssehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    phhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopegvmh
    hilhihshhhrghffhgvrhesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprhgurghmrgii
    ihhosehgohhoghhlvgdrtghomhdprhgtphhtthhopehsthgvrggumhhonhesghhoohhglh
    gvrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:rw4BaS8fCZZ19xRwa0QBwPIV7VnYCwMUFVtAyAytZszY0s4evqcshQ>
    <xmx:rw4BaVyCr8VD4qJE01uOvHsrP5Sdny9DglHLZR45_kupVEEmczm5mg>
    <xmx:rw4BaSoBxyui2cJEHfeqRmXs6PS26Jtqyzvt2OmHzGyS-ssEs5_3ew>
    <xmx:rw4BaWqygcbovCcCoOXEyTfW3YhYoF6MuVeL9hTGqnAtqtmUr8Xptg>
    <xmx:rw4BaThMmHVmwBKgk8Kd522ESLqHpe5atHGPtkF4oxmT6k7HODrzSnJ4>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3599B1EA0062; Tue, 28 Oct 2025 14:42:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AtqO_KzHnBtZ
Date: Tue, 28 Oct 2025 19:42:34 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Adrian Ratiu" <adrian.ratiu@collabora.com>, git@vger.kernel.org
Cc: "Emily Shaffer" <emilyshaffer@google.com>,
 "Rodrigo Damazio Bovendorp" <rdamazio@google.com>,
 "Junio C Hamano" <gitster@pobox.com>, "Patrick Steinhardt" <ps@pks.im>,
 "Josh Steadmon" <steadmon@google.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Phillip Wood" <phillip.wood123@gmail.com>,
 =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= <avarab@gmail.com>
Message-Id: <b03a96a8-af42-427a-8cf1-4d195be6a7c7@app.fastmail.com>
In-Reply-To: <20251017141544.1538542-11-adrian.ratiu@collabora.com>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20251017141544.1538542-1-adrian.ratiu@collabora.com>
 <20251017141544.1538542-11-adrian.ratiu@collabora.com>
Subject: Re: [PATCH v2 10/10] receive-pack: convert receive hooks to hook API
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025, at 16:15, Adrian Ratiu wrote:
> From: Emily Shaffer <emilyshaffer@google.com>
>
> This converts the last remaining hooks to the new hook API, for
> the same benefits as the previous conversions (no need to toggle
> signals, manage custom struct child_process, call find_hook(),
> prepares for specifyinig hooks via configs, etc.).
>
> I noticed a performance degradation when processing large amounts
> of hook input with just 1 line per callback, due to run-command's
> ppoll loop, therefore I batched 500 lines per callback, to ensure

I don=E2=80=99t see `ppoll` in `run-command.c`.

> similar pipe throughput as before and to avoid hook child waiting
> on stdin.
>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.co=
m>
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> ---

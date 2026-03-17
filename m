Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4241273D6D
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 15:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773761386; cv=none; b=hDG4HQOI9wH4yDouSS/aOMrNN/jPBfxbiAvlDDY4kdAC/ynDVSJPl2CARlnMJzOOtuNFH26PePGN7RbikOl7pIESC0izjyorBfQOIboFyAGmxH/ijhTmquUxKiuAgnxMdcGRmuWGamFjavMvqt5UL3afxBKhiPFJnjqF2w33HWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773761386; c=relaxed/simple;
	bh=coxSlQ8JIgJYd4ncL0Sz3doBr60LpfCU0/ZHL5zZIuE=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=jEIz9n488gprotDqil0+KH2re5V5J0Mcm2PjaI3tbDDQwm1gar8FiyJ/BIW+O21ap8IXXsrpB1ru+TdPM167sVY1d0aINGMWZBsS18csHdr4dEoXoC2+g/RODXhrx4Kq/ZvDF+qg6MkU8BH2s89Cb8Va+dy1OaORXffPyM42oNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=b5yB5BaB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VOZBwA5T; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="b5yB5BaB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VOZBwA5T"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id D5C17EC0796;
	Tue, 17 Mar 2026 11:29:43 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Tue, 17 Mar 2026 11:29:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773761383;
	 x=1773847783; bh=8jYGYQRcS/UXvRmYzeKb/cD1Onm2MX+Q+eoBBHjglWs=; b=
	b5yB5BaBZCkZnsz2Dkel/bdPLVQAIdjyA2AtQ7FISXynNZZBXo0GqoaHVJvpj7tX
	ykg7qHW0SGnlvA8oLCT9Qhq6i2yaChTlDmARLDG7R+Ok369t5CAc5pr0rnSMUFov
	6ugLFDZvD8wdU0bZp6BgMVqsGlUB121+ZBDsODiLDa4nXhKxtUtBpdL/KWxfkIHF
	gQmqffpTmfhzFsYNIEpz/kMtY4tKANxHV167qYhED3v5sti60qLAdGtSBK56ZYMT
	0VmzOaDEeS43F0J9Ay2MlnHwHlb4ii6yNEKzGM6BM1rtyizxkg/6C3RcNsB7RIkF
	ic07KX6xVm0DdXvUWdwiXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773761383; x=1773847783; bh=8
	jYGYQRcS/UXvRmYzeKb/cD1Onm2MX+Q+eoBBHjglWs=; b=VOZBwA5TyUrOj+sLx
	ilxi20nN1LeKokjZpfiIfe+8rQRCLb5fUCarZztjNfOfmTEPu9SwzFw3mJrELQRW
	eJgSn2sHBfNQgDP1pDwiAPBnKnehJqdp3eoTG1i/quEfXpkwCM35X09TOUZmdyMu
	O0gJOYJR+ShZp3nNwQ/vD8Fvh8ExVlyBkqya5mUvpFdAtl7oYKrvSCJghP1mzsXQ
	eII4kFa8iiNUq36V859DMyTSNiWdC94hlPJ/KfGIRO7Nk68sIa1BDi1cBWDjJmg7
	SlRhWqfhRXe4Ilf6tGk1vcsI19i9O4B2zRJQvkcYBJshrdY2m/AYuQwRialhVpUh
	9eIwA==
X-ME-Sender: <xms:Z3O5aQaicRYSMs2PUaNrqp-mrb6DS1kZ9-3k8YfhnvGzgR93FhgIoeo>
    <xme:Z3O5aWM0ChM22NoXRzieiv82igjyRo3-dIHqom-sMIDK5MV7DDNPkDvl7C6ghb6-q
    9s6Q8_c93cyFJqgjTOc5iz-ciDM_4u8tJAa96-0Z33le1_WmCauTQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdduieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvkfgjfhfutgfgsehtqhertd
    ertdejnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehk
    rhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecugg
    ftrfgrthhtvghrnheptdfgffettedulefhfeekheetgfegfeejveeikeeffeeikeekhfev
    ieeltdekgfeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhm
    pdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrh
    hoihhkseguvghlrgihvggurdhsphgrtggvpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Z3O5abGWIDw7TeAlNRpfOoCDha6MQow-z-xfDAXYGRfFutTRgrHbWQ>
    <xmx:Z3O5aWR4SXKUhJ_x9Wf-vZHqq5g5X-sQSgfOpVzrf8Zs2zD4NzoZKA>
    <xmx:Z3O5aUuYaEm3cUyAjcc_Gr4BAEkw1k530K7BuI14t8ccP8M2ADcLRQ>
    <xmx:Z3O5aVwlGEdJmKPvctlJd8l3qaaKUPZTVAXbmxfFdBDrmAFl3eoIBQ>
    <xmx:Z3O5adoN0hQVjn0wrK4B4pnPb3F2okTZ7FVv9nURHqgcnjSeZAIvW0f7>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 910111EA006B; Tue, 17 Mar 2026 11:29:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Avh6dDQ-TTo7
Date: Tue, 17 Mar 2026 16:29:23 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Mirko Faina" <mroik@delayed.space>, git@vger.kernel.org
Message-Id: <0294b771-2d0b-452c-90c1-82baa8344689@app.fastmail.com>
In-Reply-To: 
 <aa7802b653a44838ef78f5ae4a82b341c9853b33.1773530191.git.mroik@delayed.space>
References: <cover.1773530191.git.mroik@delayed.space>
 <aa7802b653a44838ef78f5ae4a82b341c9853b33.1773530191.git.mroik@delayed.space>
Subject: Re: [PATCH 7/7] format-patch: --commit-list-format without prefix
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 15, 2026, at 00:20, Mirko Faina wrote:
> Having to prefix a custom format-string with "log:" when passed from t=
he
> cli interface can be annoying for many users. It would be great if it

s/cli interface/CLI/

s/for many users// ? It=E2=80=99s a general assertion.

> could be dropped an it were still accepted.

s/an/and/

But maybe instead:

    I would be great if this prefix wasn't required.

>
> Teach make_cover_letter() to accept custom format-strings if a
> placeholder is detected.
>
> Note that both here and in "git log --format" the check is done naively
> by just checking for the presence of a '%'.
>
> Signed-off-by: Mirko Faina <mroik@delayed.space>
> ---
>[snip]

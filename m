Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D4A330B0E
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 07:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768203297; cv=none; b=CbGdGcQAVPSR/ZZDvwK/VoRcI2V7UYL8NU2dgBatcoV/eC5JIalAJS0S3i9QTVjwWzzOQLVc2U+XXg+eh/ZJPaDr7cckLh6PGTT8MhHSin+s5yaui9K79x6hmpwz2zPTPWvsNKbns9lQ1SWq532rq3YlV4+haEu/EMEoZigq/U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768203297; c=relaxed/simple;
	bh=g93lgtfUbtCbIcV+AiUFCEi0dcJERSIk+Wom2lXkUao=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=c+cSu5VA4fQ3+vSFz3eOrUlxEzt89tA6o4z8BhnzjpJZrcOnqRtRADkPm69EUT7y3QCiQ2mDuuQ0kXJtmNhYFEhmnYZX5z/c7Oi4Ka1Mky009XcYmlv+gtSM2rxN8Ie3RKR/rVKDmfTnJDenEQ/Ag+JfOJixG2f+rau2VVX6VK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=cZ3V6vGi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GaDrNIUd; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="cZ3V6vGi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GaDrNIUd"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6F5277A0090;
	Mon, 12 Jan 2026 02:34:55 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Mon, 12 Jan 2026 02:34:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768203295;
	 x=1768289695; bh=2Iqozukw+nTbZtbsTN5kCJW+ikaOgQxv3ZLUvKzFJe8=; b=
	cZ3V6vGiBhoMoC0DpdpegWLCCif/v4VDEUXxXHIX2Zw9s51I3rAarAi0V2Q42TVF
	XnnRrv+4Xw7EIuG+Z6zYcqBLndLVsPtudT/c5L767wfgM9rezAHKkrP0Z29+ch84
	LEzPT4ZukJM7PTF9WKstK1jbhU0kce3IsuZ1JskHmGd8rt9TbeveVQ5Lsb8+Yuca
	NOt21WlnxmPJ/hPAM+MFP14hLdTKzHLn/VFtp1eaRvwmutUpfNPPPo2+k+rnx0to
	bsTXUL9zODp0dIIlpMMZ3FFkXiEFnMtNR0wx+JLJ8BrqFaVzSb+HrDfWkOWWhcDz
	XSJ79/RHZSJf5pQdSpE5sA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768203295; x=
	1768289695; bh=2Iqozukw+nTbZtbsTN5kCJW+ikaOgQxv3ZLUvKzFJe8=; b=G
	aDrNIUdUEjHj3NKEWECmbHrL5jICBe7gD0FvuCPXfafUL4x3ibyxBj26YFMI2neO
	rFoRaOVGlAv0LkfWpj8R6sXVZMnIdb3dgJ5tAE3+X7EzXXJQ8PUtfujtVsnglyE6
	qonMAThCm+nOCgd6P06r7++B0RcAl1WuGKWnYWCp/Y1xwbKg9fbPVKSgivJ4aSso
	BfTx/KMNkCEKYYOrczDxF971e0X30XKWTlOhYuORVaqHwsX0Fucw7QmaXyqm37Xb
	PLrb5Q7TaVg9T7ZcDcCb3t/2QcL+2x0V61f5ABZdR4rpZVsyRmdVL+lAn8ioRvlY
	zJg/KkngsE3fDmikMVGIQ==
X-ME-Sender: <xms:H6Rkab3pXEYu_JpRXXlBvYrw44mVTuAnSxOqe2eWVqzsJOSseDg6hXM>
    <xme:H6RkaU4nWqvvlOdi5iKWpfmwgoSbIz9mVbNq5SqIaVeFHcYGxaOpS9u5_3Jg506Vf
    AAd6aE9HAsNHSJwq6xUdYnpDnCtGdAQd-lOMTzFdE8gGaeaN8MGPA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudeikeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghi
    lhdrtghomhdprhgtphhtthhopehhrghrrghlughnohhrughgrhgvnhesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:H6RkaRfInxOqIlbhLXKrIq_B7kiQ0E53iW9VcnHUbJbdNaI4suoM_A>
    <xmx:H6RkadDpICnT2lHNuq451pndmcldfYhYHxuGcbpG6OadTIN5LgNJyA>
    <xmx:H6RkaU-jFa4qJYej49geCr898b5fnshALVQtyTr4sNgwo-UjKzNj2A>
    <xmx:H6RkaYLQWe3CvrW9N64hQNQuw00uW3ds8BWHYQb3bEe0xrzB4Qi26g>
    <xmx:H6RkaYRv21dC9TBcEU1FeTnHNes4ac1ER6Llsgki6gQaKfaYMToKnNv_>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2EA9A1EA0068; Mon, 12 Jan 2026 02:34:55 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ATb6QwCtSznB
Date: Mon, 12 Jan 2026 08:33:11 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Harald Nordgren" <haraldnordgren@gmail.com>,
 "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org, "Josh Soref" <gitgitgadget@gmail.com>
Message-Id: <1d92e252-b395-422d-be6b-ecb7c4dfd999@app.fastmail.com>
In-Reply-To: <20260110190657.25872-1-haraldnordgren@gmail.com>
References: <xmqqzf6lqs9w.fsf@gitster.g>
 <20260110190657.25872-1-haraldnordgren@gmail.com>
Subject: Re: [PATCH v20 0/2] status: show comparison with push remote tracking branch
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 10, 2026, at 20:06, Harald Nordgren wrote:
>> Here is a place for you to explain what helps people to decypher the
>> differences since the previous iteration in Range-diff (which is not
>> very easy to read).
>
> ?

It=E2=80=99s a bit opaque. He=E2=80=99s saying that you should reserve s=
ome space in the
cover letter email (`PATCH 0/2`) for explaining what has changed in this
version compared to the previous one.

People often write:

    Here is what this patch series does.

    ### Changes in v3

    Fixed the commit message typos.

I don=E2=80=99t know where this should be filled in when using gitgitgad=
get. ;)

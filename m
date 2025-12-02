Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BD725D216
	for <git@vger.kernel.org>; Tue,  2 Dec 2025 15:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764689326; cv=none; b=phQHWY691OdjQtZVOXBGNaVpYhf0aQJ/wSUTRYn25RRuA+d3zSBnEn59gZ0FFMyySWQN/89fymR0vm5GciZ1K0s2jDwmVyvMMradh4dbswLuS1Xu1SJXSdyAROZ4++Aiqk125aDOEbEW6r2SQWu4nWNlETF2AOmL2OUF+kBiKcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764689326; c=relaxed/simple;
	bh=A/4/bNNxvdrNtIvq1xIojezUAKybUiwPkzpcmavxSAc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=pAu4GfqgP4aHrljuirZKfi6Mr652hiMacaBilwQ9xMthJZ5tMmv3vcCJuPyBTQ3uFL6fmJruS42RJU9hBexx/34dbewJjsP1cmcOVmxlffdU8pT85U6GdsP2MXEzun5Vji47YGhv9q/J0vNhUEh/tuAW3bq3ZjLzhQaUWZwL6mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=iOV43oqg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GYhCDWB9; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="iOV43oqg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GYhCDWB9"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BD4617A01B3;
	Tue,  2 Dec 2025 10:28:43 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Tue, 02 Dec 2025 10:28:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1764689323;
	 x=1764775723; bh=yVbibMOZy9aKKXYT8UIsn9MRSIewQw82qgO4okOEZ3w=; b=
	iOV43oqgnnuWMysuYpDr4nrBJx7MQEvJk7CtWF4EnoY0hBTxRuNB5WpZv4hh6CjQ
	uKqMIEydBIb34Y6/5UC3EpnUDOFIo8imbv+2Yk3+XGXvkmsm/Ofp4aLiRKpY93/S
	lwzXElx+rV/vHAhKM4Oa25BulSiaZLBGuKQ31h4G85CdW2TUJBCWmuAy6N0IFOZR
	TUGTIZ5m0yuWdy393QCi5yiENMb4dqYhk/0hhZoBqDXTHOi5ey5xWAlGfWM4pLxK
	ZCu3NbuYzkGrOe57ZRtgk2CjhIMSKjYmzxjwixAVIwvULPe/yQQYxLgs3pSUgc+z
	Z2RXWBm8oPKUmZBrpXC9KQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764689323; x=
	1764775723; bh=yVbibMOZy9aKKXYT8UIsn9MRSIewQw82qgO4okOEZ3w=; b=G
	YhCDWB9KVdHgoQnHmJAGrs6gwhU0mzfbZ7VeIT33ePc6Is8AG7UlDhHWL7gF+WsV
	gUWppM7R6MK0ixfv8ojdGDm/CEkYXDRHySYnr4ahvOIvRG90AaMY7cF29Ws3KDPG
	nuhE+bHfgkjUWBnWgfPw0JiKIDmUVajlMmrYZ9V5HF4hoB+32SSoWQWB1QAe/Gwo
	e9NIUBWxPpQupD1VMN0UNhu8HqPDYTY6NOpN56BJ9krWV4cEDcyrurbpINxuzmIl
	F8X/pl7ftipgTh6K1hfHSzwEpkaPPopreQphO/2ejDh15LCS/QjUAkkXAEUXMiOV
	HN3wTuHHDPPFdBWlUh4WA==
X-ME-Sender: <xms:qwUvaaR3Y8yha45DAQbWtg27IaTmbfxU6z7mbZHdrhDYJHnM48H-uZw>
    <xme:qwUvaakclsLS4v9BcgMy2YIHlQh8BSByRiUx6GBEVjI69_0t5BUsU8qS5ACrXY9my
    uflHWkzeOj9Lh3QTT6ON15bRmJF9kVauZshwigEbIZ0ROEvcMGqkA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecunecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertd
    ejnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhi
    shhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnheptdeigfegjeegjefhheeuvdegjeekleeguddukeeljeektdevjefgiefg
    feekudfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhn
    sggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrgh
X-ME-Proxy: <xmx:qwUvac8Py13Hm9Iw-K9eKgnn6hws3Gq5b-bwkJPpsYVsyGHnA99KZw>
    <xmx:qwUvaSr-V5wF-DyBHXYWEvkdwlT5IEXkMaM_K4we2AdYogS6UHDNow>
    <xmx:qwUvaZlxT0TtsXtfNCTojlh8acuNLjiuwVhcm-P7AFp-NDiDYQDpNw>
    <xmx:qwUvaZK_hnoTj4IrUSAukxUXGPWxHqaC-Wf8qzhhHU1ovcvaJ2eGhA>
    <xmx:qwUvaTXvQDsQP3tuGemd0NDeqdekWyNm9sBSAOzRvjY11qomB9L_viYR>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 53B671EA0066; Tue,  2 Dec 2025 10:28:43 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AIaNPumzZO9s
Date: Tue, 02 Dec 2025 16:28:23 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org
Message-Id: <de40b6b8-c110-43ae-aff2-84abbc2948dd@app.fastmail.com>
In-Reply-To: <xmqq345yjejo.fsf@gitster.g>
References: <advice_git-help.64@msgid.xyz> <xmqq345yjejo.fsf@gitster.g>
Subject: Re: [PATCH] branch: advice using git-help(1) instead of man(1)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 28, 2025, at 17:40, Junio C Hamano wrote:
> kristofferhaugsbakk@fastmail.com writes:
>
>> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>>
>> 8fbd903e (branch: advise about ref syntax rules, 2024-03-05) added
>> an advice about checking git-check-ref-format(1) for the ref syntax
>> rules. The advice uses man(1). It=E2=80=99s better to use Git=E2=80=99=
s own git-help(1)
>> instead of an external command.
>
> Substatiate "better" a bit better?  If there were a universal help
> facility, we wouldn't have had to invent our own, and that would
> have been even better, but since we do not live in such an ideal
> world, we cater to people who live in a man-less land by having our
> own.
>
> In other words, "An external command" is not the issue.  Some people
> living in a man-less land is.
>
>     ... for the ref syntax rules and refers to the man(1) command,
>     which may not be available on some platforms.  Refer to 'git
>     help' instead.

I thought that=E2=80=99s what I did. This is output from git(1), not fro=
m a
Debian/Ubuntu/Arch Linux distribution.

But people who only use Mac/Linux/(BSDs?) might not necessarily consider
this point. So I=E2=80=99ll make it clearer.

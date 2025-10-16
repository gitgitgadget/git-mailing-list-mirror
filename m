Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF711F12F8
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 17:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760634165; cv=none; b=Ui3N4c5Fx74tFuNdPgTE9xe2+vubzo39GjhPyJjzpi9KYflyEcNNAV0ZhrE1nJhZUsymtoSLYMy7Wd8KvHfBZ/BztgkUySgnYPPy68/G8z94tunfg7pJyjbryT5fJVz8/t2lsM0BaWpYB//DnPc1HKKahTMdmqIwe24ZU2JAliw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760634165; c=relaxed/simple;
	bh=pvA0MoTCY/vn7q2VgFdECrvu93tsGx4F8RqcW0VzP9k=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ON/i/JVO5Ed4JdSGmRC3Afs+TrUbRMNzEkoByoSYR59/iURbQ1HOYDuPTBnHypQCZZ0CaLxZb+/4gNibuGbGThhHef99ndbnQamhLN1kG9Q6W0xPohw8Mn24uaoVu6bohL/X3eKBYTrPCaVEsboVdHpjg34S85WdAOcVJhgwdhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=GjwYxPky; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Thk4GRou; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="GjwYxPky";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Thk4GRou"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 15C2214001BC;
	Thu, 16 Oct 2025 13:02:42 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Thu, 16 Oct 2025 13:02:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760634162;
	 x=1760720562; bh=GI2W39nf8gC+Kb1laXyVxWmMzub8Dt4YQCQenVbddDo=; b=
	GjwYxPkyWYS8j+0Pwne5RnXNGjhVHYbyZ7SB0DsZ7VCnZ74E27nQooVGHOrRqg+Y
	BX3tfJMEk0AYrzC8Cw6CmfDk2qVWwnWZmJthjPZi05neGxEAR1xDzSw5Thu2QChb
	+FQnWZXyLrLALeU2kvlt/7eo/KPtLAeuJ1HnUg8bolRFEUuMWZ+/0RwxpwpWWI2U
	USvQgAmekhENQ2FOVvwqSXxoqHxi8y1kDEZQPCP+6nqPOwclyX6u/nc08lHij7xr
	j9rOofTrnlN270c0Ebr7MIr7SjwyFjMqyKz9tsu/HGP6oB1zcp7qFdFDMK3QkBqM
	qfgNvPcf/PR7KvTyjj5TOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760634162; x=
	1760720562; bh=GI2W39nf8gC+Kb1laXyVxWmMzub8Dt4YQCQenVbddDo=; b=T
	hk4GRouDJCWAK2ndD1AikJlyPUoPKmu3C6ohdPca1I6B/jRgA1tmSoz9i6mOZ7ow
	S4SONNibdJLjAI9o3EsVG9IIS3NneqqN7ynZSPDYWgQTM94jN0UKK69IajSUmtEz
	cRo9qY4XthTSFTeABcLRIKvyvkZDzefSUiX5zEhrRD32s5XeWUvrVxzpfy2OLwgv
	1edH1HJ8OcCM8qMNYAtZ3jJAUJLCnsOX9O7r524c2Y6vAusn5lCPpBpvoqwk+knI
	TxAINcD7XAGiKT/+2+lJ/Lin34nerk4Bl8Q94J2Bi/dufN4uACqN5VaaDxWhiPWb
	leQJ0bx2IW9Sph0sb/LAQ==
X-ME-Sender: <xms:MSXxaI9oHOMhp6runYEADyWDd3w-SRV1LrF0S_KGn1QQG4LSFaE4vos>
    <xme:MSXxaLjSa3r-2kqa6aPCkhRWcw4A0kkvlZsQ3xEeQJhD4u73R4xvciBD1IO_whSlq
    YHko3O1lnmmsm1IxaMs8kGb4oDVFDGuCnLh0YQ3BU9HSDc1kAGpmw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdeikeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkjghfufgtgfesthhqre
    dtredtjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceo
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpedtiefggeejgeejhfehuedvgeejkeelgeduudekleejkedtveej
    gfeigfefkedugfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtgho
    mhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsh
    grnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohep
    ghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrrhhtih
    hnvhhonhiisehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrrhhtihhnvhhonhiisehg
    ohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:MSXxaKpTroHeWPGqC0IQYrEgc3sZd--85itZNO7GnsQH7xjIOMIJ2A>
    <xmx:MSXxaB_LCUecQ21rC0Cug3rjychoFSV9dcPI_pWX8eRt6N41F3IpqA>
    <xmx:MSXxaGcls5SPdg5Mdcz1trhJUYXxpTWzSCdeQTKEdC-Tm2nd_DrGKw>
    <xmx:MSXxaLKVBaDjOP5OYem130eT-s6S7PLldTfyxrrX4K-x_AoOp9RrXA>
    <xmx:MiXxaM7f8ekznkia27Ims4WRfQHxNlHnL5XD3Q2mg9ZzeUgMoMutUQ9M>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 938661EA0062; Thu, 16 Oct 2025 13:02:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AwcMx7jJMkTg
Date: Thu, 16 Oct 2025 19:02:06 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Martin von Zweigbergk" <martinvonz@google.com>,
 "Junio C Hamano" <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
 "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org,
 "Martin von Zweigbergk" <martinvonz@gmail.com>
Message-Id: <d47e137b-c34d-49c9-bf45-226cbcdba416@app.fastmail.com>
In-Reply-To: 
 <CAESOdVAEN=YeMqozR4438L-U7mZ3nhRnMB5PV_sUPmwuWSkbhQ@mail.gmail.com>
References: <pull.1989.git.1760566054455.gitgitgadget@gmail.com>
 <aPAgBPLH4QYa0ceP@fruit.crustytoothpaste.net> <xmqqh5vz7ygc.fsf@gitster.g>
 <CAESOdVAEN=YeMqozR4438L-U7mZ3nhRnMB5PV_sUPmwuWSkbhQ@mail.gmail.com>
Subject: Re: [PATCH] BreakingChanges: say that `git diff X..Y` syntax will be removed
 in 3.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025, at 18:38, Martin von Zweigbergk wrote:
> On Thu, 16 Oct 2025 at 06:44, Junio C Hamano <gitster@pobox.com> wrote:
>>[snip]
>>
>> The same for "git checkout master..."  that detaches HEAD at the
>> fork point of the current topic (so that I can "git am" in a new
>> iteration of patches on top).
>
> I couldn't get this to work:
>
> $ git checkout main... --
> fatal: invalid reference: main...

`git checkout X...` works for me.  Apparently it is this part of the
doc: =E2=80=9CAs a special case, you may use <rev-a>...<rev-b> [...]=E2=80=9D

>
> But don't worry about it. I think your point about there being other
> commands that support the triple-dot syntax is still valid.
>
>>  As the syntax "git diff master..."
>> is symmetric with it, if one were to change, both should change to
>> the same.
>[snip]

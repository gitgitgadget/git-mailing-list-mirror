Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A4D18D65E
	for <git@vger.kernel.org>; Wed,  4 Dec 2024 20:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733345137; cv=none; b=SQSBRRuCP9L2KDuSaS8IVZt6VPlHPUyNICBxCtsyQUHp2+g7ggQkVGzjmZ7TJW2M9NwPm0dg2GyAV89ORvt5Vt9qZtUvo/2TRVN6r4+R35kXd5APSyTBubWhoQr7zNfHaVsZGSdMQLRTTJUZQklzo4cH6XV6RbLulz6SEGkf4Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733345137; c=relaxed/simple;
	bh=JlcfvtgRyHxhyw1jtYhFvLiVgCOdL9KtF/C/iYimQ7s=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Nxp62u9TkhsGZHXabPJLluL3vJNxBjN40XzPAuI8vEgv3Ni0WOZ9gBBmps5dDWZjYBZLKt4nFwc0B2cKZb9yUQSjJxCp68h/z0Nnqk7ImyM1SonQ3ECeqCsVSuy/5uc7shUyXjB/k5AMGcxmeM0ohiEwMY809BYSm9l8dnXlpzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=lBAZ5KYO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Od4h4656; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="lBAZ5KYO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Od4h4656"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 52E1311401DF;
	Wed,  4 Dec 2024 15:45:34 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Wed, 04 Dec 2024 15:45:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733345134;
	 x=1733431534; bh=YwNtoCJQOoiAt6BaV1qf167fNsnx7GBavVmIvmdD7MY=; b=
	lBAZ5KYO5x3sxYj/iEAGXOOO5NEmCvmwJ8hLhD/MJX2Doc9da6Nu02CbfsncpeQ7
	hmUPd08hJ9v8b5vlGf/b7VmP1ulM+vPQvuUGmg/v44iyd87stWcdECVmCWR/tF2T
	A6uODxEMs33iMHZMFDdyYZg/UYqlfgOcgKiHaehOo8BeINo8WEGzaPSs8or0TSd4
	iRrqoN0pn6xcZhOzlgLPfygKZigOo4t+Fg0g3/BSXkUoMKHMBRb5Ko0u8Xp1mfJY
	Oz+dbDkyG+Uv0uQuJdcMJBBoXtpjDTS4/5LojOli85NNOu+sETMS4ZDVZKPExO8f
	gbRszz0vgmmkEzTRKZrjzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733345134; x=
	1733431534; bh=YwNtoCJQOoiAt6BaV1qf167fNsnx7GBavVmIvmdD7MY=; b=O
	d4h465604gsZEkrgWbSF+09KXpdUA6j2bKRtg1Htv6FRlscJ09Dq5cm1RfFZphg5
	e6tPhcSKQDjWgrQJwVLzy8LGVrw3XInwUGcGXKzWhCOUyv037wUjMNQmCIbrUdUs
	E94hxblciGOZrZbaKSzvc6tGXdYN4MftlqDRRApXYeLSJk1ESkOQqyJ+EO7SkWok
	GRlrxffnlbOstFlgtf3f2gdNBhqWcAVhOnEPzYOArbqe9p/EzLWT2Rd0jsqptLGk
	S8yTSO88VovEeivxLC5aK3Ca3GlEHaA2w9QjO0iXAmdpdxDSb4Tr25dRLnbvrH+8
	CQYjSflPn4v6ki7GI8RLw==
X-ME-Sender: <xms:br9QZ3yq6Voka0F4kaZr8ZE5BcztRjpmSGrNzA3Dy9l3_iPsy43Dz44>
    <xme:br9QZ_Qa756q7jrwitGx2hz9xCrRHW-9P3M-hR_xUhG2OeF1lHZ4X6v9sID7CZLkA
    rG9ld7Hzr0GVoFL_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieehgddufeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgr
    thhtvghrnheptdeigfegjeegjefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfe
    ekudfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsg
    gprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehphhhilhhl
    ihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopegsvghntggvse
    hfvghrughinhgrnhguhidrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinh
    esghhmgidruggvpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheplhdrshdrrhesfigvsgdruggv
X-ME-Proxy: <xmx:br9QZxUKVuac5No03MaROyZcfrdNQUtbkh-FtOCLlsVl5NM5iD6s9A>
    <xmx:br9QZxiV8CUkKtoaMsFXQM68eJhjHcz9YuMBamRPMU36nhRLyvLVTA>
    <xmx:br9QZ5DPxsvjKfCx7SOx10S7Sa7jtR2GwEBPVgIuoe4e0jizUPg7uw>
    <xmx:br9QZ6JcyBsNK3Ai_KSsYI7-yrf40DtBTO6Nn1734CxarLxu9TUe_A>
    <xmx:br9QZ92hH9GkFLPKGkJRw7CssvScMTniV22u0qpykZ7FNAwSFZg9uLVJ>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 03B76780068; Wed,  4 Dec 2024 15:45:33 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 04 Dec 2024 21:44:26 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "Bence Ferdinandy" <bence@ferdinandy.com>, git@vger.kernel.org,
 "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
 "Karthik Nayak" <karthik.188@gmail.com>, "Taylor Blau" <me@ttaylorr.com>,
 "Patrick Steinhardt" <ps@pks.im>
Message-Id: <173ea521-6a2e-45aa-ae5e-4da99060cc4f@app.fastmail.com>
In-Reply-To: <xmqqh67j2ndc.fsf@gitster.g>
References: <20241203215713.135068-1-bence@ferdinandy.com>
 <20241204104003.514905-1-bence@ferdinandy.com>
 <20241204104003.514905-3-bence@ferdinandy.com>
 <cfd54be2-af8f-429f-a4c6-41f54c33c89c@app.fastmail.com>
 <xmqqh67j2ndc.fsf@gitster.g>
Subject: Re: [PATCH v2 3/3] remote set-head: set followRemoteHEAD to "warn" if "always"
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024, at 21:40, Junio C Hamano wrote:
> "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:
>
>> On Wed, Dec 4, 2024, at 11:39, Bence Ferdinandy wrote:
>>> diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
>>> index 7411aa770d..daf70406be 100755
>>> --- a/t/t5505-remote.sh
>>> +++ b/t/t5505-remote.sh
>>> @@ -504,6 +504,17 @@ test_expect_success 'set-head --auto has no
>>> problem w/multiple HEADs' '
>>>  	)
>>>  '
>>>
>>> +test_expect_success 'set-head changes followRemoteHEAD always to wa=
rn' '
>>> +	(
>>> +		cd test &&
>>
>> I think you need to `cd` in a subshell here.  See `t/README`, =E2=80=9C=
Don't
>> chdir around in tests.=E2=80=9D.
>
> Puzzled.  Isn't this inside a (subshell) already?

Aha, then I didn=E2=80=99t read the context properly.

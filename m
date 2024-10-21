Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5D71FB3C3
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 19:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729537792; cv=none; b=km49GI2UoZRTJzehWNEdrOcZ+zAwJ+UUD70g+ziB7tl3XQFWUGM+DC8X6Pm8A4l/Xr6pKrtPZxDGNsvL0xpmE5DhXK+644ryEzK1SE4B5F6fAcbNxTXcrNrDTrPtrJm3f3Dm/sv9ArN3LTxSaezPgP9WbIfbrJM4Anh/pE0saiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729537792; c=relaxed/simple;
	bh=/pt3cGZU6gYGhDqOiMkLRMM3zhpdLRk1dQho1ZA7TWk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=iX+9I9ZpIf/hXXmbWIS3vaJGx9/PK725nAOOTHC19b+MVatPnibVERPFaxg96/47MGRCZfUg2LgP8kdXyQi/303Sy2ybFfO1Snr6UcoV1NJ9RZfMS19qJpJX5Ai3wTLI5UR+u8tnN9yastpjLzyQeHHHEstvzOfwjOCSqE9lgi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=AQkcIGdb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UF4rgmJq; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="AQkcIGdb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UF4rgmJq"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 13AA013802BF;
	Mon, 21 Oct 2024 15:09:49 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-11.internal (MEProxy); Mon, 21 Oct 2024 15:09:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1729537789;
	 x=1729624189; bh=/pt3cGZU6gYGhDqOiMkLRMM3zhpdLRk1dQho1ZA7TWk=; b=
	AQkcIGdbofthr1849HgG6BGiYMBBqKpNBriIlA5qAGEaTwBbkwrNfYEhiMhkm4NA
	lv9EzJE7TYeUKWBQFb8oRChvq2sKXCqQepGGFUuJlGNOIRH1Oe7O/2KlaTLDuqie
	KwCmXu2z47wG43ezRCaz8B+kP7sbpuiAc8OlsBG80pd0F2+cn2SzMIiXm1vebAyg
	5BWzDhDLWDwo3zoCqhZD+xgfmOuGIuuUPKUZysNvjulZddQqdog/3kGpa4Urqce5
	yVowdieCJTVJOxPiAB8G731kq8TcTXTDcQ801tgNVJBGducwIKpRSoqFPrWRcwf2
	l2NwkfS5kAavMeS/BKyHRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729537789; x=
	1729624189; bh=/pt3cGZU6gYGhDqOiMkLRMM3zhpdLRk1dQho1ZA7TWk=; b=U
	F4rgmJq/YFHPQ5j43eC8UoL9BePBcZwUuvdOooZg+5wpBsEiRTEuMhcdWe6KKnY8
	c8i85Z4SQZrIOYUCcu3ACjOoZXl/leaffcxvIsWI+TymfbzdfqcPgTkT/7lTNb3t
	Lh5hjJ3Qs5fj7z+0omPONHKhfj60CvA9df4TNzAFzB5ATyR0/M6HwAy82z1NKmDQ
	Yv5dDwephMKj/puFzBtCfSMX2kn4DXlZNIqksmi52RLQIxnULeDAy1lMz3Ch1w0i
	SfXY0VFgm88M0HZEKUWAs8+u9g68Pk2BGzE45palKoa1QGCB7SC3Koa5GH87EV7F
	lODt6SNJ08pNMBVgWeLQw==
X-ME-Sender: <xms:_KYWZ5TzApa33uVXXSKh8swBa5dt52Qo6s_w2DUSPRxef7n_W6sAqA>
    <xme:_KYWZyzKfrJN9Z31SZG3WrNsQvBFjWlk9QFyVL6_lnvso8Lbq8usAVrb3wo63WO0V
    Qt9g4MItEW7ThM5I7M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledgudefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdftvggsvggttggrucfvuhhrnhgvrhdfuceorhgsthesfhgrshhtmh
    grihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeelkeethfehieefkeduiefgvdelkeev
    vdevleejffeljeehuedtvdelveduvedvueenucffohhmrghinhepghhithhhuhgsrdgtoh
    hmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgs
    thesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehprghtrdgtrghllhgrhhgrnhdusehgmhgrihhlrdgtohhm
    pdhrtghpthhtoheptggufihhihhtvgefsehpmhdrmhgvpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:_KYWZ-30j2lMcux7Y83R6yBwhRy_-pB4TqFynth5FYRi45X0AQ971w>
    <xmx:_KYWZxCjt927Clerg2d4wdokWl__wm9pdypLP3Nen-mvOivm9YJbkw>
    <xmx:_KYWZyiStNIo6s4gxaw-uwyyZOYy5HPGg5wunHlVSQxIxZW8qE8_Ig>
    <xmx:_KYWZ1rH-N-ht46JhzlqlnN4Abe096qGEaK_t4of1pqVDfHbHXXfIA>
    <xmx:_aYWZ1u8oASXzXSb1SQ-MnLQ6QraRQg28BD0Yg04mMayikw1-FzlsHY0>
Feedback-ID: i445c46d3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CFDF42220071; Mon, 21 Oct 2024 15:09:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 21 Oct 2024 12:09:27 -0700
From: "Rebecca Turner" <rbt@fastmail.com>
To: "Patrick Callahan" <pat.callahan1@gmail.com>
Cc: "Caleb White" <cdwhite3@pm.me>, git@vger.kernel.org
Message-Id: <fc908a02-4901-4c14-8b37-e246ee7065e1@app.fastmail.com>
In-Reply-To: 
 <CACt=GQry+mR7fVSUEdpPjsgSoDURk4W-DRPqLkom-f9Q0KBuTQ@mail.gmail.com>
References: <D4SO70M9Z1QI.1AC4QF9ZG8T4L@pm.me>
 <444a412d-bf4c-4bbe-8250-18d8bc86fd21@app.fastmail.com>
 <D4SQFBEB1HYZ.QDOLCYY80DIZ@pm.me>
 <517c8829-f98f-4fed-af4d-b84182fb253e@app.fastmail.com>
 <CACt=GQry+mR7fVSUEdpPjsgSoDURk4W-DRPqLkom-f9Q0KBuTQ@mail.gmail.com>
Subject: Re: `git worktree list` when bare repository is named `.git`
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Pat,

> I'm working on a tool to manage worktrees as well. Can we compare notes?
I've mostly finished my tool. Here's the code: https://github.com/9999years/git-prole

I'm not sure the repository layout my tool creates will match your expectations, but it'll be an interesting point of comparison. Enjoy!

Best,
-- Rebecca

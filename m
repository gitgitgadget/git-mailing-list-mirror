Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCD72582
	for <git@vger.kernel.org>; Sun,  3 Nov 2024 15:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730646492; cv=none; b=f0Qawm+1iFWAjiYkfTmr3c/t4BXLerMGeqn2IYA6M/ynS0xoFtidxzSKd4m6m3hZriSx3XuScarj6aqZsHWhjLaB1ZOXY8AldVIDdVK3XlDOXXNBJJbXSJ/+6BBvm2EohVtqWWgs1jJHq07p3XjcJ+SWc6AFstfZAzbFDXxY2dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730646492; c=relaxed/simple;
	bh=8IFjoKdfQUtFFa4gyTZya11cuZpz27Xp2BKIvYfZhN0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=aCZINaoETekSWXL7tdkq0+8AfjNP+E8T45QiYnjawsUfXzuo4Bd7pPRd0GAY85o7lzi5qz9I5xLyKeabjkvg1+ZzIUdgwMfily+m922oZeM4+wjzx8zyFYMJFxSBkElSLpn/HC1LsrjluKUDsOmonODrXOWC1wNgOHlSl4vdqWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=RC/NaZ1G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HXTfbjk1; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="RC/NaZ1G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HXTfbjk1"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 71D722540109;
	Sun,  3 Nov 2024 10:08:09 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Sun, 03 Nov 2024 10:08:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1730646489;
	 x=1730732889; bh=pm9hYBI10F9PMSWDtLldDwVjsgl2uOWCmX+Roz4nWqI=; b=
	RC/NaZ1GsgOehzY9CcCB9Ko3Xxxochju6hTPVZTW4cgQ3xF71sU4PQIQVIqjhE/W
	yxPA2Lqr9bNPOvtVn580EZ4nmrKC9Wy2nHlGzabPDCbSKgptUlhpO0jsCfPiyexy
	F0//cnlytPZ4TElyeojfuqckSm6vEXFXTxiC4hiLMbcA6Bx2zn8CgtGgkIyAOq5s
	1shIUqUOkH8E0jEPhlBWUhkYoafBfUcpw4WgNMDnkywM4KxAH1uf0CRpV8E0ay7C
	fRez9+nPC/oQsS25cCC98oY6KlxQZ7yUEikBfrutmlsnQK9dmBP2ED6aHd6JmIzW
	NeMEBf+DCssXRgSD9AVzTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730646489; x=
	1730732889; bh=pm9hYBI10F9PMSWDtLldDwVjsgl2uOWCmX+Roz4nWqI=; b=H
	XTfbjk1OzJjuOrJOUKwHUsxRDYIg25VSWoKPbqUxWdM5BBY79AfUQ1xiRLyCbV7J
	ouD4u+rcuz16E+fOl4BM0/9gK5mWwX17xHMFENpAxAL+eMwLPaJT8cWGv9rRrRg7
	0T9AkU+bw/rF+sqlYo2j5KU/pL+0JsmXipMViGgl9LlU9U2uUVfmDyn5OBuW0V8X
	rI7s1dIPpL+L7jyFyHK7aHDx1i3ZLJNFULEBuuadgcC8KoayraHGnyNSllK0IWUJ
	9aA5OLnqvuxscKiiy+azrxIcWtrfDzA9Pxp1p1eFNYVldwIuNRis9t4UTX0Muptm
	efzaKw3SXkMYx9ZiGJKQw==
X-ME-Sender: <xms:2ZEnZwIN6MtZhjD67PepVfK68vDGtBfZ1I2OAqpUS25A8U1gvx1k9Oo>
    <xme:2ZEnZwJyS0_wpyoVo6PL19bXitVEiSLf90vl5s_6gmpDVHjxirISXj4f8HioqycUt
    uj65fAWrn4aeEzqCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdelgedgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgr
    thhtvghrnheptdeigfegjeegjefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfe
    ekudfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrghrtgdr
    shhtvghphhgrnhelieeshhhothhmrghilhdruggvpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:2ZEnZwuvxVjGo67URC2Ohi58KlfRWBzkvnreVeUeur6ERm8vLdUY3g>
    <xmx:2ZEnZ9bVdpSXPNVbSwN8ffW7ERod-3W7OerGqKPYIrW4r9eVrFpD1A>
    <xmx:2ZEnZ3YUQ-y1LdRgad5KwBBn9cpqZXbx5Vcmavb0NxMe6nbHeRosuw>
    <xmx:2ZEnZ5BWoI7T7BgecTQaqK49zcQBbdOgIMLxIqU7Q-JsCwETWaP-DQ>
    <xmx:2ZEnZ2n6MxqqRGTWsZarEEyFhP-x9KX-3D_r3B0vaB8S5sJPk9rJWkOj>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 130A8780068; Sun,  3 Nov 2024 10:08:08 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 03 Nov 2024 16:07:46 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Marco Stephan" <marc.stephan96@hotmail.de>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Message-Id: <bb6d781e-fc67-4790-a3a9-8b672dcfe7a0@app.fastmail.com>
In-Reply-To: <9fd66b8f-c457-451b-9862-6121128b2786@app.fastmail.com>
References: 
 <AM0PR02MB4980D186BDC087336C760132E6502@AM0PR02MB4980.eurprd02.prod.outlook.com>
 <xmqqo72xxcxo.fsf@gitster.g>
 <9fd66b8f-c457-451b-9862-6121128b2786@app.fastmail.com>
Subject: Re: Git revert cannot be aborted if the repository directory has been copied
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 3, 2024, at 16:04, Kristoffer Haugsbakk wrote:
> On Sun, Nov 3, 2024, at 03:34, Junio C Hamano wrote:
>> Marco Stephan <marc.stephan96@hotmail.de> writes:
>>
>>> If you copy a Git repository directory to another path while there i=
s a revert in progress for the Git repository, "git revert --abort" does=
 not work anymore for the copied repository. Instead, it will report an =
error of the following format:
>>> =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82error: Entry '=
...' not uptodate. Cannot merge.
>>> =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82fatal: Could n=
ot reset index file to revision '...'.
>>
>> I wonder if
>>
>>     $ git update-index --refresh
>>
>> is all it takes.
>
>
> This is correct.  This successful test can be added to
> t3501-revert-cherry-pick.sh:

(Meaning one can add it there if one wants to see for themselves)

--=20
Kristoffer Haugsbakk



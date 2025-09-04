Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC612C159A
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 09:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756978978; cv=none; b=ig6/iHyQxMmaWTPb63q11SQ86FfdBNluYNQOtsAqs1vaIf4Wcvi5VAxyIOcdUGVJAtvPQJQwVd/ad+mAGewicUUu9SIF690WPsrbFxbUPI+C9Tc8lpsE1qSx4ARI5qmd/AFSDrAPKBtZljtFRx9OU5UhjTTMcIyldCYftR4gT1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756978978; c=relaxed/simple;
	bh=uIJpQqyvi/wB3BiTDD4MdVl4Vnl5Dn/0wBzzg2cgIW8=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ChaP8wRj+Qb+PS66588rFpTuG/9QuqLMp8f0k2/CV5aIFIhLWmsIwwrxA/21hTi1HKxgVRc6ooOSqEkEQSIDak8J8/aXqgxqJxsDYtheX96OJngPqpvjSpAO9HnFeEB2UJiSUJ52NZxKDkEvqU3Y/ZUO8rdfKsCskqz6V2j+wkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Q8BJkMDa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qjm5aeMp; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Q8BJkMDa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qjm5aeMp"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id A4CB01D00254;
	Thu,  4 Sep 2025 05:42:54 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Thu, 04 Sep 2025 05:42:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756978974;
	 x=1757065374; bh=uIJpQqyvi/wB3BiTDD4MdVl4Vnl5Dn/0wBzzg2cgIW8=; b=
	Q8BJkMDaWHlIGbpEySnxtBdfedVSfQwFpe5Sm7x+BL9gD94jO6Z/E7ehDlMRYjSs
	+rWuiVjmXfbTebip1mTxojxqmW8IK3flJokJYmlpqCz0sUGUu2JRMlWkrxRZPOwY
	/UKbGEERT130AXlrifpk/uJyMWCo3cWjQ0Tm2bQWvgWH16brkgJp24CROA0cahUU
	G4IsXPLB+g96JJ4BjtUmVKZI9dNWpuvo1h/kOZeBjmK9y2pRguQu/rppvmTseorQ
	oyJ2wR9v+DCxNLD5EHcN4eAnnbocsht7cH/wVbQdzCqsR61oNBw2ShdrqVb2rxKZ
	mWmGg5CS4IP+lr5dH7UWlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1756978974; x=1757065374; bh=u
	IJpQqyvi/wB3BiTDD4MdVl4Vnl5Dn/0wBzzg2cgIW8=; b=Qjm5aeMp4XtR+UYWw
	Tc8kjqk3zcFgFtaaCvD8bHGLS+GP3hfvg1CtlyU8md24ffEC39aKoXxlf36QaHiY
	pf8Or268FfCHxHV7TjMtH5em6KZKgtHqC1goCU63Wz2r9oTcj0rgTST7bIcWK5dG
	dec8j++wL6iQoXMeqiCvbZdTOWXJ1znhlfZ8cVvzwmYSXod790e71sANr8ZfJdAe
	i4jyTY0cyANv0jZeIIhz2q8avGn1IxQp9dFNkkdM2q1dzACtXqtgjl5jvAiu2ZDS
	VO1ZRt60YJEDjn0cas1/rR3T+Dlz6RqCMxN+IAHoJ/OLEsR3/mM7/wjDVAO82hHY
	+MkdA==
X-ME-Sender: <xms:Hl-5aJBp-TltY7PnGxN32m7nOByuhaUfqicig5txovSWLBNQj2G9vr0>
    <xme:Hl-5aHhuvzykeEVLb9bPDjPRd_2J3oFVKuxBg-onPI_7MPBENyEVRoZudaJnv1UFS
    hAPLUdbZ0uhHkGgLg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefoggffhffvkfgjfhfutgfgsehtqhertdertd
    ejnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhi
    shhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnheptdfgffettedulefhfeekheetgfegfeejveeikeeffeeikeekhfevieel
    tdekgfeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhn
    sggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeguihhlhi
    grnhdrphgrlhgruhiiohhvsegrvghgvggvrdhorhhgpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Hl-5aNFS1CuvZV2E_85YnFmrNCoqauUVO_GYdxxocWQs5zao5xfzrg>
    <xmx:Hl-5aLSGQezPfDp4p0JyXofLr1rpzqV6bPOQr8fDxNkeoytYHTDVeg>
    <xmx:Hl-5aBH-c1pNPnp-rufzrKouMOqQw_atbpjWes9dHveLYXEjxy4Pbw>
    <xmx:Hl-5aP8l54oDqgyUAWJb0ggXaBRA0GBMfTBC7FBCWP-YitHKHnqTXA>
    <xmx:Hl-5aJx-gpK3SctMdhcMo3VZU1UZp-YuHzdE_c-U-INtxg_UkfbuAHSG>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 417F51EA0068; Thu,  4 Sep 2025 05:42:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AlQwsfZ_u25N
Date: Thu, 04 Sep 2025 11:41:51 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: 
 =?UTF-8?Q?=D0=94=D0=B8=D0=BB=D1=8F=D0=BD_=D0=9F=D0=B0=D0=BB=D0=B0=D1=83?=
 =?UTF-8?Q?=D0=B7=D0=BE=D0=B2?= <dilyan.palauzov@aegee.org>,
 git <git@vger.kernel.org>
Message-Id: <2ebdff4d-8adf-45d9-8cb5-6d7ee39f218d@app.fastmail.com>
In-Reply-To: <79ed51fbd94ec2793ab0388b33963b366e48c590.camel@aegee.org>
References: <79ed51fbd94ec2793ab0388b33963b366e48c590.camel@aegee.org>
Subject: Re: Doing blobless clone by default; switching between blobless, treeless and
 full clones by a command
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025, at 11:33, =D0=94=D0=B8=D0=BB=D1=8F=D0=BD =D0=9F=D0=B0=
=D0=BB=D0=B0=D1=83=D0=B7=D0=BE=D0=B2 wrote:
> =E2=80=A2 add a git command to download all locally missing history, i=
ncluding=20
> for treeless clones and blobless clones

This sounds like git-backfill(1).

I=E2=80=99ve never used blob/treeless.

--=20
Kristoffer Haugsbakk


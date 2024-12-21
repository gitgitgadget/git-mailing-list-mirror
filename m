Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6038264D
	for <git@vger.kernel.org>; Sat, 21 Dec 2024 12:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734784896; cv=none; b=KRbELj0u51SE9skV61+rBYhzTuoowb73cegCwVF6UKCzQMK5dMkm6mGxYkBd694fcyiTbKjSEM4+aJkEpRzbKzlAiAjqDKdUGf/ivcLMIK++lk2HiG1KStIcidhI81BUWEIWC0EHCUHyU09XfEsathdib//Wd5NN1mjRAq+dBJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734784896; c=relaxed/simple;
	bh=rwwVgBrUN71ztYR/Fl0kSELx6S3o/J+RtBeYrNSpAMc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=CD4ILUZdpEb8wpiGviiPGAmnTR90baHHUtk2t4FA5lg1cOjs5ID17afxTyG3RHKBiY3yuK4vBGM33OGlD5yjTKDf7OkD4dcd1Zn+SOtjIEr6OlV0Z3FEILR57Q2MPWza9dob2InM/GohabQVeu9820FaY3WxypNc/vJvrgiVQTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=bSOHT9Yk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U6OMx/D9; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="bSOHT9Yk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U6OMx/D9"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6EDEC1140113;
	Sat, 21 Dec 2024 07:41:32 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Sat, 21 Dec 2024 07:41:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1734784892;
	 x=1734871292; bh=R+LrkiWK9G34dGj+g5w5LE+6uZGcIT6dNKfPIL4JVqk=; b=
	bSOHT9YkI2GvP0Za7YXb5cFnez7MeCoVMoXd5RPtWPSkjAJQFlQCUBi1Xpt9oIUW
	EWFrXDi9rq5z9XoOc69PCW3/6e031NVntjCfe8ilfmLEKZhCQT2ilWz4auwB4FDr
	c1rhvdFTIs3NW4WY8bDEPlWxqP+xF56anXmoAe42W3q5RgoJ2f7BuP744Kl65gSJ
	e/1YSulCFBW+CzAIoahGfcqSXpnXHlr+Qdb5f9JKyhQsBj1a0HjCBr1vtH3ayoNQ
	EnjP8H0DA0nNkAvIWRa7jE/spUM+CL7CfLWB7HX8BilNm38Sx73wpKXlfzIu2WKP
	QdGq7Sz7GLSJpA9bwPbaJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1734784892; x=
	1734871292; bh=R+LrkiWK9G34dGj+g5w5LE+6uZGcIT6dNKfPIL4JVqk=; b=U
	6OMx/D9Mz8H7rDA/mCwoUuY9RKOUaLYQkV9GgywkjkGrz8KHdIvulk6+CYY9DRV/
	LQVIw1tBU7L9+eoclV9ozhi29kGYAvrO9bfuo/wjPwWSZmzzmckPvetdYjQqgQzQ
	3itF56XgPT/hMyrpyjju8/2Sz8+IGcoQNCTGgnawk86hOSJVVHTwqb/6/eSfo5Q6
	BPO3u6JsBggtjhL9rMzyMtz4GSe2KDe1Ct+yvf7s5rfwSzHcKHtanBCZgYV8AXnG
	kyEpKJI5Q+jxNV7JR+Ur0WiCYFAFRdl08uZc2PgdvcaUHs8o7folyYrbwekGpqhe
	Fo148O8sEuUXgxXCV4hHw==
X-ME-Sender: <xms:fLdmZ73NJ1NL1CAAh-sWTtQhu0c7WFVq1SiczWDt4RXEoSlbMLZBwhg>
    <xme:fLdmZ6GD_AKlBfcq4k8hVEtymqG3tmiTQRTwjJVjttfZHnJYvP6gcCajZ0S2qbIXu
    8fs23HV8yLVZBS_FQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddthedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgr
    thhtvghrnheptdeigfegjeegjefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfe
    ekudfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrrghnuggr
    lhhlrdgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtggrpdhrtghpthhtohepphhssehpkh
    hsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:fLdmZ74JkxGjYRXiATQ5RPcGMWfCV0rq26C88dNLMgkq2o_DHS0CkQ>
    <xmx:fLdmZw1GZ5pyxP86o1f4xI964UJMMdFQJoOxuI1A_TYayCYnEaR59Q>
    <xmx:fLdmZ-FFKJ37-LKEhRJgup5KneTY9EO9SnhjBWILQqmXRcTvQMNX1g>
    <xmx:fLdmZx-DQCPgXh79YjaiJK52L0oMwD9GzKKWWVkx3OEaoGwUTHwlzQ>
    <xmx:fLdmZ6CN5LYX2Q6VuypvFhiSo_pJycySLY6_k-CCTfEAod204yD31Jdg>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 160EF780068; Sat, 21 Dec 2024 07:41:31 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 21 Dec 2024 13:40:32 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>, git@vger.kernel.org
Cc: "Junio C Hamano" <gitster@pobox.com>,
 "Randall S. Becker" <randall.becker@nexbridge.ca>
Message-Id: <b4ba502a-b689-4736-9712-443a137b5d2c@app.fastmail.com>
In-Reply-To: 
 <20241221-b4-pks-reftable-oom-fix-without-readers-v1-2-12db83a3267c@pks.im>
References: 
 <20241221-b4-pks-reftable-oom-fix-without-readers-v1-0-12db83a3267c@pks.im>
 <20241221-b4-pks-reftable-oom-fix-without-readers-v1-2-12db83a3267c@pks.im>
Subject: Re: [PATCH 2/4] reftable/merged: fix zero-sized allocation when there are no
 readers
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi

On Sat, Dec 21, 2024, at 12:50, Patrick Steinhardt wrote:
> It was reported [1c

A Neo user, I see.

s/c/]/

> [snip]
> the result. Now that we do we notice and thus return an out-of-memory
> error to the caller.

s/Now that we do we/Now we do notice/

Repeat of =E2=80=9Cwe=E2=80=9D.  And =E2=80=9Cthat=E2=80=9D can=E2=80=99=
t be be used since it has nothing to
connect to.

--=20
Kristoffer Haugsbakk


Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340903CCFC9
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 11:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773227677; cv=none; b=d3zw+4cykzn+mLmXYiqcGLA3uPEJ5pht0HGRURC4irmXi6TyPZPtWHYZvH2+PYleqr4Pj76r3Fr1WDKd/Rvx6IpgJY16+6L1HfTHz9fgXHYcVMHxOfuJlQos1fdxyiB9axqjf7VV69tUjE0pmA+d/c7Va0OIEBo7w/GIL9sY8ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773227677; c=relaxed/simple;
	bh=ZK75+YA+glAwQ8XYDkGBSHKznRIa2YTJTixczt0vGJU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=IRidfrnQVhQn34UEKlUSh1/fJgTA9CkjTuGr7QITWz+fotD3A4bCWLYyHK0w+A2D4leaNJUF/CQe9FvbhkrtfQkMUkZsSM1jZshEp8IiK5nhsc/l/uvqyFruNZcFhE1kA4mOhwO+vJq+bDJbSP0EaN5/ouavY/eXGq/Eo4aGDQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=dkPD7oku; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oPRdAezp; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="dkPD7oku";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oPRdAezp"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 92AF77A01FA;
	Wed, 11 Mar 2026 07:14:32 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Wed, 11 Mar 2026 07:14:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773227672;
	 x=1773314072; bh=ZK75+YA+glAwQ8XYDkGBSHKznRIa2YTJTixczt0vGJU=; b=
	dkPD7okuRj5AC3S3O+qNfLltj/Z92YTOpPCk8UlxnW/tw5ATemKLsSRO9Ng+MVks
	2BPTBN0c1dT3VxmGkA+lOu/uRaJDO7y6GjwkUoIQxBiksMRiMtiDSFf8MOb/Khxv
	+bPHHhD6AQKG/4N+4V4rjUDwIUi3P6hRvf3+nxkQn5c2QgLMdA0LUOHiVktgy11H
	0rkLT+MgKZmbNL6Vcgv+67VPai2JHENMsOLGactsFbmURn24fC/nBzzj37vKS8vN
	C182eZG1Zp9AxmQCElTAwIhc9RHyjMSu18gC1457A8iRPpjhTlJ459EVPltYmXQY
	t8/wYH9AcYtA8BpOMeq7zQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773227672; x=
	1773314072; bh=ZK75+YA+glAwQ8XYDkGBSHKznRIa2YTJTixczt0vGJU=; b=o
	PRdAezp6rpkjEnSX7q05engz3YVyF+sLc4QJu76qKHF2GD4fKXJgKNHQ5Al7uU+q
	JpjnkwyAHAkx4TUjcZpnYqoSc4UD9YERwuBdlRlUK7qqylaJdqz691EunRb7Lqje
	F4/iZzClytgBJ68kq2aVua4srZOogo21+Xt07I3a2ocU6WlNsTCqcMTZwQXvyHs3
	2cd91hGbwwrhB/VbOk2MuYYJFvV4Rh/kCmcmAP3kp5cELP+cBxxuWmEwk8DGU60T
	H9D5njhRbnO+tai183hDTo73Wy6IYhDN1jxGiVsnaQUg1apnOL+eut3hTkPeOJ43
	+IrTV/yFSaQI49htQ115A==
X-ME-Sender: <xms:l06xafAEpW1nkbQiBApKF0cvpv5MPF4-nlVDyDaecDjScHEfJ94ArJc>
    <xme:l06xaQWOgXq8YDpsKXsEy0lp0PP0zyS4BKYVIx2xlX0IaR0krcpDk9HHLzOgWckre
    aSI5jtctQEmEoZf8i6IMlYr0VGeDe9bJjvGbQ4rnbochCcW60bM7bo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeefjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepffeuueeiheeh
    ffejgedtveefhedthfevvdegudeltdffheejvdfhjeduffehgeelnecuffhomhgrihhnpe
    hkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpth
    htohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthht
    ohepmhesghhithdrshhtrhhovhgrrdgukhdprhgtphhtthhopegrvhgrrhgrsgesghhmrg
    hilhdrtghomhdprhgtphhtthhopehjohhhnhgtrghikeeisehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhope
    hpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:l06xaeimCDQPXs7MFtJhWkk4LC7bTo70lGiwxmWViyqWZDiLsNEK6w>
    <xmx:l06xablnT3Pj1TdF9Q_drX17rTKYIBUZvVb97wGq1zyyrVVRwr8AvQ>
    <xmx:l06xaaiYMfDXvXN5fSLlVPQiQhE2z2Xor_2Tx7pR37u2yhabu3TVGQ>
    <xmx:l06xaeHwmW_2ECp5UqWaeC00hJri8hYWY3p34ZhkAX0jvuzY-H3eqw>
    <xmx:mE6xaTC9Yd9IF4sI7G_F_Kllj_QfreXCrObhAOLGcBHseCaFfD8inCem>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A16851EA006B; Wed, 11 Mar 2026 07:14:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Adl1l9tAOWUZ
Date: Wed, 11 Mar 2026 12:14:11 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Mathias Rav" <m@git.strova.dk>, "Junio C Hamano" <gitster@pobox.com>
Cc: "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 "John Cai" <johncai86@gmail.com>,
 =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= <avarab@gmail.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 "Patrick Steinhardt" <ps@pks.im>, git@vger.kernel.org,
 "Karthik Nayak" <karthik.188@gmail.com>
Message-Id: <bcbbdcb3-9c4b-4eb8-9e70-3eb0bd19b32c@app.fastmail.com>
In-Reply-To: <c076edd0-9057-443b-ba37-33aacde2eede@app.fastmail.com>
References: <86e5c9f7-cd99-4c4f-a852-f3b1ada53722@app.fastmail.com>
 <abATPiRUczb8fe4t@pks.im> <xmqqh5qntpvy.fsf@gitster.g>
 <c076edd0-9057-443b-ba37-33aacde2eede@app.fastmail.com>
Subject: Re: [PATCH v2] merge-file: fix BUG when --object-id is used in a worktree
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Mar 11, 2026, at 07:44, Mathias Rav wrote:
>[snip]
> As for the quotes in the commit references, I use gitk's "Copy commit
> reference" daily and am personally used to the quotes. Since
> SubmittingPatches seems to give equal preference to --pretty=reference and
> "Copy commit reference" I didn't think that the quotes were a problem.

> (I wonder how controversial it would be to remove the quotes in gitk.)

Turns out that this has been attempted least once before:

https://lore.kernel.org/git/1472230741-5161-1-git-send-email-dev+git@drbeat.li/

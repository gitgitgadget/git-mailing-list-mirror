Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A67C2FD
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 00:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722387316; cv=none; b=MX4Hugk6vmR0PON3OpCEqu2ua2zIIfo+KmfFQDTbCq7hFIXcGgUMIpKds3KszZxX3e4GKWyr022/cSWeEuxfXRRM0PX31v+B+8FtwM9DeyB55cx+MEymLXrVrxh+6tqkD20ckc7FShavn7Zc4Apu/T1CW4ubLlCtD8szAFhCAsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722387316; c=relaxed/simple;
	bh=IOFgbuwqXRT3Bjk9NyAvoosQkvYqpdMuMAMOpQJOOUo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=SCMDbJFCmSPKLbzWfmuzA78+2/Wnv+F++/YzlAg44PfvhmTz/7Dd0z8DRD8ACJkNsE3xsFCCtDVXr3EiTjEarHIQDoYkoBPGBavo+Xay+CSINVipMxs+kpjH48aQvZJbqW9C6ykq8Nn6YIEPgmlSjXpy27BVzwujihRgAOVkvQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io; spf=pass smtp.mailfrom=jamesliu.io; dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b=ckxwaeSD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sQBfxB7r; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b="ckxwaeSD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sQBfxB7r"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 8AA821146DCE;
	Tue, 30 Jul 2024 20:55:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 30 Jul 2024 20:55:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jamesliu.io; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1722387313;
	 x=1722473713; bh=IOFgbuwqXRT3Bjk9NyAvoosQkvYqpdMuMAMOpQJOOUo=; b=
	ckxwaeSDfWS8A7BZ1TRXBL7n7oZrbAfhK8NGupAttlZ0fgbajwlrVMdJQEIV/HwN
	NAr0Gd6edZBso/ISDbiKzImHq+Ei1du6euUOaZsV+OlqdZeayf1jc75LkHNJFg9q
	fgji0iL6NYg14eSD9U7sZqBhnKONCBgfmfpcXHfwihKIMG0cF+q8c07fYkTjDIHh
	/Q9AMDMNhng//f9EMwUU6bwTNHSEqpKNPHPbbA6mnR7ZS0xQ32pC1unNWaK7uMDs
	oObkUJQh1YrHxG8HiM3oWTH3EWNIihbng/ckf0zTAx++cVgIRz5urS/AGOGlkI1W
	E728wN3Dx+2+3/+lv3Mygg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722387313; x=
	1722473713; bh=IOFgbuwqXRT3Bjk9NyAvoosQkvYqpdMuMAMOpQJOOUo=; b=s
	QBfxB7rX3r/0Xi24ZqtyK0IlpnYtwCevGtZ6IE0RMVWkzUWAbpuWY5hZW/Bb97oF
	wMuWNfCHuJ6JYmbjSdOIA1ST5qreKU+Ex4vyIsySG8M0zVfePaBCA3BaaazKE2Oi
	SDcC5xLRC1J5hn/L2mfKaz4apEuU4mnhPHo58hIR0IHjVTwtkrNA6rfYCeT3rY+M
	TfGdhrjEQaPHSK+4yKqSXal0q7YwnVqwE6u5JzVFriuZKvmXZhDH9P6/NqM3IK7h
	4FP9lXIPsTdjJaolk1PMEoFrovlZGz7LWJ3qufahwCPdU/d13ohOHBMjJ2+34h9L
	7ZYB2iEdetORZru/wA23w==
X-ME-Sender: <xms:cYupZkcnQwv4lsFRCiQABnZ1PoKLirCRxWsAkciaHeKhLgEnEwmKSw>
    <xme:cYupZmOfSzBu45yxx7XWxolH4cDXvrJcLsA6GrEofVo5olq7w6iipybWXUnz54cjD
    l1IBg721Rs_b4K8_g>
X-ME-Received: <xmr:cYupZlgnCkJJDSUmf5PbzedmQh4XlYs1CUM73sfROTddii7AbL8JU3C_ZjZF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeehgdegudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpegggfgtfffkuffhvffofhgjsehtqhertdertdejnecuhfhrohhmpedflfgrmhgv
    shcunfhiuhdfuceojhgrmhgvshesjhgrmhgvshhlihhurdhioheqnecuggftrfgrthhtvg
    hrnhephfetueehudeltedtjeekudelueeihfevheeugfehhedvieektedtvdevgeeileet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhgrmh
    gvshesjhgrmhgvshhlihhurdhiohdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:cYupZp88rxeCzM7dvnLWbar9xGKO5Tcr7ViAHykLYsQVZ5vCoHKo-A>
    <xmx:cYupZgtu64aVXMQwotc2uq-MnkczvyyaaBL5vy7kuFmqa4mtYKTBWA>
    <xmx:cYupZgFZJnRK8An9OzjNtLk4H1z91Wc4m1jaKp8b2AuOxsUvu0kuPQ>
    <xmx:cYupZvNc1EWpiy_5styUpm2wy48oqT92vAxanE4sC8gt0KcOmtLZsw>
    <xmx:cYupZp4RFBe6OPverP1nJGSTrZPCar0ZIlngm8eQnfKkeFag7pVk4dvQ>
Feedback-ID: i93f149ec:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jul 2024 20:55:12 -0400 (EDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 31 Jul 2024 10:55:09 +1000
Message-Id: <D33BCEL5LQQ0.33TQBJ9KVBMBX@jamesliu.io>
Subject: Re: [PATCH 0/5] refs: stop using `the_repository`
From: "James Liu" <james@jamesliu.io>
To: "Patrick Steinhardt" <ps@pks.im>, <git@vger.kernel.org>
X-Mailer: aerc 0.18.0
References: <cover.1722316795.git.ps@pks.im>
In-Reply-To: <cover.1722316795.git.ps@pks.im>

On Tue Jul 30, 2024 at 3:22 PM AEST, Patrick Steinhardt wrote:
> Hi,
>
> this patch series removes use of `the_repository` in the refs subsystem
> and drops the `USE_THE_REPOSITORY_VARIABLE` macro define from those
> files.
>
> Patrick

Thanks Patrick, these improvements make sense to me.

Is there a priority order on removing `the_repository` from other parts
of the codebase?

Cheers,
James


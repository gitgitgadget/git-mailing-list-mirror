Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E838F253F39
	for <git@vger.kernel.org>; Thu, 11 Dec 2025 05:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765430740; cv=none; b=u+uHnlsBJ0UBJTsuxXU8zRBN3/8EcxbpjW1i7IPI0OBU+vhvGPgYgsI8cD4A5QLhB0Y6CeZbllC3j+g2Cb67WXH1CJP5f6B3KSMtzefZ8Gpcr0NAJqcX/AiBwPe06Hq5CLdso7Dm9C1B5xeGWIGvCFRTRo7E5wShux8l/ZdOkaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765430740; c=relaxed/simple;
	bh=SDc0Q9y+84GVqpTsunv51SUnIOefRoBRtajdMjewCI0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EmD6sUtwQ9h6mfsK8TTrO2knj+dR5CsxoYcSKOljIcu0zvJlR532IUg9gVzYyHGZj30GYn5TEwqZqs9rq4aun1jXa6ahNG3PkyBJ/3jwkEBHxLplYPXn7vNqu996N5QSlGN8A/FhzD1Pp4SR32+y9VSy/dEmB3/R/gRR4/PdVrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Qqe2Ad65; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tRBU6e+v; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Qqe2Ad65";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tRBU6e+v"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0E1C67A00BA;
	Thu, 11 Dec 2025 00:25:37 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Thu, 11 Dec 2025 00:25:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1765430736;
	 x=1765517136; bh=4rOdvA/BuNSgwfavtMPpNYeIi3fzZzeMk2iQzDXfiho=; b=
	Qqe2Ad65Wi/3gOA3+P9m3YwP0KIjpLLs/IpH7vuPb4rOw6AYp4RfgfJJJbQRb5Kn
	XXDayJdmV4t89NglSBRpzGmAZdRHKetY9e6yMr9DcQ/27PeRYEN3hnnajzKgvkQA
	D+g9Rv5yitjDskSIzaMTUvHsFwG+6bdcLlS5Km/Q7NV4VeMbhN6A8WUtl/mvnA55
	QOZMAu5Umsi5l3zKFreviIInMTHDJ2tkI0NH9DQioBOQiyM5r2cDvm8yX1GjudqV
	yCW5FyxRHhR42Fh54dEwhzRKUGEHkThLh+nuxD7YkxprcDlSkscEfQeVx4UgFU0L
	BpHBoZbf2myAq8Vg+6c9xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765430736; x=
	1765517136; bh=4rOdvA/BuNSgwfavtMPpNYeIi3fzZzeMk2iQzDXfiho=; b=t
	RBU6e+v8mZuuzZBQEAJc7pnAsXiPGvIeZqo1DdCuhp8LTDnxyq0xtAYdeiYa5X94
	TnsdFg9n7PFqGH/tzRP9ciWj1rSIid6THtuuX5qE0ZyZxiXEXOKV9+OuUKoFQIt6
	f9O+7Tyx9hEr9GPOQ9dHeMLygo3GLVcFzCU61EbGQ/KoqePfB26LrDtQSO/4ya3h
	iea89Ufr9DFQYDo4a+zT9TdGwOunAXkNBqkPt4VpKzNOjrri/IuCKPNsQfSQFdgf
	3aiWJvcx96Q26WFbzpAHribOM9kVf2ba+6/52cWIQ34qYS6NROLtjEsesTjHmoA8
	pl2pogOQzBFeuv7j84x7A==
X-ME-Sender: <xms:0FU6aUrIvVUfilgMZTR9_f5PL8zWX--uz-mZd2I2aex5OS5PYAYMkQ>
    <xme:0FU6aRqEJzcYKR9r7h-LXalR-Mevf9tCZ1epWqISPV3-Cp5c4JEYSWjMbxV9ZNaxp
    _fF6xuuq9NY8qnrd4ib501fGrXuQncCBF1EYURvyDyslxwyGtwiSQ>
X-ME-Received: <xmr:0FU6aeOoZL4z6HbVJ1MBcYo5NX85ndN2xp7pcbW83ODALF_0x3ylOg91ThB2kBPR6V927FaeIUb1cwaILZlG94uH3x0fbSts5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtg
    homhdprhgtphhtthhopehkohhuthhsohhufhhlrghkihhsrdhsthgvfhgrnhhoshesphhr
    ohhtohhnrdhmvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:0FU6aazo--RECHOWh8_uwUWongtNmg1csz5ToOXTrj9T5VTSZ32QDQ>
    <xmx:0FU6afvOHSasp4UUbcc8da8xN04QRvdKinxy2eqNaoGpIuX5DVQcPA>
    <xmx:0FU6ab7woMr_yc37HFqAiQSq6KpQU-1v3TEkTAk75ZrgzPviijim5A>
    <xmx:0FU6aWRI5Bnba9iJZZn7sP_dis34hmeZ0LLSRNg0vIoOZgPvdt4CCQ>
    <xmx:0FU6aSZkDvaHZc-w7N4oECzc2ojeljfv2_5u0UJ1c_2P7JKoyPV-n5aD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Dec 2025 00:25:36 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Koutsouflakis Stefanos <koutsouflakis.stefanos@proton.me>,
  "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC] reset --hard: warn before discarding staged content with
 no commit history
In-Reply-To: <CAPig+cSep7+i2R-DDK+B6p6c3gy2Ehvm4U5N_PwSR-yZF3n1hA@mail.gmail.com>
	(Eric Sunshine's message of "Wed, 10 Dec 2025 22:59:51 -0500")
References: <a5wKtD6Tn0gzcba1IEUhukYnXPHxMwPq6puQKIPywmjNufi5vc6vX-v5BpPJ7qj_zZsuXF5FiS2gbpsurWmVjoWHtMm8A-kAbaZyjMfrTcs=@proton.me>
	<xmqqldj9g0pj.fsf@gitster.g>
	<CAPig+cSep7+i2R-DDK+B6p6c3gy2Ehvm4U5N_PwSR-yZF3n1hA@mail.gmail.com>
Date: Thu, 11 Dec 2025 14:25:35 +0900
Message-ID: <xmqqcy4lfv3k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Wed, Dec 10, 2025 at 10:24 PM Junio C Hamano <gitster@pobox.com> wrote:
>> Koutsouflakis Stefanos <koutsouflakis.stefanos@proton.me> writes:
>> > When running "git reset --hard" in a repository where staged
>> > content has never been committed, the staged files are lost. This
>> > seems like a case where requiring --force could be helpful.
>>
>> The thinking has always been "'--hard' means what it says!  HARD
>> removes things harder than other modes---there is need to add
>> '--force' to it".
>
> Presumably, you meant "there is *no* need" rather than "there is need".

Thanks.  I rewrote the paragraph a few times and somehow losing the
crucial negation from there..

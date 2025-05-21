Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B12221FBC
	for <git@vger.kernel.org>; Wed, 21 May 2025 15:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747842634; cv=none; b=MWpj2lS8fXrSJ0cKncz4PejXVrd5S5Q53On21MfpzoT9NKwAo0zKzDJtWIYV1azm68RXSVU7Fg/mPEPirgSP44Zin09uImBmkvWVZDLylur/ot2X/LNNDAiJv+qj9Pu9ja55uypVIqzxZzm/VleBry+TOBkr3HrttmGHSZA6EWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747842634; c=relaxed/simple;
	bh=Gt6AhNy3dJMU8YSNe9x3VGOxT7nZtElGR3BnZ8ftcDk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lay0BXky7hWnQaC5eXkb//ft4unbq9WndwrbetkDSdjoB5qDgj2iZOedx2MznmBZ8CXLrvDy1kvph/KFHSQ2kNNqTY3pDVsKdH1YNsZfvxY0WVgq+RsFgEEKwKkh7CBr7DLkXpxS103LJPBnXc6otT7V+/GO2gtFKl8jVlwc/WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=laYNdNow; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EI9fxUlu; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="laYNdNow";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EI9fxUlu"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D01B62540155;
	Wed, 21 May 2025 11:50:29 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 21 May 2025 11:50:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1747842629;
	 x=1747929029; bh=Gt6AhNy3dJMU8YSNe9x3VGOxT7nZtElGR3BnZ8ftcDk=; b=
	laYNdNowRcv0jEhd6qlG1lmYVf+EkvjOxzuRlTfP+m03mizbZ1b9op4kzlaE+z6Q
	mwPwDJOqOPmar3PHk7x/fwXY22ALp7KRKENklJx9u9+5sUdAZ+0oN07NUZJxpFJl
	4jvX0bCOIrHv0o3vmgz7oYyf6+d4VDazrBLfV2I4mwRBmI0a+uolwT3e/rCj7061
	Ae6smC/dotko/mTRkqnCAOtaXbE91+mpV/24Hggwhg+uvpu8Q9+y4IHLdopzd8FZ
	2a42/kXrmF2ZbY/u+VCt//ZGUSf7ydGD+tLhF9kipljMlNd71vSyIF6M6VSwIJwN
	f2MqtV35vUVh9ReocZ+I/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747842629; x=
	1747929029; bh=Gt6AhNy3dJMU8YSNe9x3VGOxT7nZtElGR3BnZ8ftcDk=; b=E
	I9fxUluXztYwZuVEaATvIyl2nKYeUUM4Q8CepCCecnS6JGdsY7TroM0f9mCe8Lul
	T2BgiKDcFRN1GcW/SU6ibfM1egu/Gw6QDXFczV9AWGsm6gf3dGDz1JZ7IbVE5hCp
	u3hXB9DMOpVA8W2fEI/Lr/4V2LdGDMlhAdEehHL0juyk9II1uCFbmg2tvyAQ/h+t
	uFppGIBtrzB+nVk/2uFfCB9HwDsrd38hk3U+uJGGzvGH44o20W4R5Z3wWlENPsHs
	fsw4JANsEar9tlVeFow4KpBxlaMAazEhoRm50iz3T50ZeFXvK2CyCLj6hJdizew/
	Q7Q4xN9U3rzyHg7glqvGA==
X-ME-Sender: <xms:RfYtaJnCvBgaTSDQFQ00A4kTv5dSw1FJmzUEMo_3YZo2BJ_9ddpw4Q>
    <xme:RfYtaE1tNnpjSFAjC1feBcGM4_sqI5fTOy1Oy6b_bz1-rDE5qPMQ3sgxN7xExh7DR
    URfTYii2sa55iDV9w>
X-ME-Received: <xmr:RfYtaPoPvG-ejSUmVUa9Q4AEXTMklPXxEwcGs2adOhhaRr4NtT6AJ6gpZhAyavALdJO0XGsLTpNYFt7FiwpZEHgoo_A3omUINbwUAoU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefgeekucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffffk
    fgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteeg
    vddtkeetfeevueevlefgkeefheeigfehveehvdekheelveevfedtheenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopegsvghn
    rdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrh
    hhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
    dprhgtphhtthhopeguhihrohhnvghtvghnghesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:RfYtaJnVyFReMM0-potHoC4MlwUapo8ITfw-p-AXBw2fYVNWxgmJHQ>
    <xmx:RfYtaH0sulxAuhvJOzWf-a_-L0pAS2yNPNVrA2iYnFaRjfqJJnKV0w>
    <xmx:RfYtaIvbX6mIQSvi4seXnrvUWL6-8IyTVAIVKLkuuR9Iul0e_YiIXQ>
    <xmx:RfYtaLXt0J1D3tyIHyhac3dvO-yy0dm8qeg9e9XDpuH4lxHFZyLM9g>
    <xmx:RfYtaLh12gc4ZFvSRn2ss1V6v8qodl1CnMfGsee1NsaS8AGZbeKfMRn1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 May 2025 11:50:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,  "Kristoffer Haugsbakk"
 <kristofferhaugsbakk@fastmail.com>,  git@vger.kernel.org,  "Jeff King"
 <peff@peff.net>,  "Teng Long" <dyroneteng@gmail.com>
Subject: Re: [PATCH 6/6] doc: notes: treat --stdin equally between copy/remove
In-Reply-To: <a9768fbd-7b94-4eb5-9906-0445c93be1d9@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Wed, 21 May 2025 16:44:03 +0200")
References: <cover.1747763769.git.code@khaugsbakk.name>
	<68e5eb78040419ba64e256910501c7e37194b222.1747763769.git.code@khaugsbakk.name>
	<CALnO6CAMgA1H3_Q+H6WRchMo4L2j_Qu8fdT4JVnfXyHwu97enQ@mail.gmail.com>
	<a9768fbd-7b94-4eb5-9906-0445c93be1d9@app.fastmail.com>
Date: Wed, 21 May 2025 08:50:27 -0700
Message-ID: <xmqqsekyarp8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:

> On Wed, May 21, 2025, at 15:19, D. Ben Knoble wrote:
>> On Tue, May 20, 2025 at 1:58 PM <kristofferhaugsbakk@fastmail.com> wrote:
>>> • remove: mention `--stdin` on the subcommand as well, like for `copy`
>>> • copy: mention it as well under the option documentation
>>
>> Ooh, bullet characters. I haven't seen anything quite like that in a
>> commit message in my short time watching the list. Neat!
>
> They get through the reviews somehow. ;)

The "downside" may be that they may inconvenience folks still living
in ASCII-only world, but I suspect it is rather hard to find
ASCII-only terminals that render not-so-uncommon Unicode characters
as garbage, so perhaps there is no longer any such downside?

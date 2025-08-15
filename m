Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93F28821
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 01:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755220821; cv=none; b=dsSdJ2uKmyESGZ7ceNvksiKx+wq0ZM+VLKYTwhT5Atl9P2J+FFwavTkioFTFi+trFFr0Txqg3TqLfjT9HyGSUp2hh1knPrSMQcK2fHCbcTzXwmoIWGaEobJoRyMPBjyKB9X07jhqkUZcvi4hORu3Cmo3SoY+BG7IU1CA1SDyMVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755220821; c=relaxed/simple;
	bh=nOx8yIMhlKDG0jYbtCutuexQAzIe1QRaRZmtjaXPAbQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pWNMcT3Fn1DSlvpTTKTGlHcvUH8wIb/4c69WaluWgakfq6jg/+fcjYKxNm0tMMv0JJDWCfjbT8Gdy/pm0g1muD6TTsRaBo32lKZZNcL/xfr+G4vnX4QlE3QfAo1uITqiAqLj6X4HSoUDmJkaem7KAeNLuM1kptjM/gQ9WjgxAmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gnfqwaDU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SykHnFW6; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gnfqwaDU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SykHnFW6"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id C1D60EC01F9;
	Thu, 14 Aug 2025 21:20:18 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 14 Aug 2025 21:20:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755220818; x=1755307218; bh=XgpYRO9CiT
	DUazduWOpbO444JhybO2oebwnt2ZEtD8w=; b=gnfqwaDUJFtmY6F3UXyoIxlX9K
	bVVQEkLc3uWbKaOsn+SyHSH1jyr0EFvD/MXhgNnhu2gPOJVEUSzPZIHjOe0NzhSR
	L9Wy82X+m6CMMlKo7enfSlMHZaT8cepAhnvl9CpiryQ+zQghafC9OVbdjfNZU2ys
	G3N6cokUdCs4DbXwv0DSi+ia0RYbk+hlZHjf2Erx5SIwUQ9g9mzbly69FYgLEe4p
	XBIEQTTHPzfes1a5+G3GCFXzcqeTcpUgp0JZgjbjGxDlbK4l/2XmrBeBrSookLTz
	xXEFoqaeSOIXn3xDH3AviuhdLX2E9CfdaghmatnDFRiUUCgn3x4B3yOkEd+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755220818; x=1755307218; bh=XgpYRO9CiTDUazduWOpbO444JhybO2oebwn
	t2ZEtD8w=; b=SykHnFW6j5Auo3W1AH8hunyesR8/uqbSmlgYbdyRVxuIdY1wuqd
	6pOdsGck0D0Tz/pX+Bh3SUjqhTMc0sRBThLmbVbvC2nsPT0sFBH+UfY6iTrCkudE
	zOxvHMoXxfBJm/S+Expk+NLO3wX94od8UAyfSjgr1kneLRhgGNS2afFj2HZ8F3aB
	1uFSIOnICC0xLrdFqxVrBFxYXvFljboWgeukn4iHdJc64HLBp+NwqJmbdjXsFLaU
	Util5dPCuJE1vB8d18mGE5B2PhCLY8AN08K2LS49UnvNeBWOW4vCtKPAi8N/dA9A
	4pRJNVxbr39JNuBmzgpY6+X4A/WTp6WjRBQ==
X-ME-Sender: <xms:UoueaGjMftLZbk6Sf0ABYNwkbA_xV2Wk0zm6PoN3thJ7dM7aCWjNIg>
    <xme:UoueaPq70CIg5PqCWkJraskXqgy4PwJclO8q1nnQwIqiBqlKVwhzx-cMB48QMJN2t
    KPhMSxh6XZbp5iSew>
X-ME-Received: <xmr:UoueaFh4H2nc-b2zuweUqxOCWT4NihMmuHjHFjfD8YJZR17ux06tBQEu03J6IACsKbQnvBdnb-zG2nKUQNDosczefqcQgs_unSPwCe4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugedvieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghord
    gtohhmpdhrtghpthhtoheplhhutggrshhsvghikhhiohhshhhirhhosehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehoshifrghlugdrsghuugguvghnhhgrghgvnhesghhmgidruggvpdhrtghpthhtohep
    phhssehpkhhsrdhimhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpth
    htohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:UoueaJNocBn_oUDyqI4hXLh_NmpjcxnZPnrKrbNcHq36uLyP0pfEWg>
    <xmx:UoueaHwDhnH0gTgG6veROyGIze5RtQOSrVzhgC_ZCvzDyR-FVViDJw>
    <xmx:UoueaDod0kMoL2OkhWrsUYd67s5CPGa5p00b7oCo84uOA3TPEySHoQ>
    <xmx:UoueaPPK3hYFhGibO4p60pyyG1Ie05s7xNrm1k_mXISMENU9d25H0g>
    <xmx:UoueaPiMHL7oQHSVtAcI8R88wyvFW-Buyw6sLaWFUqDEsgeuCyTMmXTq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Aug 2025 21:20:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,  git@vger.kernel.org,
  oswald.buddenhagen@gmx.de,  ps@pks.im,  karthik.188@gmail.com,
  ben.knoble@gmail.com,  phillip.wood@dunelm.org.uk,  jltobler@gmail.com,
  jn.avila@free.fr
Subject: Re: [GSoC PATCH v9 3/5] repo: add the field layout.bare
In-Reply-To: <CAPig+cSZnfG7NDCGDDnFvtwS4hpcGkmVKA0hPhLALmXj=0Zbbw@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 14 Aug 2025 18:05:36 -0400")
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
	<20250807150239.6987-1-lucasseikioshiro@gmail.com>
	<20250807150239.6987-4-lucasseikioshiro@gmail.com>
	<CAPig+cSBg6oQC4Y81ieH25-A9cHRTfbqC5i+22RSBcbyVo_qtA@mail.gmail.com>
	<BCCE25CF-8546-4320-AB44-9B729C3D6DE6@gmail.com>
	<CAPig+cTQdEDZduG_UmdHn1JNfj7iTw0=jwdkX+VPJ11Jo0jUGA@mail.gmail.com>
	<xmqqfrdt3feh.fsf@gitster.g>
	<CAPig+cSZnfG7NDCGDDnFvtwS4hpcGkmVKA0hPhLALmXj=0Zbbw@mail.gmail.com>
Date: Thu, 14 Aug 2025 18:20:16 -0700
Message-ID: <xmqqectdv0rz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Sunshine <sunshine@sunshineco.com> writes:

>> I also care about future-proofing, though.  When Git is built with
>> WITH_BREAKING_CHANGES=YesPlease, this test would break as the
>> default reference backend will be reftable in that alternate world,
>> wouldn't it?
>
> I think Lucas already future-proofed this (and my example copied his
> future-proofing) by using `--ref-format=files` with the git-init
> invocation.

Ah, OK, if we are forcing a specific format, then we are already
future-proofed, especially when the format is something that will be
with us forever, like the files backend.

Thanks.

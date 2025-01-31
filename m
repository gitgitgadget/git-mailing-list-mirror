Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F74515F41F
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 20:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738354629; cv=none; b=DWaKw5Tx3+9unitblp3uvTe61UBGIvxB/zMl1hLU0YSPuaiu/OxVH0NJD/iEVdSvvO6zdlPuvkAaqs2McODlCDgxjEkwZ9kdqX4gUMmsc2yKQwL/0KQRB4eRgECARu3Jcko53qW9TVur0k2FWuFKEREZIjGeovBOpm9SwjUUpSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738354629; c=relaxed/simple;
	bh=mhBC6QdsOdDum2+cNVfmw64fDp8ThgsAgIj7j39bFpE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rSQhp4+6XHt3c23Tt1DYq3wWdK5DpZ1S5XzYaxY2b1EPHPAMvgbj9Cqv619yAuS07jl8XvJkMehz1aoccCJu3I5AEhRQKoanlCYwlLAAYJNDLDKWdcHij2Q9GoxeJJsgU+vDg27hlbCSnFQ133qq2VxMSU8lcjOjSjBI7FEPpzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PrL43aHj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i0mJEK0I; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PrL43aHj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i0mJEK0I"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D606F254017E;
	Fri, 31 Jan 2025 15:17:06 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Fri, 31 Jan 2025 15:17:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738354626; x=1738441026; bh=RXqqgqNi9U
	VkBzeaXggYfghOq9glGTu4ljvjUCPBoHY=; b=PrL43aHjkw36X5Be8zraUfomgd
	gVPbGyBrR9stv2qYB4+pO61ja2hNlnYALwMazu6qlrL31RlhHxfXYH6Sj4Jzfgl0
	E26/EJcNKtdClj0heXUcaDSR2MITD0XKKfXoVvT2vCECqdrPnQVGZq/h6nmxJvyT
	BdeZlbqrYTY0liBd1CKwUQVg0n7KUk8b6UzcjdKh2KRAVID7G8CUdeTFIcBWQpHo
	kyUP5+gEZ6si76ijUMkD3Jr5m0d7/hMV37iTlD0yN08cm5Lg3rRxRtc6NSwM05Rg
	lbvWrQp7k4e1cAY69oBgXHHXSqn501uRnFC1SVA/YPFZGlsYDLLZePu2V/kw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738354626; x=1738441026; bh=RXqqgqNi9UVkBzeaXggYfghOq9glGTu4ljv
	jUCPBoHY=; b=i0mJEK0I42FPPnldjxCWO+eVR6db1rk0b523hcY83KW4htahl1+
	yMeMlw1jt0Mb6vjWZffvdESmwnJfR6gHJoWhMXgvDfzLrxyChnn6GpWoSR7ZVN8I
	gCG2M8t/1XUI2T9GHjgtUkiDoCIEeD9zGj14afiiZ34mcBmu6mlBipDoFH1j2/Ui
	2oyLAjkKQExjUjLr8KCZ9tdn3qpBsEPrmJSnY5YD3x8GpRy/gYP8EipJY564kKu5
	SH+eFDw/KFx1luGXJnWsFfI9LOJatJpFaALTDLNajZHyRrjImwmXdP8/H/8UHx45
	DIqkV5DWvw8mjnAL0rLWSq6sX13hNdOg66A==
X-ME-Sender: <xms:wi-dZ-Au_gF-MEIcX4h5c353iWZjXKpSpWKK9HhIHjkhudGehp0xpg>
    <xme:wi-dZ4hRzfUvkRVyBKVx92Ymkhljm_FD1eTDkbobfLXpbnaDD1kKiNE8OZ6OgSjux
    Ewt2RFNUP0_LU3LxQ>
X-ME-Received: <xmr:wi-dZxk_bDANaoL6nBSP29vr5nGhmFmM8JG9ei_bhjdPVUnkJHAA4y-CW7FPJ6hRLMQXEJO_YrojlpmPsFpRnb3M14UqSzKUusgW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeljedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehushhmrghnrghkih
    hnhigvmhhivddtvdesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhsthhirghn
    rdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehj
    ohhhnhgtrghikeeisehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrd
    hstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepmhgvsehtthgrhihlohhr
    rhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorh
    hgrdhukhdprhgtphhtthhopehrshgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtghomh
X-ME-Proxy: <xmx:wi-dZ8y_tvyU5OHZ14R5qlJrYyIvT-ZvG7995hbbbOPipZDR79a75Q>
    <xmx:wi-dZzS2dL4B_RpZEK_UarCxnPLMKoiPAwWIXu_OS0lFaoq_mYA-bQ>
    <xmx:wi-dZ3boOoTgq3_C0Cmffvu-DckCTAvXt_AuJFosok4a8YKnKfBcUw>
    <xmx:wi-dZ8SPVE2tvpofGpwEyQP7QUZ6-2DzEQypymiCHiVW3dQmHigh2Q>
    <xmx:wi-dZ7YE1NzJ31My9S3JVTiVwePrYtwkct_bB-0SfPaErDi2Rj-OXfYi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jan 2025 15:17:05 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: Christian Couder <christian.couder@gmail.com>,  git@vger.kernel.org,
  ps@pks.im,  johncai86@gmail.com,  Johannes.Schindelin@gmx.de,
  me@ttaylorr.com,  phillip.wood@dunelm.org.uk,  rsbecker@nexbridge.com,
  sunshine@sunshineco.com
Subject: Re: [PATCH v3 0/6][Outreachy] Introduce os-version Capability with
 Configurable Options
In-Reply-To: <CAPSxiM_eob5ygBoND9QR-bS073X-Jzqfg27Ec0LOFmjEesYDhQ@mail.gmail.com>
	(Usman Akinyemi's message of "Sat, 1 Feb 2025 01:16:04 +0530")
References: <20250117104639.65608-1-usmanakinyemi202@gmail.com>
	<20250124122217.250925-1-usmanakinyemi202@gmail.com>
	<xmqqed0sxdiz.fsf@gitster.g>
	<CAP8UFD31A9KuqzXrDWzjokWzBtTYsF1FGJPX8PFAWXnn_2BH_w@mail.gmail.com>
	<xmqq5xm0wa5l.fsf@gitster.g>
	<CAP8UFD1+Qa2cRkYs8R_Lgr8Bkz7YqPUW6Q3ogKcrBSp+q-3qbw@mail.gmail.com>
	<xmqqzfj77xd7.fsf@gitster.g>
	<CAPSxiM_eob5ygBoND9QR-bS073X-Jzqfg27Ec0LOFmjEesYDhQ@mail.gmail.com>
Date: Fri, 31 Jan 2025 12:17:04 -0800
Message-ID: <xmqqcyg27n7j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Usman Akinyemi <usmanakinyemi202@gmail.com> writes:

>> You may find "ImNotTellingYou" and may wonder what OS the user is
>> really using, but they do not want to tell you, so you honor their
>> wish.
> While the current implementation allows user to specify this form of string
>  i.e "ImNotTellingYou", for agent value, it is not mentioned in the docs,
> I will add in the next iteration.

OK.  You may want to wait before hearing other's opinions, though,
for at least the time it takes for the earth to rotate once.

Thanks.

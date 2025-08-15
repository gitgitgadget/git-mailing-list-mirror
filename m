Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B3E27AC4D
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 23:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755301067; cv=none; b=ieXCsJCtZiCJ6R3bkbXZ9QiJ5tzGRHLRG9z/FCLGByx9+eJMwDFlwzbT+nh6e3BV84PGM4DwdB/Z6jdprJ4PECuRfuTPED17AARU0Buqg0/Gvcib8CHiQz0rCK6tmUwxVKEhuPc/mYrTspuy/aJXuq4YGIa0asHiNlNrTDfEu1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755301067; c=relaxed/simple;
	bh=OyOslkpM4MOcTm08dmH/6opMd16hKmkZ1//wcpfPUOM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QROBvVWETZaGxOxaO84EKtJkm7jjNLY3DTCZa0ZPWH0KxYQZ43EIcrCYzXK7EkWK6HVuQUgdH+X7WnM8PFsXnvLh3YTUsToBCtu8CvKKrb03/f2yxSOMNvZa3IN7CQQzzFiEzpB8LwAqc7RMmBmR/0192hairC7FqeBVoBRjhpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UooNMlmH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CEXaI5HQ; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UooNMlmH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CEXaI5HQ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 67129EC0102;
	Fri, 15 Aug 2025 19:37:44 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 15 Aug 2025 19:37:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755301064; x=1755387464; bh=OyOslkpM4M
	OcTm08dmH/6opMd16hKmkZ1//wcpfPUOM=; b=UooNMlmHlxsef105Ke9c2l3rk0
	GRuOIZjG81+QtqkArOH1kO5TUSMe2ib8m/K1MzQdhNbLtFwfamySevLSfYoc3K8e
	0chvhYfdQ3Wb6fyO9L8F9ZxRBjbhvbJNy6n8IIOjYjCy6RYxBgUaMi50rWZBeiaw
	doZiyDr5SfMYzyQcLjgBr9QHuthv4JB9BKD8SR/x7wD/RXZi5/5quQSZ0/A9ktKc
	PRHRxBUd9mZj6wrU/YQ6KiiQ/wFejUFZ/mJQ1XsHLF2Itkxb8VonGMOi9FqGbXgW
	/uA5+q+D0IYKDryXYPe0j8fUpSzZ4wurBI0RsM44MXxB74uUORmzxw9Zvzyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755301064; x=1755387464; bh=OyOslkpM4MOcTm08dmH/6opMd16hKmkZ1//
	wcpfPUOM=; b=CEXaI5HQVclMU8PsRgWxahpgEkqogybgL5Msf306Pl/v2Uy92Es
	6/KGeUSYbN5eBhDQnV9hJClG5Cj9QaScv3MFuxwQHDBR9p+Xn4rhgYVSuDXQTeMX
	ec6SZ7Z++Lq5oeqk4D59/sSSEonUpJTYhNJ7e4HZo1s7Ya+24clibNI3SRecy40a
	cpggmPv08Pd0WqWdsmSiCC1m1HzFpp/iONk8wFq3QLJYX4uL7+7RpBuWKL40YadS
	WyQUannQy6wKChIM8qN86fktVqjbIZsriSTAZtyiAZeDyS2gXDjguGmtzS9IJW/M
	DTC3YDY9r6cv5cn7ZS9iNLK4QwfM7YAxVYQ==
X-ME-Sender: <xms:x8SfaB5SG7OcN3jaQjgOh6jmzM4mpIEM0KxVwf_5pNE4H564aWp-CA>
    <xme:x8SfaEYKsNB31Gfjpp_2TKqyqkujpscJDxqHMVsJvxEfE5bztyG8Vo1ugkLEb38M6
    bvu2Z--H60-ZOBtug>
X-ME-Received: <xmr:x8SfaAzb0ZJfUqftNOHUAyJa3xqo8YO6rmr7-KvLbDbmjSdyfVH2-GqOHqEffmQpRPOUKzFSCT_-R16ofUsbhZ5aNI5NCWwkqz4s1sE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeehfedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepudelpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnse
    hgmhigrdguvgdprhgtphhtthhopehmhhgrudelleefsehlihhvvgdruggvpdhrtghpthht
    ohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvgifrhgvnhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrsh
    htvgdrnhgvthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthht
    oheptggssedvheeisghithdrohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhoug
    duvdefsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:x8SfaIPL7QCCnr7CQ4y8WT5FeSPyTVLAk0gbDSDmngDM4r1U1KoTFg>
    <xmx:x8SfaG4P0kRskx_bK8cjRrtNrMg8ctcXDsUHyI2gYsf8Njpbnnm6Ww>
    <xmx:x8SfaGdvW7qp9eFAsf_2mFkBzqyu0zBL65SCXT3sMyOuzSH6m_loZg>
    <xmx:x8SfaHJW3Jj5chyrqOjumzPRRz0f-bCSZMA76o3Za3TGyrIG7dc6CA>
    <xmx:yMSfaNaLVBAtbvyUsm6aaJnEr_Kjxwfa8BKNGHsztrhhvgSdxtKRGaMj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Aug 2025 19:37:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Matthias =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,  Johannes
 Schindelin via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Elijah
 Newren <newren@gmail.com>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  Taylor Blau <me@ttaylorr.com>,  Christian
 Brabandt <cb@256bit.org>,  Phillip Wood <phillip.wood123@gmail.com>,  Eli
 Schwartz <eschwartz@gentoo.org>,  "Haelwenn (lanodan) Monnier"
 <contact@hacktivis.me>,  Patrick Steinhardt <ps@pks.im>,  Sam James
 <sam@gentoo.org>,  Collin Funk <collin.funk1@gmail.com>,  Mike Hommey
 <mh@glandium.org>,  Pierre-Emmanuel Patry
 <pierre-emmanuel.patry@embecosm.com>,  Ben Knoble <ben.knoble@gmail.com>,
  Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH v2 09/17] Do support Windows again after requiring Rust
In-Reply-To: <2ce3f7ee-62d0-9ddc-761e-31dc30109db5@gmx.de> (Johannes
	Schindelin's message of "Sat, 16 Aug 2025 00:11:46 +0200 (CEST)")
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
	<pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
	<96041a10d545e0e431d05b93544771c6bdfc06f1.1755220973.git.gitgitgadget@gmail.com>
	<DB9P250MB0692900F30A3E71E4F01DFFFA534A@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>
	<xmqq349sntms.fsf@gitster.g>
	<2ce3f7ee-62d0-9ddc-761e-31dc30109db5@gmx.de>
Date: Fri, 15 Aug 2025 16:37:42 -0700
Message-ID: <xmqqy0rkkvg9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> But I may be biased, as I do not live in the Microsoft ecosystem.
>
> You do point that out frequently, so I believe that you made the point.
>
> Personally, I would like to see a more open-minded approach here.

I gave it as an explanation for the reason why my conclusion may be
different from what those in the Microsoft ecosystem decided to keep
supporting, and I have no reason to object what they want to do.

It has nothing to do with open-mindedness and such a comment was
uncalled for.

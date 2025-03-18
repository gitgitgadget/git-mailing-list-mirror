Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C761E1E0C
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 23:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742342034; cv=none; b=jmw/6L+u8rxcS4ijmUoB5pnLTtAYfI5iZgqZ+H4y7bAZ1gXQ4AtUobk3xkNRrda37GXAOJfQcVMAi6/id8lbX6wUVCj+RTsEhmMbUz0Z71dJDEIL9EH20/kUo1qeuwH5kDnP6Vq0YdLv4jBSNWt9TQvs+aY9bck+BmWDJGw9h78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742342034; c=relaxed/simple;
	bh=lzdoojog7UbqZQghHgvVvVhUUz8NRnbCOI3AplFLVEc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oLXMEDaehhHrIVOAFr4b77qsKcGr+mpBh1m90B7TkzVcG2HQCHE6LJIqP4ZSvsHWqP6ba9wCxKzE5f3SEuBX6hcIM823lgMpok13vEh8ZgODi32vBdbuENequb6tk1C4S15euokfHrDcs+U5u+ol2GCw1fkZTfM9rlwsyvLk3qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=tgQ64Fvp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L+Y44xmm; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="tgQ64Fvp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L+Y44xmm"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 20B6A114021F;
	Tue, 18 Mar 2025 19:53:51 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Tue, 18 Mar 2025 19:53:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1742342031; x=1742428431; bh=eF2g/4Emg0
	wAFCa8iBMahgSESFWhsvfVTUG/N+Pcv7Q=; b=tgQ64FvpuuTd0JIpjJpdY8xcH/
	faFhW/X9YbAFUFnUx4valq83P6qVSZpDhXc2BPmVdfcCJO4opZUIHXQvtSmMfy99
	Vc+hdXzd26LYpy154yTRXp5cvzIxcr6bvpOLILj6nOkzdVWjxRDJP7DvPsO8DXqy
	cEx8qosZTrmEYY3RypMxLfB/kwWH0rGPo8+OS0mT+CKPcgIz8/UfOOBj31yyV1Cp
	8h//GDmiwqfexlpcISNpL3oma/Ie4uHNygi5h0EAcHnk+yXZbONcR+eUF6zWnhdz
	3nHGj4PGNBqxm3HiGOLqriZ/K7rBFWUf7u/LCco5hsuMhC1yUhHCi0wwj6AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742342031; x=1742428431; bh=eF2g/4Emg0wAFCa8iBMahgSESFWhsvfVTUG
	/N+Pcv7Q=; b=L+Y44xmmf2a9Io7JPDRFmmiKeVMvc9WYX3E2+7AiNxFGw4aFchE
	Z7LgTTqrI9QlzzOsE/YvuXCkncUBP67StGIdvAjzGMrLkfZS11QJ8KVnI4NRsSoa
	o7fs78mBVkWghprv65SC7i6Uy2Pei1O3aKVQHci14lb6Xk+xFFBlovC9ciI8w6mh
	4dM4qtJOFVlI27lK23jb8fCzLlMg926LY8IwQff2qMa4MreOJIFR725aYXuxcofL
	+v9HHggm9LiftfXEaolpeHX8oSitS/RifQ0GtW1yI0cEWcYQhtCDgqp1SOqntinF
	kCSaAyU0c7i9uoLuSGtXd+W9teNXaBQENNQ==
X-ME-Sender: <xms:jgfaZ_bE1H99hVv-5m1qSwZwJ1lZrqmDqmoNSYyhTum2SCOTYZyIcA>
    <xme:jgfaZ-b8SsVzQCYC6Wg1XAg1J9ukoMX13vcJm3PP5IxR4FA-BzsL7rC9ectvYOo4l
    zW63194Vj6SL1ofeQ>
X-ME-Received: <xmr:jgfaZx-qjO9Y0l-n42y9TLQpTaL2-9vjblnE9u-Y_Urf0oJpLMDT0n-U6udnlSqOJ--YA7cJm4BYMBcvvz9kTUHXFbGA8l2_c_J3m9M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeefkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    jeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeeugeegkeehhfdugfelveehtdeuveet
    kedvfeehudehfeduuddvfeejtdelfeegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmh
    htphhouhhtpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtgho
    mhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehp
    khhsrdhimhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopegt
    hhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehshh
    ihrghmthhhrghkkhgrrhdttddusehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrmhhp
    rhhihihoghhuihhnsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:jgfaZ1q1M1uOffpfrxcUXq33Bqh8vaL4tPhTr2WJBHeTSUtvQ24TNQ>
    <xmx:jgfaZ6rXLsHURer3eoa8LrCkofICpYAZBSOnfm3hAh4KA6s-5Qjgvg>
    <xmx:jgfaZ7QrUxQ36FKqfegBxt3Jbvttid7-yTW_VBPpkJB3LxgVjbHp1w>
    <xmx:jgfaZyrlOjXHLYKm42gV4a3AypIip-MSdPSsSO9-VO7rOrfBwprrKg>
    <xmx:jwfaZ3ioAnQdJGauY0btPEmxQWdSOBGBvtNINgcttT4jRMhHqDJoFoMH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Mar 2025 19:53:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Sampriyo Guin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  "Patrick Steinhardt [ ]" <ps@pks.im>,  "Karthik
 Nayak [ ]" <karthik.188@gmail.com>,  "Jialuo She [ ]"
 <shejialuo@gmail.com>,  "Christian Couder [ ]"
 <christian.couder@gmail.com>,  "Ghanshyam Thakkar [ ]"
 <shyamthakkar001@gmail.com>,  Sampriyo Guin <sampriyoguin@gmail.com>
Subject: Re: [PATCH] [GSoC Patch] Modernize Test Path Checking in
 =?utf-8?Q?Git=E2=80=99s?= Test
 Suite
In-Reply-To: <CAPig+cSXiKOBq_+9+uDTFOLf5F8+KPocwXVX2VzPQAxJHQL99w@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 18 Mar 2025 17:49:24 -0400")
References: <pull.1923.git.git.1742329571265.gitgitgadget@gmail.com>
	<xmqq5xk611o3.fsf@gitster.g>
	<CAPig+cSXiKOBq_+9+uDTFOLf5F8+KPocwXVX2VzPQAxJHQL99w@mail.gmail.com>
Date: Tue, 18 Mar 2025 16:53:49 -0700
Message-ID: <xmqqldt1zyia.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Sunshine <sunshine@sunshineco.com> writes:

> Referring to the other thread at [*], perhaps this (avoiding `!` in
> front of test_path_*) is yet another clarification which ought to be
> added to the microproject description in order to lead candidates in a
> more profitable direction.
>
> [*]: https://lore.kernel.org/git/CAPig+cRm+sc+Rk-4SuQ5CrPeZLG2Nzz9B7+6OZxCq7tV5mzmBA@mail.gmail.com/

While mentors do that, I'd prefer to see others extend support for 

	test_path_is_file ! this-should-not-be-file

so that the students have a better tool to work with.

> One other recommendation I would make is to restrict the microproject
> submission to just a single test script (rather than updating twelve
> of them) in order to avoid exhausting the pool for other potential
> candidates.

Yes, you made that point in the other thread, and I agree with it
100%.

Thanks.

Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CD019DF8D
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 05:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728538007; cv=none; b=ZfPIeOcfjp7VYpn+PQes8LlMncBI4Ly64xHP2kJsxmpVE3OXTAgGDvNLH6kB7IA8zynnr1xLa59wzcKX0FMJHv9A/DLkHIwghd4OlrOqGt66phNpyzaPtaa4K0tzbLqQJZ9C9GhyA7dBVni8rnUHz2+N99S5uekDD0uc0iD15ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728538007; c=relaxed/simple;
	bh=dX8q3MEGocJusLqDm7OF4klbWEgM4KSODVPT4HaoFrg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HbkfWEsWkvC8TIIz5A7hNJk9l1ennMuuW/T90Nt+VI16kcZs8/7XtcicfcZNh2HWG3in+2MIN9s0oliDsH0pI6jT6rrxQBrq4SbMUTQcxYqYXMB1rsrAHBkESiYld7yiQoTASsLORjmjdwo/4dTfA6FDop8Jc7PCakc580dpNn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=C1gCmKt7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hxgl4AZF; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="C1gCmKt7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hxgl4AZF"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id CB803138069B;
	Thu, 10 Oct 2024 01:26:43 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Thu, 10 Oct 2024 01:26:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728538003; x=1728624403; bh=Cw5lYAP/QL
	1FwKX/nfRJtxN06G6tjKlj/ZatNdwMFQk=; b=C1gCmKt724cVxxzWch4tvggtpM
	L7N5o62dTD7njwd9Cig38o33Ybrt5jFKLC+TSsGceNUf2l06+pUxTh3o3FT7LwAI
	xmVyzkNqpC3LhZ+2J6G8VOkJykxDZIZgLr98qi+i5rtMikSNWRPepu/OD0cuNNVm
	Nfn5NI2VTUm5dNpd+IEtmq04pEN2oOyp5EFaPyfKbcwRtAKrnQdqh/Lt/C4SbqBR
	NDDy/qnwl9WCwFv6kIBcdsFqU2TJ7RucdgThsPfX3QCiy7y7wNr3CCu9bHknMpLG
	iu7I6pJ9/VTWZ7m4wngaZSLbzAPUdQhgMtuD9m4T6JC9pzYwEsOKIkIADirQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728538003; x=1728624403; bh=Cw5lYAP/QL1FwKX/nfRJtxN06G6t
	jKlj/ZatNdwMFQk=; b=Hxgl4AZFx5qkTe5HxzStQTCypHenbFNLEQfVWs+RbsBh
	JzPLBprHpIeIQvpYDheOxDJ8Qh3HK1cKcidhk7FjTQGKLUoaZDBFIoGjy1AvNaKq
	0N6xT7pQpQ+z7ClWI7ckKUo9EIKL8Aa/VznIOUuGac7YQDumrN4VcCglhscBYVkS
	TGSqymvl6yXjHKtkL+iTjrTxO1CHsSecCk4gOVQbYLN3pBCZ78O5s0+u318O/pKL
	ylSUHbhqiMTDorO5vbr+iQCNZoJTGwl08P1jKEH9VVv7xhd9NHm2gw7+ChuuDGy6
	f79mOLzXz5kda8GNpRgAHMpTrumilwm1yKaFgE1Khw==
X-ME-Sender: <xms:k2UHZ_fJXlwNQnoIRT0-jy_d7TI7drLg9SzstvjLRHyGgtA-8YdMuw>
    <xme:k2UHZ1MEeifA-ffkFNVRtS99_brlWK7dcQEIoycIf30YPlY92N6F5RLLjXqg0rvvX
    SkbIjhTT5M8ggSPPQ>
X-ME-Received: <xmr:k2UHZ4jBulwUm84kZwyX6v2-BqinQz-nvYbIQWj9uO48n20eM2uEVp5RiX79sg19zOQBUPgc-Zf922OFM02saSSN-Pz6kO5RAtOb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefgedgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeei
    vddugeffgfffffevvedvieelffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    vghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepshhunhhshhhinh
    gvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohho
    ugduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:k2UHZw8DqOMb02AVhhuQdvQw4GScMU2AJCdS5RWdL776p035I2ulAg>
    <xmx:k2UHZ7uLYPF7x6KfrShP8q378SeAlT_UpfvDPnFwzHUN7cKx8K6Dzg>
    <xmx:k2UHZ_Ec8P7j3Wt2n2PYc0lIjdsjqs69X5WdWtmaQk5ihbHs_7USlg>
    <xmx:k2UHZyNqBmUt6v5pX3kKcyemlXnZWpGqxOlo53rpJT9TP5SogkJzBQ>
    <xmx:k2UHZ_ia_gC_I-l0tcSXpZZFYsKyZ1CuOAPxZ-FpojeeF0PL7VHwPloV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Oct 2024 01:26:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Eli Schwartz <eschwartz@gentoo.org>,  Eric
 Sunshine <sunshine@sunshineco.com>,  Phillip Wood
 <phillip.wood123@gmail.com>
Subject: Re: [RFC PATCH v2 00/24] Modernize our build system
In-Reply-To: <cover.1728485139.git.ps@pks.im> (Patrick Steinhardt's message of
	"Wed, 9 Oct 2024 16:56:01 +0200")
References: <cover.1727881164.git.ps@pks.im> <cover.1728485139.git.ps@pks.im>
Date: Wed, 09 Oct 2024 22:26:42 -0700
Message-ID: <xmqqzfncmstp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>   - Patches 12 to 22 refactor parts of our build system to make proper
>     out-of-tree builds a reality.

Oooooh.

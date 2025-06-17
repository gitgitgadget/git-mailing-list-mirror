Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB402E8E03
	for <git@vger.kernel.org>; Tue, 17 Jun 2025 16:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750176992; cv=none; b=GSAM8MHDQmJXiLW10pFzBIYqvSjbNYuQIwN4x7g/Y3ekpRMy5P2UKi8+rAuxWep+mx9qsZFFTedGPz8ij8h2twJKjukdyz5BKFjTNZ5rb94fCB70c6mGPtaA/8l8sZ33lWsHiacW41lmfNU+KUkTdH14ol9ovbRv7S+KG3IhtSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750176992; c=relaxed/simple;
	bh=KV1MZJLuXGXI7Q9soEXrl4iWeGSVJcGHbirBzil/ZbA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kyv+SkUpeLkyRj+UNKwvYpWEoTkEqt+H1YVig684DUFJtoZ40/NZWH0N1tgndE3uwC9fvxBBgBZXsCrgbpy0IqWnjWyrjv/amqwIk15HY3W1g75Jh3oZ6Zy6r+78YFt516pkhWwgtSvKEMl5ufrdOXzRjliah1kgEaMmOAILkxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BTEEtGSZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SsTNn9OQ; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BTEEtGSZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SsTNn9OQ"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id C5789114010E;
	Tue, 17 Jun 2025 12:16:29 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 17 Jun 2025 12:16:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750176989; x=1750263389; bh=UcyJl0NtSC
	yAy3VwvnePzoFmxhc7leJ2f8C8ZucNbts=; b=BTEEtGSZ+z4OJM/VIRUl1WSjmn
	/of8QHC3oJg5jN03i76k0eTRDF7nDnjYg95O0chc26DfFnGKXoBpsHhpz9WF6qqu
	kWNgD1aHbj6CavJaQQktzYSn1CgE7O6HCqhvwMMp+MvOJK9+4wowRv/aJb7+1ip9
	fxjE++BRbr38y85up+MyIOS+ll7PWuscKENGS320nqfFkdK4eu7l35rfQdcrXJ46
	x13Jw7NpRRt8rqBuI/j6Caot4EjBXsf1SQ+zXebZchMUkbXW00WDluzYviZH7Xyz
	65nJLlZZ4v9ZGJ1PTLN+0Dit0+7tvjl6/QJf2VoCHaPBK7A+0uyEv2KT80Qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750176989; x=1750263389; bh=UcyJl0NtSCyAy3VwvnePzoFmxhc7leJ2f8C
	8ZucNbts=; b=SsTNn9OQS/MTg1eyiFcnXwjy7YCLbBvcYf2Ht9+TRjXu8V0Ao3q
	jeuTyAdjf+1NpMtqi9oGGF8hdDBrZn3OnCekzklAgmltCaIEk1Bnb+GLnNLXJJK4
	bC6As07sDHKZ53ql5nmDlYA7363cj5Frcxl9WbfJjn2b0/Y3GlcigE+jLDhT2p9P
	IvJmqnEH8Jo63ZqPnOQ89gEYhMvNDHxILl+5s/JJLCK8ESmsICfC5Rucw4CNWgrn
	IrwrNqATaDrvTX8qJXiK1HP/W8GRz39oyz+kJOAwci50KABCexkZo5ya10wRVzJk
	vtHU/Poo20WkecxHR7EeUaLPlfG8CkJ7Dvw==
X-ME-Sender: <xms:3ZRRaISLOPkiGtobmPnc3WjCkRaC8JVdBp0r5HJlV4GvQxkTzZphdg>
    <xme:3ZRRaFwbEkhJJLDsB-BeOK6x4E0dA9O6Pu1lBqphroEzHeyQtgcW4_tMqAy3HE38Q
    OVS25EM7W7aFvNGpA>
X-ME-Received: <xmr:3ZRRaF2meuy_lYXQkpY5vREcOgK2yu2gADfL-9zmf-Woh9YWv2VZofQm7kN6i-QEAF4XIPnzoEIyEe9QJBn8QNvcO3l3gVuhZjZ5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdeigecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeffieetueejveefheduvdejudffieejgeefhfdt
    vdekfeejjeehtdegfefgieejtdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgv
    rhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepjhgrtghosgdrvgdrkhgvlhhlvghrsehinhhtvghlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjrg
    gtohgsrdhkvghllhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdr
    ihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:3ZRRaMDPTyp6GlOh6aLU1H_rb01ZDrFlvUnM264_eITOMqdvs1r66g>
    <xmx:3ZRRaBi55fn6vZYLVxp3gCC3snSZNFJegdKY8hf7RWBfsWufjo8mbA>
    <xmx:3ZRRaIr7Ib5HZXpm7OCRWfcokQae6aZ6snId2CVKE9MgOi24hRKWqg>
    <xmx:3ZRRaEinS36VAm2ZqZQP6JZX33FF82DYbwsbr9SKnIzDwxyvAq4iKA>
    <xmx:3ZRRaD9GhTMmZDhPTm9w9sAwrTPDcn3kj48omz9_yNg6UKT6oAiF-du0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Jun 2025 12:16:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: <git@vger.kernel.org>,  Jacob Keller <jacob.keller@gmail.com>,  "Patrick
 Steinhardt" <ps@pks.im>
Subject: Re: [PATCH 0/6] submodule: improve remote lookup logic
In-Reply-To: <xmqq4iwexv4n.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	17 Jun 2025 08:09:28 -0700")
References: <20250610-jk-submodule-helper-use-url-v1-0-6d14c1504e91@gmail.com>
	<f16e09e8-55f8-4fb7-825d-fe4c9b049d1c@intel.com>
	<xmqqbjqnz4ve.fsf@gitster.g>
	<83af9bc9-7884-4ce8-a343-28dbcded7954@intel.com>
	<xmqq4iwexv4n.fsf@gitster.g>
Date: Tue, 17 Jun 2025 09:16:28 -0700
Message-ID: <xmqqv7ouuyw3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Jacob Keller <jacob.e.keller@intel.com> writes:
>
>> On 6/16/2025 3:41 PM, Junio C Hamano wrote:
>>> Jacob Keller <jacob.e.keller@intel.com> writes:
>>> 
>>>> Seems like there hasn't been any interest in this series? :(
>>> 
>>> So far it seems, but we have been in pre-release freeze for a few
>>> weeks combined with slower summer (in northern hemisphere anyway)
>>> season, so it might have just been a bad timing.
>>
>> Oh true. I can resend once release freeze ends :)
>
> Before doing so, can you run with leaksanitizer?  When merged to
> 'jch', many tests fail and t1013-read-tree-submodule.sh #52 is one
> of them.
>
> Thanks.

https://github.com/git/git/actions/runs/15711453001/job/44270362056

is a log of running the CI suite on this topic alone (tentatively
pushed to 'seen').

Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADC222127B
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 16:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753805281; cv=none; b=ihq1UhTvsw6eOmyUukO9FseynTKywbXfJoL2QsV+ADqjkTv33YvJBvjzs4ko8Eh4yeXuAS+tPv4Dg7rJ83D8W5O7rn6xkwdSv8dVMrEvJk36I75MY6qmZ6pr0QTtsS+05/YKOluNELYjb0ITSTS5vlvmrlCfxpUyttQSnML1wC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753805281; c=relaxed/simple;
	bh=6/u97YqMBQMej8o6G34o5uE3fkWRha0EDbXYBW915Sw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sT+rd80IL6DGA6lYY1vVqZ0WEstptzALvw4PiOALwAnvCdKsjTorlACgDBDT04zphTkRP+7txemI0CrweiWh2rSNRkDfbySBu2BaFtruFHYaM8HbsEjq54SULFd5pn+KRlTjqRG6W3UYQUId/8eam19PzZzUk0p2BZZKPvPRIDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mBaxNdG9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KgJ0Smhv; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mBaxNdG9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KgJ0Smhv"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CCDDB7A0023;
	Tue, 29 Jul 2025 12:07:57 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Tue, 29 Jul 2025 12:07:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753805277; x=1753891677; bh=hMUOZOdPG1
	itnPDgsMsLoFvYNIxf340mnXZLiiREOmU=; b=mBaxNdG9K7ewcPat4MO21iGi+a
	Canhvqm/yHeYj2ZQGbHpejI5cx4PtRl0CtFcifvPvIg4GBSdTgqYftR6lpYxzD07
	3A+l2RSwAISPKLCn0qRCLCW8bTZaToU0gNodPaLNBHSL74bHkZ3MrmiK3S6Vd9Eh
	Qy6KkwPXZKLYgQXxvT8Ka5sQb58TerV5TRUmRq3mtz8yLMXLUq1j+uFyXvpL8Kpc
	31Sw5o6GnTgK5PcwTJTl0MnSorRQD/abLVPwFgtvyleKtsgBRCxYwtjyMIVz0Rtx
	8SYS9zLNysC20ck1DPudCvvi/0U9aGoj04LwoQYzqFqTob4u0zA7qsaRgvzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753805277; x=1753891677; bh=hMUOZOdPG1itnPDgsMsLoFvYNIxf340mnXZ
	LiiREOmU=; b=KgJ0SmhvAUYn/IkXMrvV6sKmKuGN1NXoQDX3xjX4YNIb1kw4vsH
	r2jU6lM1FSwlkRlaHr74JXwTDuQ/R3TRX57Hj+K2vVMROTmsRkThww015LbtJHUl
	zA3Klmtn6XqMEOgwJqdpqVhavgWyZV3gHRMptubyNEzPCZR+9H7k3kuR/4qz1zTu
	NhOVWjbGThoErjK4YjPk95i55qKOP7dCZMRmAIWWsggpz67G/yTnh8PO6ilcB5hF
	Y8RJ1L/P4xWFXc24hyI2F7ZP0uJ6ijjl9Zf4TXdzUo8Vu4TULHm8fdc4mteQftIi
	wgFggde+7XYnxs8qk6hBi/W4OAQyillSJRQ==
X-ME-Sender: <xms:3fGIaCIabAyaZ3Nda6eX-KUu7pxpR_Il77hQSHILVHSAWDoCDQsZ8Q>
    <xme:3fGIaF3lf3ALKu5LM76_g-6vgaOnjEZlpQN4IvK3RlwzDmyhHHs6AZ-ei7xQ_dkFs
    WUfaWbqVDpENIZVxg>
X-ME-Received: <xmr:3fGIaPI3txaNRlOoyu0c1sZ7naBnZAxUG11b414q26HZVYYNmi_k2ger0T8ofwD75-EtVPMKcyPER3BgQIg1MG-xUEQl8DNtB-QDpfQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelheeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopedutddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkees
    ghhmrghilhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
    dprhgtphhtthhopehsiigvuggvrhdruggvvhesghhmrghilhdrtghomhdprhgtphhtthho
    pehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvg
    htpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgr
    ihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:3fGIaAgWfBOvmGpPdY57WrabiuaBpP50QmzIoOab9FJYcRccXdJeyg>
    <xmx:3fGIaPAIA-DBjodZ8ZwQ9-Oqh1YtITVv227D5SYhAqL_1Lzyh4ZpLQ>
    <xmx:3fGIaC7XUgzN6nprvg612pOP5QNtgY7xzGJH9JFpXqOy-u8XwKMdEA>
    <xmx:3fGIaEEDc7EYVEz10-8IC0TcVuFm3RFhRknbCAAYxETwGpkKpVlOvg>
    <xmx:3fGIaOtlnDVqQ_wKRIP4EgPQ4H5lf7JhiK13QKAppOjbWE6jjzT4fdXD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Jul 2025 12:07:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>,  Justin
 Tobler <jltobler@gmail.com>,  SZEDER =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com>,  Toon
 Claes <toon@iotcl.com>,  Jeff King <peff@peff.net>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Ben Knoble <ben.knoble@gmail.com>
Subject: Re: [PATCH v3 4/9] builtin/reflog: implement subcommand to write
 new entries
In-Reply-To: <20250729-pks-reflog-append-v3-4-9614d310f073@pks.im> (Patrick
	Steinhardt's message of "Tue, 29 Jul 2025 10:55:22 +0200")
References: <20250729-pks-reflog-append-v3-0-9614d310f073@pks.im>
	<20250729-pks-reflog-append-v3-4-9614d310f073@pks.im>
Date: Tue, 29 Jul 2025 09:07:55 -0700
Message-ID: <xmqqtt2vou90.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> +	ref = argv[0];
> +	if (!is_root_ref(ref) && check_refname_format(ref, 0))
> +		die(_("invalid reference name: %s"), ref);

The "root ref" check is new in this iteration, and it makes perfect
sense.

We are not passing REFNAME_ALLOW_ONELEVEL flag, so we explicitly
allow things like HEAD (but exclude things like FETCH_HEAD).


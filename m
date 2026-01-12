Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13ED124E4D4
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 14:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768227580; cv=none; b=hvZKml3mWdN+QkDS8p66Jp/7DBG4h5RXbXmEMmXNdJLwSn8pMTt5UxGfwJHqajGKRwzR0j3hhpuGWS1J77j9WW+OkV1CY/c5xdk5E/os0YwhzO9FdCZzU02YCRdHl/UhTgTRS3CfN5fe0i4h8ZNDIJ17NaiOjgf2pIj3834NyYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768227580; c=relaxed/simple;
	bh=HOJAsgdVl4jV9X7FdLhAE3sOCetdbisqEEUNCrpzKss=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rl5YlDAZ0Yiql1K8hw6kD52eUBJf54SjpcQ0qetR/Gsfq0CzQUhEG8sH0se5eraZSTPJaLKqU8EZJFdw4AsotDWIcjHaAbXwBpy/owkZLAM++0nKNXFxIZoM87qUiYdaYWRr6jjD9SCU63p9TL7/hFVWy6T5/wcA3k2D1zg5B+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UyaP8PI9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TCvGsMFr; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UyaP8PI9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TCvGsMFr"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 700171400111;
	Mon, 12 Jan 2026 09:19:35 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Mon, 12 Jan 2026 09:19:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768227575; x=1768313975; bh=/B7G5jCYpG
	mOGQaluHu/DIxQcwdk0WhgRgcSNUh3Ixo=; b=UyaP8PI9GUjGoBJ5IyDfWpntS2
	0cpiAg9jt5JOwLySWt8bVX5AI1Nk+5FyxQ93tYSMP4aRhN3qWusk8Hci+wkNXhIq
	YNjZlx5cvst2mQKN9wLyGLgy4/SnlpWS4S+4gLEbbRv7+yGRrQmUT/XhTMaQ+3K9
	VE8ZorqTo7Ow08vA11/O6Krrs1SfMpiWLL9anEQnjbeH/pmfKF+xk5u6gPpQZ3o9
	NBFs2yXJaHS6FHe9A4i5WJs6F1yCNzZU2emsVI9Zxdo4UpnYoYOgkvTNT7fQl+N8
	mlBW8CroYPoi6AffxF0ucPa7WgGGUg6HGpiU9WSoZr2++avKBK1dD2BA40oQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768227575; x=1768313975; bh=/B7G5jCYpGmOGQaluHu/DIxQcwdk0WhgRgc
	SNUh3Ixo=; b=TCvGsMFr2exfCS42ZAn4jWflGfN10Oq7fS6rRKRaDAIgQv0HCCS
	T8C47GVHYUhSCEPSQlxiIb0eo618HMutENBw38i6yEnQlct1kBEZKtqwd3zqZFoY
	yjGIoHax3v5vN+hWCozyMU0YBgfG1PX5OKcA/HyiFaDdpHdM2KVMCGsyS89IFq/J
	9NnoB/1JMRCf1fxLzAr4/yvzzV5cNbxfMLefr15LOiyflk/154C84pnJtqGY5Xd4
	vn7GjQOGxwHcArwNQLZcr8+jv+aT7s4APsAjNE4cxHQ5nhyTQ1t3GbQ1tPR9u6BD
	flkdYTreIznEeMbqtaYYHrifw+ygBJ2bpvQ==
X-ME-Sender: <xms:9wJladGmunhArubaeIAKXt4pWkhOEeHKMUnG8SXYP2Y72NKIJwS4uA>
    <xme:9wJlaZOzMTvcjA77On5FqprZJ6xxl-6rXstL5mdgQQ3O7CrEGaeCrX58jEcSQhpZ0
    KKQ2R33q5OVz5TAx_yB9fHsfocGKbmlzaEjr2C1nGYsYkrKVkOGQsk>
X-ME-Received: <xmr:9wJlaXcaFoRHZ132jtD6pGzU3Li2ZoTsfnhWhIA6WZRaglS3qkblgSrl5v1Vcveuc0mBINuQ_9ISToj_20qwDxcNHc53zOIfhosjqcA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudejieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehkrghrth
    hhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:9wJlaetYhTb_HBNvhS_D-WmiHBfCpWjQfPof9EP1omg00i-EKq1X7g>
    <xmx:9wJlaQm7Y_zmXoWmWJA-0GT41UwooN6t94bsOrJcZGHhCWXpwd4PWw>
    <xmx:9wJlaYwSyU5hkus1YHjdogVZeksRp9gW72Vmp8h6CnS4-Ovu5LA6Vw>
    <xmx:9wJlaaP1jwmKhDVbGoqmTyHk49yWDCawybrcSVA1zrVa6MurYshp1Q>
    <xmx:9wJlad_uqGqZKwaaz9_vdS2qb4u4wpRsXT348KKA2bCDoewOlTnBKtDJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 09:19:35 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org,  shejialuo
 <shejialuo@gmail.com>
Subject: Re: [PATCH v2 10/17] refs/files: introduce function to perform
 normal ref checks
In-Reply-To: <aWTyXufNdKckmBTC@pks.im> (Patrick Steinhardt's message of "Mon,
	12 Jan 2026 14:08:46 +0100")
References: <20260112-pks-refs-verify-fixes-v2-0-2e9e453bd6c3@pks.im>
	<20260112-pks-refs-verify-fixes-v2-10-2e9e453bd6c3@pks.im>
	<CAOLa=ZRMvbRT64+XdKobM5RZhgiPd=2k5_Yf=rgKyjWnbpMg1A@mail.gmail.com>
	<aWTyXufNdKckmBTC@pks.im>
Date: Mon, 12 Jan 2026 06:19:33 -0800
Message-ID: <xmqqldi2oqve.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Jan 12, 2026 at 06:42:04AM -0500, Karthik Nayak wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> 
>> > In a subsequent commit we'll introduce new generic checks for direct
>> > refs. These checks will be independent of the actual backend.
>> 
>> I don't think we've used the terminology 'direct refs' before. Took
>> me a second to understand. We generally use 'regular refs', but that
>> includes symrefs, so I think this does make sense.
>
> Yeah, I didn't really know what to call these other than "direct refs".
> We could instead say "non-symbolic refs", but that also feels kind of
> awkward. So I guess this is good enough...?

The latter is understandable, if awkward.  The former is not.

Thanks.

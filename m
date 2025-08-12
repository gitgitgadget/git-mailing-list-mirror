Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962C62857E0
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 14:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755009018; cv=none; b=LimiuImY2E08GpabX1C2v97n2qcyL8N8/lIBVdQad3DQRmSdJQL7D5RNyEb3LofcXzOirayi2i8G3iShAsGYKAvHkeA5szn9gye7li9tBh4XYaQn3ihcIvAhQRZGc2qQ0EvZ001xFPMzYBW4Wfd+nat9NZ6u48BC8vQrliIkAI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755009018; c=relaxed/simple;
	bh=0bV+jRZcK8s9vHDBXt8SIoq76dNgbDQw+phWkLh0Lzg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eF9zp9vC39s/0MPqd8tf/HAE42iW7z1IDN1M7tKrNIAgqijagYRP4nSP7SIHuYHrxLcDObIUuZiJd6U72FrGt2g56Fo4wGMKOg4n4gqMeROtjbkJEgrIi8JlXUkhTsUPYxH3YmTiB5puKkMSTMmRxIikBtTwfJaLp2TOS/ezsFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NGsdMiDB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ICd6AUPo; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NGsdMiDB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ICd6AUPo"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 7BE94EC02F2;
	Tue, 12 Aug 2025 10:30:15 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 12 Aug 2025 10:30:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755009015; x=1755095415; bh=1FA6Wr4Ld1
	t5Iwz+lBWnvvvbdV3VQswlvvNfvteR5qs=; b=NGsdMiDBomUBAPL4BHYLxTl5MC
	AAY86t5RQrtznhQk7SsfR5xZeFlr7vWNcpCWGaTmYpUlTKYoXfOs8skmyet8uZK0
	mzBAab+2Lnn8sQfODBaBIKLSnUGOmAem9FaVaXdGIl9yqWyXKKeNSsK0wOXm8W9l
	mJKvd2kq9elEKIopDyV/+4j8/8VYGyySFIRSpVjpZRtk63OHzxf48eiZCmUJ4SQ7
	ta89gJhjeR18jp2JPnA4J35fkWS2gI32Z/Yc0v+uNxxFMGYg6rokNm0aQEiI+LcJ
	V4KqtD9Sdx7Y9EHb4Mszo3EmkQQQdSjDBLQm4SSkoWA5N9pL2Cj5l1iV6NUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755009015; x=1755095415; bh=1FA6Wr4Ld1t5Iwz+lBWnvvvbdV3VQswlvvN
	fvteR5qs=; b=ICd6AUPobSvjA+/I98kV6Ch39VyRzRcd96qaWe11+zODZenAqiF
	9GbFhNCGHopB97Cwyel/5CJHpyPWYjmhFOqAmdCIIIhJvf+MGYqMm52EnOOdF91b
	G3WzIglfStJcTpnbl0Qb6vndifKczvc3uWsTJKEZeN6QhgAfXKe87NIFVZxvhjoP
	pl7AH+XvreUU73QKCQDwFltBgWfCbApCXBqknm8SrOrIqQtK3Al/3ARED1DsXV6Z
	gagqTYeawnpOhrkK3WVUJDC8+FUZfYOVP0KFrXhvLwwJZe5/FDNwLWhuKE/LZVm1
	/zhyEqgYICiZF+VV+/q94sgMchiNNFM+cNQ==
X-ME-Sender: <xms:90-baC4vQ_66rJHWK1ZPAQCRDYXEUksf1gOVvAVLfpQucVcNYWisyg>
    <xme:90-baEXFKUprXY826NHu-EIz87FNzrqyB7CDORZIjxcAVWl5lqwnRfGuAL8vb9WLy
    HVQo7curm5BXlPhQw>
X-ME-Received: <xmr:90-baB5sjrCOKxIMBxTn9mfrLQPG3CWR3nKeaX2OLldgh-kNjSeLNvWB0QXxBd7bhU4Jy6WyxALYoQ7Zq3Zl5rMBy48s47CW3Rc4NTk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeehheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhulhhirgesjhhvnhhsrdgt
    rgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:90-baPrL5DcNSy51DarR7u6fNRmY8M0GtNycPxbt4peq_36BP5A_7g>
    <xmx:90-baEmUVcFT6C2Xy7FjxT2rc18lDmcuVcH5CJ8jWzGCmiuX3izRoQ>
    <xmx:90-baLMv_kNFW8n-iqhvLnmXyjbEjJMZCx8sVMb-t-DK3b83KtKV7g>
    <xmx:90-baIMl54O7dZpqE3W2mxuO6FmGueprkZ9K6tTnXzcqaBNisUwA7A>
    <xmx:90-baLddEkp_ZAE9-B3tW_c5QLwWv47tjbg359RRAnythO8v5bXOyZLa>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Aug 2025 10:30:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Ben Knoble <ben.knoble@gmail.com>,  Julia Evans via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Julia Evans
 <julia@jvns.ca>
Subject: Re: [PATCH v4 1/5] doc: git-rebase: start with an example
In-Reply-To: <CAOLa=ZSCJ6NuNPeF7yN63rjgfKojsenGxyO5yfrKkX8TKTdi8Q@mail.gmail.com>
	(Karthik Nayak's message of "Tue, 12 Aug 2025 02:05:30 -0700")
References: <CAOLa=ZSTaAaWJWeXBkoxPx46g_Equo-sHWgCESE9G6vk3HZeqA@mail.gmail.com>
	<46477AC9-8363-453D-8A57-F599A451D36D@gmail.com>
	<CAOLa=ZSCJ6NuNPeF7yN63rjgfKojsenGxyO5yfrKkX8TKTdi8Q@mail.gmail.com>
Date: Tue, 12 Aug 2025 07:30:13 -0700
Message-ID: <xmqq7bz8y5my.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

>>> Nit: now that `git-switch(1)` is no longer experimental, we should start
>>> recommending it over `git-checkout(1)` as necessary. So perhaps, we
>>> could s/checkout/switch here?

Besides, the reason why it is no longer experimental is *not*
because it has proved to be so much better than "checkout" and the
users are encouraged to use it.

It is no longer experimental only because it and its set of options
are now engraved in users' mustle memory deep enough that we can no
longer change it without disrupting users.  We were hoping to
improve its end-user experience relative to "checkout", and allowed
it to deviate from the precendent that was set by "git checkout",
and that was the reason why "this is experimental. UI and behaviour
is subject to change" label was on it.

The experiment unfortunately was not a great success.  There were
only a few meaningful differences invented during the experiment.

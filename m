Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1146927AC37
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 16:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755792335; cv=none; b=YmivLHosXSDMmr6G08WQNTK8zUIHfO3IbK+CZB92KxGUFfLmb/HsZFH5WAPKvrnPAxQfxBYWyhCtnO0PXOD61RcSE3xPaThZvcGTKMPehFpzpB54yyegVeRkgx+Y/i3S+pbMGwzU7t5R84D8L7WBY8wLuh2hdN+xm4eQbu0aCLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755792335; c=relaxed/simple;
	bh=GFuUTsDRxA5troMje66LEOJzGdqFgefegYLOLnkfraE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AVZp8tQ1QxeQ4Sz5KdV69xdBlUdZIsnysAYASCLczsiUV+qVJpnLOxjlTvim+QID8knURXiaFlVzwJKxJgwRM3DzDYws4kceiNz64IOqI4cZ1c50a1nHeHpHc6DVPxtghkoTr6sfDDEln3kSaM2EO5aXyJnq2t8SbAPcBUp2Ql4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KB69eSnH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NxkFHPWP; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KB69eSnH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NxkFHPWP"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 103F77A014A;
	Thu, 21 Aug 2025 12:05:33 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Thu, 21 Aug 2025 12:05:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755792332; x=1755878732; bh=F+jecWdlLa
	rIXKOhWy98k6UuweVDNNezTygnrrgEAPY=; b=KB69eSnH1SNwlLjnx97sI/YlHR
	q2WpjZw0vGExg3cP1iELvCRi7HB9n+xc2WOevnGe4WEG3mJPFRcDKF/0LJe+4uoo
	8vw/b+MoorxUB4AvC6c7KwBIyxaZhtHuzxofrwiiLWbqmkl79stV05d6HQbqnDlB
	7pf8c30gNXoyVuNyxaBABZWVKfxcGaAQ3NSc+t1p9ZYmTsf+CTgpI1nNqkKjCIr1
	ZVwYkLG3MOuYgvNaemI8IkK5xoYQxkZzcmGL6tx2CljashHdeJRMfCyyjKr3IqEW
	DpZZoKe6eZDvkLHvZ9EHNFLkov8YMaeqCWOmfkrEVTtIWe64PKf951HmfQQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755792332; x=1755878732; bh=F+jecWdlLarIXKOhWy98k6UuweVDNNezTyg
	nrrgEAPY=; b=NxkFHPWPtHB2Qdb+s+ymbcxp9ktAHKnGqRlf9rud3RYnHipMNpQ
	+m5neZjoygd6i+kz520emDr138ZWxtmk9YzSmqs3lfmbqgkxjRoWCL4rJDspsuXG
	opjVLUmhIlqV/vXAAV6EgmoAX1WX69dPrqzM8+K9l91G0YSNFV/vZ0i3DFJlMh/A
	n+v4PleCpX6OwG+O41Q7lvPSz+bc+wmIw2eIPpqEU0DOd8lNvfAmqSVH+QyFEyJq
	BJ4qPNy3/E4FbYlPzKlkG9lflrqNpIw5FxIBeiAiRhOmbeFCdKCPJ/4f+QdQQQWi
	9aUSjG+i/Op/9/ijkSjuhd0RL4sMuDycVvQ==
X-ME-Sender: <xms:zEOnaI4H3GapNC1FbVCgLAtm7HfLNxH7CME7qMRHMDUbJirjYzbt2A>
    <xme:zEOnaCUmJN66BmS3uqrvpnBqFpFf5SEV_k68O_2VrcMv6YEBT2PeOhR15558O6o27
    hXSfeASwE6qLKU-oQ>
X-ME-Received: <xmr:zEOnaH7rsjMbGNQIv5BXhbYffSV7-pbu4deX2hsLyryZo3HyKPhGXlfXRzloKU0m0jiUxuG0fm2P1vkwYA_wO0haeCz9tXK07VLKgWo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieduieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehpvghffh
    esphgvfhhfrdhnvghtpdhrtghpthhtohepjhhovgdrughrvgifsehinhguvgigvgigtghh
    rghnghgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:zEOnaNpHX4XmwGMr5zGPoiklRBrDFyhV5nkzM4CR2wx1LcfxKuDEuA>
    <xmx:zEOnaKmSRzxQsav9TFzwOdZoNY3H5UfQcLx5gytSU9eBtasxQ94H1g>
    <xmx:zEOnaJO-EcjbOgaFsRiKK0KXfsAdaJIFipLwE3aHNH_WTFjdTZ6NDw>
    <xmx:zEOnaOM6GEn3_5JH8AG9OsJy5eIQMhzxwQ4Dj0xapiRrNU-5HvNZHg>
    <xmx:zEOnaD2u5wIMSO5wOg-4De3xK9iaaiWV27wIZwJWZxo2vDsYhODn-I5v>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Aug 2025 12:05:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>,  Joe Drew <joe.drew@indexexchange.com>,
  "git@vger.kernel.org" <git@vger.kernel.org>,  Karthik Nayak
 <karthik.188@gmail.com>
Subject: Re: "lock file exists" when fetching in bare clone of repository
In-Reply-To: <aKbwabLZiWasYoBC@pks.im> (Patrick Steinhardt's message of "Thu,
	21 Aug 2025 12:09:45 +0200")
References: <YQXPR01MB3046197EF39296549EE6DD669A33A@YQXPR01MB3046.CANPRD01.PROD.OUTLOOK.COM>
	<20250820213323.GA1667633@coredump.intra.peff.net>
	<aKbHozlmDIqfgkg4@pks.im>
	<20250821072706.GA2390046@coredump.intra.peff.net>
	<aKbwabLZiWasYoBC@pks.im>
Date: Thu, 21 Aug 2025 09:05:30 -0700
Message-ID: <xmqqwm6w3bjp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>     You're on a case-insensitive filesystem, and the remote you are
>     trying to fetch from has references that only differ in casing. It
>     is impossible to store such references with the "files" backend. You

"backend." -> "backend on your system."

>     can either accept this as-is, in which case you won't be able to
>     store all remote references on disk. Or you can alternatively

I do not see the former as a viable choice, though.  When this
happens, the clone or fetch fails and the user cannot catch up to
the upstream development, no?  You have to futz with the fetch
refspec to cause refs your filesystem cannot store ignored in order
to make progress on other refs, but that is making the user do more
than accepting this as-is.

>     migrate your repository to use the "reftable" backend with the
>     following command:
>
>         git refs migrate --ref-format=reftable
>
>     Please keep in mind that not all implementations of Git support this
>     new format yet. So if you use tools other than Git to access this
>     repository it may not be an option to migrate to reftables.
>
> The last part is what I'm working on right now. libgit2 is fully
> functional now, but what is still lacking is reviews.
>
> Patrick

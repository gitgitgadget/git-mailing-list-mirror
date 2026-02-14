Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DEB28FC
	for <git@vger.kernel.org>; Sat, 14 Feb 2026 22:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771107074; cv=none; b=JQALoceif88vHL1zNz/yZeDF9XiAJiC4b0VpISo1PFtF7yriLvXEoylPR++6BIgcwPrIAcCyqTr/rLBb7LcfVDeMos7kaNzBFMXaZXB0fFlFA0zvVS3X2d7hc8o5OSsU1VpVI0r/ze5Lh8B3nag3eoRm2ARMObR9Te1oXNYODMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771107074; c=relaxed/simple;
	bh=5mncnKZnYysRJpGl0arm7ML6zpHTMfbNgeMzJ7WGmeA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W8htpnKrEpPOJ8mnNO7ctw0O+TVNl3uG6zFew6FSbzQbtOne/SRVuPbaoeq4vqVz+kOcd81IfGfRnyc0CyvAPsxift+48tKKUC54YA4ZDFNCw7Pjk7QaL5cvH9tkfQiVw2q9EVCNcEzssyvuqsAJNHM55yjz9YvHCk0Pkw8unxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iMXp4yhH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qfwvx/xF; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iMXp4yhH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qfwvx/xF"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 96A5E7A022A;
	Sat, 14 Feb 2026 17:11:11 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Sat, 14 Feb 2026 17:11:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771107071; x=1771193471; bh=JZsVVxMjUs
	s9XtLsxmOxTOyZWlsR3VAlLNO57WgRNGc=; b=iMXp4yhHjnkH9RWAcsPf0OGmO+
	WYuTKWXzeDX/Im90u/lO8FfyPna/GNfbg8Vg9yvXyz7f2mwqKctdBx4eJY2tc9rv
	ogGS1lec/pvlrOufW5INsUUmNlO0EjfMhk1V1nRDb49S2YxJxtMo/Ohuo2R9a9Ww
	Tje7iqUBLItmJyMQqhsiGVF+C94xotGEONCovT0AsSaaOufjPHKOnzn6zmjyQ+J1
	Wv9X3wrrOeQDII2rs8GwqvYiCygo6YDDMDa/F4d+ewpGiwDvueYwAPSqSmzyY1Yf
	nnlMcNS/2I04mSjAizmSbUEpCC60sIcQeGe6j6Y+H0jNqDQOX4zDUBEKtyAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771107071; x=1771193471; bh=JZsVVxMjUss9XtLsxmOxTOyZWlsR3VAlLNO
	57WgRNGc=; b=Qfwvx/xFgEJ3PviFR2X2QGntqqozmw0YbGSQlucFc9yx3KNeMQZ
	zkrv37jRWN45PbExp88jJlPP1rq0cJwShQewLmdJ1gfq5xcHb4PNOwOxfxghfgdn
	EL3YCeJJg1qyRDGkiNvuf/Eni3PG55hiOOht8As7LqeCLoCvdbkIwdDPvS6Vqqgt
	Fk9DLNGr441QjRdG9C3A2//iXkNyLHSkj/i9uq7Ak+i34N5yOeSj09uD4R9mjX0I
	XbP4DAmfIrbRUgGQTK+5io+U/LKmhnqW9+KxAOdNTcRhTY2ED6b23oRioYcTjSGD
	yjHxu/e+HgLOhHzjao92x5M4Nt6WK1fmKOg==
X-ME-Sender: <xms:__KQaW4-8y9qFEVnasSUcJLnk2BjCYJFp7tV2M2PG3jcR52eDlDjGA>
    <xme:__KQaXVg4pfq2sh78ok125QiPAqaebc-s7fGXaMNyW5dVbVSmFa09spzpyrPSZU0E
    dS-UP7VBf2ndOzsdGwsrrSZLjmqDKQp-EiTgGK0n5J82vBODFv5Pg>
X-ME-Received: <xmr:__KQaS04ZqSG73at3ycAZUoPF-efcP7SHMpcGWu56U-Mzx_tG63lNyjFulh9BNNSoOu8ZxpA3e4m0y94c8hQfv360K-XQBc93Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvuddvvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeettddtveffueeiieelffeftdeigf
    efkeevteevveeutdelhfdtudfgledtjeeludenucffohhmrghinhepkhgvrhhnvghlrdho
    rhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhrvghgohhrsegthhhkphhnthdruggvpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:__KQac3cRI58W_Yf9HRrxD0zjvFphQQaDj7MfEt1794xHmjWAfO16g>
    <xmx:__KQad-sDy9ye5OqA92b9aE8i5_dxT4bonSjA6JWaR6SXDz0ieGFRA>
    <xmx:__KQaR12Iuk4Jrswil7j8UwJq6DbTBP2X8vuPfTdQ7tWgQn-qxWY3w>
    <xmx:__KQaS9iWbDTVUGRhK_pApHy3__ExlhDOoiVhzd7lv7gsaB8gmB4gA>
    <xmx:__KQaQjfaBMGcXlBT-1cYvBfQ8UsiuXHxXwf1g_Nt5abJAsg48D8KYg6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Feb 2026 17:11:10 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: gregor@chkpnt.de
Cc: git@vger.kernel.org
Subject: Re: Question: --since date parsing uses current time instead of
 midnight - by design?
In-Reply-To: <xmqq8qcwjmgh.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	13 Feb 2026 14:41:18 -0800")
References: <e5904a7b-c146-4c36-8b87-c5c508e14cca@chkpnt.de>
	<xmqq8qcwjmgh.fsf@gitster.g>
Date: Sat, 14 Feb 2026 14:11:09 -0800
Message-ID: <xmqq3433gema.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> gregor@chkpnt.de writes:
>
>> Hello,
>>
>> I've just noticed how git log --since=<date> interprets dates without 
>> explicit times, and I found the behavior seems potentially unintended. 
>> I'd like to understand if this is by design or a bug.
>
> Looks like it is very much designed, ...
>
> https://lore.kernel.org/git/Pine.LNX.4.64.0511171505080.13959@g5.osdl.org/
>
> ... at least to me.

With hindsight, it looks to me that both conventions are equally
legit.  If you extend a low-resolution time specification (e.g.,
date only without hours and minutes) to use the current time, which
is what Linus decided to do, that is one valid convention.  You can
choose to extend lower bits to zero (e.g., date only without hours
and minutes means midnight at the beginning of that day), that is
equally valid.

The former, however, is more convenient than the latter for humans.
You can ask "what did we in the past 24-hours?" more easily.  And if
you really care to give the midnight, filling the lower bits to zero
yourself is not that hard, compared to having to fill the lower bits
with the current time.  So it would be an overall win for both use
cases.



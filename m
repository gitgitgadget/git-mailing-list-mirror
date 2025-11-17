Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3A710785
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 00:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763337777; cv=none; b=nS6iFCPb8Etrz/mLUtJO1X8dyRNYnhBfTlL+IOuZK/G/+UF5H/FZ/d+6wqTxo0dPFE6TMuitPx6rBptGJCmOPSMteR7aem+evGA2WDY8GI30IN9OxDV7lgpWgvEg/MCzUSOo3TQr3JRF7DUieXF65uOGA1fsQdlNUEx+FmSACxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763337777; c=relaxed/simple;
	bh=oj4+Wv+/EX1lH7KJwSxAOCz4cx20j/vRhP69gFCmP6w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ED9gPyNTugybgf5TOrBKqOqb/urpTCp8zQxUf+Ok+E7kKft7l+x5pAf1rLEYC547R1It0hQijwDz3qNW6VJic2cved4QN6t2/NXKsjt6dRBrrC6RtSu7anWWFpgORMdNbVtGsMdq/m/d+Mfcg0OuDAlHB1ln9riOzBchzgxcGGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SOVP0gsn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zvgp+S5U; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SOVP0gsn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zvgp+S5U"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D41337A00D2;
	Sun, 16 Nov 2025 19:02:53 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Sun, 16 Nov 2025 19:02:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763337773; x=1763424173; bh=1cPblj00nV
	7ZXp84jTxDYqO4IuguYsW2rdOZdzbr93I=; b=SOVP0gsn7L7nHafnt/K5/iiqDP
	L51QxoNDqDkH+YkibE5/S1Lr6xNFK3c4Ydqw7sGotm7hrIKAJlzsmNBBH1i+xSup
	aCgkq8Bo7aH7IfEE/sDxY22p4h983fHAMUZ+ImVjgadrV13de07xG9dvgPzr5mbr
	ZKSmkR10fPFE+mHE34W62NxD5vozIc4XyNYgXSnXG8Quj3q/c8EgDh3ep3tevo+c
	zHr4SJk0F/hrlcZ3BfcrzK7Snv3t8HMm395b69/DdoNQ7EgUkp1TbEkpGxmmbywy
	vD+c9HMAutSzYjio67LWXHK5tdsJUwE8LpueapZ6FoABEXiDVwpdX2ZT/quw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763337773; x=1763424173; bh=1cPblj00nV7ZXp84jTxDYqO4IuguYsW2rdO
	Zdzbr93I=; b=zvgp+S5UNZKQZxQ6t3n8Yswv/EQacmiQ3cJ2+aHpfKEL04xiT/N
	9NGxARpbT23FKKn2y5CBzbJ68f0X7fru18Ix2zrFT+2WZqSoFVE5kiOErN9Wrc7l
	9+88ylPzWnzSi/QD5wK3dlNLwuYnVukykShFNsGP5Umax1gs8Dq0NV6lMPBjjxBg
	EoYbmYHqeoRSCHHJfSWRha0VeKEEa68YM8NZzuZ4k6AS4m0d7OtiPGmZ/K6gP0sZ
	p3tR5nn/dfy/9GM8NCVCaEi9jcYIRTkn1olnpt+T8dxD1/lhHq1LzkDSIAKv7r4P
	hoBqf7hieR+rLQIlIW88jxMmO0ElNozOFgA==
X-ME-Sender: <xms:LWYaaYbBlfmBbgsuCT3pHYSgsnxRujTmueEOvp9gXRzLlvR2P6CAxw>
    <xme:LWYaaXELm2Oi5wlDaH0cuHA8WO6QBI_F04z2Z2wplbk2uarTr7HUtE8osBHEaMTYT
    EPT-UVlPYefMbSKpOQ3ljtcF9ATcQ3lYigmemdhRpF2Ilt0SeP2Xrg>
X-ME-Received: <xmr:LWYaacy_OogtuTRAHDbZxViiobN0vv4I0ZM1iKaasjqJvKM5OENp6VpsSifFteuPZgrfQvsvMNOvxH8bHgx2FG_KncJD5F5tDpAr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvudeileejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    jhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopeguvggsohhhmhgrnhesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:LWYaaZlhUmWQBNP9T4BeHt71sYwHB5vZAmkQ3KqeSH_anlFSnshaRg>
    <xmx:LWYaaVnTRDWryhiCMO8wzdFT45nmFuZWoSQxlzZnktgRgume6CcSvQ>
    <xmx:LWYaabwRbBcVIeX9NdCb0E9DRbbsCU8TFcZmNsYWt6bLsLfee1z-gw>
    <xmx:LWYaaarrSoDgt2Cu4uDanv5RVLmrYlGcfW2QtK3EUxw-V7CQwv_smg>
    <xmx:LWYaab_AHWQ3gyeU9j5D95W3OkJsVDtOgtiFxN1YJCh6scUPbqJ_5aE6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Nov 2025 19:02:52 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  jltobler@gmail.com,  ps@pks.im,  David Bohman
 <debohman@gmail.com>
Subject: Re: [PATCH v5 2/2] fetch: fix non-conflicting tags not being committed
In-Reply-To: <CAOLa=ZT9wv8B7EKXJQvwR07bUT7Jx0nJSwGGyUZ8+GN3-xdRag@mail.gmail.com>
	(Karthik Nayak's message of "Sat, 15 Nov 2025 22:16:28 +0000")
References: <20251113-fix-tags-not-fetching-v5-0-371ea7ec638d@gmail.com>
	<20251113-fix-tags-not-fetching-v5-2-371ea7ec638d@gmail.com>
	<xmqq7bvtlj8v.fsf@gitster.g>
	<CAOLa=ZT9wv8B7EKXJQvwR07bUT7Jx0nJSwGGyUZ8+GN3-xdRag@mail.gmail.com>
Date: Sun, 16 Nov 2025 16:02:51 -0800
Message-ID: <xmqqtsytbk5w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

>> perform.  Namely, we do not
>>
>>  - call commit_fetch_head()
>>
>>  - run set_upstream processing
>>
>>  - honor do_set_head flag that was left for remote that does not
>>    have followremotehead=never
>>
>> but don't we want to do some of them at least?
>>
>
> Thanks for bringing this up. I would think we should do all of these,
> but not if the '--atomic' flag is used. If the '--atomic' flag is used,
> we shouldn't do anything else and simply skip to the end.

True.

So when not "--atomic", the code with these two patches will still
misbehave, but it is not a regression these two patches causes.
Failing to do any of the above three when "--atomic" is not in
effect is a part of original regression in the previous cycle caused
by the "batched ref updates".  These two patches are trying to
address the regression, but these three points are not covered.  Am
I reading the situation correctly?

> That said, we could either append this change as a new commit with some
> additional tests and re-roll the series or send it as a separate commit
> based on this series. I'd prefer the latter so that we have the fix for
> fetching tags merged sooner, but happy to do either.

Either is fine, as this won't make Git 2.52, it seems.  It is OK as
it is not a new regression, but it still is a recent one, and would
be nice if we have something concrete to address it soon after 2.52.

Thanks.

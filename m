Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B531E334680
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 17:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760634684; cv=none; b=HxCE3MtdxTjYTdIC/bZEtLjPAXvRKVMaHd1wGfZnlWfuwdz05G0G7kOzwS89yCWCgh7hMlOSm4b81xp9N3QmoxmuoGr6me+J9g2J41DcPFjs06yNToAotolnE97yy8T1zsitDdL0fBHNznoRFqnZD2GXjRwmy5T26uc4wOGrHPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760634684; c=relaxed/simple;
	bh=v9JtNGoMuNkqlJIxvdXeORlsKZQviHkB8QlFc05LS5A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dbjglTvWYtcTe6YbU7fxLnCZoJm6nCFkS+4bZmG/fwsjYa7LeFpQItuVvkMERyhIanil+3QFwUWAfXe7cR7MeCEMdPx8lpbwjc75IjqdDawtGAIYnD3jmsqSF+pVVXYowtYRdgmrZbZR3K3b0fFAV271uYZtP1V0m73mM6jcYE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Kyl0889W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G+67lszz; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Kyl0889W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G+67lszz"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id B281D1D0005C;
	Thu, 16 Oct 2025 13:11:21 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Thu, 16 Oct 2025 13:11:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760634681; x=1760721081; bh=eDtstChA2l
	cW/AIoij4rxyA8Tu5nhgdATVxFdZEQ6QQ=; b=Kyl0889WBcGTCAqy/JosCa0ENV
	Z7iyTD9j5MD46RktiF0/9WcFYdcqv+xvDLCUuVgt3z9ehZ7145WwhJB0cp4Beoc8
	CiAgCZbCQW3Hjo6nEgdbPQeYJ65HRPSX1K64uuEyjG+2Fd8wBtTD2lAOhsU4tWOe
	WRDS1Hi7YC9XMFYJlP9MBjKa3t6o6yzVzlRdcsHO/Gl6ppq6OPwJTYSrFzUdmbUE
	esAqqaPkDe0XEob9M4LjQdE/Coi44zZpX0Do+bypG4P4Fc3TU3RUF9gdavm6onwX
	yKYBHHIS74PCxnnLzt3VMKymEbD+VxJzGd5uaxJQ+YtqdCnIXtcU0DKqSwuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760634681; x=1760721081; bh=eDtstChA2lcW/AIoij4rxyA8Tu5nhgdATVx
	FdZEQ6QQ=; b=G+67lszzweug3Oe218+E1rsEJamiI8NDMC8bAYxNDOCzUvG8OYt
	CwUzuU1l3IcKZTaNVMYsMaRIGwweLTv1P/1hCLV6GrXfw2kxBsChTgE0xLgYu6tn
	xjfXhbFX7Guf9mPQGKnhHAfSVIFeq0UOMl7kivTvPsYeXzWz9WNvP372psy/5VvS
	dboC7xd6yTBTubpHCDbMCyQvr2qtzwLIjGo0qopqND3/OFSvg4A76sTVzxDd3q6o
	UjRsTlygDkG2ulqqYgJm+tjopUByy4i6wqL05d14ZByiMggn6URdwrCw4sdFBet6
	b/o0JNGYveV2Eucqc4cW9FoYJ3QULAaohEA==
X-ME-Sender: <xms:OSfxaPlDst7U0IRgAfSeyz0FarApUTz7cThPaOG4_K9JqbL2Ok9ITA>
    <xme:OSfxaFGrUpGfrRyjrP3S82EgTdn3O7VtziuPwty6NUDZaaA0mHAAf8CVC_z1oJ-Kg
    IUjG8GiYSkKPZ6gZ-v5EtlkONG7I0pUt6SCfWTTnBsk3FFhxRXvAA>
X-ME-Received: <xmr:OSfxaH6TDT6Lv0jAfqGMRSsNjPgMf36qvhlFc9IIF81I-jjRknQvCkB87dPFRZ9HS57sW6T2FRKHGdz6fohMd0VRoZFPk46YYSTJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdeikeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehmvgesth
    htrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepnhgvfi
    hrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:OSfxaNluImngnNhcJDN9_qsldae7u_SjWCBAyF6_TIU9DJZyam2u4A>
    <xmx:OSfxaMr8AFkhCyk-3h94nNonbf5OSwj3sq55X7oD20j5aYTxf_rSRA>
    <xmx:OSfxaMt9DlEU5iFSaP3Xz_cBwQg5vWaXWjx8ZyXOZMKd5fCVWuhX1Q>
    <xmx:OSfxaBFNLv3TuV1tSOeLMmOPj0MjIIKP7ExOiprd6L2H0XTwpShfYQ>
    <xmx:OSfxaLFSMmWvlGdQ8U6FHfwUFJ5i1XNEQFNyNBYoGdEmWaM1MpYZDWiQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Oct 2025 13:11:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org,  Jeff King
 <peff@peff.net>,  Elijah Newren <newren@gmail.com>,  Justin Tobler
 <jltobler@gmail.com>
Subject: Re: [PATCH v2 00/49] repack: prepare for incremental MIDX-based
 repacking
In-Reply-To: <aPDJj5e9GKLSeVfS@pks.im> (Patrick Steinhardt's message of "Thu,
	16 Oct 2025 12:31:43 +0200")
References: <cover.1759097191.git.me@ttaylorr.com>
	<cover.1760567210.git.me@ttaylorr.com> <aPDJj5e9GKLSeVfS@pks.im>
Date: Thu, 16 Oct 2025 10:11:19 -0700
Message-ID: <xmqqtszy4vrc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> A range-diff is included below for convenience, but the changes since
>> v1 are generally limited to the following:
>> 
>>  * Wording tweaks and a couple of minor typo fixes.
>> 
>>  * Dropping explicit casts out of 'void *'.
>> 
>>  * Clarification in commit "builtin/repack.c: introduce `struct
>>    write_pack_opts`" that additional cleanup follows in the upcoming
>>    patches.
>> 
>>  * Marking parts of the new API as const where possible.
>> 
>>  * Using 'bool' as the return type and simplifying the implementation
>>    of `write_pack_opts_is_local()`.
>> 
>>  * Avoid shadowing "struct write_pack_opts opts" in `cmd_repack()`.
>> 
>> Outside of that, the series is unchanged, and I am hopeful that this
>> round looks good to reviewers so that we can move on to the more
>> interesting parts of incremental MIDX/bitmap repacking ;-).
>
> I didn't quite feel like reviewing all of these patches again, so I only
> had a look at the range-diff. The changes in there all look good to me
> and address my feedback.
>
> So I feel like all of this is in a reasonably good shape and a
> definitive improvement for our code base. Thanks!

;-)

Thanks for a vote of confidence.  With what I saw in v1 round, I
agree these are in good shape.

Thanks.

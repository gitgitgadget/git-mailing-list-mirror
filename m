Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA63F3009D1
	for <git@vger.kernel.org>; Wed, 13 Aug 2025 21:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755121224; cv=none; b=nC/QZPw4gZ4P/IggoszyT5D/KWX9K62sDw+YQWLhLz56T6K0s6dgvukkazF5xD7N5VjvLo9t3UtkFP/n9Fjtaso5LYvaewo6GcuBwzlIfGeIqqb/+PMj51iv44ABESKWYjFyz1znWKjDgDk/aNB1fTgiDx/ZBS2bKa6Y1XESoKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755121224; c=relaxed/simple;
	bh=JgcKev+1gBpliyCC+upW4OtGP6YYYW4AlbaOvsT9k7c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nNbTPiVecot/l5MHSwOWhljREv9z2E7UzXCwrMPS8NGxkETv2yCRiDOIjWWORIYfmbNHLgSxkdFnjdsp2SzA3Q3wcvzdsfI/7gw+7ndcCnLJnRjaEkEHwQ4Vl9nbTMYDTfFWqJzZ947nQh0+LtjUIEfEyRTpewCowZziZNZP24Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eK2yiRAG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CVz8jND5; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eK2yiRAG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CVz8jND5"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AE5A57A012E;
	Wed, 13 Aug 2025 17:40:20 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Wed, 13 Aug 2025 17:40:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755121220; x=1755207620; bh=2BUoRV11xE
	h4O5XCE3skB94dLwcfgzn5paV/lqfawm4=; b=eK2yiRAG/oZA1bk7SiuerWBiho
	nj5TdeYoz+rHf0/Tz1+u7Fj/IXxgn1FQhOCZMvh9/KnCPiUX4UDjAcoI6KJI/J6Y
	LxXeb8ElA1p3m2W+oZsdVTV0hEXcNEGpR41ZSzDuoZDzOe35uxzRXRntLXm+RlJs
	hRmzEk57XzUGpyokQdjsQ5sbYnNNDsoLKRHmqshYM2MFlKQL8QO2fHUZ2PURnoRd
	Oc6Mvy1UZ8lorG+8g88YqY+ceL3MprIRZW4JGbn5YDBNdDoCGzxzQngz6DPO+u9w
	J0WUGOmOvDm54LlAB4T96u6TEtguZYMKPOo9umPc4z3cwKVSnyaxRav1RWkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755121220; x=1755207620; bh=2BUoRV11xEh4O5XCE3skB94dLwcfgzn5paV
	/lqfawm4=; b=CVz8jND5tVLRYKONUqrnnxjiUFTFC3CJLmb2FeTkWzwSo/ueLSl
	u/wb+XfANpCC96dXeTMa9Hvd/bqAv5L0xuo78lR8NQOrvJTBdDzqSiz3+IS5Y7vC
	a37KR7NUCjFXTd74QcOWJwd+IPzTxroasWFPYoUvylHvODWftqDt7oX4IELW085V
	dy5hVCcM6tkn9PjFphuuhFnzZHSV76PvMQg/VEDese5QQvMPcoRZei3yv26+BFAK
	gtHpvnDGPvIsN4RapKoMOjzMFAlb3YdiAF3XnmLCFSwZcJQEv7oRI+Lkd94zdR9L
	UpyzI0nvUZ3euInCbKT/Kl6JTiquufJh/jA==
X-ME-Sender: <xms:QwadaNzUC0_Y1KDQDdBQvcvzlSGqwfwLF0KOdxJJqgGy3_UZGSqOEw>
    <xme:QwadaOAYjbIUjoCzZelHGQV0RHqDFOAYKGKjlKjJSGalvra4tRrHFWwGQQ_2f5xOq
    WcDcZChe6Kh5ydAKQ>
X-ME-Received: <xmr:QwadaDf2HIgNvt36aoXmdC9cVi2sHl_Z54EFDEmrUdSpiCXDngZFS6_tRnq1e1tiEKEN302FWW1L1T1bylidh6zERbfcZidjFrrGGwo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeelfeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhr
    tghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjuhhlihgrsehj
    vhhnshdrtggrpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:QwadaAm2RrSfXGohl98SdnhHaXNSGVMO8dT0mFkK4RIwXjDq0zDUgg>
    <xmx:QwadaCGcweYGwfRnHM_lTLb81O3fB3sg3QxoCDAr1RDVFtJiLHmmxQ>
    <xmx:QwadaA78ZKplF-VRkEli2MsJ1vfcwAUBxSQBxoGhAoJQeUuL9MlQlw>
    <xmx:QwadaClUC1fuANEhTtQdYQGij28Va00ZDEgChX88fvluywHzLdJ4tw>
    <xmx:RAadaAsDtV31cqvpt1V5fVgp-qtMv8Uj5vLXuS8ow0ZZ2_v1ncLl3ocG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Aug 2025 17:40:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,  Julia Evans via GitGitGadget
 <gitgitgadget@gmail.com>,  Git <git@vger.kernel.org>,  Julia Evans
 <julia@jvns.ca>
Subject: Re: symmetric difference with --left-only vs. range notation
In-Reply-To: <CALnO6CBOWTCd-cREfGYL8DPPd=S-s3Y6s0cgwvBzCJZr6E6hvA@mail.gmail.com>
	(D. Ben Knoble's message of "Wed, 13 Aug 2025 14:55:30 -0400")
References: <pull.1949.v3.git.1754693552.gitgitgadget@gmail.com>
	<pull.1949.v4.git.1754702057.gitgitgadget@gmail.com>
	<105a65e6e7121ac6a9a8a1d0b4f3217495a9f5e7.1754702057.git.gitgitgadget@gmail.com>
	<10372e00-3bb1-453a-bb62-332aaa935b24@gmail.com>
	<CALnO6CBOWTCd-cREfGYL8DPPd=S-s3Y6s0cgwvBzCJZr6E6hvA@mail.gmail.com>
Date: Wed, 13 Aug 2025 14:40:17 -0700
Message-ID: <xmqq8qjmc33y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

>     git rev-list --count --left-only @{u}...
>     git rev-list --count ..@{u}
>
> In my estimation, since we're not using --cherry-pick here, the first
> says "list (count) the commits on upstream but not in HEAD, since the
> merge-base (which is reachable from both)" while the second says "list
> (count) the commits on upstream but not in HEAD." Is there ever a
> situation where those sets aren't the same?

I don't think of any; let us know when you find a case that the
above does not hold true ;-).

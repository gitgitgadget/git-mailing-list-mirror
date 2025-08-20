Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E142A347D0
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 17:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755711402; cv=none; b=CdGCCYQX7MnML2n9fBQWE2ybUS8lXlFcGpbEodxtylnrBBpfAAgxNJKeSBJyFSJ0VwpvF2LAzfL6qE8qyRzQVFBWVwrnf5pfLT8IayMvnIRjApleL6umrIDShsRbda0UoooTlq0MITyvK1lrYiLwdDGpTONm1ppvHHP2H4ZlJyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755711402; c=relaxed/simple;
	bh=T86sVZQEuLkT+hVvrjtEVU9ObUKcXuIyvTWqIHaY/+Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EaShalk2ROpXuaj+kCqtn+Nwm8/0g3fT9iszSF2Of/OaBXQIM4/HbYsvys+4hRAszoXePfQxHTgOZ8kPuq7NRCO5DBQnlNZtOs4j3Mpo4vPx2vwMapAClt1kilZDTfm4Fq4+LKYBP1s4nOeHqgiP2XfLWJhPndZEjkjG6h2aiIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BuNylbZI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i/l/Xmzs; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BuNylbZI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i/l/Xmzs"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DF1BD7A01A6;
	Wed, 20 Aug 2025 13:36:36 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Wed, 20 Aug 2025 13:36:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755711396; x=1755797796; bh=Qa2bYhitL0
	CtosV1OClPPZDMchNdvY+lOyuqJ/5E4IY=; b=BuNylbZI1Z2G/6RLpHd56XRfei
	NI0s0tRUJmRYh0wLyFfxSnQloSPgJ7pPJXVkxxsSAqo/BDg45q51ENVDnGHUONtb
	vu5B8eY/52vwz4oLRgIqEA+8TGKhur5C65CQcpPukyAE2gW/+B36KhmEKxJRmpVi
	ngfnNVHnMYa2owu8JBpJIssCEvGZZAtoF8QnFAYfyhgADHjtYrc4CcmwLDOgIpDE
	GYJK0D8TOmUU6swyIN03csu6Knwm4Arf3zoxozXSeJCmLdXgbnxm1wyKU8uiPXjt
	tmZm1YZDbDpAIMZWtuykv4/qRdQSqAqHNThI0oedeqZLgPHpze80Qi3fk9bQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755711396; x=1755797796; bh=Qa2bYhitL0CtosV1OClPPZDMchNdvY+lOyu
	qJ/5E4IY=; b=i/l/XmzsMQikv8aILKd2zwIdGofIUrZn9KrRjorcyz0j3/ai1i3
	ZtB4os6U89/sOeJr6kPUnw7RzplIMZWPGZZaXoeAheVtftHlT2ERtDZrVLJqyyEe
	XSDRF9QWMaTVK2cNrpwqHINpSaWsC1pJ1jV4b35knpf3GLO2sGnUs8VZsFiAa/xh
	OdUgoxQbVwyBdO5OjzmYbcNqLR+aoQGRmnohQ/Cf6Z7L1LqcOWiPitRiRh77D0H5
	uLARxcNMe9AbFRHgJdhxHacZVYl1nJSIyXrTzbUhdmKviLTKWsu4Lp0BkoW/XQO3
	lM9rSgK8o3CqFNA3X2zU31d0gEiwvJ3gK1g==
X-ME-Sender: <xms:pAemaAMpGJiVFJ-xiodQmDiyHmydKQfyjW1KUAWdvtOIrHCT8xhmoA>
    <xme:pAemaKMwZBQmGafvJA0DzKMU5hIHcxeGDBqXm5hULI97WVNHP4i0gufcJKqLi1MH1
    4anYjjLZB_p4oKfWQ>
X-ME-Received: <xmr:pAemaAuractRHiUj4feb9_AbWmlrYTm7GZFvDqRDs65dLKttKF9AcAG8026FCqnEk2RgSPTyqFtmoQvMd4OojdWSby7jSARPLP4nNUY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheekleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:pAemaEUxLy6xKbgmn1Kc4EgW3WV8GxnpWhcWn5Y42pRRK-BJiGh4Eg>
    <xmx:pAemaIt5iVwH-YDOs1zyLaClE5P7auAuXsO-GX6HYsFt4mZ9swY9OA>
    <xmx:pAemaAWssu3QbjDuuVZRJGvWTdCe-jt-P6Nqm150ZUAnT0QDWBD0_A>
    <xmx:pAemaLl8agliLSwmOhbNAcnML_6JfdJVEf_tQQzipqdVzzu0okadHg>
    <xmx:pAemaBwJFb4UF_QCg4ztW2CsRIRTWoT9OxbcptdCBvtHIiP4-dtZ5vKa>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Aug 2025 13:36:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH RFC 00/11] Introduce git-history(1) command for easy
 history editing
In-Reply-To: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
	(Patrick Steinhardt's message of "Tue, 19 Aug 2025 12:55:56 +0200")
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
Date: Wed, 20 Aug 2025 10:36:35 -0700
Message-ID: <xmqqms7tao9o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> In the end, I'd like us to learn from what people like about Jujutsu and
> apply those learnings to Git. We won't be able to apply all learnings
> from Jujutsu, as the workflow is quite different there due to the lack
> of the index. But other things we certainly can apply to Git directly.
>
> Note: This patch series currently builds on the cherry-pick infra.
> As such, when one hits a merge conflict one needs to `git cherry-pick
> --continue`, which is quite suboptimal. I didn't want to overpolish this
> series before getting some feedback, but it is something I'll fix in
> subsequent versions. Furthermore, the command for now bails out in the
> case where there's any merge commits in the history that is being
> rewritten. This is another restriction that can be lifted in the future.

Two comments.

 - You would want to honor notes.rewriteref yourself, as cherry-pick
   does not and that is deliberate [*].

 - It is a sensible design decision to limit it to linear single
   strand of pearls history.  "history reword <commit>" when
   <commit> can be reached from many branches along linear history
   that rewrites all these commits on these branches would be handy.
   There may need some way to say "these branches are protected, if
   'history reword <commit>' needs to touch commits on any of these,
   abort" and things like that.


[Footnote]

 * "history edit" (aka "rebase") is an operation that "edits" the
   history, once the edit finishes, the result is *the* history you
   want, and the previous one is to be discarded (except for in
   reflog).  "cherry-pick" on the other hand is "I have this good
   thing on this development track, I want an equivalent _copy_ of
   it on _another_ track"---it merely is an easier and quicker way
   than typing the same thing yourself on top of the other track,
   and does not duplicate notes.

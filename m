Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AEA1E492A
	for <git@vger.kernel.org>; Tue, 11 Nov 2025 20:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762892205; cv=none; b=MwdsXuB7OqP2ueZ4wsw6x/ji5SlXz/ZQNE6vfQtnJ1NyejgfNhJOxG4BhRZAUvNn0mIyWZswjLlfetSZ/E2g8xJMS39I/ZJrDugcLp/iyPytKORBX1S15TS1xgVf6+T6/DhKWDCI4+sqe02LhmD/hh7N4uSLysyA9hzHLwr7JGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762892205; c=relaxed/simple;
	bh=EoT+RxJ4ZxXYtwdu1py/gEYsNkb9T2G3MI4elepf7S0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mcXcxrGfb+UGNdHuSeh3ham61CLbxOfin7/uLadDclUUUbgfzcYuSSXQxVbAVQcrJxPR3pXdajenIaCUrYKFxHQvgGFD1POgAg9h7Adg+onrsf8qaG/VMP0tIHolSsO1yAegt6kFrYH8Z5mtMVnytk2hsnK3Vr7jPF+E6B4YwEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bDSiaBRr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VJDzy6P9; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bDSiaBRr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VJDzy6P9"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 674261D000B9;
	Tue, 11 Nov 2025 15:16:42 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 11 Nov 2025 15:16:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762892202; x=1762978602; bh=I9baAgAnQW
	3SADCoLu/yr7+mUl/xz6Hy//jAnmFcBmc=; b=bDSiaBRrTnqFBEAq/V0PGDEaxH
	mLCJAk2lhXlekL8DCgtoTtTS43B7Mu7RsU4b0O+ceC/nEuiC893LgD8lTGk7hWSZ
	xtlzRZn/RX4zq8QEeMWQVoa4Ajo2Hsnfcvs6CS2yAy6T7DOJKzlT5Gk52OxTkOAr
	swPzuZ4nffC83EFJHMmWXAcVe1Ba4wC/5Yp9zE7B6OceDFiId+338Dy1RQpbM+ER
	iGZRuIOKHswWFvFrYnrRrgXLrI0K1tcx19CKAAm7RDeXGFdjHgytCCS4x+8hNNwH
	/IP747lRaY73BsvqKbe54/3hHOQfgssQVlpWDiA5zMv9Indf6o6Pylqg6zKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762892202; x=1762978602; bh=I9baAgAnQW3SADCoLu/yr7+mUl/xz6Hy//j
	AnmFcBmc=; b=VJDzy6P9U8kdomawgthLdN3tONQUd8ERki87nMZ48QVKzPflIVk
	ysQkgbilIb8/p1Ha68JtryegqwTvURmmJodqaRHOp85+C9i4UkTBwzxCkTk7ebOe
	hLBTICFJuwZD++hLpiZNYg+hRDXzqyUwwL1y3chPEQrdn7Jup04AO/svW6YoUSUp
	ZPjsWP8tXTvmco2MxRIE2jSXrxpjlfS2P2OMvDFfnTp01UHZtEbK/nfrYTCgC1Cr
	OmIBglz6SlmjEW6el6vza4AaCVwKO/wZr6y41n8XRUILo/4UvkQDTkVmTMqGf9Oq
	S61yBj7daESv3Mizm+1Wh+8dp9fFvxFs2zA==
X-ME-Sender: <xms:qZkTabbeUFyYdJ6jvngwjMwr4f3O_zzcyFvDpdbWt9XtU8z-oV1jRw>
    <xme:qZkTabHF_aj5SPmPAgJp_nyEltf86tI1Yv2rL3LpAplQz0HgjkbcTq7YYTmjAv_6k
    VffoSukgTJdCRrmWVgDfY_9We5HJ8mOKSzPJMoFJDI8sMe-yMoriQ>
X-ME-Received: <xmr:qZkTacIGi_h4N1lGnK-Axa6o1XU0HnCy6x9Efm3uweInv_b2lPAFWRPb-WaLmyZHDMEcppTp4SCrT-C78hmSSkWgufUlf9ZK9kk3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtddvudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    grughlthgvrhhnrghtihhvvgesghhmrghilhdrtghomhdprhgtphhtthhopehsrghnuggr
    lhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehphhhilh
    hlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtghhi
    thhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:qZkTaWOMaYTf0Bxt0fPuY2MxIP15hScsuxTie4mmqPNJs60aO5U-3w>
    <xmx:qZkTackTMO7_q1PeVwVaPAPurP2Jw8HrHkZyXPba62vqGoNgFutTtw>
    <xmx:qZkTaa7987XalIjUVCMutyltYXIhGHsGUxjABnlk_LZ8uVL_MZR-og>
    <xmx:qZkTaQ0VwgK0zQgCEFTFgfIWjWiFMNA8BvYwyzwGXF71FDXw4SKh9Q>
    <xmx:qpkTaZyJS7TUZK94yI3ipIpiHh9ZsyqY_3PE0mF7CGqy9MwZosWxzOrT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Nov 2025 15:16:41 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: ZheNing Hu <adlternative@gmail.com>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  phillip.wood@dunelm.org.uk,  ZheNing Hu
 via GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] commit: add --committer option
In-Reply-To: <20251111191508.GA1907007@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 11 Nov 2025 14:15:08 -0500")
References: <pull.1997.git.1762683774166.gitgitgadget@gmail.com>
	<6be20c41-15a0-4732-bd12-4927a59a9f59@gmail.com>
	<aRIoleD6nP-kA4Xn@fruit.crustytoothpaste.net>
	<20251110201136.GB127132@coredump.intra.peff.net>
	<CAOLTT8RweGOmxNK=vKDv8w-8AJM7QUfLBw4WOKeY1EpSVeB6iQ@mail.gmail.com>
	<20251111191508.GA1907007@coredump.intra.peff.net>
Date: Tue, 11 Nov 2025 12:16:40 -0800
Message-ID: <xmqqh5v0wcif.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

>> Sometimes it's because I forgot to configure the repository-level git user
>> config and started development first. Only when I tried to correct the
>> committer did I feel the pain.
>
> OK, this workflow does make sense to me. Fixing up an earlier mistake is
> inherently a one-off thing, and a command-line option is more ergonomic
> than using the environment variables.

Not very much, at least to me.  Fixing up an earlier mistake may be
one-shot thing but it is to correct multiple commits in one go,
which would be error prone if you do so with "git commit --option".
Either "fast-export | fast-import" pipe, or "git rebase" (which this
patch does not give --committer option, but it already knows how to
honor existing environment variables) would be used for that, no?

> Two small thoughts:
>
>   - I suspect what you'd usually want there is for the committer and the
>     author to match. We have --committer-date-is-author-date for rebase,
>     and conceptually I think something like --committer-is-author would
>     do what you want here. But obviously it's less flexible, and I don't
>     know if it's that much easier to use.

I am not sure how the user experience of this would look like.

>   - Because it's easy to make such mistakes, when you override the
>     author (so that it doesn't match the committer), git-commit prints
>     an extra "Author:" line in the output to make that more obvious.
>     Should we do the same with committer when you've overridden it?  We
>     already do print "Committer:" when the ident was guessed from system
>     info, but I wonder if it would make sense to print when it was
>     forced. I dunno. I guess the time you most need the hint is when you
>     meant to use --committer and --author together, but only used
>     --author. But I don't know how Git would infer that case (versus the
>     normal case of you applying someone else's work and crediting them
>     with --author).

Yup, guessing based on what you did _not_ give is always a hard task
for any tool ;-).

> I'm not sure if either is a useful direction, but they seemed
> sufficiently not-dumb for me to at least type them out. ;)
>
> -Peff

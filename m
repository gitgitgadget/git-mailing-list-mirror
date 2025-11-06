Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DF9350A3E
	for <git@vger.kernel.org>; Thu,  6 Nov 2025 18:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762453123; cv=none; b=GapdG8KAGjIcNNA0lz4JbWKKq4TGXwmMK1EjcCyFqNPKJCiZIf4NSYY3mAhIUlerlRM6evUQbF0piq2zWTQDZoidR5YwO9X+20SGNYsb5BcAvtI4nlnKFQvy67u/IJ7QUOhZvosyt/VqJWJjQW7/fAqbR8AAh869CZxV8SDvp7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762453123; c=relaxed/simple;
	bh=1rLMzJQkd0HJvjamg/h/f6F/K32KRacIscW1cQFU/Qo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UkVEAl3LTks0vw2oJyWs+iJGrIy/p/6cQowjTzgya9Y9G/8yCyZrc/W41z246nfL2/l6g0bFqs2z/fQMAVZo7rz6TWW9FNsmkoZAp5R4A9huTAukIqwJyDdf4Ykj5BDvXXcKdaqaF7Qlyx67ofV+xs1JLUMpMbz4UwXmmmcP61I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gE1vFvQw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AlBJHipx; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gE1vFvQw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AlBJHipx"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3B5DE14001FA;
	Thu,  6 Nov 2025 13:18:40 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Thu, 06 Nov 2025 13:18:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762453120; x=1762539520; bh=v8m2N62eGr
	HRFggZvm4MolElmzsr5pYaoN+zUu7yRkg=; b=gE1vFvQwPNVd2RUTFzsk3BEyUR
	LjM7V0KGZzBWNvvbP8nq5eo+6gyOaQGbz8icKuYiIxQ9ggIj1+O45d9JMTi1ypXm
	l/9iw3lncb8qyTC0cs5JM8l18t1NGBf1IVMN5/jQhqCfWNNyAU570YL+MtvoVBMF
	Rl0iN3W0OAhq7x15WH4nj3AtTXOvBsQ86n6aNzY3D3V9KRdwuFX0p989xiVBu6eO
	BmxOLgARpVQkSBG8h5EjrSqi/l78n3hi5DsfPeXGEkAaj+TRgYPzip4h5Kr+bTZ6
	CXQd3ZKH3RgAAwpoVtkx7D6AYo8PrV5mEYQGn2wbjEw1OX6chj6PkC2j4Pyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762453120; x=1762539520; bh=v8m2N62eGrHRFggZvm4MolElmzsr5pYaoN+
	zUu7yRkg=; b=AlBJHipxm/ZkeV+6M64wMf3UCe/riF4SQQ806YgBGgGRRT05L7C
	0yNmTy2VXOm2qMVP2n3nx9Eva0rspVI+MUxZRy1vlBFafZIZiIE7SjTmor4bE10I
	FyJa64sSI/pvRK3lraaHuYFWyvkZXMzQNCHFNIrhPZwqAEy+P4oHEqsIbfPDDOaa
	hlo9fLRJNZKM/h2JXJ3G94VvprfwtdDlTtS1y0I/gYVIxyUFoilQxxSWeYcHMhX+
	kQgwNqcnAew9zdYwHzDZ9E/IenJCx92F7U0flfpyTmbKVTTLUtvSn7FdIq8Isnjh
	ANp0PSeyBShe9hfkn6OAOaBdI5EruPPttYA==
X-ME-Sender: <xms:f-YMaZ8lLUJM4Tw8VMU5XXYVITqK1DVP2gJiwm-E-pf8pXonT2fIEA>
    <xme:f-YMaUnFxmhv8uMnNs8fYvH6KSvXH2kv0x_3Bl8jVFDbVx54YRIzdY4gEZETUrbbA
    GMYCRvKNa8X_sijs9CGZ7xuZmidBZ9Gny_0MhSqyxNTQWvJSaafNg>
X-ME-Received: <xmr:f-YMafUoQAIph2W3sh6rwHY-b-6n50tD9fZ_P6ZoydcTTazhPL5cojZL8GiPenxkOO31tywStehKl-q9f_r9MF22-DQ2pyQ4sYTV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeejgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    phhssehpkhhsrdhimhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:f-YMaZG4mlczjEqdeWqWuWk6Cn9xW-pId4ftnyKHpQt6nRpXc2llsA>
    <xmx:f-YMabeYdGeFpe8pjzKMxRa67nIQk-_rFQ01ToI3UeQOB9Xk3w4d3A>
    <xmx:f-YMaaLJiUybl0lw3p2ysq3xx8e2_eeusqSDkJg9IztaFikbKQmtkg>
    <xmx:f-YMaQGuYxW10rCCJM7IAYofabHqLfTF2XKw-11qE8QxeykZqPKFzQ>
    <xmx:gOYMaQUa7gStuh_tCnK-Pz8gst2WLeROnvY32wOCoJrAEOwa4Q-ekSm7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Nov 2025 13:18:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  jltobler@gmail.com
Subject: Re: [PATCH v3 2/5] reftable/stack: add function to check if
 optimization is required
In-Reply-To: <20251106-562-add-sub-command-to-check-if-maintenance-is-needed-v3-2-d611a2a95cf5@gmail.com>
	(Karthik Nayak's message of "Thu, 06 Nov 2025 09:22:31 +0100")
References: <20251106-562-add-sub-command-to-check-if-maintenance-is-needed-v3-0-d611a2a95cf5@gmail.com>
	<20251106-562-add-sub-command-to-check-if-maintenance-is-needed-v3-2-d611a2a95cf5@gmail.com>
Date: Thu, 06 Nov 2025 10:18:37 -0800
Message-ID: <xmqq8qgjhvnm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> The reftable backend performs auto-compaction as part of its regular
> flow, which is required to keep the number of tables part of a stack at
> bay. This allows it to stay optimized.
>
> Compaction can also be triggered voluntarily by the user via the 'git
> pack-refs' or the 'git refs optimize' command. However, currently there
> is no way for the user to check if optimization is required without
> actually performing it.
>
> Extract out the heuristics logic from 'reftable_stack_auto_compact()'
> into an internal function 'update_segment_if_compaction_required()'.
> Then use this to add and expose `reftable_stack_compaction_required()`
> which will allow users to check if the reftable backend can be
> optimized.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  reftable/reftable-stack.h       | 11 +++++++++++
>  reftable/stack.c                | 42 ++++++++++++++++++++++++++++++++++++-----
>  t/unit-tests/u-reftable-stack.c | 12 ++++++++++--
>  3 files changed, 58 insertions(+), 7 deletions(-)

The required change is surprisingly small, which is a good sign.

> diff --git a/reftable/stack.c b/reftable/stack.c
> index 49387f9344..826500abed 100644
> --- a/reftable/stack.c
> +++ b/reftable/stack.c
> @@ -1647,19 +1647,51 @@ static int stack_segments_for_compaction(struct reftable_stack *st,
>  	return 0;
>  }
>  
> -int reftable_stack_auto_compact(struct reftable_stack *st)
> +static int update_segment_if_compaction_required(struct reftable_stack *st,
> +						 struct segment *seg,
> +						 bool use_heuristics,
> +						 bool *required)
>  {

Am I correct to understand that "use_heuristics" is almost a synonym
to "maintain geometric progression" in the context of this patch?
Are we expecting other heuristics in the future, in which case, this
may not be a single "bool" but a set of flag bits, and until then
s/heuristics/geometric/ might make it a better name for the
parameter?

Thanks.



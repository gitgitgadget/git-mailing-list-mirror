Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132C7524C
	for <git@vger.kernel.org>; Sun, 20 Apr 2025 21:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745183560; cv=none; b=erQqxWVft+pd5x2E+ooCakXcMEI2YVGBOtXc8dmvDVX2yRvUUEV821nFwTO/KJ08q9JZ7xHJx46FIpxVS/08Nrsmy8m1Y70up48JLwZpjYBZxY4mF5+dr4o+vFPswYnCuAaEtrR38L7D9GYnyN4uEpcOWl3DkfI9ZFzn2zxPWXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745183560; c=relaxed/simple;
	bh=SqX3qGp0uylfQCGW29ec5CVxhOTyhmOE7bQWMe1C4lA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cZQuTBikiyTbX6RhWFHSDCFVnyAmUXNrlCW7ISZWYfCSV41yfziAf8WPW6jZ/1kzkXL4EXDhvhA/6eIZT4hhh6JU1OWCLQQR5KUSYHI+TvmoablGcUWFxyw4x+KqVz+hkkcYuqVY2R/knfa43LHbPUKJpDKUmShA2SEI0dmqyB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Nx0Qm1fx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ck6xjwK+; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Nx0Qm1fx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ck6xjwK+"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B28052540158;
	Sun, 20 Apr 2025 17:12:36 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Sun, 20 Apr 2025 17:12:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1745183556; x=1745269956; bh=XjrB7krSWP
	bjwnoJ84mygxZ168w8FqMQFvffhjrR88E=; b=Nx0Qm1fx0uHtyoWxKMRfRF5VPI
	AfhOAbJdRhpArsccjuzLu5etM4OUKdXQYEEa/egbrv298kD0Lq5YY0G9t3U4y2so
	AdhmPdXdB0n1yXSzOveSCwJciAGb4+DHmmcbpTRmGGvnLFIpie9bHIgFD31yPRU7
	8MHiE+hr/y81mWuSkdP7CSdJwGQyV9R3yhD0hCpuVyBlKqxltvBwdfUUXZO0XviH
	f3daWMPrqfg9D98SEkX/PI+dFTznVMnHIudq6PvwVJrUshzL/aZYichJEqUEpccv
	XvfQQmLYZEw69DBxO/yA+E4573taDM7/5mPiwyt4bR1CJ3b8kU425yuVkVqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745183556; x=1745269956; bh=XjrB7krSWPbjwnoJ84mygxZ168w8FqMQFvf
	fhjrR88E=; b=ck6xjwK+85nAN2IPA2+adpn4yWSfpirXzuphG4mxozrgO7Pp4aM
	hrWzjWsFvt4fYBomxwHcc5klbzjP6UY/QvAKLAOVqXhG9zun9AMQNaiq7idAt8gv
	0g+SKTqrz0C6gRkbC1RBB72nNmG8krNS52KH2S1ZECqRMcsVPHANSHm/s5N6E/Dp
	oE5Xe25Kut70dhlKd06WwuduBJ6g7Ut6lUygtJ29SsLxyJz+qEEsABZzvTzWWs7h
	Ttu24oNerKY1qvjb4oOd2IsfPsQ1vz0+Zsrf7UWfbPXdgwXRYvdIMOtI3O+kMitR
	Ug+KFiHlPRI1FIA+NqoaG8yGR8Wxefc+DpQ==
X-ME-Sender: <xms:RGMFaOMwZev8A6mbTyjnge9m7lWFKBM8Fy-s7p5FQCXJ9nufhcHr-Q>
    <xme:RGMFaM_eO1dlr7RLqfDXdMX5m7-FjG910niH0Pf38DuY4WysVzRdtAydKfMlVYxYf
    0nOiXZIeoFvjKMfMQ>
X-ME-Received: <xmr:RGMFaFQw4M6dCXkexRvcyh4ROJPIPbX39zXl6IsAbX6V2h9iG47kFdQV1B_PXAPT7DDLv3JMdzWWA12n8ljfAxOWgVdCDP5nRpG8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfeekleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvg
    hffhdrnhgvthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epphhssehpkhhsrdhimhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghl
    ihhnsehgmhigrdguvgdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:RGMFaOt3MytOy_GZytvNXvcbhRr5EEvGcSAVmE_lknR99gg1mfvEdA>
    <xmx:RGMFaGf1jjUHhjghHGhlKLZKPNHKOYTw46mKHApZ1xjhMNIyS5FfQg>
    <xmx:RGMFaC2jM0zgbxag05yU4fcl9IUorhrYljQjL6zQyClqhsrgPVHS4A>
    <xmx:RGMFaK95sLyMP6Z9kxsKtT4yuJoE9E4eRlZxjljRGdy0bU3_Os_ieg>
    <xmx:RGMFaMgcTC291zHxQWxbRO49ekj9T6x4aFoxTAQWaG1Vd_PKNVKHEEFG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 20 Apr 2025 17:12:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Johannes
 Schindelin <johannes.schindelin@gmx.de>,  Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] perf: do allow `GIT_PERF_*` to be overridden again
In-Reply-To: <20250419035407.GA93039@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 18 Apr 2025 23:54:07 -0400")
References: <pull.1900.git.1743764167548.gitgitgadget@gmail.com>
	<20250419035407.GA93039@coredump.intra.peff.net>
Date: Sun, 20 Apr 2025 14:12:34 -0700
Message-ID: <xmqqfri28rlp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Fri, Apr 04, 2025 at 10:56:07AM +0000, Johannes Schindelin via GitGitGadget wrote:
>
>> However, in 4638e8806e3a (Makefile: use common template for
>> GIT-BUILD-OPTIONS, 2024-12-06), a subtle change of behavior was
>> introduced: Whereas before, a couple of build-time options (the
>> `GIT_PERF_*` ones included) were written to `GIT-BUILD-OPTIONS` only
>> when their values were non-empty. With this commit, they are also
>> written when they are empty.
>
> It doesn't look like Junio picked this up, so I wanted to chime in that
> this regression bit me today, too (specifically for GIT_PERF_LARGE_REPO,
> but also another variable which I'll detail in a moment).

This was lost in the cracks.  Thanks for bringing it back to our
attention.  I think what happened was that I saw whack-a-mole aspect
of the root cause, which makes this "the tip of the iceberg", and
felt it was more sensible to wait before a real solution, like ...

> So I think we either need to rewrite the "run" script's fallback code,
> or teach the GIT-BUILD-OPTIONS writer to avoid mentioning unset
> variables (which is the real source of the problem in 4638e8806e3a).

... this was raised.  And then I completely forgot about the topic,
as nothing happened since then.

> ...yes, this is definitely the tip of the iceberg. I don't mind doing
> this patch as an incremental step forward (and because it is an
> improvement in behavior even if 4638e8806e3a were reverted). But the
> issue is far from solved overall.

I do not mind it as an incremental band-aid.

Thanks, all.

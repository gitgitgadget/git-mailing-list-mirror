Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD34226A08A
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 22:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773440486; cv=none; b=g57rAq7jj+zjmEABi4m05WhLZo5DAT5TKPq5M7lN36qRWk6Z6y/UJDRHMHCX38tFzTY16eRLYVNfmNa9VA7AwHAimKs5UBPi7GbFGbF8dbx+k3vSJ8xl2VLGKwQ2ZBkexO57nwiHCXp04v4Fl3T45t1aUFALpfKjPPfVDgxzIXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773440486; c=relaxed/simple;
	bh=TcCMgPDvvNc/mDSwUA0f5NnRFwK5I4KmS5paFb/UCu8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gM6ch4bxgf6KVuOLBKT0muIRt/LxpXicR1E/b7KJA8fSjip5xKR5wZIhooqMbNWqITBUBZaOofGxzskq9GKCMohrgaJfeYxXY9n69eOpQS9WTNu9yMg+k+L874RA5KfoNtlef8XwWSqmMYEt+xE+oYa/XY8Lam/I8vsdLbFief8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JxpQL9ME; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nsEby4O/; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JxpQL9ME";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nsEby4O/"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id A9B431D001B7;
	Fri, 13 Mar 2026 18:21:23 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 13 Mar 2026 18:21:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773440483; x=1773526883; bh=Q77cBst6JL
	B16l8ZUEVX36drip38IuhNYQ6KDJRJ+UM=; b=JxpQL9MEvOpj7QQVXtwu7jvfTW
	qxiwPeDM8Iztbe9L4QyNGBDHZdvdUmUVW/b5RaLugfBKbS6Vv4R6JL1wwB4mqMeL
	CgSpMa5rKMSBQBTj47Ic4borNy2xfD0k7ZFmeo5N1On0YtK1KD6tHCSxFk5HI49G
	IXZisZG/lRIZMPtdF3QjBY3ex1bxQ+mC1y170+K9er4MWelLfEs58XK3mvdFpmqb
	j0EPfuPdFxNoGXzRA9lFzBPlzR8/Bmg1B0ZqTTyXqrK/Uj9swaWY5HtJtPk9Kf70
	cUoEC8KT0K6XdvAGdOXdvsV9VlDuBPbxeqcN755UcxHvcf9BpVQNyXJ9LqcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773440483; x=1773526883; bh=Q77cBst6JLB16l8ZUEVX36drip38IuhNYQ6
	KDJRJ+UM=; b=nsEby4O/9u47PajDvc6EI6lE6HZdUyYXAKcwVMH2RVJV37RLBy8
	7PWBIla3oaCXNp9tCFgTO2lsvuOmD09mqft/3RgyDIYFUzTHw/iBO2ov/28cwKB1
	txOLaDoFelrpIe9i7EXM4ZG37eOQb8RHD0bR0ibcp9Y82BKA/1Sk1odMZxFQgFtp
	PQH08dyxFBQ6YfJemJ+MdhIEVcE4fDup2Rf7ap3zIoj8hSMS6bHCWtch1ZiwHBTY
	VVD/7h/1Kt/6DWTm1QbawVdcnw3pUZpmxvjcA9SagSIi5wcD00pFC5II21ZWCFhL
	ff0cVxWT0WozIyA/QvTf3xn4ynO7UD5Hwrg==
X-ME-Sender: <xms:4o20aXKdHSRKMbwgiQ77ufL89ocLYyr0cZAWbJclXfdi1mHb_LerBg>
    <xme:4o20acqfyYL__O5Jyo8_VW4eYN7IHRIJK0KvArTVgr6rK0WV8eYQCKZMVqhkPMO-Y
    I4KecMmrO7ZAs59P857ssr7wQWAE0goQd55EYQ0NfOKmSHzVis9TQ>
X-ME-Received: <xmr:4o20afxBtoQUnRXt40gz0OtFV3ijr3BlwtpwOLV_7FBhF3GgPOy6Bw0ijxE14o0P76I7iIqqyvLrrIrGvsZqHLg-851o0AuY8Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvledtkeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdroh
    hrghdruhhkpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehsiigvuggv
    rhdruggvvhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:4o20aQPaLqGyI5N7pjvQ1vnjCVZVP3P-BDmwiEaOBdX0EzKTta0yhA>
    <xmx:4o20aU7NzqMvqY_WCNmMl_9sW6i9bX8LBJbK6Q1_hOrTU1eEtIuE3w>
    <xmx:4o20aZm_2mruQCzaA05J3xawmkM7B0JUlatVIv1tgciaU0ynQoIY1g>
    <xmx:4o20adRkFp-FWIimfl0t3HezDF0H0ONlFVT90eEILVHRfPY1q4pGFQ>
    <xmx:4420adcyPmK31xM-6UDhFxX79Vi7S06M6tqy0P15tfsfMGLL_HxjwkRb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Mar 2026 18:21:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood@dunelm.org.uk>,
     Patrick Steinhardt <ps@pks.im>,
    SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/8] Some build system improvements
In-Reply-To: <20260310-b4-pks-build-infra-improvements-v1-0-ec75d0710d6a@pks.im>
	(Patrick Steinhardt's message of "Tue, 10 Mar 2026 18:52:33 +0100")
References: <20260310-b4-pks-build-infra-improvements-v1-0-ec75d0710d6a@pks.im>
Date: Fri, 13 Mar 2026 15:21:21 -0700
Message-ID: <xmqq34232wwu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this patch series contains a small set of build system improvements:
>
>   - The first couple patches introduce a new "tools/" directory that
>     contains items related to our build infrastructure and to our
>     developer tooling. This finally follows up on my promise to do this
>     back when I did the spring clean of "contrib/". [1]
>
>   - The last couple patches introduce precompiled headers into Meson for
>     a nice compilation speedup of ~30%. It's 
>
> The two topics are not really related with one another other than being
> related to build systems. I decided to throw them in the same patch
> series though so that I can introduce "precompiled.h" in "tools/".

We saw a handful of exchanges a few days ago, but are there any more
comments?  Is the topic ready to advance?

Thanks.

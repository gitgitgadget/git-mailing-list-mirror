Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1131113633F
	for <git@vger.kernel.org>; Mon, 30 Dec 2024 13:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735566412; cv=none; b=aGkNrDkhig6Rk5mWEWcIrRnv0rXpoqogb0SzQq+UU47AEKSPOr5pFgGHqOtgAM47IJHlOfQGEqYaNAqmnw3UaFi/16iRI765LOv3ZT3FiQ5Qyk/p+3wIawkoNlYyb+YRAwkmltmtwbYUnUXKeoRgPZbMDbywjX6Ydp6idOE56Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735566412; c=relaxed/simple;
	bh=5Jm2I9A2OssDZirDwAlkPbwwWPP0t7W/oBZY6yS7pD8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CyNTz+868GaM/wAeO7G9s7JY682SFT7o3nfLq/YXi9n/pNEqca488euBBMsEo87HF5cFlUhlQFfnxTeCxW+vWTXkkhFQec3+nFYPViN12nPtot6M+Dsg5Vde0Gr6jpUGZdT2D8vI0k3R4XcEKBJ7t2oAgHlY8ct9fdgGOLZuLpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=4CeLsdO0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oTj3H9OX; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="4CeLsdO0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oTj3H9OX"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1207A1140121;
	Mon, 30 Dec 2024 08:46:49 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Mon, 30 Dec 2024 08:46:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1735566409; x=1735652809; bh=S+QuM0oeuX
	bN+jMFtKPQIb+9pECBDU9dII3+Y4vEK3I=; b=4CeLsdO0pqLTU+FB7RFI4Vm1LX
	tNZhz6uW+sq2UEuGRcnejkQla/L6XVk6fhhY8Mr1wJiu3wWkAor0Bc7gT4UtgIEr
	/K1ys6IdxDVYq5FD5iXsAxDF31PWyOapzBt0EfOr6661hGB8JsxT2idA9quSkOYy
	DSoUd+eJ6aw3QsDmKkBzOB36Ud40NDZMwQXPpAAdjUgYtbNx4dBfM/JCW5yqC+fe
	VzOrDW840b+LdOLo3VedhuvUY3EoqvGVnw8guNKPjUpvVjhOSYx8E1hjw82Cy2ZO
	YgPimv5QahZcji4Gm0YEqVVwZs7AH+ve6N1dZ4vS27D812nU2qgeSYlWgJ7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735566409; x=1735652809; bh=S+QuM0oeuXbN+jMFtKPQIb+9pECBDU9dII3
	+Y4vEK3I=; b=oTj3H9OXIk6jeBXoNaQabwioEn+BedMfj6LwuPhdB/5XlhnS6+R
	UYHpIKElNWQCcW/kpXsuoulhOnaJMFpDcsgWTynwyOjXktq/8wLaOc2MlWTRHcGA
	7R03ygjP5GeyCa1X1VM2yzP6L7m/hDiK4yXjNy8BORjM630JBRpMvAYBqdTIZw3w
	Ki+FbQKhgmk+Kg5bDVqHmbwMKGyx3VPVig9FZ9/TtOS3tnomYleTWdcr8esby7U+
	PjbMM1YiHhGMj/iyQr/FMJH1oL9j2IxUQp3L6jP4wGeX82XKGT2sNdCyyZ5evpRk
	NWdjO53aUYEC+Pul5C6iOoUilQ5O077d/aA==
X-ME-Sender: <xms:SKRyZ98BDv_R0r0VVuztyT_pkFPfLp5CybamsnFII9FKTq_EV9MCEA>
    <xme:SKRyZxtCL5LArA6vdDWOzLvj0Z3yLP6Z_ZnbfE586HGoFUZRDBHeD2a1tJyQydwzy
    sDShxiUfIqJGOJ3qA>
X-ME-Received: <xmr:SKRyZ7C_xwUKXDbOI1J58Y9RYN-U2ib8sbIhji4i6yfBW1c83JKb1vKXD5JbKSmnaj58hS4ueptj82hGEv72aBptTjMhiJYcSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddviedgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffh
    drnhgvthdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopehpshes
    phhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:SKRyZxcqaIchHZo2kvT1k64NOfov10cegUly0qrIMNhEM7VQcvPtrw>
    <xmx:SKRyZyNaojhuiOS2vnI_5UiFA3fLhCAf155eSSyWhAyzpEsByn5HNw>
    <xmx:SKRyZzlvRu2QzEhlS1QIfkm62UxZ-AX-Di9fr0srwnLuoPGDgRZ2fA>
    <xmx:SKRyZ8siFLi6LDLqy4VdA2BG6QW7fRKI3vY0jsR_kPlB4SY1-AKE1A>
    <xmx:SaRyZ50vwsNr0KtRGg5Ht3wNPkFsEk5ssgCaib9WXbLeC3D_QAWG1JIu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Dec 2024 08:46:48 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  Patrick Steinhardt
 <ps@pks.im>,
  git@vger.kernel.org
Subject: Re: racy leak sanitizer builds, was Re: [PATCH 0/9] commit-reach:
 -Wsign-compare follow-ups
In-Reply-To: <20241229165715.GA3158370@coredump.intra.peff.net> (Jeff King's
	message of "Sun, 29 Dec 2024 11:57:15 -0500")
References: <20241227-b4-pks-commit-reach-sign-compare-v1-0-07c59c2aa632@pks.im>
	<xmqqbjwwucvy.fsf@gitster.g> <xmqq7c7kubx8.fsf@gitster.g>
	<xmqqbjww65i1.fsf@gitster.g> <Z2-2dbYVuuLxpNmK@pks.im>
	<20241228190541.GA815586@coredump.intra.peff.net>
	<20241228192307.GC815586@coredump.intra.peff.net>
	<965bd864-3ac0-454f-b7bb-f8e0214e9969@web.de>
	<20241229165715.GA3158370@coredump.intra.peff.net>
Date: Mon, 30 Dec 2024 05:46:46 -0800
Message-ID: <xmqqy0zx1dx5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> One of the reasons I hadn't sent anything is that I was waffling between
> two approaches:
>
>   - implement barriers everywhere and just use them. More work, but we'd
>     have the tool if we wanted to use it later, and all builds behave
>     the same.
>
>   - make a "maybe_barrier" interface that might be a noop, and let most
>     platforms compile without them. They are not needed for correct
>     operation in most cases, but only to work around a sanitizer problem.
>     And it is not even a problem that comes up frequently; it is a race
>     that we occasionally see in CI. So enabling it only for our
>     linux-leaks CI job would be enough to dull the pain.
>
>     And there is no risk of any portability or run-time issues, because
>     the code is a noop for most builds.

I love when people think before committing to an approach, and after
seeing these two cohices, I tend to have slight preference for the
latter over the former.  The work will not be wasted even if it
later turns out that we need a full-blown barrier implementation for
other platforms.

Thanks.


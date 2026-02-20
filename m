Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140A015624B
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 22:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771628123; cv=none; b=Q+kpriqR4MK/DiXRz2ZClrxIrXWMrmWtOBfCQjxjnznpTAseCX6KEU2Lye1UDiA98V9EvwcFCXePN2EfcSDyuQQ5KlJO2BBFYmzTgFxXdlH6H9rkeeBc6obl5wtJqEKwi3gKw1mwtzg8bk7+jSOn7yookyPjxYJfPDpxKTfy67o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771628123; c=relaxed/simple;
	bh=FHWN+ZyJd4fIcvvsTaqQYISCgI9XjjEHCH4ug2Jy+uw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UePsluxwc8fqL2ie8s1D6aiNbwFxyP/1ZSd7fCt2WLMDMwkX2BUZ643eae5gGjqUNcFQ1vCsMDoCBiL7KnBabfe+QJqO1GcTEUD0gPYe1A6rS+3BTIusCuoKrByKM8y9hE53cvJnkw5+YaIF2mjcW3ruXlIKxwjjzJs5I7dVo90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=xH2694U3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u3YAjxtE; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="xH2694U3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u3YAjxtE"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0658C7A00BC;
	Fri, 20 Feb 2026 17:55:21 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 20 Feb 2026 17:55:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771628120; x=1771714520; bh=fjRyC+Fx1Z
	3ZGMM5ZkbDP89ZLL0GrbcDhUlhC6BFPxE=; b=xH2694U3DRbPO76VVb+tkSBjC9
	e8tpRZ1hqDNbZuFCHDE7X7XumITi+l5sU/8Tv1QSHAo4EmK/jY1wu/z4/F/Y0EBH
	Qukgxmj3TgqxjelFmpZYcyiGq2I4JBCCxo+lZ6lLg0gaDDI/Me35MOwIpf1Sv5Bg
	6zN01+4pE+Ci4En1JQ6GybAy9gVXf9Hv/4DKO6EYtgKUSEYDvryovUcH2iTMha/u
	HokmsIZlE0nblC41PwKqfi3tCIODAvlNQNvfwK9IwQu+qCkHN1RGC86K0MmKBGuf
	tLwe9wx2UTWhEn9DQIA4QcHvVEsGAZlOglmLclKzEM2NlV8GfBfx8UPnyGMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771628120; x=1771714520; bh=fjRyC+Fx1Z3ZGMM5ZkbDP89ZLL0GrbcDhUl
	hC6BFPxE=; b=u3YAjxtECw42KT8bc08j0OHx+mOESYSMTW+NRrW/NopINNwjZWf
	npmz6oLgvm1dYSE5VCZn3iP7BC4O0tq4w2C+F+udGWR5h0w4SQgsITbjqJZKGxLA
	JBpQXjAxQQCHyJHalN406v4CMDSxM/3MRw+NwBYu6b8N8Z+5sFEzIa6Kh20DqfBw
	fmkUNEfdzc/dErUjQqfe8eQyCA7lpgoJA8wao4LUYPKQJObsqjRgG9F1M78+7Mpe
	lvERPjUhVGIrXmG3NQAYDp2tN/OANUWYBgSlagVOxNsYZl0V2Px0sejPUc+BBG48
	OeKPDxZWFKNlraK/2PSAGNohbNUbVjUpwOw==
X-ME-Sender: <xms:WOaYaafR8_wZdoDJY0ofs_v2sXKhMKe_iYNQW9e3ZIr9g0S9aLocIg>
    <xme:WOaYaX6PkdE2sPwMsQsa6_6QZ1lZ3jK0NUI-glz4Areyw-l8K7zwDm6xXG6ec4tCY
    xOAcZnbU7ozYCwP7AQQV92UvsCYHds4watT2BO8OPdtuetGju7g2g>
X-ME-Received: <xmr:WOaYaVWn0NYKix13ZfgaPD1HTCKYscfkrpz9iAkOsdFCDHQGroT9TtXdq80rgU-0NDMhiWOZRLHlc5O8QbIo9ndBeDwT05shXQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdeljedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnh
    gvthdprhgtphhtthhopehvrghiuggrshdrphhilhhkrghushhkrghssehshhhophhifhih
    rdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:WOaYae4Md8kztmft8ShBsvEUR0xxgz6yjw7-YZXyCRkXqiEep1-gfw>
    <xmx:WOaYaYokLHMHJfteW9KobUNJ7vhdr4P03DLLpI_VDSfQars6WnH62A>
    <xmx:WOaYaZmpB53baWo_-sfboVsUus3WQy6KD2vj0PaaI_R2e_zXnm9NGQ>
    <xmx:WOaYacMit9PVlzLzP8lZQYPB9BIrekoFnAmYZLwq_v3uwIZPuNLxbQ>
    <xmx:WOaYaZUS_Xakea1iXYbEorc5xJA30BDqfq2-OKCnHTy1y7xSUngiaySS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Feb 2026 17:55:20 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Vaidas Pilkauskas via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>,  Jeff King
 <peff@peff.net>,  Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>
Subject: Re: [PATCH v4 2/5] strbuf_attach: fix all call sites to pass
 correct alloc
In-Reply-To: <f48b1f07c45f6237f91fa6f746c58b791edef5bd.1771423748.git.gitgitgadget@gmail.com>
	(Vaidas Pilkauskas via GitGitGadget's message of "Wed, 18 Feb 2026
	14:09:05 +0000")
References: <pull.2008.v3.git.1771326521.gitgitgadget@gmail.com>
	<pull.2008.v4.git.1771423748.gitgitgadget@gmail.com>
	<f48b1f07c45f6237f91fa6f746c58b791edef5bd.1771423748.git.gitgitgadget@gmail.com>
Date: Fri, 20 Feb 2026 14:55:18 -0800
Message-ID: <xmqqfr6vuisp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Vaidas Pilkauskas via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> - mailinfo, am, refs/files-backend, fast-import, trailer: pass len+1
>   when the buffer is a NUL-terminated string (or from strbuf_detach).

These are good.

> - rerere, apply: ll_merge returns a buffer with exactly result.size
>   bytes (no extra NUL). Use strbuf_add() to copy and NUL-terminate
>   into the strbuf, then free the merge result, so alloc is correct.

I am not sure about this, because this will result in unnecessary
reallocation.

For example

> -	strbuf_attach(&image->buf, result.ptr, result.size, result.size);

This would have resulted in realloc(result.ptr, result.size + X) to
preserve the strbuf invariants that len + 1 <= alloc inside the
strbuf_attach().

It depends on what the system allocator does, but when X is a small
number, often no new memory needs to be carved out when this
realloc() happens, and all that needs to happen is that the size of
the memory region recorded by the system allocator is adjusted, and
the program will keep using the same memory region plus X bytes out
of the slop that has already been there when result.ptr was
allocated.  We will call realloc(), and it may result in a true
allocation and copy when X is larger than the existing slop, but it
may end up to be a cheap operation.

But if we rewrite it to do this ...

> +	strbuf_add(&image->buf, result.ptr, result.size);
> +	free(result.ptr);

... we will allocate as much as result.size and copy the bytes.
Guaranteed, regardless of how much slop the system allocator left
after result.ptr+result.size when it allocated result.ptr.

Of course, we could rewrite the original to

	result.ptr = realloc(result.ptr, result.size + 1);
        strbuf_attach(&image->buf, result.ptr, result.size, result.size + 1);

which would avoid the extra allocation and copy when there is even a
single byte of slop after result.ptr+result.size, but at that point,
for the sake of simplicity, we may be better off with the original
implementation of strbuf_attach() that automatically does that for
us.

So, I dunno.

Thanks.

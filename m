Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD11372B25
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 18:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774981599; cv=none; b=WtbDxG6Pp0/wQZpJFi3NzcJNNHAumhPfh6WD39OB1A5GqJJRIBNEMLyz8VKRBTiUvZDGUiCfv/7JdWrN296mV8+DLjrIEtAg21TXigD2oRstDz78PzkUpBxDxJVHdTkTkCt2US3y4IPfvVNvVkHKNNmrw6bzTAYpQoKbzW5inZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774981599; c=relaxed/simple;
	bh=4lH2uzdY8MtoB/5K8uuYJ5BunxAdCkWLgdhsNsA5nYs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rSJd1uq/vVZTflF/C0O1rcikpmDe9xjaOpcseMEaFHb1aazScPsLLOrx564eCm0MWSxddfu0xCvxX1/BpFF8fYVTFqYbvnuA2Bt6Kn9xLZmw+KX4fMAyxr1HoRkOWp7nnKa5BfHdgBk5cmZGbpc5az4WTR3fxTLsoy+LCEljzLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vugyxgdx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CgmvLJ2O; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vugyxgdx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CgmvLJ2O"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 801881D000BF;
	Tue, 31 Mar 2026 14:26:37 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 31 Mar 2026 14:26:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774981597; x=1775067997; bh=ZM/RnLempR
	DJbdHwsu0meDUmfcTJmSRAnmNcOBr3aJM=; b=vugyxgdxmgX+Uvroa/5mLk626l
	RicAZPjLA4wOx8d67G7fHvYcVbJIsC64P/OjZ1GE4Kmygfh89ceFWVaxHJfx6ZwS
	EF7KMuZnrgohTW41KHV2219xfQcEc+gVpw7NNICyUWK8sMlP/xZSXIgwbD9OORpg
	GzvxSYBQKSwM7UfHyucYN5AHm4M4zOZnpU48gRwTKeU3zqFHSHMRl/m+AgmbpPUT
	/PFpKbd/MOWIXmwevUwWZb87bBa/FJ5Pm6/ti806Sxplxnb6AI5J0MTRBXkZYkBZ
	XNZZWNhS8C9gSBYc4SlsqUzi9+6X4gM1riQgsnq6aGfOpvRcU4G2jgfbFuIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1774981597; x=1775067997; bh=ZM/RnLempRDJbdHwsu0meDUmfcTJmSRAnmN
	cOBr3aJM=; b=CgmvLJ2ObtOnUfxpfk4eXW8Y/0iDCjbNg8MyIwmnQSSQJDqmJjn
	H0Y8Vie4Sv0zwzBz820PGz7c6sPmSwxuIXPUWVwa98173ZwKZ5nBN8QpSfp1NZ2T
	JW+0WkFvqcd7osaeh/w1XFVvDfa+pGDZLXohQWkL3QMMGMgahKnykBCORpctSjWL
	doBbpKFnv48Tb8EJVRnIp/5MK8XkypwnLtUlVsE3J0RBazixmHbJQR3L9FFciiNq
	bNtB/OjmR83ujU25zYbgkQMt4NCXAwBCPnyyUaMWam8S8FMSFEfa/D7NlDGPoCyV
	ksGXl9XRPsaw7YfHA2uHWNJcOX+CpmXphTw==
X-ME-Sender: <xms:3RHMaYaKZB7_igA3KWGWv2a4uG9Mevf5i3OHdNAzPYKXxuY9dOrzUg>
    <xme:3RHMaa1Wnd5HzcNenSxPwYeuH56abvqZ0t3p05tE2jl-gW6CNtUz0H405jtU1Bmht
    YRtrHY33KFHooYbHVDQaOJjJZYgUQorn-4IZ-9AdIlZRlOc3MXq_g>
X-ME-Received: <xmr:3RHMaQVe10ZAUQAswpP_axk542uHSeyQffuPMZwp8qFLZpsrcbnSDpsoVYHCkfOX2NKssRDNQPBE-20YXUj5GgwddY45ea_FBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    fhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfj
    rghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrh
    hnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:3RHMacUJkpNdsaARJroko5F_0k9j-P4fwmfrZmMmfo0WUfMu43xHBw>
    <xmx:3RHMaXei8ksJaG5FSEBAzL1ONEzss8TRpvzjXU684NuSiLiRW2bgPw>
    <xmx:3RHMadWXi1bLFdiJNZUm4UJ3nSSWlqTFb4rrxjiscCWPLA-m4-6BWA>
    <xmx:3RHMaYcNCGBCLeF2yQ9jjXOn8xGcwzPkD9fy1Nprtg9cu6GAI0NH0g>
    <xmx:3RHMaS-fctwadhGkFTDwtNCB7yY3sq3oXF9PSnv7DY7QWaDoqkN6whbx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 14:26:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 6/6] reftable: introduce "reftable-system.h" header
In-Reply-To: <20260331-pks-reftable-portability-fixes-v1-6-46bfae55c68c@pks.im>
	(Patrick Steinhardt's message of "Tue, 31 Mar 2026 13:26:52 +0200")
References: <20260331-pks-reftable-portability-fixes-v1-0-46bfae55c68c@pks.im>
	<20260331-pks-reftable-portability-fixes-v1-6-46bfae55c68c@pks.im>
Date: Tue, 31 Mar 2026 11:26:35 -0700
Message-ID: <xmqqwlyrzwh0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> We're including a couple of standard headers like <stdint.h> in a bunch
> of locations, which makes it hard for a project to plug in their own
> logic for making required functionality available. For us this is for
> example via "compat/posix.h", which already includes all of the system
> headers relevant to us.

Hmmm.  This is interesting.

> diff --git a/reftable/reftable-system.h b/reftable/reftable-system.h
> new file mode 100644
> index 0000000000..f90c415182
> --- /dev/null
> +++ b/reftable/reftable-system.h
> @@ -0,0 +1,7 @@
> +#ifndef REFTABLE_SYSTEM_H
> +#define REFTABLE_SYSTEM_H
> +
> +#define MINGW_DONT_HANDLE_IN_USE_ERROR
> +#include "compat/posix.h"
> +
> +#endif

This one is clearly tailored to be used in the context of our
system.

> diff --git a/reftable/system.h b/reftable/system.h
> index dffc717bd4..52f964c04b 100644
> --- a/reftable/system.h
> +++ b/reftable/system.h
> @@ -11,8 +11,7 @@
>  
>  /* This header glues the reftable library to the rest of Git */
>  
> -#define MINGW_DONT_HANDLE_IN_USE_ERROR
> -#include "compat/posix.h"
> +#include "reftable-system.h"
>  #include "compat/zlib-compat.h"
>  
>  #define REFTABLE_INLINE(type) static inline type

And so far in this series, I was getting the impression that
reftable/system.c and reftable/system.h are where the target system
specific definitions are stored.

The implementation detail of how we obtain the wallclock time at
millisecond resolution is in reftable/system.c, the implementation
detail of how our mmap() emulation can work to build reftable_mmap()
is in reftable/system.c, for example.

But the corresponding reftable/system.h does not seem to be specific
to the target system at all---it describes the common abstraction,
like "reftable code proper is expected call reftable_mmap() on any
system" and "the way for reftable code is expected to read the
wallclock is by calling reftable_time_ms()".

So <reftable-system.h>, just like <reftable/system.c>, is expected
to have a target platform specific "implementation", and not like
<reftable/system.h> that is expected to be platform neutral (this
neutrality comes from the fact that <reftable/system.c> will
implement the interface specified in <reftable/system.h> for the
target platform).

Which somehow feels confusing.

Besides, the definition of "REFTABLE_INLINE(type)" being "static
inline type", according to the explanation in [1/6], is valid only
in the context of this project, so shouldn't it be done inside
<reftable-system.h>, not <reftable/system.h>"?  For that matter,
what about inclusion of "compat/zlib-compat.h"?  Is it widely
applicable across target platforms, or very specific to our codebase
where this library is used/embedded in?




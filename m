Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA309299943
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 16:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768409136; cv=none; b=s/h2u1lRSlkrzawAhgnKqVKfZGi9CXUAdPVyJhMkE0lf1YmMhl3gx/U+VLh278hLhzFJ7iKqkjcJ/722oi191s2lCIeK3jKNsANT9Vhhzv1B5M4k7MIwM4nF74bOZaClcWsjfAXExXAwEwaMhPfa6Iu0XRZXRsFnIjdx9CoTxF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768409136; c=relaxed/simple;
	bh=J3GhQjcXMUV0pWsmyYZftU7IgB0d49BbcceZCoPOLFo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NvwvM/B25bzZJrt+VLQMmhf0Z9ePsq0SOwpwAOTMM+vIqVpxcdlZ9g0Wv5sFQAEwXG/m3cpQOhV9mrlDv9A1LKzrsY4M+21E3DfGlbefyTZy4HHtDjU/Epu42JWPqTjMTwqk5gxcOpGWuSmRRzVX6ItgTLHEZrTWjU6e0VSZmeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HPf81XaU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ocoXSfot; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HPf81XaU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ocoXSfot"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1AEEB7A0088;
	Wed, 14 Jan 2026 11:45:33 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Wed, 14 Jan 2026 11:45:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768409132; x=1768495532; bh=lhK1qkTtLP
	+2drRWQy+pfIm9xW5gkx2ffYfalfmuiJ4=; b=HPf81XaUBz0IfRX9Pi3EMn/dJf
	7rr1c98f3QbB1bC5LTXGxYDUq9ePHkbsTWC7pfgzWnrFlysAMwLAifavnJKafQO9
	z2O3ugr3Y+MvtfM+7/NNi8k6Z+s1E8PMtBAm8S+zhunCWVtVasKToFuUr4B/k+R+
	F0z2aq07c4w4wY7cazYfPS/8mZcG/QCKt1oF2rLQE4vf2S9tx99LJNUv7Wf77hyp
	Ivwvc7lVvpxw5xdbOlfFERT25T1upQorT3D8z/mWMLk11a22A+/b64/S30F3neuM
	YBHab+NF7zN7yi+fr8HQaXEGbHXUMJfqwPTfh3JDg+QcdXeL1QUebR7ZcVwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768409132; x=1768495532; bh=lhK1qkTtLP+2drRWQy+pfIm9xW5gkx2ffYf
	alfmuiJ4=; b=ocoXSfotuF9ao6xFTrRfSZ9hSEtKm8wn3B1c1UUAuq1oyoy2rTw
	I7w2SQWwBpnT1B7+OYOcBGNjeV6PjlhBQ6tXHde++GDOrEPuTpAuNnsvrCmD1asH
	nPNIKGH/mRYZ9kE52kyQ0Fr93d/O50UpPivy4blgehhXYTiE9leRMnETWjrsCFQN
	wsbBG3Ei22j6KZAdEIrcKi/SfiRCF/4SJL5HSLYr3HYpAp/saD+ua51duy8Gi4CZ
	az36gVCoYuCEDT3ZK35GI77wthmU34CTu/88L2lwkuvM9xGGLnXKM6I1pdY/5xOT
	L3VvYTGMOTALppDWT25e7jWzbUnK0Bv0Bcw==
X-ME-Sender: <xms:LMhnaZZQM4P63EDPg-KpTojAhiVy9s9osZUPeBK2JVQGfgfiDz6low>
    <xme:LMhnaXT6tHCuTuM-MK3RUdxcq1embkuMM73ERIzJcudMW8TPLqHm-4nJ67rAW0IRb
    BoXaeXhG1KuRlpfvlHF-l5Y7-MP617YdBEHtTjUE7_zaUD4T-3lgg>
X-ME-Received: <xmr:LMhnaURuFbQxkH6OZdhMxxyREY3jqZD4KZlI05vOfsZoXy8TMC9MRfAB7Xt1nYHSIyWsH7XCDnvaL2U5GM3bLQSlhr8DelgQ7weoPlY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdefjedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrg
    hrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtg
    hpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:LMhnaTQ1ghLUXpsFMiqAavCtmd8Ftva5XTSTvV7JU1TioGNFCzGmyQ>
    <xmx:LMhnaR4cQzZsr9_em-cs31mVam6SYYZzMPFNr166Xagge7tlYgfOUQ>
    <xmx:LMhnaX1GelmTneKoQv5uU3L1Vzyz_jF038_rP-K_hBEOo2ShzeaW3w>
    <xmx:LMhnaUCZ2avR-umTxN_7NKZPVAf59MzY31XV1K1SoNGrN03lbLw9Mw>
    <xmx:LMhnabyKR8zc_hTtORKmKMMG-p-OHUfIL3x_sB7LkqDmjuuYrDng4OCU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Jan 2026 11:45:32 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  peff@peff.net,  newren@gmail.com
Subject: Re: [PATCH 0/6] refs: provide detailed error messages when using
 batched update
In-Reply-To: <20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-0-f5f8b173c501@gmail.com>
	(Karthik Nayak's message of "Wed, 14 Jan 2026 16:40:41 +0100")
References: <20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-0-f5f8b173c501@gmail.com>
Date: Wed, 14 Jan 2026 08:45:31 -0800
Message-ID: <xmqq1pjsgn2s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> The refs namespace uses an error buffer to capture details about failed
> reference updates. However when we added batched update support to
> reference transactions, these messages were never propagated, instead
> only an error code pertaining to the type of failure was propagated.
>
> Currently, there are three regions which utilize batched updates:
>
>   - git update-ref --batch-updates
>   - git fetch
>   - git receive-pack
>
> While 'git update-ref --batch-updates' was a newly introduced flag, both
> 'git fetch' and 'git receive-pack' were pre-existing. Before using
> batched updates, they provided more detailed error messages to the user,
> but this changed with the introduction of batched updates. This is a
> regression in their workings.
>
> This patch series fixes this, by passing the detailed error message and
> utilizing it whenever available. The regression was reported by Elijah
> Newren [1] and based on the patch submitted by Jeff King [2].
>
> [1]: https://lore.kernel.org/all/CABPp-BGL2tJR4dPidQuFcp-X0_VkVTknCY-0Zgo=jHVGv_P=wA@mail.gmail.com/
> [2]: https://lore.kernel.org/all/20251224081214.GA1879908@coredump.intra.peff.net/

Thanks, all.  It is very nice to see such a collaboration going ;-)

Will queue.


> ---
>  builtin/fetch.c         |  9 +++++---
>  builtin/receive-pack.c  |  9 ++++++--
>  builtin/update-ref.c    | 13 +++++++-----
>  refs.c                  | 56 ++++++++++++++++++++++++++++++-------------------
>  refs.h                  |  1 +
>  refs/files-backend.c    |  3 ++-
>  refs/packed-backend.c   |  9 +++++---
>  refs/refs-internal.h    |  4 +++-
>  refs/reftable-backend.c |  3 ++-
>  t/t1400-update-ref.sh   | 26 +++++++++++------------
>  t/t5510-fetch.sh        |  8 +++----
>  t/t5516-fetch-push.sh   | 15 +++++++++++++
>  12 files changed, 102 insertions(+), 54 deletions(-)
>
> Karthik Nayak (6):
>       refs: remove unused header
>       refs: attach rejection details to updates
>       refs: add rejection detail to the callback function
>       update-ref: utilize rejected error details if available
>       fetch: utilize rejected ref error details
>       receive-pack: utilize rejected ref error details
>
>
>
> base-commit: 8745eae506f700657882b9e32b2aa00f234a6fb6
> change-id: 20260113-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-17786b20894a
>
> Thanks
> - Karthik

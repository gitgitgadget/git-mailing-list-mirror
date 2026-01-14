Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D562DEA87
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 17:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768410488; cv=none; b=K9R5VuPyj9m1zHeLIAiK/TN8O7IxG1c3QOVk0c3jdPuGtIombf6e/Lhfv4Ic9HKbSUPKRH26LwDLteSQaKOupclJtox8SipCkVjVHKJLS4h+NWey7daMHDmDUxdrbsP70yQV48/BdHfYS1DHgYW5N+FvGaJE1eVUF+8poc8vtqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768410488; c=relaxed/simple;
	bh=o41K0RT47vfWOcy+BcxGtwOJJPhxoeffNaCM1OWFP7Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BhMcajPSivIg7lGTj5EM2GbY6MSrxfRNMgsinIeRF+3ba2GUAEBwym91nnxdxrigPCLtvBx7SSuNw1Nj2Ms3hmBRy727jb7My54Q044kc1Mzkk9rcO2GOVSFZuqTl1vgR3bKjPouZII7N/BhqzN0n3ulONE5SuTIcwuLpysio70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NapKeosK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oW3ZkHd4; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NapKeosK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oW3ZkHd4"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 026421D0001C;
	Wed, 14 Jan 2026 12:08:05 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 14 Jan 2026 12:08:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768410485; x=1768496885; bh=OqrAXwPHqP
	VfWdyQKgNpHSxwHhnMa6YNVYQ8INxMYSI=; b=NapKeosK+q2ZF0hFY+rk01okQy
	6oYR97B+sO8I/te2m90kqrJQfladiQrskTCG1+O2dzZJJ9MRMMmUbrEjF/5CjBVl
	bVgAMhrj5xC2oNMrO8Rxdrr978tqyvCb/4NgM5cSbeo16YzFtwpakzk5tv1DutZw
	LoFrnF7nvg1b7rmn79YemrEFkKSi4qqdwabGQO4AUIKbqLHBvxWa0Us40f7UqTA6
	Vf1tgzzchtpzOz5ti4i7DK6I0ZSYzKSi89a/8zny5dMQfHlB//Q+pZFXOohtYMO1
	zMSCwloVf2NgzyDmeIhL2cNjMD0uzl1XMM5Jk4Fi9g4PjBXvGkSM8hRR2JAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768410485; x=1768496885; bh=OqrAXwPHqPVfWdyQKgNpHSxwHhnMa6YNVYQ
	8INxMYSI=; b=oW3ZkHd4VDW4kI6/mJhym3YOl9Psi1PTmzYoKhddLdAzfBpJtsQ
	unJpWwaylg0V6LLHi75wGrvZt2u1Wsp5XFEDHgtRcx8EHCV7r2BJrN0Sf3dfLgvr
	x7fJfDu9NFxk6gRwfPdTIIv20FoQyjiTGM7a/YywT09qQs6DPDyPeCh1z2+cdW42
	QDbsT5i+dZNwdNzx8SpJ3kTILInJtT2oz7hkM8Koc6cCxTPn8fBI2mbxM2LfR8Wf
	H0DZr+gGAO9sPvlq9mpYqTF1NVYqPR474AuBgOrUtoG6A+IwDYlOsiThQEYtmyxK
	bl/bEgdnGg9pZN7PfZW6lPvmGjdiflZm8ZQ==
X-ME-Sender: <xms:dc1nabftE5ZrHJu-WiCypqGqCGIuqBbwCZ73mLmnnmdzHWsN74YPgQ>
    <xme:dc1nacsz1Ue_2mzqaORNQDNIuXjV069KXtXZavzwlmtNzZdB4MeRSLIVRSXJZhujh
    L89rlDaeHvgAjMbLNOOXu9jCqQKGLOakdxH2Xyn-NARdqCbxZYBCA>
X-ME-Received: <xmr:dc1naa-ZFHGjkdeR_1ZGQwVkuYy7AU_cznRRT1qyKCtxk8RxUjRxTtn4H-b2VTuJhT_4hzSZJ9RgRWYAYYNxiopm3r5oNDS_2wDVCPU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdefjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    phgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:dc1naX1mQkzW9JM_KsgHsKwoSW3OYzcvgbDzzqMVWxjLQrdV612TvQ>
    <xmx:dc1nafBKkgVFD8yOholg0w14TRHcVZeHWSjs9fncE63NF2ywEvTmJQ>
    <xmx:dc1naTfQFlrixNl581HLbmimw1BfKpmOxM0Iq-N-cLsrKBTkbpt_Bw>
    <xmx:dc1nac5S7XYhHgdVIvkTsYYKPLeEOrOvYkqJHLiXWsMbLGfnSuNVDQ>
    <xmx:dc1naUrIfagcXBBU89_tRPMar6ybacQDU-LvsonznonYQYHbVoCwMI8P>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Jan 2026 12:08:05 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  peff@peff.net,  newren@gmail.com
Subject: Re: [PATCH 1/6] refs: remove unused header
In-Reply-To: <20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-1-f5f8b173c501@gmail.com>
	(Karthik Nayak's message of "Wed, 14 Jan 2026 16:40:42 +0100")
References: <20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-0-f5f8b173c501@gmail.com>
	<20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-1-f5f8b173c501@gmail.com>
Date: Wed, 14 Jan 2026 09:08:04 -0800
Message-ID: <xmqqwm1kf7gr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> Some of the headers in 'refs.c' are no longer required, let's remove
> them.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  refs.c | 2 --
>  1 file changed, 2 deletions(-)

One thing to note is that The resulting file refs.c still includes
hook.h and because of that, the removal of run-command.h from here
has no effect.

> diff --git a/refs.c b/refs.c
> index e06e0cb072..965b232a06 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -15,7 +15,6 @@
>  #include "iterator.h"
>  #include "refs.h"
>  #include "refs/refs-internal.h"
> -#include "run-command.h"
>  #include "hook.h"
>  #include "object-name.h"
>  #include "odb.h"
> @@ -26,7 +25,6 @@
>  #include "strvec.h"
>  #include "repo-settings.h"
>  #include "setup.h"
> -#include "sigchain.h"
>  #include "date.h"
>  #include "commit.h"
>  #include "wildmatch.h"

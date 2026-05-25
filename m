Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF383D45ED
	for <git@vger.kernel.org>; Mon, 25 May 2026 08:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779698305; cv=none; b=MPzszxogWD2JrY9/IL0difxJ1DSZ2UJnIR9DTygAcIY680Cys79bs3h6jWEzrdMGCV6zmHwQoazAVzlTptWpMo/GZryerDR5u7qfb86zwFc3anisNjlzrUplDhKSMM4dPq454D42itbftH7Mw6o/bsn6Nl8JWlHje4DX6eAif0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779698305; c=relaxed/simple;
	bh=mfH+ShMzPMyADysvNOZUpEWFAEJgsl+lEhWZY0y1WTA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=peEVe2qRw+pziq4wuI1P6qzqVE5O549FjjJBIa0B8ONY08Q98ElU6LhkF/sSuVtEDjeOi3ityjnANbQK/B+YFBaLOGVW6SjcLuunxyXCqb6v+xZAg9Sww+LxzpFC3GzWIhuGu9j9mcOJ+hn6MBQ5esazceQUu7Omot0J7yloMKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pnEYuxP8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CKVlNRnn; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pnEYuxP8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CKVlNRnn"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id EF813EC0696;
	Mon, 25 May 2026 04:38:22 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 25 May 2026 04:38:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779698302; x=1779784702; bh=T6kg+j0Oc+
	DPzSlO8jkwsqjAjHxu7HtHb8wNPqFdyZ4=; b=pnEYuxP8VY3fj6R45YDHODHaFT
	HlMlkmh56Bca+5zmrGR5ka8QjgD7ueNTZl2yNrkPI6sSq4sj2G1iABMMicvXbEnI
	GlruQpYQK/OU1fVEEwY64KBcfqPTvfKYYolCOKREK8WkibspaXFB8C8GcUKmuePd
	cwZw+gZFFkLRszMDPdNQ6P+Ym0/EbzA1yljns1G3ixDLNMqhfPjr10I6PKr5O8Y6
	LVd8ozPp3s/w8FlivGJ4T7AqSsHvF1ivPD3SRhIjte4XY5K4xH9czivhBGNdGOHt
	0BxgD0SM/6PcKOnYoecPHaOG6U2iPMthY3gk2YkSdca84oYsw3GRZO3CsXaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779698302; x=1779784702; bh=T6kg+j0Oc+DPzSlO8jkwsqjAjHxu7HtHb8w
	NPqFdyZ4=; b=CKVlNRnn8WcT9MF0WButnHrPKQF6JeRyKyndeki8Rk4NNyXbuMv
	gKldwJfmvEak3A+0p7tKDOW2QzkN59uXKX0v/22JDTolFv/p4mfizc5dokV8bbEu
	NvLqKMDbaYkv140HsWLx4fyuUfQktC1NMBGeoglTXsr5WGotQBSNMtLPMxJ7UH18
	Tvs7WI5Dvtl9OqVWoxFsq/qoYqaskW8SRK/60D6uJFJwAu8EfeHrLS9ECiDxx7bS
	4hDDvRh4WAKn0FStNxZF6T2KyjeBaTn1oYZw8kspLnxmeFoIgECKCYN/APJpRUrF
	/qHBok78x9kwULLSjfBxVBHnr569FAKqINA==
X-ME-Sender: <xms:fgoUappOposfWF7o1ArCOGLi0YUNTXTIfW83DiVSW_LrjXfI26AgoQ>
    <xme:fgoUaii6kv3jDXpWwWnwb03IoB33NB1an9P6hr-rT1Ym7jMg605dW80ooqZddSp8d
    jKwCJfRYXAt4AGSnOXRIUzAehmBJcAFa_PyMRSB579ZR-eg0oG6>
X-ME-Received: <xmr:fgoUaujFq7rMiI7YUk1ZnbEkYRKCYZPHP37S91OzDcpLUf4go5w3bERNe2h4p3RgouQcGh_YmMtI3qq__8qO2MZZavFoLRoCZFY->
X-ME-Proxy-Cause: dmFkZTGRveO0tZacf8dKdTbKySKkm8a0yGl4S1lWZVMO9crp3Q4Bt4hoEjtNlyEU9/7uBF
    z8PrvnL2VcO3H/RiO9oK/Xx/ijSX6cYru9BS496EQ73tDz+aLbDjJ2mR9f+glTgaNTTEXh
    Yxp67y4DmDLRi6fmBbENegYQmJN/VfF9GaSW2RIDQDnMyqZKZECGoGGEwH2eBA27qlPgRz
    A+vmMkTYTFxMFo2mMILUPMoRRp7qPtROqfPCgy6P1Tje25WqASL7rDG752a57OhC1FWwxe
    P5JbP2DVNUX59S5LmLq1Gt9JPJTIBzZtZm51wMgzlZPMM3VG0iiae1UhfeePzOV7m2TugW
    qaMy6SeZL2g0UuRnucKwBNd5TQvk9zblsSDdhK90wFcC0c5RjYeLw9THyVxfuLZPqgDqHN
    /9Bug03KuIjH3sgdvjRj30iEZivR/+SejOsmyw8VemlDk8Co4wE75EuUQ5k4gFqet0f4w3
    VwG1ulPXDD37/dVULEcKI+8IrymmVyFW1fZJlTKS2oot05dvGC+klYbUmbKo6XEY/1g3iZ
    ugRacW6jQ/5A+W/eRdvvrS6fTAf9URSaN7HKYUtUEUbYymbGtlgrlFnOCljm+YmO2+L3Op
    4qtzFJxm0p9o17+1Zi/RHuJ51p2Cn1IhwPRXPVYNV/W4vHYqAzp2VcPZSeuQ
X-ME-Proxy: <xmx:fgoUagjecvbJOtZ9TryfaV3HZAZtNLUomMpZ2BkVdtcD4bao1cIwKQ>
    <xmx:fgoUamJ22fam0WOVQUq4MRicI8OUKQyRycwUPVQhss5rn0q6Q5E1kw>
    <xmx:fgoUanHNR51lYzl1uHcq7-x9P2Y_mNXAPQsswPT0oWRRYK8zcHNNDA>
    <xmx:fgoUaiRHizIgn2KRXNulctob7apN9pRc18xVOzEw0M4uAk4TrMZf_g>
    <xmx:fgoUaqIncGaQqkwjN2UFUGJeQZoDXT4t2J5ExwYtdStFWoq8Om-IFzn6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 May 2026 04:38:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Kristofer Karlsson <krka@spotify.com>
Cc: Jeff King <peff@peff.net>,  Kristofer Karlsson via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 0/3] commit-reach: replace queue_has_nonstale with a
 counter
In-Reply-To: <CAL71e4MOH2iPve19dKixLHSgpC3ZAZz59zLWEWRoxW1a7vhMwg@mail.gmail.com>
	(Kristofer Karlsson's message of "Mon, 25 May 2026 09:59:59 +0200")
References: <pull.2124.git.1779644541.gitgitgadget@gmail.com>
	<20260525064755.GA2737798@coredump.intra.peff.net>
	<CAL71e4MOH2iPve19dKixLHSgpC3ZAZz59zLWEWRoxW1a7vhMwg@mail.gmail.com>
Date: Mon, 25 May 2026 17:38:21 +0900
Message-ID: <xmqqfr3fg9z6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kristofer Karlsson <krka@spotify.com> writes:

> That's an excellent approach! Much cleaner in general.
>
> I benchmarked it against the counter on a monorepo with wide-frontier DAGs
> (2.4M commits, component import merges). Using merge-base --all to bypass
> the early-exit optimization from kk/paint-down-to-common-optim:
>
>                Baseline    Cache   Counter
>     import(A)    8079ms   3686ms    3723ms
>     import(B)    5498ms   3993ms    4038ms
>     import(C)    4350ms   1748ms    1766ms
>
> The cache performs on par with the counter - within noise on all three
> cases. No new flags needed, much simpler diff.
> The amortized O(1) is just as good as true O(1) in practice, and it avoids
> the ENQUEUED flag and counter bookkeeping entirely.

Nice.

> I went with back-to-front scanning as you suggested, and also clear
> the cache when the cached entry goes stale. Applied to both
> paint_down_to_common and ahead_behind.
>
> I can rewrite the patchset with this approach and add you as co-author or
> suggested-by? Or I think I can wait for you to push it yourself.
> You did all the work here, and just didn't have enough data points to
> motivate it?

I can take from either of you two ;-).  Thanks for working so well
together, as always.

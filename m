Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE672DE6E3
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 13:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780925797; cv=none; b=ffFMTjRtpeVIuDTiBd/5t3ajYqbu8hFwXjlf0brVby4MYpl+6yLWNRGyPxvSaTCWpy0N/9pea/vlS8QnZYTyefF1+cWq3zu5HefGbuzhABVwiJni51z0LzGI7g+cl7x0yjkSEDWzaGYyQA9Z2q0pAp2jRLElpitAFk2vNeNbHQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780925797; c=relaxed/simple;
	bh=VreFV1+C2GJ6v+ws1bGZ1wQRQ+dmpUyYJpB0WXu7lVY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=vAUSsZ28OnhL4cWx1zk2lGASBj0POKhVbJbEa40QXWCz645GP0KoEr+qDYrgW2F54JEIEMqodbzFCF6/JTPKOkJpY6uxWhIj2zN4kyOocR6gSEnx52S6FxMrpAQg/xmjW3a65p/eytoGwqp5vcV96W3Im8v3hUZrMH1rZfGJyTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ies40ZDx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QxlT4tWg; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ies40ZDx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QxlT4tWg"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 2F0D5EC0199;
	Mon,  8 Jun 2026 09:36:35 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 08 Jun 2026 09:36:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780925795; x=1781012195; bh=S4tQBdRJYf
	dKwKlyxcoDw2u/qwdB8nZfqg3LPhfABZ4=; b=Ies40ZDxRMxD3mhZEOTUA8tyos
	xcUz42DyRioT8QYP/IAz3vO26tP/x3p9BvnofO0gF7ox5YHwaGPcNqW0z85QNg89
	PyejvVCakMvnKt6NjJutnxhLdRerqe2NSeUhja6ZZEuetJAMMdbpu8LciAX4La5e
	KqFT/w1P+uWw9AuUDgjViS3BWao2B8QroDaexL9gBdJAiIBYuU0k36UXg65TzgHb
	i1ZnBvpUPmox3EdLFx/HCkIjjgOw2VPldk4AlhEyy8E9NNDftNbh36llvVoYqpE0
	EiWZootrd67/+RMDYhNYVgiMxcnhl7nJqzYyhHI8yBASTP269pfDN/Wmzgnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780925795; x=1781012195; bh=S4tQBdRJYfdKwKlyxcoDw2u/qwdB8nZfqg3
	LPhfABZ4=; b=QxlT4tWgZQ5M1mjhri2TqANEX5z3QPPAmf6PDsqs1hAswAi4ue2
	i75VKtyMwGR91Q0U0zECs59BXxaOdrpODSX09mxRgYVnwX4cPRG0fSPiS1GTGFO/
	q593fdOuzBNXeN2omhzrPbAnalifZ1ZXMR78cXlt/iME6JkyRKrsPY8q17J+GgvP
	X6gYN9p2g3NCfWoSW2CHpVFg5OuLGsmy7GrrJsnj9YBLkog1laIvu1ZFHgi0jMFL
	LRKp9WVBGC6pvgOVA2Yomf/8V7emKGLl4TaZ0tcCL/K1pdS724FEO4ZyF4Cjc/lk
	W66D0/uNui7ItJpVDBq7ggJR6ghJAhMlX3A==
X-ME-Sender: <xms:Y8Umau6ThVcVKrWKmIlMRVl9ad_1zOpLVb9J7IYYD5ovIm_KbgCM2Q>
    <xme:Y8Umauy2XCXBuBnSHJo6DLeyXu76YayG6AeoLSqSyEjP6FcRcPhZ7mFgkZgqmU2r-
    8zq20xSfPd9Rf1tZMSujCzU23T_0bA1i90818WNlVwE8uoIhMgM>
X-ME-Received: <xmr:Y8Umalx9dCF8J9_IH6N54ByNFUH9GZPA0y-j_WJO0J4_IJT6uPD410dW4SxL-yhp_OP9pQLwEKD-f_XI5LzmQEHBdRS3GAK2iRGt>
X-ME-Proxy-Cause: dmFkZTEscr7ojCWYMr2/X1uGmA58hB43FyF22EDstdT9iGTc17HSNZHCsY3rjcGd/h8Hlh
    aRnboM8Bock968tqMTMY1P17GYWVoziyrlmZYjYKlR/VD23fvrno8nCm9KSHWJloXnAskP
    talL60HMf2uDgq/TJqMwMsuZO/B6rNjoTubxo5XV8QiZ5b4a/p/IXXBiMfBOWPr1VqKpm/
    SxXw3nurfICeJcdZlRTcmHfloVG1gm2MrGdlGGRgyhk4BYIFdynIYP00wXKeNh/aTeuLUp
    TdUPR/3Sbipnn0KVcncGNOXGSRn6xNRVmaGqThhZuILUGZQ5qiKHoRjMaagoaROQXSt1AC
    k0xtsSfiyv+IG+4P1EtUJHEujyHnZzwY6el4XNflFH4NGzlZObIa+joNbISlZwwwwkIDkI
    Zc4EplGrSoMMflBeqFhckisI0+Hx8jOH0a9HMqm+vdeQ90MnXl70VmufSy23K6QW408lVu
    ahT3o6DRRiDlj8u5ZI9EjYMeH7WgqBiVFuaMoeyDJ3XUlsWs6q4a7WL2ftqqf4/BpYELUh
    m9c510MVm/Mc5RnLLUtfSRzC2xvaMEooDSHmnsNeNUNvl7pT+cX6wjcwuyI+lplhv2GQ6W
    VRPefmOO2J4H/bY/BUcVSylT6V6J5f3F3O6nBW+tEiA2ytVv4Is2Kh1quJXQ
X-ME-Proxy: <xmx:Y8Umamwyq8VMR0IEvx--fLvMGoM5Neui9tEthM_aU_1GAcg-jvnFag>
    <xmx:Y8UmavY811E0pKisi0_6nzGF12HN-LeznS1ROiv8s82yBLqDfcpapg>
    <xmx:Y8UmanVSLsSikK0z1Ra2v_ycSkXroNqfeySIZNHwOCjTwXEYykq5Og>
    <xmx:Y8UmatiB4_Vk3vAy9gYhtjxe8cTjel72V2IIGXu-fI-Rz7lvg8Zj8w>
    <xmx:Y8UmaoVGrm6GyzbimhxlFZABSVfrrwXNaBJKToSyWdoem3MehSO80S9X>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 09:36:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
  Kristofer Karlsson
 <krka@spotify.com>
Subject: Re: [PATCH v3 0/2] prio-queue: fold lazy_queue into prio_queue for
 automatic get+put fusion
In-Reply-To: <pull.2140.v3.git.1780832592.gitgitgadget@gmail.com> (Kristofer
	Karlsson via GitGitGadget's message of "Sun, 07 Jun 2026 11:43:09
	+0000")
References: <pull.2140.v2.git.1780772477.gitgitgadget@gmail.com>
	<pull.2140.v3.git.1780832592.gitgitgadget@gmail.com>
Date: Mon, 08 Jun 2026 06:36:33 -0700
Message-ID: <xmqq5x3tyx0e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Changes in v3:
>
>  * Adopted Rene's suggestion to move the flush logic below the LIFO
>    early-return (LIFO mode never sets get_pending, so flushing there is a
>    no-op).

Sensible.


>  * Went a step further and inlined the flush logic directly into get() and
>    peek(), eliminating the flush_get() helper and its forward declaration of
>    sift_down_root().

Hmph, unless there is a reason to allow the copies in get() and
peek() to deviate from each other, e.g., what flush_get() had to do
inside get() and peek() were slightly different, I am not sure if
this is a good move.  I do not know if the slight difference of the
"inlined" logic we have in the patch between the one in get() and
the other one in peek() has merit, either.  It certainly lets you
avoid an unnecessary clearing of the get_pending bit (when a get was
pending but the queue has more items to yield) immediately followed
by turning it back on again (which happens always unless the
function makes an early return for an empty queue) in get(), which
will never happen in flush() that will always clear the bit before
it returns, but is such an avoidance of an assignment really worth
it?  I suspect that with the static inline version of flush_get(),
compilers are smart enough to optimize it away, but I dunno.

>        void *prio_queue_get(struct prio_queue *queue)
>        {
>        	if (!queue->nr)
>        		return NULL;
>        	if (!queue->compare)
>      ++		return queue->array[--queue->nr].data;
>      ++
>      ++	if (queue->get_pending) {
>      ++		if (!--queue->nr) {
>      ++			queue->get_pending = 0;
>      ++			return NULL;
>      ++		}
>      ++		queue->array[0] = queue->array[queue->nr];
>      ++		sift_down_root(queue);
>      ++	}
>      + 

The above is from [1/2] (this is a minor point, but flipping the
order of two patches to make the "nr_internal clean-up" as a
preliminary step might have made commenting on this part easier to
read).  I wondered if it is easier to understand if the first early
return is guarded by a conditional that takes get_pending into
account.

	if (queue->nr_internal <= queue->get_pending)
		return NULL;

As I said, since the above hunk is immediately followed by an
unconditional assignment of "queue->get_pending = 1", clearing
get_pending = 0 only when we leave inside the if() block works as an
optimization that is not available on the peek() side.  But with the
"ah the queue is empty already, the queue->ne == 1 is due to the
lazy get that did not rebalance" tweak, it would become unneeded, I
think.

>      + void *prio_queue_peek(struct prio_queue *queue)
>      + {
>       +	if (!queue->nr_internal)
>        		return NULL;
>        	if (!queue->compare)
>       +		return queue->array[queue->nr_internal - 1].data;
>      + 
>      + 	if (queue->get_pending) {
>      + 		queue->get_pending = 0;
>      +-		if (!--queue->nr)
>      ++		if (!--queue->nr_internal)
>      + 			return NULL;
>      +-		queue->array[0] = queue->array[queue->nr];
>      ++		queue->array[0] = queue->array[queue->nr_internal];
>      + 		sift_down_root(queue);
>      + 	}

This is from [2/2]; the same 

	if (queue->nr_internal <= queue->get_pending)
		return NULL;

applies here, I think.

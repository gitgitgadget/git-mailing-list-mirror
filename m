Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29804193436
	for <git@vger.kernel.org>; Wed,  5 Feb 2025 18:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738779980; cv=none; b=s4jSkXOFlsDwUD6uT9PZL/2XfZVkmgyCyo/PDLJ3waKei1ccfswT4TvrZ8MUR4owUTVvoy17wSJoz2R84JptCrgeMZbUSBlPZcIfYsizvx1r+MwVJbwLxsOW3HaqUXtsJxJvypBwlKctwz8/okA0mee/L9zE8cLD4sLMRosc50Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738779980; c=relaxed/simple;
	bh=W60yT3TNB/Fs86s+psAPpvv178CdtE/M65dviHLU9aw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z5Ilrn7pokmzhywESvCq1Iwsm4u+kiusCwuwct2ZWefs9MUB5AgKQVd6f7f6vQNanS+KUgwrewXW4FANWldmL3u6aNbx+C3+yVnz4jWxtoQNjZDLaWQoj7Z7SB+jWl6G0kqBWZPrmWa0pLO30QnrMBw81VvySCQUp/0nv3Irvh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CAg9XcJi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SB67kFvj; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CAg9XcJi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SB67kFvj"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1D0EC11400E7;
	Wed,  5 Feb 2025 13:26:17 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 05 Feb 2025 13:26:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738779977; x=1738866377; bh=TGb0+0jZLQ
	daBGAwjGfspf02ZNzIi78ytSp7m9/44oM=; b=CAg9XcJiKGwE4qD/FYv+IZAgDQ
	gO6P3D0qAdybvt9cz2hSO727ZB3mkyWsQG3M8UPJzrb6mewPuy0IioS3uyXJVK+C
	LDljvnDIt5yyjliR9U9CWOQlLsKIKWmH/dI9syuDnx+nfrQGRA7SQ46g36Zqm0QH
	/94sbCdYAu0ikc+bQNFYOwBLJc9qnqsgPqEoG3LvO05SjXkxyX0e2qnFwQ4ttiMP
	Eh/1pqveTZHJ+VCffAKzhDZiqpdDR1u5X0EkNtNs4oFtcOCrlV7fNJ2g5QdsVvts
	ubdz7c5MUBXqLBK+osTt5Ncgdf9G74HGg08Mw8a1sw70upngIJcTcxHCmXgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738779977; x=1738866377; bh=TGb0+0jZLQdaBGAwjGfspf02ZNzIi78ytSp
	7m9/44oM=; b=SB67kFvjfMx2YxGMn6ra0+UtwSg2MeawsPXgfNfrzwR5oN+tlcE
	zID41SKwHBeIsZ3UEPtoqa9f6YC1smFKaZj5hSa+KRWcHLBeZRPpRUxdcxIbD4rQ
	3F9ucSefGVrhP39i73BpEUKDkEV+WEnd0JmSTWn9vhuamM0ItRHccRdhZUIF67Rc
	XQkCKQMsGc0hcofguhMW3nn6ouKizyjhxegDuGyPcuydt/qYMSaH2se94EhHw0J7
	BqFcMIa/csfS3IhnDM4QhN88/vzBWe+TXf45zbCRITxwbfCmY7J0R7APgCXJEuWx
	PsS0VroTb5qNCbd2haXfz93mwGopCzryLQQ==
X-ME-Sender: <xms:SK2jZ5fvrhepseOsc5OgnlvJxyhjHkB2rJH8zsp7ZKy7qNH2s7UdAg>
    <xme:SK2jZ3PJ51m22ihWTtE0uXse0HC_cCanEEDNb3-9vay2idm3fIqCU2bxppPHmix8n
    14yYKYzW56j1Lt9hg>
X-ME-Received: <xmr:SK2jZyhwEu7NC1ZGGCGopUPU7-xHdn8_MTzR47HCL1i_qYXshHAy12-RKUqfoCHvde4hUEOaCUKMl6g_GY_0ViHugqpR74KsZhAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgedukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrg
    gughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdroh
    hrghdruhhkpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:SK2jZy8dYUgT7HeVr4jV-X-LKDb-SfjqR4CREuAue_ZDNPiiK44d4Q>
    <xmx:SK2jZ1trKfdD_65PrJbEppsQAc0alHNWYbRo8syvDlVqBslJEPpseQ>
    <xmx:SK2jZxEU4dV8klVPFhKdUKCni-Dkr2gEW7XdKUCiYscLd2czgndf0w>
    <xmx:SK2jZ8NiJvkWrQSGjm8ob3YeD2NtCo2KI_r1tE-cBuSa3AkaPKc9tQ>
    <xmx:Sa2jZ_Jmaq3xcesAG5cjG59R1Ls6qQ4R-8Y6mDpURRS_wV_38RNKR2_0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Feb 2025 13:26:16 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] rebase -i: reword empty commit after fast-forward
In-Reply-To: <pull.1860.git.1738751840816.gitgitgadget@gmail.com> (Phillip
	Wood via GitGitGadget's message of "Wed, 05 Feb 2025 10:37:20 +0000")
References: <pull.1860.git.1738751840816.gitgitgadget@gmail.com>
Date: Wed, 05 Feb 2025 10:26:14 -0800
Message-ID: <xmqqtt98nt89.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> @@ -2510,9 +2510,8 @@ static int do_pick_commit(struct repository *r,
>  		*check_todo = !!(flags & EDIT_MSG);
>  		if (!res && reword) {
>  fast_forward_edit:
> -			res = run_git_commit(NULL, opts, EDIT_MSG |
> -					     VERIFY_MSG | AMEND_MSG |
> -					     (flags & ALLOW_EMPTY));
> +			flags = EDIT_MSG | VERIFY_MSG | AMEND_MSG | ALLOW_EMPTY;
> +			res = run_git_commit(NULL, opts, flags);
>  			*check_todo = 1;
>  		}
>  	}

I am perfectly OK with the idea of run_git_commit() with the fixed
set of flags bits, ignoring everything the preceding code did to
incrementally compute it before the control reaches this point.  In
the fast-forward-edit scenario in which the control reaches this
point, the flag bits like CREATE_ROOT_COMMIT the earlier steps may
have added to "flags".

But the way "flags" variable is used elsewhere in this function is
"we check how this 'pick' step needs to work, and compute bits to
pass when we eventually call run_git_commit() or do_commit(),
incrementally", so making an unconditional assignment to it looked
a bit surprising.  At least the unconditional assignment deserves
a bit of comment explaining why other bits do not matter and these
bits are what we want to use here.

Thanks.

Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17173B83E8
	for <git@vger.kernel.org>; Thu, 23 Jul 2026 19:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784836445; cv=none; b=bWPDglr9fXY37M6y9ZoKR/texM9r9m6Hy/EV4hF2OtxUTyiaajHnO2dn1gunbxISIRlzWdDrIJTZWwgNn8DhdFZaMDY4oCwmSPuvZGkr/VYIBeskZ+nKcIYUa9OQdPfV2UlWsPsnlr6aGhU6beZVHQlJPIvgyWn52n9e3XNSRFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784836445; c=relaxed/simple;
	bh=THcMEZB2nppnHlPRr70qGmZzMT3g1+zcjEudoOxNTt8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LFSBgPw85eQa9TsV3hUkr7E/4my6b8Dxbdov0dzQF1vX2qFoTQ6thMZ9Ysalji6VuBRK4HQLNZeGPRacmzReRYPra4WRtJsGWinTLfqsVIQkQFEExE+NxSVpyQDHE0fDzEBmARW5l2qz/YwEaEdnkQVRm5yVLMVQ7k44IGwrIC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=j2MFevZs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Bg7Bg8ns; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="j2MFevZs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bg7Bg8ns"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id EB6991D001C5;
	Thu, 23 Jul 2026 15:54:02 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 23 Jul 2026 15:54:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1784836442;
	 x=1784922842; bh=D7NTgAss+4MazPfm3uyrcOABkXoc5mcJU5jApnND/u0=; b=
	j2MFevZs2wuGCU79BqBIi6hg7QsPDqAW7ItGk0B6ZXFZ3a/F1xHfC3bFUYh4Y+Tm
	Un23Jie5bmCK+xSZSUddZtMF30a2U1ZvGq92tir5oGuX7YQOP31yy8AGFV1ISkD7
	4GiWGTfHURAuvQQSrVpHps+f+zcmdUmsrme/jvUDyvfUc8Q8ERVydsa+tiVlV697
	vCtzvha5RILrwK2dpFdZyFdG11ctWuUt8e+hEmj5e08dpgumn9tP9Eun4XjFdCIZ
	QgDo3QNM/JHhyUpce+0FaOoe2VmWEVLFpSkmF+UVb8ANBD68jyphIKwAIWJwFbdu
	BVSJJCUa5tQ0Fyt6DVWmjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784836442; x=
	1784922842; bh=D7NTgAss+4MazPfm3uyrcOABkXoc5mcJU5jApnND/u0=; b=B
	g7Bg8ns/iiNEEngtLeMkWTJBDw1AsQXRqkNvyXksxgh89VXhlUCbPUUWL9MDh9D/
	PgHLQdUG1ggZdHb8lcRQbMOlS/BOF+Ofd4lPyAF+Sq7BLyXNXSED5G/DAcod8DlG
	PrMbWEKPvmgT4flI9N5R3mNpbGr9r6oeZWwIgXcqJn9so1araatXP5dUNePye4TW
	i+sgKVtP2d03bBJGPDRHIKvBMl/Izn+rLElNlkqeSWPOEAnnJ4nEsm0XQv5tTx1D
	LhiMXDLD0dfoXiDD9c648iFK7y9sOt+cID+FrAa7etCkyfXTo6Yt7jfH8gWYPJPz
	Gg2S4FanSC93iULFsmqlw==
X-ME-Sender: <xms:WnFiaiqoCRyDUXfDkuuq92HLh-0W6x1URccRD2JkHscFWF8iW2Ux_Q>
    <xme:WnFiang8Fyuif_8OnbkENq2xkj9uz9MwYMjrhYTgUSgshTijuMC8bqHgaEk5rf7cV
    1b3tTQzhnsjffApbFBD-0jKErGTlziHVfT5ONhiQvSmgBUPrvmEr8s>
X-ME-Received: <xmr:WnFiavgh66rjTwocgml_ZisCzqsDFymX1pa5EPwarvUZrT9O9vJME2RKtU9bfINosTLXm2SyUQLdJBC-958BHPRGGdUF-0SHFQ>
X-ME-Proxy-Cause: dmFkZTEyPCHLj+X9D1Z7P0YnXmR76d3Maz03kuNNMLXsng/2OuN4rGEKSwJeN4rb029NpJ
    9oU1CQEMDbvzdsUYfLBcZ1hziGnyPptrXOReARGxzQjVBzWkFncSZILoUCkn1X1TPNTOh+
    wgAiwc1H+upNnM6mTCdxLdzG9xPLklJ2WmXqgNu88UpMx4MecwraQ+FYZ1kQz3PcLy/3SF
    1nWhcm/tDpnHF3PgrkWVj3UFg9H/sA0R1JpMOkJAMnrb6/PyAH8nG6FW2eIYMqhCuvp6uN
    1alkUTNNbdMzbqMZ4pn3HbuQz+Yy3IpKQUtr3w3LXJBoVoJk72nY/BGpbG8k1vi8gjLwQ4
    6Nxy2zyWL5eNs2YIMMiy0N1c20+c89uH+ShSIVYUZXrs27GUTCwa7DgL5nHsobKPdGsjbf
    rqwdmhlW4UqmV4F5dHAx/jPLMIQQzkSj99q7I15CMmOJRkj84OJr0SWv4TxbaR0Mj6qgAI
    /GZDeW03DbYQ/Hfl4jkb0BOA1gS6boahDLd6wOqreuWJGHaPWEMZQW91vP0nXWXq6SO5RP
    lTqbNoYnZRBkqHkF+GMsqyMbKGBu56GYCr0VAZWI2PLryc3TP4C+yQKid7Y0ksXDux8EwR
    fyaCz5BC1UoFIWbpYMwTEE0CfI1gIj7um/b0r9mzZUQEqj1wwxmk4iBtQ6yQ
X-ME-Proxy: <xmx:WnFiathw4-x7lC2lImiJKQyIGFN_QXnVOKNIBHMktikBBxC1c6rLAg>
    <xmx:WnFiavLYbsBhqJq_5tRIqduFIebmJ1lKzCPWVYVMli1hpD8ZRRAusQ>
    <xmx:WnFiasEkMGWvk1VATgrJgKQja74s0vOTCINZhvee9ZswIdYraKWh9w>
    <xmx:WnFiajRUquz4t3SoDvxNw5h41FfgHHEWgGFT-p7OyrISf8rYX_FpmQ>
    <xmx:WnFiakEG_GlbYh4btQRTrGrpmA8Cu1hhOqR2JkqrEAlmtPDoamNMYGi2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Jul 2026 15:54:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Joerg Thalheim <joerg@thalheim.io>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Johannes
 Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] config: retry acquiring config.lock, configurable
 via core.configLockTimeout
In-Reply-To: <20260517132111.1014901-1-joerg@thalheim.io> (Joerg Thalheim's
	message of "Sun, 17 May 2026 15:21:11 +0200")
References: <409d05a5-235b-6b19-5a33-a4e613dd447c@gmx.de>
	<20260517132111.1014901-1-joerg@thalheim.io>
Date: Thu, 23 Jul 2026 12:54:00 -0700
Message-ID: <xmqq33x9h487.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Joerg Thalheim <joerg@thalheim.io> writes:

> From: Jörg Thalheim <joerg@thalheim.io>
>
> Concurrent config writers race for the ".lock" file, which is taken
> with open(O_EXCL) and no retry, so the losers fail right away with
> "could not lock config file".
>
> This shows up with parallel "git worktree add -b" against the same
> repository: each one writes a couple of branch.* keys and the losers
> fail at random. Worse, "git worktree add" doesn't propagate that
> failure to its exit code, so the tracking config is silently dropped.
> (The swallowed error is a separate bug.)
>
> Retry instead of giving up on the first EEXIST. The lock is only held
> while rewriting a small file, so the loser only has to wait out the
> other writers. Same approach as 4ff0f01cb7 (refs: retry acquiring
> reference locks for 100ms, 2017-08-21).
>
> On the semantics: the on-disk config is read only after the lock is
> taken, so writers touching different keys can't lose each other's
> change. Writers touching the same key still get last-writer-wins, but
> that is already the case today and would need a compare-and-swap config
> API to fix. The retry only turns hard failures into successes.
>
> Default to 1000ms, like core.packedRefsTimeout: same shape of problem,
> one shared file everyone serializes through. A larger timeout only
> costs anything when a stale lock is left behind by a crash, which is
> rare; a smaller one fails spuriously on slow filesystems (NTFS has
> been seen needing more than 100ms). Make it configurable as
> core.configLockTimeout. There is no chicken-and-egg problem: we read
> the config before we lock it.
>
> microsoft/git carries a similar patch (core.configWriteLockTimeoutMS,
> default off) for Scalar's tests. Defaulting to non-zero here because
> the worktree case fails silently.
>
> Helped-by: Patrick Steinhardt <ps@pks.im>
> Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Jörg Thalheim <joerg@thalheim.io>
> ---
> Thanks for the review and for poking me, this had fallen off my radar.
>
> v1 -> v2:
>
> - added core.configLockTimeout. Johannes is right that there is no
>   chicken-and-egg problem (config is read before the lock), so no env
>   var needed.
> - default bumped to 1000ms; packed-refs is the closer precedent and it
>   keeps NTFS out of trouble.
> - commit message now covers the read-after-lock / last-writer-wins
>   semantics Patrick asked about.
> - added tests; existing stale-lock tests in t3200/t5505 now pass
>   -c core.configLockTimeout=0 so they still fail fast.
>
> I matched the core.filesRefLockTimeout naming rather than reusing
> microsoft/git's core.configWriteLockTimeoutMS, but can switch if the
> downstream compat matters more.

I was reviewing the whats-cooking and noticed there are a handful of
stalled topics that are not going anywhere, and this is one of them.

This time it had fallen off my radar, sorry about that.    All the
outstanding issues seem to have been resolved, so let's merge it
down to 'next'.

Thanks.

Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799F5342532
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 22:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783980567; cv=none; b=JIFyfuns0DZKcVb9Obgs8qXcaXp0cdz1/HdHzRhturD3p3R1j+8F4kFyDLZaaRtAeAl6RD4WU+u37DqMpT5Bft2om9jCunm+QEFmjEzUVAj5YlWJ77+PEdtJj92O87UuqMckK5PLJC3DQEoQ5gNXokVIT20AvuwVBXqbks1Rk+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783980567; c=relaxed/simple;
	bh=bQlFVpZNpk0dL/rfjbHGsWmoM+g8b/pCViE1NHu2scA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T6hO2Mle2RuXxEJobjBM4yH7TUzLyUANl9a4eYYtkX8VsL/XGW0cBKaFzaI8A6z1u8TvFKi/zvjUMSa4fEkpoPqkysFMN4pwHzpQL0VnS11ndIHXb/yWivbOzKcSNxeHe3QOBsJZyKz4dNhPNl9HwqG6gDgBMklmRPtUNgvI3Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SDhl+daZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rfOpK2ts; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SDhl+daZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rfOpK2ts"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id BBE3C1D0004E;
	Mon, 13 Jul 2026 18:09:24 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 13 Jul 2026 18:09:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783980564; x=1784066964; bh=lSxxsvKQjc
	KrzvsvlpJ39MGy2vffDpM40siTkOnsbF8=; b=SDhl+daZ6AL22dirWZWXA2tTDE
	F91RMk2W/l9wYzWnzTdZknp/g2f+5BZwd7oqX8Hs8oiKoaqMScwjlh9+1hORvC6N
	XKDzghqbMVFee9dew5RWWGXt6Tq6tDlYgkHArNfC/+50FA6F0r757QVY7ZlMawcQ
	GOkA5bYxRgzHOjZoMvQB10czETnVqXxQP1vSSuk6NDJxpP42A0sytzksv3tncfuk
	g8onBym8U40pL31aQfD4Kjrq7zi4tB4oSAxmSzm+Sk/0ClFD+N8XjcsXeLmRqDUN
	tvnTwFAO6A4gG4/Z8UCLEDpGBtxGrZegh8oicem2YDUVKTsSsc4Chnj1rKpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783980564; x=1784066964; bh=lSxxsvKQjcKrzvsvlpJ39MGy2vffDpM40si
	TkOnsbF8=; b=rfOpK2tseKAjhoaIZBIEA+Ja+XxxbaOMRJtywSjR2dUB5TdK1we
	aS1240kWtrR6g+ciu2Xmues32o7V9nFRgZyN2HhDqhZNFjGy8qBI7RNZtUKkX4Ql
	vIwqDqZlq+BeJKpvT1dnm0u/6riBQ0wzGA+h8+6+gijyV7bmRJAwCklh27M2wU2N
	WcSFxp1zOOUHQVYJqKDJRXvyU98VWuqZeI67vJ17BG9jw7JNbQMBYs7l5Sj9XOAo
	iSS+QQmyF1DJJg+A+X0AGAn3NnTqA64Bz4Zi7oCq92BGG+JZODPKA8JzqE918IK4
	9GatNrhtfIspgV5JHlJPV1OPcX9rFo+3ZDw==
X-ME-Sender: <xms:FGJVahzuLUPDpow0rPCJrtYp6eJzPu1kI8ioiJx8XrZL09aiIStnAA>
    <xme:FGJVaoJweMOI1SWmp88uFjBgoOW67KHbCDCMBq39Z3E-UcfxwGMZd8-pQNslhXmq4
    Ft-BbBQ13_L2LV8MLaS8m5TZ_u3PuCmmt0wdwgLe_WT_D0u4vz3>
X-ME-Received: <xmr:FGJVajpGR4b6BxVSziCYv2-mk7umNoi8aTnqYLMKP1jO79VaKVROv1tjEf2TNzqFZu8jrtYfmHgW9mHsLejMqNHU7cKxHQgvryU7ygI>
X-ME-Proxy-Cause: dmFkZTGltB9xKWuVOd5v7olHQU8clLoIlcjqghq1Ri/UGwtFJ8R8c8CrMbi3qCVcn3zkM+
    tuziEJfZGzXHHMNbIJ8p78evRPwOGf691vQK+X98DkiJXEM78Ja5GPxteJGdKt1s7W2Nz9
    IZIkA6hX9Og/rIQNIl90siL6OtGMCUvQTgvJVee8OncmHwCgy9dQGKv+5CKQ01ycOt6oEd
    NrWdJ7YlLyJAz6ByKEA72VBgQoJSOOyd8/osexxGVRxwTjzFw0z55OuXH4tKhOgIBCUKJe
    FIQi7gUwSLluwEj3IVWwZcpycomzmUXaPtzKU0hDbCfHjBWr9GGP85U3a+K6kl0z5tAhIn
    ban7kshjBBdsdeVord4GtKh4egOQ1OY7uioIe4+jSdBvjgrUfoSUFC6nKyHCm44WfEpfU/
    ul2bKumt4qme1OaWvWW6U7Ce7tImy56/5lu75qaznLuhAjJx7Q48KpQH5DRb1ngYxw06En
    LNnBVR9PNidqoBO0S4FLREVihhX48L+FoT34Sse33zzdCCjmpQm4QnzReOB2WK/K+YuMx0
    ok6QUmGmblRIvQchem9aIZ3+ojk1dZQudRuHxNrzaGFyQ6plcw4sGdiNIvnj5g0McJBhe5
    8GHWqx7YXMklGlzwFRtD6BYqjmfxGILR0iF/Plnl4KTZcWA31NNJHatk7DuQ
X-ME-Proxy: <xmx:FGJVavIsisRR3ySJxprlUUDKP3wiTeY7Es0MpOwMQH-GobASGnwmVA>
    <xmx:FGJVagRMZFMWrl5gHqWOeF4IZU7UANJKVU4x6ngIV2E7XbxHJVH9GA>
    <xmx:FGJVamtPrC2U9PIdyL0593nZ0l_OqLT18AVAwC9iCnahnSx4A0uFOw>
    <xmx:FGJVapY6lZiONpGxhESRE7ceCTu5eq9QJoKIUM6x0Mlh3qZ9SfLW6A>
    <xmx:FGJVapwEsNuparoq8L6VAvvJZ-J6I-NctKJdx2jabIFwkaPqIbB227X7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 18:09:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Toon Claes <toon@iotcl.com>,  git@vger.kernel.org,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v7 3/3] replay: offer an option to linearize the commit
 topology
In-Reply-To: <CABPp-BGzU9KHGF1nipi2HZaa1AiikMKGGaapQzHVH06wO4V1ww@mail.gmail.com>
	(Elijah Newren's message of "Thu, 9 Jul 2026 20:47:37 -0700")
References: <20260707-toon-git-replay-drop-merges-v7-0-808ab9b4afa6@iotcl.com>
	<20260707-toon-git-replay-drop-merges-v7-3-808ab9b4afa6@iotcl.com>
	<CABPp-BGzU9KHGF1nipi2HZaa1AiikMKGGaapQzHVH06wO4V1ww@mail.gmail.com>
Date: Mon, 13 Jul 2026 15:09:22 -0700
Message-ID: <xmqqbjcawnhp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elijah Newren <newren@gmail.com> writes:

> For what it's worth, looking back at the v5 thread, it seems the `base
> = last_commit` rule came in to fix the real bug Junio and Phillip
> pointed out there -- that without it, only one side of a linearized
> merge survived.  That fix is clearly correct for the single-branch
> case.  My worry is only that applying it unconditionally reintroduces
> the multiple-positive-refs ordering problem we deliberately avoid
> elsewhere.  Making `--linearize` reject multiple positive refs would
> keep the merge-flattening fix while sidestepping this entirely.
>
>> A user
>> who wants to linearize ranges independently is advised to use separate
>> git-replay(1) invocations.
>
> Which, to me, is another argument for just disallowing multiple
> positive refs under `--linearize`: if the recommended way to do it is
> separate invocations anyway, we may as well require them.

Hmph.  To me, this is slightly different.  It acts more like an
escape hatch: "if you really do not want to mix unrelated things
into a single linear history, you can do this other thing."

Stepping back, the unpredictable order of multiple merged lines of
history exists even without multiple positive refs.  If you have
independent lines of development that were merged and you linearize
them, someone must choose which line comes first.  If you let the
machinery make that decision, the resulting commit order may not
reflect your preferences.

While I rarely perform octopus merges anymore, in situations where an
octopus merge is appropriate (e.g., when you have N independent
branches and their merge order does not matter), linearizing such
a history into a random sequence of N segments, built on top of
one another in an unspecified order, could actually be considered a
feature.  You do not have to make a decision about something that is
inconsequential.

So, I am not convinced we should forbid this behavior to avoid
dealing with a history containing merges or multiple positive tips.

When achieving a strictly linear history is the user's goal under
the "--linearize" option, is it not inherent that there is no single
"correct" order for these independent segments of history to appear
in the final linear result?

Perhaps I am not reading you correctly, but that is how I read that
escape hatch explanation.

Thanks.





Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B134047B432
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 22:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790808766; cv=none; b=lEpofubJP1z3ondRumS8buWrbN+FIeN5Kud4zT8d7y2uEyOSP4ayQgudhN/EherNuj5uZ43BuQHfNlv8vr6yq/JiAPTfGI2PA1joxLUom0lBj0l5I9f2WUlIWbpQC2gKlJLWFtvDhHyBMb2qD19HJAsElT9r3r7XQJG3TuN/Lc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790808766; c=relaxed/simple;
	bh=AKPwRUlGjRzfjbgYrKzWn85/5QBoNm8QrBKTz5lBBTk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=REkKbkxANjNV360IlLn38BPoTHgfxu7b5/ZNOtvwmmSutZp71DCrne9Jd+1M1ckIPGkAbOQ9MIV4dcb0cCo8+Xt7CHRV6X8FPDx+vV0UQCQEvqfuN11c9/GTrho3rQsCNYT5N+yv5tA34H/6L0j0Z9E4H6bplfXq/HQ4jROqiSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=n2a5JJ45; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XkB6XaiH; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="n2a5JJ45";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XkB6XaiH"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 79954EC027E;
	Wed, 30 Sep 2026 18:52:41 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 30 Sep 2026 18:52:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790808761; x=1790895161; bh=oriXChumuW
	xFb3PNA0uqTMl0rqx4aFmWZ3Wk1ZxNE5U=; b=n2a5JJ45kiMgGM1ZB/fviR7cWf
	vQJeFrSf8fcUj1c3zs5zKJGlADbFWDI4wTpAsa0AURHuQjf6nfjpNwvh1HKMPgZS
	ouHJDUGzi0DFYBYY01wrQpCw3Wl9WXaK7cldfmxESlWw/r/NO5U6wK2tkkPOAVOz
	NcJH1dH/mBeYa1Hagn2/9tzmPWnfnCqvhirpdO2Rpbt9hwbEXimYKvLAAMs5/QYq
	1xoou8CrU5p0EvML8Yt/3aB9KhvwHWF86FoJMyQNo2diFpP6K0GbAnog0EidHf11
	5UiimdQiLOFanUhAxVSsak9r6B3TILfzsA7+an9SiqJuIr0tTjNrXZQE/lAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790808761; x=1790895161; bh=oriXChumuWxFb3PNA0uqTMl0rqx4aFmWZ3W
	k1ZxNE5U=; b=XkB6XaiHX07cyLgYCajbLkNZRMup3RRxs6aiwfKwjBE2k+ADsXD
	XZpYVMyLwC5z12Pq3tSVg0h4h70/dAlP2eudFrwvF45B9jYIn7Mg9+XxrOq2nCSq
	dI4yGoo/f5qqNm1Mc+lcma4gZwvGmWZBFLsVQ1eP5EetoVVMkp6/54TzvD7epnmr
	Unh6Qr2WGPp0OeueNgQSYpwb1cBkEGL5N4+UaKWBTgej6vWuqR5vRdDbWzbyUhI5
	r++BKstTAMvRsWriqrQN530HBEFynVjfO0+MvSxUwHYdXX8PxHfg/4Q+4qOPweUK
	eOe+TzQQqnxJTmd4n0NdsGuYoT3UKd5r2FA==
X-ME-Sender: <xms:uZK9aqFaI-OUV5wketcGuOljJPh0lR7dUbRYFBulMNY7voo2owA9bQ>
    <xme:uZK9aiX9FAen_Q0luotUcb-xDr27YIZATMX7HS4EuYneYhivSiZAFOtPbf77L2Ifx
    mc_GwPu2jQHx5EkX8W5FJ0JgiSmaLuoghUu9JdpAVEonmCo1dYUXA>
X-ME-Received: <xmr:uZK9apIUZcEtRlulnFtACzxPKernYPAs6QyI9Yt9dVfJIGkSNwWtvYRncyKBwJgMVMMSjduybr8qWRCqsQlubhdA1dx99l9DNen->
X-ME-Proxy-Cause: dmFkZTG2MMdRyDPPvnhTQdS0EMLmLCz4dWojC7SksbTrmwUb84rD898UgGeRR79dhh9oiP
    10Ov6WLAF5kfRWSLcqxGnkHtO3tgHRD3qLDmu0eZtESH5nuOHrL+u8NI9XMTtaS/Dk7QmP
    +7g60bKlLy+d3XwszyTNsHkVmGm6ZYQ32We2pREisWcmyRR5ZwMElgghuKIw2cOFq2/pcx
    T5fqcSiThy7JWUSyx+vZQusiVy5rMP6wmlvul8ltkc+abByPKjC5AHwOlmFYUipK4wT2yf
    sPbnnbwddQ/48X/mv9diGGLC2FKMl6VAxmyQU4Q6+FeeWBAwxshC9vU8ZxJiCBhh4wsyPQ
    9jBO5Irq4ZVVGM4JJa4z3kn3wpOve1vDZe+wIpaG8IFyxhgXxoK786MqgPKi7bZLd4Us9z
    4W073hEBZbN7OewIvX0rn7dzPHRicOv6AQsxLcckEt3Xx3lL7mTeJ0jm6bVxpOUEog50tb
    U3guqFXe/3QK18V16UKBoYmIncsHYneZjzGhGoGYfHY1pH1z03fVJYGk2eZLR11t3h3vBR
    0BcTgYGE8x9ttMsOC0+fNlgpluwMQ3ITyRcidAEPONkzQJR0U7jsidc7hyjM1MLW1VyQeV
    4IQveE7B49eqx1vKboYTgbA8XMxRZE/jRWr9lM5M3TYHdoGDWYLtL/2Fjnfw
X-ME-Proxy: <xmx:uZK9ai_8PJQ0Q_8Wyjbdzbyd1nnpsmh2Idlxnvgep-VDQWo2Efyfkw>
    <xmx:uZK9asLPHtNtvMVnXvjerKtrBalHRWB5W1K6vja4Dfk-jyScruNMlg>
    <xmx:uZK9ankPNaTmiJKCcIzvhSb-txDhu0bG7JSdmOA12qh-l2xPXE3F3g>
    <xmx:uZK9agNg9U_P7OejS8QI8gqGf-nL2QnJApLXtp1PQoz3hSAL2gD0pg>
    <xmx:uZK9akrlphG_eNcX97p58ppAM5CA9yFEVCVzZfMKAlJljG10bOZpWhgB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 18:52:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH] object-name: accept @{p} as short for @{push}
In-Reply-To: <pull.2431.git.git.1790797186658.gitgitgadget@gmail.com> (Harald
	Nordgren via GitGitGadget's message of "Wed, 30 Sep 2026 19:39:46
	+0000")
References: <pull.2431.git.git.1790797186658.gitgitgadget@gmail.com>
Date: Wed, 30 Sep 2026 15:52:39 -0700
Message-ID: <xmqq7bk28i88.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> Typing "git log @{p}.." fails with "unknown revision", even though
> "@{u}" works as the short form of "@{upstream}". Users who reach for
> the one letter spelling of the push destination by analogy get an
> error.

That's a weak justification.  The same argument may lead to a
different conclusion, i.e., we should remove @{u}, for example ;-)

As I wrote in my response to Ben Knoble, I dug the mailing list
history, and I think it is a good thing to record in the log message
of this change what we can learn from the history.  Things that you
should describe include 

 - @{upstream} had @{u} from the beginning
 - @{push} did not
 - the reason we do not have corresponding @{p} is not because
   somebody gave a concrete reason why we shouldn't while the
   feature was being added.

The last one is, as Ben brought up, a very good thing to mention, as
we can justify this change with "just for symmetry, add missing @{p}".

Queued.


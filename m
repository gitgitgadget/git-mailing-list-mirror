Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EEC340A6B
	for <git@vger.kernel.org>; Sat,  5 Sep 2026 16:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788625972; cv=none; b=nqyuBWappTuzyssWpqPlkdR+CS2x552e9WwuNWFGdRXg4aD47+Yb6QTodg0bv/aJaruyLRdyBLoI0cu+4eyaT7vcXm+XHrvm3uXq8G3DTBNWWAFQXBL+Q7IQFPzWffoVsqmLAkJuQ0cPeZK343qAfK3+PeuclSqHETP0nZdbWyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788625972; c=relaxed/simple;
	bh=k+LMs+zjh3kgTLOClyFdQvamromE1bvusoUQ1uQGHYY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VJqTxrMPpRldWaqQ97MOBnnQV56DyY0RQuBe6OUJu+QljeNNAqwrmYXr3ZUm3sGoVVDoHTfiThNhNN3A+IZa10jzYUxQHoxgyWu2KAE1YFfmlTCCWG6EkJ+k12goguGWy2p9FLS+jS1th4Sv2bRu3NaYdrTrdG2UKwGV6O65B9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mdevXAdn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rPrR/3n9; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mdevXAdn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rPrR/3n9"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4AB047A0129;
	Sat,  5 Sep 2026 12:32:47 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Sat, 05 Sep 2026 12:32:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788625967; x=1788712367; bh=GilpXloc6u
	xxli4FqXTJ1WCr5xWEmVZNV8sct9cqstg=; b=mdevXAdnyNsNbS8ndh+9g386wq
	cDjOBGzvEOf0RFU+wDJienjclmkb2k9OjqVxRZyECSXJXUJyjxY9WlwbyWoXJ4Bq
	jRHqfQ2uKYkJEbFtRsnD97VWSke4Z63ERIFi8aOG7P5S6n14STuTQJZEFQQoNKoA
	Yb0AIe4585fqvuNyQQwq1RQRjFYl/jnKfmG3LDzAB7s7sCJ9uJvzNBbJirmh/ea8
	chRwAQwrM8yKJCFWwE33N6X8RQ78fSImlS6LHzpwV8VI8OvNMfAXhSFp3ZbUP08K
	d4gnlVuAJT2Rx08yl9uhB8PLX+k/rjasPNjK2kjAdpXtxQlZcuDDIs/RdUFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788625967; x=1788712367; bh=GilpXloc6uxxli4FqXTJ1WCr5xWEmVZNV8s
	ct9cqstg=; b=rPrR/3n95bba5ulTiC5nUSfNH6zKosr+BVlSbvii7zL3v52YFJK
	Z0WeVlJDKEPI90yfXPr2yt8sMhy2EkPJr64egfVoQCNt4K/dGWDcZSP1tTAwxKxp
	lbn5rdTaVOBYLu7mACGNEQc/Djb8nQ2q0zt1DGf7C7nYlMj5+3mK28X7MvF1zIzh
	+KpITqMXwxg9Vr6PimH61JkL6Sfk2Lxj8EVKGazgTw0iSRU1ENK9hS63boqICe/Q
	JWyUHQxb1zfyH/iRPToUDVKDyqedZKh+USeoBZ/xTY2grQxgaMFoYGR36gLbBGfW
	zwrqLAe8J9dLWHV5KQfjII17iTDXkey+Nxg==
X-ME-Sender: <xms:LkScagxW1KEAHXzGuLSzdWLiX_7MRWf2_AheztEpH969rzYUX1j5sg>
    <xme:LkScarJR9IL23jFJ-GphI_ep_R00n7sTEnUocm1LWa1Vng7dIAYJhjfjYtMZ2zRjz
    ydDj3ILGTjmtzRaBqupi9uvTDWqbEg1eXJziUnVIDPtCvuEBbTgSDY>
X-ME-Received: <xmr:LkScaqpHl5JhVuf-ba5uUfGGEirEOF4D2SJDSUd6NoNav3ylrtTi627LVzhlUxcD-L1i4dbQq1W2abIzy2LGMi40DjpaphB7r-4m>
X-ME-Proxy-Cause: dmFkZTEW0pCA6CZyKymC9OKjMzBB7uqvoEHhrSbiy9MDgHOOwPk8BXIa6NK9gcf8Sxe6AZ
    U8NEVJZu46HSlUMQA61kbt6boCBtUMncnQc+fg6uG/iABJlv/3tRHvPGyOwxNsGkbM9uU8
    K6rpwapPk99Iss3A0ZAxrm0fqAP9UfNrf3mdi+opDKk7olA5m86Dij2u54+tvDQCC5faIy
    rP+QUjaEnL3cFBh6Mnppjq0uTjHeKcw/38W+Yzz8ME6iaSiO7OnUInN5R2CJEOfrf0A7PH
    4DoDgIV+YI+5jdKMxEB+Yvc0wr/nMnhdjj9GzWEv9utzExDxnwuvbXzsbcEuQKgv48Q/r7
    1Q5FU/pmMxBeBKiNgEU+F0ZHj6t4cjvVbu2l0NAQ2NEFrH95FLqQX0qTzOZWEs/hkK/ybz
    hKCjkFhlMBK8WPA9rAJWkkhrUvmlTgVsUifOAnjypYHr/33DoPAJ5QBhcarnhYVn0tdmSN
    b04Rz54svyVurejy6tREqqTVM8XsNz7jkm7J9bZCeeKDoBjCuCOzyHGfe8xbI3rDcu5wdg
    UejijrMxNo9m0h5j+W5jkuAsDjcU8y8wFBdHKOP+ir8U8kH3HgAl0lUT0UeKKXhOfH3vLJ
    Z4Yo3CybiT3LBYF5mdBxMTTvLmjTwG39viS218EMCIMhtEstkSLSnyYJPDmg
X-ME-Proxy: <xmx:LkScaqJpJVe3ooMaFOTAhD0WOcg7CQvPAKOYD5_-pTqJTOH4yrfqXg>
    <xmx:LkScavRCQ8phue3vWRI9k7-JIadyG9DgcpVkeew0Q-8974IZKwjnZw>
    <xmx:LkScapsTt-F-0LiH3W99ft8bEGdrWe2SiC_fK-rCcKuLINosIWN8wA>
    <xmx:LkScagbjrWnOaUxF7G_Fcr-CNMcwukPPcYbw4rDF6S2CxjKXLLMMwg>
    <xmx:L0Scau0UzaRCiDqp_CaKkfA_lYh2cOmyYfm6Lm_ygnu8cw08s7D6sBHx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 5 Sep 2026 12:32:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  "brian m. carlson" <sandals@crustytoothpaste.net>,
  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] ci: bump debian-11 job to debian-12
In-Reply-To: <20260905135822.GA3914811@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 5 Sep 2026 09:58:22 -0400")
References: <20260905135822.GA3914811@coredump.intra.peff.net>
Date: Sat, 05 Sep 2026 09:32:45 -0700
Message-ID: <xmqqecf764lu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> Debian 11 just recently went out of its LTS period, and is unmaintained
> by the project (there is "Extended LTS", but it is a paid service
> provided by a third party).
>
> The point of the debian-11 job was to cover older releases in the LTS
> state, per ac112fd4f0 (Add additional CI jobs to avoid accidental
> breakage, 2024-10-31). Bumping to debian-12 will cover us there for the
> next 2 years.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I started looking at this because I got an apt failure on a debian-11
> job today. It might have just been a transient mirror failure (although
> it reproduced for several minutes afterwards). But this seems like the
> right step forward anyway.
>
> I tested the GitHub job, but not the GitLab one. They should be pulling
> the same docker images, though, so I would expect it to Just Work.

Thanks.  I also noticed debian-11 job failing.  Will queue.



>
>  .github/workflows/main.yml | 6 +++---
>  .gitlab-ci.yml             | 6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index 205325eb33..a0c3f53c6d 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -411,9 +411,9 @@ jobs:
>          # A RHEL 8 compatible distro.  Supported until 2029-05-31.
>          - jobname: almalinux-8
>            image: almalinux:8
> -        # Supported until 2026-08-31.
> -        - jobname: debian-11
> -          image: debian:11
> +        # Supported until 2028-06-30.
> +        - jobname: debian-12
> +          image: debian:12
>      env:
>        jobname: ${{matrix.vector.jobname}}
>        CC: ${{matrix.vector.cc}}
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 0242283c3c..cd6fd4a504 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -71,9 +71,9 @@ test:linux:
>        # A RHEL 8 compatible distro.  Supported until 2029-05-31.
>        - jobname: almalinux-8
>          image: almalinux:8
> -      # Supported until 2026-08-31.
> -      - jobname: debian-11
> -        image: debian:11
> +      # Supported until 2028-06-30.
> +      - jobname: debian-12
> +        image: debian:12
>    artifacts:
>      paths:
>        - t/failed-test-artifacts

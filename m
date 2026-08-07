Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78610231A23
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 21:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786137462; cv=none; b=S9H6hO5areC4P8AlGb4GDHifEFJHdw8ub4HVgH2rSKaZI8ae2WzyjlfSCAdbzDWl/YkFVVKi8FUN7vlGyAvyVR4pIHHigB4Yq63SZw45UQJqW9F6VBWOofZt3tLrerJwUPuc1wmu0vqKI7LZd1CqjhjduZ0sNcvBncM8aZ55SVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786137462; c=relaxed/simple;
	bh=ZF8Hyt1Wo60sI8DJhjULORtIoCTfCuYQ4G9jo+fyX1E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bw9LKiWzvik//EhMoqiy1lt4EvatAPFJQm/MzjoZoipbLr3xlIaRF+N4tXA9BDFYvOWdiouOgbTBRvkSVNhnS6RpxV1B5l3C1qxkSbgQ7Lkpjzq4Ale0I+pq+D9lHEcU8/+cR6ZqYJWjeFAxA01NNMx79/lLUIydgLoF7xYsc8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DOiOADVX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mXIPDEx5; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DOiOADVX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mXIPDEx5"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B658A7A015A;
	Fri,  7 Aug 2026 17:17:40 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 07 Aug 2026 17:17:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786137460; x=1786223860; bh=T74NvYepvk
	CY+XotSOI7NmVp56ABSOi2sZWL2NTMJXU=; b=DOiOADVXTb0IvHdVDH7fZKHCK8
	yOsaQkq2JDasFG8xgXSudcagG3s+DIK3NKrZfQOkk6MmPSzrgr15N2w8E83rb1Oy
	NSZU2y8fybHX8VBj29jR1+uVlL2Abjm7SZLtkmlvAAR7GwY4zYgncvowr9rHH9/Y
	9bSt9Hor4Cm0bXGM8IfFHb6QurMNK3QGctovQz1jfcYTElCW5Q885Im1579xSLny
	5aWqA/JpBJwydjzFU5HfnMlKlIqSYD4AVd3tC9nnhQQ4b/hCoFccXLq6WOb4iWsG
	VeDXE6EzJAh1ULHLV4H+NwRazzuWIlYFbLi/+LfL5xIGfqJ9z4rc2Mxmb95g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786137460; x=1786223860; bh=T74NvYepvkCY+XotSOI7NmVp56ABSOi2sZW
	L2NTMJXU=; b=mXIPDEx52hh9EVjiBrF8qf6qkDoD35qoeFhZxw1X/h90XphjfOG
	7k/tFc1tBnvjltViizYRaK1S9kimbFWSgILWB3zh8pRRXBOnx4/5Nl9oLsmSuuy1
	HsAMgU1lOdDCYKI6Xf2OFtlD1ZD7GUjqBB1zrOtl25X51PDE3axvAdSd/V/yRFZs
	80LqDrIVcC1RfYELMiTaHQ59zHTPZvmdHoLFkLH8kUThOLEi3a4IH/AoXVZqutjc
	g2wLJzZfXqdiWbkgWv9qKomWm9zxPREYhpn0saInuE+xtKCFUnqMNS7R4mS8Kb7P
	znMxrWfZRUQDb1G7MZ99LiDl6nwYnBSKUJQ==
X-ME-Sender: <xms:dEt2aqHJBvtyEVVTIQ0tQjj6SrGj1Z-_uMLMkytSegXZ1JeiwYE78g>
    <xme:dEt2atmDRHi_SY0x6juCMbNcQMtaL1hvp81k8PLay3WlY8luweqkIDUOqr907bQay
    ahal5vtCysboNIT0cvN3a_dvcqOCRFlngZxWhY5xRHheM9aK__c>
X-ME-Received: <xmr:dEt2amb18Gimi4_MMeaNyKnx3AY_S-Ebd3cdgI9mZpS2Z7Ep6ESup6Ge_blDYnnGHXmMPV7H3e8DEngbq0YcmMYL7-gO85K1GQ>
X-ME-Proxy-Cause: dmFkZTFHJAFmjvideK+NYc8grSKNI1YRTPk4ZuSIYtC0Tfvf25PP5RCClygqJk9HfZXQ+H
    mU61l10pUnn6oRXG39jp+qJ7yg8HH/jIBFry5WohgDVL5vA+Xis0f2LKv94YMVbpJsSoet
    /D2uJbSDQHtMKn4Rv4eIbkwGZdYadPeFhx3kXeSPVEA2gJk1oThPle3o0NUQwnxo3Td9q5
    iEFas6rrtIUwHbwvccFNTFMFC4GRylI1nbldOr8S1hFwHCKJkOMYQlScxMDjhFuGE0mtxU
    Mz5i004ETgwYNo5yrEDOkbFhv02QjifwXbvmSqtypYzmX9WTEU0bchodFO5eRP1ouBzNCS
    9EZEfmpJHbgqVUnIf09cPLBTiE47RYIerkipZVmNzn1bzhr1ogDNRfMOjd8QG2tdgzJf3g
    GE5P+r48WF8mpYphT3W5UoPiNebKzK67pwRU98gaBFxLp1LKyJMtXUsATjGYaH3vVFEdvR
    6IYkJprrsPWshcm8xFZpns0AjkvDaLHVtmuX1v9YO28Rr8SGZ2/0ITjIBuYJmr1dlOcCTo
    W+b6HYbRjPPnC6EjHpmo949NT0Glwut+JxEr6wA4hhOSjJrkLp3r6+OeN2sCw5ckPMMGKR
    k3+P32mc+FTWR/2li6hvcL7Z4vCW2QQM1t3hup0V2r4Nk6wsl4SmhwyGkOUw
X-ME-Proxy: <xmx:dEt2aqGOyWeW8idEbcy3fncAZk7fz0Lr49YipgnmQyY-aqF4sjuSNQ>
    <xmx:dEt2avI0F6kEa7ZN9ppKBkLUQjngKmI7Xx1aKGpnvJPpfI7OWJiCdA>
    <xmx:dEt2atNW2NXgR7ANR270ZcKy8JrRyXzDrGI1hjlLWfHUZ2CC6NALvg>
    <xmx:dEt2annlfONGULZwup3d6T7gKYovTs5D7ywNT8uNTshgW-haaroQTA>
    <xmx:dEt2asEps0VMerwKd7UtmEHqmXTCKBhZqp-8QsvAEvNnAmSH8LLKD7yf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Aug 2026 17:17:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org,  Tian Yuchen <cat@malon.dev>,  Todd Zullinger
 <tmz@pobox.com>,  Patrick Steinhardt <ps@pks.im>,  Olamide Caleb Bello
 <belkid98@gmail.com>
Subject: Re: [PATCH 3/3] core: convert build-time USE_NSEC into runtime
 core.useNanosec
In-Reply-To: <dbbd96d50811e4c2decb6f754b56dc1f7ee0944a.1786103607.git.ben.knoble@gmail.com>
	(D. Ben Knoble's message of "Fri, 7 Aug 2026 07:56:26 -0400")
References: <cover.1786103607.git.ben.knoble@gmail.com>
	<dbbd96d50811e4c2decb6f754b56dc1f7ee0944a.1786103607.git.ben.knoble@gmail.com>
Date: Fri, 07 Aug 2026 14:17:39 -0700
Message-ID: <xmqqv79ld40c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

> Racy Git problems persist today, manifesting themselves in the
> performance of commands like "git diff" in new worktrees [1]. We have
> long had a build knob "USE_NSEC" to tell Git to use in-core nanosecond
> precision when available, which mitigates most if not all racy issues,
> but most builds we know about it don't use it. In part, that's because
> someone distributing Git can't safely enable it at compile-time if they
> don't know exactly what platforms their distribution will be used on.
>
> [1]: https://lore.kernel.org/git/CALnO6CADMJSixqYvL1Yo8qKX5rWhKQ+2OoSEuPUh-yoeK9TseQ@mail.gmail.com
>
> These days, most platforms are likely to be safe for the USE_NSEC code.
> Regardless, we want to give users the ability to benefit from it. This
> requires exposing the compile-time gated code as a runtime option.
>
> In addition, update the Racy Git documentation and other mentions of
> USE_NSEC in the code.
>
> Best-viewed-with: --ignore-space-change

Don't do this.  It probably is helpful to have something like that
below the three-dash lines, though.

> Signed-off-by: D. Ben Knoble <ben.knoble@gmail.com>
> ---

> diff --git a/environment.c b/environment.c
> index 6676e6f5ae..e6a50060e8 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -571,6 +571,11 @@ int git_default_core_config(const char *var, const char *value,
>  		return 0;
>  	}
>  
> +	if (!strcmp(var, "core.usenanosec")) {
> +		cfg->use_nanosec = git_config_bool(var, value);
> +		return 0;
> +	}

OK.

> diff --git a/read-cache.c b/read-cache.c
> index 6c449f393d..297646c357 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -353,15 +353,16 @@ static int ce_match_stat_basic(const struct cache_entry *ce, struct stat *st)
>  static int is_racy_stat(const struct index_state *istate,
>  			const struct stat_data *sd)
>  {
> +	int use_nsec = 0;
> +	repo_config_get_bool(the_repository, "core.useNanosec", &use_nsec);

Yeek.  Isn't this a relatively hot code path?  If it is, it is
criminal to force string parsing and matching like this, every time
somebody calls the function.

Doesn't istate know what repository it is working with and in there
you should be able find its repo_settings struct cheaply, no?


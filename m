Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C57470E8F
	for <git@vger.kernel.org>; Wed, 22 Jul 2026 19:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784749755; cv=none; b=KN5voiHaVjA718hnP/ceaofazDsnRYJF1MCOFJOD43E+5XT2pDTQbLcJPYrCKcDhhHIOPObBDeF5a7d6Qd4KGN7A/BGJ+X8cSoHlkNvGOK/BrNEvnE9Z+byVquysBYarhhTjUq8nFzWIse5hAj0I+VPMcQaEv/UJvvzCDe5aYvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784749755; c=relaxed/simple;
	bh=XgnjZwXfD1vUv2yxUqeSvN0B82T6rG2DGC14c9GvkMU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ESbeX47YI1B1XPuY8CY6JiRRQcgnlPAdxm7eC4nJEIR8mkvBa6pvW7UX82ONS8WWD96nlPAeR7LQB9ORFBAvOShScuOKSuOAgYmEvmyBI9Pvf/cwxGUpa+RQTf+cSKlUf9UHnMNcJxtvUTS1FPfKA2BIXmsYAJH4THyopa1x5VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=h/NWQYqq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mIhWMAE0; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="h/NWQYqq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mIhWMAE0"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id D0636EC011B;
	Wed, 22 Jul 2026 15:49:12 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Wed, 22 Jul 2026 15:49:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1784749752;
	 x=1784836152; bh=4WcZbofvBkR+OTrLCou8yioExPuUUuj6Khn0b/cwrTc=; b=
	h/NWQYqqEtaceuulaFLIJqQ5L63G3pCAPk990yBnt4HzrJdRjoDXQR6d7P96UriV
	RmwOWcsYbzt6iVeuS7ZZuUiemTYLKjiL/nYKk8FFqTc2QfDJ1+l8HKiPGOVchj33
	FZo7xpW7i8quc7wuLydqRlBTMKmDX3RgSmNcvzxJ2bfbzzS2n/tsjioLzXuLtUlH
	UL/BBif9pG07cETEPodUj/5aEW7A6EI4qBVOqnwhgSNOb4wngyyMslfCX4M7RR3t
	yJPlYuWP5KFDq1iddenzZ3s54BzmoCnrO5DCva4/NSYCfowsyRMIphJliUNtdQ9b
	KdSDHYacS+yKIwHOvqebQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784749752; x=
	1784836152; bh=4WcZbofvBkR+OTrLCou8yioExPuUUuj6Khn0b/cwrTc=; b=m
	IhWMAE0+T7CvDfczSzV+l6dj3lJhgP9o44ZUS8eYeKXalUM7mcN/9Z1PLl0vAB0p
	0Vn7WdsjmqSFQbCiiFEurvp8AZTnyPvq5FMTG0e4DgJpKF53Z2cmfTmMUt6vtXBX
	Ay/cGYAsVEh3+/z9gGJ1UafPeIcuplMRa0Go33D/xkhcasXkqSRQ/Odd8M+WNEIa
	RSVN51YlRoAwUuJGvFKDpaOsyMROoLsMp0FvcJIyvWFX7cs2Vi3uf+WNI6wMpj96
	1SaEq+lM4OXyj0mgwfwMlzSl+fv3MS12r1FLbT0bffJgHr9AmnUKLEAAVDKybJ2h
	qn3XALu3cEz549QYySolA==
X-ME-Sender: <xms:uB5hasVyX-8h58LxQsp1LRCUl705BW2qQeVdROSo0HBseIC_DI3lMg>
    <xme:uB5hanmci7McY45w0-LlKZtcr8BthrpgvleTHQSsSHqSTYqnGOv7MAKKF1tnDg2_M
    lwml2zNY-OZcxXmKawSmvcU5CZkf7I0-6FRbzzVZWXgzG3aMenVhg>
X-ME-Received: <xmr:uB5halZjfHyMJxgbIlML-UNAzYS5Cvu2KirpxyMxrxmXW8bEYOMtPebSNvKmcCXAtLnRDuWu44JFsakm1xbU4EDhgLM-0wvBaQ>
X-ME-Proxy-Cause: dmFkZTGtYD+tZUQb7h7SQ1hRT58luX8jI0bTlGMM4a4HcxcfsXAa598eU6i8mO3Q0sgsZw
    v+ek0Ymrbr9/ykB56Z1sfQPMq1JGWEhBKWNx6U/OmfVghHSuz79FB51raYPPu3Fat99PoE
    +W4IoMZpm28Pap4M9qi/8vKEnzbBr5qTvCHL/K9hIyUCVlzG2rTYBj01seuwccTkqD6mVu
    ObIKuhcc6SfT/EcCKkQf6ruhhDRsV35HxR0W67TrShlc6s1kOZjJqPE36umo/OGHnFERFM
    Wpk4zDKnsvUfEI1+BU0Th2zYgazXW/rC9ZazpkKmsvVSFE+3maJn9YK+xDyZOGdU6MH9Jb
    lOKae45ZyEkLpn2DYpevmBPfBT9RYjBPo+CUZqSAxWtuORRIdaSKABVpt288XVv6KB9p/Z
    xCI0U8MEtIJ8/iSdDP03xUWPjzLblFr3zYLqYr3YtoU3xTo6f6tUunVfB/f+QeS01zr9TI
    X1yEvojvcg9eWQOK+mUB6mBnsHrNEwmWVY+IAAEqbixtJr0yiYaEYc1Oc+Mye7eDGi76tC
    syReaQuibdJdwbJnIIk4dbb/FAmYP6FgE2KA2ervl7XIg6iuBzJPDHI4jDuX/xVZBqpjZM
    eQIzqH1Kx7DpBQtolw02psVyHz5Ai1M1FZQgJg+FUFKm0uy9MguEvtFXm0mw
X-ME-Proxy: <xmx:uB5haqOdncIOlTu0IEP0i040l1DQ2pLCuQNTf-rzBZSgZME6jd3vrA>
    <xmx:uB5haibGQdKEBJMoOg-3nWSE83EBxMlPquUUGe2No7DdSc0wPNcWDw>
    <xmx:uB5hag3QpYuOizBt3Uk_pNtEXgjO6Ax6Fm0JqzmxGvNdl1-y3tziCA>
    <xmx:uB5hagdXbAjrA-kNQhvxUmjZ-oZ693jT3QOfhrLf6Jr-UNl08ptkKA>
    <xmx:uB5hag7RJkQRjtV8kx2bqPSnIma0sHyYNAB741rS0Cfx-3uvB4T4ES_A>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jul 2026 15:49:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?=C3=89ric?= NICOLAS <ccjmne@gmail.com>
Cc: git@vger.kernel.org,  Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] submodule: resolve insteadof-aliases when matching remote
In-Reply-To: <20260721213042.3357346-1-ccjmne@gmail.com> (=?utf-8?Q?=22?=
 =?utf-8?Q?=C3=89ric?= NICOLAS"'s
	message of "Tue, 21 Jul 2026 23:30:42 +0200")
References: <20260721213042.3357346-1-ccjmne@gmail.com>
Importance: high
Date: Wed, 22 Jul 2026 12:49:10 -0700
Message-ID: <xmqqbjbyole1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Éric NICOLAS <ccjmne@gmail.com> writes:

> When ca62f524c1 introduced a mechanism to identify which remote is to be
> used by a submodule, we had it compare the URL stored in the .gitmodules
> inventory to those of each available remote.

Please refer to an existing commit using this format:

    When ca62f524c1 (submodule: look up remotes by URL first,
    2025-06-23) introduced ...

> However, when using URL aliasing via url.<base>.insteadOf, we store
> in .gitmodules the URL pre-resolution of the alias, whereas the
> corresponding remote set up in the submodule reports using the
> *resolved* URL.  This mechanism therefore fails to find a match then,

Since anything involving the .gitmodules file is often security-
sensitive, it is always a good idea to go beyond just saying 'X fails
to do Y.'  We should also explain why that failure is a bad thing (or
perhaps a good thing) and for what reason.

If this aliasing were controlled by a remote entity (for example, if
an upstream project modified the .gitmodules file to redirect us
somewhere unexpected), failing to find a match could actually be a
safety feature, shielding us from bad actors trying to hijack the
local repository.  Since that is not the case here, adding 'fails to
find a match, which is unfortunate because...' would make the commit
message much stronger.

> and resorts to the fallback logic, which does use either the only
> configured remote if there is only one, or attempts using "origin"
> otherwise.
>
> Resolve the alias in the URL inventoried in .gitmodules before comparing
> it against those of the corresponding submodule's configured remotes.
>
> Signed-off-by: Éric NICOLAS <ccjmne@gmail.com>
> ---
>  remote.c                    | 15 ++++++++++++---
>  t/t7406-submodule-update.sh | 21 +++++++++++++++++++++
>  2 files changed, 33 insertions(+), 3 deletions(-)
>
> diff --git a/remote.c b/remote.c
> index b17648d6ef..ae187fb3d6 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -1821,17 +1821,26 @@ const char *repo_default_remote(struct repository *repo)
>  
>  const char *repo_remote_from_url(struct repository *repo, const char *url)
>  {
> +	char *rewritten_url;
> +	const char *url_to_match;
> +	const char *remote_name = NULL;
> +
>  	read_config(repo, 0);
> +	rewritten_url = alias_url(url, &repo->remote_state->rewrites);
> +	url_to_match = rewritten_url ? rewritten_url : url;

Being a bit lazy, I probably would have just reused 'url' directly:

	if ((rewritten_url = alias_url(url, &repo->remote_state->rewrites)))
		url = rewritten_url;

This lets us avoid introducing a brand-new 'url_to_match' variable,
whose lifetime is essentially just taking over for 'url' anyway.

>  	for (int i = 0; i < repo->remote_state->remotes_nr; i++) {
>  		struct remote *remote = repo->remote_state->remotes[i];
>  		if (!remote)
>  			continue;
>  
> -		if (remote_has_url(remote, url))
> -			return remote->name;
> +		if (remote_has_url(remote, url_to_match)) {
> +			remote_name = remote->name;
> +			break;
> +		}

While the new code preserves the original 'first one wins' behavior,
it does make me wonder why we do not issue a warning or raise an
error when multiple URLs match.  Leaving such an ambiguous
configuration unflagged feels like a silent bug waiting to happen.

But it is of course outside the scope of this topic.

>  	}
> -	return NULL;
> +	free(rewritten_url);
> +	return remote_name;
>  }

Thanks.

Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5EF2F6911
	for <git@vger.kernel.org>; Wed, 26 Nov 2025 15:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764169339; cv=none; b=IVzjU0W0mSdJupvFVCsHBBdXgr0TESphKa1u5ArOmVHPHtFMKSxPoEUUJm70gBU2YC5yCIDy2yDAYfLKe+X3H4eayL0+ruOAqRN1M5KQ+zFwtsaHHuhDDjlp8SlztYfLZEn+IidYfLGih58GIvwd2gJt7/pSmjf9C1xtKTTvk8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764169339; c=relaxed/simple;
	bh=vCwNgciJU4qAD6Hie9bHViWfslsml9j1lYOaWipz62A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ulcuddkUJNtE0Z2HjApOIAQ9l08+c3KYcl0iMfGfhAK1e4ONK3/c/NiK22mqC5G6il3zbE2MIBx2O8MuuBF8gvptxIFSIoT3tdTZN0nS8rize+NeA/I0mvpC5U9gL+bcI7k9TU4AMt5oFkZsQDR/sZ1L9vp25CCClwh7PUTYweU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=hIskrFXg; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="hIskrFXg"
Received: (qmail 107298 invoked by uid 109); 26 Nov 2025 15:02:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=vCwNgciJU4qAD6Hie9bHViWfslsml9j1lYOaWipz62A=; b=hIskrFXggSqt2fRuv5Myn0kTwOVG2eOCsd8Stgj3pu0OO/OrD15ZmB5ui5GZhAH3HuKqg2RZkGPeSHfyzGVNORmjHWI5ed/lcNQHJ8j008SMr4aWvl/kux4bXAvs9ZyMqa/eEFGii9VC3xHRNf1Re/hNTcvgtt30Reb0LE2OVFLx5GK2Q5fevHTnad1r+kLDMzFG4jOKspwBPYxAUbqq57HFqBRicrqfDncFsbr5io2rqEg1V5vFSO8QaJ/DFP0cpKdCYqbZ0kvjHQX6GbkWs3+ibydlu2qwT+tAWt1jHuocZhxbQ3IBb2WglswvD2mEWCVySrtNSpc9+C98k2MzTA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 26 Nov 2025 15:02:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 189820 invoked by uid 111); 26 Nov 2025 15:02:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 26 Nov 2025 10:02:16 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 26 Nov 2025 10:02:15 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
	Ran Ari-Gur <ran.arigur+git@samsara.com>, git@vger.kernel.org,
	"raa.lkml@gmail.com" <raa.lkml@gmail.com>
Subject: Re: [BUG] `git clone '-c KEY=VALUE'` no longer works
Message-ID: <20251126150215.GB4143292@coredump.intra.peff.net>
References: <CAN1UxBvk_GJjLWd0XexRxp8FFhYozGCNcodai0eqnjrhjKEh7Q@mail.gmail.com>
 <CALnO6CBJppT3ELyu54rJvP+uqcMomJS9Nr_JTgfssn8iqG7MWA@mail.gmail.com>
 <xmqq8qfvw2lh.fsf@gitster.g>
 <20251124235530.GC2051672@coredump.intra.peff.net>
 <xmqqo6oqucka.fsf@gitster.g>
 <xmqq8qftrcqb.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8qftrcqb.fsf@gitster.g>

On Tue, Nov 25, 2025 at 02:03:56PM -0800, Junio C Hamano wrote:

> The first step of the "right right thing" may look something like
> this.  As this thread analyzed so far, this awkward lenience exists
> only in "clone -c <key>=<value>" in that the keyname is trimmed, so
> isolating the damage within the clone's code path would be the right
> approach, if we want to keep this awkward lenience alive a little
> bit longer.

That's not entirely true. It is in any code that calls
git_config_parse_parameter(), which includes the old-style parser for
GIT_CONFIG_PARAMETERS.

So:

  $ GIT_CONFIG_PARAMETERS="' foo.bar =baz'" git.v2.51.0 config foo.bar
  baz

  $ GIT_CONFIG_PARAMETERS="' foo.bar =baz'" git.v2.52.0 config foo.bar
  error: invalid key:  foo.bar
  fatal: unable to parse command-line config

That doesn't trigger via "git -c", because we use the "new" form these
days (so it started rejecting the extra whitespace in 2021). And you'd
only see it if you hand-crafted the variable, or an old version of Git
set parameters that were then parsed by a newer one.

So whether that is a case we care about is up for debate. But if we are
going to accommodate backwards compatibility, we have to decide where to
draw the line.

> diff --git c/builtin/clone.c w/builtin/clone.c
> index c990f398ef..4ea8c92a6b 100644
> --- c/builtin/clone.c
> +++ w/builtin/clone.c
> @@ -779,7 +779,26 @@ static void write_config(struct string_list *config)
>  	int i;
>  
>  	for (i = 0; i < config->nr; i++) {
> -		if (git_config_parse_parameter(config->items[i].string,
> +		/*
> +		 * NEEDSWORK: a backward compatibility wart that made
> +		 * us tolerate (note the leading whitespace before
> +		 * the variable name)
> +		 *
> +		 * $ git clone '-c foo.bar=baz'
> +		 *
> +		 * and treated as if the leading whitespace before the
> +		 * variable name did not exist.  Apparently a third
> +		 * party tool "Bamboo" relies on this past stupidity
> +		 * of ours.
> +		 *
> +		 * Eventually we should deprecate and remove this.
> +		 */
> +		const char *trimleft = config->items[i].string;
> +
> +		while (*trimleft && isspace(*trimleft))
> +			trimleft++;

The old code actually trimmed both sides. So:

  $ GIT_CONFIG_PARAMETERS="'foo.bar =baz'" git.v2.51.0 config foo.bar
  baz

  $ GIT_CONFIG_PARAMETERS="'foo.bar =baz'" git.v2.52.0 config foo.bar
  error: invalid key: foo.bar
  fatal: unable to parse command-line config

And I think the latter would still fail with your patch. Again, that
might not matter to us, if all we care about is making:

  git clone '-c foo.bar=baz' ...

work as before. But I'm still skeptical that is worthwhile (especially
given that nobody noticed the same change to "git -c" a few years ago).

-Peff

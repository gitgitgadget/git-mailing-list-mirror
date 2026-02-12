Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA8C17B50F
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 23:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770939979; cv=none; b=ZnK0LeUyImYRp7q5lrxvvpW8EG7I2Nh4tBQ4HqZptywmGsrP390+TlrpnaELcZRCgHFomjD6icNsvp28QQzdlETK/8gsvrXcCktRIiQh17WqrSApgvbNUxRN8YMz1B+AiTMBWx0Kw1pa45NN3X6fxCaFpKnnOkeRNt0IGv9Xhec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770939979; c=relaxed/simple;
	bh=nniJgT1huMRKpbNQXQuFqmO1CS78cA9leAn9NhEsOXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nDCO4hW07irDoY0fMglKFbNHCnxcrXFd/0lPqkXe1cM0bvALvwC22KPQ83uMHtxbjsjlWFJe/JIcekT9Jnf39gsQ0yMajPZS4mjsV0mpvMH1G/MTXmWcY0P6SdRhTsQ5T7yUkruWfn0a3GapkTFIogUssCfH/LnjLLd8ubSvhRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=FgLJv8P1; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="FgLJv8P1"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-796d68083cdso6367577b3.1
        for <git@vger.kernel.org>; Thu, 12 Feb 2026 15:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1770939977; x=1771544777; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C3PU2VW0f2HQETsY8ScQ5DoHmPYb6Vh9vxp6AqiWg68=;
        b=FgLJv8P1QxkcLI62/pIrLLHToPA4ekRtWRDKHeSSqTFfr/qrnIGlPsoPHPUIaQc+wc
         GLHTi0tVEbIVkHJ7QbkLT6RUwZALxgCQ+BrxC4GFqhgaqF2gQjJqiYWVMBrtEh4QXx45
         +X67LFmQhj7N7e9IFO0QweiX9mbJ9f/LVsP7YOq9+8Ars+Pl25wKaPaVxQyZaQpktLEp
         SY+MGyNEM7qA1ndUYQg2n1+R8gSFMhvIXuLJMYrowYn31f/AqUGiYMUFvDIRilwnoh3E
         KoshGCEL5wuINBrL0dWcPrYBwVfNO2Nvy/2WmGnIWpHcuWM1B7KBoMdODydp93lF6Nhx
         RZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770939977; x=1771544777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C3PU2VW0f2HQETsY8ScQ5DoHmPYb6Vh9vxp6AqiWg68=;
        b=IJIOOM6OS4Jpl97+t8USu9exRM0VveEyDlpHNZUEY3BGptejz8Qypm90RQfgyCL8V4
         qF/C/FURDGJ7EZ6R65qTj7F3Q/5midGD4hTBteI0hIMe5GmrUdBD9rsWGHFc4R0n20Hb
         N/9+wyLMnjM+pVWmn2vEtPrzRtKuYKAkyBupwa9JQJa6EI284qfGRI+CHBh1cj4O+dZF
         tRFIWoNljJPpi0WcpcL043NJDEPYc01c+BvFhVpHJQzfZPnTW4JYjvKyTaYQ43YCTF+j
         aazy/Aq0PkYQ2Q8K46fR6irgp7Seoyk4IP2LAchkGPHD0H7D+QeqEgreUw4EVqSBboSR
         ypjg==
X-Gm-Message-State: AOJu0YwQSVP73TxO6Lgmt0/EhNhsBuCd4NgrxhmteTccxVZ7Tt7RF+Xz
	K6Yzi4w8UnNq4S2eioCWIjcrFn0wCSB2dnmSyg4sugIrNPHipvaGpUYyvcMIl6ZiG+DyoVUIe3m
	1A0Qhi+6Maw==
X-Gm-Gg: AZuq6aL0YbPeBGrU0qxTH8Js2CHXuDxOp+HgLRW1qzDAr7QW8z7kKn1rJqSTBrpYgHq
	XQJd3B195m34WREgX+Vyk4eVRe9/SpHEW2cmu9YyyAg6H1friy2bFS4wumQU1nSRLkhUvqbGslz
	C7EYPrfaYkdswkbiVKc4KFqAmM/hCRpgCU5xPOAdCeSLG3dGrSisPS8eTUv8dA8BLpeBVPaiq/B
	AIbLCQjVBxgw8ztxFuNr0jRiCw4qI8nH7AfM/bdMKmjlzTZd490pz2N8/P9nrqGr6ATJt/DeeuB
	I7rbnb3us7e635QuF2WpNNj9ckopiSpqKa1rXnSp8H2C7UyuHJH2lB4f979HGU/vuPxVZD/9z2W
	fbFh5RKn6/5hPrU2WE2oTlKRYsdGrhkvETP5JKzm2hvAY6FATc6bb2zLh+tbsCL/Q/GSzWW6teI
	ayLwjACMj4lW7AqWWF0RRKRphNhxdAowV+QglaQ2ldoXDNd1ZcG6O0OqQIf7Bwk+fkOQ+bhNwle
	RFNG5YfCWMQnpsUi92rDlE120IeSA==
X-Received: by 2002:a05:690c:c510:b0:796:2976:a466 with SMTP id 00721157ae682-797a0c4fb4cmr247907b3.18.1770939977272;
        Thu, 12 Feb 2026 15:46:17 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c254d1esm58408637b3.41.2026.02.12.15.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 15:46:17 -0800 (PST)
Date: Thu, 12 Feb 2026 18:46:14 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Lukas Wanko <lwanko@gitlab.com>
Subject: Re: [PATCH] builtin/pack-objects: don't fetch objects when merging
 packs
Message-ID: <aY5mRiYr7icW4lE2@nand.local>
References: <20260211-pks-pack-objects-stdin-skip-backfill-fetch-v1-1-870cad56d8ae@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260211-pks-pack-objects-stdin-skip-backfill-fetch-v1-1-870cad56d8ae@pks.im>

On Wed, Feb 11, 2026 at 01:44:59PM +0100, Patrick Steinhardt wrote:
> The "--stdin-packs" option can be used to merge objects from multiple
> packfiles given via stdin into a new packfile. One big upside of this
> option is that we don't have to perform a complete rev walk to enumerate
> objects. Instead, we can simply enumerate all objects that are part of
> the specified packfiles, which can be significantly faster in very large
> repositories.
>
> There is one downside though: when we don't perform a rev walk we also
> don't have a good way to learn about the respective object's names. As a
> consequence, we cannot use the name hashes as a heuristic to get better
> delta selection.
>
> We try to offset this downside though by performing a localized rev
> walk: we queue all objects that we're about to repack as interesting,
> and all objects from excluded packfiles as uninteresting. We then
> perform a best-effort rev walk that allows us to fill in object names.

Nicely explained. I think it's reasonable to ask "well why are we doing
a revwalk, you just told me that --stdin-packs does not require a
(potentially expensive) traversal?". I think that the exposition you
provided here answers that question nicely.

> There is one gotcha here though: when "--exclude-promisor-objects" has
> not been given we will perform backfill fetches for any promised objects
> that are missing. This used to not be an issue though as this option was
> mutually exclusive with "--stdin-packs". But that has changed recently,
> and starting with dcc9c7ef47 (builtin/repack: handle promisor packs with
> geometric repacking, 2026-01-05) we will now repack promisor packs
> during geometric compaction. The consequence is that a geometric repack
> may now perform a bunch of backfill fetches.

Great find!

> We of course cannot passe "--exclude-promisor-objects" to fix this

s/passe/pass, though I think Junio noted this below.

> issue -- after all, the whole intent is to repack objects part of a
> promisor pack. But arguably we don't have to: the rev walk is intended
> as best effort, and we already configure it to ignore missing links to
> other objects. So we can adapt the walk to unconditionally disable
> fetching any missing objects.

Yep, I think this is the right trade-off.

> ---
>  builtin/pack-objects.c        | 10 ++++++++++
>  t/t5331-pack-objects-stdin.sh | 18 ++++++++++++++++++
>  2 files changed, 28 insertions(+)

The implementation and test look exactly as expected. Thanks for jumping
on this and fixing it!

Thanks,
Taylor

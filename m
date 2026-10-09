Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD0E1F09AD
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 16:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791564667; cv=none; b=uuwIK1ELzTjQtr9Ymga2unveJi/gpo0qEpQG17gaBTcYCYsJ9bZu1iWT2HQTs6T7Pe6hPwoqHCL4gks1L41bTAFdKaRW9QhAtE0b4+DR+CxxFPPHJxQFLzbiWjA1kC6ziQWFemNszQ/YyJk6ryjeXWRgtUmaPIa6ZxcYtYVBcJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791564667; c=relaxed/simple;
	bh=EsjXLmxM+aPw/3evNYHNx2aLf24PKrZwHyPrlt2LLgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VM62o6pZyXtLTASEAkQ8FXry1k7wQ7RMMWG9+TJfXWF56N1KstQXMaXiwc6JWtROEIJ4UJErtvwp6nrysu6sVQ6yrhtTZsTpiATZRB9Y6DGXo/CERE97e1TR2KMDmrd5kRXWcQBcBxic8+5MDvPtLHl6Hev2vQq4lpEyE2WsWMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eD5t034P; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eD5t034P"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-49e1d10ccbdso13993fac.1
        for <git@vger.kernel.org>; Fri, 09 Oct 2026 09:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791564665; x=1792169465; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DMt4WFTOijti5H/f7kWOQvn9lglY9ZtP85mYKb85dFU=;
        b=eD5t034P/OsEIsJ7f148q9Fx6tW5g84KHjkwOZGwVP7r7SaXi+wOBY5iqR+SRS+IKu
         f+JwOshIb69oAFn8H7clEWEsVhjr17ynUetfZeFF+tfG7vUtD1hzFNWSSrS0rPWKUPjB
         KMKluqGJToTiF+Yw2iWxdTzbQCIV5jqeWsXdLgoSSQDLCq9gHzXVHJBA5BQywk1dNibM
         49QzLgHQDS0uVyn7tu3fxUwpA5qDXmTuKkieUs0vLJLKeDVeVx1pBAg/opLBxgL2Vu3g
         wYYRmWDvV9gGzcrwCZNtoW+Wkmw6ANmfNL6/ULlCIKjILL/s7rmv9/QE1JVKUJ8cdOhL
         C/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791564665; x=1792169465;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DMt4WFTOijti5H/f7kWOQvn9lglY9ZtP85mYKb85dFU=;
        b=pXY3JtJUySPo/vda+3VOqgkAkjK/YO1JXSJJTcGI6Rk5yHApIBjhqcg7AcQHDgxw8Q
         F0NrfDwOmVZ8p2zNh9ECli9v3Pu4pm89vuqjHJseUlFa63o+PbN3Du/NuqSldPo5q5U2
         c5NYB6qZg38FY/SFf2kbTdqDTkmdrKB5t/Ptzw4wc2vrNU/j+yIJn4j1xb86WtREZW0d
         mJ/7tOwmAHB6577qEzaqKXt0XsW61LcQNpsPtmclMJc+v655YPlIB5KAZc4K21uo6dGc
         KRkznmQ2kfDrIMULhycx/z73TRkdx4vBtTQWCz48VmcfzgqMAJa9jPBAAhEgkoeG02F8
         NDOw==
X-Forwarded-Encrypted: i=1; AKwUvBw/lrFLkQu5/CkcCvhMz/DEAqqfc0wFzzj8iC9x28YaZjdt319FqaoWVisT2XdUf76wdK4=@vger.kernel.org
X-Gm-Message-State: AFuF++k7aSTK9ZhxOOM6zeM3eOdq0GcrhdI5htS3IDjs90LYgdCXNC8c
	vu5s6SmmtQ3Un0xhTbqzyFzozMK6i3vWWVel8RGUO3dT7a+lp2rHZdBVs8PeFw==
X-Gm-Gg: AYBFou1ZBdm3FJAf/eex8j98+jck+obVJNcZH9DsoQiemCQ7yIvS/wst2mV8Wkit7l1
	P4aJ155CSLadcTGXkUeKFBNwXHe6qDUDoM50Q19r4KuZnVBBzp3Dqey3cGJYw8X5hW24qzzxOt8
	rilluSYzL7g1T2YRosNY7JS1RDK8tvmpIykY6xoJFMKhl/tc7v5F10KkwMoMhCav4T+td2LWfC9
	wb8jGevxP/WTOX38Y06wUsTqz260tfh4NzSYYCQ7knrPUjfClNByBmsdnK9wjkQ/f1SbwtWw8qQ
	9Ljg1bUsj9H1DcTYtYhEtGYbVfAs/TwA2sPTvfa8lbdBzdImf089JLscrGGdpkO7P7nfGVRZR+H
	RTJsWfmWqcqwm7JKaAbxu8Qo7tLELDoTZJMNblPD4yOOR7ozqD9BY4XtgwvJ5Qrqgnc0rLNhaSU
	97NtZOZwINXkLkA5ctDK3Cs7xaSydN+ZUTcT9i0n98I113uw1EcCLG2bCbWruFepLnDH/MDKB12
	bgLiheqAAR1S8SrBH/zhEw=
X-Received: by 2002:a05:6808:221f:b0:496:34a:d7e3 with SMTP id 5614622812f47-50c4ed40abcmr2041136b6e.17.1791564664832;
        Fri, 09 Oct 2026 09:51:04 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-50c0c5fe7d0sm2572793b6e.2.2026.10.09.09.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 09:51:04 -0700 (PDT)
Date: Fri, 9 Oct 2026 11:51:01 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org, 
	Mitja =?utf-8?B?QmV6ZW7FoWVr?= <mitja.bezensek@login5.org>
Subject: Re: [PATCH] fetch: commit references fetched before backfilling tags
Message-ID: <askY2aq8--2I2lEN@denethor>
References: <20261009-799-shallow-fetch-with-tags-v1-1-379d61504af5@gmail.com>
 <asjPWXAO3Cwpkerk@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asjPWXAO3Cwpkerk@pks.im>

On 26/10/09 01:26PM, Patrick Steinhardt wrote:
> On Fri, Oct 09, 2026 at 12:10:37AM +0200, Karthik Nayak wrote:
> > In 0e358de64a (fetch: use batched reference updates, 2025-05-19), the
> > fetch code was modified to use batched updates to provide a good
> > performance improvement. Wherein batched updates were used to fetch both
> > references and backfill tags.
> > 
> > When using batched updates, the references aren't yet committed to disk
> > when we start backfilling tags. This means in situations such as shallow
> > fetching the negotiation during backfilling tags, the client doesn't
> > have any references to report in the 'have' section. Since backfilling
> > doesn't use a depth limit, this can cause the server to send all the
> > objects present in the repository.
> 
> So in my own words: the server sends the reference, we queue them in a
> transaction, but don't commit it yet. We then try to backfill tags, and
> because we don't have the refs committed yet the backfill will think we
> don't have any of the relevant commits that those tags point to.
> Consequently, the packfile negotiation will result in way more objects
> being fetched than necessary.
> 
> This makes me wonder why we even do a proper fetch. In theory, we could
> basically just ask the server for the individual tagged objects without
> performing any negotiation, right?
> 
> Or... well, would that work with nested annotated tags? No idea.

IIUC, when we backfill tags, we only fetch tags that reference objects
that we have locally. The server advertises the tag reference OID and
its recursively peeled non-tag OID so the client can figure this out:

  efe1aaafb77990c4f023cec81b198e0af55bbfb5	refs/tags/foo
  c8dd1e3bb1152844983558802a52c9e4c17652b4	refs/tags/foo^{}

So because there could be nested annontated tags, I think we would need
to fetch to get the intermediate objects.

-Justin

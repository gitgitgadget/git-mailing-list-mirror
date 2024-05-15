Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AF7158DCE
	for <git@vger.kernel.org>; Wed, 15 May 2024 20:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715805618; cv=none; b=D0Ar1Saw2m34xT3F2HXyVE6haebA20ZrlTKtWBl8ml889d/ktgYcyyvCotKmku7k/AraICDoFmnswMLfw6uh4YSKV0qJjXTkcCjpFNNBWcdl00BVOnM4t0/q2N5CeMkaBLo+B8PbtljaWEVx4dUNzSFbTcZdSbjCBpDzjK4MMWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715805618; c=relaxed/simple;
	bh=Vk/x6lySdz9mUKZaY0st2yBt0OCoNAU89LMAj3iwERI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U7+HsSrvOueJCFQOgSCi0THRqqe4Se815CDi8iyfvjUcxGC2llgMZiID51S/9aZuCDjae/JUwKs23lzgbZdMCCHGz9YhX4dfg1gDll5/EySozWY43Vc3CzgYPa1nN2vx3FbRgy+2IWG+w+PuNyYyEVC+SitkjrNmDMMaL9hJzrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0QJyl1C; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0QJyl1C"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3c9741777f0so2538712b6e.0
        for <git@vger.kernel.org>; Wed, 15 May 2024 13:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715805616; x=1716410416; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47plycJgnh8/Vs93RbCk082wFiw3RfLXWYwd4zYdj1k=;
        b=l0QJyl1CxEniuyCtXt2WlB7+x87q7WcQOQ74sqbBDkUuaU13Bd0W0MVQw368O17sHd
         gBggicbnHDFfTyDG0S4fkVyglDOnP8qW56CIEi76qVUh4BB2PNjdxT+dKOh9ROY39Ply
         W9SwWPoqrxzJIs6ZFhPqJB0Dw1k4OXfmI+WHTIjHiw/CZjnYtivShiP+UgTTtUqlvQQc
         +TMxVJa6bVRo0vV+vtW76DLHHHYg92tABuC1STImStxTyqokERWm0TeN6KwUb3U4/cMT
         6pKACEgWLsakJUpQ+M1lwrIxnuRYbCP9/ZPXYOHvZUzaO0Ig2j1QEdUe+TBuF4dTYzcN
         bELA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715805616; x=1716410416;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=47plycJgnh8/Vs93RbCk082wFiw3RfLXWYwd4zYdj1k=;
        b=cLXNgwCmVgvoKJCW6T/8FaEqILIFhWx+jxCCaVt3cJtC52m/UrcSF0s2xVGml/9SSX
         xly0u56Iv3uPft9NpYFHYyzyyhgsTUdT4XNeeufZLE6P0XX05+p1wXvGvElEe8S7ihrn
         hnMA1DCuZ+IooGaV0mjlg70SQTkG1Rjy3Zrwv7yVL2G4mXzXgKZHHOvqhiIa/iONiS1H
         PCDFxKeKTci/qvw+Zo85GcqVnx47s7EbAQNLyMmY9ao5xlP6FaANUgK29af21mxX9x7g
         n5TAoDUp9bC+JDdRJdyJt9Yzw0ToORPiuXR0d7uqjnXSuNbR1pTF87z9xuy4oFXgIuOD
         1o2g==
X-Gm-Message-State: AOJu0YxuZ5hNIyl4eZoBxfw93bPZ6IHb/gTDUO9P2v9zSwIVZEaDPWhW
	a62Zch9FXMnfYLLJexMV/YKyM1rcCN/uPFLgRW4jzTPhxQZSR9JZ
X-Google-Smtp-Source: AGHT+IHuXvDUdjh8B6mNyvqNN1MOGESNQwdd9ckYkpZG4SGO4xyDY4MrPTx79SZWTjJ7wX+hUZqbvA==
X-Received: by 2002:a05:6808:1b0f:b0:3c9:c3ad:53b0 with SMTP id 5614622812f47-3c9c3ad57demr125254b6e.59.1715805615728;
        Wed, 15 May 2024 13:40:15 -0700 (PDT)
Received: from localhost ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3c9942359a9sm2159686b6e.53.2024.05.15.13.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 13:40:15 -0700 (PDT)
Date: Wed, 15 May 2024 15:38:47 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, 
	Karthik Nayak <karthik.188@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Kristoffer Haugsbakk <code@khaugsbakk.name>, 
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <avila.jn@gmail.com>
Subject: Re: [PATCH v5 06/10] refs: do not check ref existence in
 `is_root_ref()`
Message-ID: <vgzwb5xnlvz2gfiqamzrfcjs2xya3zhhoootyzopfpdrjapayq@wfsomyal4cf6>
Mail-Followup-To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
	Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>, 
	Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	Kristoffer Haugsbakk <code@khaugsbakk.name>, =?utf-8?Q?Jean-No=C3=ABl?= AVILA <avila.jn@gmail.com>
References: <cover.1714398019.git.ps@pks.im>
 <cover.1715755591.git.ps@pks.im>
 <af22581c2212088ea6a380cc1a58923abfdc4fe1.1715755591.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af22581c2212088ea6a380cc1a58923abfdc4fe1.1715755591.git.ps@pks.im>

On 24/05/15 08:50AM, Patrick Steinhardt wrote:
> Before this patch series, root refs except for "HEAD" and our special
> refs were classified as pseudorefs. Furthermore, our terminology
> clarified that pseudorefs must not be symbolic refs. This restriction
> is enforced in `is_root_ref()`, which explicitly checks that a supposed
> root ref resolves to an object ID without recursing.
> 
> This has been extremely confusing right from the start because (in old
> terminology) a ref name may sometimes be a pseudoref and sometimes not
> depending on whether it is a symbolic or regular ref. This behaviour
> does not seem reasonable at all and I very much doubt that it results in
> anything sane.
> 
> Last but not least, the current behaviour can actually lead to a
> segfault when calling `is_root_ref()` with a reference that either does
> not exist or that is a symbolic ref because we never initialized `oid`,
> but then read it via `is_null_oid()`.
> 
> We have now changed terminology to clarify that pseudorefs are really
> only "MERGE_HEAD" and "FETCH_HEAD", whereas all the other refs that live
> in the root of the ref hierarchy are just plain refs. Thus, we do not
> need to check whether the ref is symbolic or not. In fact, we can now
> avoid looking up the ref completely as the name is sufficient for us to
> figure out whether something would be a root ref or not.
> 
> This change of course changes semantics for our callers. As there are
> only three of them we can assess each of them individually:
> 
>   - "ref-filter.c:ref_kind_from_refname()" uses it to classify refs.
>     It's clear that the intent is to classify based on the ref name,
>     only.
> 
>   - "refs/reftable_backend.c:reftable_ref_iterator_advance()" uses it to
>     filter root refs. Again, using existence checks is pointless here as
>     the iterator has just surfaced the ref, so we know it does exist.
> 
>   - "refs/files_backend.c:add_pseudoref_and_head_entries()" uses it to
>     determine whether it should add a ref to the root directory of its
>     iterator. This had the effect that we skipped over any files that
>     are either a symbolic ref, or which are not a ref at all.
> 
>     The new behaviour is to include symbolic refs know, which aligns us

s/know/now/

>     with the adapted terminology. Furthermore, files which look like
>     root refs but aren't are now mark those as "broken". As broken refs
>     are not surfaced by our tooling, this should not lead to a change in
>     user-visible behaviour, but may cause us to emit warnings. This
>     feels like the right thing to do as we would otherwise just silently
>     ignore corrupted root refs completely.

Is there an expected source of broken root refs? Or would it just be due
to bugs?

> So in all cases the existence check was either superfluous, not in line
> with the adapted terminology or masked potential issues. This commit
> thus changes the behaviour as proposed and drops the existence check
> altogether.

Dropping the existence check makes sense to me. It also has the added
benefit of simplifying `is_root_ref()` which is nice.

> 
> Add a test that verifies that this does not change user-visible
> behaviour. Namely, we still don't want to show broken refs to the user
> by default in git-for-each-ref(1). What this does allow though is for
> internal callers to surface dangling root refs when they pass in the
> `DO_FOR_EACH_INCLUDE_BROKEN` flag.

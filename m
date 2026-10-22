Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792701520;
	b=uFF14QB2lgL7xRE6Dp529b8zxJaT+tqH/s3ZAmqeKUmObKib/6sOOn4e8ixbqmhPbF6Y
	 ppuRRjt+fy0yZlUD226Brsdlu7gcOdD7HrSF6Dt67HYv6yX2qolzBuJCxtcMrC/Bp8il8
	 D6ylnJtWByneyw8dqQ0XTLZF2fo0nz4WKi2IkT6oCebWjEXPzFyA4w4PuKzgg2qjHeyFX
	 LSQyLzQG6tQlS5kLdRyJUoODMhxc+CGa3GxUm3YUHP+b3BQvY36Y8OV7gCsqjMQaW9FFG
	 2hbRPqEPdSGYNrI3DkOambAF5RbnlIojJvuiTDELcP4sCl97PJYXPifLcyrJDiDPubw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792701520;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=RkXTaieQfvwByEwiEJCObX7fsMD/HTm9dSmze9IBwbw=;
	b=4G562D6qgVP+mRKrFs/puyHKl9p9uCa6GxwERzF12JimcUCeGYPLmnI8EDO0ugjPIniY
	 S5hzrywmR88zL+28L10/YalKt1x5yw5Myz29tRkomqbU9d142+rT+jijO4oVA2QnWpjmF
	 Nar6QuyJfDc9SrMvNrt1x4gFRGhZtBreKan2dPKEdAQdNy4OdPK0TEnYHwGJQvtvHw2g/
	 V0Zi416isWYH3GHSHZnvqJYpk6TBU+JIIME8/O+bJZdgD8ffymvB9ssG6TtrKDc8HCA2b
	 nRpwSQz4UfX2/5cLi7Cq87NJT7V4NkEisrzrLMh+zA2CV7fm0iHYS/3tjmjOdT6L2kQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openai.com;
	spf=pass smtp.mailfrom=openai.com;
	dkim=pass header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=Xnlyvhlr;
	arc=none smtp.remote-ip=209.85.160.180
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8503D606A31A
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 20:38:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8503D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=Xnlyvhlr
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5364648ae07so1589301cf.1
        for <git@vger.kernel.org>; Thu, 22 Oct 2026 13:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1792701519; x=1793306319; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RkXTaieQfvwByEwiEJCObX7fsMD/HTm9dSmze9IBwbw=;
        b=Xnlyvhlrn+VgsSQ2UVfUW3qEirYeVT0bX4A5fnBSVuUB8JF6fzgRsZrObPSjnGsLwm
         eMnjjeMBjb+5n0Xz1V137JSOQ7NrvOrX/P+vQmUw816LaOipiQ0EGJdAtqBZavRXslOi
         rB7NAJC0UK7+uezWm9KVyoByDX6tFfhuXkhZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792701519; x=1793306319;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RkXTaieQfvwByEwiEJCObX7fsMD/HTm9dSmze9IBwbw=;
        b=d/+6CT1xu2vDdwSPZNRmzIpcEi99T+FIu/xQ/ZOfFc+fmwvfux/BrSt76sosgQwEnM
         VILRldTotzWP8g28u5DfzxU3xwjmqUZQ8lH8W7zfDbCupE6Bmq7zD885t32IIYmZby2+
         oMKE2oItxbDzq9CtZki/LfVHs08RwymDhvAT0vuF1hMDQU4Vyv46tn05h5zUmnszcQjD
         WSGdWV4oY0OQb+KROxnH4fIzEJr1WbJwLCtuoI1S5l4qiaZagdiBETLahC6Py2J472Eg
         TIE5SRueWqxAmkaN8pGz5+oiX2WtI2Nex0wn6qG+95BFJNXw/rvbQxRFGkFApVgTuWPj
         pf2g==
X-Gm-Message-State: AFq9FYLJCIG5HN1PaX0upZs8Z42Vu0PUMW2x9D41iFPORhbCnHewPN8L
	uKiA8zQ68T7NkYaZYw7PLiMhh721sJNg9hKbJ1DN1Wyb7UaGyIJ41hLTXudbv9gmii8=
X-Gm-Gg: AYBFou3cs2DJUsdd+M/4Vms0nAurXxgTj0KAsLjNLYJqmJONyNoAHK3fEjtg0UbCBWH
	aOl+a135qSKeZHQgBqoL/piSWIrWisCnlav097yCX9GndDYYd9oIe2gxQIIYKSO/61+lp2OQpCk
	GuRuBUBpt/6iQVY1qxyisoMhCs8lIpQxpxWn5vaUyjqtviZINvaKOfxyHI1avAwXSpDvQz2AXRK
	uhmsJbARP0HuZuVLQg/aR0gP15rktvYzvf2o3x0/HVAht71wvWRAKBi7uFwnyy1fOKreo5+223I
	MJYuPNdyD+o1+gJOZOniedHHxx2K7iVoFqfsGRBTyId55iHckrb6N9q6HnpvRcHICTe1/Jurf3d
	xyBwba8uImoLmuwzf1LGm+3GYVqNnn3NGO0Gf2UEaR+p66dn4z8GLMpq8OOWvD5vMZx5zk60hln
	bMD/KHi500E3If9UL/COKuCyDnZjGjEg/LcEzmnbkTV9tHsiPU/aYQs/GViPn44sY4/2b4YA+ht
	QTjgRa0Voz9FGr42Ae26VGgmXfMwU6hHEvocKxocTlLPdd4jB6wK1oVbG19OrRH/X3YBHZlgpC3
	8TSP3XrKAVFXr5L1sPLTa3HqUO4cLzNWNCiCbGajnyi5pjz6lmgRVio39inRQ6Ut84ZnfQGpwu9
	i6mxWZVChaK/IPQc=
X-Received: by 2002:a05:622a:5c6:b0:535:922:1001 with SMTP id d75a77b69052e-536c264072dmr801231cf.49.1792701519210;
        Thu, 22 Oct 2026 13:38:39 -0700 (PDT)
Received: from com-79390 (vpn-centralus-04.tradc-corp.com. [20.80.83.168])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-536c17b37a4sm1806611cf.8.2026.10.22.13.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 13:38:38 -0700 (PDT)
Date: Thu, 22 Oct 2026 15:38:27 -0500
From: Taylor Blau <ttaylorr@openai.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Jonathan Tan <jonathantanmy@fastmail.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Derrick Stolee <stolee@gmail.com>, Ted Nyman <tnyman@openai.com>,
	Daniel Reynaud <dreynaud@openai.com>,
	Aaron Friel <friel@openai.com>
Subject: Re: [PATCH] negotiator/skipping.c: parse parents before queueing
Message-ID: <atp0Q5dFHQHAZAov@com-79390>
References: <dc3dfa3647c42da9170bf3289f4e8a4a8a55c8e2.1792441003.git.me@ttaylorr.com>
 <athgd6Ya12zRdIR_@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <athgd6Ya12zRdIR_@pks.im>

On Wed, Oct 21, 2026 at 08:49:27AM +0200, Patrick Steinhardt wrote:
> On Mon, Oct 19, 2026 at 03:17:07PM -0500, Taylor Blau wrote:
> > diff --git a/negotiator/skipping.c b/negotiator/skipping.c
> > index db90fa77b53..ed6e88b59b4 100644
> > --- a/negotiator/skipping.c
> > +++ b/negotiator/skipping.c
> > @@ -151,6 +151,9 @@ static int push_parent(struct data *data, struct entry *entry,
> >  parent_found:
> >  		;
> >  	} else {
> > +		/* Parse the parent before using its date to order the queue. */
> > +		if (repo_parse_commit(the_repository, to_push))
> > +			return 0;
> >  		parent_entry = rev_list_push(data, to_push, 0);
> >  	}
>
> Why do you parse the commit in `push_parent()` instead of parsing it in
> `rev_list_push()`? The latter would also cover the other two callsites
> that call it, and to me it's not clear why they wouldn't want to parse
> the commits before adding it to the queue.
>
> Doing so in `rev_list_push()` would also bring it in line with the
> default negotiator.

I originally wrote it this way because the skipping negotiator's version
of `rev_list_push()` returns a pointer to an 'entry' struct, whereas the
default negotiator's simply returns void. But the only caller that needs
to learn to handle a NULL return value from that function is simply
`push_parent()` itself, since the other two callers already disregard
the return value.

I agree that performing the parse in `rev_list_push()` makes more sense
from both an ergonomic and consistency perspective, so I have moved it
there for the next round.

> There's also another call to `repo_parse_commit()` in `get_rev()`. Once
> we start parsing the commit in `rev_list_push()` we could drop that call
> as we'd know that every commit in the queue is parsed already.

That makes sense. The commit struct comes from the queue, and we know
that the queue always has fully-parsed commits, so there is no need to
re-parse it (even though the second and subsequent calls are noops).
I've removed it.

> > +	sed -n "s/.*fetch> have //p" trace >haves &&
> > +	sed -n "1,2p" haves >actual &&
>
> Nit: `head -n2 haves >actual`

Thanks, I realized when responding here that we don't even need the
'haves' intermediate file, so we can replace this and the above line
with:

    sed -n "s/.*fetch> have //p" trace | head -n 2 >actual &&

Thanks for reviewing!

Thanks,
Taylor

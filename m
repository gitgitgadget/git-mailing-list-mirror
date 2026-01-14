Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E116439E6C2
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 21:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768427102; cv=none; b=qTyepdc9tDPzELdXQ44YnexzLmlDhFa7AQ4waZ2gOPkkH+i9FrGXomJwaHTH/oadQz8idmZ9II4rHyyb5x5sBzWoUeqYnnvENm0yh5tIZ5EXBEumBBC1cqRT/7OCowsfdWWp26Q/kX68X0Q/A/wCF4dEMyaXs/QUozrBgQAn+to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768427102; c=relaxed/simple;
	bh=vUE3pDzUKRPZ70f8MgDYpr4HfTacRw4RZsa3dvvVfTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tn+LRbeQiMpn9laP4KZCevbEfUkWCm8g/MacwNS9HCApVYYJYnNKAnkOc11DLVUiJYt8+KNn4ptaTvhhdhZeSZxGhJfrx9Gh6lMFUt3ISQ8ksnjrVfUDmhrfJ5+85m9vzKnCnvg5Aq8dAFaPDtqxYCUqsMSxOm/TiK2VWeFsvX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=NnhkZN29; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="NnhkZN29"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-792768a0cd3so2380027b3.1
        for <git@vger.kernel.org>; Wed, 14 Jan 2026 13:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1768427096; x=1769031896; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=75jYX+RqSxeLVJ2f94+SGF/RPNpL/yvlyLcjeEtK9PU=;
        b=NnhkZN29i3OMTjH/0pJXDXJPwAMimm0zr6HN9O4L1yYifkuton93y09nMPAdgxpWAz
         1/VcpNTK94beAj9pMSKRe1tkCO6XFoCUVX+CdrHyINrQWu1DBNeRyk66qgGAbvs00jPT
         yhUnZ+51McM2VSarpObTGAwJRDAGYScv2+0xMVX8GGwxxmyLWdGJVcM12vjg204F1X85
         ehyFiEpYidl9+/xXFh8r7S03gC6m+Y3gqteY3gL/evlHHaurFOE850ljEcBkqbt/VCtB
         aEt0nzrBVSb2bH2aiyd7gWgWTPPx+qvZWMQtEX/4iWm2sW4PLgI5fqG6FMkHCA9luoob
         v6hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768427096; x=1769031896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=75jYX+RqSxeLVJ2f94+SGF/RPNpL/yvlyLcjeEtK9PU=;
        b=Wao9PzRlE3U2uZ2nTysV0CxbsPeotbWEEboDJsiG8MeIBDBEAgOhZyGrgyzRlbdHYf
         YZnXlKivL7G0EcgTTW1+6vWYtgZUl5JSAcUxz4Tk3auqCls8C/9v6M/aJJqW+EM9i6Ou
         8S6vb7ywWwx6fdyZwPCWpuDgPDbWgqiYXQU25AoJjvjvlQi7YEn2ZTjM1XYk6cReVhvZ
         IGaGYRmfQRuvtmbECDdmJfYKDjCzV/Ly+mLZfN8lGh+PhMT5d66dvGLL3wAhjPbMHtMC
         T6ZAiJTuo4LXURUx1GFWxgWyPnkKh3Dqp5fX+Xhv4y+K1Yt//a4UH1lYevesq0Je3XfY
         wA6w==
X-Gm-Message-State: AOJu0YwvsUhiq8cYCFi4fUeA887AtqQaJbFQ1W1+njmNgxRVKpTrZREz
	+rSTvV5W7WB8eOPE78QXVacefc2ctNZwKAZhkI6EuNe/LzyQGcgfZ0ZcJwbY6N34478=
X-Gm-Gg: AY/fxX7pdeTv14NnDEnfT3+COYhf+Ue4yaX6KgRemyz8/tnWraaBhVVkQjakiuqfV63
	X6HNLqopMehhNPiT9ejHlMQ4L6jJidgcArYCxwDVaCr3KTZhRVY7ZtXvFF5syPPjH4zmIvA98es
	7xOKNZDs0UTyweEjctngkY5aDJ4O1uoSAExAbjc1v4LHz2EJ03pUnBui8qd8b0SiNMOLMBeiMm6
	P6ogdT69fcx2GylU9pBCUSWTh67vkiS+PQHrmJwP5h54tdgFyXUjrz5XR/QJ46VEkvDhSJpKCQH
	7uqCQnSagIzJTbHPpGRoJMBmlrvUyAiYZvYCyRV2/ZKo8hTFwgn30viWN0dTfT6jpKl+Nco3AwL
	pCMJ2yA8z/wQ3gxK/e1Ac1sdxVksHUrwiBxhEODnvKHNXVer725whf3igIRsrHa7ooe0RT8m+rY
	i4Gq/BRjiRtv/30YzLqDjxzowuQ1RTQ3/BSyqTDtbRNgr+DArHpSQin4s/trhkp3NVqyu+gZQn0
	DYQcdLmMvsuVJ10ANbmIz+sDhWc
X-Received: by 2002:a05:690c:f03:b0:793:b68d:1514 with SMTP id 00721157ae682-793b68d154dmr2387127b3.38.1768427096164;
        Wed, 14 Jan 2026 13:44:56 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa672cafsm94928167b3.30.2026.01.14.13.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 13:44:55 -0800 (PST)
Date: Wed, 14 Jan 2026 16:44:54 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 10/18] midx: do not require packs to be sorted in
 lexicographic order
Message-ID: <aWgOVnp+zkGiR8p6@nand.local>
References: <cover.1765053054.git.me@ttaylorr.com>
 <cover.1768420450.git.me@ttaylorr.com>
 <72bcd4ed6c7f685f58bb3b905fe553173abe1845.1768420450.git.me@ttaylorr.com>
 <xmqqtswnevfc.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtswnevfc.fsf@gitster.g>

On Wed, Jan 14, 2026 at 01:28:07PM -0800, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > @@ -374,7 +374,7 @@ HEADER:
> >  	    The signature is: {'M', 'I', 'D', 'X'}
> >
> >  	1-byte version number:
> > -	    Git only writes or recognizes version 1.
> > +	    Git only writes version 2, but recognizes versions 1 and 2.
>
> We only write version 2, then ...

Ah, thanks for spotting.

This comment is outdated, and I didn't catch it when proof-reading
the patches. I wrote this line before adding the "midx.version" config
escape hatch, and doing so made this comment stale.

It should probably look something like:

    Git writes the version specified by the "midx.version"
    configuration option, which defaults to 2. It recognizes
    both versions 1 and 2.

I'll update it and include it in the subsequent round.

> >  	hashwrite_be32(f, MIDX_SIGNATURE);
> > -	hashwrite_u8(f, MIDX_VERSION);
> > +	hashwrite_u8(f, version);
> >  	hashwrite_u8(f, oid_version(hash_algo));
> >  	hashwrite_u8(f, num_chunks);
> >  	hashwrite_u8(f, 0); /* unused */
> > @@ -105,6 +108,8 @@ struct write_midx_context {
> >
> >  	uint32_t preferred_pack_idx;
> >
> > +	int version; /* must be MIDX_VERSION_V1 or _V2 */
> > +
>
> Ditto.  When we are writing it out, shouldn't this always be 2
> anyway?

For this and below, the code here is right and the documentation is
wrong (per above).

> > @@ -410,7 +415,9 @@ static int write_midx_pack_names(struct hashfile *f, void *data)
> >  		if (ctx->info[i].expired)
> >  			continue;
> >
> > -		if (i && strcmp(ctx->info[i].pack_name, ctx->info[i - 1].pack_name) <= 0)
> > +		if (ctx->version == MIDX_VERSION_V1 &&
> > +		    i && strcmp(ctx->info[i].pack_name,
> > +				ctx->info[i - 1].pack_name) <= 0)
> >  			BUG("incorrect pack-file order: %s before %s",
> >  			    ctx->info[i - 1].pack_name,
> >  			    ctx->info[i].pack_name);
>
> Ditto.

Ditto (and so on) ;-).

Thanks,
Taylor

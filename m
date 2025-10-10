Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309E41A9FAE
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 22:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760136598; cv=none; b=asoY8EmaQ8RU+ZwFpAD2t+PhYYDvgoA4SHzyZ0gFavtbuT+qCZszE86yeyJeqrExrPKxnzfTAUMWQRzQF5L7r17MNpBlZ2RB1vYZwx3smYPIM4o/9/vxV1CsXcNolLSX5jti4z6dqoS7cPp4fixlzXTh5lmy+O/SspcCvTGUV4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760136598; c=relaxed/simple;
	bh=r/M8R0VZfJFu4WN0yE/M7JDlPAFEwmuUwibNFUtXJGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gE1AaUEpRW4xWuDuoNSY8WtXQdiYvbh5lN+xvlgy/hREgUAyZiLqds/bkbrfUnAoS7sXJD9zagf21Brnq+FITEiiVy+Jp4tUlUD1s8qoAYZrmSq6ZEFAmoN//T2th1iqvpaXRMltdXY/UEwxSr36pkO7WdUCwfTqvQ6yS+18AVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=ckXLH36h; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="ckXLH36h"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-72e565bf2f0so26956637b3.3
        for <git@vger.kernel.org>; Fri, 10 Oct 2025 15:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1760136596; x=1760741396; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r8fXg4zC3wxUwCs+Dsk4EXpq+1EJB5LPWOfLleGsGg8=;
        b=ckXLH36hYjLYHD5FHPSQk23ZkfI9+weA8GuK2ougxgrR8kbvNP1wmniljsk/w0W9Qq
         xCmaIDQ27v8VB2PjJHiv73nvbbjha/k1k31vkLYLFSmI+g1jl9+z4M7Kk5ujsHlNk7gd
         Bp+8dPgmGbUhxcvpUtgudkOrU9B2SwGAWHVh4lPrpsB4iteMdxEWd6sHvdI3hrGGIU0M
         j0Z67aLFQzXd5IMDHsetiSk6a3mJ0HrbTA8pIvDMfVZxk0gJeB5jPEghcw6FB2/9O+1h
         pkSWgz4wW9qSmRvhG1/YxGidxd1n9LyO+eOmwvo/3ab64jaIoL8RfFoAvNDo+rzeDSjn
         DQrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760136596; x=1760741396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r8fXg4zC3wxUwCs+Dsk4EXpq+1EJB5LPWOfLleGsGg8=;
        b=hdH6bGsXNYSlkXwonYVrcM+VzGp5t5VINWy7LhttDpbwDM2iFDu+0uSt3Cw7G7u8Nf
         kUAMqjXDXZOfgKIKJamYUT7GZ7SZ4s1OkvW4K6stSJp6GKB/fZRJEzHYEMQEMXgt6Z6v
         YtMRNGAlkfCNhUU+InAhhQj/iDLvzkkV1lrFL1m8xM3DwcCkfmyq/fUUoWYZCH1/hbY9
         QDZqqw8vl5RrVnM3gtBjYRBqoIIsLmtH8M0e6hGkoh5lYWfGVGnuKIAunkD5kot/z2sk
         rgzMhiLkA4o8hSpVeBCzv/ZyIvr03VRoqrno6qceZW+apEqB0yV7sJa4zYNtUBP0vICh
         e0vw==
X-Gm-Message-State: AOJu0YwsKp7kWwPRonbsFkIrXdJty8IO/KDKZr4FAyVzZcbm4vxOz7sJ
	cTv6BU6o1WK2A8Uougg55TlGo7YeO3HShElxFbKSHZ2ZHFv4bAjAMZEgC37ZzW7Tpq0=
X-Gm-Gg: ASbGnctMQM+Kg34dirB4hTCP1qBEezadTWb+LgpRBkRbwPLhaZEzF75a5y3D3N/xPZl
	uRzIaGCCc9dUvBmoULTK2pYJEj8v6tQDQOPHqxBczf20tkEy88nfaDPeGpTkwpXEXHfm3ndsWIF
	SBuzdFxljAVD6QLt7V26m4//FJXFZ1V3MNlXBLMFg0SgEEmcUwvikPnK7uqLqOaizWjBFqnRwTg
	XECBoC7m083f2+6LPvh+oiLvMishT4bC3RIcTLfIDX+rO25FY6yWLYCl/LO/PFreoMTb0aCGBg4
	ESHRrIyt3C3ZM0UNCkLq1+Irgr39QCqzMebQy7Y2AXPudtz/lYZ+3Uf0MrJVJPUVYWDERD30I8V
	orfMnUMF51C/0OPOulcenzmQa6Ai/cG4xDi1oaMPyROrz6Rw8p/pmlQ4VLqqmI70xulkXVq1cLI
	f+J7zVRm4TwFwSRlKdkbpXTHlICVPJCG5SbQpsFRwZYXSS9Fg1c6HPc1UiTaxeqAHZRg==
X-Google-Smtp-Source: AGHT+IEJ+J+rF3yrOg+5TdOhAWKvjmPgHdhNwv5c9ozRVH85TpqZdwSOefGjkOatEG6Y6OkLYhHOTQ==
X-Received: by 2002:a05:690c:4809:b0:781:2c5:bf4e with SMTP id 00721157ae682-78102c5c02emr60667087b3.7.1760136596007;
        Fri, 10 Oct 2025 15:49:56 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78106e1ede9sm8972997b3.22.2025.10.10.15.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 15:49:55 -0700 (PDT)
Date: Fri, 10 Oct 2025 18:49:54 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 04/49] builtin/repack.c: avoid "the_repository" when
 removing packs
Message-ID: <aOmNks8E1wQC7MnS@nand.local>
References: <cover.1759097191.git.me@ttaylorr.com>
 <f404dfa34f06a882e5ebf0b6ffa01ba365ac866b.1759097191.git.me@ttaylorr.com>
 <20251010052256.GB1965904@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251010052256.GB1965904@coredump.intra.peff.net>

On Fri, Oct 10, 2025 at 01:22:56AM -0400, Jeff King wrote:
> On Sun, Sep 28, 2025 at 06:07:26PM -0400, Taylor Blau wrote:
>
> > -static void remove_redundant_pack(const char *dir_name, const char *base_name)
> > +static void remove_redundant_pack(struct repository *repo,
> > +				  const char *dir_name, const char *base_name)
> >  {
> >  	struct strbuf buf = STRBUF_INIT;
> > -	struct odb_source *source = the_repository->objects->sources;
> > +	struct odb_source *source = repo->objects->sources;
> >  	struct multi_pack_index *m = get_multi_pack_index(source);
> >  	strbuf_addf(&buf, "%s.pack", base_name);
> >  	if (m && source->local && midx_contains_pack(m, buf.buf))
> > -		clear_midx_file(the_repository);
> > +		clear_midx_file(repo);
> >  	strbuf_insertf(&buf, 0, "%s/", dir_name);
> >  	unlink_pack_path(buf.buf, 1);
> >  	strbuf_release(&buf);
> >  }
>
> Ah, yeah, this is a good example of what I was talking about in the
> other part of the thread. Probably this function could just take the
> object_source pointer to find the midx. But then it wouldn't be able to
> use clear_midx_file(). That function arguably should itself take an
> object_source pointer and not a repo pointer, but it feels like minimal
> gain to go around trying to tighten these (and certainly something we
> could easily do later, even programatically, if we cared).

Yup, I agree. The changes to `clear_midx_file()` seem like a good
candidate for #leftoverbits to me.

Thanks,
Taylor

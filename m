Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC0714884C
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 18:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722538502; cv=none; b=t8/AxE7dv6rSqUHwxR4KzrGLcPz0SwLkKAXVow5vwDFzpjWWz/cMudlXEawdqP2jrmYMZqLfu305IzCbET/BxZcBOoG7rBtHpOcInELGRZtuYKSdtsCGPEmULlwcAOYcT7H+xN3p6YOOe4wwheLmrgR42soSEP2e9DPDkS+upc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722538502; c=relaxed/simple;
	bh=3ZkxKJCmyf6Buiri4Xf2Z80I4kS5LZ59yQKMOrXLAXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MjNoNNlY4fJTd94T9/eTfHJHvn9IosS9M0RdGfSiQjsVyFmy5U8QQLeNpyQbZ5wly8+F9Oo3T5FK5arY1jVTsg5W0DzYO6lYrGEMeGL7inEuvMKA6XY2ti/VioJN5/o4rkmOQnhJt5OSeqsm78KZ2JzQN7nzkqc6eVIHlsHGemI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=mbschcuM; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="mbschcuM"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e0be2978a0fso95210276.3
        for <git@vger.kernel.org>; Thu, 01 Aug 2024 11:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1722538500; x=1723143300; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=76e6tXpAPNNRmU5CWt+59snZgnGsEjrXA1gGnPxFWH4=;
        b=mbschcuMVIr7EAQQW0ayCguLBZ6rN6R5deXXZNTBwyPAtO1eOir3ANCURrmWgyISra
         Fou8Wpky2IFGS7xDxOvFYBGv2LLr+yo7dnWPzZMFL9OjZlvAlASzvTUv8Ub4f011n9cj
         JMLe+nW9zKzCydoCyeqRadOeJcBfX3j1Oy+B3N7jY45h/EEZLlR5jqu43Q6ALCcQGSRt
         iw0FFS5g1AAkeEYkdotXh2Sb7mG0HVA9UBzqQP3QvR5BQlMN5HW6Iny801P8hIuaLKPw
         J/YizM10EK3xtDdRl7NzhWkVPRsIUYxOGJugkVrWwpIsBLlegCMxBUFWVIHvARJQeI57
         y8xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722538500; x=1723143300;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=76e6tXpAPNNRmU5CWt+59snZgnGsEjrXA1gGnPxFWH4=;
        b=iCzD6eI/9Rxehc3tPe0TUPAhwrQPIGs3ZpAhc72L2hf3f9D09nIoYEDm6T1d2KqR63
         2k2A4nDpvO6S5EzbKv0HCfu+3D2oFFmfNgKPorbeNx1ZK8PpvQNfbp/85bzLj8O/ZcJZ
         VvXxCGXaTKRUG3OdXv6KwUkLhvTwURRAR/vdTL4e6GSVNGCQvAzj8ElczrtQChM0a2ep
         blB+gC1jaf0uB0IkWQgwTlVRxJhPCZuYIm3mf4cWXrtUCLmdOOV3d3znPWFC9HT3MqMO
         AFLLlw8wun1w0fyPdlCNe8P/FfOAJZNLny0S17Jot9Q1H7A6m6cX6rldvgtIyuwpLF8e
         yxvg==
X-Gm-Message-State: AOJu0Yx2w3pp8e8PKQgh+AWjT5npZFxJuAjN3fMcro2Rg4KNh3LKRd9I
	nCvGmTSTepRHvKpFSSLCE46/Ek0lTBRhNnONHdQKcCOaJWhdVhpMZH6o3qHEsu0=
X-Google-Smtp-Source: AGHT+IFQG5zcFsp9OfJ3od82JTZW7sZZ5OL13xnJkFctneikyUIrM9XXWYF9V6Tgd9JR79PhC3/9OA==
X-Received: by 2002:a05:6902:1b0e:b0:e0b:e233:89b2 with SMTP id 3f1490d57ef6-e0be2339f3bmr316060276.17.1722538500050;
        Thu, 01 Aug 2024 11:55:00 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e0be0f6bf08sm42238276.50.2024.08.01.11.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 11:54:59 -0700 (PDT)
Date: Thu, 1 Aug 2024 14:54:58 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 02/19] midx: add new fields for incremental MIDX chains
Message-ID: <ZqvaAiCCmb7AmW35@nand.local>
References: <cover.1717715060.git.me@ttaylorr.com>
 <cover.1721250704.git.me@ttaylorr.com>
 <337ebc6de7bdf6ff3b4b09c2bea3df2802174e8b.1721250704.git.me@ttaylorr.com>
 <20240801092142.GB1159276@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240801092142.GB1159276@coredump.intra.peff.net>

On Thu, Aug 01, 2024 at 05:21:42AM -0400, Jeff King wrote:
> On Wed, Jul 17, 2024 at 05:12:01PM -0400, Taylor Blau wrote:
>
> > The incremental MIDX chain feature is designed around the idea of
> > indexing into a concatenated lexicographic ordering of object IDs
> > present in the MIDX.
> >
> > When given an object position, the MIDX machinery needs to be able to
> > locate both (a) which MIDX layer contains the given object, and (b) at
> > what position *within that MIDX layer* that object appears.
> >
> > To do this, three new fields are added to the `struct multi_pack_index`:
> >
> >   - struct multi_pack_index *base_midx;
> >   - uint32_t num_objects_in_base;
> >   - uint32_t num_packs_in_base;
> >
> > These three fields store the pieces of information suggested by their
> > respective field names. In turn, the `num_objects_in_base` and
> > `num_packs_in_base` fields are used to crawl backwards along the
> > `base_midx` pointer to locate the appropriate position for a given
> > object within the MIDX that contains it.
>
> OK, so base_midx is a back-pointer. I think in theory you could compute
> num_objects_in_base on the fly by doing that crawl yourself, but we'd
> want to be able to do it in constant time, rather than O(# of midx)?
>
> Makes sense.

Yep. As you have seen in the later patches in this series, we end up
needing to read num_objects_in_base and num_packs_in_base quite
frequently, so it's nice to have them precomputed.

We could compute them lazily, but they're easy to build up in
midx.c::add_midx_to_chain(), where we're already validating that, for
e.g.:

    if (unsigned_add_overflows(midx_chain->num_packs,
                               midx_chain->num_packs_in_base)) {
            /* ... */
    }
    midx->num_packs_in_base = midx_chain->num_packs +
            midx_chain->num_packs_in_base;

> -Peff

Thanks,
Taylor

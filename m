Received: from mail-oo2-f37.google.com (mail-oo2-f37.google.com [74.125.231.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827E478F26
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 01:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790989327; cv=none; b=tU1Fkr71R3akJ/OC6r1d3U2pHuzyw171r8aJ0+DyfyX6i+lq0X4sbmYAN4ylA2fVuu+8vLkTIK05JfXxReZpKWSMHlz7UFwowqoqAkE74T/BDvQKqKQ5WH0SL6C+m6HMfgIDPFGtGrkDZg25pPf/UtdUWhCpy8ytI0TBie5GSo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790989327; c=relaxed/simple;
	bh=rpBxAjRqkHnZQcpIRKAG52dTcZGsPhs3+2LJfXXW7xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SK9fT5s073HAR1XWSLGZKkh+B418v2jUz/I6Ts+4yhzfAJv/3SBiGtPCYIdPdMteQegvdddj7hSCIiNk8TYFXhaoTQatXqgvqvamuloDU0pUQqq8Azy9lK8ZsAYRgNuV2DxkjI7jnOM+IbcTAlBsYvuDDrJHGqpaIa5vWf9/JXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=ZND7WwUU; arc=none smtp.client-ip=74.125.231.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="ZND7WwUU"
Received: by mail-oo2-f37.google.com with SMTP id 46e09a7af769-7fcb425fc2bso341153a34.3
        for <git@vger.kernel.org>; Fri, 02 Oct 2026 18:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1790989323; x=1791594123; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6jdxxOtS6U7OWE32XXmMvH18BONzUdts2oPkPovY6Lo=;
        b=ZND7WwUUV99jyaUyuYJF5xIxpjSw4ZektSsYzMrSyY+68vn5o3bciTYU1jXbgGy14i
         h2p6sHP2imnZP9B3QeOmRl35I3PhLbFA6PB/FxS773tPHnQzjJKwzlxi7UowGK3b13Ws
         FPqbxPvIztJyDfxutoik6sCJZM1kTfORZuJoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790989323; x=1791594123;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6jdxxOtS6U7OWE32XXmMvH18BONzUdts2oPkPovY6Lo=;
        b=KIVrbDUfr6mwurh38BezfLNjYFWLV3D7tlaiJ1ywkWtVlnb7rKYf5lfeqTNfjS0OfO
         mv3QgF/OeMFfJHnS6QOAOuiPpIiPVz2AEXjKtPJ/ntQJwgWbCxjg3b/DqYvgWYZVZoIK
         c+QzIcypsGhQi7F0FQkcOQ12B4sNbEnb82nNRNnFLAhmH3Gr2EqZ6MdquSa0e7yBbMwd
         OSQFnZE51/3nYD3949DYHmkZsFT/r6xW927UjA+x573DbMquGL7ol0GVcOq83ioZdqAg
         Mftmk7Nc2c1aHTNKziyrFeiWf/z6oYUWg+/to+uupCRcgumSuIGVn0G5M7S0TQtXIwzQ
         3U9Q==
X-Gm-Message-State: AFuF++mxZ92z+Ah3qIRQgXQjGJE5bTJEjtHLn1s/Pa4SBUZZCV3bih8q
	tYx7iyHjNHhaLfhGqAQoTJunuCUMkBK+xusvmzO13EqxHshhvH2bWBztxb5jCIBkEAU=
X-Gm-Gg: AYBFou0n3+C1Dz58Qg45CzS4AsRCqRM46ejpEujY1uQ5mcxrIQxC2VaC6OumPsnwUmi
	hcTvmPNd+JOqSamZksW8t6e/m9WQ/b2xBNfsSZx4kxDvk1aqAha0/zGqzmuHTn9t+X6OZqjsAoG
	8DNATcQTx8ichKJ2TFUWnV6P6pCBRyV4VZStB0L1Q2O+ttmFzK8m9M/fOUydKYqPuJjgodpLdV2
	N3OQtvwC0QZBoX5BDMSosU0GdvHXyzmTIvSmcmKTA5sbX2d9McuoXx/QPH/ZBxhoA+lrbYcnl7u
	sek6QxMzK7BCFxTC0H8vynqqHzUS0Zup73lltYYk4I8R0ZN7pQwGTTkCxCjaR4RwpypsoSn0tHl
	Kl89KlE4maOvNUOFvbmmcnQGJI55DICCi2BSfR0dMlEqtrETeeBQdsyG8X/2i761bKqd38Si0nX
	UCpd5SkVMkzpQkrzSk+QgWdOwwiTLVr1ashVz3ZfsLrOWN8AJ1SOhfEOnGh9BrnvxR3QoVXGOpq
	pRmxyDdKxRYkAQC4s3KdHIpuE7O51Osn18w9qYcQBH7VJhlhtFYFYksqqDcNX36jg+fj57C3rhF
	8OR36EvcRx/9hw==
X-Received: by 2002:a05:6820:810a:b0:6be:5642:7e65 with SMTP id 006d021491bc7-6df3389e6f0mr3532085eaf.43.1790989323349;
        Fri, 02 Oct 2026 18:02:03 -0700 (PDT)
Received: from com-79390 (vpn-centralus-02.tradc-corp.com. [20.98.136.114])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6df37fe2a90sm3908332eaf.2.2026.10.02.18.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 18:02:02 -0700 (PDT)
Date: Fri, 2 Oct 2026 20:01:59 -0500
From: Taylor Blau <ttaylorr@openai.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ted Nyman <tnyman@openai.com>, Elijah Newren <newren@github.com>
Subject: Re: [PATCH v2 8/8] repack: include required packs in incremental
 MIDX writes
Message-ID: <asBUBwM2N8lQM602@com-79390>
References: <cover.1790731662.git.me@ttaylorr.com>
 <cover.1790827875.git.me@ttaylorr.com>
 <a42f775cbe27b385bfc8ff38f33604b3913dc340.1790827875.git.me@ttaylorr.com>
 <20261002234157.GF834759@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261002234157.GF834759@coredump.intra.peff.net>

On Fri, Oct 02, 2026 at 07:41:57PM -0400, Jeff King wrote:
> On Wed, Sep 30, 2026 at 11:12:05PM -0500, Taylor Blau wrote:
>
> > The geometric plan from 1da62fb5c86 (repack: implement incremental MIDX
> > repacking, 2026-05-19) can omit kept and cruft packs, since neither
> > necessarily participates in the geometric repack. Such packs can also be
> > lost when replacing a tip layer that contains them. Neither plan
> > consults `midx_included_packs()`, so the rules for retaining cruft in
> > ordinary MIDX writes do not protect incremental writes.
> >
> > Use that selection logic to add missing packs to each plan's write step.
> > Skip packs in retained base layers, but include required packs from a
> > replaced tip. Count added objects when choosing which layers to compact,
> > without changing the preferred pack.
>
> I admit I had a hard time following this patch. I think the point is
> that we're going to include some packs in the midx that were not covered
> previously. But it was hard to see where that happens. I think the magic
> bit is this:
>
> > @@ -557,17 +604,20 @@ static void repack_make_midx_append_plan(struct repack_write_midx_opts *opts,
> >  					 size_t *steps_nr_p)
> > [..]
> > -	for (i = 0; i < opts->names->nr; i++) {
> > +	midx_included_packs(&include, opts, m);
>
> where we rely on midx_included_packs() to do that selection.

Yeah, that's right. I wrote this code in the first place, and it wasn't
even *that* long ago and I had to spend a not-insignificant amount of
time (re)acquainting myself with this area before writing this patch.

Thanks,
Taylor

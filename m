Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8572E975E
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 00:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790988664; cv=none; b=Og3Z6Q6Gf7IAxls729XKW9pITruOzctCCOkYhfHORlSn8yyrTt7N/Lkxtu9VB51lJWJia+EVH+J+wCFqIC0JmWe54pSayGQ+EAUFWWXQ6tEX297W2mVGceItA9Mu+G1vX5kyEj3GikFG7UswvSvAwQ8NwlQXFntifXY4RjEnamo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790988664; c=relaxed/simple;
	bh=Kows5J8Y75w8dMMVb/WkBmYVxpRlqNp3nii5Wk6L0CM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MUDYt4a6bnx4E+P+b34di8fciYX3nkpcZk3ax/7DnpSqNffUqLqRW2IejuFPyt4i/TVND0BADIowVwaAtIv15p+K62ASity/aHloF+WsM3htnqLd4+n3SJFouBLeJ/fxi9JLSpD1+mjlUV+6gzSN5ULNTUn2J55yhOTmE/dugKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=QEYoCjgA; arc=none smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="QEYoCjgA"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4c13f2685f2so13391b6e.1
        for <git@vger.kernel.org>; Fri, 02 Oct 2026 17:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1790988660; x=1791593460; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c7SEDd7Q/CzMh18glby9ZDe+IZlSBkyYtkigz+uhScU=;
        b=QEYoCjgAr9XFP90wXQjFWN3rcJz45xlmPkfcE6skCxZR7PIkyAOWTQ/CP1iWHbuyap
         8rYXtWNNFWiginGLtOC4w0DCB7wvbHdtiwWrp+ojpBmIBe1EbF2dxbEUQeAsqm3D/8EQ
         LtaGZak6kjLFRYz9CrlBWGbvKZnAgs8Cd5yGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790988660; x=1791593460;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c7SEDd7Q/CzMh18glby9ZDe+IZlSBkyYtkigz+uhScU=;
        b=iXmcmo0E47rXkSGLc6CVKwtDqr8h/+poa93Bwz8Q1Pu03t7Nk1BK0y0D1P8lujkrZB
         AVjvjI4ICR2fFP01F2n1PQ1yAUoZ7+YeC1cEhZyszpjPRjYX+gxRN7iL4G+/n/xl5M2g
         +eyfuMzqk8qGBYZbiP79hjFifWBKuWUmWl00HDZUR+1QqKkHYXxOKN8H2kVEsxqANx1t
         zJr6g9rH/NuuSMrdwAoZHN1JJK1/NdhpuDJu/rO+jHZnwJVWD0Hc3++Jsc6YBe+fK5oZ
         licGd2evcXC41gAdi7oUDBqGJ2K2n382gUCTTTrZjCboqbJGr7b/gTE5IPJh8z4ODNGv
         FouA==
X-Gm-Message-State: AFuF++n7VQ0dStCB1uZvnB8ANQXGFQTswQkKbbMtRP1pJr0YoTxSiorn
	ifhaB2x3H088Pouwsls0gUKC8KGGfOKcA53Cfw47rJEcR+Fagvbk9JUeXsIHJ98EyQc=
X-Gm-Gg: AYBFou3T2+K0q3LyvMNolvvUoDbMfQmdOpnwDfISv47Oow9yn5lfO02ipM+cOeqgb8M
	mzxRJetu9jEU5spbD6jAu2D/8a/JbW0vCYo3/WABQzHy1B2LUdiaYITOFueAcFOw8B0UDE0fdr4
	lzXoeOVrRmWGcPlOmearE9a/J5GIvzlIiwh4SP2GF3EUohKT06QHYdnLp2I+/x6fKeoEN2hR76K
	luhO/qomJX93hgMD/ABX0i7ZDGBJ5ko+ZzSv5ZJQydbbwRnafZjHm/qTLI1ZBRho059pLYRQByG
	qLDojhDtuOKBmaKUbyzfMvkZcEo7c1cv07k8S/gTFEKfUWRs25xDY8fP/YhpGY25c2lbkS22rp5
	tTP/ZDA5Jo2y+jMAF3TmSyJ1M3msHp8d3Ni0G6D0I64XoQNKQi3bWdxKqmvfqQAhgDQ30/zy0+T
	jhpb+zIUdshA7Po6N7O/xm2WwnULXzZI+WxWRcg227v0bQ1ODI0foZvOkyF6TqyY21Q4UW4Tdu3
	YoxYfZqwCsGE4frRebi4RjFvSBvsUGEKhMjNH6rbLFSX/JCxUJflPHus1NaIrfJ7ORcSBQSZOs9
	5FFYx5AnqoV6XA==
X-Received: by 2002:a05:6808:4f50:b0:4f6:cda3:ec05 with SMTP id 5614622812f47-4f6cda3ef7fmr310662b6e.55.1790988659631;
        Fri, 02 Oct 2026 17:50:59 -0700 (PDT)
Received: from com-79390 (vpn-centralus-02.tradc-corp.com. [20.98.136.114])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4f5252e3207sm3768587b6e.16.2026.10.02.17.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 17:50:59 -0700 (PDT)
Date: Fri, 2 Oct 2026 19:50:51 -0500
From: Taylor Blau <ttaylorr@openai.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ted Nyman <tnyman@openai.com>, Elijah Newren <newren@github.com>
Subject: Re: [PATCH v2 5/8] repack: follow kept packs when omitting cruft
 from the MIDX
Message-ID: <asBRayrg2RvzjevI@com-79390>
References: <cover.1790731662.git.me@ttaylorr.com>
 <cover.1790827875.git.me@ttaylorr.com>
 <51e20444dac1223f0e0485dc5799ed6d592f7614.1790827875.git.me@ttaylorr.com>
 <20261002232529.GD834759@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261002232529.GD834759@coredump.intra.peff.net>

On Fri, Oct 02, 2026 at 07:25:29PM -0400, Jeff King wrote:
> On Wed, Sep 30, 2026 at 11:11:51PM -0500, Taylor Blau wrote:
>
> > diff --git a/builtin/repack.c b/builtin/repack.c
> > index 88b05e96b5b..27d6668a4ab 100644
> > --- a/builtin/repack.c
> > +++ b/builtin/repack.c
> > @@ -476,9 +476,11 @@ int cmd_repack(int argc,
> >  	show_progress = !po_args.quiet && isatty(2);
> >
> >  	strvec_push(&cmd.args, "--keep-true-parents");
> > -	for (i = 0; i < keep_pack_list.nr; i++)
> > -		strvec_pushf(&cmd.args, "--keep-pack=%s",
> > -			     keep_pack_list.items[i].string);
> > +	/* Geometric follow walks exclude these packs through stdin instead. */
> > +	if (!(geometry.split_factor && !midx_must_contain_cruft))
> > +		for (i = 0; i < keep_pack_list.nr; i++)
> > +			strvec_pushf(&cmd.args, "--keep-pack=%s",
> > +				     keep_pack_list.items[i].string);
>
> This conditional makes my head hurt because of the double-negation. By
> De Morgan's it is just:
>
>   if (!geometry.split_factor || midx_must_contain_cruft)

Yeah, I struggled a bit when writing it TBH and flip-flopped between the
two. I read the conditional (as proposed in my patch) as:

    "If we aren't doing a geometric repack where the MIDX is allowed to
    omit cruft objects".

But I think the original sin here is midx_must_contain_cruft, which
probably should have been midx_may_exclude_cruft, which defaults to
false as opposed to the former which defaults to true.

It's not quite a double negation, but I agree that it's a little
awkward. TBH I find the rewritten version just as confusing if not more
so.

Thanks,
Taylor

Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEDF143883
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 18:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722538366; cv=none; b=hFUOvT3amwcFJCy9mv3SssPlYyWkCJVFWHnuwASsVRSxiz4OwTIkMufCWeUU7P8qcUX9HlmqfP5HOeuAI099khrwE1G+//CUxPPw0/rnuuI44pH+J5z+vEx4BOi2ZVrGRTFgM8Y0p9TOJ+7CG/0IdYv9hmWYP8irXkMvsVlfWms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722538366; c=relaxed/simple;
	bh=rXLgEwjRhk6bfsofBmcNFghzefJhoZWKLpRBrz6m87M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aa9DYmD3LZtEUQ5uMthA3qH3sp2VhNWeADvo0LTaypuGNpheKkNdTaHzPdYY4QtFycb3k88sjwfBmmCDAKd6FTAiy6ERpbiDNhDZGlkkZ709PPvSXYWSnSAA93v5QG+KHrx1/94vDP39Q9Os9r5smLQBJFRVrg6F2Wp/DfMpo1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=2galtfiL; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="2galtfiL"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e08a538bf7bso1992026276.1
        for <git@vger.kernel.org>; Thu, 01 Aug 2024 11:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1722538364; x=1723143164; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uzFujmCPIxRavw3l1m/gg5OoxiyqAzM9dM1JsgBWLJc=;
        b=2galtfiLjCuzYzm+fxq7DQG1wb5vmEOonV6t75a7JjK1pKtz6sj3p+6sWBMEsNklaV
         pOD5AY8qZsxBFJXwjO2rcJA75Mh273AXfqhJa8lZF82477VbpnDLe5PMSMp/MwWbE3wK
         /wDnsXT5JZPeX3Awelf6zHyIdryp9otQqdUQH7hAGErylpybbNVzX73hLs0E+QLNcHqo
         9CxTwrLluyX9SpQ4aGG+P2zVHEN1dPm9k98cnp8S/r3os5ZoNhTDqANT3LRhZIM2PyfI
         MZgDfzFLH7X+gFZr5Z0WGeYo9CO1Xs2BkSwAgJeGl8ZX6Jo7VfAamsRv8YSmm1oy0RgP
         5tNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722538364; x=1723143164;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uzFujmCPIxRavw3l1m/gg5OoxiyqAzM9dM1JsgBWLJc=;
        b=O87ozAQLUxzCcLiiTInAtVLkZ9WU46S85NNXTCGCfyx1Is+MFwROp87PcqcB5Hj81r
         01t3RvK9r6th+4m/9j2lms2mpul9anFj+q6AD/GfZRaMGLKRNn2EV2DX6CeUJ7Dhp2AV
         b8cC6D/22psUJAoVdZwvbIB5Hulcv4FJRXVXmn4XGlf9j07BUSLlxomByGT9v9hfz+Oi
         8r+4AS9CTv1q3M3QNi+yKpHymeFkabJinz5NOcXnUfd95rW5jpTl5rzEZIlKVMuPfuuV
         YBoo/f0SK43SO2kijrG9/WCRHXh8TvXQAFUSDlxEmYS+SFqDJ94SnfusWhX3lR4lJZRD
         l3bw==
X-Gm-Message-State: AOJu0Yymc6iQhnzzaAx4ESuGbX+W5o8akFR31dbrB5uOY9lP4QtmTkPM
	IsYXhEdBHaIy+QnBf/HiALNxsNX+g95rcZLjsjR7D1u/6tMfkEBXmlydGI+e1Bw=
X-Google-Smtp-Source: AGHT+IFgRvgRkBtlJUwJhvNfPL/hFMQtt7+prOJbPbzD386alccFc5M32G206r29EYeN/2uXKGI3ag==
X-Received: by 2002:a05:6902:4af:b0:e0b:dca9:c3b0 with SMTP id 3f1490d57ef6-e0bdca9c96cmr1311173276.3.1722538363698;
        Thu, 01 Aug 2024 11:52:43 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e0be0db6bf2sm44238276.10.2024.08.01.11.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 11:52:43 -0700 (PDT)
Date: Thu, 1 Aug 2024 14:52:41 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 01/19] Documentation: describe incremental MIDX format
Message-ID: <ZqvZeWDGDAeZNZjW@nand.local>
References: <cover.1717715060.git.me@ttaylorr.com>
 <cover.1721250704.git.me@ttaylorr.com>
 <014588b3ecf2e32a6ab1af8e77234dfb2f9ea75a.1721250704.git.me@ttaylorr.com>
 <20240801091952.GA1159276@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240801091952.GA1159276@coredump.intra.peff.net>

On Thu, Aug 01, 2024 at 05:19:52AM -0400, Jeff King wrote:
> > +As above, there are no fundamental limitations that stand in the way of
> > +extending the incremental MIDX format to support reachability bitmaps.
> > +The design below specifically takes this into account, and support for
> > +reachability bitmaps will be added in a future patch series. It is
> > +omitted from this series for the same reason as above.
>
> It is nice that you added a bit of a roadmap here about what is
> implemented and what is not, and that the design takes into account
> future directions (especially incremental bitmap generation).
>
> It does feel a little funny to say "this series" in text that will go
> into the repository (i.e., somebody reading the checked out file will
> say "huh? which series?"). I'm not sure how to word it better, except to
> maybe just say "in the future" and "it is omitted for now" (and
> obviously it's a pretty minor point).

s/this series/the current implementation/ ?

Definitely an oversight on my part, thanks for catching. I'll squash it
in.

> > +The `multi-pack-index-$H1.midx` file contains the first layer of the
> > +multi-pack-index chain. The `multi-pack-index-$H2.midx` file contains
> > +the second layer of the chain, and so on.
>
> Makes sense. How does the chained multi-pack-index.d interact with a
> singular multi-pack-index? Generally we should not have both at the same
> time, but I'd imagine they both exist for a brief period when moving
> from one to another.
>
> I assume the rules are the same as for commit-graphs, which use the same
> on-disk structure. I can't think of a reason to prefer one over the
> other but this might be a good place to document what does/should
> happen.

The commit-graph code reads the non-chained commit-graph first (see
commit-graph.c::read_commit_graph_one() for exact details, paraphrased
here):

    struct commit_graph *g = load_commit_graph_v1(...);
    if (!g)
            g = load_commit_graph_chain(...);
    return g;

and I matched the same for the MIDX code. I think there are reasonable
arguments for preferring either one over the other, so I think the
easiest thing to do is just throw our hands up and stick with the
convention ;-).

> > +=== Object positions for incremental MIDXs
> > +
> > +In the original multi-pack-index design, we refer to objects via their
> > +lexicographic position (by object IDs) within the repository's singular
> > +multi-pack-index. In the incremental multi-pack-index design, we refer
> > +to objects via their index into a concatenated lexicographic ordering
> > +among each component in the MIDX chain.
>
> How do duplicate objects work here? I guess there aren't any duplicates
> in the midx itself, only in the constituent packfiles. So from the
> perspective of this section, I guess it doesn't matter? And from the
> perspective of bitmaps (where the duplicate issue came up before), it is
> business as usual: the midx revindex gives the bit order, and we'd
> presumably concatenate the individual revindexes in chain order.
>
> (Mostly just thinking out loud; I'm not sure there's much for you to
> answer there).

Right. In a pre-incremental MIDX world, MIDXs contain no duplicate
object entries with respect to themselves. In this new world, the same
is true, with the additional property that MIDXs also contain no
duplicates with respect to their ancestors (when part of a MIDX chain).

> Looking good so far...
>
> -Peff

Thanks,
Taylor

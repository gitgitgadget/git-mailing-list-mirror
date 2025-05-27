Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE893142E67
	for <git@vger.kernel.org>; Tue, 27 May 2025 10:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748342400; cv=none; b=W9tY7Swy+b2FDnkIRhh9YBeJ+zwjHFIiQLhp75Av7Ju3BB36l+hZ7cRe41fErOmLdf9RQFjZlc7FbkY4Czro8RqFxJV2zpwZ0E+mtNTyA+9JEnWDrZ3meGwJP8VFydXE9bh/LneJBah/3YPor+iQFjOJEMvnVyDCZctZdnrUq1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748342400; c=relaxed/simple;
	bh=kenJH5TpEnES1l61J3qjEqLeH0Gg34nocMIjlONJnSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dgss8w0jWg48McoYTdVTnh/tGUHNCWDO+npOyeNHa/1rUiVcaC0AnZhDCftUV2o41g/CBnINFniU7Rg4TcVT60eyg9tW2sAvPUf6vbIYePSTfBtNxKsf3uS4JsESnWa/gP6vJEL9gwPKuGbsadq79c6tJ0QvIHf1997WuGNjbAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LvSHSSZ2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lgzhzgHw; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LvSHSSZ2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lgzhzgHw"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 918312540115;
	Tue, 27 May 2025 06:39:56 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 27 May 2025 06:39:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1748342396; x=1748428796; bh=/FGjBPWdlA
	m7WQgJAMwhZ4V92vxwb4e/fLvOAw3qvqc=; b=LvSHSSZ2cPXjI9KZ8Zc54DTJpg
	UhC0CpW/TPW9P6CqmtMkvAtu1wX9V/83402ZBhoiDeuE7pFvU5L4CqRHlJnW2LDR
	U+C2728DIxHvS288+e04gINp4FhHule0ov4+yidYbZ2qzfhGHORppaLQo7o7v+OR
	SRRI/W0/pTMd6OE4eAsd8qk5d4mTPqGbTiLXT/iGuMv8ytXNrjrpWp8c8J884h+v
	4oIq84AkAZJFJYCQTnac569szooDzih9alVBPtRw/Wi6lpVuKhDym28oBkhWhLRz
	6rMHztcgFWr7OsnnI8YZYvcRvvQdixJGDgm7xF3ZkrVLqS6KpjJHA45KaAug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748342396; x=1748428796; bh=/FGjBPWdlAm7WQgJAMwhZ4V92vxwb4e/fLv
	OAw3qvqc=; b=lgzhzgHwblWWEwFg19td8efo9X3yvv7z57vHrZwzHbQvIOVCCcq
	T8up2QDpAihxOJaxz/Vcx3VhUPGzgMcJFEUHPrNIRfkecQVxnTP7gAykWPbEC/O/
	a5zhOFNM/oV0UATVC7DRp0HYUlE9Tz3sNWNZIJUoBP/5axXBen18gf6CTAfzV3qa
	j2bt/dFs8YaSLZ9zMtIs+Y6f6XqSZP/329DSXfX+rhBMl2XyjDb2EbwbmNfjpPka
	MPb+oANs8Iua33qG0dtTwOmq8xv1ledk30NF9VKeFVSYdvKzBjCP5KmRNysZo6mV
	mLG6a2MPWgx5yvM/K0jpeyv0rc8q+vcDxxA==
X-ME-Sender: <xms:e5Y1aD9CJsXgOCWyLjqNT_ujSE3sgGebP0A14u90XWfc53JTTmdWAg>
    <xme:e5Y1aPvq2Ewc__blVP9ZbnDnbQMzvQKidoowBYrw3pK-tqmMWSqlfqbFgKOcfdxGo
    Ufzn_W0tZmEC-MN3g>
X-ME-Received: <xmr:e5Y1aBDnPdxMXTc2HqA0XV1DLDoopLO8AeAN-0wIqOA9TFOfRTMOCveT62xNaEj2QhXu-xfrAQdO62rBisKo4Zx3vn9xJ0hKAC_Cn5EJFqC6Vg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvtddujeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhf
    gggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrh
    guthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtledu
    iefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrvhgrrhgrsgesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehsthholhgvvg
    esghhmrghilhdrtghomhdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgt
    phhtthhopehmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:e5Y1aPctl4uudZf_gdFg5gw8AFwNP3K4Sk0Lgyd0LXF5g2hlAels2g>
    <xmx:e5Y1aINAohDGaCv9Krg7JSNsaJf6hrsPA7YCsNQX1MDEiGYRintfvQ>
    <xmx:e5Y1aBnGtW6GdBATqrs4DKSXuVkUONvQk-AHz2UsF4j779nnUL0r-w>
    <xmx:e5Y1aCtgCTMn9WSNWZEzyf-BRfnQSQDgYvJgrRxqsDGYesoqfv7p9g>
    <xmx:fJY1aHCZivE2C02gTJsmR7eolXGpb-m9VV_OT1B9ih9zDA6i0hT-VxBG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 May 2025 06:39:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 483c99fd (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 27 May 2025 10:39:52 +0000 (UTC)
Date: Tue, 27 May 2025 12:39:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH RFC v2 4/5] last-modified: implement faster algorithm
Message-ID: <aDWWdGVW90LpxZhH@pks.im>
References: <20250523-toon-new-blame-tree-v2-0-101e4ca4c1c9@iotcl.com>
 <20250523-toon-new-blame-tree-v2-4-101e4ca4c1c9@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523-toon-new-blame-tree-v2-4-101e4ca4c1c9@iotcl.com>

On Fri, May 23, 2025 at 11:33:51AM +0200, Toon Claes wrote:
> The current implementation of 'git last-modified' works by doing a
> revision walk, and inspecting the diff at each level of that walk to
> annotate the to-be-found entries to a path. In other words, if the diff
> at some level touches a path which has not yet been associated with a
> commit, then that commit becomes associated with the path.

It's a bit funny that we first introduce an algorithm, only to change it
in a subsequent step again. I don't mind it much though: this variant
here is quite a bit more complicated, and it's nice to first gain an
understanding of how the simple algorithm works before going to the
harder one.

It's also nice that the tests prove that this is indeed leads to the
same result.

[snip]
> More specifically, consider a priority queue of commits sorted by
> generation number. First, enqueue the set of boundary commits with all
> paths in the original spec marked as interesting.
> 
> Then, while the queue is not empty, do the following:
> 
>   1. Pop an element, say, 'c', off of the queue, making sure that 'c'
>      isn't reachable by anything in the '--not' set.
> 
>   2. For each parent 'p' (with index 'parent_i') of 'c', do the
>      following:
> 
>      a. Compute the diff between 'c' and 'p'.
>      b. Pass any active paths that are TREESAME from 'c' to 'p'.
>      c. If 'p' has any active paths, push it onto the queue.

What if an active path is changed on both sides of a merge commit? Do we
pass it to the first parent?

[snip]
> Now, some performance numbers. On github/git, our numbers look like the
> following (all wall-clock times best-of-five, and with '--max-depth=0'
> on the root):

This option does not exist in this version of git-last-modified(1).

>                  github		ttaylorr/blame-tree-fast
>    with filters: 0.754s		0.271s (2.78x faster, 6.18x overall)
> without filters: 1.676s		1.056s (1.58x faster)
> 
> and on torvalds/linux:
> 
>                  github		ttaylorr/blame-tree-fast
>    with filters: 0.608		0.062 (9.81x faster, ~52x overall)
> without filters: 3.251		0.676 (4.81x faster)
> 
> In short, the existing implementation is comparably fast *with* filters
> as the new implementation is *without* filters. So, most repositories
> should get a dramatic speed-up by just deploying this (even without
> computing Bloom filters), and all repositories should get faster still
> when computing Bloom filters.

It would be nice to introduce "filters" as "Bloom filters". I was
initially wondering what filters you talk about until you then mention
it in the last sentence.

> diff --git a/last-modified.c b/last-modified.c
> index f628434929..0a0818cdf1 100644
> --- a/last-modified.c
> +++ b/last-modified.c
> @@ -3,18 +3,20 @@
>  #include "commit.h"
>  #include "diffcore.h"
>  #include "diff.h"
> -#include "object.h"
>  #include "revision.h"
>  #include "repository.h"
>  #include "log-tree.h"
>  #include "dir.h"
>  #include "commit-graph.h"
>  #include "bloom.h"
> +#include "prio-queue.h"
> +#include "commit-slab.h"

It would be nice if we could keep these lexicographically sorted right
from the first commit.

> @@ -116,6 +128,20 @@ void last_modified_release(struct last_modified *lm)
>  	}
>  	hashmap_clear_and_free(&lm->paths, struct last_modified_entry, hashent);
>  	release_revisions(&lm->rev);
> +	free(lm->all_paths);
> +}
> +
> +struct commit_active_paths {
> +	char *active;
> +	int nr;

Should this be a `size_t` as it is counting something?

> +};

Hm, a bit weird, as I don't kno what `nr` is supposed to stand for.
Intuitively I would have expected that `active` is an array of strings,
and that `nr` tracks how many there are. But that's not the case.

Let's read on.

> +define_commit_slab(active_paths, struct commit_active_paths);
> +static struct active_paths active_paths;
> +
> +static void free_one_active_path(struct commit_active_paths *active)

s/free_one_active_path/commit_active_paths_release/

> @@ -197,7 +230,32 @@ static void last_modified_diff(struct diff_queue_struct *q,
>  	}
>  }
>  
> -static int maybe_changed_path(struct last_modified *lm, struct commit *origin)
> +static char *scratch;

Having a global variable like this in a library is not great. Can we
instead pass around a context or something like this internally?

> +
> +static void pass_to_parent(struct commit_active_paths *c,
> +			   struct commit_active_paths *p,
> +			   int i)
> +{
> +	c->active[i] = 0;
> +	c->nr--;
> +	p->active[i] = 1;
> +	p->nr++;

Okay, so `active` is a bitfield. It's a bit weird that we use a full
byte for each bit though. It might not matter much in practice, but it
feels quite wasteful to me. Doubly so because we allocate this bitfield
for every commit we visit.

Can we maybe instead use `struct bitmap` for this?

> +}
> +
> +#define PARENT1 (1u<<16) /* used instead of SEEN */
> +#define PARENT2 (1u<<17) /* used instead of BOTTOM, BOUNDARY */

These are the same definitions as in "commit-reach.c". Might be worth it
to deduplicate those.

> @@ -221,8 +281,88 @@ static int maybe_changed_path(struct last_modified *lm, struct commit *origin)
>  	return 0;
>  }
>  
> +static int process_parent(struct last_modified *lm, struct prio_queue *queue,
> +			  struct commit *c,
> +			  struct commit_active_paths *active_c,
> +			  struct commit *parent, int parent_i)
> +{
> +	int i, ret = 0; // TODO type & for loop var

This looks like a left-over comment that should be addressed.

Patrick

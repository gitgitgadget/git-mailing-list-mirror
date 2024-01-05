Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B8931A71
	for <git@vger.kernel.org>; Fri,  5 Jan 2024 17:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ZDx7Ls1h"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7816e463b8aso115948585a.3
        for <git@vger.kernel.org>; Fri, 05 Jan 2024 09:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1704474466; x=1705079266; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d+5jRhbIO5xif+0buWVu9SzFkrEKrrRuOXVjELoS3Tg=;
        b=ZDx7Ls1hz81wrHr3hxMC2Kec/Yzgy9e0RyEjho8AMclnDfrEhSJlWTqVmpbMskFcEA
         CLES6bQNSIj65xtwNZwcLNKZOYQVscMXXJvneKQWTWv52fKPmUK73YieKtjJrA2iD+Bf
         BYp0kU7ORSt2iWEMTQdRy/jrWSnDUO6MpbFz9xoDy0f3A+zyfQebKu4UMaWdKkZUd4Tg
         6I+T3kLhcmIjOTwx48knezvfNgvlo/2Mg0hDWLqsB0GxRQMF+Ze+kvrxq6MeoM3ljCaP
         Z3SZumilvoX/xrZTNrH4A+69Mh9OL2ZGQifx/c82ZdxbKdVlEHLEuvg20bota5ddDBIi
         BLiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704474466; x=1705079266;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+5jRhbIO5xif+0buWVu9SzFkrEKrrRuOXVjELoS3Tg=;
        b=OQEskF5Oeep9+ax+PPxJYqRaSbdM1IacOcmgeKWYc8kN5Q/i3oeP8en/rJUbK5UGYy
         qpgC4gRbtJwrvuUQ+ayX0Ncii2S2kZmVF+M0fF4HlLuIW0XxjZd8AB+jVqUQaxL0ipmV
         p+j4NJ7/nD3Jny449c1Sisw4BwunqsFnruSEM6d3r0UsHQPJnLvK+nLIUc6NcloyBnM6
         m1AQJ90I4Gx+zrZgUJuEqq3xMGRwvPGCAmWUJmPfa0bjffoQAeXFcjckG+0ePwkxD6DF
         Qd/V82OFqKhIprG1W3YEg9pOf0F74e39IT+ZnG46JWeZNNicylUVratJpLPe/e78583p
         8bRw==
X-Gm-Message-State: AOJu0YyiBwmetPVRAJ6ughe6bV3eqwmTACBLOqcwnQUxI8aCv7YR6bsA
	MdrilJupUflozwhcSSvYksGgRQme7bH+Pw==
X-Google-Smtp-Source: AGHT+IGAvyDrookMJbk1LYGKuqpfdxVW9klcMdnDxk+pmmkCGayKFbRZYC+5mTLMw52b+MU2U5odPw==
X-Received: by 2002:a05:620a:4552:b0:781:ad92:1708 with SMTP id u18-20020a05620a455200b00781ad921708mr2316883qkp.97.1704474465650;
        Fri, 05 Jan 2024 09:07:45 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b23-20020a05620a04f700b007815b84dbb3sm716855qkh.49.2024.01.05.09.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 09:07:45 -0800 (PST)
Date: Fri, 5 Jan 2024 12:07:44 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Scott Leggett <scott@sl.id.au>
Subject: Re: [PATCH] commit-graph: retain commit slab when closing NULL
 commit_graph
Message-ID: <ZZg3YIEDCjbbGyVX@nand.local>
References: <20240105054142.GA2035092@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240105054142.GA2035092@coredump.intra.peff.net>

On Fri, Jan 05, 2024 at 12:41:42AM -0500, Jeff King wrote:
> This fixes a regression introduced in ac6d45d11f (commit-graph: move
> slab-clearing to close_commit_graph(), 2023-10-03), in which running:
>
>   git -c fetch.writeCommitGraph=true fetch --recurse-submodules
>
> multiple times in a freshly cloned repository causes a segfault. What
> happens in the second (and subsequent) runs is this:
>
>   1. We make a "struct commit" for any ref tips which we're storing
>      (even if we already have them, they still go into FETCH_HEAD).
>
>      Because the first run will have created a commit graph, we'll find
>      those commits in the graph.
>
>      The commit struct is therefore created with a NULL "maybe_tree"
>      entry, because we can load its oid from the graph later. But to do
>      that we need to remember that we got the commit from the graph,
>      which is recorded in a global commit_graph_data_slab object.
>
>   2. Because we're using --recurse-submodules, we'll try to fetch each
>      of the possible submodules. That implies creating a separate
>      "struct repository" in-process for each submodule, which will
>      require a later call to repo_clear().
>
>      The call to repo_clear() calls raw_object_store_clear(), which in
>      turn calls close_object_store(), which in turn calls
>      close_commit_graph(). And the latter frees the commit graph data
>      slab.
>
>   3. Later, when trying to write out a new commit graph, we'll ask for
>      their tree oid via get_commit_tree_oid(), which will see that the
>      object is parsed but with a NULL maybe_tree field. We'd then
>      usually pull it from the graph file, but because the slab was
>      cleared, we don't realize that we can do so! We end up returning
>      NULL and segfaulting.
>
>      (It seems questionable that we'd write a graph entry for such a
>      commit anyway, since we know we already have one. I didn't
>      double-check, but that may simply be another side effect of having
>      cleared the slab).

Yeah, I agree that we should not be re-writing a commit-graph entry that
already exists in an earlier (non-removed) layer of the commit-graph.
I haven't thought through all of the details here, but that sounds like
a potentially dangerous thing to be doing.

> So that fixes the regression in the least-risky way possible.

Thanks for the detailed explanation. I think that the fix presented here
is a reasonable approach, and is worthwhile to pick up.

> I do think there's some fragility here that we might want to follow up
> on. We have a global commit_graph_data_slab that contains graph
> positions, and our global commit structs depend on the that slab
> remaining valid. But close_commit_graph() is just about closing _one_
> object store's graph. So it's dangerous to call that function and clear
> the slab without also throwing away any "struct commit" we might have
> parsed that depends on it.

I definitely agree that there seems like a high risk of another
potentially-dangerous bug happening as a result of this area.

One thing that sticks out to me is that we have a scope mismatch
between the commit structs, the raw_object_store, and the commit slabs.
Slabs are tied to the lifetime of the raw_object_store, but the commit
objects are tied to the global lifetime of the process. I wonder if it
would make sense to have a slab per object-store, and require that you
pass both the commit *and* the object-store you're looking it up in as
arguments to any slab-related functions.

I dunno. I have not put a ton of thought into that ^^ approach either,
so let me know if it seems obviously bogus to you or if this is worth
looking into further.

Thanks,
Taylor

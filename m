Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137B817583
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 17:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730741145; cv=none; b=a7/ximb7bCjx5j18PTlBlSbUaquz7o21IFWe81lWCbQkYSNlDkD3fHV0Psql3O0uj5NbOMj7AulAktLrch1at1VIQEGXvYGm/FR2ErMCiiVqwYef7Hcl1m1ZJ+SZ3hBcyiuN0A07NIxzn97ePou3eDjA0gqK9Kx6svrVC5OYvbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730741145; c=relaxed/simple;
	bh=QRk9fkiAaDhSe0tO6P1ezZeV+q2oea7l+MCTp3iLS94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YAUo/4JMuTKsxWCG6xx7wEoBoAAtQRAxcNLJBKZkyJWesJg9M3rOG9QzV/6bYepeZKsOw6q7MrchKJgr8v7V89tdS5yAmmYOoJMkgoPjWhrGlxSF9qCBSxXv/1wBjOJnzKWCqFXlUKOMfOjYTVSkE8PTX5dkvk6XfuAyOCWSjW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=G+N9qqpj; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="G+N9qqpj"
Received: (qmail 12481 invoked by uid 109); 4 Nov 2024 17:25:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=QRk9fkiAaDhSe0tO6P1ezZeV+q2oea7l+MCTp3iLS94=; b=G+N9qqpjLSZzCTA2QGOim7QSKceJVfif+zbaREvbi5UTy87C+6ZHjdiDSsQ7YQNOU1Wimyv/2zgBFFGqT8355iErGZu0E2QJY7AakcFhJW/HJ3sh+t8JfyXEk2y1UNgkvCLeVYARBCuib4VOQlBE3ZF1Au8EVPdw//UlMj7y6xN9nkO8Ub1Pnwi9H1UNZB6RFArInoOUbIUEZnG3VmRzH/q4m380J1vm02dh9Yvl2mlgHoozSjk87bXJn2UBpH/LaHn4OYChpaVceb02UxKKdKgtyhPb6fifl442NCmpdjuTsvNQJCvJ45Qbuhb4BjQtmS6STePZTRzfE3lqI+hdZg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 04 Nov 2024 17:25:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14471 invoked by uid 111); 4 Nov 2024 17:25:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 04 Nov 2024 12:25:33 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 4 Nov 2024 12:25:33 -0500
From: Jeff King <peff@peff.net>
To: Derrick Stolee <stolee@gmail.com>
Cc: Taylor Blau <me@ttaylorr.com>,
	Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
	ps@pks.im, johncai86@gmail.com, newren@gmail.com,
	christian.couder@gmail.com, kristofferhaugsbakk@fastmail.com,
	jonathantanmy@google.com
Subject: Re: [PATCH 0/6] PATH WALK I: The path-walk API
Message-ID: <20241104172533.GA2985568@coredump.intra.peff.net>
References: <pull.1818.git.1730356023.gitgitgadget@gmail.com>
 <ZyUqr/wb5K4Og9j9@nand.local>
 <2d2940ef-0b26-4060-90b6-9b6969f23754@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2d2940ef-0b26-4060-90b6-9b6969f23754@gmail.com>

On Mon, Nov 04, 2024 at 10:48:49AM -0500, Derrick Stolee wrote:

> > I was discussing this a bit off-list with Peff (who I hope will join the
> > thread and share his own thoughts), but I wonder if it was a mistake to
> > discard your '--full-name-hash' idea (or something similar, which I'll
> > discuss in a bit below) from earlier.
> 
> I'd be happy to resurrect that series, adding in the learnings from
> working on the path-walk feature. It helps that the current series adds
> the path-walk API and has no conflicting changes in the pack-objects or
> repack builtins. (I can handle those conflicts as things merge down.)

Adding my two cents, the discussion we had came after reading this post:

  https://www.jonathancreamer.com/how-we-shrunk-our-git-repo-size-by-94-percent/

I think a few of the low-level details in there are confusing, but it
seemed to me that most of the improvement he mentions is just about
finding better delta candidates. And it seems obvious that our current
pack_name_hash() is pretty rudimentary as context-sensitive hashing
goes and won't do well for long paths with similar endings.

So just swapping that out for something better seems like an easy thing
to do regardless of whether we pursue --path-walk. It doesn't
drastically change how we choose delta pairs so it's not much code and
it shouldn't conflict with other features. And the risk of making
anything worse should be pretty low.

I wouldn't at all be surprised if --path-walk can do better, but if we
do the easy thing first then I think it gives us a better idea of the
cost/benefit it's providing.

I suspect there's room for both in the long run. You seem to be focused
on push size and cost, whereas I think Taylor and I are more interested
in overall repo size and cost of serving bitmapped fetches.

> When the optimization idea is to focus on the full path and not care
> about the "locality" of the path name by its later bits, storing the
> full name in a list and storing an index into that list would have a
> very similar effect.
> 
> I'd be interested to explore the idea of storing the full path name.
> Based on my exploration with the 'test-tool name-hash' test helper in
> that series, I'm not sure that we will make significant gains by doing
> so. Worth trying.

The way I look at it is a possible continuum. We want to use pathnames
as a way to sort delta candidates near each other, since we expect them
to have high locality with respect to delta-able contents. The current
name_hash uses a very small bit of that path information and throws away
most of it. The other extreme end is holding the whole path. We may want
to end up in the middle for two reasons:

  1. Dealing with whole paths might be costly (though I'm not yet
     convinced of that; outside of pathological cases, the number of
     paths in a repo tends to pale in comparison to the number of
     objects, and the per-object costs dominate during repacking).

  2. It's possible that over-emphasizing the path might be a slightly
     worse heuristic (and I think this is a potential danger of
     --path-walk, too). We still want to find candidate pairs that were
     copied or renamed, for example, or that substantially share content
     found in different parts of the tree.

So it would be interesting to be able to see the performance of various
points on that line, from full path down to partial paths down to longer
hashes down to the current hash. The true extreme end of course is no
path info at all, but I think we know that sucks; that's why we
implemented the bitmap name-hash extension in the first place.

> I don't know too much about SimHash or MinHash, but based on what I
> could gather from some initial reading I'm not sure that they would be
> effective without increasing the hash length. We'd also get a different
> kind of locality, such as the appearance of a common word would be more
> likely to affect the locality than the end of the path.

Good point. This is all heuristics, of course, but I suspect that the
order of the path is important, and that foo/bar.c and bar/foo.c are
unlikely to be good matches.

> > I realize that this is taking us back to an idea you've already
> > presented to the list, but I think (to me, at least) the benefit and
> > simplicity of that approach has only become clear to me in hindsight
> > when seeing some alternatives. I would like to apologize for the time
> > you spent reworking this series back and forth to have the response be
> > "maybe we should have just done the first thing you suggested". Like I
> > said, I think to me it was really only clear in hindsight.
> 
> I always assumed that we'd come back to it eventually. There is also the
> extra bit about making the change to the name-hash compatible with the
> way name-hashes are stored in the reachability bitmaps. That will need
> some work before it is ready for prime time.

Having worked on that feature of bitmaps, I'm not too worried about it.
I think we'd just need to:

  - introduce a new bitmap ext with a flag (HASH_CACHE_V2 or something,
    either with the new hash, or with a "version" byte at the start for
    extensibility).

  - when bitmaps are not in use, we're free to use whichever hash we
    want internally. If the new hash is consistently better, we'd
    probably just enable it by default.

  - when packing using on-disk bitmaps, use internally whichever format
    the on-disk file provided. Technically the format could even provide
    both (in which case we'd prefer the new hash), but I don't see much
    point.

  - when writing bitmaps, use whichever hash the command-line options
    asked for. There's an off chance somebody might want to generate a
    .bitmap file whose hashes will be understood by an older version of
    git, in which case they'd use --no-full-name-hash or whatever while
    repacking.

If we're considering full paths, then that is potentially a bit more
involved, just because we'd want the format to avoid repeating duplicate
paths for each object (plus they're no longer fixed-size). So probably
an extension with packed NUL-terminated path strings, plus a set of
fixed-length offsets into that block, one per object.

> I disagree that all environments will prefer the --full-name-hash. I'm
> currently repeating the performance tests right now, and I've added one.
> The issues are:
> 
>  1. The --full-name-hash approach sometimes leads to a larger pack when
>     using "git push" on the client, especially when the name-hash is
>     already effective for compressing across paths.

That's interesting. I wonder which cases get worse, and if a larger
window size might help. I.e., presumably we are pushing the candidates
further away in the sorted delta list.

>  2. A depth 1 shallow clone cannot use previous versions of a path, so
>     those situations will want to use the normal name hash. This can be
>     accomplished simply by disabling the --full-name-hash option when
>     the --shallow option is present; a more detailed version could be
>     used to check for a large depth before disabling it. This case also
>     disables bitmaps, so that isn't something to worry about.

I'm not sure why a larger hash would be worse in a shallow clone. As you
note, with only one version of each path the name-similarity heuristic
is not likely to buy you much. But I'd have thought that would be true
for the existing name hash as well as a longer one. Maybe this is the
"over-emphasizing" case.

-Peff

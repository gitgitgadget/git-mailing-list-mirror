Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552771E0E14
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 00:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787272824; cv=none; b=HElKXHAjVQcJwYeT4xiJpbf0Z1l8bQpM6FwhdiBowCUGKrkljAtF7KTYOyE8hJAIGhjUoevZU8h9GD7gio8msvXa3hxTjO1UNLkwfzpB+FY7LmhgTVV2oLAM9pswBRGVUhcXnX4N7rKCVEtiuwcraNROMHVGOPPxR7e9Z/xEzy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787272824; c=relaxed/simple;
	bh=Gq98y59ULYeI6GcF6tkxZFb1ADeC0lKKyp152eDDFXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NH44A1WulEfU73QNLyURdOPk9uQiArrXZkpuRAkN5N+XHJrWeOZRl+6hpTiEcQmxuLOYU6buDduUCQBcQ7FhR4U3K1QKsivRUGI8vvEcLIzJ+CvG541VxGWrJT0FT8lmFNQjdNuKEAlHlgu2R4QadvgI5F2dvWgGCL4UyvqBf30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=NcbhmmwE; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="NcbhmmwE"
Received: (qmail 83097 invoked by uid 106); 21 Aug 2026 00:40:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Gq98y59ULYeI6GcF6tkxZFb1ADeC0lKKyp152eDDFXs=; b=NcbhmmwEZOBtUjeKZLy1XV0o15ES6+xAsjrkFSSeV0E9iuLb0rScWpoKfO4dO7aG7ffCqu1rYOqZApOZ4vgAzkHn+n3Jlq8W7Ho8lSCngT2Yi0Xxdv7+TjDlJ23yhd4S8+z/0ML+hMSFRUGKMFfH2fUvZgpC8oH7o4O0Q8KRqjOb35GSCs1NSi7WhtpNrU0Fp4Q8BMEq0C0H40MMpN9X2TPNv/dyns/HL8Eewi7CGTRqcAjm2xzwDV/3lfWUcbXVwJ+Kn/jh3urq21Unrojv/KzDwONFfVXviZgtvXfgfKMrXYYvt9RmZuFNt/JafcDdQNdNhq23QnfK+vPVHTGfOg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 21 Aug 2026 00:40:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 68349 invoked by uid 111); 21 Aug 2026 00:40:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 20 Aug 2026 20:40:23 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 20 Aug 2026 20:40:19 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: friel@openai.com, git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2] pack-objects: trace pack bytes written
Message-ID: <20260821004019.GA296407@coredump.intra.peff.net>
References: <20260817233914.8740-2-friel@openai.com>
 <xmqqo6f02q2f.fsf@gitster.g>
 <c6a8cdac36d2202055d637ebcc97e484122cdcd4.1787158152.git.friel@openai.com>
 <aoaTjWMSO8og_iFw@pks.im>
 <20260820082102.GA2973952@coredump.intra.peff.net>
 <aobFLJuiuM1EuNpv@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aobFLJuiuM1EuNpv@pks.im>

On Thu, Aug 20, 2026 at 11:13:16AM +0200, Patrick Steinhardt wrote:

> > But there's a subtle yet interesting difference here! f->algop won't
> > necessarily be the same pointer as the_hash_algo. If we compiled with an
> > unsafe variant, that will be used for hashfiles. If we're just looking
> > at rawsz that's OK; the two variants should be identical (other than
> > performance and collision detection), so taking rawsz from either is
> > fine.
> > 
> > But fixup_pack_header_footer() actually recomputes the hash (as it must
> > if we tweak the header). Right now it does it using the "normal"
> > variant, but we should be able to use the unsafe one (which my diff
> > snippet above would start to do).
> 
> Yeah, I agree that switching over to the unsafe algortihm is sensible.
> Being able to speed up hashing of packfiles was one of the prime
> motivations of introducing the unsafe variants in the first place, so
> the fact that we still use the safe variant here feels like a plain
> oversight to me.

Yes, though I think the oversight can be forgiven here. The unsafe
variants are purely for performance, so we started by converting a few
hot code paths, knowing that it was OK to leave other spots using the
collision-detecting implementation. The main one we cared about is
"pack-objects --stdout" to serve fetches.

But this particular case is almost never exercised! It triggers only
when --max-pack-size causes us to split the result into multiple packs
(we can't write the header up front in that case, because we don't know
how many objects we'll fit into the output). So I doubt anybody would
have noticed or cared about the performance difference.

But it also means that cleaning up the triple-hash is tricky. The three
hashes in this code path are:

  a. we hash as we write, via struct hashfile

  b. we hash as we read back the data to verify it

  c. we re-hash the data on top of the fixed-up header

We can obviously drop (b) if we choose. We can't drop (c); it's the
final value that goes into the on-disk packfile. So we'd like to drop
(a), which is pointless (except for cross-checking step b).

But we don't know if we're in this code path until we've finished
writing the file! If the output is smaller than --max-pack-size, then we
just write the hash from (a) directly, and neither (b) nor (c) happens
at all. This is the "nr_written == nr_remaining" conditional, the second
in the chain.

We could pessimistically assume that we'll need to do (c), and skip the
hash for (a). But that is worse for the usual case that we don't split
the packfiles. Instead of hashing as the data is written, we have to
re-read it (passing all those bytes through memory again).

So realistically the best we can do is drop (b).

Of course what I'd _really_ like to do is rip out --max-pack-size
entirely. I don't think it's generally helpful, and it introduces all
kinds of weird corner cases and complications like this. But obviously
that's a much bigger change, and naturally if I seriously proposed it
somebody would come out of the woodwork so with obscure case where it's
useful.

> > Of course this whole thing is absurdly pessimal in the first place. If
> > we are just going to throw out the hashfile's checksum, then why bother
> > computing it in the first place? Because we don't trust a disk write at
> > all, and actually verify the original hash computation as we read the
> > bytes back in! So we'll actually sha1 the written packfile three times.
> > Yikes. I wonder if it's really worth being so paranoid. But that is how
> > it has always been.
> 
> That's... awful. Honestly, if we cannot trust what we're writing to disk
> we're going to be kind of screwed anyway. We don't re-verify loose
> objects, refs or whatever other data structures we write to disk either.
> So doing this thrice here feels wrong.

There was an attitude in the early days of Git that we should be
checking hashes and checksums all the time. I.e., that the validity of
the data was the most precious thing, and we should notice an on-disk
corruption as quickly and reliably as possible, similar to filesystems
that checksum the data.

But over time we've relaxed that quite a bit because of the quite
noticeable costs. For example, we used to re-hash every object we
loaded, but these days we have PARSE_OBJECT_SKIP_HASH_CHECK, and
features like the commit graph.

I think this is a case where we could similarly relax. Especially
because this is just the pack checksum. The actual object contents are
still protected by their respective hashes.

-Peff

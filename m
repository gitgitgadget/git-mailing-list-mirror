Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C1435972
	for <git@vger.kernel.org>; Wed, 18 Mar 2026 03:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773802987; cv=none; b=Kpz5y7iuGl/MkW2nj2hvORgrLRvWjQ5zRAU2CVrMJXjFMJsztGtmSDJoii4j961LjEQ+LnTis1oUD/6AcHTRvVVQn0IXwM3K1hpQOOmUuejFt5FB17Cg1cvXp3UnFcdNtyqncRYiKysE8aUWNOHc6dAFM83U7re9gUEu1Zdams0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773802987; c=relaxed/simple;
	bh=K9pJCPnmAPbi81MRVe9hCnujSNWIPEPVOMlxRz2kiv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fsxyh3pQD5hmh07nw7DeHRd3w2hkLKu3e78W5nmS6UtrNx+4gi/0tGL5DZVwNpsL4TbgGqQ//9CvmZDdztnUGvYhC433ZXN3RtA/7TW5KJXKP3k9rqGqcxbxPCFXwi48VVFzMueURNk71ofTwPbsYdxhyxDp4y2q4BHsGDghqNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=VHE+VphS; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="VHE+VphS"
Received: (qmail 36890 invoked by uid 106); 18 Mar 2026 03:03:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=K9pJCPnmAPbi81MRVe9hCnujSNWIPEPVOMlxRz2kiv8=; b=VHE+VphSbD8Uj03erkQqKK2kHmfyrSwtROeUqV1+qhFU3MKYfaHgG5XxYFEC97OSxdICDHi4HBZQVDInibmm4KC7VXthPuaLaQiLOF0YA6zRd7WnrrJ5pKy1pl8+uKSz2dwDYmc3tL4beEXOXNVYwKVgNu08Wu4LsrSlx6DULH7f1u/h5k45i+Vkz9pZk71uO3G7KlELc4mJvTMpJ1Ez0xgJbaPnGgN/37o7sm0XjVcCyRPLr8urEphnSJ7b7pr4S+hSp1PHLtDY82IfNTpT2CpKSqEA3TDecQ/1J+0UlCrmieABsWXQZhz7bi9SZV1YoHpHPiVfFIyZNiNmYAGULw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 18 Mar 2026 03:03:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 55613 invoked by uid 111); 18 Mar 2026 03:03:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 17 Mar 2026 23:03:05 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 17 Mar 2026 23:03:04 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2026, #05)
Message-ID: <20260318030304.GA1926419@coredump.intra.peff.net>
References: <xmqqh5qka8so.fsf@gitster.g>
 <abh/LUGAWUDx/E2t@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <abh/LUGAWUDx/E2t@nand.local>

On Mon, Mar 16, 2026 at 06:07:41PM -0400, Taylor Blau wrote:

> On Thu, Mar 12, 2026 at 05:10:31PM -0700, Junio C Hamano wrote:
> > * tb/incremental-midx-part-3.2 (2026-02-24) 17 commits
> >  - midx: enable reachability bitmaps during MIDX compaction
> >  - midx: implement MIDX compaction
> >  - t/helper/test-read-midx.c: plug memory leak when selecting layer
> >  - midx-write.c: factor fanout layering from `compute_sorted_entries()`
> >  - midx-write.c: enumerate `pack_int_id` values directly
> >  - midx-write.c: extract `fill_pack_from_midx()`
> >  - midx-write.c: introduce `midx_pack_perm()` helper
> >  - midx: do not require packs to be sorted in lexicographic order
> >  - midx-write.c: introduce `struct write_midx_opts`
> >  - midx-write.c: don't use `pack_perm` when assigning `bitmap_pos`
> >  - t/t5319-multi-pack-index.sh: fix copy-and-paste error in t5319.39
> >  - git-multi-pack-index(1): align SYNOPSIS with 'git multi-pack-index -h'
> >  - git-multi-pack-index(1): remove non-existent incompatibility
> >  - builtin/multi-pack-index.c: make '--progress' a common option
> >  - midx: introduce `midx_get_checksum_hex()`
> >  - midx: rename `get_midx_checksum()` to `midx_get_checksum_hash()`
> >  - midx: mark `get_midx_checksum()` arguments as const
> >
> >  Further work on incremental repacking using MIDX/bitmap
> >
> >  Will merge to 'next'?
> >  source: <cover.1771959555.git.me@ttaylorr.com>
> 
> I think that this one is ready to go. There was a relatively small
> range-diff between v2 and v3 based on Peff's review of the earlier
> round.
> 
> That review[1] said that:
> 
>     There were a couple minor issues brought up in review, like
>     out-dated comments and the u32_add interface. So I think we might
>     need a v3 with a few touch-ups, but that's it.
> 
> , so I think with the latest round we should be OK to start merging this
> one down.

Yeah, I looked over the range-diff for v3 and didn't have anything
further to add.

-Peff

Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A18642F702
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 10:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786442496; cv=none; b=rtW9r5RFBgSd832AvGfZKdEmxwY1UGmLwmto5nAAXpLI4Y4iXLImkMOcURatS13cEGIXnZvpgCfdidrKYXYgJoGSOxdOl9GBUqJdKzuIqgC+fiDD9RCMxJMj1oJSBGJJ2T1EwFncVcmqWvvSAkiVhhdICfMn15utwdmL1D3Top4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786442496; c=relaxed/simple;
	bh=8Q8fFEIyZxiW3to0aBhso7dGrTEF9a8yqclFAFshmAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HITcew+Jy5EdxJYNyaOlvj/MZPVDCoOcF5N1w1s5Vr5aF7d1YE3kfp6QzwF3fO1xMxdCx8uWgjr+bFXR96RmDVihYU18/bBJNZnJuJRicSG3y6dz5c1Chb1VKnEhDxB/EI+0zV4ewZySv2fQrMinFElw1JtpNkH9nNkqvfJIl/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ix2dxBdq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DzUn+sOe; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ix2dxBdq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DzUn+sOe"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ACFD614000B6;
	Tue, 11 Aug 2026 06:01:30 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 11 Aug 2026 06:01:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786442490; x=1786528890; bh=4EmvGANLt8
	tuGI4TpR61Y0kC6RIEpRQeD3gmw3CjKKs=; b=ix2dxBdqTUuTT08JaXC2a6VqwS
	iUcWXsQJ3tCWRqVdQ5W/iyvewzWlpHVTNdCh+H2xL3lHzwtnOBh0TvITKdVIxJKU
	lWficCb6nr3i7y7GY2W8GZlmYRgXCaHkEogXBsNjDuLojpmc0pZyxTylS76+vO7h
	h6NGoHWoN2vCbUSz+JeX/Z+RzqnIE78jWXI65ED5N5+ppyfdnLZaM03RN10p2e/c
	YdlClkVWpIA2OYQyZDHOXiZLyGrnFaEa5lAPSvSNP1JHeZv+Qm1zLusOwS/rDflO
	YeT0jj6gSnam9lvfdMoaZsK7h/2XRpsAz+vvFp+jfTuPU11tSm8HXVZsaR8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786442490; x=1786528890; bh=4EmvGANLt8tuGI4TpR61Y0kC6RIEpRQeD3g
	mw3CjKKs=; b=DzUn+sOeunTEoP5zIxqJhUaIHaIQZFMjm0f7YbBIblwpQdc+cRR
	99+ZzEdQORLtDBfQn42x1ieWfJXsmq8yMjyMDQYHFshUW8I1KZAmCuLII2JrLfrt
	jIFpNwK+5TN14GQ+6SHUHTwj85TAipQ0phW+vmS3QF+YGUq7az8TqN7YCA4PmVst
	7zCNzRUSit2hov5bbvWygMrytuv1QQVxbeu2Rx0+KogJUOFVwPosHGW8DGyRwSwN
	HNUXr7tzOOidKAjEvS+EjsNYNxRlQ/zFalIxLW3JU4gfodLKsWABbwHay0AO/fpO
	TcR7Sy2b9tIkd4EwL+w+v+YKFXnZM7yhofw==
X-ME-Sender: <xms:-vJ6akJ0q4FeYOY9DrRQYdztJpGxKaUb3NgvQj5hQmHurGYOyZ4NwA>
    <xme:-vJ6arCyeMS8oeFmBoHbc18jCrH-UpqFHmft7NOEipqjAjJHaGfcq3RzBYfNZTFGt
    k-C_KSNl_HSJBQV-SMxjaQGwCNlxEVPWwrq_0hKrGhP_imEegXhUg>
X-ME-Received: <xmr:-vJ6atDHQBXKjwZrZMmQ0mobR-6NizN9K9McAXkZik9623bbXLErwQQJU-1lX9kLk6iNVfLF9049Y9fHvVCuyMwe1YB54orJ8_8CWcoRtg>
X-ME-Proxy-Cause: dmFkZTF+dbHj7b986zNcsh5GwpHvbMQ9JPFiFFgTS/Y49lCoAc1X9MMXK//9BUwKZ8W2TE
    /tv+B+YOsq9K1rKXL3XOtFKnEnRixaKk/vyMpzE5AN469oayBwNMlZ6UXu/X4Y75/4LPKl
    dJyMfcRNuCTm7QfuVsrA/J1FyGrh2YaC0NlNdyOj9+wR066XEEjuph6MPT6BGMH1HhZ47P
    ajtwgEnziNrGNi/ERQWo8qEBoHDTtrhQckeJkevb+sRcR4g66r/G12hCD5kGq9X6tnq7uv
    ReFkNMRH0gUCgj/wjJwguBrmJ7jH/RSWf+/HuNh/twYSLrCmQZwZQhih9tEOBu5ymNc2P4
    SeDVshXVqGtp0Cf0KHJg9nBDOQgKZ1BD0qdtFd7eRuYnVX0HtUMGIr1gojpRDzk7PeiKXk
    OLP57AHjP/naWaO8z3plBrb5u/Q0FMCFvjZof+9CiV3/MXQKm0aa3S18unFVblCEbP9ytb
    34vd34quFY8pH+mvKLZbNjKF21hfCwaH5lus150VuYquST4RBqsXZaTq5UMNiv/SSmR/Fj
    umxBZ+pIW2q+Rt8So8OxwEKHXgUVu25vOhnZKaRm33Vs+o3H7ceLwd21Z2eEusM+SHz2Rw
    xSHuTZ6VMC+3IcuE4dxVEVPrvarwWQ7KvZ7vp6yunvHzfgyrWgYOa7taXCHA
X-ME-Proxy: <xmx:-vJ6atAde1kBTCtSGmilf7Ezq4x9oZ4VDUJ5kr295BE99vzsTtqn4A>
    <xmx:-vJ6aopOCsceC4-hL72ImVR4lpygSHmdkgiGHmVEy8tJ9J4azJep4g>
    <xmx:-vJ6annGJxlbqu5WkLgeCNA50w-va00phL3r2OTgbMbNIEvHdplc5g>
    <xmx:-vJ6aox_Ba6v0ZlcJKgqhpkw9mFWSmWhGchQOL4fRAz3_rIqGG8hvg>
    <xmx:-vJ6atglFb4YFPEYTr0uqQ2HanUKJOaURKZI_d7uJK1l6J5GZRPrvxGs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 06:01:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id aa77a141 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 11 Aug 2026 10:01:27 +0000 (UTC)
Date: Tue, 11 Aug 2026 12:01:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <ttaylorr@openai.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Ted Nyman <tnyman@openai.com>
Subject: Re: [PATCH 1/2] maintenance: account for promisor pack geometry
Message-ID: <anry8wAbkxNfVgfh@pks.im>
References: <cover.1785902237.git.ttaylorr@openai.com>
 <a9de123b43efb58c53c99c71eb7e34f29e075071.1785902237.git.ttaylorr@openai.com>
 <annqJGFJPviEyfEC@pks.im>
 <ann0nnSGfSJ7y7YK@com-79390>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ann0nnSGfSJ7y7YK@com-79390>

On Mon, Aug 10, 2026 at 10:56:14AM -0500, Taylor Blau wrote:
> On Mon, Aug 10, 2026 at 05:11:32PM +0200, Patrick Steinhardt wrote:
> > > Check both progressions before choosing the repack mode. If either
> > > leaves a pack above its split, geometric repack still avoids rewriting
> > > that pack, whereas the all-into-one fallback would rewrite it. Use the
> > > fallback only when neither progression leaves a pack behind. That
> > > preserves the reason for the fallback: let the all-into-one repack
> > > handle unreachable objects when it is not rewriting more packs than the
> > > geometric repack.
> >
> > Okay. The consequence of the status quo could be that we perform an
> > all-into-one repack more frequent than really desired because the set of
> > non-promised packs is small, and thus even writing a small set of new
> > objects could cause a full repack.
> 
> Right. I stumbled on this after a few colleagues had reported that their
> geometric maintenance task didn't seem to be doing anything. When
> looking into it, I found that they had many promisor packs, but the
> non-promisor packs were already in a geometric progression, and thus we
> did an all-into-one repack.
> 
> > This might create the reverse situation though, where we don't perform
> > the all-into-one repack at all anymore. We could come up with a clever
> > solution here, like for example considering both sequences together and
> > repacking when we cross a certain combined threshold. But I'm not sure
> > it's worth it for now, and we can still evolve the strategy as needed.
> 
> The change in this patch means that we will perform a geometric repack
> when doing so would result in a new geometrically-repacked series of
> promisor packs, in addition to non-promisor ones.
> 
> Is your concern that the non-promisor packs might be in a state where we
> should compact them into a single pack, but that the sequence of
> promisor packs would prevent us from doing so? In that case, we will
> perform a geometric repack on both sets of packs independently. If the
> non-promisor packs should be rolled up into a single pack (i.e.,
> "geometry.split == geometry.pack_nr"), then the geometric repack *will*
> produce a single pack, as if we had performed an all-into-one repack on
> the set of non-promisor packs.
> 
> So I am not sure that I understand your concern here, but please let me
> know if I am missing some aspect of it.

The concern is that it's quite unlikely that both the geometric and
non-geometric sequence will merge all packs together at the same point
in time. Consequently, we'll never hit the case where we perform an
all-into-one pack to prune unreachable objects, and that may cause us to
never prune objects at all.

So what I'm wondering is whether we should be a bit more clever about
that and perform an all-into-one repack under a new condition, like for
example when the objects we're about to repack exceed a certain
percentage of the repository size.

Hope that clarifies it a bit :)

Thanks!

Patrick

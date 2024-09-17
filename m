Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759CE165F19
	for <git@vger.kernel.org>; Tue, 17 Sep 2024 09:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726565950; cv=none; b=aL6D8TygAVFtQy1lDfGIsXNMIg1Irutld8udIYN5gPUG0Eoqrm3oi7d5tLG9N8mYoOyIxhpOHt7ESTHsFfvBjS/Y+iku9y016a1wnuwSyKwPh7gWUM7YNCsFqYqHidnLHvjTvZVjQFCYIRyYZenAep9tLEA4XsLRvaX81IbH/4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726565950; c=relaxed/simple;
	bh=Y4dUBQdwQ6sHKNmI1rfp9BKDiIDR5fVPIFdY19drnnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R9fdMntu0yiroSNAEow2b8xYLdUrUa+4WiOH3jmGfF0t1qnM/hjFcjYelUNV/9s9NtpZb1rV3C9vlI9s3U0gs2ytPJAzsatpFlEvw1WkEvq53eY9ZVu7dS8lQkbTtZ0Up1lgfTAdWn0oPKKzBRof/jMiCvNfD9j5ztCCivZLplU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pcIBShPR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WfNhV9Bz; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pcIBShPR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WfNhV9Bz"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 94D191380497;
	Tue, 17 Sep 2024 05:39:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 17 Sep 2024 05:39:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726565947; x=1726652347; bh=D3vtE278st
	xIrTaM2vgQ+CgvshObW/ysm/BbVrpAj6A=; b=pcIBShPR/90M35uikLOHvXZKy+
	VOoh7J5owF4qrACym+jFyLISpEOX98SG/X5SlzOm1umsThzP7nsTveqtN27UGA7f
	LPASO2ZI0QNcNiMMx8LtedAnQC/9tXzze/5JRxxpn/QNh1HXBhnWEE0oU7p4LgXz
	ir7h7YDRotOlDq2qAtAsdOFG67CV1gujOA1OKgIdFNEuo3xislf25qmFVvvr2p5Z
	OejvBZ9vscArEPQyG+V4AQLLVWI4vqYaOY5ZmoTf1PSGlxIynZ4jviRi+M+xKq+N
	LcwK0pHu5CLln/v3R0fKs84J2P8Dckc45Cf6yuz9ve0Gh+1mvb6l+gvcys2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726565947; x=1726652347; bh=D3vtE278stxIrTaM2vgQ+CgvshOb
	W/ysm/BbVrpAj6A=; b=WfNhV9BzxOz5i2BNfAw4wxYOBkXRbhs19pjLPg4ilq10
	R/czDD+U0H/nLA9PYRQ5+Dkji14uLvceuEI00CybkU5ymAX9A9D/2XAz7xSgsuD2
	E9opgzb+JO9TLQylcBx/SaIpcSovKR8GVXJsm6G8vYQR6XmddjsvmJE9xuPqcWpv
	IyI4Am8UbO62eFI4F1BoY0bGUPuHO6rwE+dKWVIDCby7CWi23L7ND9pf956dAq/g
	/tt/DqaVsjnEVXskEtmljnyI4uG0EMOrxp8o24+aV3xrJgzqE75RbkhO6/NbbYoJ
	oEQ2iZzJ08WC9maZhYtvgzzCpqRF38cCsZj2USgSVQ==
X-ME-Sender: <xms:O07pZmOBKJ5ZUWR8FZIOoGTMFPWXAIRN0RxqfmNiZpA6Po5qtmuEaQ>
    <xme:O07pZk8luCTzybYz9IgepEljPkhYy_0S5yAgyHnTQDxIRtPCywIHF_o7G-GVsbwKf
    m4evNMbfUo7AAgQHQ>
X-ME-Received: <xmr:O07pZtQ0IfLNaQTqjthpH_wqFkbJxlaOTlhzzgtSGyYqZlVk_-dbgcKXt3_BvTnvMBb2xY2VAmH-XHidFsltbYL78zFgD_ibxFjTUWoIWxmX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekjedgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhi
    khdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:O07pZmti7b1mp-8gxU2A30APp1wY9w214RIYVji9Rbz1CA9m-A1bcA>
    <xmx:O07pZufNZuVqAdvLElIg62NAlbmJtQh7OAkXW-EAD7U6IXpAkzs6Hg>
    <xmx:O07pZq3Rna3gq1imReCe_WuFpxCPUbO1JabuFIhuNf_mnaLwKxwGLQ>
    <xmx:O07pZi9GrXr0FpIg_kBf9GDkq4cmlU5WvPNuTGMEdw1pZHiEoeiMtA>
    <xmx:O07pZu7fOw28bFoRqi8ZuR9Vvw4Kn_qLWf4GfgQ-_-jfelofA29IAVjD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Sep 2024 05:39:06 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 292409b9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 17 Sep 2024 09:38:46 +0000 (UTC)
Date: Tue, 17 Sep 2024 11:39:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 6/6] refs/reftable: wire up support for exclude
 patterns
Message-ID: <ZulOLLdh1_jrYcN2@pks.im>
References: <cover.1725881266.git.ps@pks.im>
 <cover.1726476401.git.ps@pks.im>
 <050f4906393d1f9c58a6b6bc695b004695d219be.1726476401.git.ps@pks.im>
 <ZulLWJWLgU7gL1MK@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZulLWJWLgU7gL1MK@nand.local>

On Tue, Sep 17, 2024 at 05:26:48AM -0400, Taylor Blau wrote:
> On Mon, Sep 16, 2024 at 10:50:16AM +0200, Patrick Steinhardt wrote:
> > +		/*
> > +		 * When the reference name is lexicographically bigger than the
> > +		 * current exclude pattern we know that it won't ever match any
> > +		 * of the following references, either. We thus advance to the
> > +		 * next pattern and re-check whether it matches.
> > +		 *
> > +		 * Otherwise, if it's smaller, then we do not have a match and
> > +		 * thus want to show the current reference.
> > +		 */
> > +		cmp = strncmp(iter->ref.refname, pattern,
> > +			      iter->exclude_patterns_strlen);
> > +		if (cmp > 0) {
> > +			iter->exclude_patterns_index++;
> > +			iter->exclude_patterns_strlen = 0;
> > +			continue;
> > +		}
> > +		if (cmp < 0)
> > +			return 0;
> 
> Perhaps I am showing my ignorance for the reftable backend, but is it OK
> to call strncmp() against all patterns here?
> 
> In the packed-refs implementation which I worked on with Peff sometime
> last year, we rejected exclude patterns that contain special glob
> characters in them for exactly this reason.
> 
> The implementation that I'm referring to has a helpful comment that
> jogged my memory for what we were thinking at the time (see the
> function refs/packed-backend.c::populate_excluded_jump_list()).
> 
> Ugh, I just read the next hunk below, so ignore me here ;-).

;)

I was also wondering whether we'd want to amend the generic parts of the
refs interface to filter out globs. But it is entirely feasible that a
backend can indeed filter out globs efficiently, even though none of the
current ones can. So it kind of makes sense to keep things as-is and let
the backends themselves decide what they can use.

> > +static char **filter_exclude_patterns(const char **exclude_patterns)
> > +{
> > +	size_t filtered_size = 0, filtered_alloc = 0;
> > +	char **filtered = NULL;
> > +
> > +	if (!exclude_patterns)
> > +		return NULL;
> > +
> > +	for (size_t i = 0; ; i++) {
> > +		const char *exclude_pattern = exclude_patterns[i];
> > +		int has_glob = 0;
> > +
> > +		if (!exclude_pattern)
> > +			break;
> > +
> > +		for (const char *p = exclude_pattern; *p; p++) {
> > +			has_glob = is_glob_special(*p);
> > +			if (has_glob)
> > +				break;
> > +		}
> > +		if (has_glob)
> > +			continue;
> > +
> > +		ALLOC_GROW(filtered, filtered_size + 1, filtered_alloc);
> > +		filtered[filtered_size++] = xstrdup(exclude_pattern);
> > +	}
> > +
> > +	if (filtered_size) {
> > +		QSORT(filtered, filtered_size, qsort_strcmp);
> > +		ALLOC_GROW(filtered, filtered_size + 1, filtered_alloc);
> > +		filtered[filtered_size++] = NULL;
> > +	}
> > +
> > +	return filtered;
> > +}
> 
> Ohhh, here's where we filter out un-excludeable patterns. Ignore me :-).
> 
> One question I had reading this is why we don't filter these out on the
> fly in the iterator itself instead of allocating a separate array that
> we have to xstrdup() into and free later on.
> 
> We may be at the point of diminishing returns here, but I wonder if
> allocating this thing is more expensive than a few redundant strcmp()s
> and calls to is_glob_special(). I dunno.

I think duplicating the array is the right thing to do anyway to not get
weird lifetime issues with the exclude patterns. A caller may set up a
ref iterator that they may end up using for longer than they keep alive
the exlude patterns passed to the iterator. So by duplicating the array
we might end up wasting a bit of memory, but we avoid such lifetime
problems completely, which I think is a win to make the infrastructure
less fragile.

Thanks for your review!

Patrick

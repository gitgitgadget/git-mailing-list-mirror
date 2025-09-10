Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3333126C5
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 11:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757504292; cv=none; b=erWja/XwngrVrBI1haMIvFM5iYStSdvs+86HSWv8edjmzrm1xh6w0U79dcOgVIKdFf1xkKjILRbfvblrM0PfZ1q2y1nvIq07A/Pmzj2JlVBlI0cZNlL7gbYQlzq7Ema81RXwbQlSQPtg4E0fC2/izI+aQUNkWSZbUkmn9pCUhLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757504292; c=relaxed/simple;
	bh=UxsyuxGnzcT77xURk2mXfmldGZfEO7Na2pMYNjpxhfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tIHum5TFBrI8x4bYcxH+43p/DJ9VTJ4Ip++eMSL8AbUtpRL5Wk2MEgLSkXIVaT0WagjzoP9AH6Q4WEXX9wOHMXzJj9VfEVk06jB9oE1P734FeW09Dq6vNtRzUos5jx90/dKHNba59e5UWTq8XNy/ji8z5O1VYaUVCnBhLGEBlt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KtbGAZHO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lUAV6zXa; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KtbGAZHO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lUAV6zXa"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 5BCE41D00255;
	Wed, 10 Sep 2025 07:38:08 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 10 Sep 2025 07:38:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1757504288; x=1757590688; bh=ys2ODf5cr8
	mInY0YfOl8hxGcinrY79JTdtxU8LjZCAI=; b=KtbGAZHOTK77ByUG2i7pX0+v5B
	VxLDSdbu8v+H8L3q6FMTLKKLEntZTFOqPPdihF1GJZQ6DOIe1XwZy69oe0fdRV1X
	u5oQeEIHj3P9pG8Y6+bwltWcQaomjhEVR6y8nX+9Hab1dSIGG4I0GFzceeAfbAhs
	dkbvcdRwZZ6+ctuowKf4fTrMmv8Ug+ooo9toQniEOIzbldfxCYM7fynoGVBbwDDF
	qSnL+yiZ3iJ3PmOCYxlkvnOTCXIqkqXao5B7K1tQwDgNRe7jXXHX5uCMxbR04Tln
	bwsFkC2xNA4IA4tny6dDFF1EF78kyxO5drqoPqowerN5i0keOd0nOB7zfI9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757504288; x=1757590688; bh=ys2ODf5cr8mInY0YfOl8hxGcinrY79JTdtx
	U8LjZCAI=; b=lUAV6zXaxQxTLyu3nUFFX4uv23MxESQ4F3w+CgeJmWSdLponQki
	x9JEVVSNAUx2PusVE86grNSXbGVMt0UuXxmV6ofx7mn1adXONYhqAjieKrdl8m8D
	Flqy3p/UzOQYy1+eqb4d10NxCcDoCRCbUAP5Y+/N1VVmuAUnGQMJIW31yl4+EBFY
	81WOSWKpc4ScVLKd2WlTUG6UgzxlMiABcbTwpgnAEyBv7dwdDEJlDX2lJcN4dde1
	36zLGxNRYdSSiK0MmSQuNdBHAFSGhG56fivrTBPLFfEuyGLPGW0cKIq7ZRDN2wTO
	TJL1O6L068wEYHoUY0bRFGpsvnYWqTOKp5Q==
X-ME-Sender: <xms:H2PBaIGXM1ZzweOTRG6cXbARl5RC55W1uAQDt6Iuuf_1AFlr5xonzA>
    <xme:H2PBaElwf8vz9RsJnLnEjUGO3t1cidMED5SOlSCvYhpzaQ8V3BOj8A6ZO2Uo8bSI1
    bGSQ2Fyt5KRsUTZJA>
X-ME-Received: <xmr:H2PBaLnoOt6XLCI1Kt-suKpNdAWVO1I3S8DvA-yCsKalofcCrJqec2Nod_50AK0NUcFXqXzWlg6ZnRI-oINNXrvConOkutW4ZZtGmFmZMcA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfedulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ejtddtgeffkedujeejgeduhefghedtgfdtieduleeulefgueetheeludegueeuveenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:H2PBaFvIGO-n-Y_FLEkuP3vGtqqq2MU7FVChdL6jsWDpSIThWA_oZA>
    <xmx:H2PBaOmRBLpReu2NBuNXW7kfaSJq_HewATI4e_uGm-n8ohzP3bmkPA>
    <xmx:H2PBaAuAqE12hQy9G4dZKeSSWRRZ8y34UBsqkobTSRgtMRK6nkqGew>
    <xmx:H2PBaEcnG2tGBLHHdAfyCmovwpPz9tA07dhwvQGOK4fxPU6qPEl5ew>
    <xmx:IGPBaBO63tsVGLs53wAePmjghPzW4vm0e2p_vEdHtbc-hCXVvwMs8zk_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Sep 2025 07:38:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9f49cf33 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 10 Sep 2025 11:38:05 +0000 (UTC)
Date: Wed, 10 Sep 2025 13:38:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee <stolee@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/6] odb: track commit graphs via object source
Message-ID: <aMFjGoPhGsRCTihO@pks.im>
References: <20250904-b4-pks-commit-graph-via-source-v1-0-d932c2481e1a@pks.im>
 <xmqq5xdx7qx4.fsf@gitster.g>
 <cf7aeda1-297a-4805-b0ae-e379ce11bbcf@gmail.com>
 <aL67U0-tw7O-y6_X@pks.im>
 <4e67fb02-bbbb-4cd8-9892-6f65b4f82b26@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e67fb02-bbbb-4cd8-9892-6f65b4f82b26@gmail.com>

On Mon, Sep 08, 2025 at 10:46:40AM -0400, Derrick Stolee wrote:
> On 9/8/2025 7:17 AM, Patrick Steinhardt wrote:
> > I (probably unsurprisingly :)) don't quite agree with this.
> 
> I think I can summarize the main point you seem to be making with
> this quote:
> 
> > So I would claim that the commit graph is specifically tied to the
> > actual storage format of objects, and it's not at all obvious that it
> > would need to exist if we had a different storage format.
> 
> I think I agree in principle, if you are saying "different storage
> format" means "different commit object information" which then means
> we are talking about a completely different object type that is not
> at all compatible with current Git.

I don't plan to introduce a new type as in commit, blob or tag, but
really only the possibility to have a different format for how exactly
the objects are stored. So it's not really "different commit object
information" that I want to store. It's rather "additional commit object
information" that we currently have to store out-of-band, which includes
items like generation numbers or bloom filters.

As an example, if the object format stores data in the cloud it would be
sensible to also store generation numbers there, as it would ensure that
we don't have to recompute them on every client. In other words, the
data that is currently stored locally in the commit-graph also becomes
fully distributed.

> You could store commit and object data in SQLite, in the cloud, or
> via plaintext files on disk. As long as the data is still representing
> commit objects as we format them today, the commit-graph is still a
> cache that can be used as a faster way to fill 'struct commit' objects
> in memory without navigating to that object database.
> 
> And you also mention that the commit-graph format itself could be
> more efficient. You're right! I think the way we did it within Azure
> DevOps is more efficient, because most of the commit walking algorithms
> are built working directly on the integer labels within the in-memory
> data structure instead of operating on commit structs. This allows for
> less overhead when loading the graph (it's already cached in memory)
> and when walking thousands of commits (we only translate to object IDs
> if they are important for the output). But this is all the more reason
> to keep the commit-graph structures outside of "the object store" since
> a "commit-graph database" can be implemented without being tied to an
> object store.
> 
> If you are saying "but our existing commit-graph format puts it in
> 'objects/info/commit-graph[s]'" then yes the storage of a commit-graph
> is tied to our storage of objects. But the way we interact with it in
> code is in some way a layer above that.

There is no inherent reason why a new backend would not be able to use
the existing commit-graph infrastructure indeed. But there are reasons
that specific backends may not want to do so. If objects are already
stored in a database table, then it may make way more sense to store
additional metadata that is currently stored in the commit-graph in a
secondary database table instead of in the commit graph.

So that raises the question who is going to decide what caching format
to use. That is, given a repository, do we want to use a commit-graph or
do we rather want to store that data in the database?

I think the most sensible way to decide this is by going via the backend
of a specific object source. The backend knows how objects are stored,
so it'll also know whether there is a better way to store metadata than
via commit graphs. If it is the "files" backend it will decide to
consult the commit-graph. If it is a SQlite backend it _may_ make sense
to use a commit-graph, as well. But if it's a remote database for
example it may make more sense to store the information in that database
directly.

By moving this logic into the object source we can tie this decision to
the object source and also abstract it away. In the pluggable object
database world we can make this data available via a couple of function
pointers that are per object source:

  - A function to check whether a cached representation of the graph
    exists in a specific source.

  - A function to load bloom filters and generation numbers,
    respectively via that source.

  - A function to load a commit via the cached representation of its
    source.

Thus, the details around the actual data format will be hidden away and
most of the code never has to care whether it's a commit graph that
contains the data or whether it's stored in a distributed database.

Now it's not impossible to make this work in your proposed world where
the commit graph continues to sit at the database level. But we'd still
have to abstract away logic so that we can have different ways to store
cached data. We could for example implement logic to ask every backend
whether it has a cached representation of the commit graph, and if so,
to provide an opaque data structure that contains the above function
pointers. We could then continue to store that structure on the database
level and use it whenever available. But I'm not sure whether that
design is in any way more obvious -- quite on the contrary, I expect
that it may be more complex.

This is roughly what I have in my head right now. And I realize that
this information really should be sitting in a design document. I'm
working on that, but still need to land two more patch series before I
want to send such a patch series to the list.

Thanks for the discussion by the way, really appreciate it!

Patrick

Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B5733CE92
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 08:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761814767; cv=none; b=l1zYxlGNaQ/2IxYqSmj0njv6jTNTTEmaLUsjWqguD909kHyiRPAwVrrU0vCTh5LSuHCNnQDPeUZILwQl2L4ix5/tvEKHrQT5RBsujO7aEDA1hZuNnclsKxrw4MzIqGsi3pnNGzKUQe5XwAPv0FOGsGTp+BpSrH05nyfAgVWx/18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761814767; c=relaxed/simple;
	bh=MPN8/giG7httpA1suWj7JuAJHvnrTXF6R8atekDsc+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cVwGaw+ErwPF4TuV4FkRCAD5Vw6FKpvAnnBo1NwBTkqWqVIcVQlSsVX1laLadOeSrFle5hMSrCyLOyZALikqJxfUagGPhdsR6vkkqlY5HGWNiyM2YD5WwjVQTz+pxGQE7MCuM09dNR+5fFde/WpIHhiKeiKKVlRpkDL8pcINPdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aGXqrEjS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J2GqhK64; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aGXqrEjS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J2GqhK64"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C2608140018F;
	Thu, 30 Oct 2025 04:59:24 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 30 Oct 2025 04:59:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1761814764; x=1761901164; bh=+d2+9OEpzt
	T76TI8kXKLkPpPIA+EzxzVLPD7xE8CnkI=; b=aGXqrEjShzHjsrHDHjfchcIwe0
	24ekmgh2FpcARhD982Z2yzoFmwuZL5Y7Hf2dVDq6fIiMEAmWa8bX8UlBjiiUWCGL
	J8nB6d/NOOIm5wE8BavAeFk0CPHz7PlpXr4d/orMQoDOD5NkOXq4TV1wq1t5MTwV
	C+GgDO66jgBRexBQHwC1peaejsCCdBF8VkR8NP5Z7y8YMGEW1KeoRUUjFB4HYkAd
	zp9uHgrYZhRvzy54nU1X6KNPhA1McF0YOC4K5xvgz3v1AS5jljmEJtB5bICrSduN
	aGKsMraQz8noz81RWW8Pg4cuh/qdSkn9taZEgzi0HCuOfWHRt9M5xcl7o9Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761814764; x=1761901164; bh=+d2+9OEpztT76TI8kXKLkPpPIA+EzxzVLPD
	7xE8CnkI=; b=J2GqhK64/Rf4U+udq6VThQkK1TmrJB8cVjGhy3WnP2yyIPWP8Yg
	xDBi97IT9o8YSU5WTdXk5JJQuih4MGSiV+EYr/M6eGcRe7/N7yGULaY0rWCakm7g
	3nDUuK8lh3S8rFcPLzpt+6qZiEQ/iU3M1/5nT1GDwtBdyAsYTjC9vlu0XJvcCs0c
	65LoVeOozdJfH6x1wqWYtq3+DFuPpz7ZnKYHUHmwa3L0LPcZMmFA2yalU6yNDdsO
	dsUTdCB9MwNcPM5RfPktUowv88oA1ls6Oz/rqiS+POtBEN0d8Pp37P06EVbN7BgC
	PlN+Q68rc/ntApsrl7O4F8pcA6XRyDl7bCg==
X-ME-Sender: <xms:7CgDaexCvYrbpK9VtPobEQmRS1TTtOGS0909WrukEulSiGuFYjp6-w>
    <xme:7CgDaRt-Fyi3XF-MJlMVdcQmwdBEKennegaWxt6FpqmeAbtLYy5n-OR5MjSfl-nwU
    D-aFKBHfBGtWGRLA6s32hu0LS1psXOn1K_MnZtsnFbKxcSegTDJrVs>
X-ME-Received: <xmr:7CgDadv7rgy29CSbQ8LNwVe-w4FQAm0iOZlzg-qJCrHTiC9Tjc4hXiN34LEVjQK0hcRCDRShOmbTYCGAQD_gcx90wBeBarCtoNLyVmXFmA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieeiudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghp
    thhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:7CgDaeOBdp2ZLUllEDqvndA9L1gy2hpDmRYWteOg4dhckrIjMA72MQ>
    <xmx:7CgDaT27zIXT3UcCAd9V9p4MJzHC0c7KavkkumJkyOFUGQ0BmHeADg>
    <xmx:7CgDaSMIMnXLZD9BZ6IiKmNvev_N84bLxGFJokIFzRwTtLjiwXd-QA>
    <xmx:7CgDab3ysyHCQ_yEJfDo3xJIHKuuW_2UGSZvzRZnF-08BEepuZ5BVg>
    <xmx:7CgDaRKAUGJGzdfbvTzUOKHCYZcpEi2rvdXKXDsVjNjzDI36DUiTRhD0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 04:59:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id be46b360 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 30 Oct 2025 08:59:23 +0000 (UTC)
Date: Thu, 30 Oct 2025 09:59:20 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/8] packfile: move the MRU list into the packfile store
Message-ID: <aQMo6DxZqYc6gEjQ@pks.im>
References: <20251028-pks-packfiles-store-drop-list-v1-0-1a3b82030a7a@pks.im>
 <20251028-pks-packfiles-store-drop-list-v1-2-1a3b82030a7a@pks.im>
 <aQKXpM8g3Oy3DVAa@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQKXpM8g3Oy3DVAa@nand.local>

On Wed, Oct 29, 2025 at 06:39:32PM -0400, Taylor Blau wrote:
> On Tue, Oct 28, 2025 at 12:08:32PM +0100, Patrick Steinhardt wrote:
> > Packfiles have two lists associated to them:
> >
> >   - A list that keeps track of packfiles in the order that they were
> >     added to a packfile store.
> >
> >   - A list that keeps track of packfiles in most-recently-used order so
> >     that packfiles that are more likely to contain a specific object are
> >     ordered towards the front.
> >
> > Both of these lists are hosted by `struct packed_git` itself, So to
> > identify all packfiles in a repository you simply need to grab the first
> > packfile and then iterate the `->next` pointers or the MRU list. This
> > pattern has the problem that all packfiles are part of the same list,
> > regardless of whether or not they belong to the same object source.
> >
> > With the upcoming pluggable object database effort this needs to change:
> > packfiles should be contained by a single object source, and reading an
> > object from any such packfile should use that source to look up the
> > object. Consequently, we need to break up the global lists of packfiles
> 
> s/lists/list/

It's actually two: the MRU-ordered and the mtime-ordered one.

> > into per-object-source lists.
> 
> How does this work for alternates? My understanding is that each
> alternate now has its own object source. So to perform an object lookup
> in a repository with alternate(s), I am assuming that at some layer we
> need to iterate over those sources to then enumerate the packs in that
> source looking for some object.
> 
> I would have imagined that packfile.c::find_pack_entry() would have to
> be adjusted in a similar way as above, but I couldn't find the changes
> in this series, so I feel like I must be missing something in my
> understanding of how this all works together :-).
> 
> Are packs from different sources still connected somehow such that
> iterating over the list of packs from one source will enumerate the list
> of packs from all sources?

This whole mechanism isn't yet part of this series :) So right now we
don't really change anything yet, and the list of packfiles is still a
global list across all alternates. This series is thus basically only
paving the path towards having per-alternate packfile stores.

Moving the packfile store into the sources is going to be part of the
next series.

> > A first step towards this goal is to move those lists ouf of `struct
> 
> s/ouf/out/
> 
> > packed_git` and into the packfile store. While the packfile store is
> > currently sitting on the `struct object_database` level, the intent is
> > to push it down one level into the `struct odb_source` in a subsequent
> > patch series.
> 
> Before sending, I was confused by "Consequently, we need to break up the
> global lists of packfiles [...]", since it wasn't clear whether or not
> this series realizes that goal, or pushes us in the direction towards
> it.
> 
> But this clarifies things, and I think is the reason that we do not see
> more invasive changes like needing to enumerate the MRU cache of each
> store in order to find an object like I mentioned above.

Yup, exactly.

> > Introduce a new `struct packfile_list` that is used to manage lists of
> > packfiles and use it to store the list of most-recently-used packfiles
> > in `struct packfile_store`. For now, the new list type is only used in a
> > single spot, but we'll expand its usage in subsequent patches.
> 
> I am a little curious why we need a new list type and implementation
> here. Is it to avoid exposing the list as part of struct packed_git like
> we are forced to do with list_head?
> 
> I could imagine that you might want to avoid exposing the "struct
> list_head mru" part of packed_git to avoid the suggestion that all
> packfiles (including those from different sources) are part of the same
> list. But if that's the case, I wonder if we couldn't have kept the same
> mru list and clarified via comment that it is per-store, not global.
> 
> I suppose that is a bit of a foot-gun, and perhaps that is what you are
> trying to do here, but after reading the patch message a few times I
> wasn't clear on what the motivation for the new type was.

Yes, this is one of the reasons, it very much feels like a foot-gun to
me. I found it significantly harder to work with the list embedded into
the packfiles themselves, and it made it significantly harder to check
whether the split really is done correctly. So by moving the list into
the packfile store it now becomes obvious in our code's layout, and it
becomes much easier to build an implicitly-correct mental model.

The second reason though is that packfiles aren't only used in the
context of our ODB, but also by other layers like our transport. I want
to have a clean split so that a packfile is a completely separate entity
that can exist without an object store. But if the list pointers used by
the store are embedded into the packfile itself, then that boundary gets
a lot more fuzzy.

So it's basically separation of concerns: `struct packed_git` should
only ever be concerned about a singular packfile. And the packfile store
is then concerned with managing a set of packfiles.

Thanks!

Patrick

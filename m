Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBFD1A4E66
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 05:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725340710; cv=none; b=DR2RRlKZt3qAEEmyscyI+GA5c9oQz4Ir3TGg1qSO397i+Hhu6nYY11BxLEXLl8RY7XH3XhDYbR60Fn0aTLpenESpLWpvgdE/GAYLdGeT64Jx8NrpSWI628gfT2Z7Nm1B7tjKGc5ANKDrVdoQkLG/D7Ubj/XYu5EnAEqteQT1K1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725340710; c=relaxed/simple;
	bh=IFcXg75xApfOLaHZNvrzsgwHpgdoSDOZLeaqw4djQhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nDCkHSJ0N8lXUwAxFLUFc1RwiPb2rJ+1V38Qr1j+h86jnd2CtqKDkMwC+IVlc+cs9Oy2ArPlDq25n39bLyq2HKTmUXIg1wh1iRu1zvgmsZgq6jNx9EnARJAq3Mtornm7pDf0Jq6XZ9lHH5RxnD9rc/KiGhlapnGtgRn2LQu9ofs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WxA6QXcd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R7/CMquD; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WxA6QXcd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R7/CMquD"
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 377B61140277;
	Tue,  3 Sep 2024 01:18:27 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 03 Sep 2024 01:18:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725340707; x=1725427107; bh=F54wOhwHi8
	msYzvheFVB+NPXyMw5gzsdaYMplXRS5ME=; b=WxA6QXcdwXUz5ZvVl8cLsGHx7v
	I1W0YbefXRWKqdQVgyaWr9q+HzmNZhPtFRWe+oL53noGmEBYJHOv5d4TYTnvVY2L
	iTgkz0hMuR789nSVKBo4G8KD/8Y+7FXGj8M5FJN6DbKNzLhgVpBiwL+tJBl2XqaF
	zBYAZ4M5hNFgQpFOCug7cr6GTDg+OzPr9FhHKxbZoabngXTqPCGSdfxeCKMg47en
	hn1ubPYGVk6EJNjQ3EWphd6/IzNNd7Cp3RA3SiozUfGy7o6eeVm3tTXuhqJXF4mr
	45CUoKUsLZeknCy6g1auDH1xDx2Ssst/k3Q7m1NfHmvaAcLhZHxGvecnTFww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725340707; x=1725427107; bh=F54wOhwHi8msYzvheFVB+NPXyMw5
	gzsdaYMplXRS5ME=; b=R7/CMquDIodl6lMeEsu8826H5wMyODINwSTqe9ztLdEQ
	PfoVj59pBnOENPe1daZ8aoRSgstxEonQTRJ1/ZBVUTe92aAVhmaoR6hFLegln1qP
	XIE+/pWUISPFvbgjdx9RgP/v0nzVBreVdQG2McbTGCN+/Ef2ytaQTmjntuOESJra
	KCjO6dou3B3jt5Jv85FF6HT247Pn3qDQqq8EkXPsp27U/O8YvCEO37HRpaADUaE/
	rTPASFgKdtQk6qxH+IFDxs/wLoNjgEGPvBuAXbyRxzgqsvE0jr2tjnwjxPikE5NH
	K+2lzwf218yUO5RX8SxUqva0oO6kvthHGdoDNe7Y+g==
X-ME-Sender: <xms:IpzWZvRQfgMmXTuFQ3_H-lOna2re_xXHTwWJjn0fh2aifUO2XiRc5A>
    <xme:IpzWZgzMaXqrnzoUv1m_ZUnqeeVx68uHlDjfFbpJZUbz27lIhKJwopBpPSTA7DQW5
    OdJcTl2X3ylps87rA>
X-ME-Received: <xmr:IpzWZk0Bz6bUKaIdBAEp7gyRUXnBw43-uGzsfIXrSE_nD7WpmAXD6F5Q7G1T5EwFCKTMzee_50DTLuUY7Hp5E3RP_o2TdbXLInoJqOIO0it_4Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehgedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevgffffedtje
    duffejvdefjeejffehfefhieeihfefgeeugffhvddvhffgudfgteenucffohhmrghinhep
    vgigrghmphhlvgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehshhhusghhrghmshhiiiiilhgvshesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:IpzWZvAnLj9T6u_YHQZ1G_4Zi7MaQ3ZWzCIFO9FeHtd5cN8oO8AJkg>
    <xmx:IpzWZohlDIzcDcOANO20KqEfeGLZ4-1d9qHp3ZfUeTFrVRQK33J4gg>
    <xmx:IpzWZjoHxs6D48Xs4H7oyXpeT3ZW0EOFL4Lgc43XL8za00oWwuIolA>
    <xmx:IpzWZjjB5Fz4YsvsB6QQdCN4ARy97TNDOsKHLa94FaL2XKZDVb2tcw>
    <xmx:I5zWZhtaDp2Tq0-CnLFGRtDJqIQf_MzvwZbF5FgmgSxW_c4ULD3yTdGI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Sep 2024 01:18:25 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 46120e48 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Sep 2024 05:18:17 +0000 (UTC)
Date: Tue, 3 Sep 2024 07:18:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Shubham Kanodia <shubhamsizzles@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Improvement: `git-maintenance` to allow configuring of remotes
 to fetch
Message-ID: <ZtacHCuql0pX3V2u@tanuki>
References: <CAG=Um+1wTbXn_RN+LOCrpZpSNR_QF582PszxNyhz5anVHtBp+w@mail.gmail.com>
 <Zs8KzG0vzCEDvkvx@tanuki>
 <xmqq4j7438yc.fsf@gitster.g>
 <CAG=Um+2OQofcfo3vjvPJEAUht5cGg0LnPAx54SWUPETgkRACPQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG=Um+2OQofcfo3vjvPJEAUht5cGg0LnPAx54SWUPETgkRACPQ@mail.gmail.com>

On Mon, Sep 02, 2024 at 09:16:24PM +0530, Shubham Kanodia wrote:
> > Patrick Steinhardt <ps@pks.im> writes:
> >
> > > I'm not aware of any discussion around this...
> >
> > I do not think so, either.
> >
> > I agree that it makes as much sense to limit prefetches to a subset
> > of remotes as it makes sense to limit to certain hierarchies (e.g.
> > excluding refs/changes/ or even limiting to refs/heads/seen and
> > nothing else).
> 
> I'm seeking advice on the configuration option structure for this
> feature. The typical config format for maintenance tasks seems to be
> as follows:
> 
> `maintenance.<task-name>.<option>`
> 
> A natural extension of this for the prefetch task could be:
> 
> ```
> git config maintenance.prefetch.<remote-name>.refs refs/heads/master
> ```
> 
> In this structure, the 'refs' value represents only the source part of
> a refspec, and both remote and refs can be configured.
> Specifying a full refspec isn't necessary since the --prefetch option
> may override the destination anyway.
> 
> While I've successfully implemented this approach, I'm open to
> suggestions for alternative configuration options. My concerns are:
> 
> 1. Most Git configurations are nested up to three levels deep, whereas
> this proposal introduces a fourth level.
> 2. This configuration appears in the config file as:
> 
> ```
> [maintenance "prefetch.origin"]
>        refs = refs/heads/master
> ```
> which might look odd?

Agreed, it does. To me, the most natural way to configure this would be
as part of the remotes themselves:

```
[remote "origin"]
    url = https://example.com/repo.git
    fetch = +refs/heads/*:refs/remotes/origin/*
    # Whether or not the prefetch task shall fatch this repository.
    # Defaults to `true`.
    prefetch = true
    # An arbitrary number of refspecs used by the prefetch task.
    # Overrides the fetch refspec if given, otherwise we fall back to
    # using the fetch refspec.
    prefetchRefspec = +refs/heads/main:refs/remotes/origin/main
```

The prefetch refspec would be rewritten by git-maintenance(1) such that
the destination part (the right-hand side of the refspec) is prefixed
with `refs/prefetch/`, same as the fetch refspec would be changed in
this way.

An alternative would be to _not_ rewrite the prefetch refspec at all and
thus allow the user to prefetch into arbitrary hierarchies. But I'm a
bit worried that this might cause users to misconfigure prefetches by
accident, causing it to overwrite their usual set of refs.

> Also, hopefully my mail is formatted better this time!

It is, thanks!

Patrick

Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E511FB4
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 05:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727156946; cv=none; b=WHQwYZq07OeTHEwAJ0QfrDhIasvq2d1Lv/DkIeI6TeNC/FtC0ScHFs3kMfa9+xw7MrXjVq/v64OOJa0DLY0qRPc1CCFIPO5/YdLT8zNaEvt+DBymtESAdHrKFoF2FmlSTFRnsyMBQxiXHlicCsFv8/oBxdI3luNeI7olmjz6GTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727156946; c=relaxed/simple;
	bh=zCuq4eBABgtYCNtlYv+07Wd4WwHyxpscsdU2NSUNX3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dltVkDD/hS2CWxVLkbwRRBVINE5JNILJokf/NxvdTk6g27AMAtSRGOTZmAH49FAmPb0Cv+g6Zsp3ciGei0+R9lJdEC9y242XwK5oOnYc4+B6Nb9Sb+2o+LqoZ3h0v5LjnwMtqaMAZhSFDGOsivIAOsWDztZ/BIqByH0lkYy0MWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Os0tlaYh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TojMDMZu; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Os0tlaYh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TojMDMZu"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2A9CE1140312;
	Tue, 24 Sep 2024 01:49:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 24 Sep 2024 01:49:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727156944; x=1727243344; bh=D0iH1cmQQV
	koaiMFh+sinnb5wEMyfzAQ3/31bhsHxrw=; b=Os0tlaYhaecwi8hpSNmkgBIQb9
	ks5SGAXU+Glig/WRIU94pXnXSr+gSgb8DOiq2DTk9DPVWquiib96wWWIhdLUqRsV
	Xhd9tOn9j+O1RWU6orRKBWd2/tm0AgWjwsmCvXPNH/5XCbOVOi25p3c1H9X+flWe
	XMzZ89lp9Ic2TJYwhwyvxLLuEubmYiz0rZb7OIl2F8nU+TTZcjerqlnIKOAjS8bw
	LNIvNk2VGNycVeH+f8prR5TqV0YduZJdNhJHAcTKQqzxDi5KlL8+KoxBTSMkDkQL
	jt2h+oIPYKVp5Z4zka+IxtHJuzH3YCeCfZrd/m2lFf+BVCetfZS0JmtK5jRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727156944; x=1727243344; bh=D0iH1cmQQVkoaiMFh+sinnb5wEMy
	fzAQ3/31bhsHxrw=; b=TojMDMZugBHmBVJ+1nyaauHgwpbV/gE/HJgbg02BOPih
	fN2UgL8DPY2DmB/Dj5YQIdeZ4M7ejJvq7GZJhRHVAx9AP2yB0WjHA+i1U9DVQWTJ
	+GQ+xkumYhqQGaH/o2PT6s+avHlWQUye2KJTVChvNQOubW58YZ4LwY/4EsYbvy55
	rAvfjbFI1q1zloYxmaPHJnvECGIYIJZCwCOxs3y0YP7PaAM1xPdgjnOlv2DTblv3
	6z3no800LXCSQ5scU/9aYnnIewRMlAQYFoJm5h+HKpC2WJFromMA0JA/DLiRTVIt
	cIUGvqwT9kps1PxJYwbnHcAfSWYL4p0FgwkdBM+dWw==
X-ME-Sender: <xms:z1LyZu6ellvbth8f4yRXDOEgHOz3g_bzcny0tFgQDRBMoupM5HtlWA>
    <xme:z1LyZn6bSYHDfHZbo793UDF3XKTb8br404z4QsLPE9NfKLWO3gNyYWW8HqM_87bil
    65ssIawm6aOOXh6NA>
X-ME-Received: <xmr:z1LyZtfAksGP_XX1-N6xp4Jr9WioptYCz4EtYMRrXXU8TkvLMCPjsXUMRC3-GVOR5nunoAN1ibfflryNLiSy178rImsO3bJsb1CCNdlr7ejV7g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtuddgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsoh
    hnrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:z1LyZrKx1MGxpv51daFgL_aYwKpQaqIY1HJy0Iq2OVsb1xzSpNM1XQ>
    <xmx:z1LyZiJZkQfhXzJudr_bykdH0-CmGBILjtfygcBICJbIPQDkDh6i_A>
    <xmx:z1LyZswbNvckLwu91SqvHIes-3fX3xuPVkpIJqwR6c3t6AEU90e8OQ>
    <xmx:z1LyZmKvsNnX5cx9DAjzIqrhg1vChwpK90Icg4IQWpMDHkD5xJpbeg>
    <xmx:0FLyZu2uYRcguxrqGgwg2uesZ_1CBarTEVKHDOOUBO5IuGkKj8w09mZ7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Sep 2024 01:49:02 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9d9df40d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Sep 2024 05:48:28 +0000 (UTC)
Date: Tue, 24 Sep 2024 07:48:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Edward Thomson <ethomson@edwardthomson.com>
Subject: Re: [PATCH 04/22] reftable/basics: handle allocation failures in
 `reftable_calloc()`
Message-ID: <ZvJSyT8OsUVLln4A@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <e6ded75f630ea309d5b76126560a0ec3d526bf71.1726489647.git.ps@pks.im>
 <xmqqed5cajd5.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqed5cajd5.fsf@gitster.g>

On Sat, Sep 21, 2024 at 12:37:26PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Handle allocation failures in `reftable_calloc()`.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  reftable/basics.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/reftable/basics.c b/reftable/basics.c
> > index 4adc98cf5de..b404900b5d9 100644
> > --- a/reftable/basics.c
> > +++ b/reftable/basics.c
> > @@ -39,6 +39,8 @@ void *reftable_calloc(size_t nelem, size_t elsize)
> >  {
> >  	size_t sz = st_mult(nelem, elsize);
> >  	void *p = reftable_malloc(sz);
> > +	if (!p)
> > +		return NULL;
> >  	memset(p, 0, sz);
> >  	return p;
> >  }
> 
> Since this series is not about eradicating all avenues in reftable
> library code that can lead to die(), but only about dealing with
> allocation errors from the underlying malloc/realloc routines, I
> think the code posted is perfectly fine as-is as a part of this
> series, but since I noticed something, let me comment before I
> forget.
> 
> When st_mult() detects overflow, you'd still die(), wouldn't you?

True.

> We'd probably want a variant of st_mult() that lets us notice a
> condition that would yield too large a result, and code the above
> like so,
> 
> 	size_t sz;
> 	void *p;
> 
> 	if (st_mult_gently(nelem, elsize, &sz) ||
>             !((p = reftable_malloc(sz))))
> 		return NULL;
> 	memset(p, 0, sz);
> 	return p;
> 
> or use the underlying helper ourselves, and say
> 
> 	size_t sz;
> 	void *p;
> 
> 	if (unsigned_mult_overflows(nelem, elsize)) ||
>             !((sz = nelem * elsize, p = reftable_malloc(sz))))
> 		return NULL;
> 	memset(p, 0, sz);
> 	return p;
> 
> which lets us without an extra helper but after writing it myself, I
> find it a bit too wordy.

Yeah, we'll have to have something like this eventually.

> In a sense, it is on the borderline to handle st_mult() overflow in
> this function for a topic whose theme is about allocation failures.
> 
> From the point of view of callers of reftable_calloc(), whether the
> arguments they are feeding the function is too large to be
> multiplied or whether the request is too big for the underlying
> allocator to handle, the end result should be the same: they
> requested too large an allocation.
> 
> So I wouldn't complain that it is out of scope, if use of st_mult()
> that computes the allocation size is fixed as part of this series.
> But as I already said, I am also OK if we leave it to a separate
> series to tackle other potential callers of die().

I'd leave it as-is for now, but I do have it on my agenda to address
this, as well. I already have it as part of my third patch series in
this context where I completely detangle the reftable library from the
rest of Git to make it a reusable library for libgit2 and the likes.

In any case, there's another, bigger elephant in the room: `struct
strbuf`. I will have to introduce a reftable-specific buffer type for
this such that we can handle allocation failures here, too. While the
alternative would be to amend `struct strbuf` itself to do that, I don't
quite think that we should do it in "core" Git itself for now. And it is
another excuse for me for why the reftable code should have its own type
instead of relying on `struct strbuf` in the context of making it a
standalone library again.

Patrick

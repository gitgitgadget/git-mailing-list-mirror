Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6B216631C
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 07:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728457614; cv=none; b=mwejGDSbXn+0wCn0zuCwCa5cTTSrc6hH25qgtI9DdNdNfET1kOScI8H0rHmmG37vJv7G61ZS1DKom2HYoP1/CATux8QLfuRWWry/PGbR3aDlkKWb0OguCBkM6+3DzoPjPptYdYsNE212yQf9Dvwo3WgsJjP+3O9+QZ2Nbdam5tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728457614; c=relaxed/simple;
	bh=ilicL5vdeAVdH17/d1/xpOSssMFZWU/1ZDg+TYJ+U2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TjNpHmaurgKKAY5QqynwUeQW8xftZYdZBVAk6YDepPQf0bi6ZjMhjrAQrjKHbzfcL7lqux2susNUJzI4ndsOaJmV8OQ/Oa1XqdqP7MksoN/l5rgGwXzxIVqAAWKDqOe4pNQ42nZEUQptvu7vlNIxH64PzUBF7XmGSDeYZf1OQgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=as9BcKdh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZiGa5G6h; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="as9BcKdh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZiGa5G6h"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DAF571140303;
	Wed,  9 Oct 2024 03:06:50 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 09 Oct 2024 03:06:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728457610; x=1728544010; bh=5N/FmXXtFT
	eZhAYjyQsFrn+hoYlkInSkVhmRgBdCd5w=; b=as9BcKdhJ1PxyCEy13/Zeks9nE
	3ia2rhuyS7zrJDq0lmXVoHjLzftrKpiKuvGzjuNbPsEoh6sxxmKJPNsIqT5m207i
	ZA7PjB77m0gwSKO2v8Xs+drxouqzX277EEmBlR5+teNDb8gtmLJXJUWpN0kkPhFT
	qQR3XFMhiph1JzyQwGK+MGeOUwkhxDd+VClPH+YeckdePuDReSkEliRsSS2pFF1R
	cR6++CpiaPQwG0c8zHx1MeQuS05UYgrnb8jbjG8UWQZ7uEuHNmI2MxxuUr+FFyWs
	6QMsC5mISJK9SAHAhKGKHE6Mq5JchrLX7LD2t6lFKcQF+ZS4iVYMoGNGxIkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728457610; x=1728544010; bh=5N/FmXXtFTeZhAYjyQsFrn+hoYlk
	InSkVhmRgBdCd5w=; b=ZiGa5G6hmDh9wY/wYk3W/KThKfTh+VMqHninbx2sX2Vp
	iviFddn4mVkPV8NOH91cmkSxTBbz5HmCTj4IUvZmzgaAAqEjs4IbTMP4j7HPL+j6
	Y7vv2rJorUQsREMEqKXW+K41Ucg13viVnLYnGJ3/VQhhnsqKg6XSG7BBU0DzCx/9
	cbIRcl69/1QFHmzuag/cxFkpp6jz7rAWSoSnThWsubSP40Schu8jixJjphyC0qwC
	JUi2S/lVozJlLbpFh7QGClTgC9vSynTLf2SlNQVSutJvSBieqfdpQF3rGD5gfK5L
	LXChZMYod6p3Xs4c10je3KjP7r4FJumLcg6NPdkpOg==
X-ME-Sender: <xms:iisGZ2guB6C0oQLbAL2xVDV2_ZRIwsVFYXMkV5-Zt7L4YgIS1MUaDw>
    <xme:iisGZ3BOltZs1G8SDR59VO2YNpZ1PkrqBLAfxw4U7hzB8idlIuZMkU3G_7Z4_BAV7
    sOaUeSVcze7mzSjXQ>
X-ME-Received: <xmr:iisGZ-FdGM_gPNLLwC-azfouBB0KAigm_QGwtoO58JvwkLANh4Exzru35MlDp8viBwYeVQRuJ3MDRNDHZsG6L5hnA7lHAlbxSlPM5VLvIUTRWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefvddgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveekkeffhf
    eitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhf
    sehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehm
    vgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:iisGZ_SKBwClj7nvIvXzaZI31LjiAXktJlJHkzQwQEgnJ7cUhD6GOQ>
    <xmx:iisGZzwmQbfayJHw4LusiRlhqduXEqd-msJK5W4pkjiUUxmYnZwVYA>
    <xmx:iisGZ97LTVev2KsfZp5fMt4-QQYP2MLSAsYGwRV3g_oCMF7K_wmhTQ>
    <xmx:iisGZwzTjvibejLeoeUe8MyYDGbMnrDJCeebGvgZ2cCG8Sv1fN3gfA>
    <xmx:iisGZ1s3Kwn0D_qfGbJFIZLvFBLxcCkC2dQbR0iC0pKc08vlQZ9SfAX2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 03:06:49 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id db4beb37 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Oct 2024 07:05:44 +0000 (UTC)
Date: Wed, 9 Oct 2024 09:06:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 15/23] pseudo-merge: fix leaking strmap keys
Message-ID: <ZwYrfCn13aP8fC6H@pks.im>
References: <cover.1727687410.git.ps@pks.im>
 <9e1161d55f96253bfeb5cddd1bbd381e2dad8a71.1727687410.git.ps@pks.im>
 <ZvsWlNPGxt5AOQcK@nand.local>
 <ZwOstswKzqMNNOUO@pks.im>
 <20241008085423.GA1211512@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008085423.GA1211512@coredump.intra.peff.net>

On Tue, Oct 08, 2024 at 04:54:23AM -0400, Jeff King wrote:
> On Mon, Oct 07, 2024 at 11:41:16AM +0200, Patrick Steinhardt wrote:
> 
> > > Hmm. I think I am probably splitting hairs, since a few xstrdup() calls
> > > between friends is unlikely to matter here, but... ;-)
> > > 
> > > It does seem wasteful if we can avoid it. We already allocated heap
> > > space for the matches via the underlying strbuf, and we really do want
> > > to hand ownership over if we can.
> > > 
> > > Would doing something like this on top of your previous patch do the
> > > trick?
> > > 
> > > --- >8 ---
> > > diff --git a/pseudo-merge.c b/pseudo-merge.c
> > > index 28782a31c6..6b6605d3dc 100644
> > > --- a/pseudo-merge.c
> > > +++ b/pseudo-merge.c
> > > @@ -110,6 +110,7 @@ void pseudo_merge_group_release(struct pseudo_merge_group *group)
> > >  		free(matches->stable);
> > >  		free(matches->unstable);
> > >  		free(matches);
> > > +		free((char*)e->key);
> > >  	}
> > >  	strmap_clear(&group->matches, 0);
> > > --- 8< ---
> > > 
> > > That introduces an ugly const-cast, but I think it's tolerable (and may
> > > be moreso with a comment explaining why it's safe).
> > 
> > Well, to me this is a tradeoff between complexity and performance. If
> > the performance benefit outweighs the additional complexity that this
> > shared ownership of keys brings along with it then I'm okay with the
> > code being intimate with each others lifetime requirements.
> > 
> > But as far as I can see the number of entries is determined by the group
> > pattern, and I expect that in most cases it's going to be quite limited.
> > So it does not feel like this should lead to all that many extra
> > allocations, and thus I tend to prefer the simpler solution.
> 
> I'd tend to agree with you that the allocations aren't a big deal here.
> But I think we've run into this kind of strbuf-detaching thing before,
> and there's another pattern that is efficient without getting too
> intimate between modules. Like this (plus your change to set the
> strmap's strdup_strings mode):
> 
> diff --git a/pseudo-merge.c b/pseudo-merge.c
> index 10ebd9a4e9..fb1164edfa 100644
> --- a/pseudo-merge.c
> +++ b/pseudo-merge.c
> @@ -210,6 +210,7 @@ static int find_pseudo_merge_group_for_ref(const char *refname,
>  	struct bitmap_writer *writer = _data;
>  	struct object_id peeled;
>  	struct commit *c;
> +	struct strbuf group_name = STRBUF_INIT;
>  	uint32_t i;
>  	int has_bitmap;
>  
> @@ -227,10 +228,11 @@ static int find_pseudo_merge_group_for_ref(const char *refname,
>  	for (i = 0; i < writer->pseudo_merge_groups.nr; i++) {
>  		struct pseudo_merge_group *group;
>  		struct pseudo_merge_matches *matches;
> -		struct strbuf group_name = STRBUF_INIT;
>  		regmatch_t captures[16];
>  		size_t j;
>  
> +		strbuf_reset(&group_name);
> +
>  		group = writer->pseudo_merge_groups.items[i].util;
>  		if (regexec(group->pattern, refname, ARRAY_SIZE(captures),
>  			    captures, 0))
> @@ -256,8 +258,7 @@ static int find_pseudo_merge_group_for_ref(const char *refname,
>  		matches = strmap_get(&group->matches, group_name.buf);
>  		if (!matches) {
>  			matches = xcalloc(1, sizeof(*matches));
> -			strmap_put(&group->matches, strbuf_detach(&group_name, NULL),
> -				   matches);
> +			strmap_put(&group->matches, group_name.buf, matches);
>  		}
>  
>  		if (c->date <= group->stable_threshold) {
> @@ -270,9 +271,9 @@ static int find_pseudo_merge_group_for_ref(const char *refname,
>  			matches->unstable[matches->unstable_nr++] = c;
>  		}
>  
> -		strbuf_release(&group_name);
>  	}
>  
> +	strbuf_release(&group_name);
>  	return 0;
>  }
>  
> 
> Now we skip the duplicate allocations because we are reusing the
> group_name scratch buffer in the loop over and over. But wait, there's
> more! We're actually _more_ efficient than the original which did one
> allocation per entry, because:
> 
>   1. We can allocate the correct number of bytes for each name, rather
>      than using the over-estimated buffer made by strbuf.
> 
>   2. In strdup_strings mode, strmap is smart enough to use a FLEXPTR to
>      stick the name inside the struct. So we've actually reduced the
>      number of allocations per entry by 1.
> 
> Now possibly it is not even worth doing this optimization, because this
> is not really a hot path. But it doesn't violate any module boundaries,
> and I think the "loop over a reusable strbuf" trick is a general idiom
> for solving these kinds of allocation problems. So a good thing to keep
> in our toolbox.

Nice, thanks for digging! I see that Junio has already merged the topic
to `next` though -- is this a mere "Let this cook before the next cycle
starts" or will it stay in next?

If the latter then I'll leave this as-is, otherwise I'll send a revised
version to make this a bit more efficient.

Thanks!

Patrick

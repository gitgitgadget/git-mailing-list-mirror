Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9792350A36
	for <git@vger.kernel.org>; Fri, 30 Jan 2026 12:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769777892; cv=none; b=VBIN0Av7DUj41usnN1PqCLKRGdn3o+uYuu/ZGtmxVsW7n+93ryscel5D4OZqMs1Q/BhkJiDOUiTAzez9b85aKoNZuiDG2kQzcsAbR1KyQ7jRu+T5s0iXZDsfDk8xPqnp/lH6iSaFIOb5URUph/+ImPPbaWHrDVcqQlwmgNaHShw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769777892; c=relaxed/simple;
	bh=OIDECrI8wNFRmkrmAbJn2EDp7J+S087v1ujMFbww728=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cTRYGdQKkrgQLrTeNxbJ0R4+N1xTXnUYKq+AvyEByvxOllbufgV5Ve7wxaAtqI6F8cpqyTaezPvjERPknijpLgfKZFt00ZNh7XbiCCiL4vb1PS9jn/OUWD7cCptw/yoKfs/kkCHRH8n1qWD7JUrY21cnwgLzOeuLPt5dPh+6kMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=S/T7Rr3d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qyt9ExNC; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="S/T7Rr3d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qyt9ExNC"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C6B321400175;
	Fri, 30 Jan 2026 07:58:09 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 30 Jan 2026 07:58:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1769777889; x=1769864289; bh=1creGMGlaz
	WgQNe5ybfuxaykU8ElubhH88QzhEXQGl8=; b=S/T7Rr3ddS/A+MK2EAMoQwredS
	io7nHSnYMPF99RTt5x/CR2zJRGuAoTQx7SSSaE6qauYERJDujpOMntwtck5Vu3Fg
	WZVfAvmAd9ECQ0ol9gj3LbU10kDkaTB7hTNrySG6mUx9inDk29bsIV3p5H39Mcf+
	6tym5Ej33WClugst314CZBqopEa/kOSjpZTOgVWz4i7DW/7VKDtPB5sAySNYcC+i
	RMJPtExBlSJs/aacqY6EC4pT6uCX3246WR0/4FbMp3qkSMRLw0hLGicn4GvAZ6Pe
	eNUYyR39JPcsbNO1HcfaH++P25H+Kh3JVlnx1gW/sTRmAcCtqVUplx6AreOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1769777889; x=1769864289; bh=1creGMGlazWgQNe5ybfuxaykU8ElubhH88Q
	zhEXQGl8=; b=qyt9ExNCRtX1n8ctmuhZy1l1a6fy7zt03HkjF2QEW+MynY04Hc3
	tNAkkKQq9Wm9ycX+Kjc2wD5SskN1Wmp+k9gO0UIm1DQu+A13lk+9C+ydTiC1HdNr
	EfrFD7G3lrf6/8SrnISmYnz6zOXBT1mFVl82WMx0dx8rXD++QZhNF34CNHiboL8Q
	0TE2G9dmFkyZdWiKEVzFrdUYZwG+SMD5WAf1yHRDDC6L6bdePsQOa6jp309gkott
	LXpkC986u+5Ut2Cv0u73MAYpXPY4XWGN+n9JIBOdarAMRq7Rog9d1P1/SeW3BY+Y
	T5U1IeuESAFYu+8gmbVyUOr/mZ/X5apMv4Q==
X-ME-Sender: <xms:4ap8ab4w5U5XCxQFdRpphtg4gn0sR30xW89x1BDz4ed4A2aiXGbPfA>
    <xme:4ap8aW4UHA0EsyFahbrsZCwHOh7P9OW45ZPVQc5OezsGmR2hJmWew4LlgKiHmleIU
    v3OisN2_J4QzMArpYqSt8MbNQVKMVAx2qD5Z7bezjtB1CjlaoQC1Q>
X-ME-Received: <xmr:4ap8aQF9AD21yR4Xz_sENDEu5e_90NUZs2EeOQZdKsLePHesxjs5aV9XeEIV57W8ehlhRpPGpKZJC-Be42l2MiSZ57pY1AC5eHzRVbLAJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieeluddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:4ap8aXRoSqxKt2ObY2g9Wr-_coYWRYejTsNGdBIkV3qrgYXLQ3WOnA>
    <xmx:4ap8aRsvPQKu8NNGABbXRp_IV3HoeVF3caxAqLl22CLzqVCfkLuqBg>
    <xmx:4ap8aew722A9w9s79tzOMTvLQQAJ9pGe52vOHcCs1g3oskhtkRnEhA>
    <xmx:4ap8aT4-U_Z2U-ZaWQhhofl5gGaZ_JeUAEsijaxkaOMAbZE7b155SQ>
    <xmx:4ap8aRDGxfLiqNYUTyWWqz964Lz267XdIm2GlWVquGsW9L_PRx1mMUXF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jan 2026 07:58:09 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 90f841be (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 30 Jan 2026 12:58:08 +0000 (UTC)
Date: Fri, 30 Jan 2026 13:58:03 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/3] pack-bitmap: deduplicate logic to iterate over
 preferred bitmap tips
Message-ID: <aXyq2_MByjxf3TBX@pks.im>
References: <20260128-b4-pks-fix-for-each-ref-in-misuse-v1-0-deccae3ea725@pks.im>
 <20260128-b4-pks-fix-for-each-ref-in-misuse-v1-1-deccae3ea725@pks.im>
 <aXrDD1H4lvBR1sF8@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXrDD1H4lvBR1sF8@nand.local>

On Wed, Jan 28, 2026 at 09:16:47PM -0500, Taylor Blau wrote:
> On Wed, Jan 28, 2026 at 09:49:20AM +0100, Patrick Steinhardt wrote:
> > We have two locations that iterate over the preferred bitmap tips as
> > configured by the user via "pack.preferBitmapTips". Both of these
> > callsites are subtly wrong and can lead to a `BUG()`, which we'll fix in
> > a subsequent commit.
> 
> OK, so there is some bug here that is shared by both call-sites (one in
> the pack-objects case for single-pack bitmaps, and another in the MIDX
> code for multi-pack bitmaps). That bug is yet unspecified, but that
> makes sense since the point of this patch appears to be unifying the two
> implementations together so that both may be fixed at once.
> 
> As of yet, it's not totally clear to me what that bug is having just
> read the cover letter. I don't know how much detail it's worth getting
> into here since you'll end up covering it in much greater detail in the
> following patch, though it might be nice to include at least a taste of
> what's to come beyond just "[they] are subtly wrong".

Sure, can do.

> > Prepare for this fix by unifying the two callsites into a new
> > `for_each_preferred_bitmap_tip()` function.
> >
> > This removes the last callsite of `bitmap_preferred_tips()` outside of
> > "pack-bitmap.c". As such, convert the function to be local to that file
> > only.
> 
> OK, I think hiding this implementation from outside of the compilation
> unit makes sense, however I am not sure that we should keep it as a
> separate function.

I originally though the same, but there still is a second callsite of
this function. So...

> > diff --git a/pack-bitmap.c b/pack-bitmap.c
> > index 972203f12b..2f5cb34009 100644
> > --- a/pack-bitmap.c
> > +++ b/pack-bitmap.c
> > @@ -3323,6 +3323,22 @@ const struct string_list *bitmap_preferred_tips(struct repository *r)
> >  	return NULL;
> >  }
> >
> > +void for_each_preferred_bitmap_tip(struct repository *repo,
> > +				   each_ref_fn cb, void *cb_data)
> > +{
> > +	struct string_list_item *item;
> > +	const struct string_list *preferred_tips;
> > +
> > +	preferred_tips = bitmap_preferred_tips(repo);
> 
> OK, so this is the sole caller of bitmap_preferred_tips() you were
> referring to earlier. That function's implementation is hidden from the
> diff context, but it's effectively a thin wrapper around
> repo_config_get_string_multi().
> 
> I wonder if we should just inline the implementation here into its sole
> caller. Is there a reason to keep them separate? I do not feel strongly
> here, just thinking aloud...

... I actually tried this, only to realize that the function is still
called by `bitmap_is_preferred_refname()`, too.

> > diff --git a/pack-bitmap.h b/pack-bitmap.h
> > index 1bd7a791e2..d0611d0481 100644
> > --- a/pack-bitmap.h
> > +++ b/pack-bitmap.h
> > @@ -5,6 +5,7 @@
> >  #include "khash.h"
> >  #include "pack.h"
> >  #include "pack-objects.h"
> > +#include "refs.h"
> 
> Oof. I wish that there was a way to forward-declare the each_ref_fn
> type, but there is not AFAIK.

We could get around this by simply open-coding the function signature
and having a forward-declaration for `struct reference`. Not sure
though whether that's really worth it.

Patrick

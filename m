Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C1622ACEB
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 09:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758620103; cv=none; b=G85wqif54XVqs6rabZ941e0q4+UWitcus/bVig1nlCj3ASZZWoln9YOtK03NaeHqRoxQz3+CgprxNlHsbvAcLtJFCouOe5ZZt9rgponr50UkAWqornQI9SykKU8cddTxPtmj4dhejrLc+MgGxxFc/aN0NzXXWMSTExYNbGBf6u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758620103; c=relaxed/simple;
	bh=ymxkmg5AK4HJ1VuDvBthktCgnihYVOlu8cqjL3Mz1fY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d9yC+ZE4ZODbfqdInzEyxluNgY4TcZvUc9BDvPWh+Lnk3hHHBBZBvjpdM20MFGFFeLAeyXocVkcpm25iLYjocSzItFJVhYF/sYuU8cBnELr+oLmVW5ZYqnsq09V6tyCcFyMH1ygGfVfUei6OHXChN6oSpXOT7mQV73FYV7p7Z5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iQf8jBoH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LNkC32Qj; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iQf8jBoH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LNkC32Qj"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id BDE331D00100;
	Tue, 23 Sep 2025 05:34:59 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 23 Sep 2025 05:34:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758620099; x=1758706499; bh=RXBKUwzQDl
	cCwBIQq5ujl+qx1KdF04gbgCH0Z7Br7KY=; b=iQf8jBoHmJT6ZUeCLKMwObPgMB
	mcGoT2Mlmk6pIJnKsLHrHBk6imEuazC7NzciweO+Tm8j30kma7yXAkWpEUjS1tgz
	KJAlGpb4R34dWhl3cqYhjdIeDQL+r7mUMKiHRols0eFCB/GXJRlziVfxIQ+6ldlb
	JUSDYXn4HpO6kjKyp1KykyitaJk5FbLiuXYjL6eUj+cW/oS4tEi2bqiAIN0fKKsI
	qLQJjEn0+4tj4tA0miKZo6fmEUv9nRHt/ZdzMAwkTJwvVDOsjLuGX7VodJENyQPE
	lJDSidm2JufOZlU31XJaKwuRUcU6zsgmeewsVlpg2ur7MB229f2n2LnPZNNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758620099; x=1758706499; bh=RXBKUwzQDlcCwBIQq5ujl+qx1KdF04gbgCH
	0Z7Br7KY=; b=LNkC32QjMtPeuEfuPZKRE5xLBnc2HkolgsUu49Wm5gXCeEoaDJI
	RZ/r/adCCZ+khqs5LyNw4CwUeFGsImo9jX7CpmiMaDarVE+iEjADAL83biMBzpvA
	zI1tX2LFG5uOooHJfHzS2zNPLo7rzpe0U0HrZ25ItLqYEBIzYv/5N1ItcfJERSDx
	i+fj6GDPK8u+DMvrCex7EndIXToLk1RFjeo+dyAw8+szkQKR3I75mDWhlQIDWr4X
	KR8yn1AALv+X9vZXBfeF2WoeOtVl6aXH0gVSfNrklXhc4DIYOHp3zCkr4ti414Vz
	I48vxbBIf5kNJNMDtrh8QW+/ObjNisnbSPQ==
X-ME-Sender: <xms:w2nSaIiI6cqI9BFptMJ2Dr7WPSYe2cpeu4xUJypccAHMHD0a9l_r_Q>
    <xme:w2nSaEuT6vpqsrVF7IdRcVMfJDYU1LjnzB15pBnPrjUi7AEkEjm8Nk3rq9dMRCVzg
    Yksplrtni6k-N7I3JN5-LFy4rv3ZbtO57jE3nr25d7xrgo1V7vfjg>
X-ME-Received: <xmr:w2nSaJ5zHbJTYHtFqfVwFkrN_51TETjHvXqMAUitwlnfKUBg717XmQG9X6_hE0D2Vrh4D2hl6U6R9_dduo1eK54EftBDgBUKI_Kj9zOJ4ws4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeitdefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhl
    rdgtohhm
X-ME-Proxy: <xmx:w2nSaAOe_8m9dcb5loqz1VLYolIkQoGWIKdZgzydobvtUVWhvx_5PA>
    <xmx:w2nSaHvIBlXWLwL9JQu6-hyl1xG5mdxmCJ9s32e5_U-Ktx4cz2S59Q>
    <xmx:w2nSaDb9lVYxsQnnqfTLUDljFmn0QwRYQtUq304RSmezkcHZ57JT-A>
    <xmx:w2nSaJzKK-_hrDXIHwMXu7apTjofH6JGR36-yRjEdgXH-WHYI-P_2g>
    <xmx:w2nSaF94G_heJwkwWwUsmnBoZxKQRc4Lr-MoztmZc3ZmUhQHm1pj1q-->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 05:34:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fedef693 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 23 Sep 2025 09:34:56 +0000 (UTC)
Date: Tue, 23 Sep 2025 11:34:53 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 09/15] packfile: split up responsibilities of
 `reprepare_packed_git()`
Message-ID: <aNJpvS1jk4ww0JXk@pks.im>
References: <20250915-b4-pks-packfiles-store-v5-0-d6340350934f@pks.im>
 <20250915-b4-pks-packfiles-store-v5-9-d6340350934f@pks.im>
 <p6f3xtitrepajnaho4eqwoh7o2qweim6adr3x726dbwg63kmny@cx5n43myawue>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p6f3xtitrepajnaho4eqwoh7o2qweim6adr3x726dbwg63kmny@cx5n43myawue>

On Wed, Sep 17, 2025 at 05:32:43PM -0500, Justin Tobler wrote:
> On 25/09/15 10:54AM, Patrick Steinhardt wrote:
> > diff --git a/odb.h b/odb.h
> > index 1c998a2478..ef34132c58 100644
> > --- a/odb.h
> > +++ b/odb.h
> > @@ -163,6 +163,12 @@ struct object_database {
> >  struct object_database *odb_new(struct repository *repo);
> >  void odb_clear(struct object_database *o);
> >  
> > +/*
> > + * Clear caches, reload alternates and then reload object sources so that new
> > + * objects may become accessible.
> > + */
> > +void odb_reprepare(struct object_database *o);
> 
> nit: IMO, something like `odb_reload()` sounds a bit better, but it's
> not a big deal either way.
> 
> [snip]
> > diff --git a/packfile.h b/packfile.h
> > index bf66211986..a85ff607fe 100644
> > --- a/packfile.h
> > +++ b/packfile.h
> > @@ -112,6 +112,14 @@ void packfile_store_free(struct packfile_store *store);
> >   */
> >  void packfile_store_close(struct packfile_store *store);
> >  
> > +/*
> > + * Clear the packfile caches and try to look up any new packfiles that have
> > + * appeared since last preparing the packfiles store.
> > + *
> > + * This function must be called under the `odb_read_lock()`.
> > + */
> > +void packfile_store_reprepare(struct packfile_store *store);
> 
> nit: I also think `packfile_store_reload()` sounds a bit nicer here.
> 
> Overall this patch looks good. :)

Seen in a void I'd agree, but "preparing" and "repreparing" have been
terms that we already used for quite a long time in this context. So I'd
rather continue using them for now.

Patrick

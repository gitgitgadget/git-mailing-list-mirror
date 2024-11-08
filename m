Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3AB2629C
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 06:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731046640; cv=none; b=o8DrVvHDw5QGZpeEvfri0DGMrvFUG+o+MC2zg5RYCi4s/d5D8j/e525ADpnb6mpy0y97Ade46hfbT38i+JYBFKKTaHSkd04L9SVHnvwj361q0h24KZpmBB+AbW6Bix+gOgtSyga56LNE1xKF+PQj8LYyhsyM6y/S4S/0wQMJUBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731046640; c=relaxed/simple;
	bh=KL8fzDEgd67UAIV42KDJB8gU3LhUle6YISZ2HA4EvOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N1aoZPNUdU2kad3ydYRLncOtaV6crbDH2Qv1HRnyeeL8V0RI2mPZTBZrg8PrFqP5yoWPQ3OTxDqzwS8AbT84kSUr7PouFKZk7D3GlSsU6l7eMagHWC8otVeJNNmthVxD6h8jgUdbFR8dKMkJXFks7UhT8Y487EFI73o3MvFff2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZieTOfV3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c9Jp+yDN; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZieTOfV3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c9Jp+yDN"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 0771811401A9;
	Fri,  8 Nov 2024 01:17:16 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 08 Nov 2024 01:17:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731046635; x=1731133035; bh=Z8/358/1df
	l0padEr8qem/uA16fi10vBNDJBeen7ei4=; b=ZieTOfV3qtpDUmrCpPERe8TKgs
	Sd7pxNWWBHBn1rIGZNdfy1WjVEsXJGpoYMtmHcb32F217hrlKiOrwqX2KYV4M7Ii
	CrgKLrDH/mt8AziW2joofONHRxyK5Nr7Prwz/iUscXHmAwEdoPktgOAchq2ukfp9
	GyxqnHpWyHt/KYgrsZGfsZbzK3vnIiHQbqm70cGwPg4l/tQZECVyI/IpAL/9rca3
	rv4qBjllBBr5bRhK+ig5WBvh7cEpfwT6qPk8QqhGGzZDpF/ymxTKW/jCLxopxNGO
	eXBlP4eu1HkxSuSWp8zIViP3nboi5Maeso/Gg9Iqxi843OYC2e1CPG8t7vFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731046635; x=1731133035; bh=Z8/358/1dfl0padEr8qem/uA16fi10vBNDJ
	Been7ei4=; b=c9Jp+yDNK7TPcw2PoRAh1v3/000yypcIVfyVoJRNGp02CP8rn/W
	lOiKP+OyTkb9KYUZnfe86N67X9B2So+REHQ0DONiRrmE/WLJeYA12Se1szK4oVef
	H1ptYoIl2/m6aeiTP/SCB9DJBHaShcL8jR5ZEwwkTTeNu0XuJeRbqC3c+pH3xJOL
	JEJsQLqqkHq2a4ecJeWYsANgNhiLjdQOXZT11HwY00tEYsbiqvhG/lq8yFW9boBc
	Rd5F7tKtIGbGp4BK4T6UC77im4R/B+rqrH7urQbwmsFyRfETRZZCabE9GntYWoPi
	JF9qgSKCVJW2JG4zxeuaffF1T6bNeg23CyQ==
X-ME-Sender: <xms:66wtZ1TNZApp-jiVnxRTJrfIrl3jLOYuvRNR66KpkCPv9dkk5RYK2g>
    <xme:66wtZ-wAy2aROPFOl_Yr21dQ-7mYc6R7OKmca1asZk4K7jdqZ1oND4Y-LZWa1XghN
    EFX-6gsuv2YnCumFg>
X-ME-Received: <xmr:66wtZ63EM6B1SVTR1ILS8w_5hu6iyZg0Da2ThGdXv_Y0FVtOMCa7cK2JcwwWVOsE1WvVzAsKPIbP9r6TkqQrD4OSFnLCsWsPq495RQmcMlQnPQo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdehgdelvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvghthhho
    mhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhm
X-ME-Proxy: <xmx:66wtZ9CXHVMqI4lq6P9z5bH8HWlUBKhcwHUbIMuIs3wg8MYxErxPyg>
    <xmx:66wtZ-hHAooAi6U--0nOHMOfSyH1TWQ9wZsYHLEH9qIuNR9syOC9Fw>
    <xmx:66wtZxqqWcokSWhJZqh1BcUVMvdUPX9uJLFKckQzUDDLNMcG49Fo-g>
    <xmx:66wtZ5haloXZILMG-s7jHYVSS0M5_aXh6FsEeHRQCoBEfUILmCXzjA>
    <xmx:66wtZ_t4n2frWlcwxc684oDdRIC3Dm3XTvMhnRDXXs-RJU7gsIQO_zaJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Nov 2024 01:17:14 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 072ff3ad (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 8 Nov 2024 06:16:47 +0000 (UTC)
Date: Fri, 8 Nov 2024 07:17:07 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Edward Thomson <ethomson@edwardthomson.com>
Subject: Re: [PATCH 4/7] reftable/stack: stop using `fsync_component()`
 directly
Message-ID: <Zy2s41sv4IlMoISl@pks.im>
References: <cover.1729677003.git.ps@pks.im>
 <86269fc4fcad9a97709aa0d080c4c077a85ca667.1729677003.git.ps@pks.im>
 <6ghxx5fmuzujegducuva77vpybihz6b5cnk75wdgv4pv2knac5@m3trfmg2dk5s>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ghxx5fmuzujegducuva77vpybihz6b5cnk75wdgv4pv2knac5@m3trfmg2dk5s>

On Thu, Nov 07, 2024 at 08:09:21PM -0600, Justin Tobler wrote:
> On 24/10/23 11:56AM, Patrick Steinhardt wrote:
> [snip]
> > diff --git a/reftable/stack.c b/reftable/stack.c
> > index 9ae716ff375..df4f3237007 100644
> > --- a/reftable/stack.c
> > +++ b/reftable/stack.c
> > @@ -43,17 +42,28 @@ static int stack_filename(struct reftable_buf *dest, struct reftable_stack *st,
> >  	return 0;
> >  }
> >  
> > -static ssize_t reftable_fd_write(void *arg, const void *data, size_t sz)
> > +static int stack_fsync(struct reftable_stack *st, int fd)
> >  {
> > -	int *fdp = (int *)arg;
> > -	return write_in_full(*fdp, data, sz);
> > +	if (st->opts.fsync)
> > +		return st->opts.fsync(fd);
> > +	return fsync(fd);
> >  }
> >  
> > -static int reftable_fd_flush(void *arg)
> > +struct fd_writer {
> > +	struct reftable_stack *stack;
> 
> Out of curiousity, from the stack I think we only need the callback in
> the options. Any reason we provide the whole stack here?

I just think that passing around function pointers doesn't make for a
good calling convention here, as it hides the fact that it is possible
to call this without a callback. But there isn't a reason to pass in the
whole stack, it would also be fine to instead pass in e.g. the write
options.

I think I'll do that instead.

Patrick

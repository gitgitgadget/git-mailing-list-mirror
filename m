Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E881F0E42
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 10:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740999314; cv=none; b=AS2a+b5FXIvX0FRVs9OZrinr/fMAG5x4jrKnnKhl+m3dcago701nDaNfZ9lrEJY4QQaZmEGSOw18C/1hAuxvo9tlK7GLXS9hfoVruE1QMeRME5OIVF6uZksqtNvhZuhi09afuUYEnWuPZammUxmm/B8eZTixz4xDars3RxgKIZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740999314; c=relaxed/simple;
	bh=ter/6WKgriIt0yOvvHDYe4KkpkCf0w2zVSNYjFM8jJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tWN7TX/XGjXe39neQUPJ5DZ0yugNipUKnALk2sPvEC3DuueEznhi7JkGEW9uXuqarzQvX0wn80bkj4uABV8hvI3OTPdjlNEWeUD4mVE34gLIFnUYeR5gleV8fsInOlNY00EbP4pwigOLw6EwwZ1ITJod7NcUJj0x+cJli1oT6Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OPGwS5iT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cqnW3Pv+; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OPGwS5iT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cqnW3Pv+"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EB0B525401C9;
	Mon,  3 Mar 2025 05:55:07 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 03 Mar 2025 05:55:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1740999307; x=1741085707; bh=LyhlE56fR6
	Gzb0pTS5ufMvKqfQdc6p9bRfK8YcZF/nI=; b=OPGwS5iTJFjFeGpXSixAE8yEAA
	MMeH0AsEG/yon3qocsy63VOCxHNOcRrQH16BCAUsBPnNU4lKjCi+9lfr6EAKD+nH
	JFQxrRrHWLiD0CEX1kUyCiJ2IXVbw1EMtIZVqS37ufPGmf76uFZHcV7pHVuDoIS3
	mf+336zZI/SbO2904K1Nd/npUVdgEcGDy5yyIi+OI/DGb6UyvNZi5XLtgiurJCNT
	xzXqLD478ufriFQ10yvB0ftfLvbOMXiyD/MULvelkVsTEclbo14aCSl4XcvKZhuO
	T+lBjWUkgsAB300Iu5Hb2qG1kRDUkMq0F+H4olcI61yJSveOJy/uA08CoiaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740999307; x=1741085707; bh=LyhlE56fR6Gzb0pTS5ufMvKqfQdc6p9bRfK
	8YcZF/nI=; b=cqnW3Pv+1EmcAks+6ySh3uylo+0Jm30UUYXwgCZU8DeQQzCmKkh
	Od5R52VN+GZUXtlXniNjigcahbDD6Hy6w66aa+aLhm9F2YBFJ+qzZUOjAqm9rOfK
	n18qa7pULzKAX67mxWYj0O5t206wyeoJB3Ybdy7OBEOEBEaK7R5lKT4IYTEsfYq2
	1T+OrgdI+YJGowg1Gvq+CgTy6Pxq1nYmdCTTC96Fa1PtwkzxUE05E12ntRWLA9Ar
	maLnnte0u/XOEWREnzF79aIzXg9iVSwPxeHtxCNCKqp/vwxEEYVPj6XIa47JLVFs
	bgiyVKY4efc/w1CXoGaxPPHVbQRKc+j9w4g==
X-ME-Sender: <xms:i4rFZ2Zlvdf-1jic4w3EsEv6DuvCjtyuh8TfkVZeJ-UeajHSozpe2Q>
    <xme:i4rFZ5bsuzqC9NtaVSi4V6Gut9D42qrc34cmb0lYTiUArAaurfhOVbP-o8T7WZlSY
    d5xY8xneOR74ndtDA>
X-ME-Received: <xmr:i4rFZw_YOv6LTWj12EVx3o82Sc8O_G3vF_S9flaoxRkkVJwEjprsHlhLLCDsV1eeMGTpliisBCpUt3ugNmO_zcBPc0SlV04ViwAD70AWXs7sYejM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelkeelfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpth
    htohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehnvgifrhgvnhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:i4rFZ4rk4pG4URHQU-ddAReeJ_QFO5KuaJRpGMkTtAngYHqDt32XSw>
    <xmx:i4rFZxoPa465l32v7Gn5tr2FwUfyOsN51aWoBwTCVkWl2xKa4rUWOQ>
    <xmx:i4rFZ2RmBcyNpfypij85w-5HBrG04VzZMQWcM17cBvrFM1U1vjlphA>
    <xmx:i4rFZxoCGEczzjwQ9JJ-3C3gFmybW6JCuOWPPDX26uQdmqmhP33DoA>
    <xmx:i4rFZ6BP5W0klppG0AIG_2oi-31yeoOpGntKPv0E5kqHnP_Uo54rgdus>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 05:55:06 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 81deeeb0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Mar 2025 10:55:04 +0000 (UTC)
Date: Mon, 3 Mar 2025 11:54:58 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 01/13] Documentation: describe incremental MIDX bitmaps
Message-ID: <Z8WKgisnKb5zc1xO@pks.im>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1732054032.git.me@ttaylorr.com>
 <caed2c6ec3483f028f59777bba40480e2661ca80.1732054032.git.me@ttaylorr.com>
 <Z8GJYMbXMZqI5fUL@pks.im>
 <Z8JGNQZolfs7fm65@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8JGNQZolfs7fm65@nand.local>

On Fri, Feb 28, 2025 at 06:26:45PM -0500, Taylor Blau wrote:
> On Fri, Feb 28, 2025 at 11:01:04AM +0100, Patrick Steinhardt wrote:
> > On Tue, Nov 19, 2024 at 05:07:19PM -0500, Taylor Blau wrote:
> > > diff --git a/Documentation/technical/multi-pack-index.txt b/Documentation/technical/multi-pack-index.txt
> > > index cc063b30bea..a063262c360 100644
> > > --- a/Documentation/technical/multi-pack-index.txt
> > > +++ b/Documentation/technical/multi-pack-index.txt
> > > @@ -164,6 +164,70 @@ objects_nr($H2) + objects_nr($H1) + i
> > >  (in the C implementation, this is often computed as `i +
> > >  m->num_objects_in_base`).
> > >
> > > +=== Pseudo-pack order for incremental MIDXs
> > > +
> > > +The original implementation of multi-pack reachability bitmaps defined
> > > +the pseudo-pack order in linkgit:gitformat-pack[5] (see the section
> > > +titled "multi-pack-index reverse indexes") roughly as follows:
> > > +
> > > +____
> > > +In short, a MIDX's pseudo-pack is the de-duplicated concatenation of
> > > +objects in packs stored by the MIDX, laid out in pack order, and the
> > > +packs arranged in MIDX order (with the preferred pack coming first).
> > > +____
> > > +
> > > +In the incremental MIDX design, we extend this definition to include
> > > +objects from multiple layers of the MIDX chain. The pseudo-pack order
> > > +for incremental MIDXs is determined by concatenating the pseudo-pack
> > > +ordering for each layer of the MIDX chain in order. Formally two objects
> > > +`o1` and `o2` are compared as follows:
> > > +
> > > +1. If `o1` appears in an earlier layer of the MIDX chain than `o2`, then
> > > +  `o1` is considered less than `o2`.
> >
> > Just as a refresher for myself: what is the consequence of an object
> > `o1` sorting earlier than `o2`? In the case where those refer to
> > different objects it is only used to establish the pseudo-pack order so
> > that we know how to interpret the bitmaps. But in the case where those
> > two objects refer to the same underlying object, e.g. because the object
> > is contained in two packs, it also impacts which of both objects would
> > be preferred e.g. during a clone, right?
> 
> Great question -- the pseudo-pack order here is how we translate the set
> of objects in a MIDX into their corresponding bit positions in the
> bitmap.
> 
> So if "o1" sorts ahead of "o2", that means that "o1" will appear in an
> earlier bit position than "o2". But note that we're talking about
> objects in a MIDX chain here, comprised of objects from each MIDX'd layer of
> that chain. So by that point the duplicates have already been filtered
> out, since:
> 
>   - The MIDX only stores one copy of an object in any given MIDX, and
> 
>   - The incremental MIDX design avoids putting objects from earlier
>     layers in later ones.
> 
> I tried to get at this a few lines up with "[...] a MIDX's pseudo-pack
> is the de-duplicated concatenation of [...]" to make clear that o1 != o2
> here. But let me know if you think I should clarify or emphasize that
> point further.

Okay, the deduplication bit was a bit subtle, so I missed that part. And
once one has learned about it my question makes less sense, as I was
expecting that an object may appear in the same MIDX chain multiple
times.

Patrick

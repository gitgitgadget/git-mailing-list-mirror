Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063811FC0E6
	for <git@vger.kernel.org>; Mon,  5 May 2025 09:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746438742; cv=none; b=dboAhCAM6ahHdEZz1wGL+hwQa5pDr1phywpUYBlDFTwdzwgnDkrIkhJBHqPH6xaSeR7oMNjsSxP2xMX5Mcsmc+YX9i2wq3RmwSszaZKAGQV6cSs96MEmit5Pr2c+OE18JVEY2s5PXYOtxCxLJKfIdVY+cKnvy7BltrzeSvaiI+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746438742; c=relaxed/simple;
	bh=nFvLw68aMzEzjAYOBYQAv6KTgbiqAQdDW/Asj3A7uEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=un4GZYgTdS7qvqkW8vsB9J/HBfvUmWIMryoO/9UZ5Se83jkk4jTWPqLLy6sm36HJ/naWQf+3/cTDZ/LENtp5XVaxx3oojp29FyW49H+9Sd7jJk4gkLaAY1Yy0jc9of93swvQ+h/Qy5n6LMrOGv7+TViF3YCwbxPSsYTk/YCjhn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hwnU6R4F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WSzlJOi/; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hwnU6R4F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WSzlJOi/"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 039D81140186;
	Mon,  5 May 2025 05:52:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 05 May 2025 05:52:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1746438739; x=1746525139; bh=0KA+yxVAxr
	oZge0XW690oB3KGIkA1i4mhQbNmNBdKTI=; b=hwnU6R4F8na2Vp0mtnc8Ugw2NA
	RaYhui4ev1DW90K9rgR20L1AwoUqHB02CNXNewLcuxGrcO+U1+BK5FOhNWAS1o7q
	ClkInAWRt8VLmJWbDQe72S7br3arE4I9WAdHktFgPPE25esJAZ/p1gpPXKCv7tUA
	HMdEHfoTx4OOLCyOF4gDfmgov4uCEYlUg2jH+49i5AOeybCsmolU/PTUrUNBEVNU
	yfVkptktNrtFG5sOqnxxk6QVTgZH6avfH+EEI1GiK7YZ1fcWTxB2DH4j0NjUE63J
	m9/7fn0b56BTz+f3bF3mF7MEe8eAwAbH6Ed9kFnvXyOnBTuiH3LF/D8I5bwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746438739; x=1746525139; bh=0KA+yxVAxroZge0XW690oB3KGIkA1i4mhQb
	NmNBdKTI=; b=WSzlJOi/W3/P83mAbiipI+Fvk7K0+gIVIz9XvHGHVXNhmwaY4LU
	L24SvBEvneUCj3ONvw8X1EZTYESEJdv/1EH/TD1cXozcU21fY4duog4lVlvA454K
	KYyD26gxvCNWBwI+frtQKnx4Fb6rM5b6jGH7dGU9FcJlDbySkLTJdpyEkS0QjPYx
	0CyBFqHlP1F1du9YMZOOmDyinDclwdaphkaSKI7QOfSijM/faJFyGVyRhq3nwgDi
	XR1TGG2m3+JBks7lgXYv0tpQW+boxGxHyIDjrpAO7XnWC4jVeSMU5gQqtQRgAm5O
	82DSqrkUZpvcjUM++tx2m6FPgjfi2A/PT0w==
X-ME-Sender: <xms:U4oYaBJyL77BXZZhxvpQsb8w0V9825--4r0g0vtOF0qJxqXnwSGg1Q>
    <xme:U4oYaNLZPadFNru-bNDXqIn8M3zSfaIVa4vrn96Cd0YfxgTzPiQuKVr8lgf5Zllx-
    6oRstZF37iaAHEm3Q>
X-ME-Received: <xmr:U4oYaJvCAKgPmzltT0FeL00Ng4vQyQIG17IgermGMqk7vnrXJA-3JkGMYUJXSlRy7vWwqKuFteZNMB_Gx5R-64kIckjc-bE51vC4h9I7jG5SpQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkedtjeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekff
    fhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihooh
    guseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepkhhufhhorhhijhhileeksehg
    mhgrihhlrdgtohhm
X-ME-Proxy: <xmx:U4oYaCaK8Uzh_kTko626zjY9ZjMF3dhgzI0-wQvq2ypvx1K0ACtrAg>
    <xmx:U4oYaIa6QVCGjpX7db4iOQfDEXgRUueEGUok1Np6hGs34FqDUR3DHw>
    <xmx:U4oYaGBr_-E4P88wo1qn9BaYLuYG_sY_B8oVDo9eiJz9CQR-w5BF1w>
    <xmx:U4oYaGaJVmMBBt3J6rMPyc_PHKjsCVurDeTrANChge_xKWDRdVqn8Q>
    <xmx:U4oYaE-yotTuf1PhZLGjo5b9ml6k-bLGLE4vo6sw5vwVJpBwPFDwVvYv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 May 2025 05:52:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c8c160e4 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 5 May 2025 09:52:17 +0000 (UTC)
Date: Mon, 5 May 2025 11:52:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Seyi Chamber <kuforiji98@gmail.com>
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 10/10] t/unit-tests: adapt lib-reftable{c,h} helper
 functions to clar
Message-ID: <aBiKUGn7avRUcehV@pks.im>
References: <20250429175302.23724-1-kuforiji98@gmail.com>
 <20250429175302.23724-11-kuforiji98@gmail.com>
 <aBSXJcT8REHWrsrx@pks.im>
 <CAGedMtdRwsBwRK6ENaJfbZ1tba4jD1WMyk3HdFft3sC6H2001w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGedMtdRwsBwRK6ENaJfbZ1tba4jD1WMyk3HdFft3sC6H2001w@mail.gmail.com>

On Mon, May 05, 2025 at 08:27:16AM +0100, Seyi Chamber wrote:
> On Fri, 2 May 2025 at 10:58, Patrick Steinhardt <ps@pks.im> wrote:
> > On Tue, Apr 29, 2025 at 06:53:02PM +0100, Seyi Kuforiji wrote:
> > > diff --git a/t/unit-tests/lib-reftable.h b/t/unit-tests/lib-reftable.h
> > > index e4c360fa7e..2958db5dc0 100644
> > > --- a/t/unit-tests/lib-reftable.h
> > > +++ b/t/unit-tests/lib-reftable.h
> > > @@ -6,12 +6,12 @@
> > >
> > >  struct reftable_buf;
> > >
> > > -void t_reftable_set_hash(uint8_t *p, int i, enum reftable_hash id);
> > > +void cl_reftable_set_hash(uint8_t *p, int i, enum reftable_hash id);
> > >
> > > -struct reftable_writer *t_reftable_strbuf_writer(struct reftable_buf *buf,
> > > +struct reftable_writer *cl_reftable_strbuf_writer(struct reftable_buf *buf,
> > >                                                struct reftable_write_options *opts);
> > >
> > > -void t_reftable_write_to_buf(struct reftable_buf *buf,
> > > +void cl_reftable_write_to_buf(struct reftable_buf *buf,
> > >                            struct reftable_ref_record *refs,
> > >                            size_t nrecords,
> > >                            struct reftable_log_record *logs,
> >
> > It is quite weird that we declare the replacement functions in
> > "unit-test.h" in the first commit only to remove them at a later point.
> > It would make way more sense if we introduced the functions in
> > "t/unit/lib-reftable.{c,h}" right from the start and then only remove
> > the unused functions in the last step.
> >
> > Patrick
> 
> If I get it correctly, you're suggesting I have both the original
> functions and the clar-based variant in `t/unit/lib-reftable.{c,h}`

Yup, exactly.

Patrick

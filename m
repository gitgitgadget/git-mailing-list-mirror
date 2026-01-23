Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C6536404E
	for <git@vger.kernel.org>; Fri, 23 Jan 2026 09:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769161386; cv=none; b=LE2Hivx4hMSQVEmCT7uQLOHhzWghCM4vlwy1VPuNl6JRqYKTFBrT1VLLC2GYsZ2bYklLWWLOX9QN/C3JwQ9u3UNkIDc8nUeZxmrYVCG2asxYrGVO3WWeuotyL15z/UhmyQqlDklvPcPSn9nPIfToGM2Pf76ljiP9pq6/ROpqrws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769161386; c=relaxed/simple;
	bh=5m0oq5trh4V3+r+Tpwv3D8ORp4acq1FrLNDpNIFLqvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QGUbvBk9QzTGB22Ex62qgnp8YzDlCJe3VVsg05z9L2D1ReqeJl0Oge5AmXzUusZ3dRQVGzOHJ7Qr7OXK8SU97cE2HcCFLSaAr173g++iXuF/St5kKaddh69FtlWuChoFjTGllLficA6xHCKtXC3x7ws0PpxjPfFrmRMX5TsbLZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JgvOY295; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iY5Bn1rN; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JgvOY295";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iY5Bn1rN"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C18C97A00EB;
	Fri, 23 Jan 2026 04:42:55 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 23 Jan 2026 04:42:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1769161375; x=1769247775; bh=S54XEpDg3D
	n/2fwvM/dKkTyBi0dABMDOIg4//6yZoxg=; b=JgvOY295ABs8cirXhCnODckd0I
	aRDFDxMoh8k6Hf9RF3GEcsZ/h9uJ1GRuG1IQnUXXZaTBk9juk5AOTfid6Zvjl6ho
	9hmmcRtGm71jOKr9YPcOOsVK6oHwArBJnv8pOg7GlrJ4lW2SaUR3tqA1sRLO+7ut
	mDY49ZrqbaEWEu4qdcHsNJrjnrX4xQUPF+Eq/ghVHeQ37ZtdJ86Gil68zg+qGdQM
	WkZ5+w1Esg3awlhhrZfZJA+by/xNJ6GZhQJLqll3zG4lHOz74zRQg3DqV/FLq4g2
	MIVP8zJqRZqrnVtTLVP6UT9I+LJR5Jxb2UGyXU1VBSwEkT6oei57aD067Y3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769161375; x=1769247775; bh=S54XEpDg3Dn/2fwvM/dKkTyBi0dABMDOIg4
	//6yZoxg=; b=iY5Bn1rNMrlSIig2+DXzH9r7jLbzWve5QwbkCs1YAyQgMvd/XDS
	5IPdOGzIGLrcQQdZNwwg73O3n+Q4MKGEr//hzRBdjTTuMJiTpiYtt/dvTXqQqtsc
	nLcnROFxW0KzYj8KZBRFzbpSl4RBuVC0mmNamU6absbcoAt0F7GnUfigoUzWatd+
	/whwVdaIwsR+iKrX7HkquFz+lQ7OepkL3YPW/r1wwVv6Wldj+BiQnPGh9NNCHJrF
	ETVoOtZ3OO1FrG+HI6VKKl+O6/5/gB+62uU4Ku6nHDk8pgksDRSXBLBBUOgahR2Y
	d7dQIEYAd8OS+1+VzridupdrR7vc6umixZw==
X-ME-Sender: <xms:n0JzaSkiVFfDb8gp-oA1wUek8n2rzG-y4__tnN7_c8zc2HpyN7P13w>
    <xme:n0JzaQtIfOyJ27nYQ7LLYxs1UNymGXnF8_dpkLdiU4h6g-xtvhKP7X6tzPPBPVZ3B
    f2JybEHA3jxMl9S0-I9bqOeaVybvA_zVfQUu4B_UajMaH0rzGR03A>
X-ME-Received: <xmr:n0JzaY8h2_Al3u0NpKRJ20m-2rEyMkpDaMDyJxEC_RQWjWg3sl-NQwhG6qRgn3M2LyWy1k-3X7aXs3WIL2W7P0TFgNdlk5vsF3h6m1m_GCVv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeekjeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:n0JzaSPu6OTLeq-prxOu2XcIdSeNS_B9V5vE9AwuQO_Q401ZKRCBqA>
    <xmx:n0JzaeGTetRpj6JOFQu2OlQn4jZEvxb1EwZ25oviRtwPJOnoFUnI0g>
    <xmx:n0JzaYR2dQ7jLglo9o3hV7cUxQeqgqDT22YAOG0xwv35t-3fOJ0YRA>
    <xmx:n0JzaTtWZ8CQYjTHXTFEHwtAHjcbgiRuaDt17jdGyZPauW-xcqCgaA>
    <xmx:n0JzaQDT_gsOOgIlP629l231mQ4lbnGs9bzhS_gprXE3qjnBGyZNKSh5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Jan 2026 04:42:54 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fdfc054e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 23 Jan 2026 09:42:53 +0000 (UTC)
Date: Fri, 23 Jan 2026 10:42:50 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 08/14] builtin/fsck: refactor to use
 `odb_for_each_object()`
Message-ID: <aXNCmnDysVmrMVJ-@pks.im>
References: <20260121-pks-odb-for-each-object-v3-0-12c4dfd24227@pks.im>
 <20260121-pks-odb-for-each-object-v3-8-12c4dfd24227@pks.im>
 <aXLBoFnqbnCcylCD@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXLBoFnqbnCcylCD@nand.local>

On Thu, Jan 22, 2026 at 07:32:32PM -0500, Taylor Blau wrote:
> On Wed, Jan 21, 2026 at 01:50:24PM +0100, Patrick Steinhardt wrote:
> > diff --git a/builtin/fsck.c b/builtin/fsck.c
> > index 4979bc795e..96107695ae 100644
> > --- a/builtin/fsck.c
> > +++ b/builtin/fsck.c
> > @@ -218,15 +218,17 @@ static int mark_used(struct object *obj, enum object_type type UNUSED,
> >  	return 0;
> >  }
> >
> > -static void mark_unreachable_referents(const struct object_id *oid)
> > +static int mark_unreachable_referents(const struct object_id *oid,
> > +				      struct object_info *io UNUSED,
> 
> s/io/oi/ ?

Well spotted.

> > +				      void *data UNUSED)
> >  {
> 
> The transformation here makes sense (and I think aloud through the
> similar mark_object_for_connectivity() transformation below). One
> thought that I had while reading, though, was how this function behaves
> when it is passed the same object more than once, since you mention that
> as a possibility in the commit which introduces odb_for_each_object().
> 
> I think that this is OK, since we already likely send the same object to
> this function multiple times if, e.g., we freshened an object from the
> cruft pack, in which case we'd see it both when iterating packed
> objects as well as when iterating loose ones.
> 
> As far as I can tell, that's OK, but it might be nice to provide a brief
> analysis of that in the commit message, just to be sure and to help
> future readers.

Fair point, will mention.

Patrick

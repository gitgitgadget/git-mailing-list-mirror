Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE13E34AB1D
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 08:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765872773; cv=none; b=sxEHEX/f3AzIFmYTPfh+9W6SzeyoD/fCyMPML8LAmWgZHRG4z1N3tn1CE7IkmYXnpMxzWgAg3ao70qdSi6g0or6KFFERIEVR3mMmVlASA2J3ez3v1lWYOAh9ytUph6Vx87Wtu0YqJitnNuoR2a8+OLzk6EHMYFlL8o9Edh7M1oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765872773; c=relaxed/simple;
	bh=aw6J1IyAgOlNhVLkUkfV23ldcUgt4cNRCmjI0eV4L2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ekjbn7RH/vNU7YCv1XBfP1gUdtSKbZR9sDPxPhdmE4lRS5Trx2vXbDwrPnDE/F8aAiXmKeGeWZbvSvNgs7DX3NTOVrTOOJuUq+VcaZfkngXYXenCX0EKpM/xJaXazdqsmVVoEE78dBgv4uXh8NVxcChqMrQdhQqAa0ZW5dLKR4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dIHHH4hJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Mc56ogM7; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dIHHH4hJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Mc56ogM7"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F35AD7A01F1;
	Tue, 16 Dec 2025 03:12:50 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Tue, 16 Dec 2025 03:12:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1765872770; x=1765959170; bh=igd+69czug
	Q3+qAieuCLohKNkMpKwkfXjRjVDZdW1Jw=; b=dIHHH4hJVOzk6SAC1k/vN61rgu
	8Q2HkVZP+UH6X6SxenuPvMkV1JyQW30y0jBady3Jd75NUacSsOvCOryjWH9z4huA
	il4gKNOaIJB/3qp9HxQoIpGjaWOsx6QqZzEbnrrEczRUBo/86UaBCYj8Jp1CDol+
	Vj+Sg7vY14SLlcuH22Yp4xwAZrHtWTxVziUyR/vJU2ocz+wMbicjBnXo8Qw+vIos
	dtN1Ylsz0RRvbJJQoSBYbprPlGv9JyJxVlPhr4NVEprm06HlHM/G95ZB+4gf+fWP
	0DiQk81BgOM2zg0b0brmg6LzsADWXTmNBXiOdJQXbqnDa/Ea+AaahsEC5jmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765872770; x=1765959170; bh=igd+69czugQ3+qAieuCLohKNkMpKwkfXjRj
	VDZdW1Jw=; b=Mc56ogM7ePWiu4yfHJgGFQVwD0mEfr270XH1aleX+Cuy9B54LXF
	WBjO/F9QzBVJL5apihvyW/Jc11ovSh/8RatqknUBkOpYo/q0URK+D65f7Ld9ZtHE
	yfpJjQQ3FlN2Q78GlI0fOWDn+nAaTUDQy/UA8QyfXCz6yQL91jA7tPvtC3rxpFZR
	zc8nby45kGk0JKAi5yq7SL1ke4BrMIttPWVB79VnOmJ9YdI2S1kj5vpkgsA9W6Xz
	mOIZm/DGRNPPd61rlP6LGztOr5lijePrOl4rkiDGpByG6CqybVbk+BPl35rK3TpE
	xhliNnYKrFnMXvdYAAyesMpE2DojjXtlJtA==
X-ME-Sender: <xms:ghRBadVJ1iKfUNaPqKgE5CQM0vrwcEK7Hj5KDq0-hWrllNbhSjNETw>
    <xme:ghRBaVDFwNOiDvZvnCE03-yET5hHStQo2AdyLyt66_KDFL9VB_YFzD0hp0uJ4fs4W
    oqkekrPeEx8_Uf3NXPpfD-ZOyp2Vl6syhEzcdgmwY1BS6o__PSL>
X-ME-Received: <xmr:ghRBaWzrl9RfvvshS1SkDPim_NdLsiikV4ovWR0ZL-5asDTIQYTvrI336cJA90xPN9ARjm5ui8JqIxWrbvmI7QfIzAZNRil9WMmhU0wg0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefledujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:ghRBaaDIjJqHejMAgxDTzdmCDJ6SMNdLV_zGC3f-D3pyghr8I8J6Tw>
    <xmx:ghRBabanEmj78dscKKQqUtzXbkgV50WxaTmg__rQcTjfdiib-32q6A>
    <xmx:ghRBaaht-IyycVgt62DvY3LjH8kcLTs2iPZFvffOH-mZFPTKi2aPeA>
    <xmx:ghRBaV6q_mxoWhrDQC_h8jscg2qQqntlicLdQ1H_24q8dMODzcMv9g>
    <xmx:ghRBaZAzTN2ImKXRJo8cS1LDr0M5HL2aCR4OR72QZj10FI5gvIBGrAxD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Dec 2025 03:12:50 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 75878fb3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 16 Dec 2025 08:12:49 +0000 (UTC)
Date: Tue, 16 Dec 2025 09:12:45 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] docs: clarify git-rev-list(1) --filter behavior
Message-ID: <aUEUfQDJyPf6Mhtw@pks.im>
References: <20251215200512.2694155-1-jltobler@gmail.com>
 <xmqqwm2n5ivh.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwm2n5ivh.fsf@gitster.g>

On Tue, Dec 16, 2025 at 10:13:22AM +0900, Junio C Hamano wrote:
> > diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
> > index d9665d82c8..453ec59057 100644
> > --- a/Documentation/rev-list-options.adoc
> > +++ b/Documentation/rev-list-options.adoc
> > @@ -983,7 +983,9 @@ to name units in KiB, MiB, or GiB.  For example, `blob:limit=1k`
> >  is the same as 'blob:limit=1024'.
> >  +
> >  The form `--filter=object:type=(tag|commit|tree|blob)` omits all objects
> > -which are not of the requested type.
> > +which are not of the requested type. Note that explicitly provided objects
> > +ignore filters and are always printed unless `--filter-provided-objects` is
> > +also specified.
> 
> The above documents the status quo correctly, so let's queue, but it
> is unfortunate that we need an extra option to do this.

True. I didn't feel comfortable to change the default to also filter
provided objects when I discovered that we don't, hence the new option.
It's not great though as it certainly is surprising behaviour, but I'm
not sure whether we can really change it without breaking existing
users. Oh, well...

In any case, the documentation addition is very welcome, thanks!

Patrick

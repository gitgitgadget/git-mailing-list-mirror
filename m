Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC5E1D47B4
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 13:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772717022; cv=none; b=fESpGlWDhe8cTfN/uoHziWEZPv6j9nQIL40ia+bxHqOli4qBLoAmL/AEdkDcJ2JEhPjiFUBoNYqKvlYYJnvh6zhBttbz4d7udc6NX7AkqC+buwus+lGTSIEz6OAHU7T5kK+Os9ux2D/BDbzCb5r52jQhSpwo21q4wymBWYE8hoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772717022; c=relaxed/simple;
	bh=71pOs78mzVjKQpqCmjvyEhDueMY3eOMglbyXhzsMITE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B834pflUPXM3NnuG6sLYWESbPYfBJbj/K6SuVt9FovbMqhd9IO/kYH3pZMCG+JElssSl2eScpq0glvvYuo9nm6+0cSivQvW480wJH3Fw6nQtzBNIGoiam+lUcBY4BI3cv2RxzAVDNKE4VntqJIqnvxrlb1vmjukU4J530/qSc+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=joYMUqFO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FbUwy6yT; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="joYMUqFO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FbUwy6yT"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 911257A0161;
	Thu,  5 Mar 2026 08:23:40 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 05 Mar 2026 08:23:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1772717020; x=1772803420; bh=1le/NpCffb
	pMctoG0444SvnNErj+391vs7mkTqqMs5A=; b=joYMUqFOf7Ipo2ykWmBVGxTAnb
	GLhwAzEBgfbgLXd8/y1s9yK4Xsd2m+i6747ubjXZRXE8mw2/QmaHGLxItguSUfS7
	b6eroBo8iCDzW+1AhBuZZoew4zU35Pm5pfkdpWsb2cHI1jTxiSGgS04jD9M86Jci
	yqykzlgubHWdOyKoyqjfzZ28h5PhgYlCVpQcyqYkawZZNhxJOBBVcvv9hFOmXBHH
	U9wAPCmICqxdOK6YWoMQZwjM5qpfl3YLM3pguprIcxRidkZfNyfJaVd5eFq4qj6J
	JZDTPC8eO2XT0JY2lMpxWhYwYdJQxbD9qK+O5UrBlLrcUJXvxb6QkDOPxZ+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772717020; x=1772803420; bh=1le/NpCffbpMctoG0444SvnNErj+391vs7m
	kTqqMs5A=; b=FbUwy6yTNb8MHBO/JncVWZTf0PaAJ6VLlsBPs9TMc31KG441m7I
	Ek3BFvhUbQwz+W6ENnHLI8D6RwmuzqfrQUHqh651/rog5JjcLfV4LF0y1vLCUO6E
	ggUcc/dIeTe1xVPH6opxOY3YGgfpB1PHRLSqu3miL5/vflebEEzstouYK0cAVTXQ
	ZIFWYy22FsR+7q+rGO7BN/AxDasco4kB0OJuo/cnOvTirXMVuPQsBOvu47ibAdB/
	5KmEQwodfvfiF4e2bKCOqOVnvxQp5psL1iKxAYCIWineROjiyQ+f7v9cOCjyGWit
	EXDih6tnj4g4zP+IG0iHaMuYY4nyb0F9tkw==
X-ME-Sender: <xms:3IOpacUYc_fxxe4ztIRYVuoXBOFmpydfs7GvR4mXKp5M-x229zmYZA>
    <xme:3IOpaWkpckgtuPNbuAS_bduXnlqVWhofcx_jyYhFYbz8OyqY3qjH9ep8rDpH4aHwF
    4SH8M5Vftk7_kH7_VYWuOHfeouYnxhjJJHHZqV0ia_BYJzv9aw>
X-ME-Received: <xmr:3IOpaeDt5NjH4p5tSAZRYBQoVqbETU3w8Ckq1__LzI8nY20P6gI9aXGA5JsbJi3K6GBURHM73WSLi0jJAFElQTpEfaCRonWJp_fiYA7sdsQC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieeigeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslh
    gvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:3IOpaWfRirmdyzF3a6OuNfFvdAcehT_fcrBUYCOF43FoMh_OMadbIQ>
    <xmx:3IOpaZIw-P6V8UXqqIEHhCBu1-gJrW4PdbA9SJ_sRQxoAp_EQfD5fA>
    <xmx:3IOpaZfFf4vsPmshflnTW99fQilrSWVcYNyp1_3eFd0yaoCDrI0Snw>
    <xmx:3IOpaQ1-tSVVHOBBu7P6KcLIHhw66X4y5bd8zWTgxWWd8nU_PcVi6A>
    <xmx:3IOpaRFY5_J9Yckn9ZxnBG-i26iK5i7LctudL2R-a0qLqy6zKWjXOoX3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Mar 2026 08:23:39 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 919d475f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Mar 2026 13:23:38 +0000 (UTC)
Date: Thu, 5 Mar 2026 14:23:35 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 07/17] odb/source: make `reprepare()` function pluggable
Message-ID: <aamD1y5Dw1Oypg1n@pks.im>
References: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im>
 <20260223-b4-pks-odb-source-pluggable-v1-7-253bac1db598@pks.im>
 <aaiei2ZN37i0Xkf8@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaiei2ZN37i0Xkf8@denethor>

On Wed, Mar 04, 2026 at 03:08:16PM -0600, Justin Tobler wrote:
> On 26/02/23 05:17PM, Patrick Steinhardt wrote:
> > Introduce a new callback function in `struct odb_source` to make the
> > function pluggable.
> > 
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> [snip]
> > diff --git a/odb/source.h b/odb/source.h
> > index f84da59ef0..2f8132f9e1 100644
> > --- a/odb/source.h
> > +++ b/odb/source.h
> > @@ -58,6 +58,13 @@ struct odb_source {
> >  	 * all associated resources. The function will never be called with a NULL pointer.
> >  	 */
> >  	void (*free)(struct odb_source *source);
> > +
> > +	/*
> > +	 * This callback is expected to clear underlying caches of the object
> > +	 * database source. The function is called when the repository has for
> > +	 * example just been repacked so that new objects will become visible.
> > +	 */
> > +	void (*reprepare)(struct odb_source *source);
> 
> Naive question: does repreparing a source still make sense outside of
> the "files" ODB source? I almost sounds like it should be an internal
> detail of the source when reading objects.

Ideally it would be, and I agree that repreparing is a detail that we
should in the best case never have to handle. In fact, I have plans to
eventually refactor this to a `prepare()` function as we have some sites
that want to ensure that the backends have been loaded before doing any
operation.

In that case, we'd likely add a `force` flag or something like that to
cover the repreparing use case. But ideally I agree with you that such
uses should be reduced over time.

Patrick

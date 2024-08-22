Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E457516EB65
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 08:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724314798; cv=none; b=ILjUqTM22iDAbY+N+4F7KZuvpjZU9h/02OxlVbKnjU3k1gW8mkas9w+h937QOi1D0W1ujwHkYWs4KXpXJRcUiMM6jkxxWYwZNFW9KMhfb+9/qZuO+W9f2XvHTGgzCGVGfF/wQlCcescpXfuB6FgCONfx6oLXlpEBsWx1UBJzkRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724314798; c=relaxed/simple;
	bh=UQg1LrxWCy6CqJFMbzWGeO+YFuNjCEx3NUQrtkg8pdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YxO5vu81rBTVyFnoHgg9FhFOpWzDEsJQ9l6ZrqJgAW1/oHsW5fCTED9rF6bSUDdk5kDmVa6kq+BGHFL88HkkFzuye1gCdoxNnvQ6asX72goCyQxeUGC2gsIF0txz8PXRaCLWuArPXaJVsxd+6Y4d4k6Y8vL74y2sjn0IuSQEggs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RiYXqb/X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jV9Pc44C; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RiYXqb/X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jV9Pc44C"
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id D7C7E13900AA;
	Thu, 22 Aug 2024 04:19:55 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 22 Aug 2024 04:19:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724314795; x=1724401195; bh=NcbhmzN6kP
	5/QrZp74nqeF/Y4+0O00F5FFHnbzSE7P0=; b=RiYXqb/XB8GO9WW5iMPXzqxSg7
	kjyVqrJLEsVEhJHUKA0l5fgJE1kR6z0/MfpoGZeQLfPaDwj0skRJdohvCcCaKAcp
	SujCNa5QNv4q7wfRFoIUcAMLDY3WvarspMXfcPa42iST1oo82Bz3f0DgcEUeF2UQ
	+LHprxfK6aYcjS5U+gPVn7FTogr/eaoPIKPmhh7Ut5JpDN3/l9bGax0ERMonuJAS
	rXrWLbiQXFsFxcJCoTBcrEGMtWFGkKMks6jI+wYDXdhJu8JU8k6+lNd/dg4l6Qa/
	fi/EQAoEf+PPk4VuS7jrPIjwY52L/oy44gWWcR1RyVvuEbBaukKCyM9vo1QA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724314795; x=1724401195; bh=NcbhmzN6kP5/QrZp74nqeF/Y4+0O
	00F5FFHnbzSE7P0=; b=jV9Pc44Cv+20+2UQHiZOHrbohQab+dA94Xl5hsVv0Gb5
	RIMlo3hgIl8IzlGTF9OoURNbJCDT9i2YzKlm7PtfL1dG5i2ayZduEGBl0Cp64tZ5
	PsHTEIb42h7yPdbXSo6OJRPpMXssE9DNtO+aLUVDIbt+fY8OuBUh8MtcGhTEA126
	vjvrAsJacUPOEjwzH4/2aDdzOE306Tx5RxiGQolp2zL6yhcvXeqbTxT4O9XFlKr5
	L3OnPStGgRcd+biKLgHA9ncdCYbwmdUezA7tTfjdmdFwT5HS9OJPYYni7B54GkvH
	+XTjbcuDDk50hEaKcGqQxHpZMIrgvR1qmreCMdcO+g==
X-ME-Sender: <xms:q_TGZh4Q0XYr7sEJQ7U3KOb-qANUm2ZyFE1uQfmb2gXXVRaOVKUADA>
    <xme:q_TGZu7sHJNsjMbBRZ5sARK2gK1Z-6_eIsTO4D7u4I2whdYO-Sof2-wFk2wqRNAkD
    kjLolLQX-i-DD41IQ>
X-ME-Received: <xmr:q_TGZocN92a3tXiHb_KLIqa8pSGWALVUHR3P-iyE5fhaFCWvlN3T8JU8hOff1ZTJVKwNpSGogIvW1Mt3i06zAcVd_zEKBK0dikguCTUumYc8Jyk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvtddgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:q_TGZqJ4r5yjBgpqOqS7T4X_L_aR7dIU6nxPNCNYFCl-4z_vL1yMsQ>
    <xmx:q_TGZlKts0rF4U6LtCSIiHPmq__D9M1B8EmCymDYgiGwKdNFYM_6tQ>
    <xmx:q_TGZjwUt6Dotfw7qIDCwFu5JKFYbsCNB1_6j7DrvaA2_umbTOV-HA>
    <xmx:q_TGZhIXDww0uLAF6kTfjAE4BiPYvx4z1PM87VE1llTx-aqjxmNIOw>
    <xmx:q_TGZsVSdPGnlRTB6l9fyRn4Ukh-gnDn2ugw205Efu_DbYoNclbdKCdj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Aug 2024 04:19:54 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fd0802e8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Aug 2024 08:19:20 +0000 (UTC)
Date: Thu, 22 Aug 2024 10:19:53 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 19/20] transport: fix leaking arguments when fetching
 from bundle
Message-ID: <Zsb0qU-G4kdlxrWa@tanuki>
References: <cover.1724159575.git.ps@pks.im>
 <b72f7d1ee394291a018061c91222ea17a99c2e53.1724159575.git.ps@pks.im>
 <xmqqseuxyck4.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqseuxyck4.fsf@gitster.g>

On Wed, Aug 21, 2024 at 11:07:39AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > In `fetch_refs_from_bundle()` we assemble a vector of arguments to pass
> > to `unbundle()`, but never free it. Fix this leak.
> >
> > This memory leak gets hit in t5510, but fixing it isn't sufficient to
> > make the whole test suite pass.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  transport.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/transport.c b/transport.c
> > index f0672fdc505..da639d3bff0 100644
> > --- a/transport.c
> > +++ b/transport.c
> > @@ -189,6 +189,8 @@ static int fetch_refs_from_bundle(struct transport *transport,
> >  		       &extra_index_pack_args,
> >  		       fetch_pack_fsck_objects() ? VERIFY_BUNDLE_FSCK : 0);
> >  	transport->hash_algo = data->header.hash_algo;
> > +
> > +	strvec_clear(&extra_index_pack_args);
> >  	return ret;
> >  }
> 
> Hmph.  unbundle() has this:
> 
> 	if (extra_index_pack_args) {
> 		strvec_pushv(&ip.args, extra_index_pack_args->v);
> 		strvec_clear(extra_index_pack_args);
> 	}
> 
> so while I think this patch would not hurt at all, do we need this
> patch?

Yes we do, because there is an early return in case `verify_bundle()`
fails. I didn't notice that we have it in `unbundle()` though.

> The other caller of unbundle() that passes the extra_index_pack_args
> is cmd_bundle_unbundle() and it does not do anything after it is
> done.

I'd argue it's bad practice to have `unbundle()` clear the caller
provided args for us and somewhat surprising. While one way to fix this
would be to have a common exit path where we always free them. But I'd
much rather make it the responsibility of the caller itself to free
them.

I'll adapt the code in this spirit.

Patrick

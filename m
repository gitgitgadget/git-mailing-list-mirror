Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4121DF986
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 11:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739965939; cv=none; b=cgsCHJ3WvBE9n2HaH2ofp9fPy00muEzBvJksVSjnW1I5BaNDg0mUleVKN8AVzzKFQXN5u4EH5XzbIUNHW2vu9oruvEW401dnw7rzcLq23IuKD6VgvW5T0cUN27HwHhEJm+oFE3STxoNY1TM4dKCY8Lf7FKuTAhtJEPKMxlcEBTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739965939; c=relaxed/simple;
	bh=BdeywDK0gd6L47yQkKTCe7sVuLy1TZTREi3r84q+RA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IvgZ38HDtUe7Yb+B6aNZPhfMr0jQNF+lP4Pw+k4ZKCsGM1MJwJoytPdmrHb2Q3VP8Xponvw+eZMSD4HZmjeSbnIfv79AhJBFYIbjA3T8Ufnmbw61Gp9uApXFA9DJt973B5JW9ktPlOdvWrJ2irsrY3lxnUKEOdAu4Tjunsng/L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iDy5JxuS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MkEj0VbC; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iDy5JxuS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MkEj0VbC"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4F2A31140163;
	Wed, 19 Feb 2025 06:52:14 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 19 Feb 2025 06:52:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1739965934; x=1740052334; bh=kVOIyqg7JC
	/lzj/AJfmMTcDsGr6sJBSS6yHEWirqANg=; b=iDy5JxuSk/EH/8Me2ctN0/vFhy
	fKjrj5ik47jh23eEiLQW5vI7F4RIuLaBQLijLFQsZPdcxA19MjHlVUOZX4vpyoMd
	aKcnfmR2/0VHhoytNnijelsP+Kw6dGiRz+G+nk/VgRcZ9fvO5DJjFaoDDcWVslsn
	5lf5UkSF7nkZDq4IIqiMuX/ovUJUOFy4vCXKXPJIJClMRagdE5lu9f7UPX28wuSf
	oMRyFjzOolkOIXGSF8GPV1ZpsiqgESIohIzPuSjO7TBwIbG13AuIF2zHVQ2EdMnE
	3iacOS8bZaVDybNxAUMEQlOD4CYz6eRztuUTktW01SohTjwPqAjPwvVnz0zQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739965934; x=1740052334; bh=kVOIyqg7JC/lzj/AJfmMTcDsGr6sJBSS6yH
	EWirqANg=; b=MkEj0VbCuSjBOuzsM0zwpTQHQO81O+F+lbcQuStzbHnTRRhmOPJ
	Z1GyNmLsxiXOLK6L7gCu335kt5VzGhuNXuosjoImxkSP/erSuJ8EeQDMpN+f+pU1
	UHsDUqJDSmbvqFucQ25MEAT+cyQ+OOflE+/APr4PwZ7eJWkAI26brxeoR1tvJ75m
	nDBNhhOIw3yLS33kgn+IIfdQg3+v3fqrk12Zgq1EnPprFZ7bOJz7LNeDdQp+3jP/
	b7VpWvc1HZxUoP6/TaKjGVM3SeyRcaNna5fOcJS7hX43PwAYVynKXvwE52cuyub8
	Ki76rr7B51RoSFUCT2X2f+IVNjXlNU8RE0g==
X-ME-Sender: <xms:7cW1ZzOsji2LvVcLXNT9JhWIdIEgDXocmzQWT_wsL7IlpJ-Zk53Hug>
    <xme:7cW1Z98_b9WIdJp2BY7VavK9V2f3rMItOl1GgjAvQq4DPle-g7cgIbO_k30_25Xfg
    reF_b-H1Uu3lIjaKg>
X-ME-Received: <xmr:7cW1ZyTktA7xAh4sXT8O5CS8gz4CQofk5WFiV4FtRf6uY5HeEigVQ363QVWUaFJXQhbthpiUil4DEVYCSdcYhint1YR4Zymk0sWYsGjTYVH3BzU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigedujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhn
    vghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghf
    fhdrnhgvthdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorh
    hg
X-ME-Proxy: <xmx:7cW1Z3vnEJZIZXj1ZD0eC6CN06LJ4K1xgOxmF1ijafMFUhFSMx6oHw>
    <xmx:7cW1Z7fV0mA6_X_2RGXa449O_8qay3Mx7rwVBmS8iq-KMcPnhCaEcw>
    <xmx:7cW1Zz0FYt3PQH3kx0COgdoNF6vaWeHfAzPbBA78q8c9Yv3Ykx0XTA>
    <xmx:7cW1Z3-aSoAAmG00xt0RwyQUIlFf6R7kdzLNzEe7s4F9a9Y9WIDQog>
    <xmx:7sW1ZzSEG4FhUMQeDbttEm1T2NWtD94HMtqr8l1Vd0tAYCI8di7U9KFN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 06:52:12 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 147b9622 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Feb 2025 11:52:12 +0000 (UTC)
Date: Wed, 19 Feb 2025 12:52:11 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 07/14] refs/iterator: separate lifecycle from iteration
Message-ID: <Z7XF6-FbetYl2AXZ@pks.im>
References: <20250217-pks-update-ref-optimization-v1-0-a2b6d87a24af@pks.im>
 <20250217-pks-update-ref-optimization-v1-7-a2b6d87a24af@pks.im>
 <CAOLa=ZQzEwWci350dhhTFiG3WZB67JUB4O9L3coiXeexYGTNZw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQzEwWci350dhhTFiG3WZB67JUB4O9L3coiXeexYGTNZw@mail.gmail.com>

On Tue, Feb 18, 2025 at 09:13:55AM -0800, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/builtin/clone.c b/builtin/clone.c
> > index fd001d800c6..ac3e84b2b18 100644
> > --- a/builtin/clone.c
> > +++ b/builtin/clone.c
> > @@ -426,6 +426,8 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
> >  		strbuf_setlen(src, src_len);
> >  		die(_("failed to iterate over '%s'"), src->buf);
> >  	}
> > +
> > +	dir_iterator_free(iter);
> >  }
> >
> 
> A bit puzzled to see `dir_iterator_*` change here, I'm assuming it's
> linked to the 'files-backend' and perhaps similar to the changes
> mentioned about `ref_iterator_*` in the commit message. Would be nice to
> call out in the commit message too.

Yeah, that's the reason. I've added a note to the commit message.

> > diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> > index a7b6f74b6e3..38a1956d1a8 100644
> > --- a/refs/packed-backend.c
> > +++ b/refs/packed-backend.c
> > @@ -1362,8 +1355,10 @@ static int write_with_updates(struct packed_ref_store *refs,
> >  	 */
> >  	iter = packed_ref_iterator_begin(&refs->base, "", NULL,
> >  					 DO_FOR_EACH_INCLUDE_BROKEN);
> > -	if ((ok = ref_iterator_advance(iter)) != ITER_OK)
> > +	if ((ok = ref_iterator_advance(iter)) != ITER_OK) {
> > +		ref_iterator_free(iter);
> 
> Nit: Since we don't return early here, wouldn't the `ref_iterator_free`
> at the end of the function be sufficient? I think the only early return
> when `iter == NULL` is towards the end of the function, where it might
> be better to add a `goto error`.

Yeah, the code here could definitely be improved with the new semantics.
But I was aiming to keep the required refactoring work at callsites to
the bare minimum, so I'd rather prefer to keep this unchanged.

Patrick

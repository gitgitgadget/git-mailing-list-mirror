Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FB161FEB
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 08:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722501671; cv=none; b=RlLxiY015B2L8OZKggItVsYIt/rNHLNmCIdpGKYQL72lD1GYaLw48qso6TsrxazE6V+9Cf4MjhSS44UxTmSNxsFHP9Q/5mRMNZWvF0rJNhzDkfIgy6Sa6etrYgyX5JIj2tQkYI525QukyAKAIUyw7qTnaH7E/mzAdZ05WPk3Z8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722501671; c=relaxed/simple;
	bh=yp+j4i8uhZMy6bZY9Se4Xfb47JvFalNZFE42qAAvybc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZQ+Xm1cLB1d2E9O/oH6qpP4BXA6D/evnGFl8H16IX+TYwPh7PlC8ibuqYH6XqlEZpyOGuakadJw++bkyZEgrl3mkl5AUM0wbot5RfSBUHhlNF1jeBVxY0PnH1x8+Oh1PturMr57mknNmLFKLq4pk1rGNkWBftlP9H5kaX2GIglA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SUHsw/ZT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=doyqc9ch; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SUHsw/ZT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="doyqc9ch"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 445EB1388035;
	Thu,  1 Aug 2024 04:41:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 01 Aug 2024 04:41:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722501668; x=1722588068; bh=NblKDGlfhO
	VhHNzNC5y74jAXjJecj5WgLUmhnrzJAcs=; b=SUHsw/ZTjRwFpwSIszxZr9+3Wi
	p5DsRSVL6keqa3dKNvWi1AwpQrb5uxnO7dWQkzsRSdqVcNjijM7+ADsKp/rOTfOx
	JKjZdxUxStZQ5btkYNZYvVfHvwZvPNSh/Q5eT2vNL/vwcaXq6SjDm09TQt1gOgt1
	+8wjSREvwV0Ue1kvbrbKK0f4oCq9GWKNhnUp5UWCdS9OEi5rbYcHNxK+LRrHLp1x
	x3x0uUYwgntPzCHOs0L8co8+LlxY/u1ujQA0quHKCXaLZd0BbzDD009UJ0FhHZMK
	8bvtY5IQNKMr4ncQVV9sMRYCtlSNVluL+0BWPtjrpG+OTH63VvT05xRjx7Yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722501668; x=1722588068; bh=NblKDGlfhOVhHNzNC5y74jAXjJec
	j5WgLUmhnrzJAcs=; b=doyqc9chKsf6At4BddJUBEGBGUhIN7si5EpzfJrmM60b
	bZW8gT+1FgbBidT4co8VRmV52S8L/wyLxPPeXelP+BZEDmc4I/+XAVi1MmsAW2yt
	UCbmQPUeCEqQvGE9VO3D9tU0OTCC9eFbJXNIyPOeNq7pS6K2dY/C4bWSY03TKOYP
	e/hftiv/KEwshiKaExZZbp3ANDtPiH8UY+/NCFB6ROIT+QiuxrW9uXSAwU5wgRyn
	2bs0tovqn98UM6pJsluD4V+8ZCb3yWZz+RjaBYN/9WrjIhcgBKNklAyD0EZmcio4
	Ygn3kg4dNYLhAp8M+jJ4EJLPGHt3Cbs9ngxll9pFsw==
X-ME-Sender: <xms:JEqrZpvvdkTi47ZIWcXYtHtowYx2rOJ2E3ps5QOtZIXaMDRq30ZLsw>
    <xme:JEqrZidjw5Y52L31ho80oDfq6vqlqg2cwEHQ0KvrjCRilmuOc3dtLFzxtaGjDYAO2
    dJSUtq3TDtOnz9CPw>
X-ME-Received: <xmr:JEqrZsyZmu16Wn2TkYmwK_Iuygy3KhuJz6DqTlPTc7s0P9jTiY0GMtglYsYC80fJQ5ZJRFeRgaO86-F6tkP4DSe1axcn84VHIkvrHfNsaQm3xg0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeekgddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:JEqrZgMw9AVI2D7ef1NdCauBOHe6ocqqvgCtD5zvFKJknHX-G3Q4YQ>
    <xmx:JEqrZp_nIgW92FgMUBRPzB6pIAZsa23f-0feDrvcWeGxQtxp8gt7YQ>
    <xmx:JEqrZgUVcHWTk02DJDC7GsKD6xX5mcHpR3NiU0FxkP_4QZvyjCltpg>
    <xmx:JEqrZqcC1dz9XZFo05fi2EURU-87uQBauP3iSpS_nxRsCIounnH7Fg>
    <xmx:JEqrZrKpIU91Q02PdW3AROXVCHZVeb3C7OtwEmGSWJ9uSOQ98CNTmoWC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Aug 2024 04:41:07 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 03ccfd5d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Aug 2024 08:39:35 +0000 (UTC)
Date: Thu, 1 Aug 2024 10:41:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 7/8] reftable/stack: fix corruption on concurrent
 compaction
Message-ID: <ZqtKIKW-lqvb00z9@tanuki>
References: <cover.1722435214.git.ps@pks.im>
 <b746565bf0ff80fff60821bdeb79867ad646c142.1722435214.git.ps@pks.im>
 <bkr4qwpgpzl2nffjuz52te3vwmn3gckoahrkynw2zrqrzptwd6@7b776obncdiy>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+uBjHvNFwL0unq21"
Content-Disposition: inline
In-Reply-To: <bkr4qwpgpzl2nffjuz52te3vwmn3gckoahrkynw2zrqrzptwd6@7b776obncdiy>


--+uBjHvNFwL0unq21
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 08:04:17PM -0500, Justin Tobler wrote:
> On 24/07/31 04:15PM, Patrick Steinhardt wrote:
> > But there is a bug in the code. Suppose we have two processes which are
> > compacting two slices of the table. Given that we lock each of the
> > tables before compacting them, we know that the slices must be disjunct
> > from each other. But regardless of that, compaction performed by one
> > process will always impact what the other process needs to write to the
> > "tables.list" file.
>=20
> I'm not quite sure I understand at this point how it is possible for two
> compaction operations to be performed concurrently. Wouldn't there
> always be overlap between the two compaction segments thus causing one
> of the operations to be unable to acquire all of the required locks and
> abort?

In practice we cannot assume anything about how another process compacts
tables. While we can assume something about how a particular version of
Git compacts tables, we cannot assume anything about future versions of
Git or about alternate implementations of Git. The reftable backend
allows for compacting only a subset of tables, and the heuristic is not
mandated by the on-disk format except that the tables that we are about
to compact need to be next to each other in the stack.

Furthermore, with the next patch, we also handle it gracefully when some
parts of the stack are locked already. Thus, it can easily happen that
process A compacts tables 1 to 3, whereas process B will try to compact
tables 1 to 5, fail to acquire the lock for table 3, and then reduce the
range to compact to 3 to 5.

> > changed after we have locked it for the second time in (5). This has the
> > consequence that we will always commit the old, cached in-core tables to
> > disk without paying to respect what the other process has written. This
> > scenario would then lead to data loss and corruption.
>=20
> If a concurrent compaction happens though, it would mess up the indices
> and cause problems when writting the "tables.list" file. That would not
> be good.

Yup.

> > This can even happen in the simpler case of one compacting process and
> > one writing process. The newly-appended table by the writing process
> > would get discarded by the compacting process because it never sees the
> > new table.
>=20
> This is indeed a problem. Since we don't reload the stack, we are
> unaware of any concurrently append tables causing them to not be
> written in the new "tables.list" file. Scary

Indeed.

> > +		/*
> > +		 * We have found the new range that we want to replace, so
> > +		 * let's update the range of tables that we want to replace.
> > +		 */
> > +		last_to_replace =3D last + (new_offset - first);
> > +		first_to_replace =3D new_offset;
> > +	} else {
> > +		REFTABLE_CALLOC_ARRAY(names, st->merged->stack_len + 1);
>=20
> I was confused at first by the `stack_len` + 1. The extra element is
> NULL which tells us there are no more tables to add to the list,
> correct? It looks like `fd_read_lines()` also adds an extra element.

Yes, that's the reason why we have it. We end up passing `names` to
`free_names()`, which uses `NULL` as a sentinel value to know when to
stop iterating over the array's entries.

I'll add a comment.

Thanks for your review. I'll wait a bit longer before sending out
another version of this patch series to wait for some more feedback.

Patrick

--+uBjHvNFwL0unq21
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmarSh8ACgkQVbJhu7ck
PpSO5A//eLCwRcCj9RaOXogMQcWsP48j2IAgezxldqUKRjRJ9AQSCuwFRMoTOTk1
rSbRJAHKCKd/u45UOxvTV+vhWuLsJL8DuGIaPZdmHYP7DA4ByzIM2za9183ta6xC
hguXTjxZL+sFtJqW3oAHWEy6KVLHQx8Pb9Ene0VwbyYsGdf2TuN1Z7IE8qxfbco7
aNfgx2FbUZ1oEIPCVm8+/yNoMzlrhbQcDSmTr8uR3u8URKM8mRDUw0MGt03/cVYb
+yYq9CiXR3vHbc70ce65JP2v+va/6yeEsKTeYQxv5kZ33xivPbPVfLVnqjOmIIag
ftplUjdXfBCfueTo8ES3mE+E9dpeDZnf0W6bDuwKNzix/7W75qnw31esWNnuNsbM
4IhB/PW5pN33UDcPnxEv25NSe1msHLZvXtQt2t3upxtUZMr4xnypx31j36r0wATe
XuUNWMXXh1QW9exTOiM4tlTaGy3szUaIW5J5kOD6BCoFagIKAorEbMRFN0rhWL1f
+1NRw9OcY8TEcj1dF0Dc8SwnaU7KjygN5khAvVeNuz5ZXDfcN59C3kwXfPRu3t3E
s9VIH6Pcq+e/EgtK81L4gUnvVtjBFE943DR83e2fhPMOs6fTumCiIrw+xFhHCKzo
T8E7AGlMZ9wSQ3ozdwX8OMO4idBdNji90BHqB9xbhSyG28r8m+w=
=eBg6
-----END PGP SIGNATURE-----

--+uBjHvNFwL0unq21--

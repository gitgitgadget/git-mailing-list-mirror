Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6693CF72
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 07:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712042629; cv=none; b=rMo6gqNxceI/9Yaac3tqb/DO6tyx0A0q08EK/16oudqXe5y0MsKxWiHdWlWwRD9kfz3EeZKwzzpO3OVjCnhciCBsT/PBFEZlieTnBG9OpUVbtbzKIEiuRu7NJPo4nubXiup3622BSijTVBMycpoprppaBWoTYbZHyvf3PNFS34k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712042629; c=relaxed/simple;
	bh=gQnLwSJMm5JSzPe1TfJz5HJNp8a1Kw932DWye10soek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hkWWiRghw2JbR/uBJaOQFPxZYHWFxykfjCZlu2ctFqr2mPmKYxJjA0Jc8JIILTbsDgtpET8XDhbRYsGmmclha6/deBM28MrMzT8+wuLPVtt9Jpkzf/ucSs5WC8cTlbs2vOYnzqxBhGyc1yf+Hc0i3hCPwEhdVYEoZN9uAGbeXaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=J0u0lLJy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xSwE0G7+; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="J0u0lLJy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xSwE0G7+"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id B4A1C1800098;
	Tue,  2 Apr 2024 03:23:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 02 Apr 2024 03:23:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712042626; x=1712129026; bh=4VY14CyevR
	86cYFY31h+cO8xeYrorUy3oHOEcgYqiYU=; b=J0u0lLJyf+PWu+JfViOS58uLgy
	vCfAapzpYRUlT0LV4JSvq2C4QA5z7su/mPBL9lJH4AhCxaS9On2Q2HN4rQH3yGBI
	wE97fS/cj0yVln/PyzbwmfxTi26nif4fBrTAnLa7wtae5oD1jp2xPxeW/OUEIQ3L
	JCjLL9eyopz6H8KEjcCDc83gxd7hviV6WcLSxRN+ttBqs240XbQHymP49RetzSAx
	MBERbZ2oNczWUmo4tA+L+cmW5NLK9rqHqLJ+k0KmIYjc0rAn0dI+TxmbAkXA9uMg
	YXbseYc+wxv5zQ3bGiEFKzCxalpj2Lb5x69uhCeEUC0zeFaB/pJ0mw83ZW7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712042626; x=1712129026; bh=4VY14CyevR86cYFY31h+cO8xeYro
	rUy3oHOEcgYqiYU=; b=xSwE0G7+URvqIOjyTt1yiPXsKzRRqQPdDXERnY0/arHM
	byD8yLQooCEz1nnTiiqXwYbeAZKVUD85Pejw6D1n2UyXDKj0JipF9vy9LPoTngZW
	SPdpp1SZFzAE4IyyH1+VAOFPSgTVjqkn0JwR5AFP3Q/QKb44xfgu5DC45CH8yDGf
	9cMS/MzsUu4uL58INwhh4fGXipm/0iKPeSnzpA9EHUcz2mZyszmVU7p1+R1LbHaf
	NPBU2dCrbM6xtjapsfiBi2fd+BLK/1kJiOzeYRr+hV8jmY1fo96Z4KWqW1MsrcfF
	P8G2OwciY0YLmwvyP27GI9+cdtdM6IpncDjUrDEXow==
X-ME-Sender: <xms:grILZh0y2l71gptjK65AP6icug5KIy8kTyNZ99BCX05DNfCtE-TW6A>
    <xme:grILZoGAnwxfcyCqLRQUIi6jCZCyf1CRWc9jF2zrrw3vNmJaPY9i9GUJbATap21DA
    u8MVdGMF52YgpSzQw>
X-ME-Received: <xmr:grILZh71qfkeRkeX0nP0NPfnqg5q3qyJGoiNHWofVzA9ZbW6wlx3l0k6BZXJNbKc79WcI2PVz1VVVCFhwN-ageWa1ywaUR7l_lDr38Zq2nowaaw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefuddguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:grILZu29IUBgB0Y6ckwo6eoD9zFMsAirLR57cx16mlXds0n3zPVdnA>
    <xmx:grILZkGQwHcmHK7TtzoGuP9C-r2kkVjROld1DUOHMf1haYA9vANkzg>
    <xmx:grILZv9tatk5gACGgH_4WbZTEMEqlAYhxeprrdvTU3KCiXnESCNFRg>
    <xmx:grILZhmB1SxSXNXvWttGwREJKYanyZY6OqSbsLlYjo3itEjyg_uO1Q>
    <xmx:grILZp5YXAomVjVVzBxSJLTI1VQSvHBS2eMuwww72GTIrv_LU8tZ6Gp->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Apr 2024 03:23:44 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bdaf97a5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 2 Apr 2024 07:23:34 +0000 (UTC)
Date: Tue, 2 Apr 2024 09:23:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Justin Tobler via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v3 3/3] reftable/stack: make segment end inclusive
Message-ID: <ZguyfEN4dLGU_YkS@tanuki>
References: <pull.1683.v2.git.1711060819.gitgitgadget@gmail.com>
 <pull.1683.v3.git.1711685809.gitgitgadget@gmail.com>
 <9a33914c852a0487dbd90c83f53fa0e36414fda1.1711685809.git.gitgitgadget@gmail.com>
 <xmqqsf08yjf2.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="I0gGcUx5ggyVld2e"
Content-Disposition: inline
In-Reply-To: <xmqqsf08yjf2.fsf@gitster.g>


--I0gGcUx5ggyVld2e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 11:36:33AM -0700, Junio C Hamano wrote:
> "Justin Tobler via GitGitGadget" <gitgitgadget@gmail.com> writes:
>=20
> > From: Justin Tobler <jltobler@gmail.com>
> >
> > For a reftable segment, the start of the range is inclusive and the end
> > is exclusive. In practice we increment the end when creating the
> > compaction segment only to decrement the segment end when using it.
> >
> > Simplify by making the segment end inclusive. The corresponding test,
> > `test_suggest_compaction_segment()`, is updated to show that the segment
> > end is now inclusive.
> >
> > Signed-off-by: Justin Tobler <jltobler@gmail.com>
> > ---
> >  reftable/stack.c      | 4 ++--
> >  reftable/stack_test.c | 2 +-
> >  2 files changed, 3 insertions(+), 3 deletions(-)
>=20
> I'd defer it to Patrick (and Han-Wen, if he wants to comment on it),
> but isn't it a natural expectation shared among CS folks that it is
> the most usual way to express a range to use inclusive lower-end and
> exclusive upper-end? =20
>=20
> After all, that is how an array works, i.e. msg[n] is NULL and
> beyond the end where n =3D=3D strlen(msg).
>=20
> So, I dunno.

I don't really have a strong opinion here, to be honest. I think the
previous way to handle this was fine, the new way is okay, too. Which
may indicate that we can just drop this patch to avoid needless churn
unless somebody feels strongly about this.

Patrick

> > diff --git a/reftable/stack.c b/reftable/stack.c
> > index e7b9a1de5a4..0973c47dd92 100644
> > --- a/reftable/stack.c
> > +++ b/reftable/stack.c
> > @@ -1237,7 +1237,7 @@ struct segment suggest_compaction_segment(uint64_=
t *sizes, size_t n)
> >  	 */
> >  	for (i =3D n - 1; i > 0; i--) {
> >  		if (sizes[i - 1] < sizes[i] * 2) {
> > -			seg.end =3D i + 1;
> > +			seg.end =3D i;
> >  			bytes =3D sizes[i];
> >  			break;
> >  		}
>=20
>=20
>=20
> > @@ -1291,7 +1291,7 @@ int reftable_stack_auto_compact(struct reftable_s=
tack *st)
> >  		suggest_compaction_segment(sizes, st->merged->stack_len);
> >  	reftable_free(sizes);
> >  	if (segment_size(&seg) > 0)
> > -		return stack_compact_range_stats(st, seg.start, seg.end - 1,
> > +		return stack_compact_range_stats(st, seg.start, seg.end,
> >  						 NULL);
> > =20
> >  	return 0;
> > diff --git a/reftable/stack_test.c b/reftable/stack_test.c
> > index 21541742fe5..4d7305623a0 100644
> > --- a/reftable/stack_test.c
> > +++ b/reftable/stack_test.c
> > @@ -723,7 +723,7 @@ static void test_suggest_compaction_segment(void)
> >  	struct segment min =3D
> >  		suggest_compaction_segment(sizes, ARRAY_SIZE(sizes));
> >  	EXPECT(min.start =3D=3D 1);
> > -	EXPECT(min.end =3D=3D 10);
> > +	EXPECT(min.end =3D=3D 9);
> >  }
> > =20
> >  static void test_suggest_compaction_segment_nothing(void)

--I0gGcUx5ggyVld2e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYLsnsACgkQVbJhu7ck
PpT7mw/+MqjrbIKKjWFlo6qYe0+akqQpq1aRXwY4OxOYOfu9cOFYKJLsKpMxq1hI
KnoE2/4Ywh1ZxOYhBLEhCxmBKrUsvy3M7NXH+o9iY0hEuzqPD3/4NmxblhYUQYZ/
bkjch9eveOJGRy2UsVJwDniz+po9iO7b9Rbr2lFOv71FPlyVtDW8b4oGrpHokDTI
70z0UKpAM75143w6a2dZU4bqM9TQif2vjGL5MQsrvUS7iZUCWW/2rvfe4LAay1Dr
c3lQcZ8vt6FdRKfeSkmCQrfuE8ja5QroG24nXnT/VbL1rlkODxmEmasc69p9TaIN
gcV9Vt5vlIUNl4UqnxO7Q+G2JX1JIiw960o52itvdwO1YIwd3LQnU1xUak3mXmuC
iF/+P/Q1TJHkVM7/agXOWFeqI1jWg3paBHLJvYQbExCD3/6z5fwpk0t+/VEmey90
0QCvxCBwUY5R6V43UiJ784yweJpmn1uCKwHVb1/KgaSjnHPO4ycQjueJ9pPaM5a5
g0p+b6vkVj+WVYQVG8xoshhNqKGU5fqGv0Lw8ESBGUrl045Y2DYw08eqqOycbfqE
5nBMlLTmiLFAeTGgnJGHtwinXlhn06tYsz4nJ0LLMhbQzZOkTZI/RAmYZBTQKE5s
Avzd9xWphSlnuqRzXk74bbWgYYLC0CNZc/Dyn7xznNla3qeu8po=
=yy6/
-----END PGP SIGNATURE-----

--I0gGcUx5ggyVld2e--

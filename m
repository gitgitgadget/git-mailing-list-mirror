Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93274F9CC
	for <git@vger.kernel.org>; Tue, 14 May 2024 06:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715668431; cv=none; b=eVPrhhEdvYkCjEG9ibz0Zdw0ZVTqb4lPTb/H3ScWbAmVdpoYKJ8xz9TQEN9fhC+oHBaF9AwNTu81cGsqmM9XZP7S4GZ88D29greebvuI6zTHtDC4pwgRArl6opyumnCnZgUOotyIPOt+A++tbx/mC8jCjShwAU6nin1C2/wQ8Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715668431; c=relaxed/simple;
	bh=S3ZZ1OzTdtL1UP8nSWJTPycF2fygL5TM2p92vCpfcTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQCVFMw+S/HZbTucjk0CGclEuOQajIRnaTen2kdPHHTb2hhe+QjFkHG6uoVNhFSFz/69bXBSNdIiEDvPm92sH0VxPeC8M+X+AX1Sh16hVKwjsNt6QQJzLq/rFY0IMiJbwIXopxkvGLs6Yo5fdaiL+MQSBj0lO9Ut+amBkWKCfM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TFWZeRc7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wj8VbgyA; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TFWZeRc7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wj8VbgyA"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id A1C671381167;
	Tue, 14 May 2024 02:33:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 14 May 2024 02:33:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715668428; x=1715754828; bh=bzW8M7OC/N
	1RmqtgAmbtYVwx2hDuZgx5pYQGzl0U7hs=; b=TFWZeRc7de2csNDZdLGe2ADVkU
	bzR55UPNGwki8A2FSxOlqBeVVF+vSE970dKrVKaL427/hVSHgyV1EyiHYGSGDGle
	5CFGTb7TIYdAidrIF6XDF+0NRI+nIwaXuVJ+CPOgAsTZaaQf43f/pYFZQOUKVvuP
	l8X/wNfimK7c1bPPoaDuFdZY6sTYqd+h8ae6z0Z4dyWZF/+R4qPA9Y6oRcCq0P4E
	qfSPR0eQQsSkz70wbBzvVwztJSOr0lkFN3O2SPtIVvIS5TjFPfIwVwioVNmW0EVV
	UI4C1KjUsfuNYR61GpovsZ7J13Jpx8ur66EKE7RrKjp3k6FyWvk/meBg5f4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715668428; x=1715754828; bh=bzW8M7OC/N1RmqtgAmbtYVwx2hDu
	Zgx5pYQGzl0U7hs=; b=Wj8VbgyA8sIwJclWNs+A0bm7oa34SgVGmzBw8pqOxYnE
	lEPE3jK8P5lYrdNW/mccrXkOPKrpUdnFl6NzR3I7juIjHRHtr+hWvCrX+fVfOKgN
	XLTF35w88t3XoUyikYeuWq0ZZQpKp7uPXSD4kA7ayu+m0XZRfCtU58zJd3qg+3KJ
	yFk2yHTQlePbfYXDDyfvHQl/DpzKeEgHbmnJn6JuKOcWHAkBYSk+jt4Wy7IVLKmC
	T9IK7+XY/nsvzGgE93m5uxKBSlWfW/JgrGw389C41TPH4ruNtHMLHcYSySayeLOa
	chik+7j4/cDtHi0wda17oGZSkpoxX9BKH+2ECbZWOA==
X-ME-Sender: <xms:zAVDZsuVxer4CKGFBZW0rszJyfFfzv659aFs8fCzPkaHC3a_4mhiMw>
    <xme:zAVDZpdFz-M8wcKOFq5H2SuznoKJnh_jOyPE8K380FCkiRC_tGbBMvFVpJhkG7aaR
    wLk2B6wwUNil9ac9Q>
X-ME-Received: <xmr:zAVDZnyjWkjPGVGq9EqtUp-zFLti0HCXNQsN1wuG-O14Iicx33OHOTmm1Fzdum3gcAvKDaVCo38BAjF3ljlqqhv0nAjwewKT6nED9HazNHzk6sAz_wop>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeghedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:zAVDZvNvrMArkut2p2KV3RIYovUVbtNjQjudQ1TQynxgZJ8w4scxdQ>
    <xmx:zAVDZs_ARyDUDo9X4til87oQhquDZAj4WJIym2zeMhzp_TtEMe0z9g>
    <xmx:zAVDZnWugfeZ8hz__0Ijj--dooEhfUJ11T-uakGmE0pxCwMEV_wErw>
    <xmx:zAVDZlf3baGGPxWwGVo4mhawfhjQkAoAKeoEVlc-0yjR845OYRapJg>
    <xmx:zAVDZrlOtpqa9at411bRlW5RqAQqz--YQax5zdZ8C9ftDdOymoJP7EfW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 May 2024 02:33:47 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id e6cf3fa5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 14 May 2024 06:33:25 +0000 (UTC)
Date: Tue, 14 May 2024 08:33:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 01/23] Documentation/technical: describe pseudo-merge
 bitmaps format
Message-ID: <ZkMFx6byw2ersCXg@tanuki>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1714422410.git.me@ttaylorr.com>
 <43fd5e3597151a86254e18e08ffd8cadbcb6e4f0.1714422410.git.me@ttaylorr.com>
 <ZjjEjNRp2BAMWJ47@tanuki>
 <ZjkHT9XVl7ua8E14@nand.local>
 <Zj4JM3ATSMice5do@tanuki>
 <ZkJuNSWLRcPjPT6S@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XJaVVw3ASegfIwKu"
Content-Disposition: inline
In-Reply-To: <ZkJuNSWLRcPjPT6S@nand.local>


--XJaVVw3ASegfIwKu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 03:47:01PM -0400, Taylor Blau wrote:
> On Fri, May 10, 2024 at 01:46:59PM +0200, Patrick Steinhardt wrote:
> > > > > +* An (optional) extended lookup table (written if and only if th=
ere is
> > > > > +  at least one commit which appears in more than one pseudo-merg=
e).
> > > > > +  There are as many entries as commits which appear in multiple
> > > > > +  pseudo-merges. Each entry contains the following:
> > > > > +
> > > > > +  ** `N`, a 4-byte unsigned value equal to the number of pseudo-=
merges
> > > > > +     which contain a given commit.
> > > >
> > > > How exactly is the given commit identified? Or in other words, give=
n an
> > > > entry in the lookup table here, how do I figure out what commit it
> > > > belongs to?
> > >
> > > They aren't identified within this section. The extended lookup table=
 is
> > > indexed into via the lookup table with an offset that is stored in the
> > > `offset` field when the MSB is set.
> >
> > Okay. Would this explanation be a good addition to the document?
>=20
> I think we already have this written down in the section above. See in
> the previous bullet point the section reading "containing either one of
> two possible offsets, deepening on whether or not the most-significant
> bit is set: [...]"
>=20
> Does that work?

One could have a back-reference to that section here. But I don't mind
it too much overall.

Thanks!

Patrick

--XJaVVw3ASegfIwKu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZDBcYACgkQVbJhu7ck
PpQ5PA//RsymaD3c3Zd4e1BavgyY0WtmXbwd4WqhOrQjzatbHOuXpZzBEraNlt24
ygPBE2T11kt6+VVDVGxbafY/f5jnmJ7vSLkC0ESVde1lSsjh4zoVZ8I9wRDz/eX/
LqhQRuwlbRyVsVL1dTEO+z+w9LRnBTU3RLRahX2nvHaC7kO4XwqBKXy/wlyYvvtf
RKdt5nfYmCJGNrTeb3akSpIqgGuTmIsCDyGcMWYpPWmEgd4fgTNzmf7n4SZrnRv7
z0R4iR/t2Cxqgk6RmRLrcUl7j6tqaa6FZpMG3JkT3DH6ANUR2nEVmBuVFy6VpJMi
JlnhUEmG9O0b+8S+wrlXiKh2iNuwuRm3ByY6qAJ65Eq90K5WLOGbIDbpNwS9/OgC
RmSe4SldQbRXi5P1bTXhAtAwnOki7Ed0YCpmZE4W2y1/aaKzIbv+dtf4F90ldcBq
cJjvnXjmNMdvxYqsQ4cGdTIMonCh5JKojDsAMuZl/HCjLISKWivnS26A1abJ/Mnp
h99iPT8FFysPULgXQms6Z5YH8vb+8vbWncKIlD2SunXdiw7KkB4SamoQDFPBE0YA
cqH3HbILh7kx7SfxOZibBzJDRBoAiCeQIiCHemMfsn2nMetDB/ruFCWb5vDwi3tD
t7k34NMq/Wyl6D/DwyIcH25R2x7p0k54Sh7Fo6+WRCEn/1pSDsg=
=LOHH
-----END PGP SIGNATURE-----

--XJaVVw3ASegfIwKu--

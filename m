Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6B32AD16
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 05:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723008719; cv=none; b=LpIsYGAhKyNIUj7L3nMikq6Pfkfj6pihPDmiR6qDdEA1JmmLOqYtnGp5rqnyOyEYfgbot94mfqPnTWwZSo9OdlEL8ljGsqSHD2xFTUzwZOBU5Hn6wz5ARNQSnuXiTQGBxMaadjP7Dof162TcYN7ME93veQD8UvFWfp501qEDtu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723008719; c=relaxed/simple;
	bh=gBLnoykdy3XCE8GrWVSuY4kFmpAsMOpqoa6h6pepGU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mWZz5bG4DMBjer2r05wFdaa3P1PiOYz8IDngaPUc7i/unteZRP0DcNQBN8yCGrGmWYiR5upaV8HVoyRO4z45cGZt/9Ga7yPPtGVz4B3irFToJG6JYlSM0WGP/tishINvYUj5M0+ZPd/iMFY7OT5dHygZiWxpssN9eDSRZ4+i6h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CS8u4k96; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R7/Ps/cT; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CS8u4k96";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R7/Ps/cT"
Received: from compute8.internal (compute8.nyi.internal [10.202.2.227])
	by mailfout.nyi.internal (Postfix) with ESMTP id 4D8C8138FC43;
	Wed,  7 Aug 2024 01:31:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute8.internal (MEProxy); Wed, 07 Aug 2024 01:31:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723008717; x=1723095117; bh=o3fmZdZ644
	M1Ay/rOQVVgW/Ripe80t2DoNX1dgXgaqA=; b=CS8u4k96w2xfsTkLbfTi1luKms
	BJG/TGAWA44+HMc0mM7s6ZwTTCe3vwOvhaL8xhKeHmM0U14gPKnIuLwnYN6L5oLv
	fbeI5y+fGKVm+bHbUJBOWowpEqswyHJhQaV4+JP7hiI87FPHG9YlZJpYiAnu3Njr
	yf/tgLLpuA1o9HMd9IknvvRaPIbbrJxLENvG0FMWuzYEeXLxEE84fXP7PDf1Vmif
	I6imjAMxrnV7N8iAnQHSQYjj55HVV4OMBdml85FxiwwrbCcN4c2D11kR6yiwzWPV
	D7qNgGCVPEdjuhQimGXcJM2o1B/9J8+kn8UJGR4XjJx35gy8/G/SlKWkpQDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723008717; x=1723095117; bh=o3fmZdZ644M1Ay/rOQVVgW/Ripe8
	0t2DoNX1dgXgaqA=; b=R7/Ps/cTj4Ay/qRqcs47lg8cWPguLjTrHy59h11q7asT
	wqLnTHNsuL06QxvY+XhA8p/7mexB/MI2QuvoNR7oVzVcNtxRp1iHqvzxOLk7/P5J
	Q+rv1KO9FhVI9+Q9zaDnSLROFz3kKPzn6PILnxOafJh81uAa82vb2h7mCI/VWNqd
	c/HHTqtLV9KwJQyOx34ryZuHqqZQsUF9Go+/+fAh5ht4hcztz7lZaglOn+ovIfzL
	oWc3peXzS3lOpNLyQj4zmd7yowX/HdBEo9DUXbwmLuD0o/xb3SmqCghlOKmksRsh
	VZksS+fR2O1YkmjjGu9GZ2l0+Vah/9qkG/OnTZ2kRQ==
X-ME-Sender: <xms:zQazZvgsefcRnV8v489_Z82cwhBP8NqQerLCWDY3FeXOcmBOXG3lPA>
    <xme:zQazZsARlQkpzoZ9trPWBbPFu-7y717v5aQoEUhm2nuvPQERbC-tvBH-01UYvzQ32
    lPmHcdWHDt9JxhmSQ>
X-ME-Received: <xmr:zQazZvFmy9ZpoC9k5395-2kC5eFaHtdERMilKksKDqaZYvABV0_YhQjOjDnhPwNmWqZkYugHUwEi_pCwySwPdrACEH4tL75TsmEIygAzcqCc5Eq0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeelgdellecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:zQazZsTGJlzI_JbxVQPn5oSaHck4w2Wm1SA_Y5IFxyAmCpj0AJlN8w>
    <xmx:zQazZsx9CoTQerEKAFQ85GtB_Z_Qc2TBpMqecj_Rm-pj0kYEVkHxjA>
    <xmx:zQazZi50cwa2BwFeobuSVkAHiftdRb3wNUuM3xjV8KpCc0I_JqinHA>
    <xmx:zQazZhxdj-od_I4EQWQLFD1WQl6WVi7j7tUxizi03p9qsOgQwjmGTA>
    <xmx:zQazZo_xWMyExK77HGUd8KNOBKjSTOkzIXZ19-NqnJcfdmuaoVj7rPG5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Aug 2024 01:31:56 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f18fe500 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 7 Aug 2024 05:31:50 +0000 (UTC)
Date: Wed, 7 Aug 2024 07:31:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 9/9] reftable/stack: handle locked tables during
 auto-compaction
Message-ID: <ZrMGyMTm3jXLSLtI@tanuki>
References: <cover.1722435214.git.ps@pks.im>
 <cover.1722862822.git.ps@pks.im>
 <1ef560feb1906c160ad7c81a30e9bd4fc92d2eca.1722862822.git.ps@pks.im>
 <sct3bl7ztqwyym3wqh3jvz7vefr5gk4mf6dhsaasdihszcnnlf@s23uyyiwwbu3>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="U1jmc/eu3pPhvBar"
Content-Disposition: inline
In-Reply-To: <sct3bl7ztqwyym3wqh3jvz7vefr5gk4mf6dhsaasdihszcnnlf@s23uyyiwwbu3>


--U1jmc/eu3pPhvBar
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 06, 2024 at 01:46:35PM -0500, Justin Tobler wrote:
> On 24/08/05 03:08PM, Patrick Steinhardt wrote:
> >  	REFTABLE_CALLOC_ARRAY(table_locks, last - first + 1);
> > -	for (i =3D first; i <=3D last; i++) {
> > -		stack_filename(&table_name, st, reader_name(st->readers[i]));
> > +	for (i =3D last + 1; i > first; i--) {
> > +		stack_filename(&table_name, st, reader_name(st->readers[i - 1]));
>=20
> I might be missing something, but why not set `i =3D last` and `i >=3D
> first`? It looks like everywhere we reference `i` we subtract one
> anyways. Since `last` is already at the starting index, it seems it
> would be a bit more straightforward.

You are missing the case where `first =3D=3D 0`. With `first =3D 0`, `i >=3D
first` would be truish when `i =3D=3D 0` and thus we would continue to loop.
We then execute `i--`, wrap around, and still have `i >=3D first`.

Thus, an endless loop is born :)

Patrick

--U1jmc/eu3pPhvBar
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmazBscACgkQVbJhu7ck
PpRM2BAAlLZUlSJRlXCa4iHjXV6VyuFYGwHbmxtlrmxVVlMegJjxNSXjxtv5fCaL
clFxE+zm3CGnfCQslW3jFpTVW4GLe1Mdll/sPllDskQd96Y9QMPSudxUpO3NpzXr
WuZ5uP9zzYOQMOZf0gH/zNPMOW4/jo94lrbXxgSWE58e6f7PvBFenEmkmxHFGaTQ
pORg3OhhNnyJ3SQVBjnbr8e3AeulroW5EDwiR0McEA7y6k6NJgU705ngjXimO429
+5uhy6rlPn+piCY5RfXZZVDpMRR+mk7+cqP3v5UKVvJB7Wo/MV3VWb7kFoaT1jSO
6A0UJS4NcVzIbms9qFEiR7FypBD9eH6IQM62thR5BUDmIVSSAsblLY9Q7OyJimmi
/BIf1ZPf7gqLMk4JKDG1PjsbgVnEPlV2Ovecys9sTMduIfwvR8uwajY90H2jAGCF
sg1bHU4d5W54YTDtrHuvkDgek3S2ghqqKLkh8bSNWfg70MlhpqdzkYRLhYqfHGsL
bC0Kvof2HIzjxzTwhykNU67NvWSAQZDy0mIU8KTzRdLsUNEis25Xj4BX0eCfCjOf
SulnxYx/FoPhibxrCmIOSpbyyfaNlgtHNU6JgcR7D5J54dL3qSndSbY6+RwI63El
yxWA2szsirPaohOdZQai/k/jcw/8hpMr4fHm4fIVO/c1ALRjRjo=
=qn60
-----END PGP SIGNATURE-----

--U1jmc/eu3pPhvBar--

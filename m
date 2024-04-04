Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8351B17736
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 05:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712209005; cv=none; b=U3GtNb2rTQoRXjKcXuI1cjLTBjojybg5ONpbK092UVqDZNDtFTHN7w0TsU1E5JwdllnwY/tOCfQsb8lfojrzeZxryUC43EssiGhwgzUHLCSb4JLmHQLUEf7sHoa+oweMfLgcl7j0ZaklspronICPaDhcre0yp1wi5yBTGa8/YUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712209005; c=relaxed/simple;
	bh=+1GlhvoIMwe5SGvTZpkCwgvlwSxKG0khghrxGvr9LUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YEivSwkYOb1DitXgxLEgG4AXA1Miow2ggTQ+fq9Am5vvgkrTgK+4Rux1DXeqNeQpwJPwyUa6NsRuYtezir5EhpyHpBdKY8vpWxZYar/K509gcsp7YBUtLtutVQ7cLKdTe8KANA2+XJpI+JXxIh1T8Mbcxq6Wd/YK4lH9Uuy7azg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QmDQn2e6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KSg9PznC; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QmDQn2e6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KSg9PznC"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 82A4811400FA;
	Thu,  4 Apr 2024 01:36:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 04 Apr 2024 01:36:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712209002; x=1712295402; bh=ux4KDWD25t
	ONrLy0T62iJlA4o2UZwd6xnNU3XWz95Io=; b=QmDQn2e6ud3Qu5onmjwt7Vkpil
	QfIsjjIcSQZR8wK67I+oHBkKUZw9NtjLXKRznDfyzEt/nGIvIVPb4qVS/7qFA+aH
	N44lUbaS2a+u7tVCVfIvffbsE9WKkdKo+KpFpBLc5Ociwt0QKS/qefshrH3U7KOA
	8OsFNOEF5+f/59NfZ0BusA+hfZ44rQ38am0S0OIOiopI4NUr5r6LiAzY000UwlcR
	HSpHrENrCHXbYDiueNzMrZsFcb1DucD+5aZvm1VbemfyDp3/yVvs1w8wAUODwnw0
	zc73c+u4TxDsMNveNrMQfyGiWUCVioY/5asj+dSjqIKRdnLub3oyNVJ5s0Eg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712209002; x=1712295402; bh=ux4KDWD25tONrLy0T62iJlA4o2UZ
	wd6xnNU3XWz95Io=; b=KSg9PznCyfQVE2yhuvNv4urEhEYkH7ojCWb1chxaYVYN
	eSA0X3Evm7H+v7zAGud1w0acVf7aKIEbUdc12I0khBK8xqNvMuPjhsyZ+H+Jg1eT
	FSkk9eVdk2BSwtjzWMbA4jDwEPqSRDEa+yvTRpJAlmIPXmTrrC8ud5y5TQoIiKQ4
	EsH9LCUk7SLxr0NZ4RE2sHjBYT6BSQCu4BETX7jgohZJ9U5UhsLxTisiDBUMWkwt
	A1G2On7xU81uc2cu9tCyGemWXFks7URag2DbXd+ImjTNONtVvqxQsmoSRiHySCVv
	AwoDrLMrN1WlYD8+i5aC29U4ZEIWOBSwpl2Km2kJDw==
X-ME-Sender: <xms:ajwOZjmGLbKh2GsdfN9Jy3jEbe1yLzQb5JOVfpbgcKqikZJgVFqHQQ>
    <xme:ajwOZm14ezYdcqLioN2grHrQTk8IUhewnLiJDzdZwo2-Na_ZnCY01YBoq6j5bCKMz
    U7E8qUSqKGN9M7z_w>
X-ME-Received: <xmr:ajwOZpqMoKJK0ggC-0BurmvQWvAHto6Ml6U8Q8-t3mMtHoHUYs2hGSRJpEuKS2KUOmze8Tur9DZ-EuVQIJs-6_pgtBSzI23Y3CaQo-qvaSVbE8ed>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefjedgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:ajwOZrmlietYhkNthyAL7X_gYNtznFPSp_DPoIvQAHeMLH3R2JngiQ>
    <xmx:ajwOZh2KT2XIs4pyfqT2Ri__EQXufLZXdTIwOyrlFHVbbfFuuZf3Jg>
    <xmx:ajwOZqt4lpLEMQdx7PHW9jAimMxEbrP2J_nlzor7SzCGAF3oiFcpVg>
    <xmx:ajwOZlWUvJQO-ml8kdLTSLYmbHJBFex58KLW-ej45qzYSSLiXIbNAQ>
    <xmx:ajwOZqwot-XCNsvOE7CduZqicbooFKc_Za5bCKJ7nblCAnFWbfTJJ2uc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Apr 2024 01:36:41 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id f35aa137 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Apr 2024 05:36:38 +0000 (UTC)
Date: Thu, 4 Apr 2024 07:36:39 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/9] refs/reftable: don't recompute committer ident
Message-ID: <Zg48Z-jcJ8YiF04b@tanuki>
References: <cover.1712078736.git.ps@pks.im>
 <a9a6795c025b23035bfdd3e23b0113df9f6c5e4b.1712078736.git.ps@pks.im>
 <xmqqedbm6zoj.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5hdMGiM+GGyXr/ar"
Content-Disposition: inline
In-Reply-To: <xmqqedbm6zoj.fsf@gitster.g>


--5hdMGiM+GGyXr/ar
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 03, 2024 at 11:58:36AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > In order to write reflog entries we need to compute the committer's
> > identity as it becomes encoded in the log record itself. In the reftable
> > backend, computing the identity is repeated for every single reflog
> > entry which we are about to write in a transaction. Needless to say,
> > this can be quite a waste of effort when writing many refs with reflog
> > entries in a single transaction.
>=20
> It would have been nice to mention which caller benefits from this
> rewrite in the above.
>=20
> There are four callers of the fill_reftable_log_record() function.
> The patch moves the split_ident() call from the callee to these four
> callers.  The write_transaction_table() function calls it in a loop,
> which should give us a big boost.  For other three callers, they
> call it at most twice (i.e. write_copy_table() when deleting the old
> one), so their contribution to the boost should be minimal.
>=20
> Makes sense.

I do say it by saying "write in a transaction", but I agree that this is
not exactly obvious. Will rephrase.

Patrick

--5hdMGiM+GGyXr/ar
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYOPGYACgkQVbJhu7ck
PpSwcw/+LllcHU/EClHwt3tI8E7UMfqRqJNdYQcL+3adBVcz0iv9sEpH94easJ1k
22P/pXXsfalmftE2urC8GQhtLeRvFS11WkGTflwG9t/c0IHPVqAL5qW9dRxsIfAy
yNSvDNiPhHJRzD3MklDA0AKN6eewjBbhW93Si5FpZ1b6O4ARrCi0Zm80i224RPkV
xKpfWq0TjQxIpSKMQFpSfNoWHEQV+iax3HhiIz0HzsPzGc9dH7umhXND+joyhjtL
A7Oal/LOL+AZRZvuDleBDz+Uz3vN9XmLS9vo7E51qUrii28ngmVbyWaQBna31S6b
sIXBnfQYjE5jZ00YMlg3zLXLZaW96fzV4uFf1IQnWGRzQR90Ibc+UjA+48GqrwsW
qInY1xuk/wVes01r+JusegH54G+3tTmHV/lTYHiat9gZ5lgW/cyjHO66oSTz2BGm
arnCGbuoFyqU2tsv2A607mt3v7wu1Gg0wMqxwS5SKtrdbaqewJ5mmIiv6EdjsiV/
zuPHgygTBs4F6Y/KaqNBZfl22N5Onwk86TqwzXy595ZsdhZ2ERghZZWED5K87tnb
Q9VT9VUUDTCVEY2QN1CbhfB8TP3kKmC6zE58fqnGGD17FdW5QaoG5Nj0t88D67wE
DPSZ2rmtPzxY1PafC5RNBp+CzDYdsRERoA7n6ShcUSsK8JFjFcg=
=7VQV
-----END PGP SIGNATURE-----

--5hdMGiM+GGyXr/ar--

Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799207351A
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 09:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711357846; cv=none; b=I8q5up/ldR4JQe2agBQS3vWder0BMob8Vws0MuCz1X53vUHxzHfW9n2EPZ2ADyNbkp7z2XEMuiZgcXPySIbeD8aAwtsEpKDolCR/7yS/Hs10zOccbIZ+ISTY1iHjkR6ArGxCN82Y9eeRxUTq2ZAmeaPo51debzNlMfyIb05fs+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711357846; c=relaxed/simple;
	bh=XeilNrI7NauizJ+lniESkt6b8uk/4oPgarbhyrYJ8H8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PMp3Z44wE5kvMUHkFrptSQvMzIjQR1fAzqvmLwbuxxEV6ALiHkgQ1VWG73fFK3Ya7kKm8lqd9Jzm/O0sqrhuzdToJI7O/+eYa0oQ1mkF1uOLD4OyIiTGGshiEQlPfN2R6JPP2Ii+bXwBCrtupfHtOw0xSXeOXaQYsKNZG6pM/UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BEO4/FGx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jOPs3FC0; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BEO4/FGx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jOPs3FC0"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 850851380117;
	Mon, 25 Mar 2024 05:10:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 25 Mar 2024 05:10:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711357843; x=1711444243; bh=aOy4HENEq+
	9A68fSvxgWz1b+LEsWbRfCrjYKfs/lnqw=; b=BEO4/FGxOShJckqs66TelfOnNx
	Ez6TewX/uU+3/l87k5+9VVip8ishX1U5PqfejmR+VxL/RVRV4CLkNOouBE7RLEXZ
	cGcq35EKjcAeIRAukjekCccq42luaiXtJlYm3cr1SMNJ2xto5SQSKeIovz0nrOtT
	cAbJ42A0udlzeURie+cKh+2P3/TXIqcGKf3w8R8vtoCE+3Zs0ROUBnuzIZbDFBn7
	nCYEAwwFN0iWfp9mDw5mRuVE6B7naPI0wy9gH/QVOtybbT5WHpA4H9S86GmaFvrO
	WMsfHbUSeCCiMG1civ7/chNZT/fCYg2KW66W1kWT+YjG2FvMSw7E2+r9l4aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711357843; x=1711444243; bh=aOy4HENEq+9A68fSvxgWz1b+LEsW
	bRfCrjYKfs/lnqw=; b=jOPs3FC0kajlfmf+XQ/jm8GSGone4K4kFAt6VHeAX3Gk
	WyzX7ef/KeTCaIdkgVnu/nsp7jTOSBGgqmJ4OVZdhwpLDDcYepbG37vVdXQgJOul
	axNwYACsfWQnClZ8cu4JUXJn3XGgfAU3wSbcaufEfJaYlYo2zoqvRMx5WfSOThJY
	4C0569fd9WXAEFHjAB9CEMattHm7bMJzqCkjxy+t4kV1uwA0t7YJosB57WQ42smw
	8xHoMC1CvLVXTpdDDhkiIV3IYDI+PiMwkdwcpxO6m4uvSc7VcKLP7tk2clEKAEBa
	EvxSqd3L1tWQtvmfq8dDbhZyIy9s/TzwbqMLquR3zA==
X-ME-Sender: <xms:kz8BZsmkB-Xs43NzBM7_p5fAi1dhQSMS1dOlHW2XuQuEFHgCRBh7SA>
    <xme:kz8BZr3bj-FYGGj1L5d96sQPoPz3DoNAC7Wx712OQYKH9BJ6IsYPiWramLDNDtaKB
    gj0JOGB82O1DJdeHQ>
X-ME-Received: <xmr:kz8BZqq1SLnZ-gUh8s8I4hbdFVXkCXPKpnIx4fK6N2al2gZHKfdaUOgAMUz0vHAF8w7Seiq3lLZEKPKhgmMitLFXkOq-2RfsWYJnRG2Htwg8iA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtlecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    eukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteenucev
    lhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhm
X-ME-Proxy: <xmx:kz8BZomBx2DjyJYQ6kWrJI2b4YCvnM4LdLj-3vWz1nzCyb_72arN9A>
    <xmx:kz8BZq0B4-eGrHvdTMG5f6maSgudTPU4APBVp12QpLMFzzmxa2fq_w>
    <xmx:kz8BZvvAi8H-UaHGBZ1p6dualpjEz22BJE8XMNQWqft1NQmKq7Ywnw>
    <xmx:kz8BZmU-5PuBJc_xbVQkShv1wlf4-FV9UrYKEgXtLs16UO3h6M2CbA>
    <xmx:kz8BZtRUt0-sjt0X54Gvbv0LmpPevhhTvLG89R3aMMRo0RN2dYwyIg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Mar 2024 05:10:42 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cdb331eb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Mar 2024 09:10:32 +0000 (UTC)
Date: Mon, 25 Mar 2024 10:10:40 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 04/15] reftable/stack: gracefully handle failed
 auto-compaction due to locks
Message-ID: <ZgE_kJldM-Rh9tKl@tanuki>
References: <cover.1710706118.git.ps@pks.im>
 <37a18b91ca998ca5ad27d17e86d286040b6e6ee1.1710706118.git.ps@pks.im>
 <CAOLa=ZRxt7rwmU4UJAZra605zyqk5QJD5OD1oM_BidRpJbZP1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DZyJd84S1ZDqPr2N"
Content-Disposition: inline
In-Reply-To: <CAOLa=ZRxt7rwmU4UJAZra605zyqk5QJD5OD1oM_BidRpJbZP1w@mail.gmail.com>


--DZyJd84S1ZDqPr2N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 03:22:55PM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > Whenever we commit a new table to the reftable stack we will end up
> > invoking auto-compaction of the stack to keep the total number of tables
> > at bay. This auto-compaction may fail though in case at least one of the
> > tables which we are about to compact is locked. This is indicated by the
> > compaction function returning a positive value. We do not handle this
>=20
> We no longer return a positive value, do we?

Yup, this is stale.

> > case though, and thus bubble that return value up the calling chain,
> > which will ultimately cause a failure.
> >
> > Fix this bug by handling positive return values.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  reftable/stack.c           | 13 ++++++++++++-
> >  t/t0610-reftable-basics.sh | 20 ++++++++++++++++++++
> >  2 files changed, 32 insertions(+), 1 deletion(-)
> >
> > diff --git a/reftable/stack.c b/reftable/stack.c
> > index ba15c48ddd..dd5160d751 100644
> > --- a/reftable/stack.c
> > +++ b/reftable/stack.c
> > @@ -680,8 +680,19 @@ int reftable_addition_commit(struct reftable_addit=
ion *add)
> >  	if (err)
> >  		goto done;
> >
> > -	if (!add->stack->disable_auto_compact)
> > +	if (!add->stack->disable_auto_compact) {
> > +		/*
> > +		 * Auto-compact the stack to keep the number of tables in
> > +		 * control. Note that we explicitly ignore locking issues which
> > +		 * may indicate that a concurrent process is already trying to
> > +		 * compact tables. This is fine, so we simply ignore that error
> > +		 * condition.
> > +		 */
> >
>=20
> Nit: The last two sentences are somewhat the same, it'd be perhaps nicer
> to explain why "this is fine".

Fair enough.

> >  		err =3D reftable_stack_auto_compact(add->stack);
> > +		if (err < 0 && err !=3D REFTABLE_LOCK_ERROR)
> > +			goto done;
> > +		err =3D 0;
> > +	}
> >
> >  done:
> >  	reftable_addition_close(add);
> > diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
> > index 686781192e..5f2f9baa9b 100755
> > --- a/t/t0610-reftable-basics.sh
> > +++ b/t/t0610-reftable-basics.sh
> > @@ -340,6 +340,26 @@ test_expect_success 'ref transaction: empty transa=
ction in empty repo' '
> >  	EOF
> >  '
> >
> > +test_expect_success 'ref transaction: fails gracefully when auto compa=
ction fails' '
> > +	test_when_finished "rm -rf repo" &&
> > +	git init repo &&
> > +	(
> > +		cd repo &&
> > +
> > +		test_commit A &&
> > +		for i in $(test_seq 10)
> > +		do
> > +			git branch branch-$i &&
> > +			for table in .git/reftable/*.ref
> > +			do
> > +				touch "$table.lock" || exit 1
> > +			done ||
> > +			exit 1
> > +		done &&
> > +		test_line_count =3D 13 .git/reftable/tables.list
> > +	)
> > +'
>=20
> I'm not sure about the testing setup for reftables, but maybe if we
> moved this to the unit tests, we could've also checked the
> `reftable_stack_compaction_stats(st)->failures` value. This is fine, but
> it doesn't really tell us if the compaction was even attempted.

Both tests have their merit, I'd say. Let's thus just add both.

Patrick

--DZyJd84S1ZDqPr2N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYBP48ACgkQVbJhu7ck
PpRTyA/+NwIVNjJ+HCEQCZBb6rs6y86TgSICRM5LrirUFxGNoj/c+MM5+lU3lPLs
wDqTXg43NeDZ8QRe2gGwHUHsmdyTynWIeivy8tOgc1ORlpn+OIzk3yTlxyjeZ6Zr
WsMDC/xtjuCD1BNg6zy8M/jRCHyQRA+midS/mztawsT0T6jFhgD9gr9G/fOuoOJJ
aQOPuRI+oxwPCuAQF11a0TJATVnl2lLLSWM08Z9d+sARK48SrK3O7Dr7EaawhOGA
R9BxzwU2+6WJ2ID+aIP8Y9HXgUq4E/gZISZSa4i3ioCT5O4TpiL4TU1vUaPd7dkU
h9Ej9z0ODMP7jjkcTyvwKgCllS6IRi1LBUPry/78CcuYHTCK/XX+oF82TR3o7osf
xvJUb5jd3l2lceeBwgSRDwxH877T+vUwrWxV7EEOOZ4GmBr0hmeqArZnNFUvsPCO
LE5VMkGjfYtII7e1DtN3V9Cod0I59O5wZWH8+bvIXmdM6l1f9onDNtIwB8McWKYU
ozDqhCcITMrz3q4sInfszeJ6dgpEvnywbLQTUu7EvlR7kNwc35bqzXcODmoObNjJ
upuL9zGPuDg+j8zzZS2t4pQ7xxS9y5p5BT8CkRdeUgxVthMr4JusznYvw4ttLqU0
uVmoYN6bLFlW4IDeR+6I6tii4WvT5GqF1ghthfzvuDZI/H1b4aI=
=HbyC
-----END PGP SIGNATURE-----

--DZyJd84S1ZDqPr2N--

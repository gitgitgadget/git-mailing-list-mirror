Return-Path: <SRS0=EE6k=7Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46CABC433DF
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 11:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DE7F204EF
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 11:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mJQ84Bk7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OjtHVFDk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbgFCLZV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Jun 2020 07:25:21 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:55209 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725833AbgFCLZU (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 3 Jun 2020 07:25:20 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id DE9285C0078;
        Wed,  3 Jun 2020 07:25:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 03 Jun 2020 07:25:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=942GjcqAzJEfkUkirwF1wDfH0aO
        74MV4XD4S4+lye0w=; b=mJQ84Bk7/jDh5Gnqu4A63WM9YgbJbZm4JzCPa0yUaIO
        buy08tEP1BPBmTFF6XqFR7wbP9B/Lf35AL68qXHfD1tQC4EbWI56HN/8+F8RP837
        cyNRNB+ZL2TRwHX5y3GZNZUHreU+hksrmOYWpBOzcvmWL9F+AqnZQAk89NjELTYZ
        nw/QnqJbW5ZrVk/9VpAA0AQQRKWOcbnUzqq9x2Y7V1xmsq/5ZvK0oYoJQskHh+N+
        nJZ9Nnvjt4aruBcNoZ0b0pQ1tDu2i2IbSHvGYbSyXtxU97ny5ShMfK+0tWPBv6VV
        T5BXwcznbLXexAGFr/9BirtX23bC0YJ9pf1fbFjQVWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=942Gjc
        qAzJEfkUkirwF1wDfH0aO74MV4XD4S4+lye0w=; b=OjtHVFDkhjioymLsff6Glt
        AAnKkTDMJxLL6OHIys376xsJkoy7rEiOuydF+xnadB3hS5C0Ua/bURc74t3bQDAw
        05y1s6ZwMb6gqbhbFsnlBzvnUdDXFQIl2M4Poh81UYuyBwu+lQYvpLuW3OhX09X9
        /pslpHKxlklacZEz1uckFSGswW6NWPtUVZPax99IG1quRyMCxyn+K+CuaJUv3LgU
        672y1YELUK0pQjLT75I+ZVgTAEt47NhA3mo0MZu/vpsx4lILR1zowRm+r0pajiUt
        RdfAKsOk0whKuFggvHo91XAbDSEmXZV1e7sMro9aP4lMjp3q82dtvObXHiHUr7lw
        ==
X-ME-Sender: <xms:nojXXjmenhFbkiNgjIruqYyvGBYWqmr6obboJsjLjVYzcBm1STJCQg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudefledgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecukfhppeejjedrudefrddujeeirddujedunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:nojXXm2wMpVhALa_M_CAjA-bu_IGGifkxEnyuzZqNy4gdT2j1rX_gw>
    <xmx:nojXXppk8zJqGCmoUUCDkPBDpCdmaLwiKN2diRYsetYf-PESKoNbXg>
    <xmx:nojXXrmd3-xSkwtsxsk7_fG655qIc_Ve51-oX2YFqJ3DKmRwlxXMgw>
    <xmx:nojXXiA3RZuvxyoDLM9c6DX_SF5-P6hI0itfqX9xGzjM-_vkADcAew>
Received: from vm-mail.pks.im (x4d0db0ab.dyn.telefonica.de [77.13.176.171])
        by mail.messagingengine.com (Postfix) with ESMTPA id E95A23280067;
        Wed,  3 Jun 2020 07:25:17 -0400 (EDT)
Received: from localhost (tanuki [10.192.0.23])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 957bc8f6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 3 Jun 2020 11:25:12 +0000 (UTC)
Date:   Wed, 3 Jun 2020 13:26:04 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] refs: implement reference transaction hooks
Message-ID: <20200603112604.GA25644@tanuki.pks.im>
References: <1d1a94426f95d842e0e3ea6a1569c0c45239229c.1591086316.git.ps@pks.im>
 <xmqq4krttl4k.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
In-Reply-To: <xmqq4krttl4k.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 02, 2020 at 10:47:55AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > The above scenario is the motivation for a set of three new hooks that
> > reach directly into Git's reference transaction. Each of the following
> > new hooks (currently) doesn't accept any parameters and receives the set
> > of queued reference updates via stdin:
>=20
> Do we have something (e.g. performance measurement) to convince
> ourselves that this won't incur unacceptable levels of overhead in
> null cases where there is no hook installed in the repository?

Not yet, but I'll try to come up with a benchmark in the next iteration.
I guess the best way to test is to directly exercise git-update-refs, as
it's nearly a direct wrapper around reference transactions.

> > +	proc.in =3D -1;
> > +	proc.stdout_to_stderr =3D 1;
> > +	proc.trace2_hook_name =3D hook_name;
> > +
> > +	code =3D start_command(&proc);
> > +	if (code)
> > +		return code;
> > +
> > +	sigchain_push(SIGPIPE, SIG_IGN);
> > +
> > +	for (i =3D 0; i < transaction->nr; i++) {
> > +		struct ref_update *update =3D transaction->updates[i];
> > +
> > +		strbuf_reset(&buf);
> > +		strbuf_addf(&buf, "%s %s %s\n",
> > +			    oid_to_hex(&update->old_oid),
> > +			    oid_to_hex(&update->new_oid),
> > +			    update->refname);
> > +
> > +		if (write_in_full(proc.in, buf.buf, buf.len) < 0)
> > +			break;
>=20
> We leave the loop early when we detect a write failure here...
>=20
> > +	}
> > +
> > +	close(proc.in);
> > +	sigchain_pop(SIGPIPE);
> > +
> > +	strbuf_release(&buf);
> > +	return finish_command(&proc);
>=20
> ... but the caller does not get notified.  Intended?

This is semi-intended. In case the hook doesn't fully consume stdin and
exits early, writing to its stdin would fail as we ignore SIGPIPE. We
don't want to force the hook to care about consuming all of stdin,
though.

We could improve error handling here by ignoring EPIPE, but making every
other write error fatal. If there's any other abnormal error condition
then we certainly don't want the hook to act on incomplete data and
pretend everything's fine.

> > +}
> > +
> >  int ref_transaction_prepare(struct ref_transaction *transaction,
> >  			    struct strbuf *err)
> >  {
> >  	struct ref_store *refs =3D transaction->ref_store;
> > +	int ret;
> > =20
> >  	switch (transaction->state) {
> >  	case REF_TRANSACTION_OPEN:
> > @@ -2012,7 +2060,17 @@ int ref_transaction_prepare(struct ref_transacti=
on *transaction,
> >  		return -1;
> >  	}
> > =20
> > -	return refs->be->transaction_prepare(refs, transaction, err);
> > +	ret =3D refs->be->transaction_prepare(refs, transaction, err);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D run_transaction_hook(transaction, "ref-transaction-prepared");
>=20
> This caller does care about it, no?

This caller does as it may abort the transaction, but...

> > +	if (ret) {
> > +		ref_transaction_abort(transaction, err);
> > +		die(_("ref updates aborted by hook"));
> > +	}
> > +
> > +	return 0;
> >  }
> > =20
> >  int ref_transaction_abort(struct ref_transaction *transaction,
> > @@ -2036,6 +2094,8 @@ int ref_transaction_abort(struct ref_transaction =
*transaction,
> >  		break;
> >  	}
> > =20
> > +	run_transaction_hook(transaction, "ref-transaction-aborted");
>=20
> And I presume that the callers of "ref_xn_abort()" would, too, but
> the value returned here does not get folded into 'ret'.

=2E.. this one doesn't. The thing is that the reference transaction hook
for the "aborted" case can't do anything about an aborted transaction
after the fact anyway. That's why I chose to ignore errors here, same
for the "committed" case.

Patrick

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl7XiMsACgkQVbJhu7ck
PpSWSQ/+KDmdHUx/yvrVk8b0ZjAwhHpJbnZFtvtqFSIOqxKRvNaAxXqAtcUOH7Bu
ZP9wcaIK3Iw3KS4NooTpJh1stPIbOuzov9GW8xICWs0427rOvCqbbQ9r6iJlC3Qk
bJ60yMjbBIxpcOgIZ4WnxuP8MxuDlG9NQy7Ps040y+HDsQim1wwokQNhAQjdOc9e
yqSuPVSt/2NxqkX+ze9OAWCPL3YGC4ky7reZVE5RM5Iq9e7rF6J2NFEKEOLI/eCJ
juCIY9cFVDwK3N03BZsyk9+pZvAORZb66CZyTLaNRyJc6jyk+V+0x1rv8JcXAtSO
pKwDh1KMgU1A3QVRqfPmgVpWg3fcPdTHZZF7vnLbPrH177I233yq3e2XzWH5FczR
SFH9lHkvIDM7Qr4FHMtn5SgQOYTjhi/sj8Z72hfDt6y7jFt98+QgGs5XWm9HwMHl
cqGu+AHJeYj9vKyYuXbzxQEaU+FuTVPwZYroCia76qtRhEuYvEHBdo/h/yDVojI8
dM6FA7jIh5XxNNdrOx1ogeGSmp9sQRQHaUW0dlZ7mSEP6iw+ziNZxvgz0EKyYMdl
/tzBxmvoEmKdCYzdl3roAzSq5SA7vrJ2FAhk9vs3vzPGfmhhHRiNm5hRcIsPXcwM
LylnpbpjcUgDfY4XhFVEudBu6omev8uqqG/eSD4T7srU/D9aseo=
=UY5O
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--

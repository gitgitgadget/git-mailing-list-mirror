Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D775C433F5
	for <git@archiver.kernel.org>; Mon, 10 Jan 2022 13:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbiAJNSc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 08:18:32 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:42705 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230248AbiAJNSb (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 10 Jan 2022 08:18:31 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 680065C00A3;
        Mon, 10 Jan 2022 08:18:31 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 10 Jan 2022 08:18:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=nVzs8y/S8HkNBQKeu+rRNKoO1nN
        DwvuAOSaR7jsstHU=; b=dNxqQygXKoicdZOQ0tRhbTlN7KM9goURYMVYX+eSzJP
        VpnZmO39aHUVK0A+HcbAwIfcrHExZ5tOmUm9/34XXxNWnIdSLTXZcWUSzTNSdxyr
        xJeZaxb7A4AapRP4hTpEYNbDDqxLxsnYDp1+5s4h9SqRwwKO2kgtPIBZCDfPLR6K
        rt/t4toj2LPEBKbJqEVFbSqs0apY+CuTTpQCh/S9qPHh/LABwrIcytfVcPV1I0VZ
        hS7fuWrw+rME7JMI2SkcGoM6qslf1zaVvtUV6ZVCX+sb2e9mgTaG0IuS5ykkGTfa
        A8HAhY9CPRNujCTK5XKWR8hX3jSy01I2jxMbHlb3pDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=nVzs8y
        /S8HkNBQKeu+rRNKoO1nNDwvuAOSaR7jsstHU=; b=GXBfHxr8m7Y8wHAJQllQgN
        ShLBnlDnaCTAQWqq0xdtJdfIRc1gmgp4WOTh5RSNez5R0bsy70NDMRgiZNOwN4oI
        IkrxJcnF2NZnONNDhTD1t4aiGPnx63+V/e2rPHGpqcpcJSc+pozQ8aYPlEHV4Nu+
        YTE4ZpAw/QLg7hcp3FdQF9DRGdPejJHuufnjwkvoZlGkDSGcDiqRyxLSUxJMQdnR
        CE3v/zBe31NsOrh9T9+JR862T6TQcgXAaCFpJs31XxV0jPww0A9KfyvGx58vvBTb
        5BYX17slHn591PZLxqOTU9yw38Be1JKITEcmEOp388QSpFz/8fL5TT6d+vbULhzQ
        ==
X-ME-Sender: <xms:JzLcYTekvoEEIhhOr779l5Qr1GU1wTYKvsh_Spr74dGGllOAJThuTA>
    <xme:JzLcYZNxX-LODplatk0tbc620MR0uVMCtipuVjpUTI44-NVBFy4EXjNV1UXZLFLvs
    09ABmAxWBl6j5TNjA>
X-ME-Received: <xmr:JzLcYcjFkUceuchBb_1qr0MWEaa_iNeO2_KDMMXk9mldJO7u2yaR472vtKJBFGbiNOd021Y3E6tktlLjjy4TTQNqEomIST8ji3NAJvmyUPRYXK8zHvhNGLhG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudehuddgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:JzLcYU9SBnrFAmAWL9XbhBUGuURZEoulYb1sKsziMfBkaWmSRG1ixQ>
    <xmx:JzLcYfvJu0GD4KH9hufIMOWRbivdcs1LQm6w_SYf-j0S2Y3bzlId8Q>
    <xmx:JzLcYTEetxLppY_GjYv8nq7QYcwkvt3ezSdr2yiN2-73yShDTdesaw>
    <xmx:JzLcYfK4GNc3Ktl4_Y9KsAiBjgVbswCP6W_rGyHaOLiO9AVQQznslg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Jan 2022 08:18:30 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 105f7a76 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 10 Jan 2022 13:18:27 +0000 (UTC)
Date:   Mon, 10 Jan 2022 14:18:14 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Bryan Turner <bturner@atlassian.com>,
        Waleed Khan <me@waleedkhan.name>
Subject: Re: [PATCH v2 6/6] refs: skip hooks when deleting uncovered packed
 refs
Message-ID: <YdwyFmqs0MhU0wA6@ncase>
References: <cover.1638874287.git.ps@pks.im>
 <cover.1641556319.git.ps@pks.im>
 <0fbf68dbf434986aa971961e20598675b2194d51.1641556319.git.ps@pks.im>
 <xmqq1r1j3s0v.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YBqUv9WMkFkqCmWR"
Content-Disposition: inline
In-Reply-To: <xmqq1r1j3s0v.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--YBqUv9WMkFkqCmWR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 07, 2022 at 06:01:04PM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > When deleting refs from the loose-files refs backend, then we need to be
> > careful to also delete the same ref from the packed refs backend, if it
> > exists. If we don't, then deleting the loose ref would "uncover" the
> > packed ref. We thus always have to queue up deletions of refs for both
> > the loose and the packed refs backend. This is done in two separate
> > transactions, where the end result is that the reference-transaction
> > hook is executed twice for the deleted refs.
> >
> > This behaviour is quite misleading: it's exposing implementation details
> > of how the files backend works to the user, in contrast to the logical
> > updates that we'd really want to expose via the hook. Worse yet, whether
> > the hook gets executed once or twice depends on how well-packed the
> > repository is: if the ref only exists as a loose ref, then we execute it
> > once, otherwise if it is also packed then we execute it twice.
>=20
> If the ref only exists as a packed ref, what happens? ...
>=20
> > Fix this behaviour and don't execute the reference-transaction hook at
> > all when refs in the packed-refs backend if it's driven by the files
> > backend.
>=20
> ... We try to remove from the loose backend, which would say "nah,
> it did not exist in my store".  I am not sure if it should execute
> the delete hook in such a case for the ref.  But if it does not, not
> running the hook in the ref transaction for packed backend driven by
> the loose backend would mean nobody notifies the deletion of the
> ref, no?

This is shown in the test I've added, "deleting packed ref calls hook
once". We create a new reference and pack it such that it doesn't exist
as loose ref anymore, but only as a packed one. Updating that ref
would've caused us to execute the hook twice before, once via the
packed-backend and once via the loose-backend. With my fix we only
execute it once via the loose-backend, even if it doesn't currently know
it. This works because the loose-backend has to create a lock for the
nonexistent reference such that no concurrent call touches the same ref.

> To me, it seems that the only case this strategy would work
> correctly is when the files backend calls deletion hook for a
> request to delete nonexistent ref, which by itself sounds like a
> problem.

It does so only if the ref exists in either the loose or packed backend
though. If trying to update a ref which exists in neither of those, then
the reference transaction would fail with an "unable to resolve
reference" error in `lock_raw_ref()`.

So this should behave as expected: deleting a packed ref calls the hook
once, deleting a nonexistent ref fails and doesn't call the hook at all.

Patrick

> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  refs/files-backend.c             | 9 ++++++---
> >  t/t1416-ref-transaction-hooks.sh | 7 +------
> >  2 files changed, 7 insertions(+), 9 deletions(-)
> >
> > diff --git a/refs/files-backend.c b/refs/files-backend.c
> > index 3c0f3027fe..9a20cb8fa8 100644
> > --- a/refs/files-backend.c
> > +++ b/refs/files-backend.c
> > @@ -1261,7 +1261,8 @@ static int files_delete_refs(struct ref_store *re=
f_store, const char *msg,
> >  	if (packed_refs_lock(refs->packed_ref_store, 0, &err))
> >  		goto error;
> > =20
> > -	transaction =3D ref_store_transaction_begin(refs->packed_ref_store, 0=
, &err);
> > +	transaction =3D ref_store_transaction_begin(refs->packed_ref_store,
> > +						  REF_TRANSACTION_SKIP_HOOK, &err);
> >  	if (!transaction)
> >  		goto error;
> > =20
> > @@ -2775,7 +2776,8 @@ static int files_transaction_prepare(struct ref_s=
tore *ref_store,
> >  			 */
> >  			if (!packed_transaction) {
> >  				packed_transaction =3D ref_store_transaction_begin(
> > -						refs->packed_ref_store, 0, err);
> > +						refs->packed_ref_store,
> > +						REF_TRANSACTION_SKIP_HOOK, err);
> >  				if (!packed_transaction) {
> >  					ret =3D TRANSACTION_GENERIC_ERROR;
> >  					goto cleanup;
> > @@ -3046,7 +3048,8 @@ static int files_initial_transaction_commit(struc=
t ref_store *ref_store,
> >  				 &affected_refnames))
> >  		BUG("initial ref transaction called with existing refs");
> > =20
> > -	packed_transaction =3D ref_store_transaction_begin(refs->packed_ref_s=
tore, 0, err);
> > +	packed_transaction =3D ref_store_transaction_begin(refs->packed_ref_s=
tore,
> > +							 REF_TRANSACTION_SKIP_HOOK, err);
> >  	if (!packed_transaction) {
> >  		ret =3D TRANSACTION_GENERIC_ERROR;
> >  		goto cleanup;
> > diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction=
-hooks.sh
> > index f9d3d5213f..4e1e84a91f 100755
> > --- a/t/t1416-ref-transaction-hooks.sh
> > +++ b/t/t1416-ref-transaction-hooks.sh
> > @@ -175,16 +175,11 @@ test_expect_success 'deleting packed ref calls ho=
ok once' '
> >  	git update-ref -d refs/heads/to-be-deleted $POST_OID &&
> > =20
> >  	# We only expect a single hook invocation, which is the logical
> > -	# deletion. But currently, we see two interleaving transactions, once
> > -	# for deleting the loose refs and once for deleting the packed ref.
> > +	# deletion.
> >  	cat >expect <<-EOF &&
> > -		prepared
> > -		$ZERO_OID $ZERO_OID refs/heads/to-be-deleted
> >  		prepared
> >  		$POST_OID $ZERO_OID refs/heads/to-be-deleted
> >  		committed
> > -		$ZERO_OID $ZERO_OID refs/heads/to-be-deleted
> > -		committed
> >  		$POST_OID $ZERO_OID refs/heads/to-be-deleted
> >  	EOF

--YBqUv9WMkFkqCmWR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmHcMhUACgkQVbJhu7ck
PpRXMA/+KGbbInxtzHTIGEOIg/4Bgdkz4aI3bcMrrEYXewqLlMmvivNgbDwAqElw
9L5SV8UsrQSsERUGvRglOmGUcMKK5qLKVyz6YhGyFg8MOxu/dMJNAq0rB5P05/X+
HRqyr+o/3eREgev7ny3a3cCXPvajPnBTIQ9oy6z0cKrQ6efVUf1VY3VlcX8lI4E0
9hGvNRGi4WvphnZITMHeZbX+Fz3zsw8RrxsYLV5DpY9jG6I2omnFeNDrweiPSw1Z
cG6VTpNVkC/RmMLvK8gVSnL75qQB1Yjmq0a4pjpDqeTEe818zLXDMlcP6rtm8Tab
5JzWwb/j5mPQPvYblMM65gyLub+OcbUzNkjJA/KvDtDsVZW077aV9wzev1z9/a1L
rWclCmXGleSI4Bw0zyFPbpXBgdQpXv9hrZZcPpnK/wWFI1lRc/Z1YkRKFAzdvFWg
Hh6Dst3cRiiX2Na2WS/W+lMmr5OMPX4QCkdHcCmnOiSt04pmU1KWqb092Ml5dj9+
D+Jt3yjIrY+m04CZw0FDZ2k8PUaCwmJ47xiMUA/Qjf8o1UHzcJ2zX3Da0+Inl/kH
EG2n9j5/5UZEGaZctbBGqGpYSdTskdLlzr9e8eiFsnpq5S7bzE2B6uObd6v2W+rU
RfEJCqH/Zz4s63dC0RLBVZdKTeRExfOoN75GGBF2XWwjBAv7tRQ=
=kTh/
-----END PGP SIGNATURE-----

--YBqUv9WMkFkqCmWR--

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86538C433FE
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 08:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4081B22516
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 08:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbgLDIik (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 03:38:40 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:55033 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725969AbgLDIik (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 4 Dec 2020 03:38:40 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 684585C01E7;
        Fri,  4 Dec 2020 03:37:28 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 04 Dec 2020 03:37:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=XI3v0Wwtdrk3A9+Gwrk5dP+MePG
        r2/EPn+HkXNBMl5o=; b=w86DIYWjiQuBVhmM8/00Jn8zJUY8rRIQXkpIG/e5z70
        pEo+g94guOOL+gDqvCVVFEGg/TPSF8jH4ytnN1KuvBK51xtTLJVZoo1iTUgMboFf
        N+oAjKk2bJ2vaHzkVXJgqb7M75nT3Uz3/ApzncOFEvGOiX8ylKVdGTEkVnR7M776
        UUMRBhMXK9fld0IZCs86ap7BiPszW6/vXh5nOtYwMWG8eCXieRXRfqFpy+o+u7Af
        OwbE/wUPBeVq33XarIN9adIUFSom6vrN5pYqo/+wUtdd8G3b4n2ote3nedDhr+JD
        0OZ+HE42A22LhDP9BdY2h39Oc5Qzhu/SeBcQDzGybMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=XI3v0W
        wtdrk3A9+Gwrk5dP+MePGr2/EPn+HkXNBMl5o=; b=FYIH1gCjdWj8y8plHa7HWu
        W0GzNtfoLi6M54lq23aSAiNAgLyW3pnbibaoG2HFzWIn0bSU86VyBhFF6yQabbDX
        2LpYAKiGUGeoxgQOE/oEQUDfYnlhVmgUyMt57mV+3WAkn+VGYlcm7vy/tWxAfUHk
        VcnbW/y4+rED/tlTL+2SyPHG1a/9TUmKeKglDx+PtnnPQxcIrgswwYz6UhlX3pig
        Q0EOerJGaoHBgP3r1RPeVIGl1ysq0IYWzJHA385RL6SOQSkqG1uNfEai0dkSLJWH
        g/NWYQyxmAf/nD/goqTnaLG0v3SwAtA0IJG2C/3p9RI+goEXI7iFysTllHU063Dw
        ==
X-ME-Sender: <xms:R_XJX0ofMNfX25ZNcf_CTFpPxJjRvgVIqTaNo5fapSYGUHnz4ja45Q>
    <xme:R_XJX6rqxycy6FlSLdqfO7nrPBm4Vsp5UpmP_W__4JYPvXa4mrCmgnZwuEjiKl-57
    SjOpf8BGxqpOELLhg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeijedguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtd
    fhvdejkedthfehvdelgfetgfdvtedthfenucfkphepjeejrddukeefrdeffedrudefheen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:R_XJX5P-C0U4yzN66RQln8t3achA9dubWfitqgfcBzhwLZML53S9VA>
    <xmx:R_XJX77iOptdxcvBtfAF0Qzw3WlcXFItYqBtxfPhJZFzTy59i3isGQ>
    <xmx:R_XJXz4DNQexJzTQanb5xAuAzXbMgaalGqjuiU5gpVZOoFR94zCs_w>
    <xmx:SPXJX9RHOHhhguIX4AS6aBwt31--jLxHtRw5SY8wcbFwzFs_in6jSw>
Received: from vm-mail.pks.im (x4db72187.dyn.telefonica.de [77.183.33.135])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1F5ED108005B;
        Fri,  4 Dec 2020 03:37:27 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 603e8130 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 4 Dec 2020 08:37:22 +0000 (UTC)
Date:   Fri, 4 Dec 2020 09:37:21 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     peff@peff.net, me@ttaylorr.com, gitster@pobox.com
Subject: Re: [PATCH] refs: Always pass old object name to reftx hook
Message-ID: <X8n1Qf7TJyqIOE/l@ncase>
References: <d255c7a5f95635c2e7ae36b9689c3efd07b4df5d.1604501894.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w01lz+/3DHZUZC8y"
Content-Disposition: inline
In-Reply-To: <d255c7a5f95635c2e7ae36b9689c3efd07b4df5d.1604501894.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--w01lz+/3DHZUZC8y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 04, 2020 at 03:58:40PM +0100, Patrick Steinhardt wrote:
> Inputs of the reference-transaction hook currently depends on the
> command which is being run. For example if the command `git update-ref
> $REF $A $B` is executed, it will receive "$B $A $REF" as input, but if
> the command `git update-ref $REF $A` is executed without providing the
> old value, then it will receive "0*40 $A $REF" as input. This is due to
> the fact that we directly write queued transaction updates into the
> hook's standard input, which will not contain the old object value in
> case it wasn't provided.
>=20
> While this behaviour reflects what is happening as part of the
> repository, it doesn't feel like it is useful. The main intent of the
> reference-transaction hook is to be able to completely audit all
> reference updates, no matter where they come from. As such, it makes a
> lot more sense to always provide actual values instead of what the user
> wanted. Furthermore, it's impossible for the hook to distinguish whether
> this is intended to be a branch creation or a branch update without
> doing additional digging with the current format.
>=20
> Fix the issue by storing the old object value into the queued
> transaction update operation if it wasn't provided by the caller.
>=20
> Signed-off-by: Patrick Steinhardt <ps@pks.im>

Quick ping on this patch. Is there any interest or shall I just drop it?

Patrick

>  Documentation/githooks.txt       |  6 ++++++
>  refs/files-backend.c             |  8 ++++++++
>  refs/packed-backend.c            |  2 ++
>  t/t1416-ref-transaction-hooks.sh | 12 ++++++------
>  4 files changed, 22 insertions(+), 6 deletions(-)
>=20
> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
> index 4e097dc4e9..8f3540e2f6 100644
> --- a/Documentation/githooks.txt
> +++ b/Documentation/githooks.txt
> @@ -492,6 +492,12 @@ receives on standard input a line of the format:
> =20
>    <old-value> SP <new-value> SP <ref-name> LF
> =20
> +where `<old-value>` is the old object name stored in the ref,
> +`<new-value>` is the new object name to be stored in the ref and
> +`<ref-name>` is the full name of the ref.
> +When creating a new ref, `<old-value>` is 40 `0`.
> +When deleting an old ref, `<new-value>` is 40 `0`.
> +
>  The exit status of the hook is ignored for any state except for the
>  "prepared" state. In the "prepared" state, a non-zero exit status will
>  cause the transaction to be aborted. The hook will not be called with
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 04e85e7002..5b10d3822b 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -2452,6 +2452,9 @@ static int lock_ref_for_update(struct files_ref_sto=
re *refs,
>  				ret =3D TRANSACTION_GENERIC_ERROR;
>  				goto out;
>  			}
> +
> +			if (!(update->flags & REF_HAVE_OLD))
> +				oidcpy(&update->old_oid, &lock->old_oid);
>  		} else {
>  			/*
>  			 * Create a new update for the reference this
> @@ -2474,6 +2477,9 @@ static int lock_ref_for_update(struct files_ref_sto=
re *refs,
>  			goto out;
>  		}
> =20
> +		if (!(update->flags & REF_HAVE_OLD))
> +			oidcpy(&update->old_oid, &lock->old_oid);
> +
>  		/*
>  		 * If this update is happening indirectly because of a
>  		 * symref update, record the old OID in the parent
> @@ -2484,6 +2490,8 @@ static int lock_ref_for_update(struct files_ref_sto=
re *refs,
>  		     parent_update =3D parent_update->parent_update) {
>  			struct ref_lock *parent_lock =3D parent_update->backend_data;
>  			oidcpy(&parent_lock->old_oid, &lock->old_oid);
> +			if (!(parent_update->flags & REF_HAVE_OLD))
> +				oidcpy(&parent_update->old_oid, &lock->old_oid);
>  		}
>  	}
> =20
> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index b912f2505f..08f0feee3d 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> @@ -1178,6 +1178,8 @@ static int write_with_updates(struct packed_ref_sto=
re *refs,
>  						    oid_to_hex(&update->old_oid));
>  					goto error;
>  				}
> +			} else {
> +				oidcpy(&update->old_oid, iter->oid);
>  			}
> =20
>  			/* Now figure out what to use for the new value: */
> diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-h=
ooks.sh
> index f6e741c6c0..111533682a 100755
> --- a/t/t1416-ref-transaction-hooks.sh
> +++ b/t/t1416-ref-transaction-hooks.sh
> @@ -52,12 +52,12 @@ test_expect_success 'hook gets all queued updates in =
prepared state' '
>  		fi
>  	EOF
>  	cat >expect <<-EOF &&
> -		$ZERO_OID $POST_OID HEAD
> -		$ZERO_OID $POST_OID refs/heads/master
> +		$PRE_OID $POST_OID HEAD
> +		$PRE_OID $POST_OID refs/heads/master
>  	EOF
>  	git update-ref HEAD POST <<-EOF &&
> -		update HEAD $ZERO_OID $POST_OID
> -		update refs/heads/master $ZERO_OID $POST_OID
> +		update HEAD $PRE_OID $POST_OID
> +		update refs/heads/master $PRE_OID $POST_OID
>  	EOF
>  	test_cmp expect actual
>  '
> @@ -75,8 +75,8 @@ test_expect_success 'hook gets all queued updates in co=
mmitted state' '
>  		fi
>  	EOF
>  	cat >expect <<-EOF &&
> -		$ZERO_OID $POST_OID HEAD
> -		$ZERO_OID $POST_OID refs/heads/master
> +		$PRE_OID $POST_OID HEAD
> +		$PRE_OID $POST_OID refs/heads/master
>  	EOF
>  	git update-ref HEAD POST &&
>  	test_cmp expect actual
> --=20
> 2.29.2
>=20



--w01lz+/3DHZUZC8y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/J9UAACgkQVbJhu7ck
PpRT5RAAiBssWf8kaSlSurRqQAHC6o484VnWJv+RRUHeBwnsQFuW5Ajf9S7YCN/t
DqJ0Y6uw5ejM0I5qUdEpU8U2k0KZ9fAQ+l9p4Hb83Z+aUrqToURVViv3VfJ1VVxv
An03QbeZG57JKu0GZKdn3dMbRveifHSE2Ensv11Q6lWBrcB7P4pLWYTub7tH8bja
Qt15aC5O0SMgDvyL8iMD8jlE9qyk66Nyr1ORxzzYLmvZiXxC2bXb7flOeynJCnMx
JfOAxmjds05gHHTJw7513IOuJWKwPieFGzf8G5ozWY45f+yCZ6z1do24VU/QRmEk
GRK39139uI/G9M+/5+mWlqcdLSCPnRDwIItYnaWH1MWyIbcvoXgBW2TK2RfcK8Rx
EAIDTEvHe71UAmtmViP7JSfKQntnaKo/NMX8icSvxkiLELIfiDFROOhn3pIF4oyw
HsQf5IvLEzg8+1ODBWOkapqOHWYwdgxwhE7uDBbQnuyNy7N9yKiI9tYUY8qo7Db1
TUzZ3kHHjyCprfH48h2n5wCyLcp0FmUyKqQSf6FwZ5EP/RKFtn95vsvSauQMacbz
HMgyEh7WGUyCr+gK6b92NObIz/Ml9eHtvAA5u0obbSNiEAMpOGnbWYwPKP1J45uD
QCBJjPI/Q63lFZpzT+4rKpdKJXhW3u7vTgrWqEy77u1uhCR1lpk=
=aLoL
-----END PGP SIGNATURE-----

--w01lz+/3DHZUZC8y--

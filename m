Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FFFC433DF
	for <git@archiver.kernel.org>; Wed, 20 May 2020 22:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B894A20873
	for <git@archiver.kernel.org>; Wed, 20 May 2020 22:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="lftDAmQv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbgETWiN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 18:38:13 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38544 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728190AbgETWiN (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 20 May 2020 18:38:13 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 22A716045A;
        Wed, 20 May 2020 22:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1590014262;
        bh=+rpw/oq1gOadHKDQcAe4INgZY1SMBB1+lhdqgF6STo0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=lftDAmQvrGWpwNQUzHcRyWvJ7l8k8i/lm1LU6YmPd1jsQ/O7OnKA1gWJ/7ChIARqY
         ZWLjZM26kf0YSNA3br31M/QHsUJ7Oyv3uaUOkW30li9LfeYB1qmS1TUAhHeAWCGUfD
         Nx/0S/GL9aCqQy4J8fngdB2kJGYF8Xo5siRXqc37cteGPtj2Hrj2ef4QL18A3m6KrJ
         NQn226hCWGJ+CnmyBwaOt5QDIaUq/PFns5r0qhk8gDtLtZLgQ5J2TKMq1MCh3tRFg+
         1XJlge6KvKqG1GN3OsmAUQ/Lt6dE3QBK6SJ+k/D28K4CJNn6F8uobB5STkr9BsjRHY
         RpuWZmI1g5131duD4IA6Zr1S3fbrllo+z8cLzOsTB3P7DuX6YwMcfuSKh6KAh1pvjP
         meE/PSOMe7NkL4IRturyt2GTD5agyQVxPKVGBrhNFRRCuEtTgnBNYOzKFzRa5y1sl/
         DaxXbshDSNxNQmzU2186FWAzEHMDv+5ygmfmVHH339j4KeLd/En
Date:   Wed, 20 May 2020 22:37:37 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] builtin/checkout: simplify metadata initialization
Message-ID: <20200520223737.GT6362@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Derrick Stolee <dstolee@microsoft.com>
References: <ef72aedf-4264-e386-9563-050c54483c93@gmail.com>
 <20200520014156.1570124-1-sandals@crustytoothpaste.net>
 <xmqqmu62ws88.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="R0SsnouPYaG+7rP6"
Content-Disposition: inline
In-Reply-To: <xmqqmu62ws88.fsf@gitster.c.googlers.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-1-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--R0SsnouPYaG+7rP6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-05-20 at 15:17:43, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > When we call init_checkout_metadata in reset_tree, we want to pass the
> > object ID of the commit in question so that it can be passed to filters,
> > or if there is no commit, the tree.  We anticipated this latter case,
> > which can occur elsewhere in the checkout code, but it cannot occur
> > here, since reset_tree is called only (indirectly) via switch_branches,
> > which requires that we have a valid commit.  switch_branches dies if we
> > lack a name and cannot produce a commit from HEAD, and its caller dies
> > if we do have a branch name but still lack a commit pointer.
> >
> > Since we know we must always have a valid commit structure in this case,
> > let's remove the dead code paths and just refer to the commit structure.
> > This simplifies the code and makes it easier for the reader.
>=20
> builtin/checkout.c::merge_working_tree() has these lines in its
> earlier part:
>=20
> 	if (opts->new_orphan_branch && opts->orphan_from_empty_tree) {
> 		if (new_branch_info->commit)
> 			BUG("'switch --orphan' should never acc...");
> 		new_tree =3D parse_tree_indirect(the_hash_algo->empty_tree);
> 	} else
> 		new_tree =3D get_commit_tree(new_branch_info->commit);
> 	if (opts->discard_changes) {
> 		ret =3D reset_tree(new_tree, opts, 1, writeout_error, new_branch_info);
> 		if (ret)
> 			return ret;
> 	...
>=20
> So, when orphan && orphan-from-empty are both set, we must not have
> commit, and then if discard is also there, we end up passing
> new_brnach_info that has NULL in its commit.

Good point.  I missed that part.

> Perhaps the "orphan && orphan-from-empty" is a dead combination and
> we won't hit the codepath and that is why this change is safe?  I
> dunno.

It looks like it's only triggered from git switch with --orphan, not
with git checkout.  And furthermore, it seems we require --force or
--discard-changes to trigger that case, which we don't have anywhere in
the testsuite.

I'll come up with a different patch.  I'll probably just set a NULL
object ID there, since if we're checking out a new orphan branch, we
won't have any files to check out, and therefore there's no possibility
that we'll actually use the value for a filter process (since there are
no files to filter).
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--R0SsnouPYaG+7rP6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXsWxMQAKCRB8DEliiIei
gYNaAQCWk3EEcGsUFF0bzNfeO2FpvXsvA3vPG4nlVBYFUnlRswD/ZHyTzjOvPVBr
ILS8Xioo4OkrmXq0T5PesujpoW29VgU=
=5cZx
-----END PGP SIGNATURE-----

--R0SsnouPYaG+7rP6--

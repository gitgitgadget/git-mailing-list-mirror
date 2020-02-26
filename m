Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84D5C4BA06
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 02:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9E1924670
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 02:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="mkbWZvTq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729702AbgBZCjP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Feb 2020 21:39:15 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41528 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727880AbgBZCjP (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 25 Feb 2020 21:39:15 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A51BF60791;
        Wed, 26 Feb 2020 02:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1582684753;
        bh=r8b3OSIFe2R2dgNzbOKb9GTm6JV6ZL7ERGX91q289Cw=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=mkbWZvTqChrYqw1UwYJk1B5TyJR5+YaDqlcC1N6zKR/z1mmO29uIm7jBmoGxkVwyO
         ltUKLiPuwlXyoUtQVW8Y3WSHnMdKXj8Xj7ziZAQfbTMwzm2hW6iaDXXTJ9xJMl4zcS
         diRG6C8JMbFRHVKKP04V5mVpW3s4cU1Zi2soyZckdRY4VLX2dhaHGdzsZDyfVcRiQt
         TsmzlwA/1FX+aNz7nEH5HvAtiWBFtizcHFfCCZ9cxOu38Hai2lcHGsZWmTnW8f+D2Z
         /mzKGzZLpWOLh333KZtKMQdShNUSQ80xaHJR8nqlo/2dZjvFJYoBwIM/Ywl5NIYmw6
         u/TIDNB//qcUpt0Gc5kS1coSgfISM1BTWnkEUKqxAbArzYkamknCjZVWmSEX02IdEu
         k6uez3Dawl+itKTOFv9MedjWNPAhHgbN8wbTHvd852csr7JWwHEVx2yGWWn9XuRwhy
         zGSPz3fsArFeYUtzN+UuRNn8tDYH6leZWgESXmkD8q6RhEvReXq
Date:   Wed, 26 Feb 2020 02:39:09 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Chris Jerdonek <chris.jerdonek@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: create reflog for reflog-less ref
Message-ID: <20200226023909.GC7911@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Chris Jerdonek <chris.jerdonek@gmail.com>, git@vger.kernel.org
References: <CAOTb1wc2uMSyc7DMau2cWrWtk=_Z94+CCovORj1dGCrwgJhL=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oJ71EGRlYNjSvfq7"
Content-Disposition: inline
In-Reply-To: <CAOTb1wc2uMSyc7DMau2cWrWtk=_Z94+CCovORj1dGCrwgJhL=w@mail.gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.4.0-4-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--oJ71EGRlYNjSvfq7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-02-26 at 01:07:35, Chris Jerdonek wrote:
> Hi,
>=20
> I wanted to ask on this list if there are any supported ways to create
> a reflog for an existing ref that doesn't already have a reflog.
>=20
> This is more likely to come up for refs not in the standard set (i.e.
> HEAD, branches and remote-tracking branches), since reflogs aren't
> created by default for those refs.
>=20
> The only workaround I could think of is using git-update-ref to delete
> the ref, and then immediately recreate it using the `--create-reflog`
> option (if that option is needed), e.g.:
>=20
> $ git update-ref -d refs/foo/bar
> $ git update-ref -m "my message" --create-reflog refs/foo/bar <SHA>
>=20
> This seems hacky though because it forces you to pass through a state
> where the ref no longer exists. It also requires you to get the ref's
> SHA first.
>=20
> This Stack Overflow reply from 2016 suggests the idea of using `git
> update-ref -m MSG REF REF` to add lines to an existing reflog:
> https://stackoverflow.com/questions/36770141/can-i-add-a-line-to-the-refl=
og/36778898#36778898
> But it doesn't seem to work to create a reflog (and only seemed to
> work for me in limited circumstances otherwise, like adding to HEAD's
> reflog). (I tried with version 2.25.0.)

There is the option core.logAllRefUpdates, which has the value "always"
in more modern versions of Git.  The documentation says,

  If [the option is set to always, then a missing reflog is
  automatically created for any ref under refs/.

Now, that assumes that you want reflogs for all your refs, but there's
really not much downside to having a reflog and not using it.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--oJ71EGRlYNjSvfq7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXlXaTAAKCRB8DEliiIei
gXuRAQDxLoJf4m1CMtEmLYiB6rw3XffV8ByekyC5CO9bwodCQQEA+qW+aVoWzBJ0
tzCAELjm7tiWTG6x6Qo6WfaGuHkpbA4=
=sX2i
-----END PGP SIGNATURE-----

--oJ71EGRlYNjSvfq7--

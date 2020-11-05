Return-Path: <SRS0=KwJF=EL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD26C2D0A3
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 03:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2C1F20719
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 03:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388538AbgKEDMb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 22:12:31 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34854 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388534AbgKEDMa (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 4 Nov 2020 22:12:30 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C0CB26044F;
        Thu,  5 Nov 2020 03:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1604545919;
        bh=8AbaF54a7P6lJIeKxuM1kx3BBPp76e5p4c5u0m9nf00=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=fsUIP4utyOpma7ZDfTYSYL8wyqKsQ2DeW30YAg3fliP56YGVCmjbFGQ50KGktTxJT
         LeGc+OzqvxsZYBr3/dnVhpaEXMksT9Sdq2wsiSHYzo4pJUY3+fTE/AQuG9bWsaLyDm
         nyCwt7f+Za6imuzSYGcJjVFcFIEaFqumJB5wtlEBPzKgTtpxGOw5ExW5F9Fp/8yTwu
         hG8LKry4dGOQ81TRJ2iptYfkxJGAt3wVR1SuNebM7SNHixTWAyKdQFCbJoMu01Ad/g
         AGCeFAVlhpO0s8cHJLXb2KN2vHvGq93Alu2Dibt/wFIM+Kdl/DGvwkqZFrJM0kyxON
         iWgKnkl9H8sV2KJzeJwN/S5pX7mik8KrfKyroSbMRRXcgxyRKn5JKP5OFL7P6G5jCj
         SVfDXQuAowQ3f8GSwYaU5PlUlwkHysdZHgXzKGwu5xS3MelKHmHRF/xlRvtxoT5/lu
         WEdNMnSXX16Ep4yLqf7JF5qaGThjusaXS+AQEE4jp8eVY5+4GbV
Date:   Thu, 5 Nov 2020 03:11:53 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rev-parse: add option for absolute or relative path
 formatting
Message-ID: <20201105031153.GA1332931@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20200908185017.2005159-1-sandals@crustytoothpaste.net>
 <20201104221659.GA3183353@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
In-Reply-To: <20201104221659.GA3183353@google.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-11-04 at 22:16:59, Jonathan Nieder wrote:
> brian m. carlson wrote:
>=20
> > This impetus for this patch is Git LFS, which is written in Go.  Go
> > lacks a cross-platform way to canonicalize paths in the same way that
> > Git does, so when Git produces relative paths, such as in some cases
> > with --git-common-dir, we end up with problems when users are doing
> > things with unusual paths on Windows, such as when using SUBST or
> > OneDrive or various other edge cases.  Go upstream does not appear eager
> > to address this problem.
>=20
> Can you describe the user-facing symptom?  While reviewing
> https://lore.kernel.org/git/20201009191511.267461-1-sandals@crustytoothpa=
ste.net/
> I'm trying to understand the motivation and I'm getting stuck at
> trying to understand the basics of the problem being solved.
>=20
> E.g. is this about being able to compare paths, being able to open
> files, resolving symlinks, something else?

The goal is to resolve paths the way Git does and allow verify that a
path is within the repository.

Some paths, such as SUBST drives, are canonicalized by Git using
GetFinalPathNameByHandle, which is the standard way of canonicalizing
paths on Windows.

Go provides filepath.EvalSymlinks, which does not handle these paths,
and consequently, a check that a given path is within the repository (or
git directory) fails because Go sees the path as being on one drive
(after canonicalization) and Git sees the repository as being on
another.  This is in part because the .git directory we've canonicalized
in Go is totally different from the path that Git has for it, and
consequently they aren't comparable.

That's the user-facing symptom.

There are a variety of other Windows paths that are handled differently
as well beyond the SUBST paths.  I'm not an expert on Windows or Windows
paths, so I can't enumerate all the cases where one case works and the
other fails.  Ideally Go would learn to canonicalize paths the way the
system does using a cross-platform function.  I believe there's an issue
upstream to deal with this at https://github.com/golang/go/issues/42201.

This is also generally applicable for scripting, where realpath(1) is
not always available (e.g., on macOS), but mostly this is here to make
Windows work more nicely, since it has more complex path functionality.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX6NteQAKCRB8DEliiIei
gfIxAQCWonZbtW7EYtlPyrfJOXddyLfewUG6bgM9pPQSZh0JLwEA5fWyIC3dhsF6
JuxdKXjyQULvwDSlYTRQICOkbcVy/gQ=
=XtDb
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--

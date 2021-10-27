Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205BAC433F5
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 22:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F11A960E76
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 22:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbhJ0WKc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 18:10:32 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:42678 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230000AbhJ0WKb (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 27 Oct 2021 18:10:31 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 61EDD60423;
        Wed, 27 Oct 2021 22:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1635372484;
        bh=A12+Q9ZYc3nXEXgR69PEoOW3sTfbFRJT/k7h2NZ8yOI=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Fs4GbYgmjGA2nGwq1g4t8EwY0+oRL2QFtkl1512REvsXRq02FEDrj8ySGPGfPRt3r
         VAyQZP4mIFL+lpVLub5/OiJ67wUjDh8qSjl0ubTFSpgMuVJtL3zJUH26m4Hwz63XsZ
         Zdem+Vl9PFP5KNkBMPF1Dqt8kd2a2Bw+GEMZQ9V2oFaUC1/BZWyNcWYSL813YDswQA
         cNvNYnumjKStI6Afurw+tHflRAbRcx9Vo647hYsPIe6sfCkbnW/RbiuzklrQ+iMZpl
         6rprXYS+ceCZv19F5S0+pN9D70j/7hM045acK6l37pAdpDdZzF5CFWHuIjGpWtmR2j
         PDHJ0+X86ymrk3K5fEcusrq25TqPR1zZY+nAVrkjEM0zZZKvbG4pOjidTLe8LEptXR
         Ehd+UQX7Y/aOFCpBPA9nNutwujYJkjGnnogQKo2KNcwplZd3qAwJ7iVmSRe93pvauO
         Z2qeuikHGwu1SgeCzqCWU7TExPvyULGyoqSX2ZHqqTdsEksYGpR
Date:   Wed, 27 Oct 2021 22:07:59 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Peter Hunkeler <phunsoft@gmx.net>
Cc:     Git Mailinglist <git@vger.kernel.org>
Subject: Re: Git not commiting anything if file created and "git add"ed in
 pre-commit hook is the only file in the staging area
Message-ID: <YXnNvyi62j5gcxQV@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Peter Hunkeler <phunsoft@gmx.net>,
        Git Mailinglist <git@vger.kernel.org>
References: <0165d68f-79a7-d8b7-1bba-89a1449e87a7@gmx.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EiKZsEErYLv5CzPP"
Content-Disposition: inline
In-Reply-To: <0165d68f-79a7-d8b7-1bba-89a1449e87a7@gmx.net>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--EiKZsEErYLv5CzPP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-10-27 at 19:03:49, Peter Hunkeler wrote:
> Hi,
> Git seems to behave inconsistently when creating and "git add"ing
> content (files) from within a pre-commit hook. It claims there is
> "nothing to commit", if the stating area was empty before the commit
> command. Otherwise, the new content becomes part of the commit. See
> details on how to reproduce and a log of the individual steps below.
>=20
> Regards
> Peter
>=20
>=20
> =3D=3D=3D Amended Git bug report
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>=20
> What did you do before the bug happened? (Steps to reproduce your issue)
>=20
> I'm quite new to using git, so please bear with me should I mix up some
> terminology.
>=20
> I need some new file to be created at each commit. The new file must
> become part of the commit.
> I thought a git pre-commit hook would be the appropriate place. While
> the file is created as desired,
> git does *not* include this new file in the commit, when there is
> nothing else in the staging area. It
> reports the new file as being untracked, and says nothing added to
> commit. A git status immediately
> thereafter does, however, show the new file in the staging area. If I
> run another commit just now, another
> new file is created as expected, but this time, git adds them both to
> the commit. This can be reliably
> reproduced by repeating 'git commit -m "empty"', and every second time,
> the commit is done.
>=20
> Further testing shows that the newly created file *is* added to the
> commit, *if* at least one other change
> was registered to be commited (git add some time before the git commit).

Yes, this occurs because the first thing we do is invoke the pre-commit
hook.  It passes, and then we consider various reasons why we should not
commit: the hook failed, there's nothing to commit, etc.  We discover
one since we haven't re-read the index yet and last we saw there was
nothing to commit, so we abort.

There's a giant comment before we re-read the index that says this:

		/*
		 * Re-read the index as pre-commit hook could have updated it,
		 * and write it out as a tree.  We must do this before we invoke
		 * the editor and after we invoke run_status above.
		 */

The commit history does not explain why we must do this _after_ invoking
run_status, but if the comment is incorrect and we re-read it
immediately, then this problem would go away.  I lack the relevant
context to determine whether this is appropriate, but if folks think
this is advisable, then I can write up a patch this weekend.  It should
be relatively trivial.

I should point out here that it isn't intended for pre-commit hooks to
be used this way; they're intended to verify that the commit meets some
standards, not to modify it, although it is of course possible to do.

This will happen to work in your case if you use --allow-empty, which
will bypass the "nothing to commit" check.

> The git pre-commit hook looks like this (indented for readability, only):
> =C2=A0=C2=A0=C2=A0 #!/bin/bash
> =C2=A0=C2=A0=C2=A0 fn=3D"folder1\folder1_file3_$(date +%Y%m%d_%H%M%S).txt"
> =C2=A0=C2=A0=C2=A0 echo "some text" > $fn
> =C2=A0=C2=A0=C2=A0 git add $fn

In general, you want to avoid adding automatically generated files to
your repository.  That tends to bloat the repository needlessly and is a
great way to lead to frequent, hard-to-resolve merge conflicts.

You may also want to read the =E2=80=9CHow do I use hooks to prevent users =
=66rom
making certain changes?=E2=80=9D in gitfaq(7) and note that hooks can be
bypassed on developer systems, so whatever changes you make in a hook
aren't guaranteed to be applied unless you're the only one working on
the repository.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--EiKZsEErYLv5CzPP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYXnNvQAKCRB8DEliiIei
gViNAQCvoIVbppb1d2miCxlgurTSX9BUZ1boLyvpz9t2LdLUHgD+JnzpKHWNVRzC
0FMeID/JD6oh0UDvk/ftxEquEB/nwg8=
=oXcF
-----END PGP SIGNATURE-----

--EiKZsEErYLv5CzPP--

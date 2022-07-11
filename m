Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E13C433EF
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 21:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbiGKVkg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 17:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbiGKVkJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 17:40:09 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CEE823B6
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 14:40:07 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 62ADE5A1BA;
        Mon, 11 Jul 2022 21:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1657575606;
        bh=BK34/bmJh3d2/jzbgw04FhCELccGs0th+miwwrIF5+c=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=xw5RdPe6L14zsQIxcAz+UaMs1vRwByuE8ZVEPbtcnsg1rwGvQW+8+iQ1aa6Le5ark
         Ym0uSr4LU4Bc67iC5W+a2UX/p98i2ILQhZBMyCfODFitrqWJSPt50sZ0KyJntrKLVv
         oRFS3HoI+qlndmf0RnwAiT1rbPjxB+7E6NHKvZ4cOUpZa3Epk3Jt6VMtk7W/m6pC4x
         0gAWuwZQmvBPwyND16lNGrMcuAOMhEPTsFGdPK9Vd8a/CX6ewLAgUMZ8uPZ5X0hWx8
         NSFtvW8GF4fS356cQzUfblpAQNcY4XosvUeturQNtD937ciMPidrTyHFhoxOHn3ad9
         ODyvOJmfXs2EbHL3bW1BLluDqeDZ/thQOzeJJpBiJd9urHcz/1Bo0A3wwnXCy4G1Zv
         BAaBxq4h8j3/OdYVicGgi1sjGEC+9AYP/xE9S7soObS0RYVUw77htsxRJCi6lpcXHH
         U+IwJhTBqZkSoNqLiuwwGSJ8CneCNCyu6h3mA3YeUykiS0Pk53h
Date:   Mon, 11 Jul 2022 21:40:04 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Gerriko io <gerriko.iot@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Revert and reset and very damaging Git commands
Message-ID: <YsyYtOIpIU29OMN/@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Gerriko io <gerriko.iot@gmail.com>, git@vger.kernel.org
References: <CALF=2AMDTa48sYdrPjc_i9UyaZfvGKhR9OvknYfLywgtj8AM_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vXn8vVmQNpx2LwkC"
Content-Disposition: inline
In-Reply-To: <CALF=2AMDTa48sYdrPjc_i9UyaZfvGKhR9OvknYfLywgtj8AM_g@mail.gmail.com>
User-Agent: Mutt/2.2.4 (2022-04-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--vXn8vVmQNpx2LwkC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-07-11 at 19:52:05, Gerriko io wrote:
> As a noob I have managed to completely delete all my local folder
> contents just by misusing reset and revert commands. Un-be-lievable!
> And no matter how many times I've tried I cannot return to where I
> was. The git reflog is not that helpful either... and only shows
> resets and not revert histories.

The reflog should indeed keep track of every revision that's checked
out, including reverts.  Reverts act as an additional commit on top of
your code, so they are part of your history.  You can use `git log` or
`git log -p` to view the history of the current branch, including any
reverts.

If you want to check out a file (say FILE) from an older revision (call
it REV), you can do `git checkout REV FILE`, and that will stage that
copy of the file and place it in the working tree.  That can be useful
to recover an older version when you've done a revert (or even when you
just want the older version back).

If you have files you've blown away with `git reset --hard` and you've
added them to the repository, they can be recovered by using `git fsck
--lost-found` to store them into `.git/lost-found` if they're not
referenced by your history.  If they are referenced by your history,
then they can be accessed using `git checkout` as I mentioned above.  If
they've never been added, then they're gone for good unless you use some
sort of deleted file recovery software.

> Gosh this is not good.
>=20
> Why are these commands bypassing all the fundamentals of a computer
> OS. Surely if a file is deleted it should end up in the computer's
> rubbish bin. Not deleted permanently without a trace.

In general, the programmatic interfaces used to create and delete files
don't use the user trash can.  That's because many programs create and
delete extremely large numbers of temporary files (Git included) and it
would be silly to expose those to the user, since the user trash can is
designed to handle files that the user specifically might want to
recover.  There is also no standard portable interface for placing files
into the user trash can, while there are standard portable interfaces
for actually removing files.

Also, traditionally, on Unix systems, deleting files has happened
without prompting, and Git is designed for Unix systems.

> If that is the intent then there needs to be warnings etc. for deletes
> and overwrites.
>=20
> I'm just amazed that all the basics of software design are ignored for
> the sake of convenience and speed.

Git is a command-line tool.  Command-line tools on Unix perform the task
as specified silently unless there's an error.

If Git prompted when using `git reset` for each file, then it would be
unusable in a script, and people do frequently use Git in scripts.
Also, when using something like `git clean` to clean build artifacts,
there might be tens or hundreds of thousands of build files, and nobody
would want to be prompted for each one.

In general, you need to be very careful with `git reset` and very
especially with `git reset --hard`.  The latter does blow away files
without notice and is very dangerous if you're not careful.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--vXn8vVmQNpx2LwkC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.35 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYsyYtAAKCRB8DEliiIei
gSbrAP43slpmNOk2U8uqs19kzOG4AFqpTOEmrUE8+hFEY2FKBwD/YpBpeS+21WhK
D/jaZiaaQiA3mRFCzOM+aktU4Y6eiQw=
=sDzi
-----END PGP SIGNATURE-----

--vXn8vVmQNpx2LwkC--

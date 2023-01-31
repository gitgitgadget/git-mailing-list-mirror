Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9858AC636CD
	for <git@archiver.kernel.org>; Tue, 31 Jan 2023 09:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbjAaJzD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Jan 2023 04:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjAaJzC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2023 04:55:02 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BCD15267
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 01:55:01 -0800 (PST)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 9F3245A300;
        Tue, 31 Jan 2023 09:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1675158899;
        bh=eyZkyy75M62Bau3aon/mMUYAzD3fOC4Zrnunv8JFKlQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=0NYR9QuJBGSAGUo/dYykTOH93HQzHe6KPhCkf82yfc5DMowblkMhcgllGs0IFqh7b
         MYsj6t4W4jBLzXYOnk5lDfZW8InfjN0e4aVq5MBxfdNZbx03nqrjSd0GqTtrsLmvb6
         H8hdKVIv5sxE5r4Q5L0nAzK8u9BJNOPXrfbOyN44ol7+sHejhvPPzxeQxNLHFb7Xfu
         FKgtENRFtp8/7syfGcRy9DdquAdBs9IxABarP5ggmP8i/yrTFjAZYSTrS+cHwJohNt
         z4f0xWfET/ovEaryJXD8+1xiu82qyY29g38fiIg3CstxEZTKjNdacV5uNOLiNSton6
         JFXpAPpl/eMst1EEAAb5Fiw+zIYgS/ia3nWV0nzAP6qMKWrZoxD1twPBSOvOW78NQX
         It/Eo8d9M69T1NI9Ms6kH8Lmz3qdV2OFfbseLA4O3eYy/U+UM1rgHZxozNm8Brgonj
         ctv9A0COLIoCJApC/fCC0yiJgux2/65eOG9tr5+/UghwUtGuaQf
Date:   Tue, 31 Jan 2023 09:54:58 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eli Schwartz <eschwartz93@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: Stability of git-archive, breaking (?) the Github universe, and
 a possible solution
Message-ID: <Y9jlWYLzZ/yy4NqD@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eli Schwartz <eschwartz93@gmail.com>,
        Git List <git@vger.kernel.org>
References: <a812a664-67ea-c0ba-599f-cb79e2d96694@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SxQ3pe07gVIaINxs"
Content-Disposition: inline
In-Reply-To: <a812a664-67ea-c0ba-599f-cb79e2d96694@gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--SxQ3pe07gVIaINxs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-01-31 at 00:06:44, Eli Schwartz wrote:
> Nevertheless, I've seen the sentiment a few times that git doesn't like
> committing to output stability of git-archive, because it isn't
> officially documented (but it's not entirely clear what the benefits of
> changing are). And yet, git endeavors to do so, in order to prevent
> unnecessary breakage of people who embody Hyrum's Law and need that
> stability.

I'm one of the GitHub employees who chimed in there, and I'm also a Git
contributor in my own time (and I am speaking here only in my personal
capacity, since this is a personal address).  I made a change some years
back to the archive format to fix the permissions on pax headers when
extracted as files, and kernel.org was relying on that and broke.  Linus
yelled at me because of that.

Since then, I've been very opposed to us guaranteeing output format
consistency without explicitly doing so.  I had sent some patches before
that I don't think ever got picked up that documented this explicitly.
I very much don't want people to come to rely on our behaviour unless we
explicitly guarantee it.

> What does everyone think about offering versioned git-archive outputs?
> This could be user-selectable as an option to `git archive`, but the
> main goal would be to select a good versioned output format depending on
> what is being archived. So:
>=20
> - first things first, un-default the internal compressor again
> - implement a v2 archive format, where the internal compressor is the
>   default -- no other changes
> - teach git to select an archive format based on the date of the object
>   being archived
>   - when given a commit/tag ID to archive, check which support frame the
>     committer date falls inside
>   - for tree IDs, always use the latest format (it always uses the
>     current date anyway)
> - schedule a date, for the sake of argument, 6 months after the next
>   scheduled release date of git version X.Y in which this change goes
>   live; bake this into the git sources as a transition date, all commits
>   or tags generated after this date fall into the next format support
>   frame

I am actually very much in favour of providing a standard, deterministic
version of pax (the extended tar format) that we use and documenting it
as a standard so that other archive tools can use that.  That is, we
document some canonical tar format that is bit-for-bit identical that we
(and hopefully GNU tar and libarchive) will agree should be used to
serialize files for software interchange.  I don't think this should be
dependent on the date at all, but I do believe it should be versioned
and tested, and the version number embedded as a pax header.  I think
this would be valuable for simply having reproducible archives in
general, including for things like Docker containers, Debian packages,
Rust crates, and more, and I'm happy to work with others on such a
format, as I've said in the past on the list.  People can opt-in to
whatever format they want when creating an archive and continue to use
that forever if they like.

Part of the reason I think this is valuable is that once SHA-1 and
SHA-256 interoperability is present, git archive will change the
contents of the archive format, since it will embed a SHA-256 hash into
the file instead of a SHA-1 hash, since that's what's in the repository.
Thus, we can't produce an archive that's deterministic in the face of
SHA-1/SHA-256 interoperability concerns, and we need to create a new
format that doesn't contain that data embedded in it.

Having said that, I don't think this should be based on the timestamp of
the file, since that means that two otherwise identical archives
differing in timestamp aren't ever going to be the same, and we do see
people who import or vendor other projects.  Nor do I think we should
attempt to provide consistent compression, since I believe the output of
things like zlib has changed in the past, and we can't continually carry
an old, potentially insecure version of zlib just because the output
changed.  People should be able to implement compression using gzip,
zlib, pigz, miniz_oxide, or whatever if they want, since people
implement Git in many different languages, and we won't want to force
people using memory-safe languages like Go and Rust to explicitly use
zlib for archives.

That may mean that it's important for people to actually decompress the
archive before checking hashes if they want deterministic behaviour, and
I'm okay with that.  You already have to do that if you're verifying the
signature on Git tarballs, since only the uncompressed tar archive is
signed, so I don't think this is out of the question.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--SxQ3pe07gVIaINxs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCY9jlcgAKCRB8DEliiIei
gY8ZAQCnOaj6p+knkG3muIrR+NUsz6krUuYYlusZY7IFKgrG8gD/RpgXzeCvuUbw
DIdS04iGt15QuXRitcZWrpd4iK6VPAE=
=Icwk
-----END PGP SIGNATURE-----

--SxQ3pe07gVIaINxs--

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E1DC433EF
	for <git@archiver.kernel.org>; Tue, 19 Apr 2022 21:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236417AbiDSVwv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Apr 2022 17:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233514AbiDSVwt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Apr 2022 17:52:49 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFEB26AD9
        for <git@vger.kernel.org>; Tue, 19 Apr 2022 14:50:05 -0700 (PDT)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 603055A410;
        Tue, 19 Apr 2022 21:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1650405004;
        bh=EKdjS96QU8zOHi+3UIDacMKo0qquXv9YPQom7FfCI8k=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=XYefTQM5BIeTA6r3IeajmDW7h1e3lecuhVzNZWHIUv8xAWx5i8CVCuKtApQ+Grqva
         LmVaaLxpQjiLpmlt+mrJ7M9u8OvBGCdtzSaNxqGGVF1tVtRazswfm2j5OcuAF/ffYh
         EYIS43Y93rsUD7IZfk6m/wnWfDYmECljxSJhy10mLXfeJ6p3axo4AKhALKDJQ9QM1s
         HM6iQVL8TxflEjz9BNWJZb2fd4XmEyssf9a6kbh7nUWvOMJMALvBNjc4dGsw2RRByk
         Yf+P7s+jSLbfZhdPhxSrlHWW6BQJNGZ7Y/0pH/kIvypQbtuboExS3mLQuigvLJgFp3
         QkkLEQCqmoKFGjr6kezewzb2GtXp69SaO3aiR+iubdNIY/ho4D80WoHO3T2OoPAP8F
         2yCBH7Zx35YCmPxJfn+ipRnd1kfb2mutq4crVEVvpuAkh0ntr56+578ZvGtzfRGDvG
         nGDXwaWax7QbReBV0jPu6aMSmQUEr92noeK5Fi8YmK91eDW+NwS
Date:   Tue, 19 Apr 2022 21:50:01 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Kevin Long <kevinlong206@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: help request: unable to merge UTF-16-LE "text" file
Message-ID: <Yl8uiflurfjuLIvD@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Kevin Long <kevinlong206@gmail.com>, git@vger.kernel.org
References: <CAJCZ4U-9KYGK0jwnL1GyOYW-CMjV_Eo--g85CbexsV=aQnn7aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="scB4dS+JPobE8CQI"
Content-Disposition: inline
In-Reply-To: <CAJCZ4U-9KYGK0jwnL1GyOYW-CMjV_Eo--g85CbexsV=aQnn7aw@mail.gmail.com>
User-Agent: Mutt/2.2.3 (2022-04-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--scB4dS+JPobE8CQI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-04-19 at 19:36:19, Kevin Long wrote:
> Greetings,
>=20
> I've been struggling to merge branches because of a UTF-16-LE (with BOM?)=
 file.
>=20
> Windows 11 / git version 2.35.3.windows.1
>=20
> The problem file is a .sln file (Visual Studio "solution"). Edited in
> both branches. It is a "text" file, but is encoded as such:
>=20
> FacilityMaster.sln: Unicode text, UTF-16, little-endian text, with
> CRLF line terminators

Git does not consider files using UTF-16 to be text because they contain
NUL bytes.  In some sense they do represent textual content, but Git
considers them to be binary.

> I have tried several "working-tree-encoding" settings in
> .gitattributes in my local working directory, to no avail yet:
>=20
> *.sln working-tree-encoding=3DUTF-16-LE eol=3DCRLF, results in:
> error: failed to encode 'FacilityMaster.sln' from UTF-16-LE to UTF-8
> warning: Cannot merge binary files: FacilityMaster.sln (HEAD vs. master)
>=20
> *.sln working-tree-encoding=3DUTF-16 eol=3DCRLF, results in:
> warning: Cannot merge binary files: FacilityMaster.sln (HEAD vs. master)
>=20
> *.sln working-tree-encoding=3DUTF-16-LE-BOM eol=3DCRLF
> error: failed to encode 'FacilityMaster.sln' from UTF-16-LE-BOM to UTF-8
> warning: Cannot merge binary files: FacilityMaster.sln (HEAD vs. master)

The proper encoding you want here is "UTF-16LE-BOM".  Many Windows
programs use a non-standard encoding where everything _must_ be both
little-endian and have a BOM.  (The standard encoding UTF-16LE must
always be little endian but omits the BOM, and UTF-16 could be of either
endianness, and must only contain a BOM if little endian, but could in
either case.)

That will result in the file being stored as UTF-8 in the repository and
converted to this non-standard Windows encoding on checkout.  However,
if you have already checked the file in without an appropriate
working-tree-encoding, you should run `git add --renormalize .` and then
commit.  You'll need to do that (or merge in a commit that does that) on
every branch you want to work with.

> Hoping for some suggestions. I've also tried to save the file as UTF-8
> in both branches, commit, then merge, but still that did not work. I
> just want to merge it like a normal source code file.

However, in order for the merge to work, both branches must have the
file checked in correctly.  That is, both master and the branch from
which you're merging need to have the file as UTF-8 in the repository.
If you make the working-tree-encoding changes above (or the switch to
UTF-8) on only one of those branches, then the other one will still have
the binary blob, and merging won't be possible.

If you can keep it as UTF-8, that's ideal.  It should definitely work if
both sides have UTF-8 files.  If you still see a message about binary
files, then it could well be that something didn't get saved properly as
UTF-8, or that these really aren't text files and that they contain
binary contents.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--scB4dS+JPobE8CQI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYl8uiQAKCRB8DEliiIei
gUhnAQDS5lW1H7Snt144PXfI8L4PavFjQoPIF13oPVyL0D/WpQEArIy6dN4asJQA
4qlMvLiaxT9bsxWzPF11pD5nUjTZJA8=
=dvs7
-----END PGP SIGNATURE-----

--scB4dS+JPobE8CQI--

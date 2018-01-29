Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A808E1F404
	for <e@80x24.org>; Mon, 29 Jan 2018 01:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932335AbeA2Bvp (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Jan 2018 20:51:45 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58494 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932121AbeA2Bvo (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 28 Jan 2018 20:51:44 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 46AE260431
        for <git@vger.kernel.org>; Mon, 29 Jan 2018 01:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1517190701;
        bh=NCK2r8pgMn2S+YrWPXEQhHEmgwhvAwr0+0Eyx0oVC2g=;
        h=Date:From:To:Subject:Content-Type:Content-Disposition:From:
         Reply-To:Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:
         Resent-Cc:In-Reply-To:References:Content-Type:Content-Disposition;
        b=hVaDg5fpjmMekRtJ8DMVBqC87VLEQzTK8fn5HnZsPkKS0ySYo/+H6yDCtnWUAN0by
         hM9mZXGIjEbUUp27D2L1IXlUNFn1wRMG03yBVkn011qNZMKeLQ0JsTcEHUidnncKU8
         a2TgXFNko8ej2gr+Prxe+7RxX7VoP0g0CMWrGtsVxZrSHqG5DEfzmGbBpZD5gTKE9d
         URV14d2ZZARkXi7LASAl6D+3Y3Fpl2wl3uT7TTXeo5gN5ZK91mocdm2dha0uFv6d+x
         QCVnWnW7a1+Lms5cMRNLay1V8CZOmGnDD9aKbHiXzHWMcQCGhF//NC8aCEmgy4zcqc
         NxG1vaPXeXmI/xmhMC+uWY9lZB5D9CRWgXcO9DWsQtE4ekydPKUsET06kazsYE7Iee
         xfkzpAF/lFEeMqH0q12qjer5Bdgpgx+giyMuargDVfMYSzBqhWUs6rQUw/IkgQCqNX
         OSunSKaGr112bkZDW1A1TJMoo1kX/sjqdL23BrHgdQ77Np9FlnT
Date:   Mon, 29 Jan 2018 01:51:34 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Subject: t9128 failing randomly with svn 1.9?
Message-ID: <20180129015134.GN431130@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4Y142/9l9nQlBiaj"
Content-Disposition: inline
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-rc8-amd64)
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--4Y142/9l9nQlBiaj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

While running tests for my object_id part 11 series, I noticed a random
segfault in git svn while running t9128.  I've reproduced this on a
different machine as well, using both Subversion 1.9.5 and 1.9.7 (Debian
stable and unstable).  It is reproducible on master.

When the test fails, it fails on the "git svn tag tag3" step, and I get
the following:

Copying file:///home/bmc/checkouts/git/t/trash%20directory.t9128-git-svn-cm=
d-branch/svnrepo/trunk at r2 to file:///home/bmc/checkouts/git/t/trash%20di=
rectory.t9128-git-svn-cmd-branch/svnrepo/tags/tag3...
Found possible branch point: file:///home/bmc/checkouts/git/t/trash%20direc=
tory.t9128-git-svn-cmd-branch/svnrepo/trunk =3D> file:///home/bmc/checkouts=
/git/t/trash%20directory.t9128-git-svn-cmd-branch/svnrepo/tags/tag3, 2
Found branch parent: (refs/remotes/origin/tags/tag3) 0604824a81a121ad05aaf8=
caea65d8ca8f86c018
Following parent with do_switch
Successfully followed parent
r7 =3D f8467f2cee3bcead03e84cb51cf44f467a87457d (refs/remotes/origin/tags/t=
ag3)
error: git-svn died of signal 11

Doing the following three times, I had two crashes.

(set -e; for i in $(seq 1 20); do (cd t && ./t9128-git-svn-cmd-branch.sh --=
verbose); done)

I'm not really familiar with git svn or its internals, and I didn't see
anything recently on the list about this.  Is this issue known?
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--4Y142/9l9nQlBiaj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.4 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlpufiUACgkQv1NdgR9S
9ovDXw//W2CFe8TXjWOuDRJjLQc6EdSyYrfaN+0lrVw39w1v7VMFSrAfHxm+ht0t
HQb6V/PkfNPcG39hu+8J6/+mJOxQjMMD26nwGQj3a2/8CaAyBms4EcR5LEdyaS5M
jzlQQvY/RpAJbkEZNWBBIXQZfBsblSg8VFT88IqS6z/OiGFsMsDlKgYl+W1norBR
bdZ9HfuoMjt9sSqnwLpqWVPHu4MSjHbRwCvN3sq0HN7mNFBXuP5QOLOqChfQ5Sod
N4Nas6ICWroDdMRWreIITpPtI8EiZ0mYO0vpZkPTnuJnzgAtBTaWs87/DRZLwlYJ
I20wIOxcJ3fcOXXk3dIroEIc5wyCKCrD91G9FZQfaCbNjP14YXJABsNSP1VewFJn
0P91Urj4ZFegDA+C+vcpiUdxHC3AZKx9hwgKm3Ye+FVoNTBaM09gIJiAolgev60e
PKBmTeshBFK4YojAK0sCqe9gTFQX0qNvVgQf0gtlJ3JOiMykTPrkq5yAbJj9Doe8
kYLkt9He0Nnn6PStbyzqxPcB8EsQxCltu7sGP8rVHvfk2o7jk3zPbCq8xuYHDzKX
RfSErVvF/qT8IMBAsFv/s/t5nSTSR/OkDrKeP8f2uLq8cFj4gPXiF2otZOhZhdph
joW6QZpuVZbaBzolz7koAGXM6yjwp1j6joLKMhSLHukGC4V4gQo=
=Dphb
-----END PGP SIGNATURE-----

--4Y142/9l9nQlBiaj--

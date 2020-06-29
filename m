Return-Path: <SRS0=sGv9=AK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40ABFC433E0
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 22:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1346F20760
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 22:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Z9pqsG6z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgF2WmH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Jun 2020 18:42:07 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40266 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726046AbgF2WmG (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 29 Jun 2020 18:42:06 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1E11860459;
        Mon, 29 Jun 2020 22:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1593470495;
        bh=1Ju++8+9zCJqE9ad1NTNpwbmUquJ2ARLei/2oU1el/8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Z9pqsG6zgEElvD5t/OBdi+FWiWqfZtuYO/Mhb4z/GcD8patRdR5EIPjDEm+7IPm3P
         fbnQl5lYHAdL748z0aJPn9r9w1flfn8FfYIRmLiTXJet52B85WbjL8I/ZFFT/MKDyL
         78rS18BnncsLFr1cheQnmpwHBV8H+nOp64yXFSwHJOCC7jdxhPmzuvyC2bVkieR7v/
         rO4wzlRWUP22uQRYfdkphmj8/aFUx0r6U/X1Y4jtNKrp7bxHYQNAK/8Ic+Np3KOIcM
         w7IP3PWwb4nejSElJ6mdni5tj55cXXOsWpcfnvRsdHGAynwKiu3VdhbAnOaUHbuWb9
         /l7s5IUQwIa+mEUPTwFSW9TxaWa8Wj09FkFG2f8MeOErNdLJUtkeq+pQxTAqd6A63o
         KmLVns/otPlEAlabXhmaYzfJ7WDhubtChoJC+NepwJ2WoxyuW4lZYNsOisKzFCwa49
         a1GPaFahzdEaflQYLMxJvTUdExPn3NfroVB5pyucgFjdLtRDExk
Date:   Mon, 29 Jun 2020 22:41:13 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        peff@peff.net, Matt Rogers <mattr94@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Denton Liu <liu.denton@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 0/9] Allow overriding the default name of the default
 branch
Message-ID: <20200629224113.GC9782@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        peff@peff.net, Matt Rogers <mattr94@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Denton Liu <liu.denton@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.656.v3.git.1592951611.gitgitgadget@gmail.com>
 <pull.656.v4.git.1593009996.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZmUaFz6apKcXQszQ"
Content-Disposition: inline
In-Reply-To: <pull.656.v4.git.1593009996.gitgitgadget@gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-2-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ZmUaFz6apKcXQszQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-06-24 at 14:46:27, Johannes Schindelin via GitGitGadget wrote:
> A growing number of open source projects aims to avoid the branch name=20
> master due to its negative connotation. See [1] for an existing discussion
> on this. The links [2], [3], and [4] describe community-driven ways for
> users to rename their default branches or use template edits to set a new
> default branch name.
>=20
> [1]=20
> https://lore.kernel.org/git/CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV=
=3D=3DapdWDg@mail.gmail.com/
>=20
> [2] https://twitter.com/mislav/status/1270388510684598272
>=20
> [3]=20
> https://www.hanselman.com/blog/EasilyRenameYourGitDefaultBranchFromMaster=
ToMain.aspx
>=20
> [4] https://github.com/ethomson/retarget_prs
>=20
> By necessity, existing repositories require a lot of manual work to move
> away from that branch name, but it should be much easier for new
> repositories.
>=20
> This patch series allows overriding the branch name being used for new
> repositories' main branch. This can be configured via init.defaultBranch.
>=20
> The initial patch was started by newcomer Don Goodman-Wilson, as well as =
the
> bigger change that morphed into #655, where we demonstrate how to change
> Git's hard-coded default branch name for new repositories to main based on
> this here patch series, verifying the approach. Thanks for the contributi=
on!
>=20
> This series DOES NOT change the default automatically, but only provides =
an
> opt-in mechanism for interested users. The plan for that is to convert the
> test scripts incrementally (by introducing GIT_TEST_DEFAULT_MAIN_BRANCH_N=
AME
> , which overrides init.defaultBranch, and then converting the tricky test
> scripts first, one by one, using that environment variable).

I'm very happy with this and the way it's progressed since v1.  This
seems simpler than earlier designs, and I appreciate the improved focus
on avoiding special-casing branches, since I think that will make it
easier for folks to choose branch naming that suits them.

Thanks for working on this.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--ZmUaFz6apKcXQszQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXvpuCAAKCRB8DEliiIei
gUlfAP4jJ2vSSsH+WgYIPzUrQezonnrcMd42cW2a5XFuWf23MwD/XYorC/MKlyoN
hOsXwi+gd5eJhRjLh//0g0Kd83JaLA4=
=JYlh
-----END PGP SIGNATURE-----

--ZmUaFz6apKcXQszQ--

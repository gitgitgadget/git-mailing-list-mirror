Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41985C0015E
	for <git@archiver.kernel.org>; Wed, 16 Aug 2023 01:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241003AbjHPBVf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Aug 2023 21:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240953AbjHPBVW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2023 21:21:22 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42331FFB
        for <git@vger.kernel.org>; Tue, 15 Aug 2023 18:21:13 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 115075A336;
        Wed, 16 Aug 2023 01:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1692148873;
        bh=KvdmIBzpip0sPDlSLrX0Gg3aD1XTX/iCI9JoiBKkp40=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=OlhUNLmRUMPLxvZ0xcofI+9FeSaZ4tVAGjGffbfzDJKRC0duNcziWeCQyzMeQz7Tb
         GGwnzjrNjUWqEeXssuZeYEzRbd/SG61H8xjgK/A/Tm7o0AHLC5iF3kfcOPrdowz/ku
         k95Xz50VDil9UrDpbUkqVxucQf/oSXJ675RlXkQzb7yFfNbIZc24wFY7rvVWX7ITx/
         mY3G7u1eSKKuBxI4+nMQnBsveY3VBuCsSJdrG279VSJurM6DAz0HM/O/JEtwnjQTYN
         K32EuRKkuvJcAB3CEmUpEUZLr4vNv5iXvAikW7O2iu1uCiWlVB46wWjq4n13+I8EX0
         /r9TNBkY+PSZXkyj3pkmN69IFXL2qepLEzqKeNRS9n2mgl9aIp7xscTuvUmKVADC/5
         FhrlaKryaKmoRmQzClK8GFgnd8HZgwrsLZo8SfLFcu6NajjSdURGplDErwuPrEEd9s
         dENPrS74m7jIo8bHFCwHTs36S9L9kD4+ncCI3/rfeEqKzj38nbV
Date:   Wed, 16 Aug 2023 01:21:11 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Grant Singleton <grant_singleton@trimble.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Corrupt repo with force push when using a reference repo
Message-ID: <ZNwkh47mBJxcSYkm@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Grant Singleton <grant_singleton@trimble.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <MN2PR03MB5072F08C68E7F32C9F5AC866A614A@MN2PR03MB5072.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+6T3WOTZil1kTTtq"
Content-Disposition: inline
In-Reply-To: <MN2PR03MB5072F08C68E7F32C9F5AC866A614A@MN2PR03MB5072.namprd03.prod.outlook.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--+6T3WOTZil1kTTtq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-08-15 at 04:05:34, Grant Singleton wrote:
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>=20
> What did you do before the bug happened? (Steps to reproduce your issue)
>=20
> With 3 clones of a repo, one on branch-a one a mirror,  another using the=
 mirror as a reference repo on branch-b, do the following
>=20
> # in the repo on branch-a, make a change, commit and push
> cd bad-object-test
> echo $(( RANDOM % 1000 + 1 )) > file.txt
> git ci -am "change a file"
> git push
>=20
> # do a git fetch in the reference repo
> cd ../bad-object-test.git/
> git fetch
>=20
> # do a git pull in the repo on branch-b
> cd ../bad-object-test-with-reference-repo/
> git pull
>=20
> # All good so far
>=20
> # in the repo on branch-a, discard HEAD and force push
> cd ../bad-object-test
> git reset --hard HEAD~1
> git push --force
>=20
> # do a git fetch in the reference repo and then prune loose objects
> cd ../bad-object-test.git/
> git fetch
> git prune -v --expire=3Dnow

When you clone using --shared or --reference, you implicitly depend on
the objects in the referenced repository existing without being pruned
for the integrity of the repository.

The manual page for git clone says this:

  NOTE: this is a possibly dangerous operation; do not use it unless you
  understand what it does. If you clone your repository using this
  option and then delete branches (or use any other Git command that
  makes any existing commit unreferenced) in the source repository, some
  objects may become unreferenced (or dangling). These objects may be
  removed by normal Git operations (such as git commit) which
  automatically call git maintenance run --auto. (See
  git=E2=80=90maintenance(1).) If these objects are removed and were refere=
nced
  by the cloned repository, then the cloned repository will become
  corrupt.

If you want to change the references in any non-fast-forward way or do
any sort of GC or pruning in the reference repository, you need to run
`git repack -a` in the non-reference repository to repack all of the
objects in that repository and dissociate it from the reference
repository.

In general, unless you are _very_ sure you know what you're doing, you
usually want to use `--dissociate` with `--reference` such that you
detach immediately.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--+6T3WOTZil1kTTtq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZNwkhgAKCRB8DEliiIei
gZpZAP9k8gJ9nTb4bPeRHtBHV3CBBBZY+6AMlVkKghmipTcMGQD9FR1Mz5N4g83U
ltSTcM29gZSHWig4G25iGwAf1194wgU=
=rINz
-----END PGP SIGNATURE-----

--+6T3WOTZil1kTTtq--

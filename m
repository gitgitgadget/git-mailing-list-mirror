Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0DBCC433EF
	for <git@archiver.kernel.org>; Mon, 31 Jan 2022 23:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiAaXa2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jan 2022 18:30:28 -0500
Received: from ring.crustytoothpaste.net ([172.105.110.227]:39970 "EHLO
        ring.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiAaXa1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jan 2022 18:30:27 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id D78F85B26D;
        Mon, 31 Jan 2022 23:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1643671826;
        bh=h3mwwbnQKEsWIMfodBnIz8u34uRakjXq9G8gkzrN4wc=;
        h=Date:From:To:Subject:References:Content-Type:Content-Disposition:
         In-Reply-To:From:Reply-To:Subject:Date:To:CC:Resent-Date:
         Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=wF+yvhE1vVnPLJXwenyf16oz44q77VgJeELSpgcfOytX8E5T4wPh+tCAYni1cLWMl
         pdEQzdnNCbCzWoqR7de5Q7qmqoXcq2Gs7DGJ829SyPqdC0Q067PGaZDryfizsjd2lZ
         B2DHHp8xkS2+HslwpidJqnJwijejVwI2bzlwheVGvRCd59x65rFbSrr7IpjxH/tRkS
         6vAA0TEx6xEqP5TOYH5oAd+nq65UNGwHiN1phUkRX50kmC8CpE7sTvOaKE8/CUt8wq
         sUK7deOyQ7M/fPpnGVEQlP7BnAFjEXqWFAEilbjLIcvmFp6Pj3XcuwlBM8P6Afvy6g
         nzlYXDkQzmZQO5dlNG/BPmRufnuZhVg4UFvSSrkvVb+m+h3jaw/nYjm3JBBJ94OtG2
         W7/jTvYx6MRGjW4iq+ebR11tejEjojONlfOA0u8Ijf3MrORgXemoM/hMI44M4oyZf4
         h3KQlZGq+PLrPJ8KDL4OEICsvtdy0XXiPULMx/4UuHnK8cHlXgQ
Date:   Mon, 31 Jan 2022 23:30:25 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Subject: Re: Why won't "git rebase -Xrenormalize -i $REBASE_SHA" do anything?
Message-ID: <YfhxESEsZo7CwFiz@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
References: <20220131110149.GE16463@raven.inka.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PYcUfrHvGHRvDcQ6"
Content-Disposition: inline
In-Reply-To: <20220131110149.GE16463@raven.inka.de>
User-Agent: Mutt/2.1.4 (2021-12-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--PYcUfrHvGHRvDcQ6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-01-31 at 11:01:50, Josef Wolf wrote:
> Hello,
>=20
> I've added "* text=3Dauto" to an existing repo with a completely linear h=
istory.
>=20
> Now, as expected, every rebase operation gives me lots of conflicts, whic=
h are
> hard to resolve.
>=20
> So I'd like to clean up the history:
>=20
>   $ git rebase -Xrenormalize -i $REBASE_SHA
>=20
> But this turns out to be a no-op? It says immediately
>=20
>   Successfully rebased and updated refs/heads/wip-normalize
>=20
> without even the counter which is usually output to show progress during =
an
> interactive rebase as it is working through the rebase-todo. I can confirm
> that nothing has happened by checking the sha of the branch.
>=20
> So, what am I missing? How would I renormalize all the commits of a branc=
h?
> The branch has linear history, no merges there.

I think what you probably want is to add the -f option.  By default, Git
doesn't perform a rebase when the current branch is up to date with the
base branch.  If you want to do it anyway, in this case, to rewrite
commits, then -f should make that happen.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--PYcUfrHvGHRvDcQ6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYfhxEAAKCRB8DEliiIei
gdQlAPwLZmojn7rqFByTg530XHnluKVpHr/HRWYUhMeQbZGWvAD8C0CG7M0pisG7
gXU2uwWvFFG/r8JoZfYIRcK0uxyYlQI=
=l0Rb
-----END PGP SIGNATURE-----

--PYcUfrHvGHRvDcQ6--

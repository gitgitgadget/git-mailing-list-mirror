Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0057EC433C1
	for <git@archiver.kernel.org>; Sat, 27 Mar 2021 18:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCB01619AB
	for <git@archiver.kernel.org>; Sat, 27 Mar 2021 18:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhC0Szh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Mar 2021 14:55:37 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:49484 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230015AbhC0SzE (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 27 Mar 2021 14:55:04 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A201A6048E;
        Sat, 27 Mar 2021 18:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1616871303;
        bh=pSq8E+36IhDfCBewZwyWY5bKb4liU8iKZSKzkDpL9GQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=w/gjH/LLjYERB6YczNDuppsjZCeocNHRNiIJL8S14GwrnaWAM5tjVlwhvps8Yfhpy
         NvKd4cD2nQqORK+s5zpORxhENylMzJoo6D/XL8HIECNKt599R0ocuhn0YOcMMxnE2a
         CV5SvFGdNEov/mHaokugSIti3dmUawWGpC9+oOC0dxVWGquaM2v9D3hEE74Zl+lf6R
         g5rffV2n0O9OGxYMqgED3nL1YfsKM3HDgjyRMrOHGXYL1VGFK6JwPotXDekoGUoxCf
         MJdPur9dldhDUZBz4solum/kQwv/QN0YN1VvvEBtlTF0MyirgoLHu7WrxqaGu2GhR/
         ktO6BI5p20oZu1//3NHcZPEKSeXvR5dJBXgZ+ltqCIvGzkwJTv3elL8k3MA/bfDIst
         qKoqPZm0+aPlrIqXSPw8OaAl5wugmwg2Dn6F65xKw3M2y/6Ok4UgqKuYYUcLV3TyH5
         C63WCU7DWVyBYR7ZwyMq7qrnM/7KygVj1VBMgbde2tdzjdHDXI8
Date:   Sat, 27 Mar 2021 18:54:56 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Utku <ugultopu@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] Git is not using the configured SSH key when there is
 another SSH key added to the SSH agent
Message-ID: <YF9/gCIWaFBicdpo@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Utku <ugultopu@gmail.com>, git@vger.kernel.org
References: <967BFF88-A8E1-4EEC-B298-668012E42C03@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jQE9PzqZGbCWjBbm"
Content-Disposition: inline
In-Reply-To: <967BFF88-A8E1-4EEC-B298-668012E42C03@gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--jQE9PzqZGbCWjBbm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-03-27 at 18:31:10, Utku wrote:
> # Versions
>=20
> - Git 2.30.1
> - macOS 10.15.7
>=20
> # Steps to Reproduce
>=20
> - Have two SSH key pairs on your machine, one with a passphrase and
> other without. The keys were created by running `ssh-keygen` in my
> case.
>=20
> - Add the key with a passphrase to the SSH agent by running `ssh-add`
> and entering the passphrase.
>=20
> - Have an entry like the following in your `~/.ssh/config`:
>=20
>       Host someName
>           HostName bitbucket.org
>           User git
>           IdentityFile ~/.ssh/private-key-of-the-pair-without-a-passphrase
>=20
>=20
> - Add the public key of the pair without a passphrase to your BitBucket
> account.
>=20
> - Run `git clone someName:path/to/your/repository.git`. You will get a
> not authorized error. As far as I can tell, this means that Git has
> tried to use the key with the passphrase (which is added to the SSH
> agent). Since this key is **not** the key that was added to the
> BitBucket account, we received a not authorized error.
>=20
> - Add the key without a passphrase to your SSH agent by running
> `ssh-add` and try the same command (`git-clone`) again. It will work.
>=20
> - Now, remove both keys from the SSH agent by running `ssh-add -D` and
> try and try the same command (`git-clone`) again. It will still work.
>=20
> I didn't test but don't believe this has something to do with the key
> having a passphrase or not. Also, I believe that I'm not using macOS
> Keychain to store the decrypted keys.

This behavior is completely due to SSH.  Git doesn't tell OpenSSH to
behave in any particular way; instead, it tells it to make a connection
with the specified parameters to the specified server, and OpenSSH makes
its own decision about what that means.

In your case, the option you want is "IdentitiesOnly yes".  This tells
OpenSSH to always use the specified identity, even if a different one is
available in the agent.  You can add it to the configuration that you
have above and things should work.

You can also see an example of this configuration in the FAQ:
https://git-scm.com/docs/gitfaq#multiple-accounts-ssh
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--jQE9PzqZGbCWjBbm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYF9/fwAKCRB8DEliiIei
gYHnAQC8Rl9T55uzZaG++jqWoNcg5K0fDXpItGIHiFyx4HwL3gD/cSi0QEzwCzGT
mbu95GXQHscxgOsbZ1/wm/d+YMlLDwU=
=OC35
-----END PGP SIGNATURE-----

--jQE9PzqZGbCWjBbm--

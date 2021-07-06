Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC917C07E9B
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 14:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0FCF6195A
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 14:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbhGFOrm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 10:47:42 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37308 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232340AbhGFOrZ (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 6 Jul 2021 10:47:25 -0400
Received: from camp.crustytoothpaste.net (unknown [72.12.180.34])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 66DB86042E;
        Tue,  6 Jul 2021 14:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1625582684;
        bh=Es+cdnFw5cUA8gQ7HKY0a9oGxMIw6BY3nEc4v2i60yE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=PAA1xM8Ylwz2PEJriH8S2ZIwxCRh58K7oiOzzAhgBp6T3bvzOe12xWmBdABZuR6Mk
         CcI72MvjKMUrshACvYl9zGAeY2SEcvNFBopFymEQYbjn8/MxsiH7MAQDj7KnNY1F0v
         dbvxWJRwOGGMl/Lp1XApiuE8rXm3xAAfR2rGPZuH76YQ+XLQ27IqZeRosuGvuCh8EI
         9DPqAcfFKGR7vnzi9c7gTrO3TTu30t8DyXLfBMwMfzlH9rKOGLWyWodHywnMYdJjAx
         uTwmOjcJ/BHuVbLIk2ITZ/2Q7/ZHcyz0/hYeIiYOspu2wlLoFnO4wryITg+x4810cH
         zaM95ZzodlRuVtoVin3wrquPxWzUvImYpxrWXdfWuSNagf4G0cciWCh0bc18Dw1nud
         vXalAMn6evLRZdOoBeA8wj2t/4aw47aoQs1GbAwRl4jh8yP69CnfKgWbHIpXJzm4IT
         /JrD7YVc+HFt7p6XwrykotmjGp3QHqpbZ/Jt9M9XJquehYSM5R2
Date:   Tue, 6 Jul 2021 14:44:36 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Fabian Stelzer via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Fabian Stelzer <fs@gigacodes.de>
Subject: Re: [PATCH] Add commit & tag signing/verification via SSH keys using
 ssh-keygen
Message-ID: <YORsVNVC6lVEA7yD@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Fabian Stelzer via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Fabian Stelzer <fs@gigacodes.de>
References: <pull.1041.git.git.1625559593910.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+In90pUEPRIdb/1l"
Content-Disposition: inline
In-Reply-To: <pull.1041.git.git.1625559593910.gitgitgadget@gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--+In90pUEPRIdb/1l
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-07-06 at 08:19:53, Fabian Stelzer via GitGitGadget wrote:
> From: Fabian Stelzer <fs@gigacodes.de>
>=20
> set gpg.format =3D ssh and user.signingkey to a ssh public key string (li=
ke from an
> authorized_keys file) and commits/tags can be signed using the private
> key from your ssh-agent.
>=20
> Verification uses a allowed_signers_file (see ssh-keygen(1)) which
> defaults to .gitsigners but can be set via gpg.ssh.allowedsigners
> A possible gpg.ssh.revocationfile is also passed to ssh-keygen on
> verification.
>=20
> needs openssh>8.2p1

Usually we'll want to write the explanation here in full sentences with
typical capitalization.

> Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
> ---
>     RFC: Add commit & tag signing/verification via SSH keys using ssh-key=
gen
>    =20
>     Support for using private keyfiles directly is still missing and i'm
>     unsure on how to configure it or if the pubkey in the signingkey field
>     is such a good idea. A SSH Fingerprint as signingkey would be nicer, =
but
>     key lookup would be quite cumbersome. Maybe storing the fingerprint in
>     signingkey and then have a gpg.ssh.$FINGERPRINT.publickey/privatekeyf=
ile
>     setting? As a default we could get the first ssh key from ssh-add and
>     store it in the config to avoid unintentional changes of the used
>     signing key. I've started with some tests for SSH Signing but having
>     static private keyfiles would make this a lot easier. So still on my
>     TODO.

I think user.signingKey could be helpful for signing here.  That could
be a file name, not just a fingerprint, although we'd probably want to
have support for tilde expansion.  You could add an additional option,
gpg.ssh.keyring, that specifies the signatures to verify.  That would be
named the same thing as a potential option of gpg.openpgp.keyring,
which would be convenient.  Also, gpg.ssh.revokedKeyring could maybe be
the name for revoked keys?

>     This feature makes git signing much more accessible to the average us=
er.
>     Usually they have a SSH Key for pushing code already. Using it for
>     signing commits allows us to verify not only the transport but the
>     pushed code as well. The allowed_signers file could be kept in the
>     repository if all receives are verified (allowing only useris with va=
lid
>     signatures to add/change them) or outside if generated/managed
>     differently. Tools like gitolite could optionally generate and enforce
>     them from the already existing user ssh keys for example.
>    =20
>     In our corporate environemnt we use PIV x509 Certs on Yubikeys for em=
ail
>     signing/encryption and ssh keys which i think is quite common (at lea=
st
>     for the email part). This way we can establish the correct trust for =
the
>     SSH Keys without setting up a separate GPG Infrastructure (which is
>     still quite painful for users) or implementing x509 signing support f=
or
>     git (which lacks good forwarding mechanisms). Using ssh agent forward=
ing
>     makes this feature easily usable in todays development environments
>     where code is often checked out in remote VMs / containers.

I think some of this rationale would work well in the commit message,
especially the part about the fact that using an SSH key may be easier
for users and the fact that it can be well supported by smart cards.
Those are compelling arguments about why this is a desirable change, and
should be in the commit message.

I haven't looked too deeply at the intricacies of the change, but I'm in
favor of it.  I would, however, like to see some tests here, including
for commits, tags, and push certificates.  Note that you'll probably
need to run the testsuite both with and without
GIT_TEST_DEFAULT_HASH=3Dsha256 to verify everything works.

> diff --git a/Documentation/config/gpg.txt b/Documentation/config/gpg.txt
> index d94025cb368..fd71bd782ec 100644
> --- a/Documentation/config/gpg.txt
> +++ b/Documentation/config/gpg.txt
> @@ -11,13 +11,13 @@ gpg.program::
> =20
>  gpg.format::
>  	Specifies which key format to use when signing with `--gpg-sign`.
> -	Default is "openpgp" and another possible value is "x509".
> +	Default is "openpgp". Other possible values are "x509", "ssh".
> =20
>  gpg.<format>.program::
>  	Use this to customize the program used for the signing format you
>  	chose. (see `gpg.program` and `gpg.format`) `gpg.program` can still
>  	be used as a legacy synonym for `gpg.openpgp.program`. The default
> -	value for `gpg.x509.program` is "gpgsm".
> +	value for `gpg.x509.program` is "gpgsm" and `gpg.ssh.program` is "ssh-k=
eygen".
> =20
>  gpg.minTrustLevel::
>  	Specifies a minimum trust level for signature verification.  If
> @@ -27,6 +27,15 @@ gpg.minTrustLevel::
>  	with at least `undefined` trust.  Setting this option overrides
>  	the required trust-level for all operations.  Supported values,
>  	in increasing order of significance:
> +
> +gpg.ssh.allowedSigners::
> +	A file containing all valid SSH signing principals.=20
> +	Similar to an .ssh/authorized_keys file. See ssh-keygen(1) for details.
> +	Defaults to .gitsigners

We probably don't want to store this in the repository.  If OpenSSH has
a standard location for this, then we can default to that; otherwise, we
should pick something in .ssh or in $XDG_CONFIG_HOME/git.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--+In90pUEPRIdb/1l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYORsUwAKCRB8DEliiIei
gaadAQDsdRNZtyumNOE586t+MMEdAieJiqIRlHDEUXA0wDGYWQD/R1wTFTQj5amV
4RfeY7EdMrtb7PXBNQEYGV85Ngt6zQw=
=/w5r
-----END PGP SIGNATURE-----

--+In90pUEPRIdb/1l--

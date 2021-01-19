Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E489EC433DB
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 23:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC04522DD3
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 23:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbhASXOb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 18:14:31 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:56602 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728456AbhASXMz (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 19 Jan 2021 18:12:55 -0500
Received: from camp.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8888D60781;
        Tue, 19 Jan 2021 23:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1611097897;
        bh=UcDbVTWF0ye6WXSHgEp3iQFng/jaUOKme4M0NHTFecQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=A+5yaNUXERIWLP9kpGDrgo11JFwpFhbL62J2uOjL79Ngo3haPRxL91p4sA83XPrYK
         crCn9jD5MpJmdgW/SF6RCZpxH8FG1Kf5kxlopU3HrVGJbwdWSPdk0DB/syxm2nZWXh
         CZvTbaARvIlupaaKnm6I5XOsO1FGNb5GYiTuBxkiqOuXAyhOiN3lpyaGKGTGrBsyV2
         KZG9Ccyiw4Rt2Fph8UXtxoOJW4Id6YSMnDO6frRnDpmv0nMXR0HG2BjRzicD+UrQen
         7L/iZ1Dn6pKltfsVF7TyK2pg0EmopMin0kIgZ3msY/ZEZEC3xPFT2AE6m52bJLVHLW
         4+VDwo4DxjbJ9GeXFVXvN/ojSWemOO5iqtZ9XaTvljz5yEmJ3lVY5ngnYLBXBvozjk
         7mSO3ZcPaNAHn82SEzWazRSsHne20s0Bx3lLJnYRzIlsO5qLGg9nF6rXyaAx3YjIXB
         3RhNMsKwKBp8ZxnAzx13GI61Hngzege6rzyVR/OB1CK6qlIU1+4
Date:   Tue, 19 Jan 2021 23:11:33 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Harley Paterson <harley.paterson@hotmail.co.nz>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: False negative authentication with multiple accounts on a
 SSH-GIT server
Message-ID: <YAdnJabiJlu9Qlli@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Harley Paterson <harley.paterson@hotmail.co.nz>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <DB8P189MB10460B9A3CA31ADF5C05A39FF9A30@DB8P189MB1046.EURP189.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uRkqBJDt0HXzv8Md"
Content-Disposition: inline
In-Reply-To: <DB8P189MB10460B9A3CA31ADF5C05A39FF9A30@DB8P189MB1046.EURP189.PROD.OUTLOOK.COM>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--uRkqBJDt0HXzv8Md
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-01-19 at 06:17:21, Harley Paterson wrote:
> Hello,
>=20
> I've noticed an edge case in Git when a user has two Git accounts on a
> single server - as might be common for a personal account and a work
> account on a Git forge (Github, GitLab, Bitbucket...)
>=20
> When attempting SSH login, `ssh` and Git will eagerly connect with the
> first matching key. This may or may not be the key right key for the
> repository the user needs. As a result, Git clones, pulls, and pushes
> will fail with the `Repository not found` if the wrong key is tried
> first.
>=20
> For example, the user `alice` has two accounts on the host
> `git-server.com`. `alice`'s accounts are `alice-work`, and
> `alice-personal`. `alice-work` has access to the `foo` repository, and
> `alice-personal` has access to the `bar` repository.

Yes, this is because SSH authentication happens before any command is
run.  The server never knows what resource is being requested until the
user is already authenticated.

> `alice` attempts to clone `foo` with both her `alice-work` and
> `alice-personal` keys in her SSH Agent. SSH Agent does not define
> which key it will attempt first, so SSH may connect successfully to
> `git-server.com` with her `alice-personal` keys, which do not have
> access to the `foo` repository.
>=20
> I'd be interested in your opinions for fixes to this. I am willing to
> make a patch, although my knowledge of the Git codebase isn't perfect.

We've documented how to deal with situation properly in the FAQ, which
you can see at gitfaq(7) or
https://git-scm.com/docs/gitfaq#Documentation/gitfaq.txt-HowdoIusemultiplea=
ccountswiththesamehostingproviderusingSSH

Is there some reason that this doesn't work for you?

> - Should Git servers provide distinctly different error messages for
>   `access denied`, and `repository does not exist`? Currently the
>   server immediately closes the connection in this case, so
>   `transport.c:handshake()` with fail when attempting to
>   `discover_version()` because the reader hits the EOF. Perhaps the
>   server could send a hypothetical access denied packet here, and a
>   more appropriate error generated?

Unfortunately, this leaks whether a repository exists.  If Company XYZ
has a repository for each of its clients, it then becomes easy to see if
Company XYZ is doing work for a particular client by trying to see if a
repository exists.  This would be bad and a huge violation of privacy,
so nobody is likely do to that.  I can tell you as one of the staff who
maintains the GitHub Git service, we're not likely to change the
behavior, and I suspect nobody else is, either.

> Can anyone point me to where in the Git codebase the daemon receives
> and responds to these requests? I haven't found it yet, if I wanted to
> patch this.
>=20
> - Should Git provide a `-i` option to allow the user to choose an SSH
>   key, which could be added to the SSH subprocess's command line?

You can use GIT_SSH_COMMAND or `core.sshcommand` to set this.  We don't
provide such an option because the user is not necessarily using
OpenSSH and different SSH programs provide this feature differently.

> - Should Git attempt to iterate over all keys in the SSH Agent when
>   the connection is setup, testing the connection to check if each
>   connected key has access to the target repository, before giving up
>   and reporting an error? This may be difficult looking at the current
>   behavior of `ssh` and `ssh-agent`. `ssh-add -l` no longer lists
>   paths to files (which could be plugged into `ssh -i`), just the key
>   signature. Does anyone know of any SSH/SSH-Agent tricks which might
>   help with this?

For historical reasons, we retry SSH connections in Git LFS and users
frequently complain about being prompted for their password multiple
times before giving up, so I suspect this would not be a good experience
for the user.  Users may also have multiple keys and have configured
their agent to prompt them for a passphrase before using the key, and
I'm pretty sure those users will complain very loudly if we do this.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--uRkqBJDt0HXzv8Md
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYAdnJAAKCRB8DEliiIei
gZYyAQC3YTuWNIWSjcXjm4itcfOPi7Uhtzq28kZgk9ORX+J9ygEAhIXvep2b8Foy
AlHacVR2vohieuMAsqASnaoPB+h6wgk=
=SFgH
-----END PGP SIGNATURE-----

--uRkqBJDt0HXzv8Md--

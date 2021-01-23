Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA62C433DB
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 00:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E12D23428
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 00:43:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbhAWAmt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 19:42:49 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58788 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726222AbhAWAms (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 22 Jan 2021 19:42:48 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D81E460D01;
        Sat, 23 Jan 2021 00:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1611362496;
        bh=N/U2BDCMSfYrItBwa8DIOZ+4R7z8b4L2dkwgADnJm2U=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=uUg7C0mSQWWHKqb69lFt6VMbLUPlb8trTUBdiLJJl5tXv4OnWhtPuDN+AIpIR+AC1
         s+psxO2s6UxBRMeVsPwyU+Oj8ysu51VJOSt1+zbC+1RdgNIfdR6Ww22DfxszTD5TuL
         6FZN78ucDEJA4wWq2DwAV8UCLzoBfgUydp5w2C1RXiFz9yPIkYDKQOr1KLBVVl/SjP
         yuiB1beAx5dJRBI9QcTbYnCR9c+BrbX0kDWQRRrqAhUXcjf/cSorXzuD2hM259ctFb
         OS+g3kNPgDkk3zXu0OxIv7VwJ/0D20re2duEHnfO1ukfbCMntvPN2QsQJAsojvfsnw
         IxNdJ0zUB+B7rMmHM4vTAdvpPxYtN8Y3PFHPwfaN/sIXL1Z0VKDqJCzYFNa7o27bEq
         oQV2t7tLuFQc6LhczqLpbdJzwB+CKycu1n3sync3A1KkbIdO8OFym4JRnNn7iVoWCX
         RCADMrrQfZa/DI5DYzzzv5+zoWSOCSHpmapmViRt8G21ROvIjZ+
Date:   Sat, 23 Jan 2021 00:41:29 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     William Chen <williamchen32335@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: faster git clone
Message-ID: <YAtwuSoEE68TV4LN@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Emily Shaffer <emilyshaffer@google.com>,
        William Chen <williamchen32335@gmail.com>,
        Git List <git@vger.kernel.org>
References: <20210122030103.GA73465@gmail.com>
 <CAJoAoZkrYYz=1wKDtUKdewPGX9wr2Zwhhyq9kd5C2_KDn9UJ=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="20fQWYPE5ZCAhB2b"
Content-Disposition: inline
In-Reply-To: <CAJoAoZkrYYz=1wKDtUKdewPGX9wr2Zwhhyq9kd5C2_KDn9UJ=w@mail.gmail.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--20fQWYPE5ZCAhB2b
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-01-22 at 19:53:21, Emily Shaffer wrote:
> On Thu, Jan 21, 2021 at 7:01 PM William Chen <williamchen32335@gmail.com>=
 wrote:
> > When I try to clone a repo of a large size from github, it is slow.
> >
> > $ git clone https://github.com/git/git
> > ...
> > remote: Enumerating objects: 56, done.
> > remote: Counting objects: 100% (56/56), done.
> > remote: Compressing objects: 100% (25/25), done.
> > Receiving objects:  23% (70386/299751), 33.00 MiB | 450.00 KiB/s
> >
> > The following aria2c command, which can use multiple downloading thread=
s, is much faster. Would you please let me know whether there is a way to s=
peed up git clone (maybe by using parallelization)?
>=20
> In general, it would be more compelling to see actual numbers than
> "much faster", e.g. the outputs of `time git clone
> https://github.com/git/git` and `time aria2c
> https://github.com/git/git/archive/master.zip` - or even an estimation
> from you, like, "I think clone takes a minute or two but aria does the
> same thing in only a couple of seconds". "Much faster" means something
> different to everyone :)

When Git shows the download speed, I believe it shows the speed at the
given interval.  So it may be that at the given moment, performance
varies.  Part of that is server side, since Git performs compression of
data, and part of that is client side.  For instance, if you're using
SHA-1-DC (which you should, for security), there is a theoretical
performance limit for clones of about 50 MiB/s on the client side which
would be improved if you were cloning a SHA-256 repository[0].

If this is a fresh clone, it is probably already cached on the server
side, since frequently requested pack files are cached at GitHub
(although I'm not clear on whether a given request is cached can be
determined), so it could be that it's just pushing data over the pipe as
fast as your system can process it.

> > Your help is much appreciated! I look forward to hearing from you. Than=
ks.
> >
> > $ aria2c https://github.com/git/git/archive/master.zip
> >
> > 01/21 20:16:04 [NOTICE] Downloading 1 item(s)
> >
> > 01/21 20:16:04 [NOTICE] CUID#7 - Redirecting to https://codeload.github=
=2Ecom/git/git/zip/master
>=20
> Right here it looks like your zip download redirects to a CDN or
> something, which is probably better optimized for serving archives
> than the Git server itself, so I would guess that has something to do
> with it too.

This is indeed backed by a CDN which may be much closer to you
physically.  Without seeing the full request, it's hard for me to say
where your request was served from (CDN or not).  I should point out
that in this case you're cloning a single revision (so much less data),
the data is usually cached, and your end of the system is not performing
any decompression or hash verification, so it may appear faster when
you're not performing equivalent work.

(I would kindly ask that you not try to download every revision in
history for a comparison, because that would be a clearly excessive and
abusive level of usage.)

I should also point out that you can't use multiple download threads to
download from these endpoints because they don't, in general, handle
Range requests.  (Basically, they do if they're already cached, but not
if they're not.)

> > [#59b6a2 8.2MiB/0B CN:1 DL:3.8MiB]
> > 01/21 20:16:08 [NOTICE] Download complete: /private/tmp/git-master.zip
> >
> > Download Results:
> > gid   |stat|avg speed  |path/URI
> > =3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> > 59b6a2|OK  |   2.9MiB/s|/private/tmp/git-master.zip
> >
> > Status Legend:
> > (OK):download completed.
>=20
> There are others on the list who are better able to explain this than
> me. But I'd guess the upshot is that 'git clone
> https://github.com/git/git' is asking a Git server, which is good at
> Git repo management (e.g. accepting pushes, generating packfiles to
> send you a specific object or branch, etc) - but when you ask for
> "git/git/archive/master.zip" you're getting the result of some work
> the Git server already did a while ago to zip up the current 'master'
> into an archive and give it to some other server.

It's impossible for me to say definitively what the performance problem
is in this case, but I don't think it's intrinsically Git if you're
seeing less than a 50 MiB/s speed.  Git can and does process data at
that speed on the local system (and at 15 MiB/s on my local network over
Wi-Fi), so I'd guess that it's either a limitation in network
performance based on two different serving locations or perhaps a
temporarily overloaded server combined with the packfile not being
cached.

[0] I personally think 50 MiB/s is a very reasonable transfer speed, but
some people disagree.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--20fQWYPE5ZCAhB2b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYAtwuQAKCRB8DEliiIei
gX9/AP9ZG6HaT4EtuVTagvdtQjari5BiQveSaH0ft1YprUvErgEAhihdpaeoMfKt
Rp5F0pNyeMbcQ1+bfa5gSV7CfmWDcAE=
=t4iv
-----END PGP SIGNATURE-----

--20fQWYPE5ZCAhB2b--

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1F061F404
	for <e@80x24.org>; Sat, 20 Jan 2018 06:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750937AbeATF5d (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Jan 2018 00:57:33 -0500
Received: from smtp.gentoo.org ([140.211.166.183]:33208 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750745AbeATF5c (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Jan 2018 00:57:32 -0500
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by smtp.gentoo.org (Postfix) with ESMTPS id 90E7B335C39
        for <git@vger.kernel.org>; Sat, 20 Jan 2018 05:57:31 +0000 (UTC)
Received: (qmail 29267 invoked by uid 10000); 20 Jan 2018 05:57:30 -0000
Date:   Sat, 20 Jan 2018 05:57:29 +0000
From:   "Robin H. Johnson" <robbat2@gentoo.org>
To:     Git Mailing List <git@vger.kernel.org>
Subject: regression in output of git-pull --rebase --recurse-submodules=yes
 --quiet
Message-ID: <robbat2-20180120T054223-685328376Z@orbis-terrarum.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l0l+eSofNeLXHSnY"
Content-Disposition: inline
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--l0l+eSofNeLXHSnY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Somewhere between 2.13.6 & 2.14.1 there's an output regression. I
haven't done a bisect to trace it down further yet.

Specifically, --rebase --recurse-submodules=3Dyes seems to cause --quiet
to not be effective anymore.

Full commandline:
$ git pull --rebase --recurse-submodules --quiet

In 2.13.6, there is no output, it's quiet as expect.

In 2.14.1, you get:
HEAD is up to date.
Submodule path '_data/news': rebased into 'a50b763c338161b4621d23e9fa5cd6e1=
1455d6ca'
HEAD is up to date.
Submodule path 'glep': rebased into 'e1f100ec3ba44ab1672d61cabf4690b355e461=
58'

Steps to reproduction:
1. git clone --recurse-submodules \
 https://anongit.gentoo.org/git/sites/www.git
2. cd www
3. git submodule foreach --quiet git pull --quiet origin master
4. git pull --rebase --recurse-submodules=3Dyes --quiet

Repeat step 4 for repeated bug output.
If you drop the --rebase, then you need to re-run step 3 first.

--=20
Robin Hugh Johnson
Gentoo Linux: Dev, Infra Lead, Foundation Treasurer
E-Mail   : robbat2@gentoo.org
GnuPG FP : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
GnuPG FP : 7D0B3CEB E9B85B1F 825BCECF EE05E6F6 A48F6136

--l0l+eSofNeLXHSnY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iQKTBAEBCgB9FiEEveu2pS8Vb98xaNkRGTlfI8WIJsQFAlpi2khfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldEJE
RUJCNkE1MkYxNTZGREYzMTY4RDkxMTE5Mzk1RjIzQzU4ODI2QzQACgkQGTlfI8WI
JsSFtA/+KzpVptBpjUkvX4q/DwZi/EmrQmFkLSMIfdA3rlGYPb/L0qO8TRlD85Lv
6b2ghLroeI6qy6UiJ4QrPTJCEe9sz+OZ0khycyW/hyPar2omV1a40M4Witx3pO/j
Dg67DHgXsSy4T3q3IHy0KtcJ7+01EZd565pgK2qbUfSDPgoCudrK0fRMos/BByLN
Ci7p2Cxc+0stxkER0gVKByp2J6jCqSP0w0KdphhqIgG4vyVNKsShW/gJWv4Y7K0G
bV22Sebr6pc/z/pCfNGGMrKyd1DEhUpkJ+ELqWQuAbmLapQaaA4GBjmMuvZ2u3KV
90zxSuLl8NSvmPVsBL4SGBhHysU7PWQ8CMWhfJUjJy/6JvXeF4jCHsvoDooaoUtU
n4Lsaynk3GYzxjCbEvafs2L6VurBXvh9gOC0Zx5azngZcIBspffFaIaH0Z8w3dhw
l03nCCwv2r5Ih6ofSGE2Xh78wgf6USJrdATLCKnt1kzStS7gWWD6yq75q6TOWv4q
Gk6RC/mMUZoBEToAYqngDa/1I1Ik8A3ownPoe6VzmahGA6jNTAFuMlYztnk1z9VK
yuNaCn4DOUXFBfGoH6cvKZomarHxxUXUujfaKQCYeNtBwqlRC9hrIsKK3PaoJVlh
aPqUMk4mJVbVu3mkQnJCnh1F348oyYbtqsIoVgV0CsKaXg3v8ls=
=nd3L
-----END PGP SIGNATURE-----

--l0l+eSofNeLXHSnY--

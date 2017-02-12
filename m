Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 231851FC45
	for <e@80x24.org>; Sun, 12 Feb 2017 16:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751297AbdBLQq6 (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Feb 2017 11:46:58 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:46642 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751270AbdBLQq5 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 12 Feb 2017 11:46:57 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id CFEFA280AD;
        Sun, 12 Feb 2017 16:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1486918014;
        bh=mtjqD5u9r/ojzjs4BKkFP80MXXaZyDkuxEvW14WyOiA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xjxRkDhLo+mKEN/deF2IhxTjAIjsw1aFJNiqX89Q32S2/w7Qi6o+AmAW9qi6ICcaE
         TVQqhhyMlVM46vjKbXKyRf53m0PUqM5737TSBsv4Bnp4GhIXy5iv9hjAHviW/6Fwey
         61XyYboLPqMWok9DRiKZzGZHS7yxOMnNCUH407Fag6grefL2a+kKpyHpO5BhlHiF+z
         lPjdBqidZs50BSZBTQeAQmzSussQXY170Aym2wip+xgMU1h8fcVkXiUPKwp8l9xeCY
         jn/+aM3qCWEWTZvZ6uUnrSaxv0dzp+/aX+T6fsZYyOMDllzsVzI2tO/9p/BN82JQlG
         qQTExDdQoQ9DzWlL+o2HBsNqnzMeiencKeCwNXet/GuXZMPmHTMVfjhmKAJSl5YC/t
         QxeT3sBA6pVUwT1CRos5wRpUTDS7pBCM3oFvOg0/2jYjegryK767wCGzEL9ebAK1/m
         MFCxoEaQ+aXIjSO3TshOpj6XVnKy8Pr7HiZoy8tq3cJHv/54htJ
Date:   Sun, 12 Feb 2017 16:46:50 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Mark Gaiser <markg85@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Git status performance on PS (command prompt)
Message-ID: <20170212164650.u7frv234kmu5hm7r@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Mark Gaiser <markg85@gmail.com>, git@vger.kernel.org
References: <CAPd6JnGC3yeDo_sB+H+UKvh-PbiC2qySC=EbaRNLbkkwYkJM4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zvffb3zkaafusax2"
Content-Disposition: inline
In-Reply-To: <CAPd6JnGC3yeDo_sB+H+UKvh-PbiC2qySC=EbaRNLbkkwYkJM4A@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-1-amd64)
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--zvffb3zkaafusax2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 12, 2017 at 04:53:47PM +0100, Mark Gaiser wrote:
> Hi,
>=20
> I'm using ZSH with some fancy prompt. In that prompt is also a quick
> git status overview (some symbols indicating if the branch is up to
> date, if there are changes, etc..
>=20
> The commands that are being executed to fetch the information:
>=20
> For the file status:
> git status --porcelain
>=20
> For the repository status:
> git status --porcelain -b

So your prompt is running git status twice?  Wouldn't it make more sense
to just run it once and do a head -n 1 to filter out the branch when you
need it?  git symbolic-ref HEAD might work as well.

> On small repositories (or even medium sized ones) this is fast, no
> problems there.
> But on larger repositories this is notably slow (i'm taking QtBase as
> an example now, but the same is true for much of the Qt repositories,
> or chromium or even the linux kernel itself). It's no problem if it's
> slow when you do "git status" on the command line. That can be
> expected to take a little while on large repositories. But in zsh
> prompts the call to git isn't asynchronous [1] so any slowdown will be
> noticed as the prompt simply doesn't completely show till after the
> command.
>=20
> I did a bit of profiling in git to figure out where this slowdown comes f=
rom.
> Callgrind tells me that "read_directory_recursive" takes up ~62% of the t=
ime.
> Within that call the function "last_exclude_matching_from_list" takes
> up 49% of the time it takes to run "git status --porcelain -b".

This isn't entirely surprising.  When git status runs, it checks all the
files to see if the stat information is changed, and if so, updates the
status.  last_exclude_matching_from_list determines if the files are
ignored, which is also necessary to ensure that only the proper files
are listed.

That doesn't mean that there couldn't be some improvements there,
though.

> I don't really know how this code is supposed to work (i'm a git user,
> not a git developer), so i hope someone might be able to investigate
> this further. I can however apply patches to git locally and help out
> with testing.
>=20
> Also, is there perhaps a command out there that might be better suited
> for the git status i want to show in the prompt? What i have now is
> merely from one of the oh-my-zsh themes.

I typically use the vcs_info support built into zsh[0], although that
can be very slow on my phone.  It performs adequately on most
repositories on my laptop and server machines, though, including on the
Linux kernel repo and our 2.4 and 9 GB repos at work.

I don't know that it has all the functionality that you need, as git
status provides finer-grained data, but it might.

[0] Example at https://github.com/bk2204/homedir/blob/master/.zsh/prompt_bm=
c_setup
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--zvffb3zkaafusax2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.18 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAligkXoACgkQv1NdgR9S
9os52A//f556zF4Z8dS5eiUHFVbeQwPjltyc1ivft8bkgT0lSo7PXD9xMkhidZ4n
Py9W7Fuaek+DZDkdneBZ47TZl0BnFbhdNIAdo8XXOcVBI19IIsKAZQdg9AWn8PRO
+k7iOgKI+T7gFoY/fHpBAFCrB2t2L5Ww2xzEHJmFlL4mFO9LW0SQ4pJS2H2+MNv7
Ns7LcmJEf0eNeVz3LYr6XLxuMe1E/5/g0ttK+TUey2cHIXE95p+nYvGzAocV6BN7
iFyfMco9U1RcC/owGFNsoUi9bQAAEfFfJQXAzh1SzCd4q05hvanLl1ZnHsDad+f1
HMSUzzXjK2TSHBboZFA/rG40Wvr/vBlYPSS4beOvr019FiFuJuojE4PyMT47vzgN
ruvLkWWmpltDvR4ipa14X5FJ3chW8B0K2T91N13wQAVDOZnfzAuAmelAq1npRKwR
KCEuU6bsqfVcxLwTasIKGVRboUf5+l4USml4lbZHBXzq5GqsLeEUJpbOgDSZabxi
a+2KSNeGXz2DWj8hFc/3dONdLvZp4ifioJ5blUBtucdFtrbxs+819zOolvcVGoMI
SzuR/5L+7Zx8DWVdcZRYbiAeWwKpEZPf3X2UEyloiom9+qUsgLvmV0WYcFxugue9
Ib+IaQTQUTtlPd/aXAXWMNwI0obGSPJuIHwCm0fQ/tnZ0/R6tLc=
=IUqb
-----END PGP SIGNATURE-----

--zvffb3zkaafusax2--

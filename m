Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBDD4C433C1
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 04:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB1E16023F
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 04:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbhCaEYl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 00:24:41 -0400
Received: from mail.archlinux.org ([95.216.189.61]:43476 "EHLO
        mail.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbhCaEYI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 00:24:08 -0400
To:     Jonathan Nieder <jrnieder@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-rsa; t=1617164641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YDIZ2fKnCZrpvoD8quBZNiiPGqDBu3atV9mGFA2KgIc=;
        b=QaKTCkQy06bX9jS0cQOgZVk3PsYOVCAPo/0OEmRGBc2YtJ364oOZxzlrYHEzdesGHHmEgz
        7F6vqy1EF8g+CiWdvFlpaCunxWWz9y+N7s6St2Lr5x4z0gMKqOP8ZVFheHCnS1i1BPUouQ
        ayDSdSmisKqPzFdjDOk0XZkZmGEkQGpIEh8KgtEeBrNMfd5l8TAeWLf7O1MhiRNwWjoSpt
        SNqHwgF3gfSz5FwnoldEhDb37H36ytqBPAEElL3NPExEJ/wAWdntMCf5EexHHaA5he8zBZ
        Q+lNXusuxWe5O4amsYlJGpY9qcT15MUISwtj+Vokti2tNioOyttv+aZkeyhq5c1v2KSV9h
        lBxYnAT4IFP7f2qQv3FSeT2Fb8zVU1fCVuKC4Oa45fny6uycVGdey3r9kRn7rob1CFVkwh
        5fG8Q+QfDwgtDS4Os3DOCckvGJ171F211Q+t5QQSxhYyTvXRjCQAJjMOKlcQgr6araFer5
        X3aLAQ0unf7oeWFBU+bFFkkmx5hXCkKq+qlPv7sIQBGlaVO5AKJEVAdeQvKaf4AN/qqICh
        OTRzyg1eTZB/x1PfX1SBWtdgYnL1nDF356c6U07GGFkF2UcavCz33XF+3aAcK3iKlGt8di
        bb+w9GrJOxVLkjz2vuc05IxOv9ijdaSBIrj54Vpylr1/LJAbyDUYk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-ed25519; t=1617164641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YDIZ2fKnCZrpvoD8quBZNiiPGqDBu3atV9mGFA2KgIc=;
        b=eJPcuEGOGIyGxzd9mbEJwaGNAy21o4tBWdb8ahEeLPRVinTSQ6oz+bK6YLDB4JINHJmCsf
        bAUG7ncY+L2AEVDA==
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Drew DeVault <sir@cmpwn.com>, git@vger.kernel.org
References: <C9Y2DPYH4XO1.3KFD8LT770P2@taiga> <YE+ftT2WaKDzc+45@google.com>
 <C9Y4NXXX6HRI.1IROIK8ZXK4S2@taiga>
 <YE/ZSiuIsMs3ucVM@camp.crustytoothpaste.net>
 <C9YD4AEUH84L.29FP64NJJ1BPU@taiga> <YFADuptwV7iR76g5@google.com>
 <40740478-8b3c-b33e-8bb4-a2d68b83d385@archlinux.org>
 <YFCckC8fHmEyOAnp@camp.crustytoothpaste.net>
 <8fed0d1f-a2bd-131c-5552-e95216b43474@archlinux.org>
 <YFJ/g2N+s1V3/qMo@google.com>
From:   Eli Schwartz <eschwartz@archlinux.org>
Subject: Re: Regarding the depreciation of ssh+git/git+ssh protocols
X-Clacks-Overhead:  GNU Terry Pratchett
Message-ID: <0206a8b6-8b07-24c8-9513-ce638339eafc@archlinux.org>
Date:   Wed, 31 Mar 2021 00:23:57 -0400
MIME-Version: 1.0
In-Reply-To: <YFJ/g2N+s1V3/qMo@google.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="TXan9gjM1d9MI2W7KTzHZuee9QWm2y8lz"
Authentication-Results: mail.archlinux.org;
        auth=pass smtp.auth=eschwartz smtp.mailfrom=eschwartz@archlinux.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TXan9gjM1d9MI2W7KTzHZuee9QWm2y8lz
Content-Type: multipart/mixed; boundary="RULSiy2zlp05bvNvLBGyjgBvu6Dh1HZ7U";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@archlinux.org>
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
 Drew DeVault <sir@cmpwn.com>, git@vger.kernel.org
Message-ID: <0206a8b6-8b07-24c8-9513-ce638339eafc@archlinux.org>
Subject: Re: Regarding the depreciation of ssh+git/git+ssh protocols
References: <C9Y2DPYH4XO1.3KFD8LT770P2@taiga> <YE+ftT2WaKDzc+45@google.com>
 <C9Y4NXXX6HRI.1IROIK8ZXK4S2@taiga>
 <YE/ZSiuIsMs3ucVM@camp.crustytoothpaste.net>
 <C9YD4AEUH84L.29FP64NJJ1BPU@taiga> <YFADuptwV7iR76g5@google.com>
 <40740478-8b3c-b33e-8bb4-a2d68b83d385@archlinux.org>
 <YFCckC8fHmEyOAnp@camp.crustytoothpaste.net>
 <8fed0d1f-a2bd-131c-5552-e95216b43474@archlinux.org>
 <YFJ/g2N+s1V3/qMo@google.com>
In-Reply-To: <YFJ/g2N+s1V3/qMo@google.com>

--RULSiy2zlp05bvNvLBGyjgBvu6Dh1HZ7U
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: quoted-printable

On 3/17/21 6:15 PM, Jonathan Nieder wrote:
> Hi,
>=20
> Eli Schwartz wrote:
>=20
>> I'm not especially attached to the proposal. I'm a maintainer for one
>> of these package managers that currently special-case git+https?:// an=
d
>> rewrite the url that git sees, which has worked adequately for a long
>> time.
>=20
> This is useful context.  What URL forms does this package manager
> support (e.g., do you have a link to its documentation)?  What would
> the effect be for the package manager and its users if Git started
> supporting a git+https:// synonym for https://?


https://archlinux.org/pacman/PKGBUILD.5.html#VCS

We support cloning arbitrary version controlled sources via either

vcs://

or vcs+proto://

but not

proto+vcs://

so that encompasses git:// or git+https:// or git+ssh:// and also
permits hg+https or svn+https:// or bzr+http:// or fossil+https://

(ignore the documentation not mentioning fossil, this is a development
branch addition and obviously the docs are for the stable release)

We then do prefix removal of everything before the plus sign since
currently no VCS supports this directly (I think?), but we could remove
that pass from our git source plugin if git implemented it internally.

Implementing https+git:// as a synonym for https:// is IMO confusing, so
I don't intend to implement it even if git does. I think one way to
specify the VCS + transport protocol is enough... and prefix removal is
easier than removing the middle of the string.

The net effect would be, I guess, less code in the package manager, and
users would be able to go to a public registry of source packages like
https://aur.archlinux.org/packages/pacman-git, see the clickable link
under "Sources (5)" and copy/paste that into a `git clone` command line
without knowing they need to edit the link first.


--=20
Eli Schwartz
Arch Linux Bug Wrangler and Trusted User


--RULSiy2zlp05bvNvLBGyjgBvu6Dh1HZ7U--

--TXan9gjM1d9MI2W7KTzHZuee9QWm2y8lz
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEYEETBMCdNmKDQO7/zrFn77VyK9YFAmBj+V0ACgkQzrFn77Vy
K9av/RAAquR2Di/zXix1y/qLD/Ft3ujMnpOLVhthxAmIlMtLfXhuxO2oMKQL/0vd
N4OTV70ShlUcV0cYfuAdPUcpmvjNvJg0ZB+K8Q9iBgedf2wbvlL9oTQ9RftI1J/s
g9SfDNyE91RQrTqDM8+wxmFqYd1cPlgarMp5jPmIMvI9cSQBIJDglK+etxIRMGct
IV+Vs0yL43Nq/YV6si2veiLtkCbBh+6GZFbA/vykUqTiuflgD/IfZay9Al0+bzub
AS8xNX/2/PGy89DWnW64SMvR9XWDEwuBjDNke8kH28IsshFApwY0Z3JmAUrXn8ya
QFSvCS/1r1+52d3WMFGDTQ5rCFTsGwc3GihFlDWYnrHlras21AfHneaykbqd8YXI
C8FCAi7cL//PifcuMgTBcMyBua2ugX7W0ZRSBXLXtwklDTNu137Tn9rm6Z8/kxT3
/Xvnb+aRFm/rOSXD7drq+OyQ5uUSyrzNV9NFpUfGUJiPEyn0QFHxOaZupg35T8GL
+zc3bgwk7LyoT0u2IrM6rfFpEUaxPNV3M6F7ZGcoY3BA5V+CVCYlDY/5MF6g9E02
JUW+/nSiqW0M1B5YaedEv7Vl+pFAA2UyLJlpzqHD1yDTrDdkdX144HIUdr/tBc2c
fbw7H0qyIPchaSqqNnc1nWokfZjsMXvjS7d+qAsBObp+u4VAf2E=
=F9dM
-----END PGP SIGNATURE-----

--TXan9gjM1d9MI2W7KTzHZuee9QWm2y8lz--

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E698C433FE
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 00:07:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiJMAHQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 20:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiJMAHN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 20:07:13 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8035C103DB3
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 17:07:11 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 4EA205A39C;
        Thu, 13 Oct 2022 00:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1665619630;
        bh=Bks4pPurLPFfbX/m4xo4qDGlYlaQthUYzGc3O6xnsZU=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=bvtsQajoll5hzkuFMNnoDCjazhnq6kZW6P/9FOkb3his+t1LBOTy+PTtdxtyiPddq
         FGFWdnlY8Nj3b6v1k7lB1lOVdd+HkmN/JCqyAsqIyW13034JCeuN61HKvpfsTX+lMW
         gDT9bTsq7ozBfVRM2FcUSB0D/mXdJgI7ywyQLBdn/VujZx7Wje/bxcPKC7B29jUNBW
         iUO/FdBIMtrD4WoQubrwWIHAKMhJFDPhEDk6z0bQyHIJE70OC/WUX2xv79aAPmrBLx
         OBGppi1x2a3o8H6S0UOkAqKBOdzj+65lvwrWD1CU6js5VpcMKHK+cXdMYacT8RvGR6
         K1nMtHxT66xWYJww73lCV3F8ErXCN2MVY+jAq4SgrwGJh9lJRxhv/8R5zRvLTKy4oR
         0oYecSacEW6xQTkoQ9i5Q3KPCpjzgWvyMwyItGMRhOvCCSSuAAifUibo+uoJ1XZQYD
         fmamPUJkLL6TY2wjBaajbWyiH963PdCrHoVKG/v7U8lIHJcx9HE
Date:   Thu, 13 Oct 2022 00:07:08 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Thorsten =?utf-8?B?U2Now7ZuaW5n?= <tschoening@am-soft.de>
Cc:     git@vger.kernel.org
Subject: Re: How to best maintain directories like /etc/sysstat in GIT?
Message-ID: <Y0dWrAba6U+j0tT9@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Thorsten =?utf-8?B?U2Now7ZuaW5n?= <tschoening@am-soft.de>,
        git@vger.kernel.org
References: <1681596318.20221012183551@am-soft.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5oal0ECaTlFN+5Au"
Content-Disposition: inline
In-Reply-To: <1681596318.20221012183551@am-soft.de>
User-Agent: Mutt/2.2.7 (2022-08-07)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--5oal0ECaTlFN+5Au
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-10-12 at 16:35:51, Thorsten Sch=C3=B6ning wrote:
> Hi everyone,
>=20
> I'm using SVN to maintain lots of different host specific configs like
> crontab files, web server configs and the directory /etc/sysstat. The
> current approach is to simply have some directory structure in trunk
> named by topics like /trunk/Mail/Postfix for some reference host, if
> any makes sense at all. That config is then copied to e.g.
> /tags/Mail/Postfix/some.other.host and Postfix for that host
> maintained in that writable tag.
>=20
> GIT doesn't have writable tags, which might be worked around using
> branches or one repo per host or stuff. The more important difference
> is that SVN can have a working copy for each and every maintained
> directory. So one can really make /etc/postfix or /etc/sysstat a
> wroking copy and maintained that only, without additionally necessary
> subdirs and without having .svn in /etc or alike. AFAIK that is not
> possible in GIT, even with sparse checkouts one needs a subdir of
> some kind, which is pretty incomplatible with many system wide
> configs. Unless one wants to put .git into / or /etc or alike, which
> is what I would loike to avoid.
>=20
> Any useful suggestions for workarounds?

There are a couple approaches you can take.  One is to keep the
repository elsewhere and simply copy files into place.  This is how I
and many people manage our respective dotfiles with Git.

Another option is to use some sort of automatic system for managing
those config files, such as Puppet, Chef, or Ansible, and keep those
files in a repository suitable for that system.  This is how I manage
configuration for my servers and how we do it at work.

Finally, you can also keep the Git directory separate from the working
tree.  For example, if you're in /etc and your repository directory is
/srv/checkouts/etc-git, you can run one of the following:

$ GIT_WORK_TREE=3D/etc GIT_DIR=3D/srv/checkouts/etc-git git status
$ git --work-tree=3D/etc --git-dir=3D/srv/checkouts/etc-git status

(Note that you must set both environment variables or both options, not
just one.)  Of course, this is a little unwieldy, so a shell script may
be helpful.  You'll also want an appropriate .gitignore file.

> I can only think of two things: Putting the GIT clone somewhere and
> link directories into that. Which won't work very well for directories
> for which I only want to maintain some and not all files and seems
> like a lot of work, might break package management etc.

Git does not preserve hard links and this won't work in general.  Since
Git also does not preserve permissions other than the executable bit, so
you almost certainly will not want to use symlinks, either, since that
means the destination directories may change ownership and permissions
when you run git checkout.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--5oal0ECaTlFN+5Au
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.39 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCY0dWrAAKCRB8DEliiIei
gSqvAQCSxQv1Q4fv8xjNWlAzqXDcN/MGG6aSfI1VTZB/kfju9wEAjrAW6VvpLfcm
yfLmtxiNUkF4WFGPL2Qvv/RvoPnnawM=
=3eeW
-----END PGP SIGNATURE-----

--5oal0ECaTlFN+5Au--

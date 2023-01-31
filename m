Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2FDC636CC
	for <git@archiver.kernel.org>; Tue, 31 Jan 2023 22:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbjAaWco (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Jan 2023 17:32:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjAaWcm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2023 17:32:42 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6B03403B
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 14:32:41 -0800 (PST)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 283915A300;
        Tue, 31 Jan 2023 22:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1675204361;
        bh=eO4JRayDanQoHPlfk5fqWkf3pAs0TbI4pk2gL2bNv98=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Uqx580uB2VGRRyLfgFeWrw6fCavxJnyPo0gj58xFq+qjTk6p7lt0LOUvlwpCu5YoH
         on3fL79lmXl/hVrdMoZEzJ6Y2+Yi9WCqEzgCUr/TOmhDk8zCz6HgPpCUiwDb66gLZ2
         4PLkS1PDaDw09oPDQnIRulmrXWCX8Jpkz7w/aImWrTxrmz76epH7ylx3H3sih61jGT
         METPByrIxFGi4g93zau3CXPeantIqOql6IRwKQyJFKIBEu58ldYBKhZN8qReCQKma5
         ljZIBjQB+uNXo6rgJ6reiMN1MufnMjkxspykNBUt8iqAFijtMzu/WRaeZWsyrvcWkS
         tZCX8Oi1vbbTu+Wp8QI+VW5/nhFznlUbgR3vPF+AJZhJVH5k24yDOy5NRI9+e4rCAM
         aybvcYECPqEQ//Qv8hgB8ko9BL3MY4q2ATdOk4dXCjteSnebSPScvlSKxKSV202OkX
         pze1oBKRWjApwcXuQb0w1utV/2C80ubI8zrAbbOtbzw8ubwP4K/
Date:   Tue, 31 Jan 2023 22:32:39 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Eli Schwartz <eschwartz93@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: Stability of git-archive, breaking (?) the Github universe, and
 a possible solution
Message-ID: <Y9mXB1LaYSUJBlwF@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Eli Schwartz <eschwartz93@gmail.com>,
        Git List <git@vger.kernel.org>
References: <a812a664-67ea-c0ba-599f-cb79e2d96694@gmail.com>
 <Y9jlWYLzZ/yy4NqD@tapette.crustytoothpaste.net>
 <20230131150555.ewiwsbczwep6ltbi@meerkat.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XrJ/fdFj5fnUO76c"
Content-Disposition: inline
In-Reply-To: <20230131150555.ewiwsbczwep6ltbi@meerkat.local>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--XrJ/fdFj5fnUO76c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-01-31 at 15:05:55, Konstantin Ryabitsev wrote:
> On Tue, Jan 31, 2023 at 09:54:58AM +0000, brian m. carlson wrote:
> > I'm one of the GitHub employees who chimed in there, and I'm also a Git
> > contributor in my own time (and I am speaking here only in my personal
> > capacity, since this is a personal address).  I made a change some years
> > back to the archive format to fix the permissions on pax headers when
> > extracted as files, and kernel.org was relying on that and broke.  Linus
> > yelled at me because of that.
> >=20
> > Since then, I've been very opposed to us guaranteeing output format
> > consistency without explicitly doing so.  I had sent some patches before
> > that I don't think ever got picked up that documented this explicitly.
> > I very much don't want people to come to rely on our behaviour unless we
> > explicitly guarantee it.
>=20
> I understand your position, but I also think it's one of those things that
> happen despite your best efforts to prevent it. :)
>=20
> May I suggest adding a "git-archive --stable" that offers this guarantee,
> simply as a matter of codifying the fact that the world has built
> infrastructure around git's repeatable output. Maybe just for .tar (and
> .tar.gz).

It is my intention to implement just .tar.  That's my proposal: simply a
pax-based format that serializes in a consistent way according to a
predefined spec.

As far as whether other people want to implement consistent compression,
they are welcome to also write a spec and implement it.  I personally
feel that's too hard to get right and am not planning on working on it.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--XrJ/fdFj5fnUO76c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCY9mXBwAKCRB8DEliiIei
ga79AP9WC0qnQk8C2o6Wz+vf2+nEuJzoKQ3ouQsvCCOVrLVHYgD9H4GK2HF9kFLn
zrn8xs64Gn2l1DbgSdre+1bGk/3zaQE=
=3NXQ
-----END PGP SIGNATURE-----

--XrJ/fdFj5fnUO76c--

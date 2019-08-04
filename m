Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9F8B1F731
	for <e@80x24.org>; Sun,  4 Aug 2019 17:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfHDRUQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Aug 2019 13:20:16 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57294 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726332AbfHDRUP (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 4 Aug 2019 13:20:15 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:49db:b3cb:1703:1c9a])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6E1CF6047B;
        Sun,  4 Aug 2019 17:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1564939213;
        bh=vJKVDkE/7M6B5vDBDy61sDbWkOMwvLKQq7BVdWAZgMY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=o6MTB+tAOK43ezpdpg6/Mqx5QTXtxu67HFmtXWZctMJ5JS4vvTrngpF7ZRO6fVvb4
         I8XTnWiGOBYNY/6xdCl9sIBCxk26jyel1OXGFUTkA3tmMzSmcTEJo0QpoBpcr4h7EI
         PH3+WkMXbxXBfRHtvO4+thoevQshZmeKCzp/ecHJJuasUeuN6gBpUlGuqKbPFnuz0Q
         hx1qrTtBznn5slJvhggLbB7ut7JpSVYm64JnWwmd8Gd2K70nt5o5f4mlt8NwmtwRJE
         cJgNWkotKQv9eIurT3HN3o4goZn0ugqbO6GNX2+e2Q23Ghs5f9TszLD2h808n3wtpY
         +nDDKYfFZefo9fdHTvX0JQMM/yYPZLEHeC2TQgPY0+q+IprIs5qSfH6+O6l/27arJb
         Iz+/X2Q/H+j0EsbiugVE1UtCV+pmVam3hJi4DAvDNC+zLeRjN9ZdwimpK2ScUAlCmP
         udINLvBvrddQmGp/oJJBkodCaJ5wJjBVsipaUzt9NdDKxMwseQm
Date:   Sun, 4 Aug 2019 17:20:08 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     johnywhy@gmail.com
Cc:     git@vger.kernel.org
Subject: Re: Default Clone Dir?
Message-ID: <20190804172008.GG118825@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        johnywhy@gmail.com, git@vger.kernel.org
References: <1564938816.2622.1@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mGCtrYeZ202LI9ZG"
Content-Disposition: inline
In-Reply-To: <1564938816.2622.1@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-5-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--mGCtrYeZ202LI9ZG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-08-04 at 17:13:36, johnywhy@gmail.com wrote:
> hi,
> Is there a way to set default clone destination directory on linux?
> Currently, seems to clone to the active dir.

It sounds like you want to always clone repositories to a single
directory. git clone doesn't have a configuration setting to do that,
but you can specify the directory you want to clone. For example:

  git clone https://github.com/git/git.git

would create a directory "git" under the current directory, but you
could also write the following:

  git clone https://github.com/git/git.git ~/checkouts/git

to create the repository in ~/checkouts/git. You can also do this:

  git -C ~/checkouts clone https://github.com/git/git.git

which will change to ~/checkouts and then perform the clone there. "-C"
says to change directory to the given location before running the
command; it must be specified before the "clone" command.

If you want to automate this, you can create an alias:

  git config --global alias.myclone '!f () { git -C ~/checkouts clone "$@";=
 };f'
  git myclone https://github.com/git/git.git

and then your alias will always clone to that directory.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--mGCtrYeZ202LI9ZG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl1HE8gACgkQv1NdgR9S
9ovs/hAAuJ80HpLEptYFJ6aTC6YAIZWEQyTZCTcMjIahJRoUSWWFwTxerStpLWWw
QwyQy9yXNCgzAnse+8MNNA+/mtIxU1aBPxEq7qT89KmFZewsiFXsUkJX87PtmDnA
rSRz2VkKPFLYv330/zdVciZ6CkLond9QVuKvVJ0tp4b+W3Qu2uAWjq80JOuV2Qht
9AkREnguwtmjp8LqTITlItgF4DGZaUgjqOsmsTbzriHo0R79RNw3MmtSa9wpFDuJ
Xu/0nMWdlm7AK1uvhWaCV/Pf7TKURDPLc8ms6hL5s1efnDC6Wy37xG7mfUamHOJW
4+BPfFyGk380P25JeglZ1GYkJNP1buI2OK+TCPU9LRYZ6RmFcmNMymQFeOuchSHF
ytqVGWnwMZmluFzpFcej9kwFt9pxS9+lorOQK+LwS5KXHZOKdYnMd8X1C+tnfLVB
QiEk3GZ7iGSeIQ4kPY3JCCebIW5JeaS1VtPcWXi3856qGdx1NS4Ql8s8a7f3k5HS
Mc9byWTLpttjvj2IPxfoZZOWX0Hm2kliTXHqg8TIfpbXS2RI+6gZHs1e+W5FU/q7
Y67ycOIvVBxhVzFft3Nt6X0XDSFwjCqug1cpERoRcLFQBO2zUc4+DOkrKQqA91Wh
2BsJZaIcxe7JcAtifdarTgECWPpDWiPMuLAygdkLTNCPlhXlNjM=
=TKHE
-----END PGP SIGNATURE-----

--mGCtrYeZ202LI9ZG--

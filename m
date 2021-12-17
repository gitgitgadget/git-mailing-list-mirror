Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC95C433F5
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 21:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239775AbhLQVO0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 16:14:26 -0500
Received: from ring.crustytoothpaste.net ([172.105.110.227]:52964 "EHLO
        ring.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236219AbhLQVOZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 16:14:25 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id B66105D498;
        Fri, 17 Dec 2021 21:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1639775664;
        bh=SF/C/ZNbg1jpr2TE8UwgVj7L+FWjR6Vsobx6mSE7g3w=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=TUyGcHBm8TiHC5mSasUpQH22eFECleOxUo3mFydEJVvhmdZm9ld8SZWbWENXgqXa+
         156bmQnwPRqM+S2//KJNWZyw2ADnu2oBX1i/yZjpT2mceSAFykB1WPxHWX6qdSgAuC
         YGV8PZD3cRrQqmC5xQ4q/kEpp1AKsGcaGwssng7wGuw8uVxebf4kfDRz+g3WhZJHmn
         qkIsV2PbcBO6Q70jdbfH9Pw5674mdiH9+gX8UCvTruISU6IPihPyxlkU+1b+EWYxt1
         Asj7nigWodSjuOIGdELe3ptlrPHfNYJG3OutQ9aiX3SP0upygaufOscVJ0c+XAtRS2
         fOMJKVGOW80qpj0P6k/p7bR2wJVwf/CGaf18KwF8J4SKjUWm0OWX7SCNvRlEj69s4/
         m82hGNO6aRpPXUEY21OeZuko/OiDNqkt0QZCT2IGnLGGK4Zx9tLGJQg+iBjmXTvwD9
         tpn8homAyM3JSpH8wSYtnoji/N49I23OvoIxVjB0vkTPZ6lxhG7
Date:   Fri, 17 Dec 2021 21:14:22 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Marc Strapetz <marc.strapetz@syntevo.com>
Cc:     git@vger.kernel.org
Subject: Re: Should update-index --refresh force writing the index in case of
 racy timestamps?
Message-ID: <Ybz9ruQ/uOfFbn3W@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Marc Strapetz <marc.strapetz@syntevo.com>, git@vger.kernel.org
References: <d3dd805c-7c1d-30a9-6574-a7bfcb7fc013@syntevo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zI+pq9JYRSTZKYnx"
Content-Disposition: inline
In-Reply-To: <d3dd805c-7c1d-30a9-6574-a7bfcb7fc013@syntevo.com>
User-Agent: Mutt/2.1.3 (2021-09-10)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--zI+pq9JYRSTZKYnx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-12-17 at 10:44:32, Marc Strapetz wrote:
> For one of my Git-LFS test repositories, switching between branches quite
> often results in lots of racy index timestamps. Subsequent calls to "git
> update-index --refresh" or "git status" will invoke the "lfs" filter over
> and over again, just to figure out that all entries are still up-to-date.
> Hence, the index will never be rewritten and racy timestamps will remain.
>=20
> To break out of this state, it seems favorable to write the index if any
> racy timestamp is detected. We will be able to provide a patch if this
> change sounds reasonable.

Sure, this sounds reasonable, especially if, as you mentioned, git
status already does this.  We might as well make the plumbing commands
as functional as the porcelain commands.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--zI+pq9JYRSTZKYnx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYbz9rQAKCRB8DEliiIei
gfehAQCnaus0ymd3QklWxXCdiWPVfV6moiARMPB15jEmXqfHNwEA8WjEeT5CD+tC
hGIUIvY5LXW2rkzy8X4U/OXzTkMh6Qc=
=4u4Q
-----END PGP SIGNATURE-----

--zI+pq9JYRSTZKYnx--

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69C3721847
	for <e@80x24.org>; Wed,  2 May 2018 00:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753322AbeEBALs (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 20:11:48 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37560 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751825AbeEBALr (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 1 May 2018 20:11:47 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id BBBB960129;
        Wed,  2 May 2018 00:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525219906;
        bh=678nj7xM38kElbbpkB6TIHTzFV9GDAPt9eeCcBx212I=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=iUNIcDVyP9GsbJsIugciev6d6P6iJngrQAyO1ubFOrZLzJROXLff5xZl3X2i5kkKe
         FCA/eqFZeXBYIP0Zk5kdp+NVq31Mfs1sw5Jl/ntcV2PAQMrYJaRIwsccHUMzjDw1zA
         JRrUEvirc3i/+DGou3FBNJ0Il01zQ1sz7Kepovu4eucdL4H2GzXPWjHCYXAPdYHTGd
         1Y3RGHpSLVCszJM/cE6QWCEeNxLLIilM3mmdeW3xmH68iEY67XrcKCf5eHWqYfGeJl
         x2I+8AknPwhtTbg6jCLyuXtEiXzFlTvmw8bQtGX5Nx8Q5aN+KlNgEOnIVXsvBYlhRD
         pj9v/F3JpVG95pkR1hWO7mUINLim5KNDZeLtmBomslA2tnEedynXJZJLj3F1kwKUzh
         uEw7Myw5RCi4Y45OvShd4ofZALUHKBFOdoH4U4/XBl1BeQ1Gun0QDcGhoTXSbrWQI/
         7vtH+bsZNt0YEcmnRW3ku8PFX9aPsniVbkznOgw4dCKelzxwd9d
Date:   Wed, 2 May 2018 00:11:41 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 08/41] packfile: abstract away hash constant values
Message-ID: <20180502001140.GH13217@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Duy Nguyen <pclouds@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <20180423233951.276447-1-sandals@crustytoothpaste.net>
 <20180423233951.276447-9-sandals@crustytoothpaste.net>
 <20180501102243.GE15820@duynguyen.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="17/8oYur5Y32USnW"
Content-Disposition: inline
In-Reply-To: <20180501102243.GE15820@duynguyen.home>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-3-amd64)
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--17/8oYur5Y32USnW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 01, 2018 at 12:22:43PM +0200, Duy Nguyen wrote:
> On Mon, Apr 23, 2018 at 11:39:18PM +0000, brian m. carlson wrote:
> > There are several instances of the constant 20 and 20-based values in
> > the packfile code.  Abstract away dependence on SHA-1 by using the
> > values from the_hash_algo instead.
>=20
> While we're abstracting away 20. There's the only 20 left in
> sha1_file.c that should also be gone. But I guess you could do that
> later since you need to rename fill_sha1_path to
> fill_loose_object_path or something.

I'm already working on knocking those out.

> > @@ -507,15 +509,15 @@ static int open_packed_git_1(struct packed_git *p)
> >  			     " while index indicates %"PRIu32" objects",
> >  			     p->pack_name, ntohl(hdr.hdr_entries),
> >  			     p->num_objects);
> > -	if (lseek(p->pack_fd, p->pack_size - sizeof(sha1), SEEK_SET) =3D=3D -=
1)
> > +	if (lseek(p->pack_fd, p->pack_size - hashsz, SEEK_SET) =3D=3D -1)
> >  		return error("end of packfile %s is unavailable", p->pack_name);
> > -	read_result =3D read_in_full(p->pack_fd, sha1, sizeof(sha1));
> > +	read_result =3D read_in_full(p->pack_fd, hash, hashsz);
> >  	if (read_result < 0)
> >  		return error_errno("error reading from %s", p->pack_name);
> > -	if (read_result !=3D sizeof(sha1))
> > +	if (read_result !=3D hashsz)
> >  		return error("packfile %s signature is unavailable", p->pack_name);
> > -	idx_sha1 =3D ((unsigned char *)p->index_data) + p->index_size - 40;
> > -	if (hashcmp(sha1, idx_sha1))
> > +	idx_hash =3D ((unsigned char *)p->index_data) + p->index_size - hashs=
z * 2;
> > +	if (hashcmp(hash, idx_hash))
>=20
> Since the hash size is abstracted away, shouldn't this hashcmp become
> oidcmp? (which still does not do the right thing, but at least it's
> one less place to worry about)

Unfortunately, I can't, because it's not an object ID.  I think the
decision was made to not transform non-object ID hashes into struct
object_id, which makes sense.  I suppose we could have an equivalent
struct hash or something for those other uses.

> Same comment for other hashcmp in this patch.
>=20
> > @@ -675,7 +677,8 @@ struct packed_git *add_packed_git(const char *path,=
 size_t path_len, int local)
> >  	p->pack_size =3D st.st_size;
> >  	p->pack_local =3D local;
> >  	p->mtime =3D st.st_mtime;
> > -	if (path_len < 40 || get_sha1_hex(path + path_len - 40, p->sha1))
> > +	if (path_len < the_hash_algo->hexsz ||
> > +	    get_sha1_hex(path + path_len - the_hash_algo->hexsz, p->sha1))
>=20
> get_sha1_hex looks out of place when we start going with
> the_hash_algo. Maybe change to get_oid_hex() too.

I believe this is the pack hash, which isn't an object ID.  I will
transform it to be called something other than "sha1" and allocate more
memory for it in a future series, though.

> > @@ -1678,10 +1683,10 @@ int bsearch_pack(const struct object_id *oid, c=
onst struct packed_git *p, uint32
> > =20
> >  	index_lookup =3D index_fanout + 4 * 256;
> >  	if (p->index_version =3D=3D 1) {
> > -		index_lookup_width =3D 24;
> > +		index_lookup_width =3D hashsz + 4;
>=20
> You did good research to spot this 24 constant ;-)

Thanks.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--17/8oYur5Y32USnW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.5 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlrpAjwACgkQv1NdgR9S
9ounPxAAhNhDaH6LLXYqwWKc22KrY1Px+K8WgWgFJtD6TVYep/3hDzs5/CKD0ppW
POEeBWQ6ptlGhlInbJYuHBlG0035jOMEmertr6GFXwrYe9SG6iK7ePQSOlJg/J2D
y4XrAnAfyGAZzKKnAfOp4LQv9W2qVmt18hri+IYBMY9fchQegP6sgTYJ0dxV/UrL
5WKDrMkmgfyn0qN4pkx1VOSE/p8IBHvdNTK6VH8RJQIhFT3ukGzBj+V9a2S+DPa1
9FawJ6SAEj0vkRSD1/wKfU6inpVOD2m1ElnM/F7AnIuRvFIQQFLHgbyS7g1vYp9+
ALHixCsjpAdEsvOMSTM10pVDeWXnzd4TYhbmZB3IxG/GpS98Gq5rTrD71Ey2M5m0
jV7b0OcjpvQZ2veEd8gOGWMa6wS2WJS1AP7zWvqSdzkI+AMHHqZwSZsZeQib78Cd
5Tb2wJcMFBbDX+ThHGJKBIbV9FkeHN2wqL5pvbtg21ck7+w9z/cFllOjXo0p5wG+
2gLHUy9738+GBk5JVno6A6N2sTHQoQHtVnuHF43B+8CV8kVrvFSrXxODQTfHnC/l
LmZKBC/1EJ5q0PGZekZVIMFlQCj4gc1JYlxLUu/Ywx3XJtTKWiKaAP9xdc8fx60q
S1xooeTutIakZZ3VF2DtKzScatTTwzT3xAwtT3AHIowsNEK+lzc=
=WrBp
-----END PGP SIGNATURE-----

--17/8oYur5Y32USnW--

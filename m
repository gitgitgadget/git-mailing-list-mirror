Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B552F1FAFB
	for <e@80x24.org>; Wed, 29 Mar 2017 00:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932516AbdC2AGz (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 20:06:55 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:58664 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932088AbdC2AGy (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Mar 2017 20:06:54 -0400
Received: from genre.crustytoothpaste.net (unknown [172.16.2.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 6B081280AD;
        Wed, 29 Mar 2017 00:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1490746012;
        bh=vYTDAggxZXENSOWZ5mjYOZ2BuPG1VwoRIqHAYWvv/nA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iyUsuG3lHg0jrAIjg8YnjGHjBDsyDX5MR8jgWyJCLsmFP7oyiWPzo5GiXTSSyRkHe
         VM+m8nO1QbzX9UPvQmct0XWe0w9XWloJYo9Cq4RDdCHd4tRgmO37pkViYMJWnPjd7f
         bgoNTeuLcHeVb5BgwCZ8dyXV+eDBNsEpXTQrr6PL8EHDIYpLBRhMOgfd4B0whz8Ao9
         /4YZprqJnmHcS3Su4+jA85ORui/Up4Qxcc4Nl60JLtlbxrFZeIoGRRxXPbzuSFG87M
         aC9oGs7wDohKGfGuCjXKDLt1tl8Q9zy1Hk9LM078vydv3jWI2J4BB60PFnF/eVbVj3
         KImyH3rBp4c042U5/WGF67Ne0uXiUbaJ+ZWXFEOku7Ewzu4BA6a1eF1tv9lvxyzy8X
         RiY29JLmhDpqSfV/x/wg/hwV3LqdgWv/b329elCoWJsxxYjE2qVpzZX19U3hFgR04T
         RmBsqJWc1Q0DhBfy5h9dulRX3k5nRzBTQcRJ11Mdk9UiNl3INgW
Date:   Wed, 29 Mar 2017 00:06:48 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 16/21] Make sha1_array_append take a struct object_id *
Message-ID: <20170329000648.vb2hdqfizjqjyryr@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
References: <20170326160143.769630-1-sandals@crustytoothpaste.net>
 <20170326160143.769630-17-sandals@crustytoothpaste.net>
 <xmqq7f39e2gi.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="agrtclly7u5j74x6"
Content-Disposition: inline
In-Reply-To: <xmqq7f39e2gi.fsf@gitster.mtv.corp.google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-2-amd64)
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--agrtclly7u5j74x6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 28, 2017 at 10:27:41AM -0700, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > Convert the callers to pass struct object_id by changing the function
> > declaration and definition and applying the following semantic patch:
> >
> > @@
> > expression E1, E2, E3;
> > @@
> > - sha1_array_append(E1, E2[E3].hash)
> > + sha1_array_append(E1, E2 + E3)
> >
> > @@
> > expression E1, E2;
> > @@
> > - sha1_array_append(E1, E2.hash)
> > + sha1_array_append(E1, &E2)
>=20
> I noticed something similar in the change to bisect.c while reading
> the previous step, and I suspect that the above two rules leave
> somewhat inconsistent and harder-to-read result.  Wouldn't it make
> the result more readable if the former rule were
>=20
>     -sha1_array_append(E1, E2[E3].hash)
>     +sha1_array_append(E1, &E2[E3])
>=20
>=20
> FWIW, the bit that made me read it twice in the previous step was
> this change
>=20
> -		strbuf_addstr(&joined_hexs, sha1_to_hex(array->sha1[i]));
> +		strbuf_addstr(&joined_hexs, oid_to_hex(array->oid + i));
>=20
> which I would have written &(array->oid[i]) instead.
>=20
> After all, the original written by a human said E2[E3].hash (or
> array->sha1[i]) because to the human's mind, E2 is a series of
> things that can be indexed with an int E3, and even though=20
>=20
>     *(E2 + E3)
>     E2[E3]
>     E3[E2]
>=20
> all mean the same thing, the human decided that E2[E3] is the most
> natural way to express this particular reference to an item in the
> array.  &E2[E3] would keep that intention by the original author
> better than E2 + E3.

I'm happy to make that change.  I'm an experienced C programmer, so a
pointer addition seems very readable and natural to me, but if you think
it's better or more readable as &E2[E3], I can certainly reroll.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--agrtclly7u5j74x6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.18 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlja+pgACgkQv1NdgR9S
9ovAwBAAvTKc8IRRdbZA6WlHDnPD1dTNudYViLe5CYkWYmIZygGnLRlJp3/vAhsX
iBL00SocGVBFux15xL7BNdJXM69xl5doQejZqwFFDGBaEZXWtx5dkE83VMK8BmbK
r+XCADU1DiQrQJsT2+SyBy84fIP79oGAV2e3+Kopms9XijLzm/CuNHHLQ32z0dw0
bkf/5Ri8DOSyllBNNaXTnyj2bVlFcnpMjg6NbKlyXrvRB/+BSJqi08QuQv6350t+
S7G982e/yfmQZrdjsvVOunvwoNhVIrmVTP20ktFeeeYBZpAE7ldFm4yii9c8SEzd
7uKH+k4XEDvhbFwtDU4iyu7xQboE0shEAiElmBlTCRkPQdHScr6bPwbZRxUsOFTC
jb3GiyvHz9MW9WhwRtHPMdQtGcB2iBaD9r133EmqnxwKUc9EqoF7AuOjKIN6Q5YH
YsIwAdJoCokfBVMaftQkezgmC0rQIk9tWkQR1tdKLFpc/kVaOAIudbpxuKAGE4cT
aHNnQsQUmqEfXwagDcbjJZq3Pn7gvsi0v8W+XiAvf4QFMH8C9n9MTKjG8RPYurwe
GhO6S0T2NN69wwM5Zh/A5nPP+CT2wjIPAzTvqVZfw5Flk/3oj/E14V3XUAAQOJwv
wRDHl68vO3MDTpbN4CoofxsFm+PP08bQ+QvgrKFv3rnSnOayx04=
=XAk8
-----END PGP SIGNATURE-----

--agrtclly7u5j74x6--

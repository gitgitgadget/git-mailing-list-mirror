Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0D0D202C9
	for <e@80x24.org>; Tue, 28 Feb 2017 23:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751542AbdB1XYo (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 18:24:44 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:41766 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751748AbdB1XYR (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Feb 2017 18:24:17 -0500
Received: from genre.crustytoothpaste.net (wsip-98-185-58-71.no.no.cox.net [98.185.58.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id B26E5280AD;
        Tue, 28 Feb 2017 20:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1488313163;
        bh=Zo2vXXVwYtEwvVPmhh118Ocryp0F+jhnuAINeiec3XE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ULC/mgiirwiX8bMY8695gDr3u/Ejuu1lPua/T+endZ2GKZZrIqU3ZDvD1ElDBMtQO
         flss/f64wBYS4HEv+AATGjNbNs2H98Us4zQ0nG9NDLX9cJDXHyaTW9SFiv7AS+mN1O
         6xD6NU9RHJXiVPNtfAVu42y+t1l42H2JZ2LtaD8ndNDUFSw3yjiby2B868ZBjcCGWG
         bPh9RMBB3Eb6/3XMV5aU9lpuiIS785u1v44RAzAXjDw0QiMuboGIqHBvkxf++gx/Jp
         /fvzO8wIoayoegMAmvoTvfkReSmrD8EXECgCO/MV+TLR9OUPMgWVFNgEVuL+2bP8jO
         MkuOZDOBca4Zcd/BKFvzZOsNTpqiNM6covgB6ZARwL3ch1zEmqHD99Yfk94+DylC5i
         fSS5qTVNfrID6XaI7ywDAcu45G/cxpyoagZ8AeBNzmpfrG/+nne7FzpvRGS1TJR/FM
         +GJBvOSn/yqnV43ZgHPbA0j6ePpiPTVVuwEshoaEhYo75CqR+Qb
Date:   Tue, 28 Feb 2017 20:19:19 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Typesafer git hash patch
Message-ID: <20170228201918.dpqrrijibdapemaf@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
References: <CA+55aFxYs1zp2c-UPe8EfshNNOxRVxZ2H+ipsnG489NBsE+DLQ@mail.gmail.com>
 <xmqqvarujdmv.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cx33r5tlzlahx52v"
Content-Disposition: inline
In-Reply-To: <xmqqvarujdmv.fsf@gitster.mtv.corp.google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-2-amd64)
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--cx33r5tlzlahx52v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 28, 2017 at 11:53:28AM -0800, Junio C Hamano wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
>=20
> > That
> > actually can clean up some code, because right now we have duplicate
> > interfaces for some things that take an oid pointer and others take a
> > "const unsigned char *sha1", and that duplication essentially can go
> > away.
>=20
> ... I understand that this is an eventual goal of "struct object_id"
> effort.

Yes, it is.

> > ..., and the lines are generally shorter, eg
> >
> > -               const unsigned char *mb =3D result->item->object.oid.ha=
sh;
> > -               if (!hashcmp(mb, current_bad_oid->hash)) {
> >
> > turns into
> >
> > +               const hash_t *mb =3D &result->item->object.oid;
> > +               if (!hashcmp(mb, current_bad_oid)) {
>=20
> Hmph.  I somehow thought the longer term directio for the above code
> would be to turn it into
>=20
> 		if (!oidcmp(&result->item->object.oid, &current_bad_oid))
>=20
> instead.

It is.  The duplication is temporary.  We've actually removed some of
the original SHA-1 functions in favor of the object_id versions.

> Having said all that, I do not offhand see a huge benefit of the
> current layout that has one layer between the hash (i.e. oid.hash)
> and the object name (i.e. oid) over "there is no need for oid.hash;
> oid is just a hash", which you seem to be doing.
>=20
> Except for cases where we need to be prepared to see two or more
> kinds of object names (in which case struct object_id would have an
> enum that tells you if oid.hash is SHA-1 or SHA-3-256), that is.  Of
> course we can encode that in hash_t itself (e.g. multihash).

Right, this is indeed a benefit.

The bigger issue is the assumptions in the code base that assume a given
hash size.  These assumptions are in a bunch of places, so pretty much
any time you see a number, you end up having to question what it means.
We have a 64 that means 40 (SHA-1 hex) plus 24 other values, for
example.

I've sent various series because I think that's the way that the Git
development community has most welcomed my contributions.  I have
another 69 patches in two series (which are as of yet untested).  I can
probably have almost all of the transition actually complete in another
couple weeks (because I have a day job which does not involve working on
Git).

I've hesitated to send additional patches to the list when my existing
changes haven't even hit next yet, since they're received little actual
testing.

I'm unsure if sending one enormous patch is actually going to be
welcome; I feel Junio and most of the regulars are probably not going to
be very excited about the idea, mostly because the reviewing task is
enormous, and the risk for breakage is also pretty high.  We want to
move away from SHA-1 as quickly as possible, yes, but we don't want Git
to become unusably buggy.

I guess what I'm saying is that I'm fine if we want to have a more
aggressive timeline, and I can probably make that happen, at least if we
can wait a few weeks.  If Junio and the other regulars are comfortable
merging one omnibus patch to get it moving even more quickly, I won't
stand in the way.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--cx33r5tlzlahx52v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.18 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAli120YACgkQv1NdgR9S
9ot1Xg//Z2cHUL5c852h/DIJZkh/BSX/mAbAcxRWIZPiU/m8dc9V/Bm5khIDmiIy
MiwSC60g4iWZIfDapqynyo+y5r65q0Hepjbb3EAV3YuLd/xsQWUHK9qNOLnuffJ4
G6stwryd6qAxeLrVAQ6VJ5gd2xF49Bq7ZxiHtrywQ4MtPOQs/59CavnIwyo6Gptk
Yn1tYcX8Ls9lWybLvYoDZn+zLlxn3wnfne/YGOuNL9BGY/gvj0RDLjR2D/ZO6jBZ
LwH+Tdl0qONBUSMyaHCdLTkKj36twsB4qWnkiuMh5kkCMceB0G6hBcLKHsbI2jQK
jDOZQIuAC4UbD9hcjPAjdRWWb44O56VfoxNpfytzhsgUe/IDIklypLU+pNgQqaGW
YUI3G8ftwWiCMplXeax41ukAt3DouNVYsopw6NxkzBP6J7Go1mEEn0uJLjY1178V
VxAP5KR/pcQVZwqxBHHcLNLD8ZBflIuu4aG4pqZj2DJT//bqMYUE43v+/NXnxePR
989QirEVmGx3gnfH5qoHYEH+ozJJ94Aqm6u3vid4Eg9MJiI9hhUkAHgcBjNT7qli
1xoPUNwmjhEM7W6lpnoz3CU+T0Xfd8ZtDcZ0wwSqKQAYX0ww+EEhm5k6/CiaRKuW
KZyMyNvt3NpR1WAPeaBdmwj/IKbq5Xfj345It2WpWNWwgEh0dKA=
=DcGG
-----END PGP SIGNATURE-----

--cx33r5tlzlahx52v--

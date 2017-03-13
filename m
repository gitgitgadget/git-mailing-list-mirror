Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B850E201C2
	for <e@80x24.org>; Mon, 13 Mar 2017 10:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751676AbdCMKhY (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 06:37:24 -0400
Received: from kolab.intevation.de ([212.95.107.133]:37560 "EHLO
        kolab.intevation.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751204AbdCMKhX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 06:37:23 -0400
X-Greylist: delayed 404 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Mar 2017 06:37:23 EDT
Received: from localhost (localhost [127.0.0.1])
        by kolab.intevation.de (Postfix) with ESMTP id 1DF2262675
        for <git@vger.kernel.org>; Mon, 13 Mar 2017 11:30:35 +0100 (CET)
X-Virus-Scanned: by amavisd-new at intevation.de
Received: from kolab.intevation.de ([127.0.0.1])
        by localhost (kolab.intevation.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mfjDfIfa3kHw for <git@vger.kernel.org>;
        Mon, 13 Mar 2017 11:30:34 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by kolab.intevation.de (Postfix) with ESMTP id 461B16270D
        for <git@vger.kernel.org>; Mon, 13 Mar 2017 11:30:32 +0100 (CET)
Received: from ploto.hq.intevation.de (ploto.hq.intevation.de [192.168.11.18])
        (Authenticated sender: bernhard.reiter@intevation.de)
        by kolab.intevation.de (Postfix) with ESMTPSA id 0A4116265A;
        Mon, 13 Mar 2017 11:30:32 +0100 (CET)
From:   Bernhard Reiter <bernhard@intevation.de>
To:     =?iso-8859-1?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
Subject: Re: Stable GnuPG interface, git should use GPGME
Date:   Mon, 13 Mar 2017 11:30:27 +0100
User-Agent: KMail/1.9.10 (enterprise35 20150610.75555ff)
Cc:     Git Mailing List <git@vger.kernel.org>, gnupg-devel@gnupg.org,
        Lukas Puehringer <luk.puehringer@gmail.com>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <201703101100.15214.bernhard.reiter@intevation.de> <CACBZZX4Av-D6hxE9ceDFPuG-_qUQbH_6KW5JKsJf0SuH62jkuQ@mail.gmail.com>
In-Reply-To: <CACBZZX4Av-D6hxE9ceDFPuG-_qUQbH_6KW5JKsJf0SuH62jkuQ@mail.gmail.com>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5067130.SVEuGKEmWq";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <201703131130.31623.bernhard@intevation.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--nextPart5067130.SVEuGKEmWq
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Freitag 10 M=C3=A4rz 2017 15:23:27 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason:
> On Fri, Mar 10, 2017 at 11:00 AM, Bernhard E. Reiter wrote
> > please consider using libgpgme interfacing to GnuPG, because the gpg
> > command-line interface is not considered an official API to GnuPG by the
> > GnuPG-devs and thus potentially unstable.

> > =3D=3D Usability problem with `gpg2` vs `gpg`
> >
> > My use case today was signing and git by default found the `gpg` binary
> > by default and the command failed.

I've mentioned this as one example for a possible advantage using libgpgme
when interfacing with GnuPG.

> > The reason is that I have `gpg2`=20
> > installed and most applications use it right away. So git failed signing
> > because the .gnupg configuration of the user was not ready for the old
> > `gpg` which is still installed on Debian GNU/Linux for purposes of the
> > operating system. If git would have used libgpgme, gpgme would have
> > choosen the most uptodate version of `gpg` available (or configured)
> > without me intervening via gpg.program. Now because of this problem you
> > could adding a check for `gpg2` and fallback to `gpg`, but even better
> > would be to move to libgpgme. >:)
>
> I'm on Debian but haven't had these issues. What's your gpg & gpg2
> --version & Debian release? And what in particular failed?

If you use options in your configuration that only gpg2 understands, gpg(1)
will barf. For example the following lines in ~/.gnupg/gpg.conf

  debug-level basic
  log-file socket:///home/bern/.gnupg/log-socket

will lead to
LANG=3DC gpg -K
  gpg: /powerhome/bern/.gnupg/gpg.conf:102: argument not expected
  gpg: /powerhome/bern/.gnupg/gpg.conf:103: invalid option
where gpg2 works as expected.

As a number of application already uses gpg2 (via libgpgme or not), this ma=
y=20
go unnoticed for a while. So when I've started to sign with git on this=20
machine I ran into the problem (current Jessie default versions):

  dpkg -s gnupg | grep ^Version
  #Version: 1.4.18-7+deb8u3
  dpkg -s gnupg2 | grep ^Version
  #Version: 2.0.26-6+deb8u1

Workarounds are:
 * Use a different config for gpg2 and gpg, e.g. ~/.gnupg/gpg.conf-2
   (https://www.gnupg.org/documentation/manuals/gnupg-2.0/Invoking-GPG.html=
 )
 * or set gpg.program for git to gpg2.

> And what git version was this? I see we've had a couple of workarounds
> for gpg2, in particular Linus's v2.8.4-1-gb624a3e67f, but if you have
> v2.10.0 or later that won't fix whatever issue you had.

dpkg -s git | grep ^Version
Version: 1:2.1.4-2.1+deb8u2
(I've checked the most current master source to see that git still calls=20
gpg.program, otherwise followed advise on https://git-scm.com/community
to send reports and questions to the list.)

> Using the library sounds good, but a shorter-term immediate fix would
> be to figure out what bug you encountered in our use of the
> command-line version, and see if we've fixed that already or not.
> Regardless of what we do with a gpg library in the future some distros
> might want to backport such a small patch if we can come up with it.

I guess a good simple approach would be to try "gpg2" first and then fall b=
ack=20
to "gpg" or "gpgv" in case only these version are available.
(Here is a report that puts forward using gpgv in some situations=20
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D852684 )

As there are other subtle potential issues with directly calling a gpg bina=
ry,
using libgpgme by default probably has other advantages as well. And if the=
re=20
are important functions missing the GnuPG-devs would like to hear about the=
m.

Regards,
Bernhard

=2D-=20
www.intevation.de/~bernhard =C2=A0 +49 541 33 508 3-3
Intevation GmbH, Osnabr=C3=BCck, DE; Amtsgericht Osnabr=C3=BCck, HRB 18998
Gesch=C3=A4ftsf=C3=BChrer Frank Koormann, Bernhard Reiter, Dr. Jan-Oliver W=
agner

--nextPart5067130.SVEuGKEmWq
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJYxnTDAAoJEDxD9Mjv9dQq0V8H/0J1uy95sFRZBJQMUA8Ye3rq
+5dvzTyNKH+bqEZOk1Pgk7ePr+fmUIcVUamTFATWvWxWXAbJ5M4GjpwZkpjJtPOW
Og9zXJZdnQctlLViVij/aJ4G39p5W+fzHJEFZ37gQIjBkZgz2pxyZ8UOiauX8Ljv
3fdyhkPLPkZVBgD2DMDCAyQtcVzX8iyBKBET7KiDwJIiK8iytKWuA966Wxkar4qa
DqofgclheEb8Z3O0gwH6dTTytq+uOZ6vDZnt+c0KRdDb9dakh5QYVhp9vwfhJ8rG
6+5W9svwL843gh2AILtFhO+5YS9CsHqXfQP8qebsVAO67mKbTtZXaPlORzsPyK8=
=pKaY
-----END PGP SIGNATURE-----

--nextPart5067130.SVEuGKEmWq--

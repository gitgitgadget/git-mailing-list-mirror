Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E57B2095B
	for <e@80x24.org>; Fri, 17 Mar 2017 09:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751309AbdCQJ6A (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 05:58:00 -0400
Received: from kolab.intevation.de ([212.95.107.133]:33234 "EHLO
        kolab.intevation.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751096AbdCQJ4u (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 05:56:50 -0400
Received: from localhost (localhost [127.0.0.1])
        by kolab.intevation.de (Postfix) with ESMTP id C8B736268B
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 10:56:16 +0100 (CET)
X-Virus-Scanned: by amavisd-new at intevation.de
Received: from kolab.intevation.de ([127.0.0.1])
        by localhost (kolab.intevation.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RFt7nCz19eEH for <git@vger.kernel.org>;
        Fri, 17 Mar 2017 10:56:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by kolab.intevation.de (Postfix) with ESMTP id 134A162738
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 10:56:11 +0100 (CET)
Received: from ploto.hq.intevation.de (ploto.hq.intevation.de [192.168.11.18])
        (Authenticated sender: bernhard.reiter@intevation.de)
        by kolab.intevation.de (Postfix) with ESMTPSA id D0338624DD;
        Fri, 17 Mar 2017 10:56:10 +0100 (CET)
From:   "Bernhard E. Reiter" <bernhard.reiter@intevation.de>
To:     Michael J Gruber <git@drmicha.warpmail.net>,
        Werner Koch <wk@g10code.com>
Subject: Re: Stable GnuPG interface, git should use GPGME
Date:   Fri, 17 Mar 2017 10:56:02 +0100
User-Agent: KMail/1.9.10 (enterprise35 20150610.75555ff)
Cc:     =?iso-8859-1?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        gnupg-devel@gnupg.org, Lukas Puehringer <luk.puehringer@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <201703101100.15214.bernhard.reiter@intevation.de> <201703131350.00139.bernhard.reiter@intevation.de> <13c66211-9671-5bd3-f3eb-96ffd5c39975@drmicha.warpmail.net>
In-Reply-To: <13c66211-9671-5bd3-f3eb-96ffd5c39975@drmicha.warpmail.net>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
X-UID:  38
Content-Type: multipart/signed;
  boundary="nextPart2201765.UeHDTmt69z";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <201703171056.10468.bernhard.reiter@intevation.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--nextPart2201765.UeHDTmt69z
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Dienstag 14 M=C3=A4rz 2017 11:39:12 schrieb Michael J Gruber:
> >> The problem is the "difficult" upgrade path and mixed installations wi=
th
> >> gpg and gpg2.1+ that some distributions force upon you:
> >>
> >> As soon as you start gpg2.1, your (secret) key store is migrated to a
> >> new format without technically invalidating it. Similarly, users may
> >> enter gpg2.1+-only comand in the config that is actually shared with
> >> gpg, throwing off any use of gpg - not just by git, but also by anythi=
ng
> >> that your distro requires gpg for (such as packaging tools and the
> >> like).
> >
> > Yes, this is another example why trying `gpg2? first by default or using
> > libgpgme keeps trouble away from users.
>
> No, not at all. On the contrary: Using gpg2.1 without being asked to by
> the user will migrate his key store! This can lead to tremendous
> problems when a user manages his secret key store using gpg and git uses
> the other secret key store (via gpg2.1)!

In the following scenario I agree with you:
* The user only uses gpg (1) and only applications that use gpg (1)
   and does not have gpg2 installed.
* Now a GnuPG package for 2.1/2.2 is installed and only the "gpg2"
  binary now points to it.
* If then git will just switches using `gpg2` which is v2.1 because it=20
  came available, it will force the migration to the new store.

My statement was assuming a scenario where
* the user has gpg v1 and gpg2 v2.0 installed and many (or all) application=
s=20
  use gpg2 via gpgme or by other means. I consider this typical for desktops
  or application servers using for desktop or development work.
* Now git also uses gpg2 (via gpgme or by other means, a possible improveme=
nt=20
   we are just talking about)
* If GnuPG 2.1/2.2 becomes available and of the already used application wi=
ll
  trigger the keystore migration. git users will have a smooth experience
  because they were using gpg2 all along and then to use the new keystore.

(It is still possible for some to configure libgpgme to use `gpg` v1 and al=
l=20
applications using gpgme will use it and you do not have to configure each=
=20
one separately. Because you should either use gpg v2.1 or gpg v1=20
exclusively, it makes sense to configure it close to gpg in its official ap=
i=20
and not within each application. Again you can deviate from this.)

> >> As for the library: While - technically speaking - the command line is
> >> not a stable API for gpg, it does work across versions of gpg, and gpg
> >
> > ... to some extend.
>
> I have no idea what you're implying here - but I have a pretty good idea
> of what works in current git and what not, including gpg usage (which is
> the qualifier that you cut out).

As the command line is not a stable API to GnuPG, there were changes and th=
ere=20
will be changes to the command line over several versions. It maybe in the=
=20
past that git's usage of the command line was stable and works well, becaus=
e=20
of the subset of functionality of GnuPG that git is using and good work don=
e=20
by you and other developers of the git GnuPG support. It may or may not be =
a=20
good choice for the future. As I've written before I'm not familiar enough=
=20
with git to make a final call here, but there are some signs and examples=20
where using gpgme may be an improvements in the areas:

* better configuration which gpg and which options to use for all applicati=
ons
* consistent behaviour from git with other applications
* more robust programming interface over several gpg versions
* (better performance when reusing the same gpgme "context" for many=20
consecutive crypto operations)

> Unfortunately, gpgme does not solve the interoperability problems
> between gpg (1, classic, stable maint mode) or gpg2.0 (stable) and
> gpg2.1 (modern) key stores, and gpg2.2 (modern, stable) is not released
> yet.

That is right, I also believe gpgme does not solve all interoperability=20
problems. I guess it solves some, but I would do more research to come up=20
with some specific examples.

> >> Note that we (git) refrain from parsing ordinary output/return codes of
> >> gpg and use status-fd as we should (and as documented).
> >
> > It is good to use --status-fd and --with-colons when calling gpg, you
> > still have to parse the results of status-fd as described in doc/DETAIL=
s.
> > https://git.gnupg.org/cgi-bin/gitweb.cgi?p=3Dgnupg.git;a=3Dblob;f=3Ddoc=
/DETAILS
> >;hb=3DHEAD
>
> Again, have you checked what we are doing in git land?

As mentioned before: Only on the surface. I'm not deeply familiar with all =
git=20
use case of GnuPG.=20

> Your agenda is pretty clear.

Yes, I'd like to improve the user experience of git users regarding crypto
operations done with GnuPG. There are some signs that indicate that using=20
gpgme may potentially improve this user experience (as outlined).

> It's also pretty clear from the above that=20
> gpgme is not the solution to the problem which is introduced by the
> migration path to versions of gpg which are not declared stable by the
> gpg project, away from a gpg version which is not obsoleted by the gpg
> project (2.0, maybe 1).

While I agree that gpgme does not solve all problems with this migration,
it solves some problems with it (see above and my other email)=20
and offers other advantages as the official API of GnuPG. Still it is the c=
all=20
of people more familiar with git usage and use cases to see if they have a=
=20
good reason to deviate from the common case and use a non-official way of=20
automating crypto operations with GnuPG.

> And, really, key store migration was the only "major" thing we had to
> think about to cope with gpg 2.1+ - it affected the test suite setup.
>
> So, once 2.2 is out and stable and mainstream and we don't risk
> migrating users' secret key store sneakily I'm all for defaulting to
> gpg2, and then is a good time for us to look into gpgme.

The key store migration is mainly an orthogonal issue and the problems will=
=20
happen with or without using gpgme. As GnuPG 2.2 is under way, it makes sen=
se=20
to look into an improved support now, to be ready if GnuPG 2.2 becomes more=
=20
widely used. It probably will get a lot more usage this year because of the=
=20
ECC support (and some other reasons).

Thanks all for your thoughts, using GnuPG, considering gpgme=20
and in general for maintaining git as Free Software! :)

Best Regards,
Bernhard

=2D-=20
www.intevation.de/~bernhard (CEO)     +49 541 33 508 3-3
Intevation GmbH, Osnabr=C3=BCck, Germany; Amtsgericht Osnabr=C3=BCck, HRB 1=
8998
Owned and run by Frank Koormann, Bernhard Reiter, Dr. Jan-Oliver Wagner

--nextPart2201765.UeHDTmt69z
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJYy7KyAAoJEDxD9Mjv9dQqbrIIAJiUkcOgEuABNmI0KC3uv5MA
pQ+geCmWXz1bDeUYiT0wgDcU8yqlJOEenfdcH0Reh+3BIXFqgeYn+06MEZL6tdah
W8amMPcunJMo2dpdWpu2y43iuYk/nsDBPcG/nav016JCaUxDpqwUbAaQ7CZqVdlB
ckwGjYMRBYlzTEU1Eg1BZNuoaHQb/jU5csApHAXLg0g9yBt7eej6ZmmVcVDK8MGe
oI5dUqpNv9GHX+W6+KQmz3qrXhdV6ycvyWoU+j3qble95I71ULNbHYkOoABoOi7C
zAV590OzWqKByaE+/G/HuNNb9boUHRtwrS+bXyU/6GW9RdK7XX/QJgPiCmn2EIM=
=0cZc
-----END PGP SIGNATURE-----

--nextPart2201765.UeHDTmt69z--

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8412B20323
	for <e@80x24.org>; Wed, 22 Mar 2017 17:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935743AbdCVR4J (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 13:56:09 -0400
Received: from kerckhoffs.g10code.com ([217.69.77.222]:45406 "EHLO
        kerckhoffs.g10code.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935714AbdCVR4I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 13:56:08 -0400
X-Greylist: delayed 1978 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Mar 2017 13:56:08 EDT
Received: from uucp by kerckhoffs.g10code.com with local-rmail (Exim 4.84_2 #1 (Debian))
        id 1cqjyW-0001oT-Mm
        for <git@vger.kernel.org>; Wed, 22 Mar 2017 18:23:08 +0100
Received: from wk by wheatstone.g10code.de with local (Exim 4.84 #3 (Debian))
        id 1cqjrF-0005Rs-7B; Wed, 22 Mar 2017 18:15:37 +0100
From:   Werner Koch <wk@gnupg.org>
To:     "Bernhard E. Reiter" <bernhard.reiter@intevation.de>
Cc:     Michael J Gruber <git@drmicha.warpmail.net>,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Git Mailing List <git@vger.kernel.org>,
        gnupg-devel@gnupg.org, Lukas Puehringer <luk.puehringer@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Stable GnuPG interface, git should use GPGME
References: <201703101100.15214.bernhard.reiter@intevation.de>
        <201703131350.00139.bernhard.reiter@intevation.de>
        <13c66211-9671-5bd3-f3eb-96ffd5c39975@drmicha.warpmail.net>
        <201703171056.10468.bernhard.reiter@intevation.de>
Organisation: The GnuPG Project
X-message-flag: Mails containing HTML will not be read!
         Please send only plain text.
OpenPGP: url=https://k.gnupg.net/80615870F5BAD690333686D0F2AD85AC1E42B367
Mail-Followup-To: "Bernhard E. Reiter" <bernhard.reiter@intevation.de>,
        Michael J Gruber <git@drmicha.warpmail.net>, =?utf-8?B?w4Z2YXIgQXJuZmo=?=
 =?utf-8?B?w7Zyw7A=?= Bjarmason
        <avarab@gmail.com>, Git Mailing List <git@vger.kernel.org>,
        gnupg-devel@gnupg.org, Lukas Puehringer <luk.puehringer@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 22 Mar 2017 18:15:36 +0100
In-Reply-To: <201703171056.10468.bernhard.reiter@intevation.de> (Bernhard
        E. Reiter's message of "Fri, 17 Mar 2017 10:56:02 +0100")
Message-ID: <87poh9p70n.fsf@wheatstone.g10code.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=Guantanamo_doctrine_Mole_kilo_class_ASPIC_security_emc_Peking_Consul";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--=Guantanamo_doctrine_Mole_kilo_class_ASPIC_security_emc_Peking_Consul
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 17 Mar 2017 10:56, bernhard.reiter@intevation.de said:

> As the command line is not a stable API to GnuPG, there were changes and =
there=20
> will be changes to the command line over several versions. It maybe in th=
e=20

That is not true.  The command line interface has been stable for the
last 19 years.  We only removed a left over PGP-2 backward compatibility
in 2.1 (-kvv).  I doubt that this has even been noticed.

>> Unfortunately, gpgme does not solve the interoperability problems
>> between gpg (1, classic, stable maint mode) or gpg2.0 (stable) and
>> gpg2.1 (modern) key stores, and gpg2.2 (modern, stable) is not released
>> yet.

It actually does.  For the tasks git uses gpg you should not notice a
difference in gpgme between any of these versions.  BTW, 2.1 was
realeased more than 2 years ago and 2.0 will reach EOL in 9 months.

> That is right, I also believe gpgme does not solve all interoperability=20
> problems. I guess it solves some, but I would do more research to come up=
=20

The main arguments pro GPGME are

 - There is generic stable API and ABI which did not changes since 0.4.1
   (2003-06-06) when we decided to redesign the API.

 - Iff verification of signatures needs a speedup we can do this inside
   GPGME and GnuPG without the GPGME user noticing that.  Technically we
   will then run gpg as co-process controlled by GPGME; for gpgsm
   (S/MIME) this is already done but there has not yet been a need to do
   this also for gpg.  Git could be the trigger to implement that.

 - The GPGME API would allow to provide a rich and stable output with
   the pretty print format.  AFAICS the current %G* format characters
   are a bit limited and require that scripts need to look at the key
   for further information.

> The key store migration is mainly an orthogonal issue and the problems wi=
ll=20
> happen with or without using gpgme. As GnuPG 2.2 is under way, it makes s=
ense=20

Please note that 2.2 is more of a marketing term than a change.  2.1 is
already in use and will be the standard gpg version in several distros,
including Debian.

Interoperability with 1.4 is a bit cumbersome if you often add new keys.
However, "gpg --export | gpg1 --import" is not too complicated.=20

Be aware that ECC keys will be used more and more and they are not
supported by gpg1.  Further we are currently defining a v5 key format to
be prepared for weaknesses in the SHA-1 based fingerprint.  It is very
unlikely that a v6 key format will be added to gpg1.


Salam-Shalom,

   Werner

=2D-=20
Die Gedanken sind frei.  Ausnahmen regelt ein Bundesgesetz.

--=Guantanamo_doctrine_Mole_kilo_class_ASPIC_security_emc_Peking_Consul
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQTX/8BjtAoilLlm20f/gK6dHew1jQUCWNKxOAAKCRD/gK6dHew1
jcLIAQDqVe87wKo4pGGNHOjUPCNyfTyyndhDTKxhBHQ3vKAO1gD+NJbtElJOH+up
wABGiZ8uNBGt8LdXPONDMUWD9PMY9gY=
=4mDR
-----END PGP SIGNATURE-----
--=Guantanamo_doctrine_Mole_kilo_class_ASPIC_security_emc_Peking_Consul--


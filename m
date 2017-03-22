Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B55AD20958
	for <e@80x24.org>; Wed, 22 Mar 2017 08:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933577AbdCVIbF (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 04:31:05 -0400
Received: from smtpo.poczta.interia.pl ([217.74.65.206]:39366 "EHLO
        smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758232AbdCVIbC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 04:31:02 -0400
Date:   Wed, 22 Mar 2017 09:30:52 +0100
From:   Zenobiusz Kunegunda <zenobiusz.kunegunda@interia.pl>
Subject: Re: fatal: Could not get current working directory: Permission
 denied | affected 2.10,2.11,2.12, but not 1.9.5 |
To:     =?iso-8859-1?b?UmVu6Q==?= Scharfe <l.s.r@web.de>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
X-Mailer: interia.pl/pf09
In-Reply-To: <3e8b756c-81bd-0a29-e032-d5733a8b3ed0@web.de>
References: <elvahoiwfqayelbskykd@qjih>
        <7d947891-ce40-23e7-2bc7-0f76dee53665@web.de> <hpulcgxossrwvfbbcvcl@zndn>
        <10cc42b8-0f63-2d97-8da1-2943970d63cc@web.de> <ogwsaxvtiqlsiwojzxul@owpk>
        <3ba0c8e3-894a-846f-ba99-dad1deba7cdf@web.de> <tskgutqgpyszzedvyfra@prol>
        <f2ab799f-5f0a-0ce0-0625-13513bc1973d@web.de> <ffntuqzgjgcfhebokbty@eduj>
        <7f25def4-9943-ae59-a649-b4348a79890e@web.de>
        <f6588ace-eecc-118d-ef26-70bc21dcc4d4@web.de>
        <CAGZ79kbpPBN21mbN2F20ikr6dXrKEcY=msqymaG8TOujeQF0jw@mail.gmail.com>
        <250f6b35-03c3-1fa8-8b6b-dfdc42660d8c@web.de> <bcrjmkhdzucyoncxqruj@gkuh>
        <3e8b756c-81bd-0a29-e032-d5733a8b3ed0@web.de>
X-Originating-IP: 89.64.255.37
Message-Id: <nmvyuyfhjvyycfsdyczr@tyca>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=interia.pl;
        s=biztos; t=1490171453;
        bh=VlFx1kKTU0u899ldjjQ+1lSeaIh/UEjcQqyVJ8+p+vE=;
        h=Date:From:Subject:To:Cc:X-Mailer:In-Reply-To:References:
         X-Originating-IP:Message-Id:MIME-Version:Content-Type:
         Content-Transfer-Encoding;
        b=m/GFuIXNcV8LzFj1V13xVCxSfwbIKcZXknnGdzTUFdjCJXlYVpBYFGLFzsd4Y+mXC
         4OQXhFuAsUOUVmKckAutP1ADJi/UU9NrcPR0iad+UI71gdPTyLG9DqbJRUN7bHvQYs
         Y1aFsWM6ur5Jft5MK0eczjsmbJbY/w9RkguJQxRg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After applying mentioned patch to git v2.12.0 I was not able to reproduce b=
ug.Od: "Ren=C3=A9 Scharfe" &lt;l.s.r@web.de>
Do: "Zenobiusz Kunegunda" &lt;zenobiusz.kunegunda@interia.pl>;=20
Wys=C5=82ane: 20:06 Wtorek 2017-03-21
Temat: Re: fatal: Could not get current working directory: Permission denie=
d | affected 2.10,2.11,2.12, but not 1.9.5 |

>=20
>> Am 21.03.2017 um 14:29 schrieb Zenobiusz Kunegunda:
>> I think I found a way to reproduce this error.
>> I installed FreeBSD 10.3 under qemu with zfs partitioning.
>> Test program did not report any access errors.
>> Then I did chmod 711 /usr/home
>> Now program started reporting permission denied errors just like this:
>>    $ ./a.out
>>    len =3D 0, errno =3D 22, Invalid argument
>>    len =3D 1, errno =3D 34, Result too large
>>    len =3D 2, errno =3D 13, Permission denied
>>    len =3D 20, errno =3D 0, No error: 0
>=20
> Yes, and I think we can take ZFS out of the equation.  As a regular user=20
> I get this with UFS and for $mode values of 000, 100 or 400 (with umask=20
> 0022):
>=20
> 	$ mkdir -p /tmp/a/b &amp;&amp; cd /tmp/a/b
>=20
> 	$ chmod $mode /tmp/a &amp;&amp; getcwdtest
> 	len =3D 0, errno =3D 22, Invalid argument
> 	len =3D 1, errno =3D 34, Result too large
> 	len =3D 2, errno =3D 13, Permission denied
> 	len =3D 9, errno =3D 0, No error: 0
>=20
> Only with both read and execute/search permissions for the intermediate=20
> directory I get rid of that irritating permission error for small buffers=
:
>=20
> 	$ chmod 500 /tmp/a &amp;&amp; getcwdtest
> 	len =3D 0, errno =3D 22, Invalid argument
> 	len =3D 1, errno =3D 34, Result too large
> 	len =3D 9, errno =3D 0, No error: 0
>=20
> So a workaround for you would be to run "chmod a+rx" (or similar)=20
> against all parent directories of your repository.  Another one would be=20
> to keep the path length below 128 characters (that's the initial buffer=20
> size in strbuf_getcwd()).
>=20
> Have you been able to test the patch I sent on Friday by any chance?
>=20
> Thanks,
> Ren=C3=A9
>=20
>=20
=

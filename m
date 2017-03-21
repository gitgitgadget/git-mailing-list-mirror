Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CBA92095B
	for <e@80x24.org>; Tue, 21 Mar 2017 13:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757233AbdCUNbu (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 09:31:50 -0400
Received: from smtpo.poczta.interia.pl ([217.74.65.206]:41798 "EHLO
        smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756517AbdCUNar (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 09:30:47 -0400
Date:   Tue, 21 Mar 2017 14:29:46 +0100
From:   Zenobiusz Kunegunda <zenobiusz.kunegunda@interia.pl>
Subject: Re: fatal: Could not get current working directory: Permission
 denied | affected 2.10,2.11,2.12, but not 1.9.5 |
To:     =?iso-8859-1?b?UmVu6Q==?= Scharfe <l.s.r@web.de>,
        Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
X-Mailer: interia.pl/pf09
In-Reply-To: <250f6b35-03c3-1fa8-8b6b-dfdc42660d8c@web.de>
References: <elvahoiwfqayelbskykd@qjih>
        <7d947891-ce40-23e7-2bc7-0f76dee53665@web.de> <hpulcgxossrwvfbbcvcl@zndn>
        <10cc42b8-0f63-2d97-8da1-2943970d63cc@web.de> <ogwsaxvtiqlsiwojzxul@owpk>
        <3ba0c8e3-894a-846f-ba99-dad1deba7cdf@web.de> <tskgutqgpyszzedvyfra@prol>
        <f2ab799f-5f0a-0ce0-0625-13513bc1973d@web.de> <ffntuqzgjgcfhebokbty@eduj>
        <7f25def4-9943-ae59-a649-b4348a79890e@web.de>
        <f6588ace-eecc-118d-ef26-70bc21dcc4d4@web.de>
        <CAGZ79kbpPBN21mbN2F20ikr6dXrKEcY=msqymaG8TOujeQF0jw@mail.gmail.com>
        <250f6b35-03c3-1fa8-8b6b-dfdc42660d8c@web.de>
X-Originating-IP: 89.64.255.37
Message-Id: <bcrjmkhdzucyoncxqruj@gkuh>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=interia.pl;
        s=biztos; t=1490102986;
        bh=PGHGzOCap2+WcY1uo6xu2kfq+6dbQ0iddMWC8oqY2dE=;
        h=Date:From:Subject:To:Cc:X-Mailer:In-Reply-To:References:
         X-Originating-IP:Message-Id:MIME-Version:Content-Type:
         Content-Transfer-Encoding;
        b=QTEwWbEEfzvPstmE95v/fbiR3HG0/hOuKDZZqNssJAoy7FBwGNuc8/VKKLkD2BKGB
         rZdZRD/ijNP20TjW4YFPQTCSeEv+jUXKVzgytjpWEIrsXVdKODQ0yljQUtliIb8Zfs
         4QLzdPfNfb4dWv0wb8Hd/XBaHQRmMIMrJ/jWVxHU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Od: "Ren=C3=A9 Scharfe" &lt;l.s.r@web.de>
Do: "Stefan Beller" &lt;sbeller@google.com>;=20
Wys=C5=82ane: 22:08 Pi=C4=85tek 2017-03-17
Temat: Re: fatal: Could not get current working directory: Permission denie=
d | affected 2.10,2.11,2.12, but not 1.9.5 |

>=20
>> Am 17.03.2017 um 20:45 schrieb Stefan Beller:
>> On Fri, Mar 17, 2017 at 12:34 PM, Ren=C3=A9 Scharfe  wrote:
>>> Am 15.03.2017 um 22:30 schrieb Ren=C3=A9 Scharfe:
>>>> Am 15.03.2017 um 10:44 schrieb Zenobiusz Kunegunda:
>>>>> $ git bisect bad
>>>>> 7333ed1788b4f2b162a35003044d77a716732a1f is the first bad commit
>>>>> commit 7333ed1788b4f2b162a35003044d77a716732a1f
>>>>> Author: Ren=C3=A9 Scharfe=20
>>>>> Date:   Mon Jul 28 20:26:40 2014 +0200
>>>>>
>>>>>     setup: convert setup_git_directory_gently_1 et al. to strbuf
>>>>
>>>> That's what I half-suspected, and I think by now I got an idea.  Here'=
s
>>>> a test program:
>>>
>>> And here's a patch for letting strbuf_getcwd() use the same getcwd(3)
>>> extension that pwd(1) uses.  It avoids the need to guess the path's
>>> length and thus reduces the chance of stumbling over strange error
>>> codes.  I wonder if it helps in your case.
>>>
>>> Ren=C3=A9
>>>
>>> ---
>>>  strbuf.c | 8 ++++++++
>>>  1 file changed, 8 insertions(+)
>>>
>>> diff --git a/strbuf.c b/strbuf.c
>>> index ace58e7367..4c02801edd 100644
>>> --- a/strbuf.c
>>> +++ b/strbuf.c
>>> @@ -442,6 +442,14 @@ int strbuf_getcwd(struct strbuf *sb)
>>>  {
>>>         size_t oldalloc =3D sb->alloc;
>>>         size_t guessed_len =3D 128;
>>> +       char *cwd;
>>> +
>>> +       cwd =3D getcwd(NULL, 0);
>>
>> from my local man pages:
>>
>>   As  an extension to the POSIX.1-2001 standard, Linux (libc4, libc5,
>> glibc) getcwd()
>>   allocates the buffer dynamically using malloc(3) if buf is NULL.  In
>> this case, the
>>   allocated buffer has the length size unless size is zero, when buf
>> is allocated as big
>>   as necessary.  The caller should free(3) the returned buffer.
>>
>> This sounds specific to Linux (though I am reading Linux man pages,
>> which claim this; Also it seems I might have misread it as it also state=
s
>> "The pathname is returned as the function result and via the
>> argument buf, if present.").
>=20
> I'm only interested in FreeBSD for now, as that's the platform Zenobiusz=20
> reported the issue on and I haven't been able to reproduce it, so this=20
> is still a bit exploratory, but hopefully getting closer.  This=20
> extension is used in the first version of pwd(1) in FreeBSD's repo,=20
> comitted 1994-05-26, so it was supported there basically forever.
>=20
> The oldest version I found that's using the extention is NetBSD's=20
> pwd(1), which was committed 1993-03-21 and carries a SCCS timestamp of=20
> 1991-02-20.  Visual Studio .NET 2003 supports it as well.
>=20
>> Looking further:
>>
>>   These functions are often used to save the location of the current
>>   working directory for the purpose of returning to it later.  Opening t=
he
>>   current directory (".")  and  calling  fchdir(2)  to return is
>> usually a faster
>>   and more reliable alternative when sufficiently many file descriptors =
are
>>   available, especially on platforms other than Linux.
>>
>> Not sure if that opens another door here?
>=20
> Reducing the use of absolute paths may be a good idea in general, but=20
> that would probably require major changes.  And Windows doesn't seem to=20
> offer fchdir() at all; I don't know if it has an equivalent function=20
> that could be used to build a replacement.
>=20
> Ren=C3=A9
>=20
>=20

I think I found a way to reproduce this error.
I installed FreeBSD 10.3 under qemu with zfs partitioning.
Test program did not report any access errors.
Then I did chmod 711 /usr/home
Now program started reporting permission denied errors just like this:
   $ ./a.out =20
   len =3D 0, errno =3D 22, Invalid argument
   len =3D 1, errno =3D 34, Result too large
   len =3D 2, errno =3D 13, Permission denied
   len =3D 20, errno =3D 0, No error: 0
=

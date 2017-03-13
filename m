Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 863C91FC43
	for <e@80x24.org>; Mon, 13 Mar 2017 12:23:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751128AbdCMMXl (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 08:23:41 -0400
Received: from smtpo.poczta.interia.pl ([217.74.65.205]:43280 "EHLO
        smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750808AbdCMMXj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 08:23:39 -0400
Date:   Mon, 13 Mar 2017 13:23:28 +0100
From:   Zenobiusz Kunegunda <zenobiusz.kunegunda@interia.pl>
Subject: Re: fatal: Could not get current working directory: Permission
 denied | affected 2.10,2.11,2.12, but not 1.9.5 |
To:     =?iso-8859-1?b?UmVu6Q==?= Scharfe <l.s.r@web.de>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
X-Mailer: interia.pl/pf09
In-Reply-To: <10cc42b8-0f63-2d97-8da1-2943970d63cc@web.de>
References: <elvahoiwfqayelbskykd@qjih>
        <7d947891-ce40-23e7-2bc7-0f76dee53665@web.de> <hpulcgxossrwvfbbcvcl@zndn>
        <10cc42b8-0f63-2d97-8da1-2943970d63cc@web.de>
X-Originating-IP: 89.64.255.37
Message-Id: <bolnkqijewdhfhyoqodf@zfyt>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=interia.pl;
        s=biztos; t=1489407811;
        bh=P3J7m5HzBEpbhMY4GG+U4fCXHUUGrQ3hItzT4AR7SwU=;
        h=Date:From:Subject:To:Cc:X-Mailer:In-Reply-To:References:
         X-Originating-IP:Message-Id:MIME-Version:Content-Type:
         Content-Transfer-Encoding;
        b=h7em7YwTosUoUYUU8oFStNq55NjqrtH7OjudFDmrpafz1DpEty+uKuXF4uT/NVVWf
         DLuLPp3x+fUuxVM3Q723VcdLJ0At6+vd73Yi+1Pf+aJJ89oyD2LQOlCXlgChwW2mqW
         6AJg/QrY21vbZuLhcr3i6L35LGGCSQf6GL6K1124=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tested on ZFS filesystem



    [test0@s0]:<~>$ mkdir '232222222222222222222222222222222222222222222222=
222222222222222222222222222222222222222222222222222222222222222222222'
    [test0@s0]:<~>$ cd 2322222222222222222222222222222222222222222222222222=
22222222222222222222222222222222222222222222222222222222222222222/
    [test0@s0]:<~/232222222222222222222222222222222222222222222222222222222=
222222222222222222222222222222222222222222222222222222222222>$ git status
    fatal: Unable to read current working directory: Permission denied

    [test0@s0]:<~/232222222222222222222222222222222222222222222222222222222=
222222222222222222222222222222222222222222222222222222222222>$ git blahblah=
blah
    fatal: Unable to read current working directory: Permission denied


But when I create directory with same name (232...) as it's subdirectory ev=
erything works as expected inside that subdirectory.Od: "Ren=C3=A9 Scharfe"=
 &lt;l.s.r@web.de>
Do: "Zenobiusz Kunegunda" &lt;zenobiusz.kunegunda@interia.pl>;=20
Wys=C5=82ane: 22:18 Sobota 2017-03-11
Temat: Re: fatal: Could not get current working directory: Permission denie=
d | affected 2.10,2.11,2.12, but not 1.9.5 |

>=20
>> Am 09.03.2017 um 12:01 schrieb Zenobiusz Kunegunda:
>> OK, I printed euids inside function calling getcwd(). Every single
>> EUID is the same and have expected value. The same as any other local
>> application run by this user. Permissions of every directory in the
>> path are OK.
>>
>> /bin/pwd -P inside directory returned exact path and exited with exit
>> status 0.
>=20
> Weird.
>=20
> I tried to reproduce the behavior on FreeBSD 10.3, unsuccessfully.  I=20
> tried with Ruby 2.2 from the ports tree and Ruby 2.3 installed with=20
> rbenv, and with git 2.6.4 from the ports tree and a self-compiled=20
> version of the current master branch.
>=20
> You could try to bisect the issue to find which commit to git caused the=20
> behavior change, but that will be a tedious process (compile and install=20
> an intermediate version, run bundle install up to the point of interest=20
> then hit Ctrl-C, clean up somehow, run "git bisect good" or "git bisect=20
> bad" in the git source tree depending on the outcome of bundle, repeat=20
> ca. twelve times more).
>=20
> But I suspect the cause of the problem hides somewhere else.  Why would=20
> pwd(1) be able to call getcwd(3) just fine, while git gets an EPERM=20
> error for the same call?  I'm stumped.
>=20
> Ren=C3=A9
>=20
>=20
=

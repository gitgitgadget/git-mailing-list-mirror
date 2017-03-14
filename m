Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8ED9B201C2
	for <e@80x24.org>; Tue, 14 Mar 2017 15:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751765AbdCNP0Q (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 11:26:16 -0400
Received: from smtpo.poczta.interia.pl ([217.74.65.205]:35397 "EHLO
        smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753217AbdCNP0C (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 11:26:02 -0400
Date:   Tue, 14 Mar 2017 16:25:50 +0100
From:   Zenobiusz Kunegunda <zenobiusz.kunegunda@interia.pl>
Subject: Re: fatal: Could not get current working directory: Permission
 denied | affected 2.10,2.11,2.12, but not 1.9.5 |
To:     =?iso-8859-1?b?UmVu6Q==?= Scharfe <l.s.r@web.de>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
X-Mailer: interia.pl/pf09
In-Reply-To: <b9dc5b05-46e6-a3d7-2fb0-638bff2da676@web.de>
References: <elvahoiwfqayelbskykd@qjih>
        <7d947891-ce40-23e7-2bc7-0f76dee53665@web.de> <hpulcgxossrwvfbbcvcl@zndn>
        <10cc42b8-0f63-2d97-8da1-2943970d63cc@web.de> <bolnkqijewdhfhyoqodf@zfyt>
        <b9dc5b05-46e6-a3d7-2fb0-638bff2da676@web.de>
X-Originating-IP: 89.64.255.37
Message-Id: <jwwousyentaeeuvbaznm@xjvs>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=interia.pl;
        s=biztos; t=1489505150;
        bh=Z4frglTOzn2bTcU1xLcG7WS9jw5/Ws6I/apHVJAHENQ=;
        h=Date:From:Subject:To:Cc:X-Mailer:In-Reply-To:References:
         X-Originating-IP:Message-Id:MIME-Version:Content-Type:
         Content-Transfer-Encoding;
        b=j1JpgG9K+pNOZHpEtBDWdGxVrmh08+XlPfbTX1/lKV1fDw+3jRnNUoCDVWxf3Td9R
         /lNfZLDHl0I0YSQkwtrJiZRw+bx2MPf8u3sHu1IpYbFzm58i5+3UowXEeBi2bTwu8I
         9kZXtr87LTg+47nEWG/aHtuadSuzJQdZgn/RncP0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Output of=20

truss git status 2>&1 >/dev/null |grep chdir

is empty when git status fails.


Also git status succeeded when run as root.Od: "Ren=C3=A9 Scharfe" &lt;l.s.=
r@web.de>
Do: "Zenobiusz Kunegunda" &lt;zenobiusz.kunegunda@interia.pl>;=20
Wys=C5=82ane: 18:32 Poniedzia=C5=82ek 2017-03-13
Temat: Re: fatal: Could not get current working directory: Permission denie=
d | affected 2.10,2.11,2.12, but not 1.9.5 |

>=20
>> Am 13.03.2017 um 13:23 schrieb Zenobiusz Kunegunda:
>> Tested on ZFS filesystem
>>=20
>>=20
>>=20
>>     [test0@s0]:&lt;~>$ mkdir '232222222222222222222222222222222222222222=
222222222222222222222222222222222222222222222222222222222222222222222222222=
'
>>     [test0@s0]:&lt;~>$ cd 2322222222222222222222222222222222222222222222=
22222222222222222222222222222222222222222222222222222222222222222222222/
>>     [test0@s0]:&lt;~/232222222222222222222222222222222222222222222222222=
222222222222222222222222222222222222222222222222222222222222222222>$ git st=
atus
>>     fatal: Unable to read current working directory: Permission denied
>>=20
>>     [test0@s0]:&lt;~/232222222222222222222222222222222222222222222222222=
222222222222222222222222222222222222222222222222222222222222222222>$ git bl=
ahblahblah
>>     fatal: Unable to read current working directory: Permission denied
>>=20
>>=20
>> But when I create directory with same name (232...) as it's subdirectory=
 everything works as expected inside that subdirectory.
>=20
> Earlier I checked on UFS.  Now I tried the above commands on ZFS,
> but they work as expected:
>=20
>   $ git status
>   fatal: Not a git repository (or any parent up to mount point /src)
>   Stopping at filesystem boundary (GIT_DISCOVERY_ACROSS_FILESYSTEM not se=
t).
>=20
> Git checks out if it's in a git repository and if the current
> working directory isn't one then it goes to the parent directories
> recursively until it finds the root of a repo or a file system
> boundary or / (root).
>=20
> You can see where your invocation goes to with:
>=20
> 	$ strace git status 2>&amp;1 >/dev/null | grep chdir
>=20
> Ren=C3=A9
>=20
>=20
=

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B8DC76196
	for <git@archiver.kernel.org>; Fri, 31 Mar 2023 20:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbjCaUpY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Mar 2023 16:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbjCaUpJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2023 16:45:09 -0400
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4128E2220E
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 13:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1680295496; i=l.s.r@web.de;
        bh=KPJ0dn4L6Cle8BfI/xHMTHSSBykrB3+XmGc8tqj97Ws=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=ZsRtyQw/9br7SO1z1W4fnaXp67v5P3XDl2em9uwd6PKChXw13I7yBqhKp3FDNdna5
         U5UcLEOqyP9rMU3h3WeKVXHn54o2kuz3zTSvXedTb5wn8wHc6koOk6BJ/bfvy2hBRP
         RJDvIAxi7cppx0iL4MvG+LxtxmBDI5ZwJpXtkfp1M5DPL0Dchw/Xa4+x3aFzHMtayn
         VOGMdCEqLVXoIiUSLHXU4V/+OOBCBirCg3DWJKA1Ym+kbfeEFAMBwWX0r+DSula8In
         W/ZAf5chJQCT7ZBIxYsh87y+EUdU5ITObseknBYIzaWnhUQv55KOzdV3Fu5f76qU5e
         hQoraTY1ix0/w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.158.21]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N0Zs0-1qcWg009JM-00weYp; Fri, 31
 Mar 2023 22:44:56 +0200
Message-ID: <b8b3777b-ee6e-d90e-3365-5cb9c9d129fe@web.de>
Date:   Fri, 31 Mar 2023 22:44:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: regex compilation error with --color-words
To:     Diomidis Spinellis <dds@aueb.gr>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, demerphq <demerphq@gmail.com>,
        Mario Grgic <mario_grgic@hotmail.com>
References: <CAPig+cSNmws2b7f7aRA2C56kvQYG3w_g+KhYdqhtmf+XhtAMhQ@mail.gmail.com>
 <b45bf46f-580a-870c-5293-10ecdf2e56d3@aueb.gr>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <b45bf46f-580a-870c-5293-10ecdf2e56d3@aueb.gr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:e9X1CVn4hGaXZidzBW8tjC3ZpIZOItHVxkXZFwXQzzTh5GBV+l7
 tqI3vWZqLBVtw3K+CaN1F/aPE0P1wOohohPlGiqsBXgPIp5WaPwNVKxJZ8tvLiuvP3EobEM
 jktW+7hcVbdRtL9BLw6tIHpBZsarsbr5C4sUWAYPAuqDVYc0DsDvw7GPJmVfMHk7Dfp0AMi
 ikVRoPlqRupYdAVLOq5cA==
UI-OutboundReport: notjunk:1;M01:P0:3BX/n/gRgUQ=;FDlA9cez9nwWvHpeZDF+9zdIlV8
 +4gKNNccGmpR202nPh/k0wE3/2sQNJ8cMrI7feGutKMQEt4Nhm0mY5JPbzpD78pbnqbgLH2VW
 Nt4L3Duiw5plfM/BtHak3Pr/8MJW2liPulufg73ZWEoZBOLwYHa+o2xr9lsNYSFCX5raknPKO
 tbJsWZUWUYjCuCbd0byzpOYekDwFPSihPpj//k7pdQxLGZBIAfhP6j8wdgG5lE3lPuzpKBr7E
 6pNfN8nbAbk1H5huAYAU/lNG+4T7yAAA91Y9RK1VDG9v0/WQNsCibLoH/lcMur/UMjWG/1RkC
 LKAAwTk/PyfXdy0CmL7ood3yNjKvVpEqFabaAlhqnA9xuN4/QoGhhYsbqgQwwN9Yj83nArYul
 Cy87jxD1nEicyQi+UTtPzhLY0EPGS0z1L76XOF2a0qvbNpG+T85dyKsO9knJmeoLZUoczBHUy
 e0SD5eftfGK+kJ9cOF9wBrFS5buq5NSVjUnSEt0zlCQmbNXoTMCX0XcdH7dAxzW8zICVNNyC4
 akyK8MBJkHjVK9X7D0w5C0sJoLFcqF7uFrxwnvAwShzqi6vil/wDjE736/xUmUiQ+Tnrb0Llt
 LVlMn59ilUDs4GYP2QjzuSA/ZnxFgvwXQwLFPPa5jRiAbF19121XJPo+bVtLw8W7vEUrIDVI1
 GBS8SXz/QFQH73D4ob79TJ3hWOYMkIVBExiVPRqZU37prT46IxKID9aECLhxcY7lZu+sa5yM0
 S/IW/l8HKOqvGncZ/VHIG3pmwzmq0oMgrIgytdsE09M2nvUCVL+5iI72p02jV/oOe8PfNrkel
 mzyICxmDg0VcsqMCt8L2EKgz+rOjg3Z1vwLrnqYwxIQkOmkS7O4yUuAD0YKyHEDnivyMHr/Xr
 A0xTQVFmkimkNvBi1t61tYTWgCm9impqfrR0X2A8+mfApbPDQZsr3jlOSFX155TTosAkNe3F/
 fpM+Uz8Ng0yUFWwdWRzRh4elFZQ=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 30.03.23 um 09:55 schrieb Diomidis Spinellis:
> On 30-Mar-23 1:55, Eric Sunshine wrote:
>> I'm encountering a failure on macOS High Sierra 10.13.6 when using
>> --color-words:
>
> The built-in word separation regular expression pattern for the Perl lan=
guage fails to work with the macOS regex engine.=C2=A0 The same also happe=
ns with the FreeBSD one (tested on 14.0).
>
> The issue can be replicated through the following sequence of commands.
>
> git init color-words
> cd color-words
> echo '*.pl=C2=A0=C2=A0 diff=3Dperl' >.gitattributes
> echo 'print 42;' >t.pl
> git add t.pl
> git commit -am Add
> git show --color-words

Or in Git's own repo:

   $ git log -p --color-words --no-merges '*.c'
   Schwerwiegend: invalid regular expression: [a-zA-Z_][a-zA-Z0-9_]*|[0-9]=
[0-9.]*([Ee][-+]?[0-9]+)?[fFlLuU]*|0[xXbB][0-9a-fA-F]+[lLuU]*|\.[0-9][0-9]=
*([Ee][-+]?[0-9]+)?[fFlL]?|[-+*/<>%&^|=3D!]=3D|--|\+\+|<<=3D?|>>=3D?|&&|\|=
\||::|->\*?|\.\*|<=3D>|[^[:space:]]|[<C0>-<FF>][<80>-<BF>]+
   commit 14b9a044798ebb3858a1f1a1377309a3d6054ac8
   [...]

The error disappears when localization is turned off:

   $ LANG=3DC git log -p --color-words --no-merges '*.c' >/dev/null
   # just finishes without an error

The issue also vanishes when the "|[\xc0-\xff][\x80-\xbf]+" part is
removed that the macros PATTERNS and IPATTERN in userdiff.c append.

So it seems regcomp(1) on macOS doesn't like invalid Unicode characters
unless it's in ASCII mode (LANG=3DC).  664d44ee7f (userdiff: simplify
word-diff safeguard, 2011-01-11) explains that this part exists to match
a multi-byte UTF-8 character.  With a regcomp(1) that supports
multi-byte characters natively they need to be specified differently, I
guess, perhaps like this "[^\x00-\x7f]"?

> Strangely, I haven't been able to reproduce the failure with egrep on an=
y of the two platforms.
>
> egrep '[[:alpha:]_'\''][[:alnum:]_'\'']*|0[xb]?[0-9a-fA-F_]*|[0-9a-fA-F_=
]+(\.[0-9a-fA-F_]+)?([eE][-+]?[0-9_]+)?|=3D>|-[rwxoRWXOezsfdlpSugkbctTBMAC=
>]|~~|::|&&=3D|\|\|=3D|//=3D|\*\*=3D|&&|\|\||//|\+\+|--|\*\*|\.\.\.?|[-+*/=
%.^&<>=3D!|]=3D|=3D~|!~|<<|<>|<=3D>|>>|[^[:space:]]|[\xc0-\xff][\x80-\xbf]=
+' /dev/null

No idea how to specify non-ASCII bytes in shell or regex.  '\xNN' does
not seem to do the trick.  printf(1) interpretes octal numbers, though:

   $ echo =C3=B6 | egrep $(printf "[\200-\377]")
   egrep: illegal byte sequence

(The regex contains "illegal bytes" -- UTF-8 multi-byte sequences cut
short; the "=C3=B6" is OK.)

Ren=C3=A9

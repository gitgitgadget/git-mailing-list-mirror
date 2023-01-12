Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD379C54EBE
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 17:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238082AbjALRx1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 12:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbjALRw7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 12:52:59 -0500
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E524E6E418
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 09:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1673543594; bh=8qQe3CxAaq6GxFOwf6kcBMUBwUvGl3PVvOOTCeS6aAo=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=H08271fckm2LI84tGEAk91Xx/zCsRHmjcVI8aXdX3WdlUMNK7E8FSYjNEanGcM8fE
         KBH0RfaADPqAZ+eh79+pGU2njfpKenAgxQaGe4XbYoPNR7PsKAtYztIk0AsEOuHXA0
         dG/5k8goMPwG5Hi+l6iMBhALdDktQhe4/Rp79u7bkQ5awXBlbv0N5V/JtshFcf97C4
         RYyYWNEh4gdLgJs4ysQlKMG8adGMStz1AiBvxkY/ZnuNv7K+plDKSczbDuOrkecpII
         Hu7IWqMLeTc8JUpvUXB8pttjNRGH2pfWm68PlLZ6OmMZRcZcIEhxASWqvqnc1XnnV0
         8Wj7/vLdFyf1Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.21.69]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MGxMN-1pTzEP2Oah-00E5hZ; Thu, 12
 Jan 2023 18:13:14 +0100
Message-ID: <4165031d-e7f1-0477-2245-6a8e312de522@web.de>
Date:   Thu, 12 Jan 2023 18:13:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: BUG: git grep behave oddly with alternatives
To:     Jeff King <peff@peff.net>
Cc:     Marco Nenciarini <marco.nenciarini@enterprisedb.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <f82ae28a-fb56-8d1f-96c8-550b61439d3a@enterprisedb.com>
 <634f47a8-b370-81cb-00e7-d93ffc7534a8@web.de>
 <1f61b660-b2d0-ba93-3182-05a9ab97b00e@enterprisedb.com>
 <343a891e-d737-0ace-26a9-3839d3bd5583@web.de>
 <Y7Uu35HwUx2EVfAg@coredump.intra.peff.net>
 <e5165840-331c-e9b6-b45f-62abab860d79@web.de>
 <Y7flVcALZQgz0VPl@coredump.intra.peff.net>
 <26a0d4ca-3d97-ace4-1a1f-92b1ee6715a6@web.de>
 <Y78GXZvyrOrXhe7n@coredump.intra.peff.net>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <Y78GXZvyrOrXhe7n@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QU/+haCX4sr2KVTevfCmA+P8SVrvKdW1NGWOSItxIGElp1LVSd9
 zmr4hZqqNhAlt7fA6+NwnqVCvU2cJLbJe0WWL9nGRYuPKIxoFdabWOjAtAM5idwpacgj8mc
 KDLibyLCP2sZvA4RV9Bjw3E45qj0us0b66udPXdgcozW+qai3VGmYJt7XufmUPSCFqZAZQs
 kcE44OrGQTE1vPqLvEA2g==
UI-OutboundReport: notjunk:1;M01:P0:aXm4X70T1fU=;WpEg9KtJqTyd2rCHY3UEErlNweP
 pbClw7nPvpzRq6EYOmfvQqzxQPJZFs+XYwliMRNGTyN/5NO3/eJemDw1g902UsuFGpHt2nOGa
 mIzr4l/O77ARdPAvK9Rlx2UuIEyGy8CKVC/fx3tgWaEhQ2JAxgn/6niSF7fzrZ/cOP6dEJ2vd
 7hFbjIkGYtj3UTpN5s46vYk7iXaq9ZgIExPN3A7EOpc68MienQkNal2jzRJILS+IIbUqhaSgO
 DeXASKnoka6DMByOxMBV27mxqq9MBQGVcMEwnuz8FHNFZjLRqh47S1A6kmKbV3ppmvJEWwYfL
 4UTcx5kGWx7W2oo6z+NJO7Mvhd2vMaTvM7wiXpKYhIZCfgjlP93zfZeA1t2I1wsEjmtXQNbP6
 aFn0pzDyM6JOLKrIwlzXnJ2x0RFwGr8iLN75MuKsRCF4+2FV56q7DYFcTh2Q8O32brPkE5gpN
 HpM//iB8HK4vAp4yLP/hVuM3HAb3qtAIDFGKIcD2POK6Y1Qxy491hmQVUnJCJQqYHpWgggLVQ
 H7Yrwvo0oWAE/CjPNNEPG5qtpqz+WhN53/1Yz//VokdnjeuMICPuv+JK3KTyeyz/ZQGHc5lUj
 vEjBgFWGD1gkfcfWnZTKga0RzdH9bCAgOI2FMAC5v5kLpI9ErM8MeV3U51UdTK3lIDuPG9WYL
 710rPK0zRfmwu+tI7m76VulTAqeln6bskuCzA42Nlzlz753tY8NRmuV6kYjCuaeuoFw9Tx0FK
 W0fs5QgV+c/H16ASufeH19T4BivMrDr++4PxLKQAh0Ui70OfJ5D1nbSqcyVTpd1ng6kLCUMmj
 xgEhax4tTnlKHlKYNSmtdr46Q7rKbuGdUqvFlq01N7BW7/FfX6/ZZP7T4yzYSsIlw8f7iWvQU
 SxaURC1V/8QuYYzWBiwvOmG4/3FQ9UAsPaisKfRjbCtOQSLrspDS+59C6Bn06KUP/1sBG/pTB
 edylCBkQ28QgyNvfWxf04z4Mjsk=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11.01.23 um 19:56 schrieb Jeff King:
> On Sun, Jan 08, 2023 at 01:42:04AM +0100, Ren=C3=A9 Scharfe wrote:
>
>> REG_ENHANCED on macOS affects REG_EXTENDED as well.  It unlocks e.g.
>> non-greedy repetitions and inline comments.  Sounds nice, but also
>> potentially surprising.  I was unable to find a current version of
>> the re_format(7) manpage online, unfortunately.
>
> I'm not quite sure what you mean here by "non-greedy repetitions".
> Something like:
>
>   # prefer "foo bar" to "foo bar bar"; only matters for colorizing or
>   # --only-matching
>   git grep -E 'foo.*?bar'
>
> ? If so, then yeah, that changes the meaning of a bare "?" and people
> might be surprised by it.

Right.  To be fair, question mark is a special character and you'd
probably need to quote it anyway if you want to match a literal
question mark.  Otherwise I get:

   $ git grep -E 'foo.*?bar'
   fatal: command line, 'foo.*?bar': repetition-operator operand invalid

>> Apple's latest version of Git sets NO_REGEX and thus uses
>> compat/regex, if I read their source correctly:
>>
>> https://github.com/apple-oss-distributions/Git/blob/Git-128/src/git/Mak=
efile#L1302
>>
>> The easiest and most consistent option would be to do the same.  But
>> we can't do that, because it would break multibyte support, which was
>> fixed by 1819ad327b (grep: fix multibyte regex handling under macOS,
>> 2022-08-26), which started to use the system regex functions again.
>
> Looks like that NO_REGEX line was dropped by 1819ad327b. So I don't
> think Apple added it themselves; their version is just based on an older
> version of Git (looks like 2.24.3).

Makes sense.

>> Which begs the question: Isn't that a problem for the platforms that
>> still have to use NO_REGEX?  Shouldn't we fix compat/regex?
>
> I'm not sure. I always assumed our fallback was similar-ish to what was
> in glibc and was thus pretty featureful, but that may not be true (it
> actually comes from gawk). It looks like we just didn't pull over the
> multi-byte parts in a997bf423d (compat/regex: get the gawk regex engine
> to compile within git, 2010-08-17).

GAWK removed NO_MBSUPPORT, NO_MBSUPPORT and mbsupport.h in the meantime.
I guess that means they support multi-byte characters everywhere now.

Ren=C3=A9

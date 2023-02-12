Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C2B5C05027
	for <git@archiver.kernel.org>; Sun, 12 Feb 2023 17:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjBLRlZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Feb 2023 12:41:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBLRlY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Feb 2023 12:41:24 -0500
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31105113E4
        for <git@vger.kernel.org>; Sun, 12 Feb 2023 09:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1676223662; bh=aRYY+sCssIJ36DbpZUto0C5fRJg9op2J94msJbx2jKo=;
        h=X-UI-Sender-Class:Date:From:Subject:To:Cc:References:In-Reply-To;
        b=CI5VfpubHFAaglah18pLGDf8PKY/heYZXKdcV4uejeSIh5JcmRGmIlWOuQs+5ORUR
         AchZqHF7fJcMKIE20UvbOZgHbL4/H5bSSRR+OZoezAGa46el/cuvQKw6N8PdjNGJT5
         N3Kcr6YcJNMHWGC2uUPFCzAkXiGAXeiUY8yePNfAyTZV1RaTVEHw/yqbJDbPLzJdeg
         NyCg8BHb1QNwaftAJ9iYtd5uCwPH95lSUN9JaDbLHsJlXLERdvaUTPRngsDZwVUM5r
         sJP7DyWYd/kFj+xJ3rD4xlRze1OGHJF7K3wIX/oyhhXt3O6UE0l8qVoQxMDGnKMZAo
         jC3xFiqA2E5Pg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.21.51]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MTfkd-1ozWsN13Ub-00U39u; Sun, 12
 Feb 2023 18:41:02 +0100
Message-ID: <29b3cd6f-6e06-e32f-dfad-ab527488ba12@web.de>
Date:   Sun, 12 Feb 2023 18:41:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH 0/9] git archive: use gzip again by default, document
 output stabilty
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Eli Schwartz <eschwartz93@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>,
        "Raymond E . Pasco" <ray@ameretat.dev>,
        demerphq <demerphq@gmail.com>, Theodore Ts'o <tytso@mit.edu>
References: <230131.86357rrtsg.gmgdl@evledraar.gmail.com>
 <cover-0.9-00000000000-20230202T093212Z-avarab@gmail.com>
 <xmqq5yckvxtb.fsf@gitster.g> <c3f215ca-b4ae-79a2-c14a-3c0f1799e6f7@web.de>
 <230205.86mt5r7q2e.gmgdl@evledraar.gmail.com>
Content-Language: en-US
In-Reply-To: <230205.86mt5r7q2e.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FgNh8b2Q2+G480Q2WuDPZso+Uu95PHQTMQvTCbKIt92TN+SdaQt
 Qc+0yKa2zak+ZY+RpEwfysuMCYyfiFDOXZJQpAOhub2nioDuLsTZfYV0HolxD3YQQiql5fl
 YWjW/FKetEVuRQmU0pWRZXZFWZ90N+zILMwelF/iWWPiuUibEtw8bqkR2NZr6w5e5p8PYeP
 FP5HM9l4uAW4YNCQQ2gFg==
UI-OutboundReport: notjunk:1;M01:P0:lxmH2rr01sQ=;0srpl3+3x69FTNb6KsmvcDunYYo
 wQT+IARS63+k0EVhcTSeWrHpXrPymF23KmXTTPJdAZXEi5xgVRa4zz8qmv+H4bZNBe5MSeR4h
 OrmZGAm6S4fcgC6otiWtdBODHrwObpIvaPxy1dKgwh56agCa99G58A82J0qAO8+p8JZGf8NXu
 GqjU+TT2s1dNi7tDUYMlkrQaVi41z8AqCjwd3b0UtmubBxnLJU3eP8cStIUkTaTMajdXVuqW8
 gvPyaP6aznO3/YVKeTUO6iWNRXeHLfQ3cj9QStI5oVhIJ0wOIHZr/pV/O96fsQHx5/la1i9il
 hqhLySJRod21tEKfOtTg/IbPXXqg391eTTR0LdBVlBafAJXPke8K31d6Y20rx6tJkPHL8uYWD
 yJjRButJmo74qgdzTf+JFQg8qoEiTmqagQfs2Be+ZGZUfzHLkEUSx3F9PtRAJ1FrfqTm78c8d
 hHxDrTKFIs/QAIldJzxfW/t+kvpjESMAM3kvc/C4gleDRXdHr3VJKBCesqOqmX3TU2rUvJrhV
 c4Xe/cPRjdv7y6w/6XEHZlrMKR7MLRroGeIYW4+MZC0Sga94o7kyODVI4iqvsakFhN8WHkicg
 WQTUz6doFqsPRpdEDn7NKBSOVww7SRUXU4gCCI4VmNbqsvLEFUi8zOI7+DHXLsBRredmWR7lU
 sLoK5SUbfW/Jrw66ab7BFVu9mu+vXLojAjD3ydqZYGHGHf+tstOLXRDRMHr0qtC5ampeK70jA
 vSPlpHxVMj1pn8CEFjG17IQBsm7rgyTgzH6tK0LX9E5t9Kmivn0308dpto6N6Td4vkzRZxx86
 qvsB0PU6djOVvgROSN8XOXaBmkqPYrOgXLwjNXE/5syo6nXIyRzNatT8tIDtoFTZAREzSd1U5
 AOy9Wz01/VDrkW9ycKlvrV3HC6QVOCiFwEMGCyEaGS2dPxZqYok6i7zcYYZebCNcAkJTFiEaz
 gi6U6BOeXNpRjeuZvJK43rZIk1o=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.02.23 um 22:30 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Sat, Feb 04 2023, Ren=C3=A9 Scharfe wrote:
>
>> Am 02.02.23 um 17:25 schrieb Junio C Hamano:
>>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>>>
>>>> As the disruption of changing the default isn't worth it, let's use
>>>> gzip(1) again by default, and only fall back on the new "git archive
>>>> gzip" if it isn't available.
>>>
>>> It perhaps is OK, and lets us answer "ugh, the compressed output of
>>> 'git archive' is unstable again" with "we didn't change anything,
>>> perhaps you changed your gzip(1)?" when they fix bugs or improve
>>> compression or whatever.  Of course that is not an overall win for
>>> the end users, but in the short term until gzip gets such a change,
>>> we would presumably get the "same" output as before.
>>
>> Restoring the old default is an understandable reflex.  In theory it
>> worsens consistency and stability of the output, but in practice using
>> whatever was found in $PATH did work before -- or at least it was not
>> our problem if it didn't.
>
> "In theory" because the user might be flip-flopping between different
> gzip(1) versions?

No flopping needed.  We can't control what's in $PATH.  There are
OS-specific replacements for GNU gzip in NetBSD/FreeBSD/macOS and
OpenBSD.  People could use pigz.  Or cat, for that matter.  Different
versions of different tools might produce different output.

There are alternative to the original libz as well, e.g. libz-ng.  We
don't control which one or which version is installed, either, but we
could do so if we wanted by importing one of them like we did with
LibXDiff.

> Even if it wasn't for that breakage, I think 4/9 and 6/9 here show the
> main problem you were trying to solve in making "git archive gzip" the
> default didn't need to be solved by changing the default. I.e. the aim
> was to have it work when "gzip(1)" wasn't available, which we can do by
> falling back only if we can't invoke it, rather than changing the
> long-standing default.

The aim was to no longer depend on gzip.  That goal was already met by
providing the internal implementation, without changing the default.
Git for Windows for example could use it in their config and drop gzip.

Calling gzip if available, warning if it isn't and using the internal
implementation adds yet more variance.  No longer allowing gzip to be a
shell alias might confuse someone.  The automatic fallback would only
benefit users that don't want to touch /etc/gitconfig, have nobody to
do it for them and don't care about warnings -- hopefully not a big
crowd.

I didn't intend the change of default to be that painful, but don't see
the point in going back now that we're through.  The new default is
better -- one less dependency to care about.  And if we need to go
back, however, then a know-good state makes more sense than a smart
fallback with some new twists.

Ren=C3=A9

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA896C433EF
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 17:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C140D6101A
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 17:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234798AbhJHRcb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 13:32:31 -0400
Received: from mout.web.de ([212.227.17.11]:47773 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229606AbhJHRca (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 13:32:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1633714222;
        bh=eGL9KCipVfEFF8KE+lDBdqBCZiVN0X++S0vowY4fGwU=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=D8gLWNH0gkUwSlbkxh5EmkIX9HcAeIABngN74lxSa4azqwya/vfxoLd8qMP5qH1Bb
         0nBxbqZUoCi4kVF3Lk8Z1LBX0UwZOQ5TqkQcLi2forj5SabjcHmY87ulSuI+qoQIRZ
         j3s86Oh2sqoUB9xb7wqDKYVVG91YikhZkgCxpYAY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb103 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0Lba35-1n2EIH0mj5-00lDvq; Fri, 08 Oct 2021 19:30:22 +0200
Subject: Re: [PATCH 10/9 v2] test-mergesort: use repeatable random numbers
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
References: <943b1e01-465e-5def-a766-0adf667690de@web.de>
 <522fba5e-1048-3377-45c1-7107b55dc6e1@web.de> <xmqq7dew7aqd.fsf@gitster.g>
 <87o887q0s9.fsf@evledraar.gmail.com>
 <850aa059-61d9-0eba-5809-e0c27a19dfb4@web.de> <xmqqee9210a1.fsf@gitster.g>
 <a3eeb255-56e3-eb22-ebf7-e9f04c95fa44@web.de>
 <b73452fa-f5b0-0ab4-25e8-7494637c49f5@web.de>
 <87tuhsez93.fsf@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <c43ce422-0eba-0c7e-af01-a85cd948b0bb@web.de>
Date:   Fri, 8 Oct 2021 19:30:20 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <87tuhsez93.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RWb8I1lZIJ1dmLPp+rNq0mGVVrQwZpmiCSbJ774fhfEG2fQxY+j
 PFN/dl/WdOnA75N7h2QoaMgTTy4Oxtf7y3qU6dqd0aRKtCHwc7iFgz18k1i8QKCzYfJxuZB
 WbaYncZelllEuq1wQN1E220FSGKk9q0Ku7pB8nQ6+p1v+3Dm8BzTcYmnEUQw939Qn/BSfdr
 PoDBUH8HCpozejmn1AHKg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FC6Hjl2g4Qw=:1m9qxiCC0+mK/Qir3BQkRc
 JViMNc1LRbM57L16/Ypspnw3u4r9XfXTFOqgFl+SWogn25w5BUJTFyJ/9JT3/D4hnjUUMksFO
 +fq73r/mwVH6shPc7eavTAc+bAGVGzMqIE32UxIeqYdMJ8Gcv1HEVVqARk6alOlnSYGL/xDZN
 t936VzWv9BxdhA/5+Bb+HlfNJHsAuisWgvv6eYkhT2QbGAouHGgV6GAPgJP2Rryy9X84vt/hB
 6NwICWyug+yLQaK5QRV7CAwXqHoF/TdrYV5Iw/KULuu+RuSy6Dd+7JOtihL15OD6lrz4Pen/G
 JuGXVBvA3QNK5yaaEDpdwy7PkXCi8Op0950eyLeqTfWGZ2j/u2c9L1Fkhd94Hm/15JUS3Omo5
 rYc16O7dZfA12/DVDGmwkStE2orJDShcYZLwebhy4CfJqHsDaK2Bym6xES/hdLxYErw/ci/U+
 mgL5d8Y5Bg6R+7C7Kdp104HlyvIlnyvBphVHH17uq9Ek1tLy/ofUeUT/Nz0vx2N+mwAiZFhxG
 j0E7IgLPxnQC1EHqyimNiIz7F4HwJTkCOO3fb2dXYQo//ocey/Xxu3/m6LJmdFkXkERxtEEeb
 2jOTvifdHMwVDGFzT1YGrNTsk3r/sOxLQ+gFfTB+acms9+Kc7HmptetpdfsazmMgI9d5miz/p
 LudA9v4XDrRAYINCm+r3h9Fggr6x/Ehn57GjuQIjyu7MsHqXVxLGSwV6WMCgZkWoPZUJaUa10
 rW1C9ygzpE41AkB56w1X6PnxV1mM1s3DQd3waWfxLSVTnYDyzD6zglufAsaOL/9Hhh0bpo0dx
 mR+M338YbaVv61/UWz6dDGMQPGLRhvykJOub3cU9RLPfvaaT9wvmERII/saK0B1tzfc8vML1d
 1T2lrwfv+FVc9QKbMYFky3VN98yPlEnPt6Ieelst0OLIfmzbuCbDDpZV+/QwavXmXb8ar+krK
 GTKbWSiikruGB2Y81l6b+Nbnis4WLKf5kYaRZK5H66/JogPjyXjjJZAydwOxD/WFU763k80Kt
 Z/aZdSvSgga8qr2NRRtFkxQ6HTMDw3g3bdE+KwxEhjOtTiY7VAw5Ui7CCUZM+TpdJlpinPGsH
 sC48bw67riLq7s=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 08.10.21 um 09:23 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> Just to your upthread:
>
>     "Right, so we'd need to ship our own random number generator."
>
> I don't really think this matters in either case here, and if anything a
> flaky failure in this test would quickly point us in the right
> direction, as opposed to say having the N test_expect_success being run
> in rand() order or whatever.
>
> If we'd like results we can compare across platforms we're surely better
> of here running this in a loop with different per-platform srand()
> values N times for some high value of N, than we are in picking one
> "golden" distribution.

A mergesort bug that only causes invalid results for certain RNG seeds
is not impossible, but unlikely.  Portability of results is more useful
for comparing the number of operations needed for different types of
input, i.e. for performance work, not so much for correctness checking.
(And those results need to be taken with enough salt to avoid micro-
optimizing for specific distributions.)

Adding more rand and shuffle distributions, parameterized with different
seeds, is certainly possible.  Not sure what it would prove, though.  We
would visit a bigger part of the permutation space, but that thing is so
huge (N!) that any reasonable sample is still small.  That's why I added
the unriffle modes, to find maxima.

> But just on srand() and rand() use more generally in the test suite: I
> think it's fine to just assume that we can call srand()/rand() and get
> "predictable" results, because what we're really after in most cases is
> to avoid hard-to-diagnose flakyness. If as a result of random
> distribution we'll get a consistent failure on one OS (or the flakyness
> is just OpenBSD...).

I can't find any current use of rand() in t/, except perhaps
t/helper/test-genrandom.c, which open-codes it to get reproducible
results.  I don't see how calling rand() instead would improve it.

> Also generally: If you'd like "portable" rand() for a test just shell
> out to perl. I ran this on various Perl versions (oldest 5.12) on Debian
> Linux, OSX, Solaris & OpenBSD, all returned the same number for both:
>
>     ruby -e 'srand(1); puts rand'; perl -E 'srand(1); say $^V; say rand'
>
> Whereas a C program doing the same:
>
>     #include <stdio.h>
>     #include <stdlib.h>
>
>     int main(void)
>     {
>             srand(1);
>             printf("rand =3D %d\n", rand());
>             return 0;
>     }
>
> Returns different numbers an all, and on OpenBSD the number is different
> each time, per their well-known non-standard srand()/rand() behavior.

For test shell code that needs only a few random numbers this would
be fine.

For test-genrandom it would also work, but I don't see any benefit in
converting it to a scripting language.

Shelling out to a script to avoid a multiplication and a modulo in
test-mergesort is not interesting, to put it mildly.  A mode that sorts
input from stdin like the sort subcommand, but returns the operation
counts, might be useful if you want to test distributions generated by
a Perl script or other data source of your choice.

Ren=C3=A9

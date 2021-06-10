Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A4FC47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 15:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB766613C8
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 15:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhFJPQ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 11:16:58 -0400
Received: from mout.web.de ([212.227.17.12]:52259 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231365AbhFJPQz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 11:16:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1623338094;
        bh=cVOZsaPzFayagZ6RMmTffVyw3ELGQQ3qyj2bKBeapDo=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=s1/x1iY3MxYYM6M18NCizdopq8EUD+IHXl/Q+0uvC2AA72kKMGTJ6ku9CZZO7qNrm
         4ZscQggGnDLp7CcMyzM99WK3DRAhpKxkvFTr4bxp9M3W3xS+2aekU6P43ud2nRW32P
         N/HKkj3Z6hN6nakrTURKbcF7zkE2dTZ94rg8U+Jg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.31.60]) by smtp.web.de
 (mrweb101 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0M7snk-1l5Bev3cYK-00vOB4; Thu, 10 Jun 2021 17:14:53 +0200
Subject: Re: [PATCH 2/2] read-cache: fix incorrect count and progress bar
 stalling
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
References: <cover-0.2-0000000000-20210607T144206Z-avarab@gmail.com>
 <patch-2.2-042f598826-20210607T144206Z-avarab@gmail.com>
 <8f336b1b-6cb7-8277-79d5-0f331159b00c@gmail.com>
 <87k0n54qb6.fsf@evledraar.gmail.com>
 <eaf2b6b0-4202-d5ea-87a2-b828fdbc60a1@web.de>
 <8735tt4fhx.fsf@evledraar.gmail.com> <xmqqczsxtf8g.fsf@gitster.g>
 <87wnr4394y.fsf@evledraar.gmail.com>
 <74183ce6-e17f-1b11-1ceb-7a8d873bc1c7@web.de>
 <87lf7k2bem.fsf@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <f5e181fc-af94-bccf-051f-a58a04fe1ffc@web.de>
Date:   Thu, 10 Jun 2021 17:14:52 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87lf7k2bem.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WqLnaH4Qj5JfAJbaHA6y1furV2HesZTqHa+7ujhME1eoHD+aBqM
 nx6xeSkYebrdunjPvUcojV1E9IHbHFTwIjQ1VSFSrXFAN22NLcr6grkzOfIYCZm3Ja/nq+7
 vjmmnDcY0FQlXHhYPmFE0dCDr4eBTjk/SBFalp5sV4X0hSZm0eAD25zvnUdLr7mUsVjz2QY
 /7NgGg8jKghZvcVrPSnzg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cwH15WBj/9U=:Nqfp5v2uFNnVKKlmuxpiZi
 bKlSizeGARms7xvAANHa3TgCdmP019bEr2qTSx6Y7sUAfdcgy+u9d8yCax4kgR5p/ObuDbFKI
 oN1dVTG0kJYz/wXxniOdeNCqQGzRhZcy4iT4Axh5sowAnwQAUJ+5C6IBkoJwruiqD9k5tpEzh
 8H98u5eOv8PzWI4agDY/jWlKgYpGTdtQlaqzgM4wxdRKL2NPbx7aWqvysUavYCyQjml8gsD+/
 8wfECOJqBzFMoD0qTlPL+zIR4mt9wxSbxrXZ3c4f0+a+/vVn5+NxpYhXyDc7JDI13SbYE9GuJ
 w1T8/yJew+iCn1C4msrecQqTAdLs2CEtfhK1LAI6dLQlHDlpyf9TYanlo2QT0MNP+CE0H4Nus
 KlSw5RbZp6Oq/TcaQmuH6ciLzE9lPyb47gzYuAP9tD5s+REAxD7o7AN0HH87P/qUVcUFqiCkT
 O7rQMIBG1IhkDv8LBVYKPmwaqFoSG1ICn4J6SaYlNfPftiClZqVBs9m7na0Nnhav9gUVx0/mU
 XJLmS3HatbnSfuHC5n7eDwIkGiBWPDK73ho2xi+qBBcCMt//u+NcfFhXi3eloiIjSHeOUuopR
 uFEQMitlXvla6+7xMy6lZDeDbJSr6fxOG7db0FwdZSS/19pQmVu6q/0rj4IXJbIgBImYXLEs0
 HdurbXY4AQ+5Xvhd5FiOJSP3zG2zaaTUjVNRuGckahEpFOd0KsFply6dq9n9b8YfvDzNNQfp5
 VwNPlW4a09K+mHFqirnYFGZG22qgwUZ0ODy2f9aaIBevmi1VCpWQnaSnok9+C0FDJOjvApI4f
 gjImWSdM1qRSUbOSy2kJjmXAAFgLZz+G2Pimwoz2of+zQj+8Jctz26NMx9Kx5ZLeJW+4uHcf1
 5REFvN/ulA+VVFrZ0+DRsE2/5pGiAGSkYuVmXp1zEytg86GSZPsrz7Rk6yCaitaMnzJ8mFoBI
 7N2LVVJ8QXKCpRtnepByhepYq3YT17VyQ5usCy5IwiVrZFVeiVVfy3YWreHYLTjnQyJ5AlcDH
 m6zLHNR3hjyuPdaiHuuMnBWLaJ89GlvIB52zC1MApQc2qEbxZakyTotPc3V8dxXgUyyFv08Zv
 xPJq12lB5sKiHd5JBYOCN2WZtWO8Psx1ATJ
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.06.21 um 00:12 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Tue, Jun 08 2021, Ren=C3=A9 Scharfe wrote:
>
>> I wonder (only in a semi-curious way, though) if we can detect
>> off-by-one errors by adding an assertion to display_progress() that
>> requires the first update to have the value 0, and in stop_progress()
>> one that requires the previous display_progress() call to have a value
>> equal to the total number of work items.  Not sure it'd be worth the
>> hassle..
>
> That's intentional. We started eating 3 apples, got to one, but now our
> house is on fire and we're eating no more apples today, even if we
> planned to eat 3 when we sat down.
>
> The progress bar reflects this unexpected but recoverable state:
>
>     $ perl -wE 'for (0..1) { say "update"; say "progress $_" }' |
>       ./helper/test-tool progress --total=3D3 Apples 2>&1 |
>       cat -v | perl -pe 's/\^M\K/\n/g'
>     Apples:   0% (0/3)^M
>     Apples:  33% (1/3)^M
>     Apples:  33% (1/3), done.
>
> We're at 1/3, but we're done. No more apples.
>
> This isn't just some hypothetical, e.g. consider neeing to unlink() or
> remove files/directories one at a time in a directory and getting the
> estimated number from st_nlink (yeah yeah, unportable, but it was the
> first thing I thought of).
>
> We might think we're processing 10 entries, but another other processes
> might make our progress bar end at more or less than the 100% we
> expected. That's OK, not something we should invoke BUG() about.

It doesn't have to be a BUG; a warning would suffice.  And I hope not
finishing the expected number of items due to a catastrophic event is
rare enough that an additional warning wouldn't cause too much pain.

Loops that *regularly* end early are not a good fit for progress
percentages, I think.

> Similarly, the n=3D0 being distinguishable from the first
> display_progress() is actually useful in practice. It's something I've
> seen git.git emit (not recently, I patched the relevant code to emit
> more granular progress).
>
> It's useful to know that we're stalling on the setup code before the
> for-loop, not on the first item.

Hmm, preparations that take a noticeable time might deserve their own
progress line.

Anyway, if no guard rails can be built then we have to rely on our math
skills alone.  Off-by-one errors may look silly, but are no joke -- they
are surprisingly easy to make.

Ren=C3=A9

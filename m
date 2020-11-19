Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB52C388F9
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 10:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 610672225B
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 10:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="TUgTZ6p8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgKSKrV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Nov 2020 05:47:21 -0500
Received: from mout.gmx.net ([212.227.15.18]:41333 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725905AbgKSKrV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Nov 2020 05:47:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605782806;
        bh=93pFxT6Dmc/9Wkya9FQrD/7VteEG/9hy+Z+ijejuOv0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=TUgTZ6p8AHK13Zxk35CehOlVx95JSm3w3iFXUNHtHevSQTTn+dKayugfDDrmGGAP3
         1AeQiPRzinIaUYMEF+U4fusjE3U5MC5vaXpSTYgfy29E0kGSBVM9/9BbyaZgE4q91u
         TitoQExl80izphvxTgtpiDPOoskpBixxjq7wLpIg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.22.105] ([213.196.212.61]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N2V0H-1kGDdJ0Y1f-013twL; Thu, 19
 Nov 2020 11:46:46 +0100
Date:   Thu, 19 Nov 2020 11:46:45 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Don Goodman-Wilson <don@goodman-wilson.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH] tests: support testing with an arbitrary default
 branch (sort of)
In-Reply-To: <87ima2rdsm.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2011191050550.56@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.2011131519170.18437@tvgsbejvaqbjf.bet> <20201113161320.16458-1-avarab@gmail.com> <20201113191418.GA764688@coredump.intra.peff.net> <nycvar.QRO.7.76.6.2011132229480.18437@tvgsbejvaqbjf.bet> <87h7psg6lz.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2011162118060.18437@tvgsbejvaqbjf.bet> <87ima2rdsm.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1318466315-1605782808=:56"
X-Provags-ID: V03:K1:EIzockhuUo2E/Ib/DZejwEC8KHkgWIR6M5dflYc7C/4ofJwzmFa
 MAqRoDU4CMH6G1j34/H55JJ5BEMWQrZTkL/ITtn9B8iO/N0WsrXBeVT0cIVOXS3i247dvGZ
 jixXiOfEjKol95vKo7GFFPMwfePob3B2oMSPKC0Zw7t8p5OOZ8EfKa9gZbiB0EDhXblV5W0
 B1n14zd2aXxNmYxXI/x2w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bKwbT20zQVI=:h0vA3opM17Cr8WYGwdwtFq
 UQzst6SyzWhMPXYzzAXVO9fBAB6sgIRognHnYGxkwVME2QB6JXrVZQcz1GGZUw7CgjCT06HQy
 TarS7NaeoAXmtb28cT3hRMTEKn3DKtmGBcoBDm2GdWFvL+knYvGDn6a40kWbh3OZ+2lm3q4eI
 qk2byDa67725HXQwgPqflEDCNQjDWIn6+4Pb73LgbyTD81VEi5J/BGjOKGjqJEBPr6tFhxtqL
 2flpjBJRazBjjb/pU8cb0dq1u3jIkQNieBk4pOyk9DPCyC2WMGIOrrPrn3CePf5MuU05/45Pg
 MkdcTJ0feZGrPKglvr6DXRR8phdi/Fa46FMig1nNBFyycESqBAMbSJRezQZat0R+zW6Ix39J2
 SCKtpclSmoZy0caU0DXgcde2ScDelIC91d/jUUNWNUELb0xS7MGqZGr4Nnwxculb+0FbJFbCl
 ystqOXFysGGtjtvt6UeVqevCUSWNzzEAvjaAQ72/zsvj6LQ4+h9XTVWg0QW4nChqDi7K2funJ
 b7lgLPIlVaJ7rkoAuN8gw83u1X9fPGmsc8F3YzrtXII/KFAvB4uCpyU6hZHVVfmcNoiA8ZzGt
 jrmHRNEo3C7OHEk3mTSljrFJH/nJ0GZyxCVMybiSDQ1sxS5KV4fug2fMZdgHOfGVQ+V751F1w
 QLLqTvyUujNmHJWTsc4B625tIYui7tH4r7DUfUQp8Zplvm2BkPFSkyeRGquT9yQ4K2kA/T5BA
 gGDZOwUlnQLo8W0s81XLsWjp0ewoO0e98ElwUZeaXByVLo8RfcUHJC2cpztwyiZaJpM6NqYc4
 Wy+GJcX8QgasYYP0oOzL31eHnl76pXZFKTaaJhdz2565cVRg8OkYSZGRXoBPDSY20diCipo92
 GsCjJsrAg7Dia5vr4MaqCBNrvSdD7zzYrxmO/fyS8=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1318466315-1605782808=:56
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

I agree with pretty much all you said, just wanted to comment on a couple
things:

On Wed, 18 Nov 2020, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> In case I didn't make it clear I have no objection entirely replacing
> "master" with "main" in the tests. I just had a practical
> concern/question about coverage while it was landing, and a suggestion
> of whether perhaps there was an easier/faster way to do the "init"
> change first by omitting some of the test churn.
>
> But if you want to do all the legwork that's fine by me :)

I started it, I finish it, I guess. Well, technically Don started it...

> I think some of the people advocating this change can rightly look at
> some of the previous E-Mail traffic and see what are at best rants and
> at worst some political grandstanding that's at best pretty irrelevant
> to any proposed changes in git.git.
>
> But that doesn't mean that there aren't some legitimate concerns.

And that's so sad to read. It is disheartening how eager certain people
were to drown out others' voices, then claiming that they had not heard
any views opposing their own. I mean, yeah, if you want to hear other
opinions, it sure helps to stop talking for a while, and to start
listening.

I consider myself lucky that I _did_ get the chance to listen. Related to
my work in GSoC and Outreachy, and through my day job, wonderful people
approached me with their stories and perspectives. I am really glad that I
had the opportunity to hear those.

As to legitimate concerns: yes, you are right. There are those. If your
documentation says that you should avoid committing directly to the
`master` branch, and then you clone a popular Open Source project and it
does not even _have_ a `master` branch, that might be a bit puzzling.

Note that I used a clone as an example, not `git init`, because it is a
much more common operation. Git is a tool for developers to communicate,
in a way, after all, even if it _can_ be used for working in isolation,
too. Hence clones outnumber inits. And that communication of ideas, of
code, and to combine efforts, to collaborate, that is what Git really
facilitates. That is why I find it so important to be inclusive, to be
inviting underrepresented developers. There is such a lot of untapped
potential there, and even if using a non-offensive default branch name is
but a _teeny_ tiny step to open the door a little, it is at least a step
in the right direction.

Now, since I mentioned `clone`: please note that the default branch name
used in a `clone` is squarely outside the Git project's control. It is
decided by the maintainer(s)/communities of the respective projects. And
that's exactly how it should be.

Therefore, as you said before, it does not really matter all that much
at what date we will change the fall-back for `init.defaultBranch`.

At the same time, I still think that it is valuable to transition the test
suite _now_, to be as independent on a specific default branch name as
possible, if only to ensure that above-mentioned projects can choose
freely what they want their primary branch to be called and Git works just
fine.

> I do 100% agree that the s/master/main/g change of the default should be
> made in one form or another. In my mind that doesn't even require a
> consideration of the political motivations at this point as far as
> git.git is concerned, just:
>
>  1. Major Git hosting providers already made the change
>
>  2. Realistically a lot/majority of git's user base interact with that
>     in a major way.
>
>  3. A discrepancy in any default between /usr/bin/git and those
>     providers is more confusing than not.

Right.

I originally thought that we should switch the default branch name in
v2.30 for that reason, but I now think that adding that advice is probably
a less disruptive, and almost equally supportive solution.

>  4. #3 doesn't mean they say "jump" we say "how high" whatever the
>     change is.
>
>     But in this case the default is an entirely arbitrary default. Not
>     e.g. that they decided to add some ill-thought out header to the
>     object format or whatever.
>
> P.S.: Shouldn't the pull patch in d18c950a69f be using the advice
>      facility, not warning()?

I submitted a patch for that, but unfortunately forgot to Cc: you:
https://lore.kernel.org/git/pull.795.git.1605781349528.gitgitgadget@gmail.=
com

Ciao,
Dscho

--8323328-1318466315-1605782808=:56--

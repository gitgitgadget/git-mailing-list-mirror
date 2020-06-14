Return-Path: <SRS0=22YV=73=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DD9C433DF
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 21:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECEEA2065C
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 21:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="eVTwJN4O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgFNV3B (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Jun 2020 17:29:01 -0400
Received: from mout.gmx.net ([212.227.15.19]:53437 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726648AbgFNV3B (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jun 2020 17:29:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592170125;
        bh=G3Ur/WWZ6X/IGkjSM9uhAN/WSZAp6cp8+P/nNQ4QKGU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=eVTwJN4OhwAzeB3x6uIwaq5mXaXneSt7n2qu0zy99sytvPqWYPCm6qNLIh/rCsUe+
         WAjL6DIp0lEhbIycnuGODNmBUtJTBwLsp+9XI7gagph4uD5wQ+WfUNdJCfvdw4WpY2
         T988ZrR8BpUekQlefHHfZ6rdlukZhN/V5ZFB5Ppg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.173.52] ([89.1.215.43]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MjS9I-1j48d43Epm-00kvi7; Sun, 14
 Jun 2020 23:28:44 +0200
Date:   Sun, 14 Jun 2020 10:55:29 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Sixt <j6t@kdbg.org>, Matt Rogers <mattr94@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        don@goodman-wilson.com, stolee@gmail.com, Jeff King <peff@peff.net>
Subject: Re: Re* [PATCH 8/9] fast-export: respect the possibly-overridden
 default branch name
In-Reply-To: <xmqqeeqiztpq.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2006141053170.56@tvgsbejvaqbjf.bet>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com> <1efe848f2b029e572cea61cadcfe36b9d3797836.1591823971.git.gitgitgadget@gmail.com> <CAOjrSZvm9QNUttUNVBEUMPJ8zgYEoAnSPN5_6N5uwpiM1sVrcQ@mail.gmail.com> <20200610233912.GU6569@camp.crustytoothpaste.net>
 <CAOjrSZvV6+ApfmOBa7rdXDPQJbExRsOfodO16i_1N5QjjhCB1w@mail.gmail.com> <xmqq3672cgw8.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2006111559300.56@tvgsbejvaqbjf.bet> <xmqqpna5bq2l.fsf_-_@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2006121451100.56@tvgsbejvaqbjf.bet>
 <xmqqy2os2u55.fsf@gitster.c.googlers.com> <405521ec-aed7-ff76-5b48-70e9d11018e6@kdbg.org> <xmqqv9jvylt7.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2006131645380.56@tvgsbejvaqbjf.bet> <xmqqeeqiztpq.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:7spRtj+jq3fIL+meWYvloEwJRbQ24P0Ad3fr+W/Kvkz/bJbg9ZX
 NhCZhsB4cSBj8GgyBQCIrUz5NnMfSyrw65npUwoafdGahnqYK+x7Gx/yCdjpLB6DX55/xPM
 Q2jcBo66K+9gs2Fi8oGk0PoUHnLMva4obD/4p3SmelU3yg2s43SAhPlGl6NRf0BFZPwuMhs
 Z6QBEfAYJa8xislnhatCw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Cch1uLzw2sw=:1Yct1BBWKRI6MGXG7yUS5l
 jATbY8ImlHgRPNM5LVkxziBvuiaXHuz0MH7FSiLpOJWEPAPWPtDC3cFaafegaaDk8FeaceMea
 q34KRFf4gewM6/daIogFaULt6i4Je/bymzc1L7J4hMZhWKNeBmGsn+hO6leMHHCiXqkWDX8MP
 k3rF4Ru8Zi9lSGuX4sAf7J8ei8F2PZRDV8a4/urMO9tGQSPitbCfXdFm6aDp/mDe4/VWhYvR5
 d8uM53heH8Jdm19F3xfhWiJTNL2MeCr9kXTwGciV1pISw2WnNLJUFLekyCJVrW7zh+vZudJ0S
 3tUhRUB5TuSGPCKjJ8P9C9sosXz6bLwmRcadRPfHwq2zp12dNusFdbg0R+sUjV3CV73zArkHO
 kqg2vrUwWdecfz9dTODeMLExKJZ6M/68n5eWOJUxip7JhyLbglrc7wsjRks5Utr4pITIm93Yf
 KeeOyOphb4mHgJb8CMSUYes4SeWAk/55XC7tvgwyPKt0THnr1TF5BFSxth6SsyChUj0TysbEI
 s9Gj6WQfUlqvC0OzroTwHkyQdKLHLTdh0DvObc6WYzD/qRjxsSNspyS1+u3gSWi0m8wI1zzX/
 He56AXxF61WWn/lGfErbUb80DgpoAIvfBytZ8yaPwifhYTUlKjLDov3u9Uj+5iX6PKzV+4qAI
 VakVwwcr++2w4X/tM5373Wqk8MrY9ZNmJgU+l0fC5HCRKU5xVRgGau+NhyOs9iTXCsUpFLMUT
 cxuR+78P5PjmSvG8eJeHNF9gQ2pKqkeSYrOhMGAlqCh7JqjDY6I/7EW08lGWnCAvLPDqXH62F
 zsCAMT0TS7Y9nVmPZh8fU2jztU6BcltmY9Eh1E8TvelEeQfTy9hR30WatV/Zbe3qJllo21rBI
 PZtXispAR6pVYh+90dqQRwpbxpP2BBtkwYQ8BbHqF8pbbkZswuhHH6sfUl2h7VAGjmp1HQF6F
 P0e1xS4mHKCU8Waoc3BYZvJ6Q9Jkyvz3eA3fkp1AtOJHqbmqyBaVs9z+U1eG8kKlhPy5W3dwr
 zlODSHcoyitl+kZXrY13zchMukthVi0UzY0HZEI53SvqeA6KIzUgmonu8or4f37knbC0oPFct
 g9zs/nLdPy8vCfmQRIQja1exkJbg20lEwaXOgUk/F/b70MR1mK6llwqctoa8Fk+Qr3+Xc3DJK
 8tPSMHvclHfFayb5hXs3UbrcaVzjWSUV/5KdqAl8brseXNqYKVJQiIpZ6RlSfC2aE+WArByXC
 346AIJQnoSC3/iNDB
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sat, 13 Jun 2020, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> >> A corrected code should return a hardwired constant 'main' (it
> >> probably gets behind a C preprocessor macro, but the point is that
> >> we do not want end-user customization) for the reason stated in that
> >> message.
> >
> > I like `ref0` better, for two reasons:
> >
> > - it is more consistent to just have all anonymized branches be named
> >   `ref<N>`, and
> >
> > - using `main` both for an original `main` and an original `master` ca=
n be
> >   a bit confusing, as the reader might assume that this branch name (a=
s it
> >   does not follow the `ref<N>` convention) was _not_ anonymized, when =
it
> >   very well might have been.
>
> A pro for keeping a hardcoded 'master' is that it is compatible with
> the current world order, and flipping it to hardcoded 'main' upon
> transition is just to use the moral equivalent, so we do not need to
> immediately have to change anything.  The _new_ consistency across
> ref<N> does feel attractive, but because it is new, there always is
> a pushback not to "fix" what is not broken.
>
> I am personally OK either way.
>
> By the way, we'd need to devise a transition plan for switching the
> default branch name (i.e. the name used for the primary branch in a
> newly created repository unless the user configures it to some other
> value) to 'main' (oh, I just found one reason why I will not want to
> use that name in my project(s)---it is too close to 'maint').

Yes, the trouble with `maint` did cross my mind, but I try not to
"overfit" to git/git. :-)

> It might roughly go like:
>
>  1. We introduce core.defaultBranchName; when it is not set, its
>     value defaults to 'master' in the 1st phase of the transition.
>     "git init" and "git clone" however issue a warning that says
>     "unless you configure core.defaultBranchName, we use 'master'
>     for now for backward compatibility but we will start using
>     'main' in three major releases of Git in the future".  These
>     commands use the default branch name when creating a new
>     repository in the 1st phase, and set core.primaryBranchName to
>     that name in the resulting repository.
>
>     This is to encourage early adopters to set it to 'maint'^W'main'
>     (eek, see, I again made that typo), while allowing those who
>     have toolset that depends more heavily on the current default
>     branch name than other people to set it to 'master' for
>     stability.
>
>     In the 1st phase, a few commands that care about what the
>     primary branch is in a repository (i.e. fmt-merge-msg and
>     fast-export are the two we have identified so far) pay attention
>     to the core.primaryBranchName configuration, and default to
>     'master' if the configuration does not exist.
>
>     These commands issue a warning that says "unless you configure
>     core.primaryBranchName in the repository, we use 'master' for
>     now but we will start using 'main' in three major releases of
>     Git in the future".
>
>     The above two warning messages will be squelched once the user
>     sets respective configuration variable.
>
>  2. We flip the default for the two variables from 'master' to
>     'main' in three major releases of Git (i.e. 24-30 weeks from the
>     1st phase).  The two warning messages added for the 1st phase
>     will be reworded for the updated default.  We no longer need to
>     say "in three major releases" in there.
>
>  3. After long time passes, remove the warning.

Yes, that's what I had in my mind, too (modulo the concrete part about the
three major versions, which is something I would have asked about at some
stage, thank you for answering that question already!).

Thank you,
Dscho

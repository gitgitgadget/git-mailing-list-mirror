Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2562C63793
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 07:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9342960551
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 07:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbhGVGtk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 02:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbhGVGtj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 02:49:39 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044EFC061575
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 00:30:13 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id k27so5561735edk.9
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 00:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=jvDjB8JvSpwxpQvw+FKFOROwnc9dTNVBGVpfY7H3Hxg=;
        b=k4/WS+PpNLYVXVgw5GUiuQCylmoemLLGUjmhdnVE37Rf1StawrspHGJx9SzwCDUVim
         gKqe1oy8qLgtgVC7BeZpIab3za8ws4XcetcDOJuXRu04NIWjFX4RvYqRXMob0uq6roNQ
         Sely4NGWiWpFXfMd2+FpCEGNEMvt/15BI9etu3ZMRBd+AEGNr0WG2nL9mKX6L3CsZXkW
         UtQDiIVO447Aco5KNcGEjUbkAoPNYfRImMD3ttmC7C/dwVyXsx6GOYMDww8DdQ0Td4qL
         1CUd/YXp2XkjufT4/u5FSXnnR2P//0jBKZIViyRxMyQOmLyPcvlDVbV3YOHYPcUIQQEC
         OgNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=jvDjB8JvSpwxpQvw+FKFOROwnc9dTNVBGVpfY7H3Hxg=;
        b=tMLT3AUkRPuYz7GL44mYunmix0KLWe5rYk4711/QKL658iROQPRKCNUGNrV4V1iQD+
         5tV386sc7kGqcEyzXQ46FGeJGIKGJJffocRUgwzLR2IKqri+9x3y+ZYF7eEy2qKrZna8
         ig60iZlCpmADG/gYL6Na0cEeRpuiHVW35SWRJImX5DPS+ehXNcW6neaqfHe9eKSa/ahY
         lGjCyPX0V5tm6kIlJ5PGP/K8GOzJNhSnVIKJmaDqFpl4o4p6v9hOvnYXVV4i6Jbv2VEk
         +U0tc6YWHL7Lsjcg9yO/cj68QATBdrLpIvyR/IjLUDEqqM5fwjvEKPzKujUQKSd2z322
         ajqw==
X-Gm-Message-State: AOAM531spVO/QoIiXeWoCYKwvg+JFhixH5FQSp9sdVOd99XQmu5lbj1C
        7mw8qI1cdvily1oba239rtM=
X-Google-Smtp-Source: ABdhPJzwEKkSgU/ZK0MWPa5PkZYNtcRnm0g58W+ke3Dyq9BjdcIzfouG/tUynbCueM1yD+sqO6MWfg==
X-Received: by 2002:a05:6402:53:: with SMTP id f19mr52851827edu.200.1626939012409;
        Thu, 22 Jul 2021 00:30:12 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id m15sm11870455edp.73.2021.07.22.00.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 00:30:11 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>,
        "Tom G . Christensen" <tgc@jupiterrise.com>,
        Mischa POSLAWSKY <git@shiar.nl>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 0/5] drop support for ancient curl
Date:   Thu, 22 Jul 2021 09:09:59 +0200
References: <20170809120024.7phdjzjv54uv5dpz@sigill.intra.peff.net>
        <cover-0.5-00000000000-20210721T220402Z-avarab@gmail.com>
        <YPimBp+TkaJ9ycuM@camp.crustytoothpaste.net>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <YPimBp+TkaJ9ycuM@camp.crustytoothpaste.net>
Message-ID: <87czravm96.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jul 21 2021, brian m. carlson wrote:

> [[PGP Signed Part:Undecided]]
> On 2021-07-21 at 22:22:11, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> This series simplifies the http code by dropping support for curl
>> versions older than 7.19.4, released in March 2009.
>>=20
>> This was last discussed on-list in 2017:
>> http://lore.kernel.org/git/20170809120024.7phdjzjv54uv5dpz@sigill.intra.=
peff.net
>>=20
>> My reading of why it didn't get integrated at the time was:
>>=20
>>  - The original commit messages are opinionated about git not working
>>    on these versions anyway, as noted in the original thread that's
>>    only true of vanilla curl, but anyone impacted by these issues at
>>    the time was probably using e.g. RHEL, which had backports that
>>    confused the issue.
>>=20
>>  - While in 2017 these versions were already ancient, RHEL 5 (released
>>    in 2007) was still seeing some notable production use.
>>=20
>>    It finally got "we really mean it now" EOL'd in late 2020 when
>>    extended life-cycle support ended (see
>>    https://access.redhat.com/support/policy/updates/errata). RHEL 6
>>    does not have a libcurl affected by these changes.
>>=20
>>  - It ended with a patch to "error on too-old curl", i.e. to make
>>    compiling on versions older than 7.19.4 an error. I've ejected that
>>    per the discussion about backports confusing that issue.
>
> I'm in favor of this series.  I'm actually in favor of dropping support
> for RHEL 6 as well, since there is nobody providing public security
> support for it, and therefore nobody but people paying Red Hat (that is,
> not this project) can be expected to safely run it.  I also think ten
> years is about the reasonable maximum lifetime of software.
>
> So, with or without those changes, this seems like a good approach to
> me.

I'll clarify this along with other fixes in a re-roll, but I think our
policy shouldn't have anything to do with upstream promises of support,
but merely the trade-off of how easy it is for us to support old
software & how likely it is that people use it in practice along with
git.

So as an example we still say we support Perl 5.8, which is ridiculously
ancient as far as any notion of upstream security support goes (and as
an aside, does have real DoS issues exposed by e.g. the gitweb we ship).

But while we could probably bump that to something more modern nowadays
in practice we're not a mostly-Perl project, so I haven't found it to be
worth it to bump it when working on the relevant code.

I'm only using RHEL 5 as a shorthand for a system that's usually the
most ancient thing people want to build new gits with in practice.

It's just not the case that you can't run RHEL 5 or even RHEL 4 "safely"
even today. Upstream has just abandoned it, but that doesn't mean users
in the wild have. There's also CentOS, not everyone cares about IBM
corporate support policies.

E.g. in practice at a past-job I've had to build git using system
libcurl in a mixed environment which (and I forget the details) included
mostly today's equivalent of RHEL 8 and 7, but there was some system
using RHEL 5 in a closet somewhere still using puppet automation.

Why? Because (and I forget the details, but this example will do)
because it needed to operate some proprietary dongle requiring a RHEL 5
kernel driver that its vendor had since abandoned.

There were plans to move away from it, but that was maybe 1-2 years away
at the time. Meanwhile I had to build a git across the fleet, and it
would be a hassle to need to ship my own libcurl just because this
project wanted to have paternalistic version dependency policies.

I mean, if it's a matter of supporting that version being painful then
fair enough. I had some comments in the 2017 thread (or something linked
from it) about needing to package your dependencies not being *that* big
a deal.

Hence this series, I think on balance the improvement in maintainability
of the http code makes it worth it.

But let's not justify it with a user not being able to run such software
securely, in my example those ancient boxes were externally firewalled,
and in any case any practical security issues were probably with some
vendor's admin interface on them, not whatever ancient kernel they had.

On the other hand there's surely people who are running RHEL 5 today who
are running insecure setup, but let's not make it our job to force them
to move by virtue of being overly annoying about dependency version
requirements.

We should have the view that git's critical infrastructure and we should
be wary of breaking things. It would also just be counter-productive,
the result would probably be that the ancient box wouldn't get an
upgraded git, and would still have preventable CVE's in git itself
present (e.g. the gitmodules RCE).

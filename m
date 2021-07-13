Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E600C07E95
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 08:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5901A600EF
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 08:57:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234603AbhGMJAs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 05:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234121AbhGMJAr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 05:00:47 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C9CC0613DD
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 01:57:57 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id t186so14679096ybf.2
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 01:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GKAiCN4t6xRhm+lj3NNVzBfCHmUj14Djvu4b4pkOuNE=;
        b=pbri4LqJqwHWAtQtsRuFXE+qktD13d3W0wme5mbJMsRZWQPr4HMI6PudCx4qk8Z7Eb
         uN461WYVKZaZmI2IdbQo1RwCCj08Xlg/88yzAuMCxFQ+oJfZuxAE5d0/WfXGoVAAI3ne
         1dmr8WV5StnOEY9tQUG+m6yXd3+iSKm/rOfRDwdOT0Qz5AkuYFL88lj4febdFWTMNfp0
         lhGS/BZPDKVOW1swpGBp2Y+5umjTAk6qQ3SYVvHKyjF4kZtuinOtzx7otKlt5rJAmo7R
         pcFA4XwOy/2GJZ/zY2UygzKQnTz5Mu/Qi01Q2pDSxDg+z41ILw81CfUO/tihm7vaAUTT
         2CPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GKAiCN4t6xRhm+lj3NNVzBfCHmUj14Djvu4b4pkOuNE=;
        b=r18px7ZzeoyeuBozXKFphVpLZSaSlYPxBVB2vjJ0OfTbIvTF4VxDJbHNn37yxlqB8T
         65djKNr8leOUaf4+4cEo1xHB29xxML3nR5zAqxN1MPK4KfiLXJZAa5V0eq5+o2HzbWRX
         iiMZ37cTpVttj/1UnVuSW+goB8d9JR+FWIZ5xlCGBLMxGltMNxLunva2/IqpNTbFU3jX
         g1le44C8BP3R89WAoimvu73a1WNvQb7DdrU9ciDhr53J4PkUgYHmnea8B0IJUa2bvs9A
         Y5eB2C/nbCimyYTz03BZlu56VGVuqMzgo6GyZsS3cMGIhSXjLD/Xq5Yt9bOMKbr7UN72
         UWSA==
X-Gm-Message-State: AOAM532PMR3w1Pjr85Q9oCxKD17EIsT22AQ4qiXdWNlJ9irb/NSwhp1L
        RrN2I140UjZ3iuwDX8EacKc4fa2gZVpke9pdoaA=
X-Google-Smtp-Source: ABdhPJw2P3+dpEYP4fufdkP4GUKDCurYHAvbdsKgapfUs/CrR092uItWKkypeUUxBtE8re1wu+lMBCCvQATisH2FRV8=
X-Received: by 2002:a25:1455:: with SMTP id 82mr4410440ybu.403.1626166677155;
 Tue, 13 Jul 2021 01:57:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210708150316.10855-1-worldhello.net@gmail.com>
 <YOcvaFL7+6qcIOUa@camp.crustytoothpaste.net> <CANYiYbGYzbMoU_2wb4duppASoYUjGLsJsr692Xe3GaVBOXUsBA@mail.gmail.com>
 <YOoXCJV2ssef/KsN@camp.crustytoothpaste.net> <YOyByjmGu1oDXK4X@coredump.intra.peff.net>
In-Reply-To: <YOyByjmGu1oDXK4X@coredump.intra.peff.net>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Tue, 13 Jul 2021 16:57:46 +0800
Message-ID: <CANYiYbF3dcOzZ5gqbYkstxv+WRxZwnoxoNP28A6px44YD98k1Q@mail.gmail.com>
Subject: Re: [PATCH] revision: allow pseudo options after --end-of-options
To:     Jeff King <peff@peff.net>,
        Patrick Steinhardt <psteinhardt@gitlab.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> =E4=BA=8E2021=E5=B9=B47=E6=9C=8813=E6=97=A5=E5=91=
=A8=E4=BA=8C =E4=B8=8A=E5=8D=881:54=E5=86=99=E9=81=93=EF=BC=9A
> On Sat, Jul 10, 2021 at 09:54:16PM +0000, brian m. carlson wrote:
> > > I know "rev1..rev2" and "rev2 ^rev1", but I prefer to use "rev1 --not
> > > rev2 rev3" instead of "rev1 ^rev2 ^rev3".
> >
> > I don't think a personal preference is a good reason to change this.
>
> I do think it rises slightly above personal preference. It's potentially
> making things much easier for the caller if they can ferry along:
>
>   tip=3D$1; shift
>   git rev-list --end-of-options "$1" --not "$@"
>
> instead of:
>
>   tip=3D$1; shift
>   # whoops, whitespace splitting is wrong here! Real programming
>   # languages make this easier, of course.
>   git rev-list --end-of-options "$1" $(for i in "$@"; do echo "^$i"; done=
)
>
> Though in my experience it is usually a static "--not --all" or "--not
> --branches --tags" or similar in such a function. I don't think I've
> ever seen a case quite like the code above in practice.

Last week, I made a study on how gitlab wrap and execute a git
command. I saw the following code [1]:

    if c.supportsEndOfOptions() {
        commandArgs =3D append(commandArgs, "--end-of-options")
    }
    if len(postSepArgs) > 0 {
        commandArgs =3D append(commandArgs, "--")
    }

I was surprised to see the options "--end-of-options" and "--" used
next to each other, and the DashDash option ("--") is not mandatory. I
want to make some changes on it, but when I try to construct a git
command like this:

    git.SubCmd{
        Name: "log",
        Flags: []git.Option{
            git.Flag{
                    Name: "--stat"
            },
            git.ValueFlag{
                    Name: "--pretty",
                    Value: "%m %s",
            },
            git.Flag{
                    Name: "--no-decorate",
            },
        },
        Args: []string {
            "topic1",
            "--not",
            "main",
            "release",
        },
        PostSepArgs: []string {
            "src/hello.c",
            "doc",
        },
    }

The generated git command will be:

    git log --stat --pretty=3D"%m %s" --no-decorate \
        topic1 --not main release \
        --end-of-options \
        -- \
        src/hello.c doc

It works. But if I move the "--end-of-options" before the revisions like th=
is:

    git log --stat --pretty=3D"%m %s" --no-decorate \
        --end-of-options \
       topic1 --not main release \
        -- \
        src/hello.c doc

The generated command failed to execute with error: unknown revision "--not=
".

It's reasonable for gitlab to construct git commands using mainly three fie=
lds:
1. Flags: for options like "--option", or "--key value".
2. Args: for args like revisions.
3. PostSepArgs: for pathspecs.

And if the command supports these options, it's better to add
"--end-of-options" between 1 and 2, and add "--" between 2 and 3.

If we can handle revision pseudo opts as pseudo revisions instead of
options as in this patch, the only disadvantage is that we cannot
handle branches whose names conflict with well-known options such as
"--not" and "--all". But users can input full branch names, such as
"refs/heads/--not", "refs/heads/--all".

Maybe I should keep this patch as a local enhancement for git.

1. https://gitlab.com/gitlab-org/gitaly/-/blob/v14.0.5/internal/git/command=
_description.go#L320-326

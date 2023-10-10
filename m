Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 605EECD80C1
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 12:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbjJJMoL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 08:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjJJMoJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 08:44:09 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5A2A9
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 05:44:08 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9ada2e6e75fso1020367166b.2
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 05:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696941846; x=1697546646; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fUH7RjvsTkWd1vRc5g0fLC4FR4Z220cCZ+fjGauHUiQ=;
        b=IM0ouIrVSv6h/aLtUQ20pWnhjSVomdfloyjCNgOEywoGijauH+RYjsYoisjbIroz/0
         2TD0pfOjwcezA0C2kQXKdDyjUvJGgvsiVDlkEQwDW8ZEfY3fB3mx909nVSD6nAXfGK4+
         7gGuYfdNnO0mvb1wtG7lM8iq4jhsnjQdJL0bFlsmKRCnXcvNhtPnKmpNpddCNHWoXAvg
         oieYSugDXDZiW16rvCB0/OxeDhD9FdvrfSvot6FWK/2i2XZpKxUjp3fPtfVHdFy/DwSV
         46QIvn9Iw6BZ91fO36RbceyCJGoUUMStQ5ZpEf668u3UuRtvqMG1ZV1S47rnG1eZxarX
         xebA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696941846; x=1697546646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fUH7RjvsTkWd1vRc5g0fLC4FR4Z220cCZ+fjGauHUiQ=;
        b=YfeSU0lmfFSmSgSk4UFqKS+nBpZawrzEv5730cCMquaJ0f4Lns/PyvCFfEqA3oedYX
         1eU1ZkCP/0lk+0HdY41hb3ewenJAn+Rz6pAbSpYjrPXceWLOa7yd54coKJw36KRrrF6I
         AAMGX1rn9pvN30RSSDj7RySJRzCKgFop1RS4WFYiBjINZ70SkCoaXbYbInPJGbC27p/X
         x1bADd84I3Xn6khMw5Jz+7BWwbItkvVJO8sWAerGEOs4eGRvjds1vf27V4nf9UU5S4QO
         dsNozzp41VUM0N36Y7ai6fiQchXwiwwEvdgZefVfaSamQln5W67EilX2ejKdUnwwaaNL
         yZMg==
X-Gm-Message-State: AOJu0Yz0biC3EjNi0S7lXRoJUppvGBwjFFRX4/Havktq3jbUfkbhRyFI
        7lUb0TaB1J5XmNynzvLoG2zWQC/18fyL6Z4Issg=
X-Google-Smtp-Source: AGHT+IFgESpangC9pyI6j1RyVTvSg67fbRsu7a+nCRZzVaiernA5P2mAZTYpvLljoojhM0YK1NusxfAGCjSaP7CN9Sc=
X-Received: by 2002:a17:906:5342:b0:9ad:ef08:1f32 with SMTP id
 j2-20020a170906534200b009adef081f32mr16355829ejo.37.1696941846380; Tue, 10
 Oct 2023 05:44:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230602102533.876905-1-christian.couder@gmail.com>
 <20230907092521.733746-1-christian.couder@gmail.com> <20230907092521.733746-7-christian.couder@gmail.com>
 <58daa706-7efb-51dd-9061-202ef650b96a@gmx.de>
In-Reply-To: <58daa706-7efb-51dd-9061-202ef650b96a@gmx.de>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 10 Oct 2023 14:43:54 +0200
Message-ID: <CAP8UFD0QhNzWims9i2tz1XsDjQEApecXZEfC-vmEHopqZun81w@mail.gmail.com>
Subject: Re: [PATCH v4 06/15] replay: don't simplify history
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Toon Claes <toon@iotcl.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Thu, Sep 7, 2023 at 1:02=E2=80=AFPM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Christian & Elijah,
>
> On Thu, 7 Sep 2023, Christian Couder wrote:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > Let's set the rev walking options we need after calling
> > setup_revisions() instead of before. This makes it clearer which option=
s
> > we need.
>
> In light of the currently open issue about command-line validation, this
> change does more than this paragraph lets on: It hardcodes certain
> settings, overriding (silently) any rev-list options the user might have
> passed.
>
> Is there any chance that we can avoid this change?

In the version 5 I just sent, I have changed the commit message and the cod=
e.

The commit messages says:

"
   replay: change rev walking options

   Let's set the rev walking options we need after calling
   setup_revisions() instead of before. This enforces options we always
   want.

   We want the command to work from older commits to newer ones by default,
   but we are Ok with letting users reverse that, using --reverse, if that'=
s
   what they really want.

   Also we don't want history simplification, as we want to deal with all
   the commits in the affected range.
"

So about "revs.reverse" the code is now:

  revs.reverse =3D !revs.reverse;

which seems to be what you suggested elsewhere.

Apart from that I think it's fair to enforce some values for a few
options. This way we can make the command work the way we want by
default, get consistent behavior and avoid users shooting themselves
in the foot for now. If more flexibility is needed and useful in the
future, then we might allow it in future patches with proper
justification, tests and docs. There is still a lot of flexibility
left especially as the patch that disallowed some rev walking options
and pathspecs has been removed as you suggested.

> > Also we don't want history simplification, as we want to deal with all
> > the commits in the affected range.
>
> This, however, is a good change. It deserves to live in its own commit,
> with its own commit message, in particular because it is not obvious from
> the attribute names which ones we're talking about (I guess it's `limited=
`
> and `simplify_history`, not just the latter.

We only enforce "revs.sort_order", "revs.topo_order" and yeah
"revs.simplify_history".

Also I don't think it makes much sense to separate these changes in
different commits/patches. I am Ok to improve the commit message if
you think it's worth it, but the patch series is designed to make it
easy to review the changes from the "fast-rebase" test-tool to a good
"replay" plumbing command, and I don't think separating those related
changes would improve things much.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F01FC41513
	for <git@archiver.kernel.org>; Mon,  7 Aug 2023 12:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbjHGMlj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Aug 2023 08:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbjHGMlg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2023 08:41:36 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8774D198C
        for <git@vger.kernel.org>; Mon,  7 Aug 2023 05:41:18 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5217ad95029so5771912a12.2
        for <git@vger.kernel.org>; Mon, 07 Aug 2023 05:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691412077; x=1692016877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3WAg1RuHcVV57r87tCfBhq/34ErXgZFM6P5HbvZa7ho=;
        b=nxxkDIi0BDliao/OE6h8CzbAxHwNlxONXnr4O/aw6wYjfDSAOJFu5NZSXW7SdqCyDB
         ML/AR98npjBw6n1r6K3/aI8NFbJWFJ5AxRuRHKedYbnQ1BLHFo4pjsOxAMk4mtzsqlKg
         4yz1F6PEe3GyNT4L9D1eQIK4p7f06jNtv5tWMe8RWKYu9MpYgfsYdmXvgwViTi7YG5/V
         0DE2y2FRzI3X5RQAY1+plbV2g6mVk8j1H55EXSuwrgPndCQYycFsopPjs0dtgIpxeZzd
         AGzkd994B50Knd7a1y6YSMF7lgSPnnwP/HGgynk6MYr4o7OtkpvBUDw6wQrFvAQKX7Ov
         fTLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691412077; x=1692016877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3WAg1RuHcVV57r87tCfBhq/34ErXgZFM6P5HbvZa7ho=;
        b=kIV4GuNMAqPv1WL1B2PGmYPMHYLL5kvoLiJ34PgwJVf4S1dki86XrU1ru+ULC8wj9y
         p26wDI2OjDKnsDY7ULqPBCqp5RSLUKWnjiEFHmdW2EoIgZMBgUsJm5P+TWVDth7JkzlO
         UNmejrhI2M/jAEsPMUyrtp7oC5bKdn+x6zUEAa5zqPqGtqJXomkhiICXlZeFr4SVUqZQ
         2PB41rt56tjZwzLTPYYuoYrQlH9U4CrqxyKiZuah5wLJEdTNKvuJKqnlpbDyS4L1mb6z
         iD1n1gg5186sxjGcVne7PjwC5KKaPBOFHf/FAZ+vhfzJCeFOgWL0R4YO+gSEpnxbGWSQ
         yJTg==
X-Gm-Message-State: AOJu0YwnnuglgyU2BdTUzxo579Ouu+a/w0pR5veZ7u6h/Uynw6k6A8Sl
        L2EDtV/jX1drXaWp0HwRzAmeNk5K1Wy87tRtTaA=
X-Google-Smtp-Source: AGHT+IHtSeUmYx0NbOpQ5LSUGPcJaVwV3i83V63Lx60wI4pC1ahcL9Y6cIGDvqeZwsofVDNWZneDtTeNmZBnIhmbqdk=
X-Received: by 2002:a50:ef0c:0:b0:523:9c4:544f with SMTP id
 m12-20020a50ef0c000000b0052309c4544fmr7398186eds.31.1691412076561; Mon, 07
 Aug 2023 05:41:16 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqfs518gdh.fsf@gitster.g> <CAP8UFD1vuB2kRr890B7GXum9HAMjRep86zy2tE4yE2C3W5QGHA@mail.gmail.com>
In-Reply-To: <CAP8UFD1vuB2kRr890B7GXum9HAMjRep86zy2tE4yE2C3W5QGHA@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 7 Aug 2023 14:41:04 +0200
Message-ID: <CAP8UFD2Fw+oGz4VK=_i3B_D_VMQqMoXTJPpXRbkDiWjHciEqJw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Aug 2023, #01; Wed, 2)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        John Cai <johncai86@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(Sorry I somehow forgot to put the mailing list in Cc: of this.)

On Fri, Aug 4, 2023 at 10:15=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Wed, Aug 2, 2023 at 10:55=E2=80=AFPM Junio C Hamano <gitster@pobox.com=
> wrote:
>
> > * cc/repack-sift-filtered-objects-to-separate-pack (2023-07-24) 8 commi=
ts
> >  . gc: add `gc.repackFilterTo` config option
> >  . repack: implement `--filter-to` for storing filtered out objects
> >  . gc: add `gc.repackFilter` config option
> >  . repack: add `--filter=3D<filter-spec>` option
> >  . repack: refactor finding pack prefix
> >  . repack: refactor finishing pack-objects command
> >  . t/helper: add 'find-pack' test-tool
> >  . pack-objects: allow `--filter` without `--stdout`
> >
> >  "git repack" machinery learns to pay attention to the "--filter=3D"
> >  option.
> >
> >  Breaks CI with some environment variables configured.
> >  cf. <xmqqo7jzh9mh.fsf@gitster.g>
> >  source: <20230724085909.3831831-1-christian.couder@gmail.com>
>
> I am working on this and hope to send a version 4 soon.
>
> > * cc/git-replay (2023-06-03) 15 commits
> >  - replay: stop assuming replayed branches do not diverge
> >  - replay: add --contained to rebase contained branches
> >  - replay: add --advance or 'cherry-pick' mode
> >  - replay: disallow revision specific options and pathspecs
> >  - replay: use standard revision ranges
> >  - replay: make it a minimal server side command
> >  - replay: remove HEAD related sanity check
> >  - replay: remove progress and info output
> >  - replay: add an important FIXME comment about gpg signing
> >  - replay: don't simplify history
> >  - replay: introduce pick_regular_commit()
> >  - replay: die() instead of failing assert()
> >  - replay: start using parse_options API
> >  - replay: introduce new builtin
> >  - t6429: remove switching aspects of fast-rebase
> >
> >  What's the status of this thing?
> >  source: <20230602102533.876905-1-christian.couder@gmail.com>
>
> I have a 2 week long vacation starting soon, so I will likely not have
> time to work on a new round in the next 3 weeks.
>
> However in a recent article
> (https://github.blog/2023-07-27-scaling-merge-ort-across-github/)
> GitHub says that they are already using git-replay (though not sure
> it's this exact version or another one), and GitLab plans to use it
> too. So I guess it's worth keeping.

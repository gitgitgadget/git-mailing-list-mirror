Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF07C433EF
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 20:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347932AbiBKUMC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 15:12:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiBKUMB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 15:12:01 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E46C55
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 12:11:58 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id n24so11292103ljj.10
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 12:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s3PWaRjGm1ATWBW2RozMWlUkD/oKtHKMSm10R3s/IqI=;
        b=M9jBfiMZ9KIp7PUwZxKbNmSxAkcWpw+ps5gIe/7S30L58YEJuDbJyjGYDJkjR/Xp1a
         4lh+9UXpu+qHtMBzEVGL/Lv8Qabhv7gCD9drZ8Ea1sEndjBZPI7O15q4m94O8z+Qallx
         GBkzszGMoS7UM02EcqBfr5jL1UiI5Jj6A3I6jftlGyhQajWYWxRQtkND1W5qAFtripTU
         pNXDIJFx2C1CjHB2w/o+DSMgYxFFz9fbZoegU0t/yO23BOOk8Cnr/hbAMcZx8r/AUazy
         9MV1qgzlI7BHYf/BoYV8B8LcdumjspEKph2VlYW/ONnJs+7mISfNjY0xEpib8hmiF0UA
         jYPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s3PWaRjGm1ATWBW2RozMWlUkD/oKtHKMSm10R3s/IqI=;
        b=pwSnWFJ14hIrZpoiQMu2+MfCvc83/zmLUs7/4S0+QXAOO85l5h5aoJc1shvTctxFvJ
         O9zyV2bk3oDAMV42p4JTUDmqbQpA6Vvdkuj4nLKE2B+GZt9y2Clzbj9F7SKlvEolWbYE
         X4nw8FeFlW+MvQBNf/h9DEb4ERm+/66P0YS30O+JiJ9qZFzvPsLK8ffPqOLHRJwirJId
         LhCgCvUm4gU6KRyEeijB2UaEnnHI28bJR2Tr+8gsszqJUxFrusKYJ7WLlEqOvlaFRdRK
         Db0GK6Yk4Mz4973p28uok2+GzyPMDVfaykCnAXl0Z8rBZl6JHvasvcCkb1mgtTif8qiU
         lfSQ==
X-Gm-Message-State: AOAM533YNJMhTtY4jvEwg+A9iHru/wbQN9xmjyjyV/PeObvtuEMW7Xw7
        2iTBTPCSlHKD9nHkRjlEsiqrW15yTZI0hjAgW0I=
X-Google-Smtp-Source: ABdhPJwNekFQlpuC/umObMb+JyWrKILUJErZxJaqvCxoJGN7KgTRycQf7VOShGlV4o1qZ9KuqHDL9pj68ofbubiQqwU=
X-Received: by 2002:a2e:bf14:: with SMTP id c20mr1973249ljr.392.1644610316803;
 Fri, 11 Feb 2022 12:11:56 -0800 (PST)
MIME-Version: 1.0
References: <20220211163627.598166-1-alexhenrie24@gmail.com>
 <20220211163627.598166-4-alexhenrie24@gmail.com> <xmqq1r09clxl.fsf@gitster.g>
 <CAMMLpeTBstt8qo2q6r=YCEi-h-G-EkjY=d7kHKeepzTvz1gmJg@mail.gmail.com>
 <xmqq5yplb46m.fsf@gitster.g> <xmqqwni19nrd.fsf@gitster.g>
In-Reply-To: <xmqqwni19nrd.fsf@gitster.g>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Fri, 11 Feb 2022 13:11:45 -0700
Message-ID: <CAMMLpeQJ69i6OCGtbu7sV5rAzg4Od3fOsREMDRDW0vD+m3L3HA@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] gitk: pass --no-graph to `git log`
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>, paulus@ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 11, 2022 at 1:00 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Alex Henrie <alexhenrie24@gmail.com> writes:
> >
> >> What if we make log.graph=true also require feature.experimental=true?
> >
> > No.  feature.experimental is to give people an opt-in opportunity
> > for features that we are considering to enable by default.
> >
> >> The log.graph option would really be a useful feature for people who
> >> use Git exclusively from the CLI without any external tools. It seems
> >> that the main challenge is how to give others time to adjust.
>
> Let me clarify the first point by stating it a bit differently.
>
> feature.experimental is all about this:
>
>     We have an idea for this new feature.  We made it useful, and
>     also made it not to regress the end-user experience for those
>     who do not need the new feature, to the best of our ability.
>     But there may be use cases we failed to consider while doing
>     so.  So let's ask early adopters, who may use Git in contexts
>     that are very different from ours, to try testing it out in
>     their daily use, to see if there are unexpected glitches.
>
> You do not have to argue how the --graph feature may be useful for
> character terminal users.  We already know it is, otherwise we
> wouldn't have added it in the first place.
>
> And arguing how --graph feature is useful does not help prove
> anything, when at the issue is if it is a good idea to allow the
> log.graph configuration variable to affect (unfortunate) scripts
> people wrote around "git log", instead of using plumbing commands,
> negatively.  We already know it will hurt to force everybody to
> update their script to explicitly pass --no-graph on the command
> line.  This series hasn't done any of the "not to regress to the
> best of our ability" part.
>
> If there were an agreement on the general direction to _forbid_ use
> of "git log" in scripts, which would require coordinated efforts to
> help people migrate over time, e.g.
>
>  - improve plumbing by adding features that people piled only on
>    "git log" without allowing plumbing users the same over time.
>
>  - perhaps an automated way to convert scripts that use "git log" to
>    instead use "git log --no-graph"
>
> to help script writers migrate away from "git log", adding log.graph
> configuration variable may become very a good idea.
>
> But without such effort starting at the same time and gaining
> consensus (or already underway), just adding such a variable to
> break existing scripts would not be a good idea worth asking the
> early adopters to test.  We already know it would break scripts.

Okay. Thanks for the explanation!

-Alex

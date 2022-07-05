Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCC3C433EF
	for <git@archiver.kernel.org>; Tue,  5 Jul 2022 18:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiGESnt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jul 2022 14:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiGESns (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jul 2022 14:43:48 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461AA13DE0
        for <git@vger.kernel.org>; Tue,  5 Jul 2022 11:43:47 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id l40-20020a05600c1d2800b003a18adff308so7988903wms.5
        for <git@vger.kernel.org>; Tue, 05 Jul 2022 11:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2UzWsK/w3mriJXqK7aItQF+fDljBgMNqyxhBLe6xlZ8=;
        b=AIkEfYMJUrJhapmmDpUK4ZAsmHnw+GMZwv7rCKMbXCxlSKbbsr7F4GEiZ2z2SRkaWC
         2UC3Jwtq5s9KoqiyZupLjDd7fTNDlLbxdHBjdrpKOJBmkcOyQ59JEqaOq9QzYpoVceZX
         ttoNnZNVH/EEGTJQQzTm9Fi8lB0rZ/5AqUdbI/B5TFD33pua9F3ZqCC/6w9O6fqQQUkR
         B4278D2HHPPs1HgxHiJv2vqFrGlejQkjutPP2KFmMa233MG3BqUbviBMuqPy5kPqZtUA
         /QJb/sMQDipJXBdNddb0GuburyvO9GN3u73FBwraB+SOykOa/+msSuma3VyrA1vcHukb
         syKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2UzWsK/w3mriJXqK7aItQF+fDljBgMNqyxhBLe6xlZ8=;
        b=7jA4MnwdyArEl8T849vIA5EVbC4C6k1QzxaeehAUb1hRQ6eBoo/yvA/1/4oZnm7jlR
         qXPM8lN1JupfCZ9tVVXwkBLBQJ/gFH0nuPsZs7zKlXYMuxHA/1yH4k8gHop9AuB1C1Zw
         NIyDa05zyLLpXJtJ63tEUx6+feNT8evaOYrB4iedCgCoQoLx8zyYexs9w0SwN8eMtokF
         GBFwatBB8dt4XiXngXjw88lPE84/RC/FRh59YddPHurhRkOypOYVHaFWpqihHnvHJLaW
         46jvmb/9lwmu4PYQYxzlviCMdyIQcqnoTi80Wpy3lprVGjajzvW8arCliWac8SaYixeI
         L3NA==
X-Gm-Message-State: AJIora9sb7W+ykFos+mkrdAoLKZHJAsKN3gsoOewkU5c3f77ZB3A8oq8
        ur69h6e4FOEvQcu+ODeza/lmfZEvlq57ZSE23mg=
X-Google-Smtp-Source: AGRyM1sQtFYa1JSh4S9i2MV0rjJnZNYIYDnmr3qKPbB4XAk58e1SydJ8FvO1id4tQA4n18He6Hj6GWHo5B9Mq1d/NWY=
X-Received: by 2002:a05:600c:3492:b0:3a1:70dd:9a14 with SMTP id
 a18-20020a05600c349200b003a170dd9a14mr35292382wmq.177.1657046625704; Tue, 05
 Jul 2022 11:43:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAKQoGamCrRMqtzziuzi8mL6E7uA3SC1WXiMGT_4rpbk1jcu_OQ@mail.gmail.com>
 <YryF+vkosJOXf+mQ@nand.local> <CAKQoGakSFaNm10ZeTKc8XtTcD0JW19CZP1OwA4j7W__iBQaJfg@mail.gmail.com>
 <YryKCl5J1Em89d3e@nand.local> <CAKQoGanPBec6wRO6uWrETaoJXdszpjRWytXaJwx6jw0mrrj-gQ@mail.gmail.com>
 <Yr0WLebMfBXZ1K7D@nand.local> <Yr0XMWWyD5C9uhlb@nand.local> <xmqqletdewrf.fsf@gitster.g>
In-Reply-To: <xmqqletdewrf.fsf@gitster.g>
From:   Gregory Szorc <gregory.szorc@gmail.com>
Date:   Tue, 5 Jul 2022 11:43:34 -0700
Message-ID: <CAKQoGakLzF+bvSnU7JD7yBibmYe0-8j3eo+CgN7EchUiNc2NkA@mail.gmail.com>
Subject: Re: Race condition between repack and loose-objects maintenance task
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        stolee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thinking about this some more, it is clear that running `git gc` /
`git repack` *and* `git maintenance` simultaneously is prone to
badness since their locking mechanisms aren't aware of the other.

I think it makes sense to consolidate onto `git maintenace` going
forward as this seems to be where the inertia is. However, a barrier
to that for me is the objects/maintenance.lock file has no acquisition
timeout and will wait indefinitely. So in scenarios like mine where
you have multiple processes looping over repos invoking `git
maintenance run`, you can have extended execution stalls during
long-running operations like `gc`.

There should probably be a configurable timeout for the maintenance
lock like there is for other locks. This shouldn't be too much work
and I may throw up a patch if others feel this is a good idea.

On Thu, Jun 30, 2022 at 1:12 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Taylor Blau <me@ttaylorr.com> writes:
>
> > On Wed, Jun 29, 2022 at 11:19:09PM -0400, Taylor Blau wrote:
> >> > However, I think there is yet another bug at play: running
> >> > `incremental-repack` appears to be able to repack the cruft packfile.
> >> > In doing so, it deletes its .mtimes file and the metadata inside.
> >>
> >> That sounds like a bug to me. I'll take a look into it and see what I
> >> can find.
> >
> > I actually think that there are two bugs here.
> >
> > One is that we run a MIDX repack and expire, which could lead to us
> > repacking the entire contents of the cruft pack and then expiring the
> > metadata file. This is a bug, and we should exclude cruft packs from
> > this computation.
> >
> > Another bug can happen when the cruft pack gets written into the MIDX
> > and is MIDX-expireable (meaning that no objects are selected from the
> > cruft pack). In that case, the `git multi-pack-index expire` step would
> > remove the cruft pack entirely, which is also incorrect.
> >
> > I'll take a look at fixing both of these, and thanks for pointing them
> > out!
>
> Thanks, both.
>
> The fact that the semantics of the .mtimes file being not equivalent
> to the mtime on individual loose objects does not help thinking
> about the possible ways the "cruft" pack can break, and both of the
> possible issues you discuss above are indeed tricky ones.
>
>

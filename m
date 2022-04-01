Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2C4C433EF
	for <git@archiver.kernel.org>; Fri,  1 Apr 2022 10:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344862AbiDAKDP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Apr 2022 06:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239929AbiDAKDO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Apr 2022 06:03:14 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84C126C561
        for <git@vger.kernel.org>; Fri,  1 Apr 2022 03:01:24 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id g20so2333760edw.6
        for <git@vger.kernel.org>; Fri, 01 Apr 2022 03:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=+Ull3Nd2UOKKlwgRFQja+K4pKfqMwNJh2l6jdMFHhh0=;
        b=pIXFumUdMRQY6z96wzEPMU2BOFJCvDh8k5T1XroFiGdhO7ifATTjupsS1ZLRDWmzTv
         Glw70E0ooE6KoNISIVVESRRkHMJQ/EISG7fB/f1N9XKWdOX4WlJQPW4TELxDcedVuNMO
         klfBHo6H24+3axFRRjwZnQTmQN/vcyPzSnIqGS4OjU82+RSq7p/tQC2hAo2kIudYcRyU
         221R5kIRxYko2ON7E7AslnRXeW1YSECx0NMYzUKfaOrfCTiC67KOKmD0njVnLIcC/wL+
         w07uA4o68I61zcLNP+mSCKa+vsxyb9haGA1C5RgvBi0/aQk0ozAXHS/gGiLD/FZRpvB/
         jJMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=+Ull3Nd2UOKKlwgRFQja+K4pKfqMwNJh2l6jdMFHhh0=;
        b=qtb3ny+Jfnu6JBFXSiXvTDvCqEH0+c+r4/pIvsbz5qlkSOZmS+ly7U+sEkbxz8gIdL
         NnxV8edask4Ps0f2hsG2NoLyKi1q5WjvT7Wy29X7M1KRIolxDPnXF36OCkz0eotlZ+sI
         GdP3oUTKwTofqq0nNKib0ZAQHQ8xMT/qKj1QiNiLETkCKhKtpk1Hyll4Lsux2G2I7fCJ
         ZswEOu2D7uM9qPVYJgp685QS8HzFWCZELAnasLG/QEeF4rEFozw6AHeUDT2JGOlBoPCp
         SFgSI4RhQliQ4nU0fDGVCMplqjgc3Hk4DwVezz79nOTBs3XcBFO3wFjPNhTlsPYcFbw1
         N8Ew==
X-Gm-Message-State: AOAM5306wkzataTPchytcnCq+7NZGvcRHKpR1FSMWsopkmEKljEY1AVM
        Tek5q9BSsJ2L5x0sZmtYPAyH7FUcjRI=
X-Google-Smtp-Source: ABdhPJx5kwHYPTdmF6VZkT88vN02IRbHWn5tReLLFAxI899IiQ+IZ9fb4BI0BzhoZ8CV/0+qP/ILDw==
X-Received: by 2002:aa7:d445:0:b0:41b:5835:c6da with SMTP id q5-20020aa7d445000000b0041b5835c6damr17241859edr.309.1648807283275;
        Fri, 01 Apr 2022 03:01:23 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id m24-20020a170906161800b006d420027b63sm852786ejd.18.2022.04.01.03.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 03:01:22 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1naE5q-0010Rx-DE;
        Fri, 01 Apr 2022 12:01:22 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Miklos Vajna <vmiklos@vmiklos.hu>
Cc:     git@vger.kernel.org
Subject: Re: git log --since to not stop after first old commit?
Date:   Fri, 01 Apr 2022 11:57:33 +0200
References: <Yka2GSGs3EIXm6Xt@vmiklos.hu>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <Yka2GSGs3EIXm6Xt@vmiklos.hu>
Message-ID: <220401.86pmm1nmvh.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Apr 01 2022, Miklos Vajna wrote:

> Hi,
>
> I wanted to look at commits of a contributor from the last year, and
> noticed that I only see commits from this year, not last year when I use:
>
>         git log --author="that person" --since="1 year ago"
>
> Digging around in the history, one other contributor pushed a mistake on
> 1st Jan, where the author date was supposed to be 2022-01-01, but
> happened to be 2021-01-01. Knowing that, it makes sense that 'git log'
> stopped at that commit by default.

So (just making sure I understand this) in this case the --since option
is behaving as expected in the sense that the information in the commit
itself matches what it's finding, but what you'd really like for it to
consider some "adjusted" commit date?

I.e. to be smart enough to spot that it should include a commit from
2021 if all the preceding commits are from 2022, or some other similar
heuristic?

Or...

> I wonder though, is there any option to "force" git log to walk all
> reachable commits from HEAD, but just show the ones which match the
> --since criteria?

...did we stop the walk as soon as we saw that 2021 commit?

> Or is this need so special that the best is to parse the output of 'git
> rev-list' and do my own filtering for author and date?

I think this is somewhere between "we could grow a new feature to be
more helpful" (we adjust commit dates in other places, i.e. commit-graph
reachability), or "a bug" depending on the answersto the above, but I
obviously haven't dug much. Hope this helps!

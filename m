Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97EEC433EF
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 19:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391790AbiDUTMA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 15:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391788AbiDUTL6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 15:11:58 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1165F4CD46
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 12:09:08 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e1so3673314ile.2
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 12:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CmuQE5rxHAk6njBPozI+ms35ZUAeqeIz+hpp7XuY1wQ=;
        b=iqjrT8yP7FAhtMt5l6kg1ibo2q9AeZ2hoOQP5J/lWkH0er6ENV+C0A2IAq5l2F8FJL
         hIINb4qKUfVF+YwtnMwzztI1v3a4EkV9dP3bVyt8d/uou9hd8wJNbtt3g3tpWZ5GtQ0u
         f2JBDkkhY8AGySZfhtAcVeODKBLRJA5aY3B1uF1+JCNbV/vZunAQP69469/pSBO4SKZM
         lfIhaX4rzcJtCM/r+tkCM8qBV1C92cCtqOAPItrK4bUV7I7mRil3Jv808gtBbKIVXXsg
         ek6a4aa4okUE12ROFcAB9pJ8eCmOu/C9wuJzJgtCwizv0m8bKHEhuCTCxZ0UTGIriJyV
         JzFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CmuQE5rxHAk6njBPozI+ms35ZUAeqeIz+hpp7XuY1wQ=;
        b=YDd1Zg4+pFcYllxI0LVm7yyUsQr+SQHNTWDYNR8vrlAquqQR49gNnLFQIF23uxQ9Nv
         O1Sveu/lJ4nDitC/9wl3SBGY85+auPN0mdD/RwgL9Jp+CbKyuIrtPGIkaQSaGoA22eue
         5EXVHhxoYSOU32HjLNO1jUt3W4f6Kpi0zUZ/+WCxI1oTKlebsdNA6fbvFfbfZIRAUT3W
         Ou+4hXXnXD0kjLRokfg4wsX15ef1+4cBJbCoMSZXlFYqCtYyjhARTbhAa5u5HvJlYbdW
         GWknCv1dW2l9Bmk3vfwerMwdZgF6vEdDWrhHggfL1DvMef7M5Xhg3eDVCDFeYI7nABat
         cjXw==
X-Gm-Message-State: AOAM532yuwpO4wv/isQqZEUevSy9JCpKW4pQvKxZ23z+IPb7c05hGGAA
        iMb0qrlKg/7owBMmK1s0DHwPj+QwfiDqe3Ii
X-Google-Smtp-Source: ABdhPJxy2D4Okt8x4IP+ixD0+0HeiqlmDGk+DFq0bIaDRbQaViZXltji7JaLHX3a/VpilGg7v+CckQ==
X-Received: by 2002:a92:640d:0:b0:2ca:ad76:3e88 with SMTP id y13-20020a92640d000000b002caad763e88mr499978ilb.84.1650568147317;
        Thu, 21 Apr 2022 12:09:07 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a9-20020a926609000000b002ca50234d00sm12361705ilc.2.2022.04.21.12.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 12:09:07 -0700 (PDT)
Date:   Thu, 21 Apr 2022 15:09:06 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Glen Choo <chooglen@google.com>,
        Git List <git@vger.kernel.org>, justin@justinsteven.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: Bare repositories in the working tree are a security risk
Message-ID: <YmGr0upicQJML+9B@nand.local>
References: <kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com>
 <kl6lwnfp7tbc.fsf@chooglen-macbookpro.roam.corp.google.com>
 <Ylobp7sntKeWTLDX@nand.local>
 <CAJoAoZkgnnvdymuBsM9Ja3+eYSnyohr=FQZMVX_uzZ_pkQhgaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJoAoZkgnnvdymuBsM9Ja3+eYSnyohr=FQZMVX_uzZ_pkQhgaw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 21, 2022 at 11:25:39AM -0700, Emily Shaffer wrote:
> On Fri, Apr 15, 2022 at 6:28 PM Taylor Blau <me@ttaylorr.com> wrote:
> >
> > On Fri, Apr 15, 2022 at 05:41:59PM -0700, Glen Choo wrote:
> > > * We want additional protection on the client besides `git fsck`; there are
> > >   a few ways to do this:
> >
> > I'm a little late to chime into the thread, but I appreciate you
> > summarizing some of the approaches discussed so far. Let me add my
> > thoughts on each of these in order:
> >
> > >   1. Prevent checking out an embedded bare repo.
> > >   2. Detect if the bare repo is embedded and refuse to work with it.
> > >   3. Detect if the bare repo is embedded and do not read its config/hooks, but
> > >      everything else still 'works'.
> > >   4. Don't detect bare repos.
> > >   5. Only detect bare repos that are named `.git` [1].
> > >
> > >   (I've responded with my thoughts on each of these approaches in-thread).
> >
> >   1. Likely disrupts too many legitimate workflows for us to adopt
> >      without designing some way to declare an embedded bare repository
> >      is "safe".
> >   2. Ditto.
> >   3. This seems the most promising approach so far. Similar to (1), I
> >      would also want to make sure we provide an easy way to declare a
> >      bare repository as "safe" in order to avoid permanently disrupting
> >      valid workflows that have accumulated over the past >15 years.
>
> I'd like to think a little more about how we want to determine that a
> bare repo isn't embedded - wantonly scanning up the filesystem for any
> gitdir above the current one is really expensive. When I tried that
> approach for the purposes of including some shared config between
> superproject and submodules, it slowed down the Git test suite by
> something like 3-5x. So, I suppose that "we think this is bare" means
> refs/ and objects/ present in a directory that isn't named '.git/',
> and then we hunt anywhere above us for another .git/? Of course being
> careful not to accept another bare repo as the "parent" gitdir.

Definitely worth considering. Fundamentally I think if you're going to
allow checking out embedded bare repositories (which I strongly think
that we should), any search for "is this repository embedded in another
one?" needs to walk along its entire path up to the filesystem root.

I'd think that we could offer some tools, perhaps "safe.boundary",
specifying a list of directories to halt our traversal at. IOW, if you
have a bunch of bare repositories underneath /data/repositories, and
know that they're all safe, you could set your boundary there to signal
to Git "if my path is a subdirectory of anything in safe.boundary, then
I don't care whether the repo is embedded or not".

> Does it work for submodules? I suppose it works for non-bare
> submodules - and for bare submodules, e.g.
> 'submodule-having-project.git/modules/some-submodule/' we can rely on
> the user to turn that flag on if they want their submodule's config
> and hooks to be noticed from the gitdir. (From
> 'worktree-for-submodule-having-project/some-submodule' there is a
> '.git' pointer, so I'd expect things to work normally that way,
> right?)

I don't enough about submodules to comment here, sorry.

> > Here's an alternative approach, which I haven't seen discussed thus
> > far: [...]
>
> Nice - a more strict spin on proposal 3 from above, if I understand it
> right. Rather than allowing any and all bare repos, avoid someone
> sneaking in a malicious one next to legitimate ones by using an
> allowlist. Seems reasonable to me.

We'd probably want to allow saying "all embedded bare repositories are
safe to read config/hooks from", too. I hadn't considered this approach
as a way to read some embedded repos and not others; I suspect the
overwhelmingly common use-case would be: `git config --local
safe.embeddedRepo '*'`.

Thanks,
Taylor

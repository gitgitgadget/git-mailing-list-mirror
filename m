Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB81CC43334
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 17:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbiFHRZK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jun 2022 13:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbiFHRYw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jun 2022 13:24:52 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B8E9FE6
        for <git@vger.kernel.org>; Wed,  8 Jun 2022 10:19:38 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id a21-20020a9d4715000000b0060bfaac6899so6777812otf.12
        for <git@vger.kernel.org>; Wed, 08 Jun 2022 10:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=33YgvaZMAgNVz2Qc2pTj1qmiY/Df5w1E+rwWi1ARmLY=;
        b=CWRk65DeKvm8DHRLRJziQS2qnXP8hlclvpWBNeNeOBZ0yhYyn4/MTeXJpLjdf2mOki
         UUsHs/6YoijXwlDUyxtaJReA+C5seItQZjUB6oFycQ7NI/lzJCUFbKoc8e8PiC86T6im
         yDpwf7Ud0d1mEG6YHWq4zj2KHpj2Fy6iTh7JrXAW8Z2TwW9XBdJHrL9ENu+0iHZbwfIt
         PjFm7sXIoSne5uEbNi0+1Zzu3MC+VeMl8WeYAz3HDWIrNMpQypsaaJHGQkqfk0Io0ZcK
         MGZqN+EmZXx0Beoffg9OZ6POy4bJDEAV3jbEAPUeWiyD/sfGpulmzE4ijNXSnvneXsKc
         AY4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=33YgvaZMAgNVz2Qc2pTj1qmiY/Df5w1E+rwWi1ARmLY=;
        b=L4fpD4Ro69zVJG5bAcTakBmrkRSXj0/iglKd8OfIGzzFJ1B9cqvbnBuNKB9c2+QzJM
         jsfM02IUXWk7VaJZD3HCORdfWUUjYaiBqmtbFDDq4ga2/Vk0AwPKde9Ndtthxq5Hhpwl
         owZ2rLRANJzsYjQUoNA3fsDClqbmEbDEQOXUqeT/ujxU1hTpy76uasBRiWozWOi1ZOsI
         MRBBZZ7g9iMIn5CQGUdW2P9z0MBwSa9A9UeguFlVsk3T1RDn/RI/nNzxPE+8I23JDDVe
         nTw6/S12wfsZW3eqqqaNj8jlBB524L0EPT9FWaqQO2FEH2KfhBVIa4wvP/tvwPMI/g+M
         nQmg==
X-Gm-Message-State: AOAM531D6WemxShn80fkGuU/l7rr1Fof9ayxZlTRTuCf1HgeXiaHSEvB
        KWUO4tS/LWRTZnH70gFiIohuK+3jV/M1AZ2CFSWkV5koXYVmiw==
X-Google-Smtp-Source: ABdhPJyRyV4kBmz8d5mjf0Cmfrqf10BABt9ChiN66QcPNj3eZaW9SHfweAUwGI6O3GbCDjeGcHvm7IpzELjyppRsoBc=
X-Received: by 2002:a05:6830:345:b0:60b:fd21:47fe with SMTP id
 h5-20020a056830034500b0060bfd2147femr6572344ote.42.1654708777766; Wed, 08 Jun
 2022 10:19:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220606235449.2890858-1-calvinwan@google.com> <xmqqh74x1eol.fsf@gitster.g>
In-Reply-To: <xmqqh74x1eol.fsf@gitster.g>
From:   Calvin Wan <calvinwan@google.com>
Date:   Wed, 8 Jun 2022 10:19:26 -0700
Message-ID: <CAFySSZC0ieObo=CzhoHiqrcdv3335VaRBtYMLFe9oEJ0hucOCA@mail.gmail.com>
Subject: Re: [PATCH] submodule merge: update conflict error message
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, chooglen@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Hmph.  Is 1. necessary?

I just tested it and it is not, so I do agree recommending to abort the
merge is unnecessary/bad advice. How does this sound?

Failed to merge submodule <submodule>
CONFLICT (submodule): Merge conflict in <submodule>
Automatic merge failed; recursive merging with submodules is currently
not supported. To manually merge, merge conflicted submodules first
before merging the superproject.

On Mon, Jun 6, 2022 at 5:48 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Calvin Wan <calvinwan@google.com> writes:
>
> > When attempting to do a non-fast-forward merge in a project with
> > conflicts in the submodules, the merge fails and git prints the
> > following error:
> >
> > Failed to merge submodule <submodules>
> > CONFLICT (submodule):Merge conflict in <submodule>
> > Automatic merge failed; fix conflicts and then commit the result.
> >
> > Git is left in a conflicted state, which requires the user to:
> >  1. abort the merge
> >  2. merge submodules
> >  3. merge superproject
> > These steps are non-obvious for newer submodule users to figure out
>
> Hmph.  Is 1. necessary?
>
> IOW, based on the information we already have (we may not be
> surfacing, which can be corrected), wouldn't it be easier to instead
> (A) go to submodule and make a merge and then (B) come back to the
> superproject, "git add <submodule" to record the result of submodule
> merge, and say "git commit" to conclude?
>
> The thing I am worried most about is that you may be throwing away
> information that would help the user by aborting the superproject
> merge.  Before doing so, you have stage #2 and stage #3 of the
> submodule commit, so which commits in the submodule you need to
> merge in (A) above should be fairly clear.  If you abort the merge
> first, how does the user know which commits in the submodule the
> user needs to merge?
>
> > The error message is based off of what would happen when `merge
> > --recurse-submodules` is eventually supported
>
> OK.
>
> > Failed to merge submodule <submodule>
> > CONFLICT (submodule): Merge conflict in <submodule>
> > Automatic merge failed; recursive merging with submodules is currently
> > not supported. To manually merge, the following steps are recommended:
> >  - abort the current merge
> >  - merge submodules individually
> >  - merge superproject
>
> Again, I am not sure about the recommendation.  The message saying
> "currently not supported" I think is a good idea.
>
> > I considered automatically aborting the merge if git detects the merge
> > failed because of a submodule conflict, however, doing so causes a
> > significant amount of tests in `t7610-mergetool.sh` (and some other test
> > scripts as well) to fail, suggesting users have come to expect this
> > state and have their workarounds with `git mergetool`
>
> With or without test failures, my gut feeling sais that it cannot be
> a good idea to automatically abort the merge, without first grabbing
> some information out of the conflicted state.
>
> Thanks.

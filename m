Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD72A1F597
	for <e@80x24.org>; Mon, 16 Jul 2018 23:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729980AbeGQAZ4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 20:25:56 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:35844 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729615AbeGQAZ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 20:25:56 -0400
Received: by mail-yw0-f193.google.com with SMTP id v197-v6so2421997ywg.3
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 16:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ELUaB+lGeCCDxCVMGt4LQEjV8sYd9QwBGS7/Wcr6CLQ=;
        b=D4cd3OAZGo+pIeHWrc1Hhen/h17nuLBB0jN7XSyNb2d3FAijuBUj/K0MBB4CaZieJ+
         kP/jiWc7wh+qCBo+BxTvHNaUHfdzy17X8dH0dB2zkxDt+eNtx3OGyZDpPpDPWiN2UeYH
         7XhyJIfOBydV2dDkm51ytk7hFHEhgMDY3vkkJcdzefyxfnZ9TMRJWknnMrea2VBLJQQj
         8DQzCvSrkLqtWt92kiIgGe4OyQYxW53KKLXM4nn973fFMKmMfMGahsQfVI+graLcYk12
         FVlSIMaq/UOzNDdxYYJsSduP7M73T3Bfs65xlXa2IGwjIk6Bi4vjQnhvOWWl5H3M7UNn
         5sZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ELUaB+lGeCCDxCVMGt4LQEjV8sYd9QwBGS7/Wcr6CLQ=;
        b=mV14sCCIotiG9jW7MV4qawv5jXcwn9MF+Pk8b7K2OaKSQbL3SjLkvp5A3bqfD9MSLm
         ExeSRr9U23Q2ZfnlgOP677/tLuX3KCr+dW/gpVN7DH0JJ7pJn1XdiKEwzCTn2H/lwD5S
         e+upjCs0SkO5KJuD3E5yDAqDX2fVyemIz7/8GN9elXZYh4s73e2MMnlHsZZshDVR2JUk
         J1syBPj39x1aC4G4d9gyqwVDv0p1vVreEWJin89xFGEZ2isfvwrcurqwdeCUDU/xQTNC
         wbnTHW9sT/DqfXXsWqPENijYBKU/AKWtZVqJDm8FweNb3owQQcbJjzRe7Rj/iAJ/wXlr
         uidg==
X-Gm-Message-State: AOUpUlFuf3OS3jBgEZ5UZG4kkdPRjNGTuiIw730xFIz/MUGhKq7zbKD0
        nlErzg/0S+zt/OyM2UwVjGqjd6lg5p90aEBLD0pZ0A==
X-Google-Smtp-Source: AAOMgpfhdxJiGG1dsJMCgKObbvzvC9mFjbjf98QdkoJgLUZL+sHvgxiqMxQjLAlhGtPbO7etKDyVuhEG8PKFcKtyySE=
X-Received: by 2002:a0d:d342:: with SMTP id v63-v6mr9124637ywd.500.1531785370998;
 Mon, 16 Jul 2018 16:56:10 -0700 (PDT)
MIME-Version: 1.0
References: <20180712194754.71979-1-sbeller@google.com> <20180712194754.71979-5-sbeller@google.com>
 <xmqqo9f7t1jy.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqo9f7t1jy.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 16 Jul 2018 16:55:59 -0700
Message-ID: <CAGZ79kaOy0pZJCob4d=66FQLaOu_q_BAJeFc94xkFa0SSqYigw@mail.gmail.com>
Subject: Re: [PATCH 4/6] builtin/submodule--helper: store update_clone
 information in a struct
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 16, 2018 at 12:37 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Stefan Beller <sbeller@google.com> writes:
>
> > The information that is printed for update_submodules in
> > 'submodule--helper update-clone' and consumed by 'git submodule update'
> > is stored as a string per submodule. This made sense at the time of
> > 48308681b07 (git submodule update: have a dedicated helper for cloning,
> > 2016-02-29), but as we want to migrate the rest of the submodule update
> > into C, we're better off having access to the raw information in a helper
> > struct.
>
> The reasoning above makes sense, but I have a few niggles on the
> naming.
>
>  * Anything you'd place to keep track of the state is "information",
>    so a whole "_information" suffix to the structure name does not
>    add much value.  We've seen our fair share of (meaningless)
>    "_data" suffix used in many places but I think the overly long
>    "_information" that is equally meaningless trumps them.  I think
>    we also have "_info", but if we are not going to have a beter
>    name, let's not be original and stick to "_data" like other
>    existing codepath.  An alternative with more meaningful name is
>    of course better, though, but it is not all that much worth to
>    spend too many braincycles on it.

agreed.

>  * Is the fact that these parameters necessary to help populating
>    the submodule repository are sent on a line to external process
>    the most important aspect of the submodule_lines[] array?  As

In terms of what the submodule--helper does, it is.
It is not the most important aspect in the big picture, or once
we finish the migration to not have shell interpret its output.

>    this step is a preparation to migrate out of that line/text
>    oriented IPC, I think line-ness is the least important and
>    interesting thing to name the variable with.

ok.

> If I were writing this patch, perhaps I'd do
>
>         struct update_clone_data *update_clone;
>         int update_clone_nr, update_clone_alloc;
>
> following my gut, but since you've been thinking about submodule
> longer than I have, perhaps you can come up with a better name.

That makes sense. We do not need to mention 'submodule' as that
ought to be obvious from the file name already and 'update_clone'
is just enough to describe what we are doing.
Although there is already struct submodule_update_clone, which
would be the better candidate for 'update_clone' and this new
struct would be used as a helper in that struct, so update_clone_data

I'll think of adding a patch to rename that already existing struct
(submodule_update_clone -> update_clone) and renaming
this to update_clone_data.



>
> > @@ -1463,8 +1469,9 @@ struct submodule_update_clone {
> >       const char *recursive_prefix;
> >       const char *prefix;
> >
> > -     /* Machine-readable status lines to be consumed by git-submodule.sh */
> > -     struct string_list projectlines;
> > +     /* to be consumed by git-submodule.sh */
> > +     struct submodule_update_clone_information *submodule_lines;
> > +     int submodule_lines_nr; int submodule_lines_alloc;
> >
> >       /* If we want to stop as fast as possible and return an error */
> >       unsigned quickstop : 1;
> > @@ -1478,7 +1485,7 @@ struct submodule_update_clone {
> >  #define SUBMODULE_UPDATE_CLONE_INIT {0, MODULE_LIST_INIT, 0, \
> >       SUBMODULE_UPDATE_STRATEGY_INIT, 0, 0, -1, STRING_LIST_INIT_DUP, 0, \
> >       NULL, NULL, NULL, \
> > -     STRING_LIST_INIT_DUP, 0, NULL, 0, 0}
> > +     NULL, 0, 0, 0, NULL, 0, 0, 0}
>
> The structure definition and this macro definition are nearby, so it
> is not crucial, but its probably not a bad idea to switch to C99
> initializers for a thing like this to make it more readable, once
> the code around this area stabilizes back again sufficiently (IOW,
> let's not distract ourselves in the middle of adding a new feature
> like this one).

Are we still in the phase of "test balloon" or do we now accept
C99 initializers all over the code base?

But I agree to defer the conversion for now.

Thanks,
Stefan

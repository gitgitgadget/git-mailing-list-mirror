Return-Path: <SRS0=1eW7=DV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED02EC433DF
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 15:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 888482222E
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 15:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yqgy6Mjq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbgJNPwk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 11:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgJNPwk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 11:52:40 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7ACC061755
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 08:52:40 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id r4so5860702ioh.0
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 08:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dqaaA19ZU5H6DHuCFWmyUHRZtfBu3doomBovQyzH3Io=;
        b=Yqgy6Mjqib6mAo71rZNh++/lik1WCaTQxWNp5UBFZZ5iVEn8KWj2Oc2vQ6HbLdzqNu
         zWVeW5bcYxCBpjEzsXT5sJQLxvXdMgeUxFyITC7yv8SUaaCS5F6dx0LKy+RwI1QKzr3y
         EOGTK1NYe6jz2a03Gw24+2p+fgvErEsuH3rPJTgIbhkSbCLqYRkvgSjrSfmPEQS+62XC
         jmh9WerzfI0GM52bl7nB2FuMcin1V4zoJhV6L9leHKvxOVRaLVRk9qQb35dowVCrs7Ht
         hvjZxFZ2MdejziS+petamXIwafuBWzejWQdpNC85pNPdEKb9iw2lPuu1Dj2+H6egVhAh
         KS0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dqaaA19ZU5H6DHuCFWmyUHRZtfBu3doomBovQyzH3Io=;
        b=t+gL/wHQp6gBAjMjac9HJwS0WXVUtFCC+WKUl1khNrdTZ805cY9SJoGvkdwxyfYvIJ
         LEGVMvs2J5aZWqRPtI2JktqX0heXZkcWL9w5vmoJvj/Jvq3haOmsv19rN9Mj28Eh+nA5
         77/7zvvUd9UkPhW0AfrY1+gpNZsZdHgMqdqmjGlT9Oayp1+DW0qJMfND2ek0r8t6e+w/
         3i2UzhsWF25EOj+FZeZA3Ti5gsGs8PuPOdi04CZEADb2LAkWImU92lTiBHmxNkMiXG1l
         rceU0eKb/dogYDfd4BtUFwmJVxAmuZLbhHUMCxFZX1rXhaRpptUWfxzkEXrsiXOCyxSi
         B+jw==
X-Gm-Message-State: AOAM5310NpuspNokg/L4SFYZ0pipgdk404+vBsHLfOTtNF9b6bktD9j0
        0D0AEz7JY9/QQhtOEK5q72vMO1IE7t+SGqpCLe0=
X-Google-Smtp-Source: ABdhPJzEsrce2JDaTzePFVblgwY63OEXfRlrMtYrrxzL31WSupDmM1DuYtSEnfUZzOY+m+dJloRwarftA+6skm82Lu4=
X-Received: by 2002:a05:6602:3d5:: with SMTP id g21mr3504958iov.111.1602690759113;
 Wed, 14 Oct 2020 08:52:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAHjREB4gsyOrdnhp0_9rs0wv5q5H47-3RcB3fm5NY+L=3SYnMA@mail.gmail.com>
 <22e3d737-8621-9f20-307e-fc4c2a47ec0c@gmail.com> <CAHjREB59HjZAs98wMPtMANcHUaXGou7CYg9vAacc3m4uz1yUug@mail.gmail.com>
 <7d691f37-b8b7-510d-ba46-51a4a7587226@gmail.com> <CAHjREB6j6BqZ49wX5uqEOiysTAm8Oo7N=EFpcoovWKkBghBjxQ@mail.gmail.com>
 <xmqq362jsahk.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq362jsahk.fsf@gitster.c.googlers.com>
From:   Sangeeta NB <sangunb09@gmail.com>
Date:   Wed, 14 Oct 2020 21:22:27 +0530
Message-ID: <CAHjREB4Qw78xS-T=LA80yVf_u3=Hbpxg5tqBnP1QK44FRkBFOQ@mail.gmail.com>
Subject: Re: [Outreachy] Introduction
To:     Junio C Hamano <gitster@pobox.com>, phillip.wood@dunelm.org.uk,
        kaartic.sivaraam@gmail.com
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey everyone,

I created a PR at gitgitgadget here[1] but it is failing at three
tests of git rm[2].  I looked at the behavior of git status at some
other places( by pausing  'git diff HEAD with dirty
submodule(untracked)' in t/t4027-diff-submodule.sh and looking at `git
status` behavior)  but it was working perfectly fine(was giving what
output was expected). But here[2] I couldn't understand why is it
failing. Can someone please have a look at the PR and give me some
pointers? I know I am asking way out of too much but I tried a lot on
what could have been missing but couldn't find anything.

[1] https://github.com/gitgitgadget/git/pull/751
[2] https://github.com/git/git/blob/master/t/t3600-rm.sh#L691

Regards,
Sangeeta

On Mon, Oct 12, 2020 at 9:27 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Sangeeta NB <sangunb09@gmail.com> writes:
>
> > A fix for making this as the default behaviour can be:
> >
> > --- a/diff.c
> > +++ b/diff.c
> > @@ -422,6 +422,7 @@ int git_diff_ui_config(const char *var, const char
> > *value, void *cb)
> >         if (git_color_config(var, value, cb) < 0)
> >                 return -1;
> >
> > +       handle_ignore_submodules_arg(&default_diff_options, "untracked");
> >         return git_diff_basic_config(var, value, cb);
>
> This function is called for each and every element of configuration
> item in your ~/.gitconfig and .git/config; by definition, the
> default behaviour is what is used when the user did not specify
> anything so what is usually done is to do that kind of defaulting
> before the code calls git_config() with a callback function like
> this.
>
> And more importantly, the users may have
>
>     [diff] ignoresubmodules=<value>
>
> in their configuration file.  After calling handle_ignore_submodules_arg()
> with the value the user desires, the above code will overwrite it with
> a hardcoded default---at that point that is no longer "the default"
> to be used when the user didn't specify.
>
> I am wondering if the init_diff_ui_defaults() function is the right
> location to add the above call.
>
> >  }
> >
> > But this would also involve a lot of changes in the way tests are
> > written as 12 out of 19 tests in t4027-diff-submodule.sh failed after
> > adding this patch.
>
> If the tests expect that the -dirty suffix is added at the end of
> "Subproject commit 2f256705..." when the submodule directory has a
> untracked file, it is expected that such tests need to be updated
> to the new world order you are introducing, which is "just like 'git
> describe --dirty' does not consider having an untracked file does not
> make otherwise clean checkout a dirty one, 'git diff' should not
> show that a submodule is dirty in its output if its working tree has
> an untracked file but is otherwise clean".
>
>
>
> What follows is a note for more experienced developers, but I notice
> that over the years, we seems to have done a shoddy job adjusting
> the implementation in diff.c file in the hope of adding support to
> work in multiple repositories; most file-scope static globals like
> default_diff_options and diff_detect_rename_default are still only
> read while in the main repository, yet repo_diff_setup() pretends as
> if an invocation of the diff machinery in a different repository can
> use settings that are repository specific.  Again, this is not
> something you need to be worried about.

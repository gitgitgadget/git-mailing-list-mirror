Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 785852022A
	for <e@80x24.org>; Thu, 27 Oct 2016 02:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933459AbcJ0CD6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Oct 2016 22:03:58 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:34278 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932707AbcJ0CD5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2016 22:03:57 -0400
Received: by mail-qk0-f171.google.com with SMTP id x11so26956727qka.1
        for <git@vger.kernel.org>; Wed, 26 Oct 2016 19:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3X57ITgoAwduugn0Uo0ngQQLIwIEQGQoA3Hi/VXEh2I=;
        b=nM5wt8ggqzi40zeMAM4if4FDZjaL0YuPQx541Q3QGfoYnI4VCWp9cNI/zoRcuEsA+i
         /RusjJG8UVbmg8VZRALADrty/Zeq05kqv1MWh2JIcGcbmOK6/45IL7usl9sLMpZ7MZV1
         zz/3UZrevbpEA83PfKlwxJpNp0cCtT5mt1STbqVjxr8d3E+IgGKHEVXiivdoFWyBYYsT
         OYwwRrzAwm+eh7cL1EZzjY8r3h4ZoSJzLC1VZ5bTaBfGJosUkf1YFbxNi+n6SoLHaA0m
         lWXgRJ+PbWmlj9QpWjjKbw8uX84E4Kh2iGIfK5vjjjznsZg7Q6iSBCEw7Uabuj3B/LpJ
         X1/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3X57ITgoAwduugn0Uo0ngQQLIwIEQGQoA3Hi/VXEh2I=;
        b=XTpelFx8tTCPvLpROpWuVfDHF0MkZZ2MpKt29be+ao5JiWEbMHuifTs1vIDsS885h5
         XfEHlDYqYojHxv6ELTy1RBX8+w6k4yeNKnZMhizZcOME+7A+GyDT1utaMN1KNzphCkQ6
         tYbilqcxX+RFdjPFbSxoa6GinSlhRedk1L+Pz0jqEhRGpfFYdTHfLsQSynuzFhdZgFHg
         eqEX9BWxMG+XUXdazsZtWpvQ2QQCVu2h+/FSnkBfW6h0mypMoxHzd3zyfJrEgjBHYpjd
         Xcd1gb77fDA/H7jFN52lSNb9zcAIwf9O2A5HU4O1KXDS4ba1WPSfWlu5kCOtX5SrdOqS
         e4Rg==
X-Gm-Message-State: ABUngvcbk+1Bl9Vfvi/SDmJd6ta8nPITgzRmFz8rXlRIk1H+jQcDkSP8INoVukIYRwRUMQqSeLLIkx1/S2Mzoe2Y
X-Received: by 10.55.56.11 with SMTP id f11mr3973546qka.255.1477533836317;
 Wed, 26 Oct 2016 19:03:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Wed, 26 Oct 2016 19:03:55 -0700 (PDT)
In-Reply-To: <1477533150.2764.147.camel@mattmccutchen.net>
References: <1477523244.2764.114.camel@mattmccutchen.net> <CAGZ79kaw0s_PC2AstRVwFT8N1CJVC_7yQfC19zPzRjAqkSpMDg@mail.gmail.com>
 <1477533150.2764.147.camel@mattmccutchen.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 26 Oct 2016 19:03:55 -0700
Message-ID: <CAGZ79kb1bb5e5hKpnkFqLOsPow5xt8zczWmZNxMMt5nA84tf-w@mail.gmail.com>
Subject: Re: "git subtree --squash" interacts poorly with revert, merge, and rebase
To:     Matt McCutchen <matt@mattmccutchen.net>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 26, 2016 at 6:52 PM, Matt McCutchen <matt@mattmccutchen.net> wrote:
> Hi Stefan,
>
> I appreciate the effort to remove obstacles to the use of submodules!
>  It looks like a custom tool is probably still our best option at this
> time, though we can always switch back to submodules later.
>
> On Wed, 2016-10-26 at 16:23 -0700, Stefan Beller wrote:
>> On Wed, Oct 26, 2016 at 4:07 PM, Matt McCutchen <matt@mattmccutchen.net> wrote:
>> > - We have to make separate commits and manage corresponding topic
>> > branches for the superproject and subprojects.
>>
>> Well yeah, that is how submodule work on a conceptual level.
>> While having multiple commits may seem like overhead, note
>> the subtle difference for these commits. One if deep down in the
>> stack patching one of the submodules, the other is a high level
>> commit advancing the submodule pointer.
>>
>> Note that the target audience of these two commit messages
>> might be vastly different, hence can be worded differently.
>> (The submodule describing how you fixed e.g. a memleak or race condition
>> and the superproject describes on why you needed to include that submodule,
>> e.g. because you switched your toplevel application to use threads.)
>
> I understand one can adhere to that philosophy, but I don't see the
> practical benefit of doing so in our case compared to using a "git
> subtree"-like approach and making a single commit.  It would just be us
> looking at both commits.  If we do upstream any of the library changes,
> we'll probably have to rework them anyway.
>
>> > - A diff of the superproject doesn't include the content of
>> > subprojects.
>
>> Although this is just Git, you probably also have a code review system that
>> would need that change as well.
>
> Indeed.  We currently use Bitbucket.  I'd be open to switching, though
> maybe not just for this.
>
>> Is there anything else besides these 3 points that encourages you to
>> switch away from submodules?
>
> Those 3 are the ongoing pain points I can think of.  There are a few
> other drawbacks compared to "git subtree" that come up less often:
>
> 1b. On another project, I was working with a teammate who was new to
> version control and not very careful, who forgot to run "git submodule
> update" and ended up committing back the old submodule pointer.
>  Thankfully, this hasn't happened yet on my current project.
>
> 4. I pushed several dangling submodule pointers before I learned I
> could set push.recurseSubmodules = check.  This isn't the default; each
> developer has to do it manually.  (In theory, I could put such things
> in a setup script for them to run if they trust me.)

There is a current series in flight/for review that makes "check" default.
(It is blocked as check has some performance issues when having lots
of commits to be pushed, so it may take a while and not show up in the
next release)

>
> 5. Stashing changes to both the superproject and the subproject takes
> more steps.

True, so you'd want to have a `git stash --recurse-submodules={yes,no}`
where the command line option is configurable, so you don't have to type
it all the time?

>
> 6. I use multiple worktrees (with "git worktree") because of #5 and
> also so that I can run two versions of the application at the same time
> and compare the behavior.  Using "git worktree" with submodules is
> officially unsupported, though I was able to get things working by
> manually editing some files.

Heh, true. I made an attempt on fixing git worktree a few weeks ago, but that
did not go anywhere, but it's still on the TODO list.

You can use git clone --reference with --recurse-submodule though when
having bandwidth concerns. It doesn't deliver the full worktree experience
though as it would be separate clones with shared object store.

>
> 7. We have to set up a repository for each subproject on our hosting
> service.  Anyone who forks our application and modifies a subproject
> has to set up a subproject repository and carry a change to .gitmodules
> to point to their repository.  If we use relative URLs in .gitmodules,
> it's even worse: anyone who forks our application has to set up
> repositories for all the subprojects, even if they don't modify them.
>
> Matt

Yeah the model of referencing in gitmodules is conceptually broken.
I don't even claim it is on my todo list. ;)

Thanks for pointing out the issues though. they align to what
we plan on doing for submodules, so ... the plan actually makes
sense :)

Thanks,
Stefan

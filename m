Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 549441F424
	for <e@80x24.org>; Sun,  8 Apr 2018 09:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752783AbeDHJI4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Apr 2018 05:08:56 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:37504 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752111AbeDHJIx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Apr 2018 05:08:53 -0400
Received: by mail-qt0-f194.google.com with SMTP id w12so5971294qti.4
        for <git@vger.kernel.org>; Sun, 08 Apr 2018 02:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=rZEGsGgy5Bs84Fqz8Fb/GCl7irw1v/4LK4lZZk/Wo48=;
        b=vLduKEyAgAPXOzJoxu1MX0jcHhpU9xIvgKol9xbsho0EqASos9XlmskdCvh3rzPu52
         PuxQk4KWozMvoMqXwD3AmjWRCgtxYYJxFIbHTfAqCoohH9pllz3HVazc3SP/LNdt7u1i
         YUcUAU9K1MVSQUEu3CEak5YuHUn/mF0rtHCWwxoOdYdiy6lSsGmwgQTWKU6YRy7zpbDn
         7plZ8XxobYhjXM+55cFm36XvSxMWfEqQ78Jg2yY+udBijEGja8TsJ2VZeAvRKJPzvWA4
         hriFf9+smlaoO/xrvImc/7ZPCS1b1OF4vQ0FCuEohrFJcXPtSjTfwR5UvH9xLxYDiVUG
         lAqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=rZEGsGgy5Bs84Fqz8Fb/GCl7irw1v/4LK4lZZk/Wo48=;
        b=ENajYwZ5ipQo5iKLnU0nBneUtod/mhXg4/UysN8pBoYLH0Hg3dXfwHVCw9APk5rNoo
         tjjSTM3yCu/SLWW/uwnefUY7LyijyFy7E92wFHpsLR1+LI8Y+TsPeEXlU+QbVLflj32u
         7mU1JOD6LfuU6+bgaS67Bub3m1DHQGGLeK4n8GO+/t8UwgN+EsfV7BzmR0UYp38gv3n1
         B9n2HMyTcKWvx76dTlW+oJVqOc3ezQ1rLrOAleXVjdNFXZ5JWrvFziYKnopzo47aKENM
         GNVRPJjW6CLuih72wcG5J6QocQaM9WAIZfDTzrkuISmXoUsIkVRBixyHk+cy8gMwEACl
         7CdA==
X-Gm-Message-State: ALQs6tB8jjNyHcJxkJhtEkcokZdGnPxxSW2ybx/TcsnRs1cNuvlHXGjZ
        21NknTuKjONjxt07vE6QJvlechHwKSahCGPmJ0U=
X-Google-Smtp-Source: AIpwx4+rlc9qdaw7K/SDwb/8KgnRNNSnJ1qiSpHLZIjFms3FhIj61JQy3wJqe0ZDx0ADyYU6YbVG6EcxX3BhGxdHUjw=
X-Received: by 10.200.69.131 with SMTP id l3mr4402177qtn.50.1523178533036;
 Sun, 08 Apr 2018 02:08:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Sun, 8 Apr 2018 02:08:52 -0700 (PDT)
In-Reply-To: <20180331151804.30380-1-t.gummerer@gmail.com>
References: <20180325134947.25828-1-t.gummerer@gmail.com> <20180331151804.30380-1-t.gummerer@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 8 Apr 2018 05:08:52 -0400
X-Google-Sender-Auth: DkjJ1eZ3l_VM1lxsopBpgOHFqX4
Message-ID: <CAPig+cQ8VzDycUMo-QOexNDBgQGEGj2BPmPa-Y0vhGCt_brbhg@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] worktree: teach "add" to check out existing branches
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 31, 2018 at 11:17 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> This round should fix all the UI issues Eric found in the last round.
> The changes I made in a bit more detail:
>
> - added a new commit introducing a new hidden --show-new-head-line
>   flag in 'git reset'.  This is used to suppress the "HEAD is now at
>   ..."  line that 'git reset --hard' usually prints, so we can replace
>   it with our own "New worktree HEAD is now at ..." line instead,
>   while keeping the progress indicator for larger repositories.

As with Junio, I'm fine with this hidden option (for now), however, I
think you can take this a step further. Rather than having a (hidden)
git-reset option which suppresses "HEAD is now at...", instead have a
(hidden) option which augments the message. For example,
--new-head-desc="New worktree" would make it output "New worktree HEAD
is now at...". Changes to builtin/reset.c to support this would hardly
be larger than the changes you already made.

The major benefit is that patch 3/6 no longer has to duplicate the
code from builtin/reset.c:print_new_head_line() just to print its own
"New worktree HEAD is now at..." message. (As for the argument that
"git worktree add" must duplicate that code because it wants the
message on stderr, whereas git-reset prints it to stdout, I don't see
why git-worktree puts those messages to stderr in the first place. As
far as I can tell, it would be equally valid to print them to stdout.)

> Some examples of the new UI behaviour here for reference:
>
>  - guess-remote mode
>
>     $ git worktree add --guess-remote ../next
>     Creating branch 'next'
>     Branch 'next' set up to track remote branch 'next' from 'origin'.
>     New worktree HEAD is now at caa68db14 Merge branch 'sb/packfiles-in-repository' into next
>
>  - original dwim (create a branch based on the current HEAD)
>
>     $ git worktree add ../test
>     Creating branch 'test'
>     New worktree HEAD is now at c2a499e6c Merge branch 'jh/partial-clone'
>
>  - new dwim (check out existing branch)
>
>     $ git worktree add ../test
>     Checking out branch 'test'
>     New worktree HEAD is now at c2a499e6c Merge branch 'jh/partial-clone'
>
>  - no new branch created
>
>     $ git worktree add ../test2 origin/master
>     New worktree HEAD is now at c2a499e6c Merge branch 'jh/partial-clone'

I like the "creating" or "checking out" messages we now get for all
the DWIM cases. I wonder if it would make sense to print "Checkout out
blah..." for this case too. It's certainly not necessary since the
user specified <commit-ish> explicitly, but it would make the UI even
more consistent, and address your subsequent comment about missing
context above the "Checking out files: ...%" line for this case.
Thoughts?

> Compare this to the old UI (new dwim omitted, as there's no old
> version of that):

Thanks for contrasting the new with the old. The new output is nicer
and more helpful.

> The one thing we are loosing is a context line before "Checking out
> files:", if no new branch is created.  Personally I feel like that's
> acceptable, as the user just used the 'git worktree add' command, so
> it should be intuitive where those files are being checked out.

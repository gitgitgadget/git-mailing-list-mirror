Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B00D1F453
	for <e@80x24.org>; Fri,  1 Feb 2019 07:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbfBAHHL (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 02:07:11 -0500
Received: from mail-it1-f169.google.com ([209.85.166.169]:38958 "EHLO
        mail-it1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbfBAHHK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 02:07:10 -0500
Received: by mail-it1-f169.google.com with SMTP id a6so8365616itl.4
        for <git@vger.kernel.org>; Thu, 31 Jan 2019 23:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5o+2XGwusC+cGnV3fs8xHt94l3f5J1aAB3OaaydvF78=;
        b=kz4JSUY2Jtr59iAC6PxiNeGs+RFyByExwx4GNW0bcIFIb1W6pDku5AgT4o3IcmoST2
         bjFF91q02A9jK1rxZnxwdzqeY7K9gkwJU0O4WCSkxVmREIDtgP/mknU1PSkf5AqaYFuN
         6euDUlL280E/BSCTWcWZlXt8zU8My9etAFPQL74WLtASsk0WUhJxXg+hUhihiFN5M9zA
         8n2WtWt3sWk4jtxw/Q7kMPz4mMLPJv2DTiUQgipz3jq3sdr8qQFX1WqqsH3cCBCaO2h3
         71imrbFnXki87jf3XqidbwvKhOIHQU3CTXSoZ0KHDRb0upenV1xSRWWYKYOlrGOEACdG
         VMcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5o+2XGwusC+cGnV3fs8xHt94l3f5J1aAB3OaaydvF78=;
        b=GoubYeTCPBNaXJ1yMapXaFX7HkjAJC7u3AuNd8mkSnwhhwOZFAQeRf91xUnxR3wjWc
         162Umu4oGXvE8+DVwsWYS27z4KIuewZbeJsPaGWE/h7KF+llbXFSM5y+Z0QsY0v3upTf
         74+dA1t3BuxClcENBV8DO5d58XwO3IOc2wE3pXez5KxUUgr+TaINL9o1n5BBZjShNoQb
         9ajNJVMVSEUC3DA6IqscZ6LFQbbzTT+Hedx/GOw8fqe7uFlUHX/cwYALpbarKOfuScL5
         kE3qwxE7yF2lbAaMt8Qc6oruaeS94DGgnQuGX7gZiJJtLxE+e+jSwi4ukXOXncikqzDh
         Mt8w==
X-Gm-Message-State: AJcUukfkjlFVJPlRsTY265Iy2ElWlO3fLnpZOMsff/PgHJBvC2UzOxMk
        xu66Mp9EqkjMSRu+XzPSOmw8CjtU0hRaHGCfsDs=
X-Google-Smtp-Source: ALg8bN6TZnMn8DbKYCS8GbxC7AOMfJfLqVRrvfbJiBAEijIm9GUvouK1VuovSkfrMNxivxaz3VMF8+Aw5uPerousqiU=
X-Received: by 2002:a02:8943:: with SMTP id u3mr22890804jaj.92.1549004829270;
 Thu, 31 Jan 2019 23:07:09 -0800 (PST)
MIME-Version: 1.0
References: <89985b60-4c28-ebf0-64b1-8da75263d745@suse.cz> <2ee89ff3-e672-e940-f601-aa1d2647756a@suse.cz>
 <CAPig+cSdpq0Bfq3zSK8kJd6da3dKixK7qYQ24=ZwbuQtsaLNZw@mail.gmail.com>
In-Reply-To: <CAPig+cSdpq0Bfq3zSK8kJd6da3dKixK7qYQ24=ZwbuQtsaLNZw@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 1 Feb 2019 14:06:43 +0700
Message-ID: <CACsJy8D+zvgtw8RuBefYQsYrvn_vQT1dUO3Veg5ZtfQa2u5QKA@mail.gmail.com>
Subject: Re: Worktree creation race
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Marketa Calabkova <mcalabkova@suse.cz>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for including me. Apparently I did miss some emails :)

On Fri, Feb 1, 2019 at 1:27 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Mon, Jan 28, 2019 at 7:58 AM Marketa Calabkova <mcalabkova@suse.cz> wrote:
> > On 15/01/2019 15:03, Marketa Calabkova wrote:
> > > I am writing to report a bug. The original report is from my colleague, I am also providing his suggestions.
> > >
> > > There is insufficient locking for worktree addition. Adding worktree may fail.
> > >
> > > The problem is that git reads the directory entries in $GIT_DIR/worktrees,
> > > finds a worktree name that does not exist, tries to create it, and if an
> > > error is returned adding the worktree fails. When multiple git processes
> > > do this in parallel only one adds a worktree and the others fail. Git should
> > > reread the directory and find a new name that does not exist when creating
> > > the worktree directory fails because another git process already created it.
> > >
> > > I suppose adding PID in the tree name would mitigate the issue to the point it will be very unlikely to encounter.
> > >
> > > I need more than the tree in the temporary directory so using the temporary directory directly as a tree is out of question.
> > >
> > > cd gitrepo
> > > git commit --allow-empty -m Empty
> > > for n in $(seq 10000) ; do ( tmp=$(mktemp -d /dev/shm/gittest/test.XXXXXXXXXXX) ; mkdir $tmp/test ; git worktree add --detach $tmp/test ; ) & done
> > >
> > > (you should see many messages like:
> > > fatal: could not create directory of '.git/worktrees/test284': File exists)
> > >
> > Does anyone has a suggestion what to do with this bug? It looks like a
> > one-line fix probably in builtin/worktree.c, but I have no idea how to
> > do it. Sorry.
>
> I doubt this is a one-line fix, and I don't think it has anything to
> do with reading entries in $GIT_DIR/worktrees.

I never thought people would create worktrees "like crazy" to end up
worrying about races like this. The mkdir loop would be one way to go.
But I'm going to add a new option to let the user control this
directory name. This is necessary since this name is now exposed via
"worktrees/<name>" reference space and should also be reported in "git
worktree list". Avoiding the race is a nice bonus.

> add_worktree() already attempts to give a unique identifier to each
> worktree by adding a numeric suffix and incrementing that suffix if
> the name already exists (such as the 284 in your example error
> message) but there is definitely a race-condition between the time it
> stat()s the name and the time it mkdir()s it.
>
> One possible fix would be to unconditionally use the PID, as you
> suggest, though, this is not necessarily foolproof against races
> either (though it makes collisions very unlikely).
>
> Another possibility would be to skip the stat() and instead do the
> mkdir() in a loop, incrementing the sequence number each time through
> the loop. That should eliminate the race entirely (I think).
-- 
Duy

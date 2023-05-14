Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F40C7EE22
	for <git@archiver.kernel.org>; Sun, 14 May 2023 20:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233720AbjENUV3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 May 2023 16:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjENUV1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 May 2023 16:21:27 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3881B6
        for <git@vger.kernel.org>; Sun, 14 May 2023 13:21:25 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-306dbad5182so7815604f8f.1
        for <git@vger.kernel.org>; Sun, 14 May 2023 13:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684095684; x=1686687684;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D30kBiX9dfFL+/o/VSGfK+UUW3Si3naqQjahMlc9mvM=;
        b=XW/0m+94o8arMjMhJmmSdw+C5i33dN7mKYuWWDa0bQuQ3Puq52MeHMNbF1O17l7sX5
         2oWDNV9wTy0vbaKKgTrhD2gAHvL4xtmVQ8BIYZ/Ki6ahx4DwtzLVAQuALJsoOf9qwsFQ
         b9j8iTaxULpaF45Nu4ffQUPqVnXyPfExf+DTaV+5GmCC4pbtvUetFbeAMgGEc/5rYOuy
         r92BwdigC5Ac3qU74xkc9JBME0940Gg7gXZoYk8HPgGAeq6DYxPxK5yoMQ51E5LmrzUj
         0JDNPFzr5Viti3RB38MnYuE9is6lDdOiG8iJzSlk3xbO7PjUy71jByb63eyQsPWpaxFU
         +daQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684095684; x=1686687684;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D30kBiX9dfFL+/o/VSGfK+UUW3Si3naqQjahMlc9mvM=;
        b=WuBXMv9rEzV/G2TwcNxH7sGMsF4b+i1Q9YHFd8VRzjibJmvvPiqzvOAtEZL04OBS1V
         1QyzfAbOuHYcYuAub5PH/n0O9cnevpLLRR53hGt6MwVS4tfUHeX2yxd6ZalORoTLwyq1
         zYrh/sF7xnaj2ncQxTx5I7BFGUh0wGEqs6NpbCZTrHYmDKvTJkDyqFWZTpz5bgooogxx
         +1MKkdwWRzAGJiFyISNqvAcvMu6wXkANnnA9e+hihGO65UO0kzjed4EnuERaFruadh78
         5FpzwRD/sFUQk9fhs+GjaVMcmyPflZ9frBNX1a+aT6ulKoRlj6wL4t6ArMAfyQGTiuwL
         3QQw==
X-Gm-Message-State: AC+VfDyM9G1flLAVGLXP5Sp/OysRCscvXHKs8rc25D2P4+DcCu8zeu8i
        27O86anAAQAFzJawFxYOark=
X-Google-Smtp-Source: ACHHUZ6bktKHi4RtR5TxxDT7PhQVPVW6/GNP+pfZv8B+iznFQyN0jz13Of0kBGzqvn9lU71SJ2Re7Q==
X-Received: by 2002:a5d:6346:0:b0:307:977a:e693 with SMTP id b6-20020a5d6346000000b00307977ae693mr19229919wrw.59.1684095683796;
        Sun, 14 May 2023 13:21:23 -0700 (PDT)
Received: from [192.168.2.52] (151.red-88-14-53.dynamicip.rima-tde.net. [88.14.53.151])
        by smtp.gmail.com with ESMTPSA id o4-20020a5d4a84000000b003062b6a522bsm30344898wrq.96.2023.05.14.13.21.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 May 2023 13:21:23 -0700 (PDT)
Subject: Re: [PATCH v4] checkout/switch: disallow checking out same branch in
 multiple worktrees
To:     phillip.wood@dunelm.org.uk, Carlo Arenas <carenas@gmail.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com, gitster@pobox.com,
        Jinwook Jeong <vustthat@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>
References: <20230119055325.1013-1-carenas@gmail.com>
 <20230120113553.24655-1-carenas@gmail.com>
 <8f24fc3c-c30f-dc70-5a94-5ee4ed3de102@dunelm.org.uk>
 <CAPUEspjuXSncRxo5DMj1pA5zcYvn4Y6epdijYL6HJRGhk_6q7g@mail.gmail.com>
 <a848b7d5-fd40-b043-7ed9-1672f65312e6@dunelm.org.uk>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <31ab5d7c-d310-1659-5d56-2fd341c44275@gmail.com>
Date:   Sun, 14 May 2023 22:21:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <a848b7d5-fd40-b043-7ed9-1672f65312e6@dunelm.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27-ene-2023 14:46:45, Phillip Wood wrote:
> Hi Carlo
> 
> On 20/01/2023 22:12, Carlo Arenas wrote:
> > On Fri, Jan 20, 2023 at 7:08 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
> > > 
> > > On 20/01/2023 11:35, Carlo Marcelo Arenas Belón wrote:
> > > > Commands `git switch -C` and `git checkout -B` neglect to check whether
> > > > the provided branch is already checked out in some other worktree, as
> > > > shown by the following:
> > > > 
> > > >     $ git worktree list
> > > >     .../foo    beefb00f [main]
> > > >     $ git worktree add ../other
> > > >     Preparing worktree (new branch 'other')
> > > >     HEAD is now at beefb00f first
> > > >     $ cd ../other
> > > >     $ git switch -C main
> > > >     Switched to and reset branch 'main'
> > > >     $ git worktree list
> > > >     .../foo    beefb00f [main]
> > > >     .../other  beefb00f [main]
> > > > 
> > > > Fix this problem by teaching `git switch -C` and `git checkout -B` to
> > > > check whether the branch in question is already checked out elsewhere.
> > > > 
> > > > Unlike what it is done for `git switch` and `git checkout`, that have
> > > > an historical exception to ignore other worktrees if the branch to
> > > > check is the current one (as required when called as part of other
> > > > tools), the logic implemented is more strict and will require the user
> > > > to invoke the command with `--ignore-other-worktrees` to explicitly
> > > > indicate they want the risky behaviour.
> > > > 
> > > > This matches the current behaviour of `git branch -f` and is safer; for
> > > > more details see the tests in t2400.
> > > 
> > > As I said before, it would be much easier for everyone else to
> > > understand the changes if you wrote out what they were rather than
> > > saying "look at the tests". I do appreciate the improved test
> > > descriptions though - thanks for that.
> > 
> > Apologies on that, I tried to come up with something that would
> > describe the change of behaviour other than the paragraph above and
> > couldn't come out with a better explanation except reading the tests
> > (which I know is complicated by the fact they are interlinked).
> > 
> > The behaviour I am changing is also not documented (other than by the
> > test) and might have been added as a quirk to keep the scripted rebase
> > and bisect going when confronted with branches that were checked out
> > in multiple worktrees, and as such might had not be intended for
> > `switch`, and might not be needed anymore either.
> > 
> > Using`checkout` for simplicity, but also applies to `switch`,
> > 
> >    % git worktree list
> >    .../base  6a45aba [main]
> >    % git worktree add -f ../other main
> >    Preparing worktree (checking out 'main')
> >    HEAD is now at 6a45aba init
> >    % cd ../other
> >    % git checkout main
> >    Already on 'main'
> >    % git checkout -B main
> >    fatal: 'main' is already checked out at '.../base'
> 
> Thanks for explaining that. If there is no <start-point> given we don't
> reset the branch so it seems a bit harsh to error out here.

We say in the documentation:

   +
   If `-B` is given, `<new-branch>` is created if it doesn't exist; otherwise, it
   is reset. This is the transactional equivalent of
   +
   ------------
   $ git branch -f <branch> [<start-point>]
   $ git checkout <branch>
   ------------
   +

and, since 55c4a67307 (Prevent force-updating of the current branch,
2011-08-20), we return with error on "git branch -f <current-branch> [...]".

Therefore, when the current branch is checked out in multiple worktrees, it
seems consequent to error on "git checkout -B <current_branch> [...]".

But we want to allow "git checkout -B <current_branch>", without <start-point>,
as a way to say "git reset --keep", see: 39bd6f7261 (Allow checkout -B
<current-branch> to update the current branch, 2011-11-26).

Your suggestion not to error is not only reasonable, but also seems desirable.

Thanks.

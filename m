Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD08CC433E0
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 22:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B1AC23A5C
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 22:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbhAVWYa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 17:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730602AbhAVTyR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 14:54:17 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD03C061794
        for <git@vger.kernel.org>; Fri, 22 Jan 2021 11:53:34 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id a25so6745843ljn.0
        for <git@vger.kernel.org>; Fri, 22 Jan 2021 11:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=fAl1cD+1kay3q+6zbzlBTgnLDxSNOe9NWWjLTphmyOU=;
        b=QZBmESo0f0AsfglpAUJrH8UTXAWuj3b0MdW8T5V4WXky5TDZGa/zCWXfzLgdrs6YXC
         AEzpJf0Rk0H04QtKJVmB3AbfKZLWVqcMnpgVe8PhZLurl1v3/UhmdtQiylht8iEgh9J7
         OBJwy2bW7ZL0mglMgYbsj+1pI1gPAu4bSHUjxJHUIDeu8BpxjbmaF43G7FPxegFljLHj
         VyZfpUXXkhOc0DiSKIt4eqUIRsrceX3jLyLtjn+vIiyInEPd87jOCyhZKGc1afXI5D/b
         zrGxULFeXw4+S97hTbcKUbmEue1gN5N46chkt9yWTlgauz56pt1ZmI3/Pz291cVx4nXo
         vj9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=fAl1cD+1kay3q+6zbzlBTgnLDxSNOe9NWWjLTphmyOU=;
        b=p6FcNtZU/dH9NQUHoA6BUIfuYAQO3iW1onVfMHifGql7WroJIjixzym69IiW/Tpkyl
         /9MV/NiyoEAoE2EgIJXC5KyViSCdIZw5DPkyMpG3TXqcoButnEZWIy2IG1J00HMizuib
         P4GwN+XdEjunPkRqy8EG2dimtl7qc203GmE2Bqph10cfNRCjIDWTftFsdTSFIBNHCWcz
         HCJnbb9XL+FMmbArqTJZsXOPhezOJnXnspDCNH8Jw+7qjIs65L2Ac+W8ir15uUNruIQM
         qv9YhQ6aNjSowoUqCjNLxnp9g5UFN8g6UC8qXvlata3Vi6dfVKXRM+CtGh7oLuLiH5SB
         BFag==
X-Gm-Message-State: AOAM533uCyBddL93TPf7IiB7/S5kEtZWqxuIo6gZntBICRxONxxQ6tfK
        9ZWy1oqOm99etnMqFfvzkoqF/H8BYdtM0nmKuYBU8g==
X-Google-Smtp-Source: ABdhPJygNtIwcnfzeTHb9fBUGzE6V0hUA3M9d/RkWdHI0Qkozlq929x6sxb3GLE2dCZxkpVc3LmCq3005PyDJC0Jt8o=
X-Received: by 2002:a2e:b003:: with SMTP id y3mr2393744ljk.346.1611345212698;
 Fri, 22 Jan 2021 11:53:32 -0800 (PST)
MIME-Version: 1.0
References: <20210122030103.GA73465@gmail.com>
In-Reply-To: <20210122030103.GA73465@gmail.com>
From:   Emily Shaffer <emilyshaffer@google.com>
Date:   Fri, 22 Jan 2021 11:53:21 -0800
Message-ID: <CAJoAoZkrYYz=1wKDtUKdewPGX9wr2Zwhhyq9kd5C2_KDn9UJ=w@mail.gmail.com>
Subject: Re: faster git clone
To:     William Chen <williamchen32335@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 21, 2021 at 7:01 PM William Chen <williamchen32335@gmail.com> wrote:
>
> Dear Emily,
>
> I see your excellent contribution to git clone. I hope that you are well.

Hi William, this is a question much better directed at the Git list as a whole.

>
> When I try to clone a repo of a large size from github, it is slow.
>
> $ git clone https://github.com/git/git
> ...
> remote: Enumerating objects: 56, done.
> remote: Counting objects: 100% (56/56), done.
> remote: Compressing objects: 100% (25/25), done.
> Receiving objects:  23% (70386/299751), 33.00 MiB | 450.00 KiB/s
>
> The following aria2c command, which can use multiple downloading threads, is much faster. Would you please let me know whether there is a way to speed up git clone (maybe by using parallelization)?

In general, it would be more compelling to see actual numbers than
"much faster", e.g. the outputs of `time git clone
https://github.com/git/git` and `time aria2c
https://github.com/git/git/archive/master.zip` - or even an estimation
from you, like, "I think clone takes a minute or two but aria does the
same thing in only a couple of seconds". "Much faster" means something
different to everyone :)

>
> Your help is much appreciated! I look forward to hearing from you. Thanks.
>
> $ aria2c https://github.com/git/git/archive/master.zip
>
> 01/21 20:16:04 [NOTICE] Downloading 1 item(s)
>
> 01/21 20:16:04 [NOTICE] CUID#7 - Redirecting to https://codeload.github.com/git/git/zip/master

Right here it looks like your zip download redirects to a CDN or
something, which is probably better optimized for serving archives
than the Git server itself, so I would guess that has something to do
with it too.

> [#59b6a2 8.2MiB/0B CN:1 DL:3.8MiB]
> 01/21 20:16:08 [NOTICE] Download complete: /private/tmp/git-master.zip
>
> Download Results:
> gid   |stat|avg speed  |path/URI
> ======+====+===========+=======================================================
> 59b6a2|OK  |   2.9MiB/s|/private/tmp/git-master.zip
>
> Status Legend:
> (OK):download completed.

There are others on the list who are better able to explain this than
me. But I'd guess the upshot is that 'git clone
https://github.com/git/git' is asking a Git server, which is good at
Git repo management (e.g. accepting pushes, generating packfiles to
send you a specific object or branch, etc) - but when you ask for
"git/git/archive/master.zip" you're getting the result of some work
the Git server already did a while ago to zip up the current 'master'
into an archive and give it to some other server.

We've done some other work[1] around enabling use of CDNs and prebuilt
chunks lately, but again, there are others on the list better able to
explain than me.

[1]: https://github.com/git/git/blob/master/Documentation/technical/packfile-uri.txt

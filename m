Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21D691F453
	for <e@80x24.org>; Tue, 25 Sep 2018 02:48:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbeIYIxs (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 04:53:48 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:37840 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbeIYIxr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Sep 2018 04:53:47 -0400
Received: by mail-yw1-f67.google.com with SMTP id y14-v6so1514578ywa.4
        for <git@vger.kernel.org>; Mon, 24 Sep 2018 19:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2MOq0WGDETdbfz+la9hjU3cg+iSXoewEjnW40cVZyLM=;
        b=jBDS/h93Z+dzoa2zM61ZHID7cghq9M1t6e+/trZhBrJh87efkV3a4QsT6uG7BaPAOI
         Kz0ZR3V6j7rXMEKBFQquEE3V2wWxN/CFNcDhSkSuI9Yj+MEVgF5erWVeva+NZbPk19/+
         Z4m/0V2Ro/I3oYyADGpJ40LnSdSlAVM2LXKCoEIUhHUNTW/B2fK47+fWZtsE6QskXByy
         jie9+zmQPl14UulkbmPMRjrf+85pG1xi3Vi24ZKTebr/JcQBPbAwO8NFspihNQLMFFJP
         w0kotvRGw1h+XLx2rkDyd5UDfERKqjBzHI9HyUJOrQGXpks47+cvoyjIR156XrEQBxnD
         rS9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2MOq0WGDETdbfz+la9hjU3cg+iSXoewEjnW40cVZyLM=;
        b=IGEhV+k8UyUlyPckE10wL2BfdhFBs9lq32VS7craww8Z0jFXOm06HAtPWzF/RdfLGe
         KGbVomnB8r/L6oGDhk6hz8A4JVamxsOS44PVmap6jrXUsQpuAIJcVzxh94JGc4tGMyrw
         Su3wRuI+zpd4BMVCvIEP542mbdjLDZ8Tg3QIJW14WKIpgeELHwbDShSMOzb1wVQtsYr6
         59i5o4WqfNhHJESktLrpZuhRGpi5gNekfTa96/RwrIJGUsrGBPq8AvhhlLFclYf0ye5D
         7sL8und0Dso3qNG977vHPXHMDklKIWoUMkQSrutBPkrgjQO1PdfYM8W0e3u9Wmn1CQ9i
         mxkA==
X-Gm-Message-State: ABuFfoj1IWcTRwZakeKVHFlzOMrDvCPkpYii3GBfHTXatezf8P7GaAVh
        elMTxw/KN1hc7S0K5zAwfDMAjVx6JTZaiH5eiiwPmg==
X-Google-Smtp-Source: ACcGV6283KC5fslRjafMojVwK0gxquAQnhiYkJgoUc2Bjcj7oZT9tdrpFb+KzlAkK0UGeM/K8QbC8qFmSfEKCv4bj2o=
X-Received: by 2002:a81:b64c:: with SMTP id h12-v6mr758990ywk.119.1537843709150;
 Mon, 24 Sep 2018 19:48:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180922180500.4689-1-pclouds@gmail.com> <20180922180500.4689-4-pclouds@gmail.com>
In-Reply-To: <20180922180500.4689-4-pclouds@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 24 Sep 2018 19:48:18 -0700
Message-ID: <CAGZ79kYTzs=Xx-K-ghUa=as7Q0tiw-z1h7_D2=6zaO3fpWMrWg@mail.gmail.com>
Subject: Re: [PATCH 3/8] refs: new ref types to make per-worktree refs visible
 to all worktrees
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 22, 2018 at 11:05 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
>
> One of the problems with multiple worktree is accessing per-worktree
> refs of one worktree from another worktree. This was sort of solved by
> multiple ref store, where the code can open the ref store of another
> worktree and has access to the ref space of that worktree.
>
> The problem with this is reporting. "HEAD" in another ref space is
> also called "HEAD" like in the current ref space. In order to
> differentiate them, all the code must somehow carry the ref store
> around and print something like "HEAD from this ref store".
>
> But that is not feasible (or possible with a _lot_ of work). With the
> current design, we pass a reference around as a string (so called
> "refname"). Extending this design to pass a string _and_ a ref store
> is a nightmare, especially when handling extended SHA-1 syntax.
>
> So we do it another way. Instead of entering a separate ref space, we
> make refs from other worktrees available in the current ref space. So
> "HEAD" is always HEAD of the current worktree, but then we can have
> "worktrees/blah/HEAD" to denote HEAD from a worktree named
> "blah". This syntax coincidentally matches the underlying directory
> structure which makes implementation a bit easier.
>
> The main worktree has to be treated specially because well.. it's
> special from the beginning. So HEAD from the main worktree is
> acccessible via the name "main/HEAD" (we can't use
> "worktrees/main/HEAD" because "main" under "worktrees" is not
> reserved).
>
> This patch also makes it possible to specify refs from one worktree in
> another one, e.g.
>
>     git log worktrees/foo/HEAD

This has strong similarities to remote refs:
Locally I may have a branch master, whose (stale local copy of its
distributed) counterpart is named origin/master.

It is also possible to have a working tree named origin
(just I like to name my worktree "git", when working on git.git),
how do we differentiate between the neighbor-worktree
"origin/master" and the remote-tracking branch "origin/master" ?

As the remote tracking branches are shared between all
worktree there is no need to differentiate between a
local-worktree remote tracking branch and a
neighbor-worktree remote tracking branch.

Now that you introduce the magic main working tree,
we also need to disallow working trees to be named "main",
i.e.
    $ git worktree add main HEAD

produces

  $ ls .git/worktrees/
  main

How do we deal with that?

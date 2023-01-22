Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE348C25B4E
	for <git@archiver.kernel.org>; Sun, 22 Jan 2023 05:11:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjAVFL6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Jan 2023 00:11:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjAVFL5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2023 00:11:57 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA2C1B56F
        for <git@vger.kernel.org>; Sat, 21 Jan 2023 21:11:54 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id b3so13678255lfv.2
        for <git@vger.kernel.org>; Sat, 21 Jan 2023 21:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8YuOS5tXVc4lYtQjX3heBymBmpdZVaSngLxRqYX/4x0=;
        b=nhfuj60sWSWz8n/ThyMdj7AA44fI9hpZA5rr/9452njCZJR3Hl3lzRIhXcvpLa8puq
         3FfXAKsGLjpqNt7JOkuFV5dPRrNH02Ax2rIA4ErzScqlNN+HzAYEY43wTIjGhdglP2O7
         jcR41Z68Tv9smhqfBdXBKS8mcMQEb0ReyWxcbLhzpX4zr3d/K1D7PA9jGPrGu0Zws7ZF
         chjX/JTlbcBjVaZDRWmYoXMwaXrGRjT05vHcxqdQiKur4HudLAdOPkajBhf5AAZLR5ed
         gPQxVAwmcenhgYr2Rag15bHzr7llgCXHkEWstIfRtZJfBuLtWxPaTKSiUvnRbryrfY99
         RPng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8YuOS5tXVc4lYtQjX3heBymBmpdZVaSngLxRqYX/4x0=;
        b=2h/zBNc/8bcVaZIlcBIt1qRXAkYdAR+uhs6rihEfFbuwT3nwuWSL1QlYSB6X7wDNXh
         bE6ls8dJhAa0i4b6TYyuf41qkMtf/3VZIJzFBeTcMOcBEMtWS3NcmJdnyfbegC/seqgA
         zDG1lIAKXk/ixesBZiv5J9uw0kHbfDCeXWycVQ5D1y2/zn+T6q+AM5NHmqUB6S9Hvrz9
         NurgLqE3D6mfnvqXvfQHpa2WT8B3AMpiHLPVhFnDxX0hNclArBExjv22GvHZm9KTw6ax
         CVJT7X9I/au6H/VMjyug9r+JNkXtc2iNWAYXe/aNzKUEu33lb+iJutwnzReir+eOr2fO
         RwvQ==
X-Gm-Message-State: AFqh2krJGFlj/7vLDeWqesyk02xfoV4Neh6MxYIL46/RUiF3PX0xiUK0
        peqYjzys5Ee8S/ZA8PxwJfXXDHAzvJjet/X0y5ipEmFc
X-Google-Smtp-Source: AMrXdXuWbD2upPo5GygWLPe74MRJ7vDipELHUT617RyZJhj5TsrHVJZvsnik9G9lf0MNf28zn174v9XoOwvkf/G9aSo=
X-Received: by 2002:a05:6512:3b9c:b0:4b5:9233:6e9b with SMTP id
 g28-20020a0565123b9c00b004b592336e9bmr1972712lfv.394.1674364312481; Sat, 21
 Jan 2023 21:11:52 -0800 (PST)
MIME-Version: 1.0
References: <pull.1466.v2.git.1674190573.gitgitgadget@gmail.com>
 <pull.1466.v3.git.1674266126.gitgitgadget@gmail.com> <48c40c0dda00eeb8b9bdc5ba9372b46964eea14a.1674266126.git.gitgitgadget@gmail.com>
 <d5ef5870-baac-14d4-65a5-deb94a848011@dunelm.org.uk> <20e759bd-7d13-b7ba-c0df-69b4f827c5bd@dunelm.org.uk>
In-Reply-To: <20e759bd-7d13-b7ba-c0df-69b4f827c5bd@dunelm.org.uk>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 21 Jan 2023 21:11:39 -0800
Message-ID: <CABPp-BFCHvc2rDjYLYmx9ji2QcnGFJHptJR97exHNqifcz4vDg@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] rebase: add coverage of other incompatible options
To:     phillip.wood@dunelm.org.uk
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 21, 2023 at 11:25 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> On 21/01/2023 15:20, Phillip Wood wrote:
> >> @@ -1238,6 +1238,17 @@ int cmd_rebase(int argc, const char **argv,
> >> const char *prefix)
> >>           if (options.fork_point < 0)
> >>               options.fork_point = 0;
> >>       }
> >> +    /*
> >> +     * reapply_cherry_picks is slightly weird.  It starts out with a
> >> +     * value of -1.  It will be assigned a value of keep_base below and
> >> +     * then handled specially.  The apply backend is hardcoded to
> >> +     * behave like reapply_cherry_picks==1,
> >
> > I think it is hard coded to 0 not 1. We generate the patches with
> >
> >      git format-patch --right-only $upstream...$head
>
> Sorry I somhow managed to omit --cherry-pick from that, it should have been
>
>         git format-patch --right-only --cherry-pick $upstream...$head
>
> Phillip

Oh, indeed, I was reading wrong.  Thanks for the correction.  I still
think there's something to fix up here, which I'll include in my
re-roll.

> > so cherry-picks will not be reapplied. I'm hardly an impartial observer
> > but I think the current check is correct. We support
> >
> >      --whitespace=fix --no-reapply-cherry-picks
> >      --whitespace=fix --keep-base --reapply-cherry-picks
> >
> > but not
> >
> >      --whitespace=fix --reapply-cherry-picks

Right, nor do we support
      --whitespace=fix --keep-base --no-reapply-cherry-picks
(If you try it, you'll notice that the code accepts those flags and
starts the rebase pretending everything is fine, but it silently
ignores the --no-reapply-cherry-picks flag.)

Stepping back a bit, though, the apply backend doesn't support
toggling --[no-]reapply-cherry-picks at all.  It hard codes the
behavior (in a way dependent upon --keep-base).  So, if the user
passes --[no-]reapply-cherry-picks and we don't error out, we are just
going to ignore whatever they passed and do whatever hardcoded thing
is baked into the algorithm.

While the user can pass the flag in a way that happens to match what
is baked into the apply backend, I'd still say it's wrong for them to
specify it since we will just ignore it.  Doing so is likely to result
in the user later toggling the flag and being surprised that they get
an error when it used to be accepted, or seeing that it only sometimes
gets accepted.

Anyway, I'll update this patch to document this a bit more clearly in
a code comment and add an improved check.

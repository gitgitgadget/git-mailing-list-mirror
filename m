Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63CFDC38A02
	for <git@archiver.kernel.org>; Fri, 28 Oct 2022 08:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiJ1IUf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Oct 2022 04:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiJ1IUd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2022 04:20:33 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6D6635EA
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 01:20:32 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id r12so7113154lfp.1
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 01:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h/T4AGrqnrwMhDfI0js1nhvseIgslyQVVwYbZwR2xTU=;
        b=DVemJAq5X+VGxT4PkV34ANMNeATSjIReqjpLzyKU6My55XZNU5yASKUbkj29ofgXWD
         WYKbv9gbsroBWR2/PgDDFsON1kzOasTOdYGOgpZPFN8Gazd+ECt+v7Sz7R7W1V1vZOHS
         227ucIeni1qlEeXWBj5WI538ujBenI80mxq06hdcVBidPr8LMsAi6Wt10RR8k0n5y7xW
         9z24n5Q3YtWk4RdtZGxag+bTmnUVPVOUKM8xKDHGDyLptt29RS79h9eMdShdTOd9boaM
         0Nn/JG5CKdIPiYClgCr85dkhVn+n736VBstItMtBX+8P3UeX2rc/nYvI5SItAAP6wW9X
         4vKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h/T4AGrqnrwMhDfI0js1nhvseIgslyQVVwYbZwR2xTU=;
        b=1L8R89QCu6/vubSb0UVqm+NfNfi5x31VeVQP1cCuHjZI7bnlfy8UZxfdWJnp4vOpk6
         16nYfUFJuTHtIYNBXpwmf9KOkk4v2HkRwhc/hOnbdHQAIShsuo3I6Xvhe4hcPj0vwNyy
         kMedT/d4ND6raoLxX4bi8j0seaU4zPsWMxH8iK/iTKIvPj59PL32ttm0+1y5HguIDGHQ
         4Dlg9ynzAIhj4lvE9nEVyhs5df+q3wVE+qOWon+6agNzIPDtzQ+EjpExSn/C6OR0exSu
         wi/3LJobheX+762whNM7I2IZtfKhGkf4SiijpxD6lkqax0J+hBuQdNTQRQ9S6LYPRtHB
         GG0Q==
X-Gm-Message-State: ACrzQf3+ne89Z+A47XCyDyuELzH/mw3TF/lQwNNf2aa1DM1zueblq/rX
        EYcPERckrr0v5JFdefTawc/Oitw6cLCHftFATds=
X-Google-Smtp-Source: AMsMyM5z9E44gQVr5WV1SDpI39P/w5s9t6ynngThDQTMuEn2BxCdCj2jb+RJn3zjv+CM8SwpTvuUNvmTt5Ogbx4qdJY=
X-Received: by 2002:ac2:5e70:0:b0:4a9:cd8b:980b with SMTP id
 a16-20020ac25e70000000b004a9cd8b980bmr12264007lfr.516.1666945230643; Fri, 28
 Oct 2022 01:20:30 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1397.git.1666872761355.gitgitgadget@gmail.com> <xmqqczadm93w.fsf@gitster.g>
In-Reply-To: <xmqqczadm93w.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 28 Oct 2022 01:20:18 -0700
Message-ID: <CABPp-BHceBeo6Y8s00gET=4yqCMf3qqsiNMhqJ34HVf8r=bhnw@mail.gmail.com>
Subject: Re: [PATCH] merge-tree.c: add --merge-base=<commit> option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kyle Zhao via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Kyle Zhao <kylezhao@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 27, 2022 at 11:09 AM Junio C Hamano <gitster@pobox.com> wrote:
>
[...]
> Wouldn't it be sufficient to update the UI to
>
>     git merge-tree [--write-tree] [<options>] [<base-commit>] <branch1> <branch2>
>     git merge-tree [--trivial-merge] <base-commit> <branch1> <branch2>
>
> IOW, when you want to supply the base, you'd be explicit and ask for
> the new "write-tree" mode, i.e.
>
>     $ git merge-tree --write-tree $(git merge-base branch^ branch) HEAD branch
>
> would be how you would use merge-tree to cherry-pick the commit at
> the tip of the branch on top of the current commit.

This was my thought too; but would we be painting ourselves into a
corner if we ever want to make merge-tree support octopus merges?

Also, why did you write $(git merge-base branch^ branch) rather than
just branch^ ?

> I also have to wonder how this should interact with a topic that is
> in-flight to feed multiple merge-tree requests from the standard
> input to have a single process perform multiple (not necessarily
> related) merges.  Elijah knows much better, but my gut feeling is
> that it shouldn't be hard to allow feeding an extra commit on the
> same line to be used as the base.

Yeah, I don't think that'd be too hard...if we could rule out ever
supporting octopus merges in merge-tree (which I'm not so sure is a
good assumption).  Otherwise, we might need to figure out the
appropriate backward-compatible input parsing (and output format
changes?)

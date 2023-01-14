Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CF1C3DA78
	for <git@archiver.kernel.org>; Sat, 14 Jan 2023 03:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbjANDAt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Jan 2023 22:00:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjANDAs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 22:00:48 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9476C05B
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 19:00:46 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id m6so35614502lfj.11
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 19:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NxCTQ/I2yUthDGgewJVg1gMYrTEXQ0/UOyAKE3iZbGw=;
        b=jYu45v/U64bFJG4yfmlQ+I/BBKacE5UPPKxFPByB+LNH3wKSM+6d8QVYoBu7a0eBMU
         vBZiiZPFowWKgaLUIaXaHa/ID6nQnpa7NO0QfmwxCVF6wJ8d7oy+WmaheTw3cZQRWfFc
         YyUNBhIbzAmsNlvHE84NuwoK+E5eFSk3oFXxnYsg0nEr7fD2QNFxRKvoXPb26R16Gjeb
         5VWkDfFVut8mMqw+4qAIx77D8d7U4PFecYXtaeW5uYpEfXzfurmOAA/8pgdJ5FZGfNLp
         0/KW0USCMkr8iez5MNUVVAn0xopbCqJnSeY15szaOYeLJa31uxe9aSGKqEdFWhT3DaGo
         8qjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NxCTQ/I2yUthDGgewJVg1gMYrTEXQ0/UOyAKE3iZbGw=;
        b=aUBwCZAEGFxnGlTNYOMn5C4tPgL/fZuLpAZJnvEIUhg4/JW8SC2Lg7jxu75GFVOtHA
         S2tqO+YWMK9DGWEAF5rOxsDNKZyzxAvLDam+qeLiD8xv7OQrvBaL9YTSL6f6TfwKO6+8
         NdUDpra9iOc6CY6kjdnwO/4hD/K/eSC8NQULS9B5KopTmcbQfUBcxqh6rCmM80APm+ZA
         gVgWorgP1cAV68J2sC2tQn7MzIaUkqdubE5+x1blWgfdb+iqqNerx9YYk32tHxwLIC/S
         9ezvgEdGgDtf580oDD8sNR+WHlVfqLe2qp2tX863UDjkd9tfDiEN19rRax9wlZ6w3xJq
         hehg==
X-Gm-Message-State: AFqh2krthiSM3YzYW4V0OZc4zQWgmtB/CSGf7lJ4+0j17SJnV4RaZQg0
        toW++403741FfKh3lJE1aNsgsVRg00pPZvXTh9Ur/Dnvg6QLAA==
X-Google-Smtp-Source: AMrXdXvzZ4LwIhAB8dhe0J5eE1a7Xv3iTX1RNSe4h3WJCuTDBeZwh+mxTtVlweC8+w1AtLe6MB9EuJfNlCu6V8NlYI4=
X-Received: by 2002:a05:6512:acc:b0:4cb:24a0:27ce with SMTP id
 n12-20020a0565120acc00b004cb24a027cemr5807433lfu.238.1673665245126; Fri, 13
 Jan 2023 19:00:45 -0800 (PST)
MIME-Version: 1.0
References: <pull.1458.git.1673451741587.gitgitgadget@gmail.com>
 <CABPp-BGsD=6PiJtnsuYPsiZJ1rm2X8yTeu-YeP4q5uu5UDw2og@mail.gmail.com> <CAOLTT8RNWJLA_UvoMA_MktkEmLSjJrx7E6Khy97cHhVFXPQD2A@mail.gmail.com>
In-Reply-To: <CAOLTT8RNWJLA_UvoMA_MktkEmLSjJrx7E6Khy97cHhVFXPQD2A@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 13 Jan 2023 19:00:32 -0800
Message-ID: <CABPp-BFEKqU2YWEk=NT2xA_cO=rj_EgjqzYsuxDGwPon18dq8Q@mail.gmail.com>
Subject: Re: [PATCH] ls-files: add %(skipworktree) atom to format option
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 13, 2023 at 8:50 AM ZheNing Hu <adlternative@gmail.com> wrote:
>
> Elijah Newren <newren@gmail.com> =E4=BA=8E2023=E5=B9=B41=E6=9C=8812=E6=97=
=A5=E5=91=A8=E5=9B=9B 18:00=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Wed, Jan 11, 2023 at 7:42 AM ZheNing Hu via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> > >
[...]
> > The "and removed from working tree" portion of this sentence is
> > superfluous.  (And actually makes it harder to understand, I had to
> > try to think through a bunch of cases to try to figure out why you
> > might be trying to add some extra qualifier.)
> >
>
> I just quoted the definition of SKIP_WORKTREE from
> Documentation/technical/sparse-checkout.txt:
>
>     SKIP_WORKTREE: When tracked files do not match the sparse specificati=
on and
>       are removed from the working tree, the file in the index is marked
>       with a SKIP_WORKTREE bit.

Ah, thanks for pointing out the error.  This should probably be reworded to=
:

SKIP_WORKTREE: When a tracked file which is unmodified does not match
        the sparsity patterns, it is removed from the working tree and
        the file in the index is marked with a SKIP_WORKTREE bit (to
        distinguish the missing file from an unstaged deletion).

[...]
> To be honest, right now I think %(skipworktree) just refines the
> --format option's ability to read the index entry SKIP_WORKTREE
> flag bits. It is probably still worth keeping.

I'm not opposed to the idea of a special skipworktree formatting in
conjunction with ls-files' --format option, so long as it has
alternate rationale and isn't worded to suggest it supersedes `git
ls-files -t` for all sparse-checkout uses.

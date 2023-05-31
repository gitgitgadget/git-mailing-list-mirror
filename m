Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3457CC77B73
	for <git@archiver.kernel.org>; Wed, 31 May 2023 05:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbjEaFMP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 May 2023 01:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjEaFMN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2023 01:12:13 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECF7EC
        for <git@vger.kernel.org>; Tue, 30 May 2023 22:12:11 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2af2e1725bdso6979261fa.0
        for <git@vger.kernel.org>; Tue, 30 May 2023 22:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685509930; x=1688101930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IKLiHfFX0vdlko/mtZGGTf8i9WzVA4tSxRXvC42/hnI=;
        b=I3Q1MWcfCjN1GiLZ/1+F9RZia9Acomos0yGc6ebPFzeIwjdpUh9iOx1+1q15Ca2K3U
         /XRCjl+piXh45+a3koXnooJ0jeu95X1DGK3FBUUsFJsQptMCT9Fiq95qnUVlXkerTENT
         9NVg1unf4iJsMvSlJ/8vKUA3CphvAt/AmVrWGc6gB9vGSs4zAQjYK0G+Ggp/Jxx6yq+G
         u7QAEGA7aR/vw+LqKBusWUKExDzLECr36MIEX4IA+mzJFcpUC+ZI8mJzxdOjhPjAAKck
         srfDu4aSwOMWHfJC2F0HTg08ODNIDGRd6/We1tjyGQqTf5zIsLn9e18QdZ4R2GCddDem
         UwRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685509930; x=1688101930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IKLiHfFX0vdlko/mtZGGTf8i9WzVA4tSxRXvC42/hnI=;
        b=jyDz9amlRHOP7VmNRd6dWHDKmSV6Ei5/Nfe4uZ7q9mLkHM5FVP0xT6zcSJxp9kcLxf
         xtDJ9+t+r1heoGw4XHcAN+SE6CsMQoGgIgKKwZ+WRUe1T1cJrPyJkLuH5hWlGCzQVQes
         u0kzHhY7Lq43fqXuxhgLtH/s640QCcgG7eiKSiHihFBkDdnC88io8mtvsKY9gqBEraG4
         xT9EDyA5B2pZVdfeKH+bpW7GHM8iClSPOorFDD4lVCoJXtnGFGRoPE+AqdckVJ4qn+jj
         q5g+6jLMaDjdwCP47PQWB9JQKeBFm+N9gCZ5ONBripLZZFysRUrI1WF/KOTbfGF0Lu6n
         g8tg==
X-Gm-Message-State: AC+VfDzE+VAAmNnUk+tz0wdwpyy+dk2bri9lRXDreDoEt7L2vkQF95gO
        fxruek1PYeN8WDroUtc+zLRABoXjjRmOqo+upY4=
X-Google-Smtp-Source: ACHHUZ5AQWKp13c+4YCIOR9Q26cUQsGXiuhJ/3B/iGR4LS237JS3+xSV0PcbuWTmgNYIS5sKbE1hOYrH+/b42guBJw4=
X-Received: by 2002:a2e:b74e:0:b0:2af:23dd:fd71 with SMTP id
 k14-20020a2eb74e000000b002af23ddfd71mr4088114ljo.25.1685509929839; Tue, 30
 May 2023 22:12:09 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1537.git.1685126617.gitgitgadget@gmail.com>
In-Reply-To: <pull.1537.git.1685126617.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 30 May 2023 22:11:57 -0700
Message-ID: <CABPp-BFj0+3y7C4FKy9qzVjHWP2r6-=azW8g0j3WGX-zYpaCQQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Create stronger guard rails on replace refs
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com, me@ttaylorr.com,
        gitster@pobox.com, Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 26, 2023 at 11:43=E2=80=AFAM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> (This series is based on tb/pack-bitmap-traversal-with-boundary due to
> wanting to modify prepare_repo_settings() in a similar way.)
>
> The replace-refs can be ignored via the core.useReplaceRefs=3Dfalse confi=
g
> setting. This setting is possible to miss in some Git commands if they do
> not load default config at the appropriate time. See [1] for a recent
> example of this.
>
> [1]
> https://lore.kernel.org/git/pull.1530.git.1683745654800.gitgitgadget@gmai=
l.com/
>
> This series aims to avoid this kind of error from happening in the future=
.
> The idea is to encapsulate the setting in such a way that we can guarante=
e
> that config has been checked before using the in-memory value.
>
> Further, we must be careful that some Git commands want to disable replac=
e
> refs unconditionally, as if GIT_NO_REPLACE_REFS was enabled in the
> environment.
>
> The approach taken here is to split the global into two different sources=
.
> First, read_replace_refs is kept (but moved to replace-objects.c scope) a=
nd
> reflects whether or not the feature is permitted by the environment and t=
he
> current command. Second, a new value is added to repo-settings and this i=
s
> checked after using prepare_repo_settings() to guarantee the config has b=
een
> read.
>
> This presents a potential behavior change, in that now core.useReplaceRef=
s
> is specific to each in-memory repository instead of applying the
> superproject value to all submodules. I could not find a Git command that
> has multiple in-memory repositories and follows OIDs to object contents, =
so
> I'm not sure how to demonstrate it in a test.
>
> Here is the breakdown of the series:
>
>  * Patch 1 creates disable_replace_refs() to encapsulate the global
>    disabling of the feature.
>  * Patch 2 creates replace_refs_enabled() to check if the feature is enab=
led
>    (with respect to a given repository). This is a thin wrapper of the
>    global at this point, but does allow us to remove it from environment.=
h.
>  * Patch 3 creates the value in repo-settings as well as ensures that the
>    repo settings have been prepared before accessing the value within
>    replace_refs_enabled().

Thanks for implementing this.  I had a few questions on the first
patch (though I think one of them was answered by noting that you have
both a global and a repository setting for the flag), but otherwise it
looks good.

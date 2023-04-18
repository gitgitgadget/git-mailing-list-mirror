Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774C3C77B75
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 15:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbjDRPyh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 11:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232457AbjDRPyd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 11:54:33 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A29AB762
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 08:54:27 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-94f7a0818aeso131874466b.2
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 08:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681833266; x=1684425266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mgvzBh5oEO8ATMF3EmQxyXuu7L5qsI/RvBi1FhvpZcc=;
        b=qWp1u8UxIogSzO+vEjZ1fFMJQ+os9bAHew+uFMhl9BcIP9DVCOTZpxunSUtLr2/u/Z
         eID1F82TndK9Axz6MxQtOW+q4jnCD2yt6zT0tYFm6E6FEphq6/e/0t621RMStKtnDwYe
         qqPPIXBoYL37luNe7iZK9HdXSEMyvS5gtnwZ/lIdvGyMJqyFULro0z4OjuHVCunvtb3l
         +w10i/t45HbvhtiZHHEuMRse2t5YDrlJFAv/+MxYoyZFychBkQXlJlTpRuXA3RN/B+gv
         AcdhnobnCO7E/DGP2dpTw0J3WJBwi7jZBU0HLJzq2xw/TLh2/MSLoLUb/FpmgTxtnWDZ
         7bKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681833266; x=1684425266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mgvzBh5oEO8ATMF3EmQxyXuu7L5qsI/RvBi1FhvpZcc=;
        b=D0mNLPNPeLXr7FRAfgTMHFJy7NOfuGxcjvooH89TSOeApAypNbqvvcnN1sopV3el38
         kPTPyKa3iCdxHke//SEHrPLM2xuAbHbGRZbY+MmGAa5LaimWCeIzHRWAcuYEhcD+DevJ
         xfWj9PiFdCIOZ3NYEvYawKIVB56PRWjw9WghstzVkHQbCwedeHA/1RpK1rgTtuYeokZG
         uI4vXOr3ZW289YJ0viYfpy/hhKp6pRS2cQRsQxRhd4wZ5dC6cmia9LI+KlXrgTQMu1ze
         q2XSRgnAy2sDjx+1/c5DpPZI9qo4AxOaBY0rkXg3M0Dsc6xEUpkXPF9Z2RZRzuYm3M5/
         JNrA==
X-Gm-Message-State: AAQBX9fzdkzXDKZTtw9Ovmw4IolClQNrDy0fe6QesmVQFUuHtvGAXmII
        9YyzPMOtlr+dUbbUFCu6LuFRvReZaIliRavZK3laMZZ9xmU=
X-Google-Smtp-Source: AKy350aE1dDZXkFoUfZopjo0uTxPRtFpX/SjxazDNnNwBr2cMMfrfAhW0qUCszZuktvh++kpRKVt0Q/66ppQDg9lE3Q=
X-Received: by 2002:a50:d783:0:b0:504:ca21:cc64 with SMTP id
 w3-20020a50d783000000b00504ca21cc64mr1447153edi.2.1681833265658; Tue, 18 Apr
 2023 08:54:25 -0700 (PDT)
MIME-Version: 1.0
References: <CA+JQ7M_KuDXBaVTzVwLTx+R4-6-3TOuUOpcchkS26iiosc85Hg@mail.gmail.com>
In-Reply-To: <CA+JQ7M_KuDXBaVTzVwLTx+R4-6-3TOuUOpcchkS26iiosc85Hg@mail.gmail.com>
From:   =?UTF-8?B?Q2VtIEfDvG5kb8SfZHU=?= <cscallsign@gmail.com>
Date:   Tue, 18 Apr 2023 17:54:13 +0200
Message-ID: <CAGrwipO7odTbuKgwDmU+3hY0pEeTdjxx-_9=oufUdBzyQ_eRvQ@mail.gmail.com>
Subject: Re: Git rebase no longer defaults to upstream after force push
To:     Erik Cervin Edin <erik@cervined.in>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Erik,

From documentation:

> If <upstream> is not specified, [...] and the --fork-point option is assu=
med.

The --fork-point option does this:

> Use reflog to find a better common ancestor between <upstream> and <branc=
h> when calculating which commits have been introduced by <branch>.

Since the parent of a is still in the reflog of origin/a, it is not
being rebased (the rationale being that the commit *was* in origin/a
at some point). If you want to disable this behavior, add
--no-fork-point option:

git rebase -ir --no-fork-point

Since this is the documented behavior, it probably is not a bug.

Best,
Cem

On Tue, Apr 18, 2023 at 11:34=E2=80=AFAM Erik Cervin Edin <erik@cervined.in=
> wrote:
>
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>
> What did you do before the bug happened? (Steps to reproduce your issue)
>
>   git init --bare foo.git && git clone foo.git/ foo && cd foo
>   touch bar && git add bar && git commit -m init
>   git push -u
>   git switch -c a
>   seq 1 3 > bar && git add bar && git commit -m 1
>   git push
>   seq 11 13 > bar && git add bar && git commit -m 2
>   git rebase -ir # Works like git rebase -ir @{upstream}
>   git push --force origin main:a
>   git rebase -ir # No longer works like git rebase -ir @{upstream}
>
> What did you expect to happen? (Expected behavior)
>
> After force pushing, I still expected the rebase to work like git
> rebase -ir @{upstream}.
>
> What happened instead? (Actual behavior)
>
> The rebase defaults to a commit other than that of the tip of the
> upstream branch.
>
> What's different between what you expected and what actually happened?
>
> Instead of behaving like git rebase @{upstream}, the rebase seems to
> default to rebasing on-top of the old upstream.
>
> git rebase -ir result in a todo like this:
>
> l onto
>
> t onto
> p f1cfbff 2023-04-18    2
>
> Compared to git rebase -ir @{upstream} which results in a todo like this:
>
> l onto
>
> t onto
> p 01e3c92 2023-04-18    1
> p f1cfbff 2023-04-18    2
>
> Anything else you want to add:
>
> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.
>
>
> [System Info]
> git version:
> git version 2.40.0
> cpu: x86_64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> uname: Linux 5.15.90.1-microsoft-standard-WSL2 #1 SMP Fri Jan 27
> 02:56:13 UTC 2023 x86_64
> compiler info: gnuc: 11.3
> libc info: glibc: 2.35
> $SHELL (typically, interactive shell): /bin/bash
>
>
> [Enabled Hooks]
>
> --
> Erik Cervin-Edin

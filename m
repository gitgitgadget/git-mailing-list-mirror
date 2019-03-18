Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5EFD20248
	for <e@80x24.org>; Mon, 18 Mar 2019 16:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbfCRQsv (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 12:48:51 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:38904 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbfCRQsu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 12:48:50 -0400
Received: by mail-ua1-f68.google.com with SMTP id d4so5513877uap.5
        for <git@vger.kernel.org>; Mon, 18 Mar 2019 09:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XDjiHnqOzFaedcws1CFQZPvJGKE5JlHIufzXZiuHlcc=;
        b=PrsI4s4ksPJ7qQ1t7kAnc2b/d6xipgnWj5poPg4x3UCNYiB1T20cKCt6/g5GIU4Mmg
         8TqYUwTz4bPWEYrq5IpoegK9cTg3ZnG3ZVKwBnM/TEBxltPllnJmTkK3udePFmbJPqOe
         V1FjM68flfTm7dap1Trd70F5Jn/eKA+aJjN0Md8MLQMdqy+2ZnkrRGyiNSbq7fUlS+0J
         jB1J2hQRiXt6KpiII1SyeB0FId8MLXKgLeKwHYvi/Pn6VaOioRoBwTaLHk7spN5H28yw
         skl80iW2H6FkG1BbA687XDqwUk4TLmoe3JxSgpmKKdm4FGM4O5HD7y+k0nLYAyMcaWB2
         LlkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XDjiHnqOzFaedcws1CFQZPvJGKE5JlHIufzXZiuHlcc=;
        b=JviXwRYQS+J0GaKvEx1Jogb99UkWwZNQ1zTbhXl9J3Yi0zujf7gU38qPOmzUGiv/I0
         ETYGZ6CYOPOEO0cHHwnmPFKIUuWrSDPuwG7IHbFZJHp6/2SPGxjc4H0VpyXjpBU9z3qe
         U5hslZt26jruuHQP52S7yPKq+4iRUQg7o/0WfjWiA0MJ97gifyBdI8oiFLrYKUUXpDAr
         935Oc/HgcuMulbMO8LoXY6q34POJGaOyU9B9N9pXEozKucyU0Hop27ehoHUGef70xeBx
         VB+AUD4HClmjDGNjwUhsJPR6dwjBBA+0U1hBaiuUQ5m5aBO+tRLd6ojA53RWhy7FWLAN
         F+FA==
X-Gm-Message-State: APjAAAWvZkskd77lQLg+k4gbdhPp+8qsKYdNOjnPD/yHZF4T5Ci11YaT
        fTksre4tifwIXYfN3PEsXIGW+qWGnd9k1ptrXu4=
X-Google-Smtp-Source: APXvYqyL9hMrXRMzz76vwadkXA72kHDXo5NibdioZTG3i584WLMdY1ahjorsuAbUTS6PfGtZ2PqK0+keSUmGcUgjGho=
X-Received: by 2002:ab0:2712:: with SMTP id s18mr6329588uao.114.1552927729250;
 Mon, 18 Mar 2019 09:48:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190308095752.8574-1-pclouds@gmail.com> <20190317124926.17137-1-pclouds@gmail.com>
 <20190317124926.17137-13-pclouds@gmail.com>
In-Reply-To: <20190317124926.17137-13-pclouds@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 18 Mar 2019 09:48:36 -0700
Message-ID: <CABPp-BE+9cmd-gR=ZRR2v1gpjduoQ0hQCL+57nmaiG45RZTB9g@mail.gmail.com>
Subject: Re: [PATCH v4 12/26] checkout: split part of it to new command 'switch'
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Eckhard_Maa=C3=9F?= <eckhard.s.maass@googlemail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 17, 2019 at 5:50 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <=
pclouds@gmail.com> wrote:
>
> "git checkout" doing too many things is a source of confusion for many
> users (and it even bites old timers sometimes). To remedy that, the
> command will be split into two new ones: switch and restore. The good
> old "git checkout" command is still here and will be until all (or most
> of users) are sick of it.
>
> See the new man page for the final design of switch. The actual
> implementation though is still pretty much the same as "git checkout"
> and not completely aligned with the man page. Following patches will
> adjust their behavior to match the man page.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---

Looking really good.  Just some minor comments...

> +git-switch(1)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +NAME
> +----
> +git-switch - Switch branches
> +
> +SYNOPSIS
> +--------
> +[verse]
> +'git switch' [<options>] [--guess] <branch>

Should this now use [--no-guess] since --guess is the default?

> +'git switch' [<options>] --detach [<start-point>]
> +'git switch' [<options>] (-c|-C|--orphan) <new-branch> [<start-point>]
> +
> +DESCRIPTION
> +-----------
> +Switch to a specified branch. The working tree and the index are
> +updated to match the branch. All new commits will be added to the tip
> +of this branch.
> +
> +Optionally a new branch could be created with either `-c`, `-C`,
> +automatically from a remote branch of same name (see `--guess`), or
> +detach the working tree from any branch with `--detach`, along with
> +switching.
> +
> +Switching branches does not require a clean index and working tree
> +(i.e. no differences compared to `HEAD`). The operation is aborted
> +however if the switch leads to loss of local changes, unless told
> +otherwise.

Maybe s/otherwise./otherwise with --discard-changes or --merge./, just
for a little extra clarity?

> +-f::
> +--force::
> +       An alias for `--discard-changes`.
> +
> +--discard-changes::
> +       Proceed even if the index or the working tree differs from
> +       `HEAD`. Both the index and working tree are restored to match
> +       the switching target. This is used to throw away local
> +       changes.

It looks like elsewhere you and Junio discussed making --force also
imply --ignore-in-progress.  That option should be moved close to
--force, so that similar options are adjacent, but it also brings up a
question for me:

Is --force an alias for both `--discard-changes` and
`--ignore-in-progress`, or is `--discard-changes` really just another
name for `--force` (i.e. does it too imply `--ignore-in-progress`)?
I'd be tempted to say the former, but I'm curious on others' thoughts.

> +--orphan <new-branch>::
> +       Create a new 'orphan' branch, named `<new-branch>`. If
> +       `<start-point>` is specified, the index and working tree are
> +       adjusted to match it. Otherwise both are adjusted to contain no
> +       tracked files.

Thanks.  I'm still slightly hesitant about whether <start-point>
should be allowed with --orphan; it seems equivalent to me to letting
people have a flag for switching to existing branch A while forcing
the index and working tree to match branch B (defaulting B to HEAD
from before the switch).  Having <start-point> and --orphan together
is just a special case of this idea, and thus allowing those together
seems like it'll cause the more general request to be filed at some
point, and we will already have the precedent of supporting it
somewhere.  This usecase seems to be somewhat esoteric and infrequent,
and could be easily obtained by combining other commands.  I'm worried
that trying to explain this usecase may make the documentation for the
common everyday commands even more complex, and these manpages are
already kind of long.  However, as I said above, that's just a slight
hesitation and maybe I'm just excessively worried about the length of
our manpages for the most common commands.  This new description of
--orphan at least gets the default behavior right.


Great work so far; thanks for working on this.

Elijah

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 416661F404
	for <e@80x24.org>; Wed, 15 Aug 2018 17:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729481AbeHOUCy (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 16:02:54 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:45537 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727604AbeHOUCy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 16:02:54 -0400
Received: by mail-yw1-f66.google.com with SMTP id 139-v6so1324196ywg.12
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 10:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zgrUP3FS1zl2MOp9aKHYL3qE0TxJ0DCj0fnTUwFFqrk=;
        b=EsS3FhC+xLDcWz3G1gBDaA80BZOg819JPQc1lT+mwD9hqE6AN/wO4pLb20Wu3cKtOc
         ej42lfUSOP1/OELUJMeDMCpF4+hNyzT/bYKDgVPNTpCKs2NOqUCkMQl6TwDYQjE4F++l
         PWXxcTiKof6bsVp0OTvAU9pq09LGFg1c1D/httckp0PM+rZZ+Er33mu/ozjR0bJNUamz
         H6tgIYLDgrou6E2gxEC6FtnOpVMm7lXV8i++3AsUnSFTNXkO+6c1hcp02PqSDkF3y9YD
         ZOJ+2MspsXfKPQ7cOMFnUeSJDADI1h8Ff/wZ8iWDsmWEqaBbgVi0I5YbyBtri59yytxy
         bm6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zgrUP3FS1zl2MOp9aKHYL3qE0TxJ0DCj0fnTUwFFqrk=;
        b=mmj4WydXTZe6qUcstdX3bwTboVN3eT3ADJI8gXFKkYZK5HE6jELtLg8hZYJ35TlTDH
         eHZuqJXDdC+2SADnlKiT1zrVJ41VVvvmn0XN6X1JwVLypTeYa4P+dReqFEaKDy7f5GJN
         qfrorQ5areHzMfRBR5DAEEAup1TUSJmWP07tvGkEWuq/wLfQtPGq3yyN6QcaA76IAz34
         ERIQIqg1MFxAfOebdfbGy63kjbEENc7bkFsy/YcqIhF5QLXvgSc0F/XEA6W1NumqsNDd
         e8jt33rqz9eL9IBFE5xeFHgLK2PAP7Jw+YtNncjSbUU2lI109bXKRrqBJbsCYEQBNIDO
         earQ==
X-Gm-Message-State: AOUpUlG1+vM1OmqrVULesDqEnhWnr9c4Ln4e4irefEesFkTWrAXvEm/z
        pUbME0xZfLDcPEKNuzvaIrFVc7YYwzgx8N6U8ZXqWQ==
X-Google-Smtp-Source: AA+uWPxLVr5hT2DC5BV3eeZ/9NAq8qyIhry3RlvjyWm7V38Pw1wc8Ygk1nI36o4Lw4ngxsqn30EGUqBmLVYMWs0js3Y=
X-Received: by 2002:a81:af67:: with SMTP id x39-v6mr14147530ywj.33.1534352994311;
 Wed, 15 Aug 2018 10:09:54 -0700 (PDT)
MIME-Version: 1.0
References: <20180815162308.17747-1-pclouds@gmail.com> <20180815162308.17747-2-pclouds@gmail.com>
In-Reply-To: <20180815162308.17747-2-pclouds@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 15 Aug 2018 10:09:43 -0700
Message-ID: <CAGZ79kYo-icUHfezTMg77s_2GtKcgH6jysNTu11XOoL4UT-9bQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] cherry-pick: fix --quit not deleting CHERRY_PICK_HEAD
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 15, 2018 at 9:23 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <=
pclouds@gmail.com> wrote:
>
> --quit is supposed to be --abort but without restoring HEAD. Leaving
> CHERRY_PICK_HEAD behind could make other commands mistake that
> cherry-pick is still ongoing (e.g. "git commit --amend" will refuse to
> work). Clean it too.
>
> For abort, this job of deleting CHERRY_PICK_HEAD is on "git reset" so
> we don't need to do anything else.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
>  builtin/revert.c                | 9 +++++++--
>  t/t3510-cherry-pick-sequence.sh | 3 ++-
>  2 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/revert.c b/builtin/revert.c
> index 76f0a35b07..e94a4ead2b 100644
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -7,6 +7,7 @@
>  #include "rerere.h"
>  #include "dir.h"
>  #include "sequencer.h"
> +#include "branch.h"
>
>  /*
>   * This implements the builtins revert and cherry-pick.
> @@ -191,8 +192,12 @@ static int run_sequencer(int argc, const char **argv=
, struct replay_opts *opts)
>         opts->gpg_sign =3D xstrdup_or_null(opts->gpg_sign);
>         opts->strategy =3D xstrdup_or_null(opts->strategy);
>
> -       if (cmd =3D=3D 'q')
> -               return sequencer_remove_state(opts);
> +       if (cmd =3D=3D 'q') {
> +               int ret =3D sequencer_remove_state(opts);
> +               if (!ret)
> +                       remove_branch_state(the_repository);

Technically you would not need patch 1 in this series, as you could call
remove_branch_state(void) as before that patch to do the same thing here.
I guess that patch 1 is more of a drive by cleanup, then?

It looks a bit interesting as sequencer_remove_state actually
takes no arguments and assumes the_repository, but I guess that is fine.

I wondered if we need to have this patch for 'a' as well, and it looks like
which does a sequencer_rollback, which is just some logic before
attempting sequencer_remove_state. So I'd think remove_branch_state
could be done in sequencer_remove_state as well?

Or are there functions that would definitely not want sequencer_remove_stat=
e
after sequencer_remove_state?

Going down on that I just realize sequencer_remove_state could also
be returning void, as of now it always returns 0, so the condition here
with !ret is just confusing the reader?

Thanks,
Stefan

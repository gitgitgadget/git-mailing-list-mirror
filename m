Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74786C47087
	for <git@archiver.kernel.org>; Fri, 28 May 2021 20:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D72E6127C
	for <git@archiver.kernel.org>; Fri, 28 May 2021 20:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbhE1UyH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 16:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhE1UyG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 16:54:06 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CDEC061574
        for <git@vger.kernel.org>; Fri, 28 May 2021 13:52:30 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id j26-20020a4adf5a0000b029020eac899f76so1232959oou.7
        for <git@vger.kernel.org>; Fri, 28 May 2021 13:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mbZfaQ7LwvcpL1wyHlt91JDjrhcrucl9rgMrPKvOdn0=;
        b=lJBakIw3n0FhBNbsJWfgxIZwDBefRs0jBX3NC92rtrSxC7jSGFAZiKHEZ1x1erdqDa
         Viu39fwdQibZwZGhZUMsOr1FbNhPtFVFMiFE2DmKF0gUNIw+5VAgRstko4+Gzi7Qodek
         XRqjw10C6cl3YP4SEncCDr0vV5fSpneHskElAFjzU9hlGJm1IzDtt8Im+Z6us76x6CYg
         vFVjm/2zYipHFSlHg3OBs+viCsaa9DVerCjSt13RgK3UKkNeXXBIeoEkVpwBkCaEMg1S
         pv3JIN9yvLA5LPtsp7wQ/cyAFp55nnVR0EeaCqu2na4OIPVV/88zPywO4MzSKm/ZRFpW
         NYww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mbZfaQ7LwvcpL1wyHlt91JDjrhcrucl9rgMrPKvOdn0=;
        b=qtILobLB8poXHo1mA/VZ2uu1TProiO8H1I3tcEg+/rezFzEL/hYaCneTlQTjFVWl6l
         QSD9hrlU9TH1/FVotSAYzLzT9ZROBTh1yuMEIqalUSzvdYmgC05RpVKoVLMPcwEezKJF
         /0AiKovIrKyVE8aweVqeEXBIen8OQe4fvcp/C2XPEgYe5Llid4cqUuduGE7lqrsaCFRr
         cPLpzgXrj78QsE8bjelCeGPRySZ5naXGbJTobb7YnsaVzkEfKyUjx/TiLa39yfoEnH5y
         Cp8aukp6MXiYiOelu4SqH0jINF42SC030iFtnlfsZ5bgMLysNEOFIcfYNeZSFGAP2sba
         gZbg==
X-Gm-Message-State: AOAM532aFYu/fm1cEKm5P3tQqhWUjwHYzZtE6yb+/BOl4dat26iMCZPS
        i22gpRw5HmrFPr2gPgBRKf0UYqY5b+ofVlVvcYI=
X-Google-Smtp-Source: ABdhPJyHt5Ws+PiBFMMZxSBZnMOniAwsiP7ugg+gKKt4o1BHt+T8zUwoaprxc96p+FjNYzXaRToEgiRqvlrHUXuJSt8=
X-Received: by 2002:a4a:b301:: with SMTP id m1mr8399792ooo.7.1622235149968;
 Fri, 28 May 2021 13:52:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210528201014.2175179-1-felipe.contreras@gmail.com> <20210528201014.2175179-4-felipe.contreras@gmail.com>
In-Reply-To: <20210528201014.2175179-4-felipe.contreras@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 28 May 2021 13:52:19 -0700
Message-ID: <CABPp-BFPXWy0GwZwT0weNs1DKMKFC4ds2tLJWcVQBOKxPMomFQ@mail.gmail.com>
Subject: Re: [PATCH 03/11] push: reorganize setup_push_simple()
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Mathias Kunter <mathiaskunter@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramkumar Ramachandra <r@artagnon.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 28, 2021 at 1:10 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> Simply move the code around.

Not quite, you also deleted dead code.  Made the patch a bit harder to
read because I was trying to verify you did what the commit message
said and it took me longer than it should have to realize that you
were also deleting dead code.  Might be worth including that fact in
this sentence here.

> No functional changes.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  builtin/push.c | 29 ++++++++++++-----------------
>  1 file changed, 12 insertions(+), 17 deletions(-)
>
> diff --git a/builtin/push.c b/builtin/push.c
> index d173c39283..9c807ed707 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -225,13 +225,14 @@ static void setup_push_current(struct remote *remote, struct branch *branch)
>
>  static void setup_push_simple(struct remote *remote, struct branch *branch, int triangular)
>  {
> +       const char *dst;
> +
> +       if (!branch)
> +               die(_(message_detached_head_die), remote->name);
> +
>         if (triangular) {
> -               if (!branch)
> -                       die(_(message_detached_head_die), remote->name);
> -               refspec_appendf(&rs, "%s:%s", branch->refname, branch->refname);
> +               dst = branch->refname;
>         } else {
> -               if (!branch)
> -                       die(_(message_detached_head_die), remote->name);
>                 if (!branch->merge_nr || !branch->merge || !branch->remote_name)
>                         die(_("The current branch %s has no upstream branch.\n"
>                             "To push the current branch and set the remote as upstream, use\n"
> @@ -243,20 +244,14 @@ static void setup_push_simple(struct remote *remote, struct branch *branch, int
>                 if (branch->merge_nr != 1)
>                         die(_("The current branch %s has multiple upstream branches, "
>                             "refusing to push."), branch->name);
> -               if (triangular)
> -                       die(_("You are pushing to remote '%s', which is not the upstream of\n"
> -                             "your current branch '%s', without telling me what to push\n"
> -                             "to update which remote branch."),
> -                           remote->name, branch->name);

This if-block is safe to delete because we're already in the !triangular case.


> -
> -               if (1) {
> -                       /* Additional safety */
> -                       if (strcmp(branch->refname, branch->merge[0]->src))
> -                               die_push_simple(branch, remote);
> -               }
>
> -               refspec_appendf(&rs, "%s:%s", branch->refname, branch->merge[0]->src);
> +               /* Additional safety */
> +               if (strcmp(branch->refname, branch->merge[0]->src))
> +                       die_push_simple(branch, remote);
> +
> +               dst = branch->merge[0]->src;
>         }
> +       refspec_appendf(&rs, "%s:%s", branch->refname, dst);
>  }
>
>  static int is_workflow_triangular(struct remote *remote)
> --
> 2.32.0.rc0

Everything else is, as you say, just moving code around.

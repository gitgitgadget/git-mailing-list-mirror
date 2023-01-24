Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12FDC38142
	for <git@archiver.kernel.org>; Tue, 24 Jan 2023 15:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbjAXPme (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Jan 2023 10:42:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235278AbjAXPmT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2023 10:42:19 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4B64C6D8
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 07:42:04 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id z7so17124975ljz.4
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 07:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4CPzwt4J6r/zq6aEs2+u5Q6u+Hf9MTY9dz8UUSfNeeY=;
        b=SurKPVbYvU8w3lX3XqSWXk+2sdIUJf6SgUycRgtHNuUBvEzwvbh/yXj6N+zfoPg/Mt
         5MK2HUhZ4YpVny3n0cfgmdYRXTU/4LMAOKZk0XmFllYIS9AWmegyTv6HikZs3iPgHeqS
         2KczeadZ7UJ53HaqhDSfPPnVR6CIHVjVoC+UTyEmCAXP1/YufIDs7osS2Yx1yYcgZZfJ
         tROEKo3lHO+3UC002i01XEt+3EpnrOXFkrQph2kmca4xfGQHMEOdo8lPwA2R0MT+9eb2
         cnNoWdS37Yy6wbahJX5c4ShCoP473ynhTCsBC6F8h/PZkc8CRPktNbJbhz5NVD/X0htV
         urAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4CPzwt4J6r/zq6aEs2+u5Q6u+Hf9MTY9dz8UUSfNeeY=;
        b=vjWq0oFsb159alBDkLKOhEteGSC2nFEuJwsuHf/AF+X+0CWu0lbsYqphwNr3RboDZp
         LbowyY4oybA32+8vHHE+vmqvomcj0O30Rs5SHNBQNqsRc/liaCGqfh8SCkGBR+qNvhcd
         rIoumuTKz0v9pAzuDwCFaxHX9b9X3QM6Niem9CprnhaF6D1m6ipUIR70hdnTHB/Q8rPE
         rIhdP2750ejeAwvewQgTn0aWtpbo0ncDP9OMxbgl3xlBZbxOBa8agyMNHP6aludrF98b
         Pbk25uPsc+awxYQOVgVazknGKGnasWljC1Yh4eKUPQCibrVYuqR39lRiuBdGxPCKSqCt
         gmgQ==
X-Gm-Message-State: AFqh2krwJEpxHcIxZ1Ig6wQQUrJQ6TDbD96Qt+RbK0ZQXxW1GETvBqrM
        Y9W8O2/RKKRrZBFW6myavmHCzyCgIXBgeIg4Lr4SjGrxbp4=
X-Google-Smtp-Source: AMrXdXs1WBooYHFgFdwerRvJy1GK/rGIPQirJ4cIb2g3ax4CrwP+RkWHwgsLYwU5YguSFHxgIaQrF6eIqGhmEX6NgTY=
X-Received: by 2002:a2e:9842:0:b0:289:c64d:cba2 with SMTP id
 e2-20020a2e9842000000b00289c64dcba2mr2669813ljj.325.1674574922875; Tue, 24
 Jan 2023 07:42:02 -0800 (PST)
MIME-Version: 1.0
References: <pull.1466.v3.git.1674266126.gitgitgadget@gmail.com>
 <pull.1466.v4.git.1674367961.gitgitgadget@gmail.com> <5e4851e611ee18112bd71939ee900e02a8d590c5.1674367961.git.gitgitgadget@gmail.com>
 <759fb313-ce88-4eb7-96c0-4adeb75ca9f9@dunelm.org.uk> <CABPp-BE+wRgjmWknARQpNsdUFjNOz0ND9wgx_-_RTyK+EwJjXA@mail.gmail.com>
 <83d27162-59d4-d8c0-fde3-f522630d024d@dunelm.org.uk> <7b9ee972-2680-2e1b-bef3-201d8a1e4bdd@dunelm.org.uk>
In-Reply-To: <7b9ee972-2680-2e1b-bef3-201d8a1e4bdd@dunelm.org.uk>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 24 Jan 2023 07:41:48 -0800
Message-ID: <CABPp-BHVUc7EdY9z_TPcHspCak6Yc3mfDXUkivj4zq_fJem3SQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/9] rebase: add coverage of other incompatible options
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

Hi Phillip,

On Tue, Jan 24, 2023 at 5:16 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> >>>> Signed-off-by: Elijah Newren <newren@gmail.com>
> >>>> --- a/builtin/rebase.c
> >>>> +++ b/builtin/rebase.c
> >>>> @@ -1224,6 +1224,26 @@ int cmd_rebase(int argc, const char **argv,
> >>>> const char *prefix)
> >>>>                if (options.fork_point < 0)
> >>>>                        options.fork_point = 0;
> >>>>        }
> >>>> +     /*
> >>>> +      * The apply backend does not support
> >>>> --[no-]reapply-cherry-picks.
> >>>> +      * The behavior it implements by default is equivalent to
> >>>> +      * --no-reapply-cherry-picks (due to passing --cherry-picks to
> >>>> +      * format-patch), but --keep-base alters the upstream such
> >>>> that no
> >>>> +      * cherry-picks can be found (effectively making it act like
> >>>> +      * --reapply-cherry-picks).
> >>>> +      *
> >>>> +      * Now, if the user does specify --[no-]reapply-cherry-picks, but
> >>>> +      * does so in such a way that options.reapply_cherry_picks ==
> >>>> +      * keep_base, then the behavior they get will match what they
> >>>> +      * expect despite options.reapply_cherry_picks being ignored.  We
> >>>> +      * could just allow the flag in that case, but it seems better to
> >>>> +      * just alert the user that they've specified a flag that the
> >>>> +      * backend ignores.
> >>>> +      */
> >>>
> >>> I'm a bit confused by this. --keep-base works with either
> >>> --reapply-cherry-picks (which is the default if --keep-base is given) or
> >>> --no-reapply-cherry-picks. Just below this hunk we have
> >>>
> >>>          if (options.reapply_cherry_picks < 0)
> >>>                  options.reapply_cherry_picks = keep_base;
> >>>
> >>> So we only set options.reapply_cherry_picks to match keep_base if the
> >>> user did not specify -[-no]-reapply-cherry-picks on the commandline.
> >>
> >> options.reapply_cherry_picks is totally ignored by the apply backend,
> >> regardless of whether it's set by the user or the setup code in
> >> builtin/rebase.c.  And if we have an option which is ignored, isn't it
> >> nicer to provide an error message to the user if they tried to set it?
> >>
> >> Said another way, while users could start with these command lines:
> >>
> >>      (Y) git rebase --whitespace=fix
> >>      (Z) git rebase --whitespace=fix --keep-base
> >>
> >> and modify them to include flags that would be ignored, we could allow:
> >>
> >>      (A) git rebase --whitespace=fix --no-reapply-cherry-picks
> >>      (B) git rebase --whitespace=fix --keep-base --reapply-cherry-picks
> >>
> >> But we could not allow commands like
> >>
> >>      (C) git rebase --whitespace=fix --reapply-cherry-picks
> >>      (D) git rebase --whitespace=fix --keep-base
> >> --no-reapply-cherry-picks
> >
> > (C) is already an error
> > (D) is currently allowed and I think works as expected (--keep-base only
> > implies --reapply-cherry-picks, the user is free to override that with
> > --no-reapply-cherry-picks) so I don't see why we'd want to make it an
> > error.

Ah, despite looking over the code multiple times to check my
statements, I somehow kept missing this:

    if (keep_base && options.reapply_cherry_picks)
        options.upstream = options.onto;

which is how --[no-]reapply-cherry-picks is supported in conjunction
with --keep-base.  Thanks.

> >> For all four cases (A)-(D), the apply backend will ignore whatever
> >> --[no-]reapply-cherry-picks flag is provided.
> >
> > For (D) the flag is respected, (C) errors out, the other cases
> > correspond to the default so it's like saying
> >
> >      git rebase --merge --no-reapply-cherry-picks
> >
> > ignores the flag.
>
> On reflection that is only true for (B). I agree that we should error
> out on (A) which we don't at the moment.
>
> I'd support a change that errors out on (A) and (C) but continues to
> allow (B) and (D). I think we can do that with the diff below
>
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 1481c5b6a5..66aef356b8 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1230,12 +1230,6 @@ int cmd_rebase(int argc, const char **argv, const
> char *prefix)
>                   if (options.fork_point < 0)
>                           options.fork_point = 0;
>           }
> -        /*
> -         * --keep-base defaults to --reapply-cherry-picks to avoid losing
> -         * commits when using this option.
> -         */
> -        if (options.reapply_cherry_picks < 0)
> -                options.reapply_cherry_picks = keep_base;
>
>           if (options.root && options.fork_point > 0)
>                   die(_("options '%s' and '%s' cannot be used
> together"), "--root", "--fork-point");
> @@ -1412,11 +1406,17 @@ int cmd_rebase(int argc, const char **argv,
> const char *prefix)
>           if (options.empty != EMPTY_UNSPECIFIED)
>                   imply_merge(&options, "--empty");
>
> -        /*
> -         * --keep-base implements --reapply-cherry-picks by altering
> upstream so
> -         * it works with both backends.
> -         */
> -        if (options.reapply_cherry_picks && !keep_base)
> +        if (options.reapply_cherry_picks < 0)
> +                /*
> +                 * --keep-base defaults to --reapply-cherry-picks to
> +                 * avoid losing commits when using this option.
> +                 */

I know you were copying the previous comment, but this comment is
really confusing to me.  Shouldn't it read "--reapply-cherry-picks
defaults to --keep-base" instead of vice-versa?

> +                options.reapply_cherry_picks = keep_base;
> +        else if (!keep_base)
> +                /*
> +                 * --keep-base implements --reapply-cherry-picks by

Should this be --[no-]reapply-cherry-picks, to clarify that it handles
both cases?  Especially given how many times I missed it?

> +                 * altering upstream so it works with both backends.
> +                 */
>                   imply_merge(&options, "--reapply-cherry-picks");

And perhaps this should be

    imply_merge(&options, options.reapply_cherry_picks ?
"--reapply-cherry-picks" :
         "--no-reapply-cherry-picks");

Also, the comment in git-rebase.txt about incompatibilities would become

     * --[no-]reapply-cherry-picks, when --keep-base is not provided

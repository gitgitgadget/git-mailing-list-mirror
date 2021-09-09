Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 072E5C433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 15:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC47060F92
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 15:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236843AbhIIPFG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 11:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237264AbhIIPEt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 11:04:49 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C04BC061575
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 08:03:39 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id l16-20020a9d6a90000000b0053b71f7dc83so2837763otq.7
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 08:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WXEr7HSbx3j8z9w94QNzjsbAHIeBHIpCUgBiWk8p7ro=;
        b=pMVPHcTN2So/VTVImHPrdlPk+dYWsbI+Xc35DujjG5VohQRy1dbytRiOXK47u0UAQh
         LsCGinpdNWwxsGfJlhDySR0sJnPA2mIMx9oAnGdjHUbwUUIg5100xnQbQY7tADV8xu09
         GHz7rxK/+DAQ7SEPN91AOYv4MJ89Yr2xCbhfZyd6mk3HA9nF6SkD+eTKp9sCrQv3muHO
         mxRqJMuhzDzTWpvSjKR8o+ROy+EKYwmQrzZMLkgTftfPfiQgYjvzGi0IgKqpy63xTffK
         S6YnaqNanv4izk0+3dnavt6qHE5uSCh5qWnry8u+ZsIC0YVhxd5itFwajMTwFysN/s95
         /PMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WXEr7HSbx3j8z9w94QNzjsbAHIeBHIpCUgBiWk8p7ro=;
        b=PG6pwHlnIJ+lQuVaxxjOmDfQ1mrM4EkodUL8Z//V2gAMFAU2AzWD1Ijos/43gEeBBR
         QboUXzmyVJ1OsXXfZxfXI+bbK5pT3epI5HEzSjsvERARLOQcVVkYFbJKjh5hHQtBtb2Q
         /mQEZlT8zur6zn/D3FMfAGaLSoanHaq5v+fRgDYUoCiKx18nMDSML+3tVLjQ+YsISzYm
         PWyOzN6Irey3pmJsJg4wmqMtPaZlrUKBGTRLWJc+40Dmw5U6UV17UQsM/AUvMS8Ns78t
         TupbjkoxFkp+OzqfMF7Qqe3OX0/RZLN4zV7QtBQGVv77o+5Gxstkt2lenK3ITXSFAfLn
         Nm5Q==
X-Gm-Message-State: AOAM533tM9/nwkFuoiTOVMZXhVFvX/8pCJz2Pf0KiatI86w1BjTyRKZd
        WwBx9y/FquC+9n1Dg6dUjvRoTqqjbpUFdPdLs8g=
X-Google-Smtp-Source: ABdhPJy10QyVCz6yiS1yug5x9jQDfWQn6QG/9CPVp8us53g/J4gyr68URDaG7+iZdTAoo72vAKsteNEBHwrjBHFXS5w=
X-Received: by 2002:a9d:7204:: with SMTP id u4mr265581otj.276.1631199818783;
 Thu, 09 Sep 2021 08:03:38 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1034.git.1631108472.gitgitgadget@gmail.com> <39ad40c9297531a2d42b7263a1d41b1ecbc23c0a.1631108472.git.gitgitgadget@gmail.com>
In-Reply-To: <39ad40c9297531a2d42b7263a1d41b1ecbc23c0a.1631108472.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 9 Sep 2021 08:03:27 -0700
Message-ID: <CABPp-BG=pWhLpjKKSbgUyuaSEwjdkhwv8Vb1Ut1-n3LziSy_pQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] rebase -i: don't fork git checkout
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 8, 2021 at 6:44 AM Phillip Wood via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> The "apply" based rebase has avoided forking git checkout since
> ac7f467fef ("builtin/rebase: support running "git rebase <upstream>"",
> 2018-08-07). The code that handles the checkout was moved into libgit
> by b309a97108 ("reset: extract reset_head() from rebase", 2020-04-07)
> so lets start using it for the "merge" based rebase as well. This
> opens the way for us to stop calling the post-checkout hook in the
> future.

Wahoo!  So exciting to see this, and for the future plans mentioned here.  :-)

> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  sequencer.c | 29 ++++-------------------------
>  1 file changed, 4 insertions(+), 25 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index d51440ddcd9..1a9dbc70d3c 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -4192,42 +4192,21 @@ int apply_autostash_oid(const char *stash_oid)
>         return apply_save_autostash_oid(stash_oid, 1);
>  }
>
> -static int run_git_checkout(struct repository *r, struct replay_opts *opts,
> -                           const char *commit, const char *action)
> -{
> -       struct child_process cmd = CHILD_PROCESS_INIT;
> -       int ret;
> -
> -       cmd.git_cmd = 1;
> -
> -       strvec_push(&cmd.args, "checkout");
> -       strvec_push(&cmd.args, commit);
> -       strvec_pushf(&cmd.env_array, GIT_REFLOG_ACTION "=%s", action);
> -
> -       if (opts->verbose)
> -               ret = run_command(&cmd);
> -       else
> -               ret = run_command_silent_on_success(&cmd);
> -
> -       if (!ret)
> -               discard_index(r->index);
> -
> -       return ret;
> -}
> -
>  static int checkout_onto(struct repository *r, struct replay_opts *opts,
>                          const char *onto_name, const struct object_id *onto,
>                          const struct object_id *orig_head)
>  {
>         const char *action = reflog_message(opts, "start", "checkout %s", onto_name);
>
> -       if (run_git_checkout(r, opts, oid_to_hex(onto), action)) {
> +       if (reset_head(r, onto, "checkout", NULL, RESET_HEAD_DETACH |
> +                      RESET_ORIG_HEAD | RESET_HEAD_RUN_POST_CHECKOUT_HOOK,
> +                      NULL, action, "rebase")) {
>                 apply_autostash(rebase_path_autostash());
>                 sequencer_remove_state(opts);
>                 return error(_("could not detach HEAD"));
>         }
>
> -       return update_ref(NULL, "ORIG_HEAD", orig_head, NULL, 0, UPDATE_REFS_MSG_ON_ERR);
> +       return 0;
>  }
>
>  static int stopped_at_head(struct repository *r)
> --
> gitgitgadget

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D665CC07E94
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 08:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD10D6141D
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 08:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhFDIXO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Jun 2021 04:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbhFDIXN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jun 2021 04:23:13 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B7CC06174A
        for <git@vger.kernel.org>; Fri,  4 Jun 2021 01:21:14 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id g18so8148766edq.8
        for <git@vger.kernel.org>; Fri, 04 Jun 2021 01:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Osr2OPeiUTKPM6lfWrOet8Oi5HSdaXxcd7Iragds4ao=;
        b=knda8nGF3MB6bVfCwRDNjjDkLzXoVwm6HUQTy1/Zoi1Enz+B0YSQLNyyNvqw0sG4pL
         5asU6ARL5eJUIl8/1QZDsx/nu0ZgaxgyXJkteBGou+uBEq6/Q6pEtmOOIUXdZ48/W1dM
         vkNg+Js9Id1DlIsdN6nXuDCiKfso+2Pj2zXW8j+4GKyTgzD1c4/2LROQp33plW2EOU10
         9gVU4UN30PuF/FeLNg3LAWmRc/iZD2LSiATHd/lvc9cvI1oqcM5g77FsMKX9Gz9wNpDH
         7qziVrTAX6KF1LKfQVifLoqA1CK+zRjmV8Eo5Vp15oK94etMNyNjww+i583Una2W3VVs
         VlCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Osr2OPeiUTKPM6lfWrOet8Oi5HSdaXxcd7Iragds4ao=;
        b=GnYfIRS45wTzt1lwK82nnzNtD8O97OrpZnwCuulX+rExH6MhOFHxPfuc6qCxjk+G+o
         L3lNiHVumwDRX5B1zAJl8YuNhmpZbcsDjavhnk3HJKAyTjD1yd0UK5NrxixLcQORx5cW
         rhHvIQGh/DFUjoUEIMMRDaEF1ezpuWdkMleirWfDyoOnYPDjjDADsRjAl/DBVOqCR2tj
         G9zrokw7P5PN8b2BwsyT6qkNlPzK2959ZEAxwJeTu3/8EuyWi68FtTmP0818GgUGkU4G
         nJa8QmjtiAFgTKGIRFlozYhBh7IOf3b3R/+XJC3e7Ar0PhqEJsFJSGGZi4b/LLwVPJER
         RgWQ==
X-Gm-Message-State: AOAM5307GE+tY0/6bFrpikMBSnyRcaVzPs6C6a/kdCl8we7izyCdkIIv
        qebJYl7NOaApJ2mL+/g5bnj7Kb5Boj/z+gQX6MI=
X-Google-Smtp-Source: ABdhPJzfjJosB+PhsfLOIAhWIFeoAbNv8E8Ey13N0e6rdbJK68SA7yFX2P5QlgtZkO9//ERIfDvvgCJFv/Cu7dM4sxQ=
X-Received: by 2002:a05:6402:35c4:: with SMTP id z4mr3450666edc.362.1622794873333;
 Fri, 04 Jun 2021 01:21:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210528081224.69163-1-raykar.ath@gmail.com> <20210602131259.50350-1-raykar.ath@gmail.com>
In-Reply-To: <20210602131259.50350-1-raykar.ath@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 4 Jun 2021 10:21:02 +0200
Message-ID: <CAP8UFD01-VJpUEGg3cEG7X=xU0KCv1AEgq2n_qhk=U+rXV5mvA@mail.gmail.com>
Subject: Re: [PATCH v2] [GSoC] submodule--helper: introduce add-clone subcommand
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 2, 2021 at 3:13 PM Atharva Raykar <raykar.ath@gmail.com> wrote:

> +static void show_fetch_remotes(FILE *output, const char *sm_name, const char *git_dir_path)
> +{
> +       struct child_process cp_remote = CHILD_PROCESS_INIT;
> +       struct strbuf sb_remote_out = STRBUF_INIT;
> +
> +       cp_remote.git_cmd = 1;
> +       strvec_pushf(&cp_remote.env_array,
> +                    "GIT_DIR=%s", git_dir_path);
> +       strvec_push(&cp_remote.env_array, "GIT_WORK_TREE=.");
> +       strvec_pushl(&cp_remote.args, "remote", "-v", NULL);
> +       if (!capture_command(&cp_remote, &sb_remote_out, 0)) {
> +               char *line;
> +               char *begin = sb_remote_out.buf;
> +               char *end = sb_remote_out.buf + sb_remote_out.len;
> +               while (begin != end && (line = get_next_line(begin, end))) {
> +                       char *name, *url, *tail;
> +                       name = parse_token(&begin, line);
> +                       url = parse_token(&begin, line);
> +                       tail = parse_token(&begin, line);

Sorry for not replying to your earlier message, but I think it's a bit
better to save a line with:

                       char *name = parse_token(&begin, line);
                       char *url = parse_token(&begin, line);
                       char *tail = parse_token(&begin, line);

> +                       if (!memcmp(tail, "(fetch)", 7))
> +                               fprintf(output, "  %s\t%s\n", name, url);
> +                       free(url);
> +                       free(name);
> +                       free(tail);
> +               }
> +       }
> +
> +       strbuf_release(&sb_remote_out);
> +}
> +
> +static int add_submodule(const struct add_data *info)
> +{
> +       char *submod_gitdir_path;
> +       /* perhaps the path already exists and is already a git repo, else clone it */
> +       if (is_directory(info->sm_path)) {
> +               printf("sm_path=%s\n", info->sm_path);

I don't see which shell code the above printf(...) instruction is
replacing. That's why I asked if it's some debugging leftover.

[...]

> +               if (info->dissociate)
> +                       strvec_push(&clone_args, "--dissociate");
> +               if (info->depth >= 0)
> +                       strvec_pushf(&clone_args, "--depth=%d", info->depth);

It's ok if there is a blank line here.

> +               if (module_clone(clone_args.nr, clone_args.v, info->prefix)) {
> +                       strvec_clear(&clone_args);
> +                       return -1;
> +               }
> +               strvec_clear(&clone_args);

> +static int add_clone(int argc, const char **argv, const char *prefix)
> +{
> +       const char *branch = NULL, *sm_path = NULL;
> +       const char *wt_prefix = NULL, *realrepo = NULL;
> +       const char *reference = NULL, *sm_name = NULL;
> +       int force = 0, quiet = 0, dissociate = 0, depth = -1, progress = 0;
> +       struct add_data info = ADD_DATA_INIT;

Maybe: s/info/add_data/

Also it seems that in many cases it's a bit wasteful to use new
variables for option parsing and then to copy them into the add_data
struct when the field of the add_data struct could be used directly
for option parsing...

> +       struct option options[] = {
> +               OPT_STRING('b', "branch", &branch,

...for example, here maybe `&add_data.branch` could be used instead of
`&branch`...

> +                          N_("branch"),
> +                          N_("branch of repository to checkout on cloning")),

[...]

> +       info.branch = branch;

...so that the above line would not be needed.

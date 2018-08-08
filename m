Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4481208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 16:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbeHHSX6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 14:23:58 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:35995 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbeHHSX6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 14:23:58 -0400
Received: by mail-io0-f193.google.com with SMTP id m4-v6so1197885iop.3
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 09:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NT6eP4IEZ+vj4wxM5VZ2w/JwEkmH7lu3c/jCaxyNjLs=;
        b=kOljOhv1DDedIQAbH2/qGl3hePHjgFBTh7t7MurFxvlXwQfTnFNpEjAyF3T5Zcu/z2
         EnvwE1ZRLNEYg1r3I+MnjrEW+Rl3w0DMNEHta+cicL06Y8IQlBhdJF5Fh+yavN25Bu8v
         tKIO/oZzXpJlsKG1Q6Or5mrnO5G8OMiufwftV7qYEbJWi9x6pfJThH9pXCJ4sCW2cVmw
         bQUWjex+R/XQvgVgfx8DiPjGPX7/mh2kkv+PbDVmcvsP9Fng7nN7KLYOjWvvq723LqJc
         eW3BFRsKIjAe0XoOi/fGBdsaejt0ehj92GEHOU8Rl/3WRt/0x304+/oAaIlJLKjBo/DI
         7w6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NT6eP4IEZ+vj4wxM5VZ2w/JwEkmH7lu3c/jCaxyNjLs=;
        b=b5EKA0zOlmQl1o6jF4TPOtq0s2aVT7WaKsNQ2mcIw2yPFW211pTlEAvhwyaKtNrsBY
         l7F+N60FViDgpDnO6MniwnESDxaD2N5vkG23dB39wjDdIIkXqu20Cex8lw7UBzeRD5ou
         6XiNQgzweOowj9RBkvqU04oQ+qNj4jXan9IV42aZ8atWZxn6Z7mKbZGDhPBcnqjlmG+3
         CYKf7ikHJQJMSJVdGNanCUI3rG42501Ru7+WTtSQ0FQxvDGFK3tTHP3ORQfD2CxYqQpN
         P+WVezBF/FS6Hyvf91PCOe7khvOHIr52KJ2JiPqaRLnKkbJEhlUgpDwG27enMzJl/+4B
         qe8Q==
X-Gm-Message-State: AOUpUlFfBOuU6ga6H05uULtzs752S7IJqM1/w7SxGV2JWO3FOC/Ym2lE
        7uzH4he/tmga2RZBqnuFoVNA7ioem+Nb9Zawa0Y=
X-Google-Smtp-Source: AA+uWPya7otmPwdsf6b5x0LBU9sEmMH2KrIaYo/mHtGOZCQZB6DNC5qAfRPBQPxvvwEALX4mPTX+TGASI3OUIE91XJE=
X-Received: by 2002:a6b:8f4b:: with SMTP id r72-v6mr2845600iod.118.1533744218887;
 Wed, 08 Aug 2018 09:03:38 -0700 (PDT)
MIME-Version: 1.0
References: <20180808134830.19949-1-predatoramigo@gmail.com> <20180808134830.19949-12-predatoramigo@gmail.com>
In-Reply-To: <20180808134830.19949-12-predatoramigo@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 8 Aug 2018 18:03:12 +0200
Message-ID: <CACsJy8BDLvGhRvNQgSgvkR-RMAvVxPpT=i9ayi=awQYOqd2Crg@mail.gmail.com>
Subject: Re: [PATCH 11/11] builtin rebase: support `git rebase <upstream> <switch-to>`
To:     Pratik Karki <predatoramigo@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>, alban.gruin@gmail.com,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(not really a review, this patch just happens to catch my eyes)

On Wed, Aug 8, 2018 at 3:55 PM Pratik Karki <predatoramigo@gmail.com> wrote:
>
> This commit adds support for `switch-to` which is used to switch to the
> target branch if needed. The equivalent codes found in shell script
> `git-legacy-rebase.sh` is converted to builtin `rebase.c`.
>
> Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
> ---
>  builtin/rebase.c | 48 ++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 44 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 63634210c0..b2ddfa8dbf 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -79,6 +79,7 @@ struct rebase_options {
>         struct commit *onto;
>         const char *onto_name;
>         const char *revisions;
> +       const char *switch_to;
>         int root;
>         struct commit *restrict_revision;
>         int dont_finish_rebase;
> @@ -186,6 +187,8 @@ static int run_specific_rebase(struct rebase_options *opts)
>                 opts->flags & REBASE_DIFFSTAT ? "t" : "");
>         add_var(&script_snippet, "force_rebase",
>                 opts->flags & REBASE_FORCE ? "t" : "");
> +       if (opts->switch_to)
> +               add_var(&script_snippet, "switch_to", opts->switch_to);
>
>         switch (opts->type) {
>         case REBASE_AM:
> @@ -564,9 +567,23 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>          * orig_head -- commit object name of tip of the branch before rebasing
>          * head_name -- refs/heads/<that-branch> or NULL (detached HEAD)
>          */
> -       if (argc > 0)
> -                die("TODO: handle switch_to");
> -       else {
> +       if (argc == 1) {
> +               /* Is it "rebase other branchname" or "rebase other commit"? */
> +               branch_name = argv[0];
> +               options.switch_to = argv[0];
> +
> +               /* Is it a local branch? */
> +               strbuf_reset(&buf);
> +               strbuf_addf(&buf, "refs/heads/%s", branch_name);
> +               if (!read_ref(buf.buf, &options.orig_head))
> +                       options.head_name = xstrdup(buf.buf);
> +               /* If not is it a valid ref (branch or commit)? */
> +               else if (!get_oid(branch_name, &options.orig_head))
> +                       options.head_name = NULL;
> +               else
> +                       die(_("fatal: no such branch/commit '%s'"),

die() automatically adds "fatal:" so you should not add it yourself here

> +                           branch_name);
> +       } else if (argc == 0) {
>                 /* Do not need to switch branches, we are already on it. */
>                 options.head_name =
>                         xstrdup_or_null(resolve_ref_unsafe("HEAD", 0, NULL,
> @@ -585,7 +602,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>                 }
>                 if (get_oid("HEAD", &options.orig_head))
>                         die(_("Could not resolve HEAD to a revision"));
> -       }
> +       } else
> +               BUG("unexpected number of arguments left to parse");

Does this mean "git base one two three" triggers this BUG? If so, this
should be a die() instead. I did not real the full source code, so
maybe this case is already caught higher up.
-- 
Duy

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217A9C4338F
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 06:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A5CE601FF
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 06:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234041AbhG1GhQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 02:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbhG1GhP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 02:37:15 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4202C061757
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 23:37:13 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id gn26so2840120ejc.3
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 23:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YzVfQgTit/o8RU2j3aP/kn+aq4AMplvdbjnxS3TawzA=;
        b=W8vbpg5i550gXAAT3awTiyef8oSKre4sr0IJHI7ky6BNBJHU9Z36M577xODiUCyG7v
         6pdiZRpmwBYuLdk8qvBziXOtS0YK20U+7spmcFT/UhIR4MmUfyy4W4R8lRqEUDm5/yWd
         0o06SdNp49bW9KoPdJZT6Y4b4q5LiVM3/mwNj1pywiQZ4oXImgNqxm4mZQUgo/cd/+6Z
         EHZJk7rj0uDc6r8lR4LPKzurGioDPkDBO7+IGpruQA2eOFfc+SrgxCh7NrB6rZZxyE0z
         CwPg3lxMpAfHZpdnJDwUomeCo9evAxjJyKce+gTfZwX2UYeLSpm7lWWx+VUEgq2VZCxw
         +vZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YzVfQgTit/o8RU2j3aP/kn+aq4AMplvdbjnxS3TawzA=;
        b=taEiXYNvqpBOCOdZW362l9XXX4+5Mon095Ki+P4lgRhW3I606wLMpVPcCk/k7lv3Rz
         9rSW/FX9L+ABzbmrV7VULo7wK+xlL/S2jN9LsyIG6/9X2NNWEHE0yjHMe6s4sOrL7Va2
         0AL9ad78UHHM6/X0T+2j7Pfxoy4G5lLGpWjVgu+Co/4ya/8bn39IbnBWRRquGHoDKYzM
         Zs185Aehgrz0oF6knNxrkRj/rRergSuIzId7buALZio7F47DNArXhJein2Vxft+NPG8G
         Jn3jtVXdq1gFLuhzkSoqKUP4qTIccHQvFjtXrDYZAALuGlAJkLResaZ2ESDMefpinmjX
         0A1A==
X-Gm-Message-State: AOAM533NugLU/PTesgz+1WmMo8sofy79q5fEVqncokIf7b7CVDSvgZRL
        cXJi+wXUT70TCwXX78CpR9lsKmFkiJS36qau5Xw=
X-Google-Smtp-Source: ABdhPJyLFR5hv+NqYnaIh5U5rzElHsl7+wa1Z80cv45N5QN5q9UegBc+bmJ+yxeRPgGtiCLJ2bvcjjMnYN/8OEiOpzQ=
X-Received: by 2002:a17:906:511:: with SMTP id j17mr6611009eja.283.1627454232504;
 Tue, 27 Jul 2021 23:37:12 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1003.git.1627311659384.gitgitgadget@gmail.com>
 <xmqq4kcgkjhk.fsf@gitster.g> <xmqq7dhbehwl.fsf@gitster.g>
In-Reply-To: <xmqq7dhbehwl.fsf@gitster.g>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 28 Jul 2021 08:37:01 +0200
Message-ID: <CAP8UFD26AXTYPvSzBD1x6hSvK5SNbM0F5BPX5bLEbxUZa2dAUg@mail.gmail.com>
Subject: Re: [PATCH] Fix git-bisect when show-branch is configured to run with pager
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        Oded S via GitGitGadget <gitgitgadget@gmail.com>,
        Oded S <oded@istraresearch.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 27, 2021 at 8:26 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Also, in the longer term, I suspect that we probably should stop
> > calling show-branch from this codepath and here is why.
>
> I wonder if it is just a simple matter of a few lines of code, like
> this?

Yeah, I also think it's a good idea.

> ---- >8 ------- >8 ------- >8 ------- >8 ------- >8 ----
> Subject: [PATCH] bisect: do not run show-branch just to show the current  commit
>
> In scripted versions of "git bisect", we used "git show-branch" to
> describe single commit in the bisect log and also to the interactive

s/single/ a single/

> user after checking out the next version to be tested.

[...]

> diff --git a/bisect.c b/bisect.c
> index af2863d044..2b8b6546e9 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -23,7 +23,6 @@ static struct oid_array skipped_revs;
>  static struct object_id *current_bad_oid;
>
>  static const char *argv_checkout[] = {"checkout", "-q", NULL, "--", NULL};
> -static const char *argv_show_branch[] = {"show-branch", NULL, NULL};
>
>  static const char *term_bad;
>  static const char *term_good;
> @@ -729,6 +728,9 @@ static enum bisect_error bisect_checkout(const struct object_id *bisect_rev, int
>  {
>         char bisect_rev_hex[GIT_MAX_HEXSZ + 1];
>         enum bisect_error res = BISECT_OK;
> +       struct commit *commit;
> +       struct pretty_print_context pp = {0};
> +       struct strbuf commit_msg = STRBUF_INIT;
>
>         oid_to_hex_r(bisect_rev_hex, bisect_rev);
>         update_ref(NULL, "BISECT_EXPECTED_REV", bisect_rev, NULL, 0, UPDATE_REFS_DIE_ON_ERR);
> @@ -748,13 +750,11 @@ static enum bisect_error bisect_checkout(const struct object_id *bisect_rev, int
>                         return -abs(res);
>         }
>
> -       argv_show_branch[1] = bisect_rev_hex;
> -       res = run_command_v_opt(argv_show_branch, RUN_GIT_CMD);
> -       /*
> -        * Errors in `run_command()` itself, signaled by res < 0,
> -        * and errors in the child process, signaled by res > 0
> -        * can both be treated as regular BISECT_FAILURE (-1).
> -        */
> +       commit = lookup_commit_reference(the_repository, bisect_rev);
> +       format_commit_message(commit, "[%H] %s%n", &commit_msg, &pp);
> +       fputs(commit_msg.buf, stdout);
> +       strbuf_release(&commit_msg);
> +
>         return -abs(res);

Nice! Now, the above line can be simplified to:

         return BISECT_OK;

And the declaration of the `res` variable can be moved into the else
clause where it is used.
>  }

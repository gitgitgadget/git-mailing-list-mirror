Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A8ABC433ED
	for <git@archiver.kernel.org>; Mon, 10 May 2021 19:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5952561585
	for <git@archiver.kernel.org>; Mon, 10 May 2021 19:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbhEJT2r (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 15:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbhEJT2q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 15:28:46 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8964C061574
        for <git@vger.kernel.org>; Mon, 10 May 2021 12:27:40 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id x15so3059228oic.13
        for <git@vger.kernel.org>; Mon, 10 May 2021 12:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wpzlff3Abn/2nuv1XqZRPO1THXohPIGdIUPnAHAHw/c=;
        b=VoUzvwuGFOHmtO/ep+4Qok0nmesZVecqTNd58MYRlJcaLnos0xOk/x6BWuCHM2hOJy
         AnUQ3PuM95a+yMmjQhN6GV/2v1qubKa0G8rIho9Nq/7ns/8OJeZeVhK+MYbZI09bGaM8
         U9q2SVoKNwxitNH1CZCO8k2/bK+sPcW8ZipIQG8sZcvE/efaJ5q/OED8qhIOd0VYIy10
         sZFvO40v6EiQs4wG8baF0iXN7yBdpFnoMfxDpbo47hY8b0pgngiVTW6vy3cJtlBbmnkF
         3OlLryGEeuYImSmbCeyMRUMR4FkPW/iQ1WScWuoYuBEbCDHLQcIRkklUA7INLLaJE+WO
         Mx9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wpzlff3Abn/2nuv1XqZRPO1THXohPIGdIUPnAHAHw/c=;
        b=WlWxYozsqTyZ5QK+2Kuunr9KLkZMVy59IkJ1DJaYmPBkVNEOnFXggPMsXXzC8rsTAc
         hd/hzeQ6yYEEtu+bXzUz3J7sVvlOinWj9EEhYGYJOiX1dL24YVWq/mt7INjfBf0pUrCY
         nlppbGhCfwCtP5N2PMwVdozZ84sHpv0r6DaXcNxhSNRImipfEK5t8W3L2jYtz3kauwPk
         zC1AHw0/sFchQ1voeKPNUvS61hc4+8Y9KUcrqHMi3mPzSh7bFCliKWIJf/IIRKq2gKA+
         I+VQMzLX6Z8dgij9xkxbNyMCqAiV/pqsEIMAe9c6jHEIMXNAnkyKNKH+Z84HO/PlEnaY
         vpzw==
X-Gm-Message-State: AOAM533IToZOCmvjaC+vwTKfMJvaG/+nkMVfFafqagjisQR0p18rGO2O
        OeFLwnU+EWpzznu1TNiPp+DNuDEFXE/L04nezqBQCHkagY7Gkw==
X-Google-Smtp-Source: ABdhPJxUdzURFuCNwlKyhX0Xqx7M1aeblX0cz0JzLuiPVfzrYe3APVkCHsZnTtsDW9cKRu1+IJSk++bvQ68fvdUarjI=
X-Received: by 2002:aca:3e05:: with SMTP id l5mr547549oia.39.1620674860185;
 Mon, 10 May 2021 12:27:40 -0700 (PDT)
MIME-Version: 1.0
References: <e4c3d482-03b4-141c-e47b-cb3e175da3ab@iee.email> <789bcc9cd074cb94f706b9d432e29b52bf6a33c3.1620134775.git.matheus.bernardino@usp.br>
In-Reply-To: <789bcc9cd074cb94f706b9d432e29b52bf6a33c3.1620134775.git.matheus.bernardino@usp.br>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 10 May 2021 12:27:28 -0700
Message-ID: <CABPp-BFpeoENLADH-e6dCc0PyEVQyHueY6PV8AZYbD+a3iceXA@mail.gmail.com>
Subject: Re: gitignore + commit with excludes = bug
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>,
        mailnew4ster@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 4, 2021 at 7:10 AM Matheus Tavares
<matheus.bernardino@usp.br> wrote:
>
> Hi, Paul and Philip
>
> On Tue, May 4, 2021 at 9:55 AM Philip Oakley <philipoakley@iee.email> wrote:
> >
> > Hi Paul,
> >
> > On 01/05/2021 19:37, Paul Jackson wrote:
> > > Hello,
> > >
> > > I stumbled upon what I believe is a bug in git.
> > > See the following reproduction steps:
> > >
> > > mkdir test
> > > cd test
> > > git init
> > > echo 1 > ignored
> > > echo 1 > not-ignored
> > > echo ignored > .gitignore
> > > git add -A -- ':!ignored' || echo 'ERROR!!!'
> > >
> > > In these steps, I ignore the "ignored" file twice - first time in
> > > .gitignore, and second time in the "git add" command. I didn't expect
> > > this to be a problem, but I'm getting the following error message:
> > >
> > > The following paths are ignored by one of your .gitignore files:
> > > ignored
> > >
> > > It looks as if git thinks I wanted to include, not exclude "ignored"
> > > in "git add".
> > I was intrigued by this. The man pages can be hard to decipher, and it
> > may be an 'as designed' feature, but still not intuitive
> >
> > It took a while to find the relevant parts of the man pages.
> >
> > The `-A` option of `add` is under
> > https://git-scm.com/docs/git-add#Documentation/git-add.txt---no-ignore-removal
> > which has caveats for whether a pathspec is given.
> >
> > The `exclude` magic pathspec is under
> > https://git-scm.com/docs/gitglossary#Documentation/gitglossary.txt-exclude
> > and again has caveats and a double negative regarding whether the
> > `exclude` pathspec counts as a path spec.
> >
> > I _think_ that it is saying that the `exclude` pathspec is ignored for
> > the purpose of the `-A` (all) condition for git add.
>
> Hmm, I think the issue is not really related to `-A`. In fact, if we
> reproduce Paul's original example without `-A`, we still get the
> warning.
>
> The problem seems to be at `dir.c:exclude_matches_pathspec()`, which
> creates the list of ignored files that is later used by `git add` to
> presented the "The following paths are ignored..." warning.
>
> This function ignores the `exclude` magic, so a path 'x' incorrectly
> matches both ':x' and ':!x'. And thus, we end up warning the user about
> 'x' being ignored even when the user had ran `git add ':!x'`.
>
> I think something like this, might solve the problem:
>
> diff --git a/dir.c b/dir.c
> index 3474e67e8f..165ca6a543 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -2042,6 +2042,25 @@ static int exclude_matches_pathspec(const char *path, int pathlen,
>                 const struct pathspec_item *item = &pathspec->items[i];
>                 int len = item->nowildcard_len;
>
> +               if (!(item->magic & PATHSPEC_EXCLUDE))
> +                       continue;
> +
> +               if (len == pathlen &&
> +                   !ps_strncmp(item, item->match, path, pathlen))
> +                       return 0;
> +               if (len > pathlen &&
> +                   item->match[pathlen] == '/' &&
> +                   !ps_strncmp(item, item->match, path, pathlen))
> +                       return 0;
> +       }
> +
> +       for (i = 0; i < pathspec->nr; i++) {
> +               const struct pathspec_item *item = &pathspec->items[i];
> +               int len = item->nowildcard_len;
> +
> +               if (item->magic & PATHSPEC_EXCLUDE)
> +                       continue;
> +
>                 if (len == pathlen &&
>                     !ps_strncmp(item, item->match, path, pathlen))
>                         return 1;
> ---

Thanks for tracking this down.  Your analysis and patch look correct
to me, but perhaps we could simplify the code a bit.  Instead of
looping twice, perhaps insert the following code above the if-checks:

+               /*
+                * We can have a bunch of exclusion rules:
+                *    .gitignore
+                *    *.log
+                *    !settings.log
+                * and we're trying to see if the path matches one of these,
+                * but note that the last one is a "negated exclusion rule",
+                * for the excludes to match this pathspec, it needs to not
+                * match the negated exclusion.
+                */
+               int retval = (item->magic & PATHSPEC_EXCLUDE) ? 0 : 1;

and then change all the "return 1" statements to "return retval".

Thoughts?

>
> I had to split the original loop into two and handle the `exclude`
> pathspecs first because we cannot let the original loop return early
> when one of the `non-exclude` pathspecs matches the path. Otherwise, we
> would still incorrectly warn the user on executions like
> `git add ignored ':!ignored'`.
>
> (We might also want to extract the matching part to its own function to
> avoid repeating this code on the two loops.)

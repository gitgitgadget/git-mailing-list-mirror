Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73708C433E0
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 17:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40A5864F5B
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 17:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235156AbhCDRXA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 12:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233773AbhCDRWk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 12:22:40 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8D5C061574
        for <git@vger.kernel.org>; Thu,  4 Mar 2021 09:22:00 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id j8so2548760otc.0
        for <git@vger.kernel.org>; Thu, 04 Mar 2021 09:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JJ4CkIdQYjCNj4GMlUtfqK9F03dDC+99L5weRxM3Yi0=;
        b=SH0+DGpuykGfKBOVIAPr43QCD/F/cDAy3vtxmQFs6HFDt2YleqXsbmHhYAhyAb7LBj
         hAu4Ftk4eeD6fxJ0K+dKQ2Il+BbtioR4P2vTdcsnN3H/4Qh3YcvT59lrF6474INCj5FY
         JVsbPq5+vNmYpvx5sp2Wucrabqrx2Hq+3BW3lKLTdpvFhCL9dIfPpMuO5LYqBEzjwYJf
         S6VgVeUZtK1AgzUKO4OBI5KUeNiXX82Cwkt/+ZxmuBvUHtr1W7f1ERl4mkWWGhh+zYRX
         Im1rP5d7s5mop1ZgECy2XX7W9eYtWKeQWyPO/hihYT4dOQtGjeOuJ93hlkBX0H7og/hm
         HUcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JJ4CkIdQYjCNj4GMlUtfqK9F03dDC+99L5weRxM3Yi0=;
        b=fok6NENhw+IvLoO9qE//mY+ZanE83S67p6CgShVVfehfxtrRdVReWxCJgb+X4NpuRl
         UWwEpz7Vretv/Z39FXgnYX92iChdHBEWRPWPg2E3eHqB/lFfYd1uJM7OiZYsU6wM/Wo5
         1cIz2kC7BKmQlaOM1nTJD6HcqdQlq5igMiWnOdkYH++T6RbtNmvIW8/mIq5kc7L+cg+n
         8xyAcH7HulO6NdgVkDj2PFCr3oUNjT3iGfzlCvWDqKfFASirZo3NHG1mEtKnc+vlUDhS
         INzgspU3K6osOsVvzKavQ9Xs1/JeLRWNq+QhBAAsdm2wVvcGh6G2LjyPmKjGAcOAeMk8
         OaCg==
X-Gm-Message-State: AOAM530h31CS3+PyCIBS53p9lNdLsOwzRM4FHPPPQHSVC1t1XnyeDL4L
        grtYXP4RsYPcaQ0pOm6F7i03CPg0ynAsuo+IHvw=
X-Google-Smtp-Source: ABdhPJweMz8pKqrQM8NZwo8yfNwluHRsdBKSIhfs+CQOZyDMZn/gsMnRChCvfrBoUf2MCvOjg0gJkkPym5kjxHhpRh8=
X-Received: by 2002:a9d:8d5:: with SMTP id 79mr4212911otf.345.1614878519811;
 Thu, 04 Mar 2021 09:21:59 -0800 (PST)
MIME-Version: 1.0
References: <CABPp-BEpnaR1tydJ-vcWAUYnT-TFcfCMMqwbmOz1Dx+nvsHZMQ@mail.gmail.com>
 <20210304152315.18498-1-matheus.bernardino@usp.br>
In-Reply-To: <20210304152315.18498-1-matheus.bernardino@usp.br>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 4 Mar 2021 09:21:48 -0800
Message-ID: <CABPp-BE9QA5RAwdebmAyK3b3wh1mGE+NF7sPS5RCf4FogYBV7A@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] add: warn when pathspec only matches SKIP_WORKTREE entries
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 4, 2021 at 7:23 AM Matheus Tavares
<matheus.bernardino@usp.br> wrote:
>
> Hi, Elijah
>
> I was going to send v3 a couple days ago, but there is still one issue
> that I'm having a bit of trouble with:
>
> On Wed, Feb 24, 2021 at 3:50 AM Elijah Newren <newren@gmail.com> wrote:
> >
> > Hmm...here's an interesting command sequence:
> >
> > git init lame
> > cd lame
> > mkdir baz
> > touch baz/tracked
> > git add baz/tracked
> > git update-index --skip-worktree baz/tracked
> > rm baz/tracked.  # But leave the empty directory!
> > echo baz >.gitignore
> > git add --ignore-missing --dry-run baz
> >
> >
> > Reports the following:
> > """
> > The following pathspecs only matched index entries outside the current
> > sparse checkout:
> > baz
> > hint: Disable or modify the sparsity rules if you intend to update such entries.
> > hint: Disable this message with "git config advice.updateSparsePath false"
> > The following paths are ignored by one of your .gitignore files:
> > baz
> > hint: Use -f if you really want to add them.
> > hint: Turn this message off by running
> > hint: "git config advice.addIgnoredFile false"
> > """
> >
> > That's probably okay because it does match both, but the "only
> > matched" in the first message followed by saying it matched something
> > else seems a little surprising at first.
>
> After giving this a little more thought, I got to this idea [1]. With
> this patch, git-add doesn't warn about sparse paths that are inside
> ignored dirs (it only warns about the ignored dirs themselves). If
> --force is used, then git-add recurses into the ignored directories, and
> warns about any sparse path inside them. I think this is more consistent
> with the way in which ignored dirs (and their contents) are handled with
> and without --force. And we avoid the double warning.
>
> But there is a performance penalty. The relevant code is:
>
> @@ -2029,19 +2033,23 @@ static int exclude_matches_pathspec(const char *path, int pathlen,
>                        PATHSPEC_ICASE |
>                        PATHSPEC_EXCLUDE);
>
> +       assert(matched_ignored);
> +
>         for (i = 0; i < pathspec->nr; i++) {
>                 const struct pathspec_item *item = &pathspec->items[i];
>                 int len = item->nowildcard_len;
>
> -               if (len == pathlen &&
> -                   !ps_strncmp(item, item->match, path, pathlen))
> -                       return 1;
> -               if (len > pathlen &&
> -                   item->match[pathlen] == '/' &&
> -                   !ps_strncmp(item, item->match, path, pathlen))
> -                       return 1;
> +               if (matched && matched_ignored[i])
> +                       continue;
> +
> +               if ((len == pathlen ||
> +                   (len > pathlen && item->match[pathlen] == '/')) &&
> +                   !ps_strncmp(item, item->match, path, pathlen)) {
> +                       matched = 1;
> +                       matched_ignored[i] = 1;
> +               }
>         }
> -       return 0;
> +       return matched;
>  }
>
> This function is called for each ignored path (not recursing into
> completely ignored dirs, though). Before the patch, the internal loop
> stops at the first pathspec match. But with the patch, the loop must
> continue as we need to know about all pathspecs that had matches with
> the ignored paths...
>
> And there is also one odd case:
> $ mkdir d
> $ touch d/s d/i
> $ git add d/s
> $ git update-index --skip-worktree d/s
> $ echo d/i >.gitinore
> $ git add 'd/[is]'
>
> This outputs:
> The following pathspecs only matched index entries outside the current
> sparse checkout:
> d/[is]
> (and no warning on ignored paths).
>
> I don't think the warning here is 100% correct, as 'd/[is]' *does* match
> other files, only they are ignored. And git-add only warns about an
> ignored path when the pathspec is an exact match with it (no glob
> patterns) or inside it.
>
> So, I don't know... Perhaps should we just rephrase the sparse warning
> to remove the "only" part (and don't try to avoid the double warnings)?
> I'm open to any suggestions on alternative wordings or ideas :)
>
> [1]: https://github.com/matheustavares/git/commit/5d4be321e1f69cb08b0666ffd3f8fa658e9f6953

The only thing that I think was problematic about the double warning
was the contradiction between them due to the use of "only" in the
first; if we remove that, I think printing two warnings is perfectly
fine.  So, I'm in favor of just rephrasing as you suggest.

I think it's kind of lame that git-add won't provide a warning for
ignored files when the match is via glob/pattern; if git-add didn't
end up adding anything, but an ignored file was matched, I think a
warning is appropriate.  However, I don't think your patch series
needs to address that; your series addressing sparse behavior is long
enough, and fixing the handling with ignored files could be done
separately.

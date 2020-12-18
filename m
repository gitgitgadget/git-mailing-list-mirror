Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA6AC4361B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 05:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47BDD23A62
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 05:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732113AbgLRFyn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 00:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbgLRFyn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 00:54:43 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A510C0617A7
        for <git@vger.kernel.org>; Thu, 17 Dec 2020 21:54:03 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id o11so955534ote.4
        for <git@vger.kernel.org>; Thu, 17 Dec 2020 21:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xN9q47tjctuYtnEejXJIQDiDIEJbpVpn1CzhetWmnzc=;
        b=GOg1PQXZ7qxRVOG+b3dnjQP3qz4HDAzhnXYUgReZQMjnvHTsNXX0FkSAEFSPoBQwsL
         KF3HlloeMVZ4lMMFAM2AasUdY3H6RdtVGmWwrl6BCAGjQdbjfqQnsNlbfZOMtDpUJ213
         T/UuCKSzWz8CUvDlbbv4sBicDOsbqfQI4zvfZZje49nHAFel8Y7gHfzEU+oNHbGePLMh
         Gz49ZVSnbaKrOVC4/cwQzb9/HfXfyvlODWhyiBSpEeo+yRRDcbN25EeNeGeSWi9I6lF0
         EwJES9DG3eK4k4iUqjktC2rQB5/0UCxi3aIhfqqjfREFm49b8ivsHuVARNSM/rzPKhIf
         zE3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xN9q47tjctuYtnEejXJIQDiDIEJbpVpn1CzhetWmnzc=;
        b=COh+4tNQs8DOmnaZFangSOcuHZVC3bmefmU2vnuJtGhoua8gJKXIMR9mWCwHKc3nNg
         P37Z3ix4QbOiDaEEBsCU4VbP/kC88i7Ftfa6dm5V7sxZLzKuwIUmrqRYYlNt4/Ho5Z5I
         eS9wrz5+64uCefF6tygJbOU3jq9fcxFVJHEBbn22OLAlCOWDfbw6l0Kyn02aHCQcXzlk
         L1Bbn0d691l+g6KrhPBlD3sbJ5Omq6J4c7fFQmxojD31hew7naIPsq0OzIMLA8fZu2kk
         4trhLqJthg7YrZxGFt2GSn5fyF0MvWRYoLeF1St5aJmT8HbqLcCAPTopJXSdOV5FMBE1
         b37w==
X-Gm-Message-State: AOAM533Y9a4e3JOZHnBw3ZtsfIWfwnpdObM+LV3TXuTTpShWhgNWrjaI
        ZrE5beMTYIPnAxZvZJTecwi9uxg3PDLITFDruSM=
X-Google-Smtp-Source: ABdhPJw+QT4lhKcZHrIGE2lQIdoOhR/NIdIfxLioeQ/d05zDuKLgw4BIIIlTao2YKz1eKQArPB/rNbBWjySoU7KtSlg=
X-Received: by 2002:a05:6830:1610:: with SMTP id g16mr1781397otr.345.1608270842324;
 Thu, 17 Dec 2020 21:54:02 -0800 (PST)
MIME-Version: 1.0
References: <20201101193330.24775-1-sorganov@gmail.com> <20201216184929.3924-1-sorganov@gmail.com>
 <20201216184929.3924-30-sorganov@gmail.com>
In-Reply-To: <20201216184929.3924-30-sorganov@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 17 Dec 2020 21:53:51 -0800
Message-ID: <CABPp-BFRPFxm=SuJFwfG+QYCivMKp2VRpnHGwxNL+extK7UdtA@mail.gmail.com>
Subject: Re: [PATCH v2 29/33] doc/git-log: describe new --diff-merges options
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 16, 2020 at 10:50 AM Sergey Organov <sorganov@gmail.com> wrote:
>
> Describe all the new --diff-merges options in the git-log.txt and
> adopt description of originals accordingly.

You also took care to explain interactions of options with -p that
were previously undocumented, which is a nice bonus.  That wording
could still be improved a bit, though, as noted below.

> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
>  Documentation/git-log.txt | 85 ++++++++++++++++++++++++---------------
>  1 file changed, 52 insertions(+), 33 deletions(-)
>
> diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
> index 2b8ac5ff882a..27bc619490c6 100644
> --- a/Documentation/git-log.txt
> +++ b/Documentation/git-log.txt
> @@ -120,45 +120,64 @@ DIFF FORMATTING
>  By default, `git log` does not generate any diff output. The options
>  below can be used to show the changes made by each commit.
>
> -Note that unless one of `-c`, `--cc`, or `-m` is given, merge commits
> -will never show a diff, even if a diff format like `--patch` is
> -selected, nor will they match search options like `-S`. The exception is
> -when `--first-parent` is in use, in which merges are treated like normal
> -single-parent commits (this can be overridden by providing a
> -combined-diff option or with `--no-diff-merges`).
> +Note that unless one of `--diff-merges` variants (including short
> +`-m`, `-c`, and `--cc` options) is explicitly given, merge commits
> +will not show a diff, even if a diff format like `--patch` is
> +selected, nor will they match search options like `-S`. The exception
> +is when `--first-parent` is in use, in which case `first-parent` is
> +the default format.

Thanks for fixing this up.  :-)

>
> --c::
> -       With this option, diff output for a merge commit
> -       shows the differences from each of the parents to the merge result
> -       simultaneously instead of showing pairwise diff between a parent
> -       and the result one at a time. Furthermore, it lists only files
> -       which were modified from all parents.
> -
> ---cc::
> -       This flag implies the `-c` option and further compresses the
> -       patch output by omitting uninteresting hunks whose contents in
> -       the parents have only two variants and the merge result picks
> -       one of them without modification.
> +--diff-merges=(off|none|first-parent|1|separate|m|combined|c|dense-combined|cc)::
> +--no-diff-merges::
> +       Specify diff format to be used for merge commits. Default is
> +       `off` unless `--first-parent` is in use, in which case
> +       `first-parent` is the default.
> ++
> +--diff-merges=(off|none):::
> +--no-diff-merges:::
> +       Disable output of diffs for merge commits. Useful to override
> +       implied value.
> ++
> +--diff-merges=first-parent:::
> +--diff-merges=1:::
> +       This option makes merge commits show the full diff with
> +       respect to the first parent only.

Does it imply -p?

> ++
> +--diff-merges=separate:::
> +--diff-merges=m:::
> +-m:::
> +       This makes merge commits show the full diff with respect to
> +       each of the parents. Separate log entry and diff is generated
> +       for each parent. `-m` is different in that it doesn't produce
> +       any output without `-p`.

Different from what?  From --first-parent?  From flags that haven't
been covered yet?  (-c and --cc show up below)

> ++
> +--diff-merges=combined:::
> +--diff-merges=c:::
> +-c:::
> +       With this option, diff output for a merge commit shows the
> +       differences from each of the parents to the merge result
> +       simultaneously instead of showing pairwise diff between a
> +       parent and the result one at a time. Furthermore, it lists
> +       only files which were modified from all parents. Historically,
> +       `-c` enables diff output for non-merge commits as well.

"Historically"?  Does that mean it doesn't anymore?  (Maybe, "The
short form, `-c`, also enables diff output for non-merge commits as
well." or something like that?)

> ++
> +--diff-merges=dense-combined:::
> +--diff-merges=cc:::
> +--cc:::
> +       With this option the output produced by
> +       `--diff-merges=combined` is further compressed by omitting
> +       uninteresting hunks whose contents in the parents have only
> +       two variants and the merge result picks one of them without
> +       modification.  Historically, `--c` enables diff output for
> +       non-merge commits as well.

Same note as above.

>  --combined-all-paths::
>         This flag causes combined diffs (used for merge commits) to
>         list the name of the file from all parents.  It thus only has
> -       effect when -c or --cc are specified, and is likely only
> -       useful if filename changes are detected (i.e. when either
> -       rename or copy detection have been requested).
> +       effect when `--diff-merges=[dense-]combined` is in use, and
> +       is likely only useful if filename changes are detected (i.e.
> +       when either rename or copy detection have been requested).
>
> --m::
> -       This flag makes the merge commits show the full diff like
> -       regular commits; for each merge parent, a separate log entry
> -       and diff is generated. An exception is that only diff against
> -       the first parent is shown when `--first-parent` option is given;
> -       in that case, the output represents the changes the merge
> -       brought _into_ the then-current branch.
> -
> ---diff-merges=off::
> ---no-diff-merges::
> -       Disable output of diffs for merge commits (default). Useful to
> -       override `-m`, `-c`, or `--cc`.
>
>  :git-log: 1
>  include::diff-options.txt[]
> --
> 2.25.1

The rest looks good.

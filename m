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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0527CC4361A
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 16:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B80720754
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 16:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgLCQs1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 11:48:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbgLCQs1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 11:48:27 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1D8C061A4E
        for <git@vger.kernel.org>; Thu,  3 Dec 2020 08:47:47 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id f12so2328486oto.10
        for <git@vger.kernel.org>; Thu, 03 Dec 2020 08:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TpYjpxROIdqu35c00/p+0b/egSLmM+9o+DEuR+sRcZ4=;
        b=OZUIgTwPe84eXAMWd/lYU1CrFKsTB0ZQ8atTwx0DW8hnvR5rAW3hgVxVfIA9n/25G3
         I6uuQIkzFyMc3JM/dQFx01/EzrXw9DEjAuBxc7WiHP/eKPWFONsxMi9ddpjw3TYxqmA1
         l7ezgGe31/TG1LWd1WHqj4kaRfLcxPRSvpEM1UkL2lKT9smwHQnFzerIsJd7gi03wf9k
         zvnNPcnQWoq4bm0+Cyln/JSUxABMGe01VPw5NO8SZD68mwGuTDnYLlrSPRvO4riTa+ee
         gWrwabOR2w3mvej7UFQWhhRLfZqAVpfEGbxMNm2sha3mjjeGbaDWuT0p2RtLfocQav/X
         /H/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TpYjpxROIdqu35c00/p+0b/egSLmM+9o+DEuR+sRcZ4=;
        b=KjERK6zVW+3K2IyxXmwFbZfiv2MBvEOrO+FwdAjXdWjeOv8ATjCAYg38f9DNSDC9CT
         CAyW2McTFpLk2jrtB5jTfsu3lAchSb5hacOMbvM64R+dcu6eVL6132i2J+EM1yGfCbl3
         4rOj00tGKmSzH9VsyDErRuxq2QVtkC/frJrPFqHo5yBcKJX+EsRDdECcqlDP/dNJvfA+
         prvJKoZXixa5bhjFO48SCD7DqoANIv3HRw3eVOh6auNv2+v88cVSPyHPP1nKgo6etuUp
         0qOEs9jSvhJw6I1WPyiGFuGMOw1aa9w1MYcXUJSpy+aTCHXQ3rdJaeINfRJJCPia4TQ7
         Barw==
X-Gm-Message-State: AOAM533GuBFGV7cWW3TZbxS5SPkmW2Rlst4s0SwHlLiibGK2vGuCLvVi
        kdaiTJFoZTdXLFMIpwhqBEuz92VD/wutlMjUMFeg6swEDC6HjQ==
X-Google-Smtp-Source: ABdhPJzKpUu2FXoTTM6myWHzEthUqrt+HEakYepaXgdco1bWMb29cttoLEDJXX3v+Z1DLxEt+Juo5x229w9evaWQRiA=
X-Received: by 2002:a05:6830:12c2:: with SMTP id a2mr46412otq.162.1607014066355;
 Thu, 03 Dec 2020 08:47:46 -0800 (PST)
MIME-Version: 1.0
References: <20201101193330.24775-1-sorganov@gmail.com> <20201108213838.4880-1-sorganov@gmail.com>
 <20201108213838.4880-28-sorganov@gmail.com>
In-Reply-To: <20201108213838.4880-28-sorganov@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 3 Dec 2020 08:47:35 -0800
Message-ID: <CABPp-BG_YT2i_27tqkh_e4mwfkYae-zDCEYL=F+NjYQed2gKAg@mail.gmail.com>
Subject: Re: [PATCH v1 27/27] doc/git-show: include --diff-merges description
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sun, Nov 8, 2020 at 1:44 PM Sergey Organov <sorganov@gmail.com> wrote:
>
> Move description of --diff-merges option from git-log.txt to
> diff-options.txt so that it is included in the git-show help.
>
> While we are at it, make git-show closer to git-log in this area by
> providing similar wording in the introduction of diff options.
>
> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
>  Documentation/diff-options.txt | 54 ++++++++++++++++++++++++++++++++++
>  Documentation/git-log.txt      | 52 --------------------------------
>  Documentation/git-show.txt     |  8 +++--
>  3 files changed, 60 insertions(+), 54 deletions(-)
>
> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index 573fb9bb71e2..f1629887103e 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -33,6 +33,60 @@ endif::git-diff[]
>         show the patch by default, or to cancel the effect of `--patch`.
>  endif::git-format-patch[]
>
> +ifdef::git-log[]
> +Note that unless one of `--diff-merges` variants (including short
> +`-m`, `-c`, and `--cc` options) is explicitly given, merge commits
> +will not show a diff, even if a diff format like `--patch` is
> +selected, nor will they match search options like `-S`. The exception
> +is when `--first-parent` is in use, in which case
> +`--diff-merges=first-parent` is implied.

So, now diff-options says that no diffs are the defaults for merge commits...

> +
> +--diff-merges=(off|none|first-parent|separate|combined|dense-combined)::
> +--no-diff-merges::
> +       Specify diff format to be used for merge commits. This has no
> +       effect unless diff output is enabled in the first place (e.g.,
> +       with `--patch` option.)
> ++
> +--diff-merges=(off|none):::
> +--no-diff-merges:::
> +       (default) Disable output of diffs for merge commits. Useful to
> +       override implied value.
> ++
> +--diff-merges=first-parent:::
> +       This option makes merge commits show the full diff with
> +       respect to the first parent only, exactly like  regular
> +       commits.
> ++
> +--diff-merges=separate:::
> +-m:::
> +       This makes merge commits show the full diff with respect to
> +       each of the parents. Separate log entry and diff is generated
> +       for each parent.
> ++
> +--diff-merges=combined:::
> +-c:::
> +       With this option, diff output for a merge commit shows the
> +       differences from each of the parents to the merge result
> +       simultaneously instead of showing pairwise diff between a
> +       parent and the result one at a time. Furthermore, it lists
> +       only files which were modified from all parents.
> ++
> +--diff-merges=dense-combined:::
> +--cc:::
> +       With this option the output produced by
> +       `--diff-merges=combined` is further compressed by omitting
> +       uninteresting hunks whose contents in the parents have only
> +       two variants and the merge result picks one of them without
> +       modification.
> +
> +--combined-all-paths::
> +       This flag causes combined diffs (used for merge commits) to
> +       list the name of the file from all parents.  It thus only has
> +       effect when `--diff-merges=[dense-]combined` is in use, and
> +       is likely only useful if filename changes are detected (i.e.
> +       when either rename or copy detection have been requested).
> +endif::git-log[]
> +
>  -U<n>::
>  --unified=<n>::
>         Generate diffs with <n> lines of context instead of
> diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
> index de498a189646..0cacc780bf30 100644
> --- a/Documentation/git-log.txt
> +++ b/Documentation/git-log.txt
> @@ -120,58 +120,6 @@ DIFF FORMATTING
>  By default, `git log` does not generate any diff output. The options
>  below can be used to show the changes made by each commit.
>
> -Note that unless one of `--diff-merges` variants (including short
> -`-m`, `-c`, and `--cc` options) is explicitly given, merge commits
> -will not show a diff, even if a diff format like `--patch` is
> -selected, nor will they match search options like `-S`. The exception
> -is when `--first-parent` is in use, in which case
> -`--diff-merges=first-parent` is implied.
> -
> ---diff-merges=(off|none|first-parent|separate|combined|dense-combined)::
> ---no-diff-merges::
> -       Specify diff format to be used for merge commits. This has no
> -       effect unless diff output is enabled in the first place (e.g.,
> -       with `--patch` option.)
> -+
> ---diff-merges=(off|none):::
> ---no-diff-merges:::
> -       (default) Disable output of diffs for merge commits. Useful to
> -       override implied value.
> -+
> ---diff-merges=first-parent:::
> -       This option makes merge commits show the full diff with
> -       respect to the first parent only, exactly like  regular
> -       commits.
> -+
> ---diff-merges=separate:::
> --m:::
> -       This makes merge commits show the full diff with respect to
> -       each of the parents. Separate log entry and diff is generated
> -       for each parent.
> -+
> ---diff-merges=combined:::
> --c:::
> -       With this option, diff output for a merge commit shows the
> -       differences from each of the parents to the merge result
> -       simultaneously instead of showing pairwise diff between a
> -       parent and the result one at a time. Furthermore, it lists
> -       only files which were modified from all parents.
> -+
> ---diff-merges=dense-combined:::
> ---cc:::
> -       With this option the output produced by
> -       `--diff-merges=combined` is further compressed by omitting
> -       uninteresting hunks whose contents in the parents have only
> -       two variants and the merge result picks one of them without
> -       modification.
> -
> ---combined-all-paths::
> -       This flag causes combined diffs (used for merge commits) to
> -       list the name of the file from all parents.  It thus only has
> -       effect when `--diff-merges=[dense-]combined` is in use, and
> -       is likely only useful if filename changes are detected (i.e.
> -       when either rename or copy detection have been requested).
> -
>
>  :git-log: 1
>  include::diff-options.txt[]
> diff --git a/Documentation/git-show.txt b/Documentation/git-show.txt
> index fcf528c1b30d..abe58ce5d3a8 100644
> --- a/Documentation/git-show.txt
> +++ b/Documentation/git-show.txt
> @@ -45,8 +45,12 @@ include::pretty-options.txt[]
>  include::pretty-formats.txt[]
>
>
> -COMMON DIFF OPTIONS
> --------------------
> +DIFF FORMATTING
> +---------------
> +
> +By default, `git show` does not generate any diff output. The options
> +below can be used to show the changes made by each commit.
> +

This is not right, `git show` generates diff output by default for
both normal commits and merge commits -- it defaults to -p --cc (see
show_setup_revisions_tweak() of builtin/log.c).  Also see earlier in
git-show.txt where it says

       For commits it shows the log message and textual diff. It also presents
       the merge commit in a special format as produced by git diff-tree --cc.

>  :git-log: 1
>  include::diff-options.txt[]

...and the included text will contain the repeated claim that no diffs
are shown by default for merge commits, which is true for `git log`
but not `git show`.

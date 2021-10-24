Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0DFC433EF
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 22:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A4886101C
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 22:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbhJXW5u (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Oct 2021 18:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbhJXW5t (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Oct 2021 18:57:49 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E84C061745
        for <git@vger.kernel.org>; Sun, 24 Oct 2021 15:55:28 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id w15so11131672edc.9
        for <git@vger.kernel.org>; Sun, 24 Oct 2021 15:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nwcJUKakbosbQEkd/eRN/rwlQMQ0seGchi61YMsFOF8=;
        b=ZpifgDNJji4mnHUsol723knlNPAGDvGZno88YA9Jdr7BBN6Kj+MHbk4NqQr0TmLOM7
         l0t+LmezBtCQs7R/MfS4vB4+Zy+/S5+kc7nOFOCBqkL856+8C1h74M6l1XmDgKR+c4Fz
         kXYg0o3hE39VLkaHurzD0Ge0vW0DQou5B4unToRGEk8X1X1m3nswkBVvK0B75OKn+JUT
         ZKAkO5KhEODAm6B+EjUdjdLggTTVPs0ZjzFai2+WY7Vc1KtKifg5beQ3JSJ4TxNRwpUp
         m+xDZeqsL+loUcmj7rO+tIOplMAWur/7Agy6vskNe/1HAxxjOPZPl0UWr36dbhGc9RaY
         AbBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nwcJUKakbosbQEkd/eRN/rwlQMQ0seGchi61YMsFOF8=;
        b=hdGWc+Eoe2R3+ONIxSRYYCCVVTJEzKG/bPonvj6pfszPkoTav2KXCYrrKFYbnb7UvH
         mgKcD1r3LEhcStwwhNrEkrB/A9Tn65d1dipg0NvF95GTXwKdlDtWUtBrF1KQCpzoEUGf
         X/TQFn5m4YTTPOW31Sj8Bvn9LBSJ9urDR9l42cIxSBrrAWwigDT8XLKv0NgiM8IEHSJ5
         NUbmeDV4xoSUAjhmlGmU92MB9XVY9CSP4QHI644xHCJsKSAeFz1IYN0qqf6hrNqlOvyn
         fV+Kf4JdD8vo4P5aABxTY6CMd9sVePS7fT2qeQUzP1AFQDbSmEhYCK4pki3Iko/5uo83
         c0sg==
X-Gm-Message-State: AOAM532vjbz80STTfHHiNrUdB2YTzqkHhxKoFwVcOratFsCgqNt70NIW
        q50HmL9+qhpdV2IAgwo9mqqc0LBrQ9fA9f+gsjU=
X-Google-Smtp-Source: ABdhPJwPLtdIiX2Bb43nhXLXrJxISgnRxd2g6EkvCZqP5IIyBqBTb/sG+XzU4gpnGrW13Fm1IzUOcPWU0VU68OqSYLQ=
X-Received: by 2002:a05:6402:268f:: with SMTP id w15mr21540615edd.13.1635116126171;
 Sun, 24 Oct 2021 15:55:26 -0700 (PDT)
MIME-Version: 1.0
References: <20211019212020.25385-1-greenfoo@u92.eu>
In-Reply-To: <20211019212020.25385-1-greenfoo@u92.eu>
From:   David Aguilar <davvid@gmail.com>
Date:   Sun, 24 Oct 2021 15:54:49 -0700
Message-ID: <CAJDDKr5frTgh4_x5yvskJfppew3ntvpgBe9MnUB9CfGQaw1TLQ@mail.gmail.com>
Subject: Re: [RFC PATCH] mergetools/vimdiff: add vimdiff4 merge tool variant
To:     Fernando Ramos <greenfoo@u92.eu>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Seth House <seth@eseth.com>, levraiphilippeblain@gmail.com,
        rogi@skylittlesystem.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 19, 2021 at 2:22 PM Fernando Ramos <greenfoo@u92.eu> wrote:
>
> This new vimdiff4 variant of the merge-tool opens three tabs:
>
>   - The first one contains the same panes as the standard "vimdiff" (ie.
>     LOCAL, BASE and REMOTE in the top row and MERGED in the bottom row).
>
>       ------------------------------------------
>       | <TAB #1> |  TAB #2  |  TAB #3  |       |
>       ------------------------------------------
>       |             |           |              |
>       |   LOCAL     |   BASE    |   REMOTE     |
>       |             |           |              |
>       ------------------------------------------
>       |                                        |
>       |                MERGED                  |
>       |                                        |
>       ------------------------------------------
>
>       NOTE: This view is enough for 90% of the cases, but when the merge is
>             somewhat complex, the three-way differences representation
>             end up being messy. That is why two new tabs are added to
>             show isolated one-to-one diffs.
>
>   - The second one is a vertical diff between BASE and LOCAL
>
>       ------------------------------------------
>       |  TAB #1  | <TAB #2> |  TAB #3  |       |
>       ------------------------------------------
>       |                   |                    |
>       |                   |                    |
>       |                   |                    |
>       |     BASE          |    LOCAL           |
>       |                   |                    |
>       |                   |                    |
>       |                   |                    |
>       ------------------------------------------
>
>   - The third one is a vertical diff between BASE and REMOTE
>
>       ------------------------------------------
>       |  TAB #1  |  TAB #2  | <TAB #3> |       |
>       ------------------------------------------
>       |                   |                    |
>       |                   |                    |
>       |                   |                    |
>       |     BASE          |    REMOTE          |
>       |                   |                    |
>       |                   |                    |
>       |                   |                    |
>       ------------------------------------------
>
> Signed-off-by: Fernando Ramos <greenfoo@u92.eu>
> ---
>  mergetools/vimdiff   | 12 +++++++++++-
>  t/t7610-mergetool.sh |  1 +
>  2 files changed, 12 insertions(+), 1 deletion(-)


Thanks for including the visual diagrams (which I hope gmail doesn't mangle).
That makes it much easier to see what's going on.

I'm personally not opposed to the vimdiff4 variants (we already have 3
others) but what I think might be missing is a bit of documentation
that documents the builtin tools and their variants.

Right now git-mergetool.txt includes config/mergetool.txt for
documenting its config variables. It might be worth having a common
"mergetools.txt" where the builtin tools and variants can be
documented and then we can include that file from both
git-mergetool.txt and git-difftool.txt.

That would be a good place to write up the differences between the
variants, and the diagram you included in the commit message would be
helpful there as well.



>
> diff --git a/mergetools/vimdiff b/mergetools/vimdiff
> index 96f6209a04..f830b1ed95 100644
> --- a/mergetools/vimdiff
> +++ b/mergetools/vimdiff
> @@ -40,6 +40,16 @@ merge_cmd () {
>                                 "$LOCAL" "$REMOTE" "$MERGED"
>                 fi
>                 ;;
> +       *vimdiff4)
> +               if $base_present
> +               then
> +                       "$merge_tool_path" -f -d -c "4wincmd w | wincmd J | tabnew | edit $LOCAL | vertical diffsplit $BASE | tabnew | edit $REMOTE | vertical diffsplit $BASE | 2tabprevious" \
> +                               "$LOCAL" "$BASE" "$REMOTE" "$MERGED"
> +               else
> +                       "$merge_tool_path" -f -d -c 'wincmd l' \
> +                               "$LOCAL" "$MERGED" "$REMOTE"
> +               fi
> +               ;;
>         esac
>  }


It's pretty rad how we're able to get that much vim goodness out of
this snippet of configuration.

There seems to be an issue here, though. The $LOCAL values are passed
to the "edit $LOCAL", "edit $REMOTE" and "vertical diffsplit $BASE"
commands as-is. It seems like this would break when the filenames
contain spaces. Is that correct?

If so, does vimscript have a way to quote those arguments? Does
surrounding the variable with escaped double-quotes ("... | edit
\"$LOCAL\" | ...") work? (... for everything except files with
embedded double-quotes in their name, which might be an acceptable
limitation).



>
> @@ -63,7 +73,7 @@ exit_code_trustable () {
>
>  list_tool_variants () {
>         for prefix in '' g n; do
> -               for suffix in '' 1 2 3; do
> +               for suffix in '' 1 2 3 4; do


Pre-existing, but we typically try to avoid multiple statements on a
single line. It seems worth fixing this up in a preparatory patch
since we're touching these lines.

for prefix in '' g n
do
    for suffix in '' 1 2 3 4
    do
        ...
    done
done



>                         echo "${prefix}vimdiff${suffix}"
>                 done
>         done
> diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
> index 8cc64729ad..755b4c0a4a 100755
> --- a/t/t7610-mergetool.sh
> +++ b/t/t7610-mergetool.sh
> @@ -836,6 +836,7 @@ test_expect_success 'mergetool --tool-help shows recognized tools' '
>         git mergetool --tool-help >mergetools &&
>         grep vimdiff mergetools &&
>         grep vimdiff3 mergetools &&
> +       grep vimdiff4 mergetools &&
>         grep gvimdiff2 mergetools &&
>         grep araxis mergetools &&
>         grep xxdiff mergetools &&

Looks good otherwise, thanks for the RFC patch. I'd recommend getting
the docs and quoting stuff sorted out as the next step towards getting
this merged.

Thanks!

--
David

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0284A1F428
	for <e@80x24.org>; Sat, 28 Apr 2018 16:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757209AbeD1QTM (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Apr 2018 12:19:12 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:46166 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752029AbeD1QTL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Apr 2018 12:19:11 -0400
Received: by mail-yw0-f194.google.com with SMTP id i17-v6so1540413ywg.13
        for <git@vger.kernel.org>; Sat, 28 Apr 2018 09:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cx97XCXhW3/WAYliL+XmpQ03UVIJDyCZTThjUO/nKTk=;
        b=KWGmqRvmqs2TfumTTECPz3Xi29VaefIVqEcSVBgIuJjw2mPD1PZosZecLOACoxOX/r
         ybFLhuRQXh7d6/Hq4ImV/fL4CFwMpdjeObXvgIPZRBLclMKkq6zcd4YPEvOla614FNtl
         6nIXc9UDFB1zVpE0QHUXydAKBJKhsnQIzNMAhPIdGj+CuNocmgyviKUrd8yC1ZV3afsL
         /EPxy3+dKJYXJOXYIf9jrZHqPhKFjeLlmTBXz5odSXKSyhEeuC27tPrfmb41eijFww63
         j/xjKMH2oq2qFL54CzvTVce+2iwUdh9yWTY4VtWf3BSSCJ5N1/wKASBn56lDyNhdhrP9
         09pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cx97XCXhW3/WAYliL+XmpQ03UVIJDyCZTThjUO/nKTk=;
        b=BmflaeqoUBOswSlEZNaTgzcRVYoTueqOS6OXeIq+z31vxHtzmu+Od6Sqd1Yi8A1hAx
         z7QiGTfd3kCqaN8RIoYOFylIKECx521kM4S+RD5q4aV63TxNVb7+wfvYEYYmgaC8Wzmf
         6B/g7LBqX079HYu3udzVifO86HIEjAEvXoiy7nx+mKEE4XqZolkaH3boFqajbgYrdvlp
         z64uFLiRvn1CRWLnMGxarNwu6d5pGTJnEZRK4x8R17IsxOe7YDMqE6vXkvcJGCX1W7Vu
         3D5LhHsd0Do7UPW91lq7B9nLZJxgoiVbw2O9Uoo7tqhsKXUmPw0YoZwIcvm2NGbzj2Vb
         UpuQ==
X-Gm-Message-State: ALQs6tAvY08uJPYyandNV5f9GKeSqXzMcaRGE6d8mCVdQwcIwDIsKpJh
        q5f5vbpCMRMHVaoRe5VOy/6dU30e5/s7T81ja4BCgwrT
X-Google-Smtp-Source: AB8JxZpKZ6yKqXtpyP/nFxDS9ijPkrtlJCm1lfNxXBqVU+WgqgBtgDdeUtfbEwBS8xqetVTGjhLb95oUfhk+z2kzwaA=
X-Received: by 2002:a81:5605:: with SMTP id k5-v6mr3117832ywb.345.1524932350606;
 Sat, 28 Apr 2018 09:19:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Sat, 28 Apr 2018 09:19:09
 -0700 (PDT)
In-Reply-To: <1c8740eaa916351832cbea4cf75b77e5dc965db8.1524868165.git.johannes.schindelin@gmx.de>
References: <cover.1524868165.git.johannes.schindelin@gmx.de> <1c8740eaa916351832cbea4cf75b77e5dc965db8.1524868165.git.johannes.schindelin@gmx.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Sat, 28 Apr 2018 09:19:09 -0700
Message-ID: <CAGZ79kYi5W+m9TQ_iEwPmEaXQ_tvpRjcycGioY5jThtfGM6mYw@mail.gmail.com>
Subject: Re: [PATCH 3/6] rebase -i --root: let the sequencer handle even the
 initial part
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Wink Saville <wink@saville.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 27, 2018 at 3:31 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> In this developer's earlier attempt to accelerate interactive rebases by
> converting large parts from Unix shell script into portable, performant
> C, the --root handling was specifically excluded (to simplify the task a
> little bit; it still took over a year to get that reduced set of patches
> into Git proper).
>
> This patch ties up that loose end: now only --preserve-merges uses the
> slow Unix shell script implementation to perform the interactive rebase.
>
> As the rebase--helper reports progress to stderr (unlike the scripted
> interactive rebase, which reports it to stdout, of all places), we have
> to adjust a couple of tests that did not expect that for `git rebase -i
> --root`.
>
> This patch fixes -- at long last! -- the really old bug reported in
> 6a6bc5bdc4d (add tests for rebasing root, 2013-06-06) that rebasing with
> --root *always* rewrote the root commit, even if there were no changes.
>
> The bug still persists in --preserve-merges mode, of course, but that
> mode will be deprecated as soon as the new --rebase-merges mode
> stabilizes, anyway.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  git-rebase--interactive.sh        |  4 +++-
>  t/t3404-rebase-interactive.sh     | 19 +++++++++++++------
>  t/t3421-rebase-topology-linear.sh |  6 +++---
>  3 files changed, 19 insertions(+), 10 deletions(-)
>
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index cbf44f86482..2f4941d0fc9 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -894,6 +894,8 @@ init_revisions_and_shortrevisions () {
>         else
>                 revisions=$onto...$orig_head
>                 shortrevisions=$shorthead
> +               test -z "$squash_onto" ||
> +               echo "$squash_onto" >"$state_dir"/squash-onto
>         fi
>  }
>
> @@ -948,7 +950,7 @@ EOF
>         die "Could not skip unnecessary pick commands"
>
>         checkout_onto
> -       if test -z "$rebase_root" && test ! -d "$rewritten"
> +       if test ! -d "$rewritten"

I have the impression this is the line that is really well
explained in the commit message ("migrate to rebase
helper even when there is $rebase_root set")

The rest of the patch is covered as "a couple of places
where we adjust stdout to stderr"?

Makes sense,
Stefan

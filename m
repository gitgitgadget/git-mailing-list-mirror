Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B980C433E6
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 18:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B3C964D7F
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 18:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbhBGSqM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Feb 2021 13:46:12 -0500
Received: from mail-ej1-f43.google.com ([209.85.218.43]:37111 "EHLO
        mail-ej1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbhBGSoH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Feb 2021 13:44:07 -0500
Received: by mail-ej1-f43.google.com with SMTP id jj19so21243987ejc.4
        for <git@vger.kernel.org>; Sun, 07 Feb 2021 10:43:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LY4JmTufTnD7rJ1xC7jGn184UV0+hXRj9nLDmTpcDlc=;
        b=LYIUBWtH3ZgVLHezyj4HfSHZZcYqzGzRV9DcHwQABCVQayuWDNkfOr6tS45oBlfzZi
         hvKqw2PjtMi0JLkCa7/AsK0TuqY5lzY9hGcosm08iYbwVY/N2JIbLPHuryupSDXHUFqm
         x7iEffA3mECLGQnXLLk3tfxWePgszZv2hFg3n1t8DtGzli6svbr+hgYdcbAH/eXpssPF
         inZY3im9U345p1OA78QSfL3TrG2H2/36pTV6Obh0ukGX77d2SrBI4YfsyuhCkU1VgZBA
         D3otfUHJ3dBpcquSymU/IllNHG7f/w5mFusB8NVLZu9u0xCVjG98IfOg6iV5mMHTa5l+
         yKnQ==
X-Gm-Message-State: AOAM5332vrtz7jHlfNySK/OO9LUbMR7Ib4E+BggF/twhwsuCbxQdIJVn
        675CoQzyYKEtyH3zATPwLzSq+36QKz+08QBO0XA=
X-Google-Smtp-Source: ABdhPJzE+cdPBgxe818PNC8ewBSUdR9iqwNcBgm0m1F2O7uhDk8k2xjGI9U5rnoSFtRv7VCH/Lm6oC+/XlkdibPEfKg=
X-Received: by 2002:a17:906:4348:: with SMTP id z8mr13704493ejm.371.1612723405172;
 Sun, 07 Feb 2021 10:43:25 -0800 (PST)
MIME-Version: 1.0
References: <20210207181439.1178-1-charvi077@gmail.com> <20210207181439.1178-7-charvi077@gmail.com>
In-Reply-To: <20210207181439.1178-7-charvi077@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 7 Feb 2021 13:43:14 -0500
Message-ID: <CAPig+cTDT5Hct7dUTY93nO+P5-US=ZokuGhOQeELPpZwQGzf=w@mail.gmail.com>
Subject: Re: [PATCH 6/7] t/t3437: update the tests
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 7, 2021 at 1:19 PM Charvi Mendiratta <charvi077@gmail.com> wrote:
> Let's do the changes listed below to make tests more easier to follow :
>
> -Remove the dependency of 'expected-message' file from earlier tests to
> make it easier to run tests selectively with '--run' or 'GIT_SKIP_TESTS'.
>
> -Add author timestamp to check that the author date of fixed up commit
> is unchanged.
>
> -Simplify the test_commit_message() and add comments before the
> function.
>
> -Clarify the working of 'fixup -c' with "amend!" in the test-description.
>
> -Remove unnecessary curly braces and use the named commits in the
> tests so that they will still refer to the same commit if the setup
> gets changed in the future whereas 'branch~2' will change which commit
> it points to.

Typically, if you find yourself enumerating a list of distinct changes
like this in a commit message, it's a good indication that it should
be split into multiple patches, each taking care of one item from the
list. A good reason for splitting it up like this is that it's
difficult for reviewers to keep the entire list in mind while
reviewing the patch, however, it's easy to keep in mind a single
stated goal while reading the changes.

Having said that, I'm not sure it's worth a re-roll or the extra work
of actually splitting it up since you've already been dragged deeper
into this than planned, and these are relatively minor issues.

(Returning to this after reading the remainder of the patch, I did
find it reasonably confusing trying to figure out which changes
related to each other and to items from the list above. It would have
been easier to reason about the changes had they been done in separate
patches. Still, though, I'm not sure it's worth the time and effort to
split them up -- but I wouldn't complain if you did.)

More below...

> Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
> ---
> diff --git a/t/t3437-rebase-fixup-options.sh b/t/t3437-rebase-fixup-options.sh
> @@ -8,8 +8,10 @@ test_description='git rebase interactive fixup options
>  This test checks the "fixup [-C|-c]" command of rebase interactive.
>  In addition to amending the contents of the commit, "fixup -C"
>  replaces the original commit message with the message of the fixup
> -commit. "fixup -c" also replaces the original message, but opens the
> -editor to allow the user to edit the message before committing.
> +commit and similar to "fixup" command that works with "fixup!", "fixup -C"
> +works with "amend!" upon --autosquash. "fixup -c" also replaces the original
> +message, but opens the editor to allow the user to edit the message before
> +committing.
>  '

I had trouble digesting this run-on sentence due, I think, to the
mixing of thoughts. It might be easier to understand if you first talk
only about the options to `fixup` (-c/-C), and then, as a separate
sentence, talk about how `amend!` is transformed into `fixup -C` (like
`fixup!` is transformed into `fixup`). However, as this is just minor
descriptive text in a test file, not user-facing documentation, I'm
not sure it matters enough to warrant a re-roll.

> @@ -18,36 +20,34 @@ editor to allow the user to edit the message before committing.
> +# test_commit_message <rev> -m <msg>
> +# test_commit_message <rev> <path>
> +# Verify that the commit message of <rev> matches
> +# <msg> or the content of <path>.

Good.

>  test_commit_message () {
> +       git show --no-patch --pretty=format:%B "$1" >actual &&
> +    case "$2" in
> +    -m) echo "$3" >expect &&
> +           test_cmp expect actual ;;
> +    *) test_cmp "$2" actual ;;
> +    esac
>  }

The funky indentation here is due to a mix of tabs and spaces. It
should use tabs exclusively.

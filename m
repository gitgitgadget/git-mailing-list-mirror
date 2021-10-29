Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF73BC433F5
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 18:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3B57610CF
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 18:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhJ2SH3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 14:07:29 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42]:35796 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhJ2SH3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 14:07:29 -0400
Received: by mail-ed1-f42.google.com with SMTP id g8so41682598edb.2
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 11:05:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vm5dB/O6WKq3UR3x2bxLm9MNk275/m9/fLsQbxBchmY=;
        b=LrUgtCHvUO6arCThhuGbG8DuVlJS5dU0AU8THZAxeRcDimion9HRflARQ/d4U7BzE6
         dqKt6ETGUSg48ue7F/TrE5FAvfLkmcCjFfaqPi66SDTN7rdTWoX5eOiOmO8vDk3+ALzI
         vCMuuWljwbrRiE2Sj95uJstX4UBdWR2lKxBfKntn2GWIAmYTnYPNqsE7zLQ1lV2nmcL6
         YSxUs4ht34QamtmhAPhBKLKkrrIywwQEbE1neffKWDnueEJoJnryS0H7QLpKu2uOiFKU
         AvUbSCiA5vPsSjIEwnw5R8dAycV4w1ZwCR8GmdklJ6+WogqssiNoyNKGIt/SM0bLtQMZ
         HHWA==
X-Gm-Message-State: AOAM532+TSvppImPFAp+0pH5Mb++GUUiIFb7g5aNikNe0E7wZ+Fk0CNC
        0cb0UQhiFVsPScyKtSzwNXE7OUhqqD0P1ZZjiZQb/Ymw7po=
X-Google-Smtp-Source: ABdhPJzpPLKuwSUebu8t5k6tjssQBvuo+MJCPn9fc53hMtbs8sI9SpvI9kvVsavyKzVSFgl7dMfv4+EZG7667/ouUFk=
X-Received: by 2002:a17:906:39b:: with SMTP id b27mr15258559eja.568.1635530699254;
 Fri, 29 Oct 2021 11:04:59 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1063.git.1635343531.gitgitgadget@gmail.com>
 <pull.1063.v2.git.1635530296.gitgitgadget@gmail.com> <5c9deaf0bccfe158c7f410f084529850a33b7fd0.1635530296.git.gitgitgadget@gmail.com>
In-Reply-To: <5c9deaf0bccfe158c7f410f084529850a33b7fd0.1635530296.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 29 Oct 2021 14:04:48 -0400
Message-ID: <CAPig+cRzdzK7f=+38u-RuwL80WPoPvX8pwr8GK5vebvuQH5yUg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] docs: fix places that break compilation in MyFirstObjectWalk
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, John Cai <johncai86@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 29, 2021 at 1:58 PM John Cai via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Two errors in the example code caused compilation failures due to
> a missing semicolon as well as initialization with an empty struct.
> This commit fixes that to make the MyFirstObjectWalk tutorial easier to
> follow.
>
> Signed-off-by: John Cai <johncai86@gmail.com>
> ---
> diff --git a/Documentation/MyFirstObjectWalk.txt b/Documentation/MyFirstObjectWalk.txt
> @@ -58,6 +58,7 @@ running, enable trace output by setting the environment variable `GIT_TRACE`.
>  Add usage text and `-h` handling, like all subcommands should consistently do
>  (our test suite will notice and complain if you fail to do so).
> +We'll need to include the `parse-options.h` header.

It seems like this change belongs in patch [2/2].

> @@ -65,7 +66,7 @@ int cmd_walken(int argc, const char **argv, const char *prefix)
>         const char * const walken_usage[] = {
>                 N_("git walken"),
>                 NULL,
> -       }
> +       };

Whereas, this change correctly resides in patch [1/2].

>         struct option options[] = {
>                 OPT_END()
>         };
> @@ -195,7 +196,8 @@ Similarly to the default values, we don't have anything to do here yet
>  ourselves; however, we should call `git_default_config()` if we aren't calling
>  any other existing config callbacks.
>
> -Add a new function to `builtin/walken.c`:
> +Add a new function to `builtin/walken.c`.
> +We'll also need to include the `config.h` header:

Should be in patch [2/2].

> @@ -229,7 +231,9 @@ typically done by calling `repo_init_revisions()` with the repository you intend
>  to target, as well as the `prefix` argument of `cmd_walken` and your `rev_info`
>  struct.
>
> -Add the `struct rev_info` and the `repo_init_revisions()` call:
> +Add the `struct rev_info` and the `repo_init_revisions()` call.
> +We'll also need to include the `revision.h` header:

Patch [2/2].

> @@ -624,7 +628,8 @@ static void walken_object_walk(struct rev_info *rev)
>  Let's start by calling just the unfiltered walk and reporting our counts.
> -Complete your implementation of `walken_object_walk()`:
> +Complete your implementation of `walken_object_walk()`.
> +We'll also need to include the `list-objects.h` header.

Also patch [2/2].

> @@ -697,7 +702,7 @@ First, we'll need to `#include "list-objects-filter-options.h"` and set up the
>  static void walken_object_walk(struct rev_info *rev)
>  {
> -       struct list_objects_filter_options filter_options = {};
> +       struct list_objects_filter_options filter_options = { 0 };

Good, this change belongs here in patch [1/2].

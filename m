Return-Path: <SRS0=DNff=2R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48BFC2D0C3
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 21:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7441920740
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 21:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JnlYR0XR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfL0Vhw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Dec 2019 16:37:52 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42030 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbfL0Vhw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Dec 2019 16:37:52 -0500
Received: by mail-ot1-f68.google.com with SMTP id 66so37734625otd.9
        for <git@vger.kernel.org>; Fri, 27 Dec 2019 13:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yeycfrUwoStfcy8hJsyGOP4YJkO/3YKxRgcGxREQjfc=;
        b=JnlYR0XRZGmMXjgNoI6+aNyv4hKwRJbErbvu4wIiVhtBU/lcP3tghuZN8LAVGf0oEH
         95jOM2OglwIAg7m18hzKjat7BRn5DRgFXBlO6OgLyS4r61BFRLaEtWRFpvfaBOqwm/bw
         Jv6ETSM670cB9VbTb+WqPvBFgpeAl3BpfNFmkERPSRtfDYVYGGSOHhCA6KzK30ft7HAM
         gUY7P5yDQ9MLvv409zw8NpoXDpQGS9QNBtT0LSaK39sOUzQmlwUCyiLtValLfkHHJl1v
         DNJPN8YuO70uXWEJG1fTH/B5zBvNbnEEpX8qxT1YP6EXh2rXHOVwUAPqapcjufxlbg/D
         1z9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yeycfrUwoStfcy8hJsyGOP4YJkO/3YKxRgcGxREQjfc=;
        b=dhe8JXhYBdkhmFknR+oIFurv/dPgHDqnOSrmfFmvZ9WSlQQuuOOGh8eAziz7EFkXcu
         T4zOOMEJ0ewXwEnqBzeAikUvJJ/5dQWSyuadVRl6z+XCXZ0axbm/jXecjywPYU3HctYT
         Zz9kH1z6AZ8HmeWsJofPa9ke3iMJv0VlsSyawg8d9KI6LcMGmqLY+/Qa9xg5NdEh5nF1
         vIreiNu37DVTFuqN5yvlpln5EkhhwWpA9j8Vo7MqooONLrvw/4X5gzbHbNUO48KxjKQi
         q0N7E015yl1QdqYqsHbz0EhyNqOHDYu+AeKWCw/zYSVn/crNJ1WdJ41ds+F6/qWeYxwu
         mEjg==
X-Gm-Message-State: APjAAAWkXwoNCj5ZROLkLOifJdLdITkP7oxwQnyQ2KoCEj4M+h4V+lFG
        m3wtVE9lGC4LXZ9Ng1DSVpW3oYLKq/INtr2KRWg=
X-Google-Smtp-Source: APXvYqzOWlMMEtXBOQx3MGQrHxQYiiOWjVHPJyF0VhRsvddztJEitRzn4qNj8hbiqeXAWBswFMeA2VdWUaSYTmiMv00=
X-Received: by 2002:a05:6830:158:: with SMTP id j24mr60317234otp.316.1577482671252;
 Fri, 27 Dec 2019 13:37:51 -0800 (PST)
MIME-Version: 1.0
References: <pull.500.git.1577393347.gitgitgadget@gmail.com>
 <pull.500.v2.git.1577472469.gitgitgadget@gmail.com> <d6f4f404866e30e9de89991bb39f2908facb30ae.1577472469.git.gitgitgadget@gmail.com>
In-Reply-To: <d6f4f404866e30e9de89991bb39f2908facb30ae.1577472469.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 27 Dec 2019 13:37:44 -0800
Message-ID: <CABPp-BGGfwR3r1YZuyeQN1=WqokSBdcHeFWkkZ2OD_S9Enfb0w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] sparse-checkout: list folders in cone mode
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        jon@jonsimons.org, Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 27, 2019 at 10:47 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> When core.sparseCheckoutCone is enabled, the 'git sparse-checkout set'
> command takes a list of folders as input, then creates an ordered
s/folders/directories/

> list of sparse-checkout patterns such that those folders are
s/folders/directories/

> recursively included and all sibling entries along the parent folders
again here.

> are also included. Listing the patterns is less user-friendly than the
> folders themselves.
and here.

>
> In cone mode, and as long as the patterns match the expected cone-mode
> pattern types, change the output of 'git sparse-checkout list' to only
> show the folders that created the patterns.
and here.

>
> With this change, the following piped commands would not change the
> working directory:
>
>         git sparse-checkout list | git sparse-checkout set --stdin
>
> The only time this would not work is if core.sparseCheckoutCone is
> true, but the sparse-checkout file contains patterns that do not
> match the expected pattern types for cone mode.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/git-sparse-checkout.txt | 11 ++++++++++-
>  builtin/sparse-checkout.c             | 21 +++++++++++++++++++++
>  t/t1091-sparse-checkout-builtin.sh    | 11 +++++++++++
>  3 files changed, 42 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
> index 9c3c66cc37..dcca9ee826 100644
> --- a/Documentation/git-sparse-checkout.txt
> +++ b/Documentation/git-sparse-checkout.txt
> @@ -28,7 +28,7 @@ THE FUTURE.
>  COMMANDS
>  --------
>  'list'::
> -       Provide a list of the contents in the sparse-checkout file.
> +       Describe the patterns in the sparse-checkout file.
>
>  'init'::
>         Enable the `core.sparseCheckout` setting. If the
> @@ -150,6 +150,15 @@ expecting patterns of these types. Git will warn if the patterns do not match.
>  If the patterns do match the expected format, then Git will use faster hash-
>  based algorithms to compute inclusion in the sparse-checkout.
>
> +In the cone mode case, the `git sparse-checkout list` subcommand will list the
> +folders that define the recursive patterns. For the example sparse-checkout file
and here.

> +above, the output is as follows:
> +
> +--------------------------
> +$ git sparse-checkout list
> +A/B/C
> +--------------------------
> +
>  If `core.ignoreCase=true`, then the pattern-matching algorithm will use a
>  case-insensitive check. This corrects for case mismatched filenames in the
>  'git sparse-checkout set' command to reflect the expected cone in the working
> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> index 5d62f7a66d..b3bed891cb 100644
> --- a/builtin/sparse-checkout.c
> +++ b/builtin/sparse-checkout.c
> @@ -53,6 +53,8 @@ static int sparse_checkout_list(int argc, const char **argv)
>
>         memset(&pl, 0, sizeof(pl));
>
> +       pl.use_cone_patterns = core_sparse_checkout_cone;
> +
>         sparse_filename = get_sparse_checkout_filename();
>         res = add_patterns_from_file_to_list(sparse_filename, "", 0, &pl, NULL);
>         free(sparse_filename);
> @@ -62,6 +64,25 @@ static int sparse_checkout_list(int argc, const char **argv)
>                 return 0;
>         }
>
> +       if (pl.use_cone_patterns) {
> +               int i;
> +               struct pattern_entry *pe;
> +               struct hashmap_iter iter;
> +               struct string_list sl = STRING_LIST_INIT_DUP;
> +
> +               hashmap_for_each_entry(&pl.recursive_hashmap, &iter, pe, ent) {
> +                       /* pe->pattern starts with "/", skip it */
> +                       string_list_insert(&sl, pe->pattern + 1);
> +               }
> +
> +               string_list_sort(&sl);
> +
> +               for (i = 0; i < sl.nr; i++)
> +                       printf("%s\n", sl.items[i].string);
> +
> +               return 0;
> +       }
> +
>         write_patterns_to_file(stdout, &pl);
>         clear_pattern_list(&pl);
>
> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
> index 6f7e2d0c9e..37f6d8fa90 100755
> --- a/t/t1091-sparse-checkout-builtin.sh
> +++ b/t/t1091-sparse-checkout-builtin.sh
> @@ -246,6 +246,17 @@ test_expect_success 'cone mode: init and set' '
>         test_cmp expect dir
>  '
>
> +test_expect_success 'cone mode: list' '
> +       cat >expect <<-EOF &&
> +               folder1
> +               folder2
> +       EOF
> +       git -C repo sparse-checkout set --stdin <expect &&
> +       git -C repo sparse-checkout list >actual 2>err &&
> +       test_must_be_empty err &&
> +       test_cmp expect actual
> +'
> +
>  test_expect_success 'cone mode: set with nested folders' '
There's another one here but that's just the context area, so it'd be
a separate patch in a separate cleanup series...

>         git -C repo sparse-checkout set deep deep/deeper1/deepest 2>err &&
>         test_line_count = 0 err &&
> --

The rest looks good

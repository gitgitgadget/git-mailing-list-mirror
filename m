Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5400FC433DB
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 08:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08FAA23106
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 08:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbhAFIcl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 03:32:41 -0500
Received: from mail-ed1-f41.google.com ([209.85.208.41]:39909 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbhAFIcl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 03:32:41 -0500
Received: by mail-ed1-f41.google.com with SMTP id c7so3661193edv.6
        for <git@vger.kernel.org>; Wed, 06 Jan 2021 00:32:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ue7i6cgP1swr/SWFOTg7RKvvS5+oK2JoSvQ+LdDXMkw=;
        b=eLjA1yAMpUnM/hH/RdSVRHylpW3GnzzNTX8s443WtocNthPbMOuodg203253a7ODFp
         8WqcF8LO9pS0COHMyzbw6p/OF8RB1mKd7rbE/fawjz2CNENiuk7ygU2O9MGAHuv2pZ2Y
         fItoP3hTX4EXajVxJZYDZK9HCUj3/42tdZTEYvotYf3itEyU/IlZwyWSVQp7hbtTpEyX
         DIsp3TXFLkcgfoByfSgXaJ8lNHdV//MsEhvd5oVfy/u3OrCMz0KNXVNL3QvWFr4Afxau
         ZPjCsQrfYAieBa4esPnxPRjLtwSS7BWQcGgNMZ7JS95Zd8TC5uHnqiDP+Zu2xJuxdprC
         bujw==
X-Gm-Message-State: AOAM531WtR1ZWjHNTX7disefyGfBQ/DE59N6F5LeWrsATxzbKhxz3kjy
        jvqjxn9GRIvg288yR2MsVLYHk1IokDzaHxfoWpw=
X-Google-Smtp-Source: ABdhPJw6yVYYH3rR8MNtY9l/vvnIUJ61MiKi3MNNfcfIyiBkLgJlVt/iCtqoBpMVgC85m90cy8abhNSkdmpp2CAqn5k=
X-Received: by 2002:a05:6402:1592:: with SMTP id c18mr3174090edv.181.1609921918253;
 Wed, 06 Jan 2021 00:31:58 -0800 (PST)
MIME-Version: 1.0
References: <20210104162128.95281-1-rafaeloliveira.cs@gmail.com> <20210104162128.95281-5-rafaeloliveira.cs@gmail.com>
In-Reply-To: <20210104162128.95281-5-rafaeloliveira.cs@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 6 Jan 2021 03:31:46 -0500
Message-ID: <CAPig+cRO86CXFPfiX7dj3Qkxv0O6nXXe0gqd+OkaXgHUbi7Vqw@mail.gmail.com>
Subject: Re: [PATCH 4/7] worktree: teach `list` prunable annotation and verbose
To:     Rafael Silva <rafaeloliveira.cs@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 4, 2021 at 11:22 AM Rafael Silva
<rafaeloliveira.cs@gmail.com> wrote:
> The "git worktree list" command shows the absolute path to the worktree,
> the commit that is checked out, the name of the branch, and a "locked"
> annotation if the worktree is locked. It is not clear whether a worktree,
> if any, is prunable.

Maybe this could just say...

    ... "locked" annotation if the worktree is locked,
    however, it does not indicate whether it is prunable.

> The "prune" command will remove a worktree in case
> is a prunable candidate unless --dry-run option is specified. This could

s/case is/case it is/

Or better:

    ... will remove a worktree if it is prunable unless...

> lead to a worktree being removed without the user realizing before is to
> late, in case the user forgets to pass --dry-run for instance.

s/before is/before it is/
s/to/too/

> If the "list" command shows which worktree is prunable, the user could
> verify before running "git worktree prune" and hopefully prevents the
> working tree to be removed "accidently" on the worse case scenario.
>
> Let's teach "git worktree list" to show when a worktree is prunable by
> appending "prunable" text to its output by default and show a prunable
> label for the porcelain format followed by the reason, if the avaiable.
> While at it, let's do the same for the "locked" annotation.

s/avaiable/available/

> Also, the worktree_prune_reason() stores the reason why git is selecting
> the worktree to be pruned, so let's leverage that and also display this
> information to the user. However, the reason is human readable text that
> can take virtually any size which might make harder to extend the "list"
> command with additional annotations and not fit nicely on the screen.
>
> In order to address this shortcoming, let's teach "git worktree list" to
> take a verbose option that will output the prune reason on the next line
> indented, if the reason is available, otherwise the annotation is kept on
> the same line. While at it, let's do the same for the "locked"
> annotation.

This is a lot of changes for one patch to be making, and it's hard for
a reader to digest all those changes from the commit message. I think
I counted four distinct changes being made here:

1. extend porcelain to include lock line (with optional reason)
2. add prunable annotation to normal list output
3. add prune line (with optional reason) to porcelain output
4. extend normal list output with --verbose to include reasons

The patch itself is not overly large or complicated, so perhaps
combining all these changes together is reasonable, although I'm quite
tempted to ask for them to be separated into at least four patches
(probably in the order shown above). A benefit of splitting them into
distinct patches is that you can add targeted documentation and test
updates to each individual patch rather than saving all the
documentation and test updates for a single (large) patch at the end
of the series. This helps reviewers reason about the changes more
easily since they get to see how each change impacts the documentation
and tests rather than having to wait for a patch late in the series to
make all the documentation and test updates, at which point the
reviewers may have forgotten details of the earlier patches.

(I've come back here after reading and reviewing the patch itself, and
I'm on the fence as to whether to suggest splitting this into multiple
patches. The changes in this patch are easy enough to understand and
digest, so I'm not convinced it makes sense to ask you to do all the
extra work of splitting it into smaller pieces. On the other hand, it
might be nice to have each documentation and test update done in the
patch which makes each particular change. So, I don't have a good
answer. Use your best judgment and do the amount of work you feel is
appropriate.)

> The output of "git worktree list" with verbose becomes like so:
>
>     $ git worktree list --verbose
>     /path/to/main             aba123 [main]
>     /path/to/locked           acb124 [branch-a] locked
>     /path/to/locked-reason    acc125 [branch-b]
>         locked: worktree with locked reason
>     /path/to/prunable         acd126 [branch-c] prunable
>     /path/to/prunable-reason  ace127 [branch-d]
>         prunable: gitdir file points to non-existent location

One "weird" aesthetic issue is that if the lock reason contains
newlines, the subsequent lines of the lock reason are not indented.
However, this is a very minor point and I don't think this patch
series should worry about it. We can think about how to address it
some time in the future if someone ever complains about it.

> Signed-off-by: Rafael Silva <rafaeloliveira.cs@gmail.com>
> ---
>  builtin/worktree.c | 35 +++++++++++++++++++++++++++++++++--
>  1 file changed, 33 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index eeb3ffaed0..dedd4089e5 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -578,6 +578,20 @@ static void show_worktree_porcelain(struct worktree *wt)
> +               if (worktree_lock_reason(wt)) {
> +                       if (*wt->lock_reason)
> +                               printf("locked %s\n", wt->lock_reason);
> +                       else
> +                               printf("locked\n");
> +               }
> +
> +               if (worktree_prune_reason(wt, expire)) {
> +                       if (*wt->prune_reason)
> +                               printf("prunable %s\n", wt->prune_reason);
> +                       else
> +                               printf("prunable\n");
> +               }

A couple observations...

As a consumer of `struct worktree`, builtin/worktree.c should not be
poking at or accessing the structure's private fields `prune_reason`
and `lock_reason`; instead it should be retrieving those values via
worktree_prune_reason() and worktree_lock_reason() which are part of
the public API.

If a worktree is prunable, then worktree_prune_reason() will
unconditionally return a (non-empty) string; if it is not prunable,
then it will unconditionally return NULL. This means that the
`printf("prunable\n")` case is dead-code; it will never be reached.
This differs from worktree_lock_reason() which can return an empty
string to indicate a locked worktree for which no reason has been
specified.

Taking the above observations into account, a reasonable rewrite would be:

    const char *reason;

    reason = worktree_lock_reason(wt);
    if (reason && *reason)
        printf("locked %s\n", reason);
    else if (reason)
        printf("locked\n");

    reason = worktree_prune_reason(wt, expire);
    if (reason)
        printf("prunable %s\n", reason);

> @@ -604,8 +618,19 @@ static void show_worktree(struct worktree *wt, int path_maxlen, int abbrev_len)
>                         strbuf_addstr(&sb, "(error)");
>         }
>
> -       if (!is_main_worktree(wt) && worktree_lock_reason(wt))
> -               strbuf_addstr(&sb, " locked");
> +       if (worktree_lock_reason(wt)) {
> +               if (verbose && *wt->lock_reason)
> +                       strbuf_addf(&sb, "\n\tlocked: %s", wt->lock_reason);
> +               else
> +                       strbuf_addstr(&sb, " locked");
> +       }
> +
> +       if (worktree_prune_reason(wt, expire)) {
> +               if (verbose && *wt->prune_reason)
> +                       strbuf_addf(&sb, "\n\tprunable: %s", wt->prune_reason);
> +               else
> +                       strbuf_addstr(&sb, " prunable");
> +       }

Same observations here about using public API rather than touching
private `struct worktree` fields, and about the final `else` case
being dead code.

> @@ -650,12 +675,18 @@ static int list(int ac, const char **av, const char *prefix)
>                 OPT_BOOL(0, "porcelain", &porcelain, N_("machine-readable output")),
> +               OPT__VERBOSE(&verbose, N_("show extended annotations and reasons, if available")),
> +               OPT_EXPIRY_DATE(0, "expire", &expire,
> +                               N_("show working trees that is candidate to be pruned older than <time>")),

Perhaps:

    "add 'prunable' annotation to worktrees older than <time>"

>                 OPT_END()
>         };
>
> +       expire = TIME_MAX;

Good, this mirrors how prune() initializes this variable.

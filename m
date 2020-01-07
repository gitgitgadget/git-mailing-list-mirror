Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E53C33C99
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 11:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AA6A20848
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 11:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgAGLQb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 06:16:31 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43934 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727427AbgAGLQb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 06:16:31 -0500
Received: by mail-wr1-f65.google.com with SMTP id d16so53468434wre.10
        for <git@vger.kernel.org>; Tue, 07 Jan 2020 03:16:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6ycQ7J9nbkdNNGEmaszYvsnUIUrnThwzFi1651tatcs=;
        b=cH627kvpEAyMwuyLdPTwbGdg2FUSfAOLJxR00WCyXALrHrXqixzHSl8ilj7kmnt43D
         uXYm/hAORa0E7MiRTsjsTcq2FbsTr65KEY8TYvxSjGq1zeTASF+P80zpWgziL0UUOJIx
         HbIXhx/htq17Lwngd7JP/52DtZkx68jCiu7lSpJ92Cs7xp0ljqoEb0jMC+hmlVv/MABK
         G4Xf7Ovd7l21OCxFk3/rMEVlA+braBeIl3ZfFUey+jLq6MJfwO8aODlb//PVL3gmPCAt
         HR6FQ5ekkVwy+PKLDkstdD++FD+ALb5wQtAy8QU7HTu3j5/lEQ4bjmcy3nhnIEFma9LT
         SmGA==
X-Gm-Message-State: APjAAAWzVmolyn2iSEuRdrNY5Eli6S0A3EpYpkgwDkz40i7Wjm08tiaR
        kbGLOhNuvyc2tVD/N4MZXeqFwL4S57Fxyzz2yG/R7uag
X-Google-Smtp-Source: APXvYqxw+7s9KmeK3JPOKuoM1isqP3tOOrtHjOrZ6OuuEDgwKprddUWQh/2KfdpKXCDq7T8ScoiGOQf6e6STKa5BRx4=
X-Received: by 2002:adf:b193:: with SMTP id q19mr108493151wra.78.1578395788874;
 Tue, 07 Jan 2020 03:16:28 -0800 (PST)
MIME-Version: 1.0
References: <pull.507.git.1577933387.gitgitgadget@gmail.com>
 <pull.507.v2.git.1578370226.gitgitgadget@gmail.com> <19a7cc1889d6094e4f8a94c19c43ad554662e8d8.1578370226.git.gitgitgadget@gmail.com>
In-Reply-To: <19a7cc1889d6094e4f8a94c19c43ad554662e8d8.1578370226.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 7 Jan 2020 06:16:17 -0500
Message-ID: <CAPig+cQ0qY8KDZrQ8khuz34DqPimorN7JHHn0Ms=KpvJYtxJoA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] branch: advise the user to checkout a different
 branch before deleting
To:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Heba Waly <heba.waly@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 6, 2020 at 11:10 PM Heba Waly via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> branch: advise the user to checkout a different branch before deleting
>
> Display a hint to the user when attempting to delete a checked out
> branch.
>
> Currently the user gets an error message saying: "error: Cannot delete
> branch <branch> checked out at <path>". The hint will be displayed
> after the error message.

A couple comments...

The second paragraph doesn't say anything beyond what the patch/code
itself already says clearly (plus, there's no need to state the
obvious), so the paragraph adds no value (yet eats up reviewer time).
Therefore, it can be dropped.

To convince readers that the change made by the patch is indeed
warranted, it's always important to explain _why_ this change is being
made.

Both points can be addressed with a short and sweet commit message,
perhaps like this:

    branch: advise how to delete checked-out branch

    Teach newcomers how to deal with Git refusing to delete a
    checked-out branch (whether in the current worktree or some
    other).

By the way, did you actually run across a real-world case in which
someone was confused about how to resolve this situation? I ask
because this almost seems like too much hand-holding, and it would be
nice to avoid polluting Git with unnecessary advice.

> Signed-off-by: Heba Waly <heba.waly@gmail.com>
> ---
> diff --git a/advice.c b/advice.c
> @@ -31,6 +31,7 @@ int advice_graft_file_deprecated = 1;
> @@ -91,7 +92,8 @@ static struct {
>         { "submoduleAlternateErrorStrategyDie", &advice_submodule_alternate_error_strategy_die },
> -
> +       { "deleteCheckedoutBranch", &advice_delete_checkedout_branch },
> +

When you see an odd-looking diff like this in which you wouldn't
expect any diff markers on the blank line (that is, the blank line got
deleted and re-added), it's a good indication that there's unwanted
trailing whitespace on one of the lines. In this case, you (or more
likely your editor automatically) added trailing whitespace to the
blank line which doesn't belong there. Unwanted whitespace changes
like this make the patch noisier and more difficult for a reviewer to
read.

> diff --git a/advice.h b/advice.h
> @@ -31,6 +31,7 @@ extern int advice_graft_file_deprecated;
> +extern int advice_delete_checkedout_branch;

Is there precedent elsewhere for spelling this "checkedout" rather
than the more natural "checked_out"?

> diff --git a/builtin/branch.c b/builtin/branch.c
> @@ -240,6 +240,20 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
> +                               if (advice_delete_checkedout_branch) {
> +                                       if (wt->is_current) {
> +                                               advise(_("The branch you are trying to delete is already "
> +                                                       "checked out, run the following command to "
> +                                                       "checkout a different branch then try again:\n"
> +                                                       "git switch <branch>"));

This advice unnecessarily repeats what the error message just above it
already says about the branch being checked out (thus adds no value),
and then jumps directly into showing the user an opaque command to
resolve the situation without explaining _how_ or _why_ the command is
supposed to help.

Advice messages elsewhere typically indent the example command to make
it stand out from the explanatory prose (and often separated it from
the text by a blank line).

A rewrite which addresses both these issues might be something like:

    Switch to a different branch before trying to delete it. For
    example:

        git switch <different-branch>
        git branch -%c <this-branch>

(and fill in %c with either "-d" or "-D" depending upon the value of 'force')

> +                                       }
> +                                       else {
> +                                               advise(_("The branch you are trying to delete is checked "
> +                                                       "out on another worktree, run the following command "
> +                                                       "to checkout a different branch then try again:\n"
> +                                                       "git -C %s switch <branch>"), wt->path);

I like the use of -C here because it makes the command self-contained,
however, I also worry because wt->path is an absolute path, thus
likely to be quite lengthy, which means that the important part of the
example command (the "switch <branch>") can get pushed quite far away,
thus is more easily overlooked by the reader. I wonder if it would
make more sense to show the 'cd' command explicitly, although doing so
ties the example to a particular shell, which may be a downside.

    cd %s
    git switch <different-branch>
    cd -
    git branch -%c <this-branch>

(It is rather verbose and ugly, though.)

> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> @@ -807,8 +807,10 @@ test_expect_success 'test deleting branch without config' '
>  test_expect_success 'deleting currently checked out branch fails' '
>         git worktree add -b my7 my7 &&
> -       test_must_fail git -C my7 branch -d my7 &&
> -       test_must_fail git branch -d my7 &&
> +       test_must_fail git -C my7 branch -d my7 2>output1.err &&
> +       test_must_fail git branch -d my7 2>output2.err &&
> +       test_i18ngrep "hint: The branch you are trying to delete is already checked out" output1.err &&
> +       test_i18ngrep "hint: The branch you are trying to delete is checked out on another worktree" output2.err &&

Nit: Separating the 'grep' from the command which generated the error
output makes it harder for a reader to see at a glance what is being
tested and to reason about it since it demands that the reader keep
two distinct cases in mind rather than merely focusing on one at a
time. Also, doing it this way forces you to invent distinct filenames
(by appending a number, for instance), which further leads the reader
to wonder if there is some significance (later in the test) to keeping
these outputs in separate files. So, a better organization (with more
natural filenames) would be:

    test_must_fail git -C my7 branch -d my7 2>output.err &&
    test_i18ngrep "hint: ..." output.err &&
    test_must_fail git branch -d my7 2>output.err &&
    test_i18ngrep "hint: ..." output.err &&

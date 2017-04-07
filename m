Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B14E220966
	for <e@80x24.org>; Fri,  7 Apr 2017 22:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755356AbdDGWlp (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Apr 2017 18:41:45 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:34231 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752384AbdDGWlo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2017 18:41:44 -0400
Received: by mail-pg0-f45.google.com with SMTP id 21so78470858pgg.1
        for <git@vger.kernel.org>; Fri, 07 Apr 2017 15:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=A+82jrDdJl7DldYghgqWWw39t+2hiZ2pj1bYCU9UpJ4=;
        b=WQ1Wp3gaIyaZQvkjTI0EGTsJKxiIEF5z3wlvkLetokuNQD9NI75yDfzNIAkNZMLupF
         /kSjbCQfqZOkKLMk4cwQw2/NDo+F1eWeBung2JsajDUQh8ZpypzUVi9m2y9ZMIJArpZY
         0W+KQK4SaA88rf0gK8WPQDCTJ7TFVdUTgzzEl9hQ6ONBAbsHQC/ijxmfu0JKdJwYM13P
         7if9aIlgkZApV0wQ8snRb/MgB4dofbZKnTrSsWMxpcXhsnGR3e/ERdri/+s0nORr+B7I
         t7QUYMqGRFMrKhus05UXGjH/ncsOhkuhPuct5fR3CSA/r1Yb5nqn7i6QqEdiArkpfNm6
         Yd1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=A+82jrDdJl7DldYghgqWWw39t+2hiZ2pj1bYCU9UpJ4=;
        b=hI0XeO0U9pgQW+XwJ6iXxZdbijeMXjgMlXJhpUWZ/A2lm3rS9gv5SiwjGp0nkWrlPu
         snuVl2psW7fylsOiqb7+FXqFfZmETZho+v1egtZAbKmCzWatKau1Vjx4MoyP0/6iSGfL
         SUa/eLe+uB8pU4xScv+vijVGig9v1DVlCK9We842ULvt/DiwYGbmZ1elqGk1vDFjkGtT
         SF5LaQRbww34+bzGc/SeiwoP89aPR8cXWa2DrYjkWAgxN3M2KEZgfvJ4OlSjIwrtkyOi
         1kGIBUiOfayIWlf7s/ipKEQ0ZfsciM5DAb0rtFUR+g6gD6GIDpJX5goXAK+OQeckdc4A
         WmXA==
X-Gm-Message-State: AFeK/H2sEh1pQVHYvMUE953ETwbd5vFE/RLL0mOxftDifdQCK3NfZ3JgI5nwVirFFUD6GRXf3IDyfzmh3xn2rSG2
X-Received: by 10.98.137.68 with SMTP id v65mr29039063pfd.125.1491604903221;
 Fri, 07 Apr 2017 15:41:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.163.239 with HTTP; Fri, 7 Apr 2017 15:41:42 -0700 (PDT)
In-Reply-To: <20170407192357.948-4-kewillf@microsoft.com>
References: <20170407192357.948-1-kewillf@microsoft.com> <20170407192357.948-4-kewillf@microsoft.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 7 Apr 2017 15:41:42 -0700
Message-ID: <CAGZ79kYJvLQxTcL2-hLS+MOoWQoshxpeLzNoNXbH6zQqGbbCdw@mail.gmail.com>
Subject: Re: [PATCH 3/3] reset.c: update files when using sparse to avoid data loss.
To:     Kevin Willford <kcwillford@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Kevin Willford <kewillf@microsoft.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 7, 2017 at 12:23 PM, Kevin Willford <kcwillford@gmail.com> wrote:
> When using the sparse checkout feature the git reset command will add
> entries to the index that will have the skip-worktree bit off but will
> leave the working directory empty.  File data is lost because the index
> version of the files has been changed but there is nothing that is in the
> working directory.  This will cause the next status call to show either
> deleted for files modified or deleting or nothing for files added.
> The added files should be shown as untracked and modified files should
> be shown as modified.
>
> To fix this when the reset is running if there is not a file in the
> working directory and if it will be missing with the new index entry
> or was not missing in the previous version, we create the previous index
> version of the file in the working directory so that status will report
> correctly and the files will be availble for the user to deal with.
>
> Signed-off-by: Kevin Willford <kewillf@microsoft.com>
> ---
>  builtin/reset.c                  | 34 +++++++++++++++++++++++
>  t/t7114-reset-sparse-checkout.sh | 58 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 92 insertions(+)
>  create mode 100755 t/t7114-reset-sparse-checkout.sh
>
> diff --git a/builtin/reset.c b/builtin/reset.c
> index 8ab915bfcb..8ba97999f4 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -21,6 +21,7 @@
>  #include "parse-options.h"
>  #include "unpack-trees.h"
>  #include "cache-tree.h"
> +#include "dir.h"
>
>  static const char * const git_reset_usage[] = {
>         N_("git reset [--mixed | --soft | --hard | --merge | --keep] [-q] [<commit>]"),
> @@ -117,12 +118,45 @@ static void update_index_from_diff(struct diff_queue_struct *q,
>                 struct diff_options *opt, void *data)
>  {
>         int i;
> +       int pos;

You could declare this inside the for loop.

>         int intent_to_add = *(int *)data;
>
>         for (i = 0; i < q->nr; i++) {
>                 struct diff_filespec *one = q->queue[i]->one;
> +               struct diff_filespec *two = q->queue[i]->two;
>                 int is_missing = !(one->mode && !is_null_oid(&one->oid));
> +               int was_missing = !two->mode && is_null_oid(&two->oid);
>                 struct cache_entry *ce;
> +               struct cache_entry *ceBefore;
> +               struct checkout state = CHECKOUT_INIT;
> +
> +               /*
> +                * When using the sparse-checkout feature the cache entries that are
> +                * added here will not have the skip-worktree bit set.
> +                * Without this code there is data that is lost because the files that
> +                * would normally be in the working directory are not there and show as
> +                * deleted for the next status or in the case of added files just disappear.
> +                * We need to create the previous version of the files in the working
> +                * directory so that they will have the right content and the next
> +                * status call will show modified or untracked files correctly.
> +                */

This comment also belongs to the commit message IMHO, as
it describes the bug on a high level, and when it is in the code it wastes
screen real estate; commit messages however have low prices for
screen real estate. ;-)

> +               if (core_apply_sparse_checkout && !file_exists(two->path))
> +               {

Coding style: Git prefers { at the end of the line:

  if (..) {
    ..

> +test_expect_success 'reset after deleting file without skip-worktree bit' '
> +       git checkout -f endCommit &&
> +       git clean -xdf &&
> +       echo "/c
> +/m" >.git/info/sparse-checkout &&

huh? Did your mailer wrap lines here or do you intend to have
a LF in the output?

Assuming the latter, I think we prefer cat with here-doc for
multi line content, i.e.

    cat >.git/info/sparse-checkout <<-\EOF
    /c
    /m
    EOF
    test_config ...
    ...


Thanks,
Stefan

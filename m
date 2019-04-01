Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CB0020248
	for <e@80x24.org>; Mon,  1 Apr 2019 10:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfDAKJt (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 06:09:49 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37622 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfDAKJs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 06:09:48 -0400
Received: by mail-io1-f68.google.com with SMTP id x7so7240832ioh.4
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 03:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V11Oyxc/OZ7ivz21AogzSQEUVQ21kt1ALIQZ7+xksXU=;
        b=gozGfvHMo9QR254wFV/Sp2kNoueavDJ4yl1lrEwI3ELk9gAS1OXLZfRZBbIkLOMZkl
         9BVVB8uxvP5mKru7ygrHXTFQWrbtJ5mlOOqmyOdH43K4N7r33BZNM7tTrehuYUWEYlCd
         WIOo2sKpSH+ViES5IFVrO4hA6osUdVA09vO/aUHyuUm0wYIPt8UoYa9Mp9vOVExlbweO
         EULGI8bHraDmrtm+RMnGcUq5Ue4Aw5kaftiJbml+zxRlgrjFF3geIKSVHXhPZqnWk1Ea
         ZnZijZ6Mvpp85+6kH5TQIUEAk/md438TcDrHreGomWrM0HXkUGnm3jQOHQgltlAHCVI2
         Grnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V11Oyxc/OZ7ivz21AogzSQEUVQ21kt1ALIQZ7+xksXU=;
        b=TLH7Nl7FD4XL4E1dDt2qbxAjlcdVHtDGZ8YKzskpp7ZeXiMJ4B886pGiiAoy5+1q9k
         57tV4vJCixLzNiIwZYi6/96AdLh3s0AwiOrgsTnX3UFYQjWYau/A155XgtCg7/k1+kP+
         sHcR9eBs3TQpId8q8tMspqvfxpc96l0SGn/i0eds0sTV/MOqppqSTKSCzHXuQ7rI8FhI
         PSuKHHlV5ELGZwq6Kxk0GXXzlq5YJJNfYSyiA+vOdG5lKEyFNziKc1g8mSV3Q0M9ME1x
         blO0IrV2o90hOxf/DrNyfTchrY6v/wToLC4mKERcMZN8K94txxVnAx2RAdHFPSiIhxxr
         ws7g==
X-Gm-Message-State: APjAAAVbECQXbnYh6U5bmN1RrigG3B+5LvDZPdueN9SKmk6C7WeVbHiT
        Rp54yeejaFyggD5u9tow4qPjXEH/qMBwfnt7FE0=
X-Google-Smtp-Source: APXvYqxffFrEGZtnUBdzfSmCnAjfe1igA63dA4yCnBPCjYlqPEypy1kAZpJu+6QLCV5OlJct7pwpVAMYEPAyca/dBV0=
X-Received: by 2002:a6b:3709:: with SMTP id e9mr17129253ioa.282.1554113387705;
 Mon, 01 Apr 2019 03:09:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190329163009.493-1-phillip.wood123@gmail.com> <20190329163009.493-2-phillip.wood123@gmail.com>
In-Reply-To: <20190329163009.493-2-phillip.wood123@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 1 Apr 2019 17:09:21 +0700
Message-ID: <CACsJy8D3tH0K8wNLighuNtjUtv3K3TGNMGgx3T5j5sCxok8hbQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] commit/reset: try to clean up sequencer state
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 29, 2019 at 11:32 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> When cherry-picking or reverting a sequence of commits and if the final
> pick/revert has conflicts and the user uses `git commit` to commit the
> conflict resolution and does not run `git cherry-pick --continue` then
> the sequencer state is left behind. This can cause problems later. In my
> case I cherry-picked a sequence of commits the last one of which I
> committed with `git commit` after resolving some conflicts, then a while
> later, on a different branch I aborted a revert which rewound my HEAD to
> the end of the cherry-pick sequence on the previous branch. Avoid this
> potential problem by removing the sequencer state if we're committing or
> resetting the final pick in a sequence.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  branch.c                        |  7 +++++--
>  builtin/commit.c                |  7 +++++--
>  sequencer.c                     | 23 +++++++++++++++++++++++
>  sequencer.h                     |  1 +
>  t/t3507-cherry-pick-conflict.sh | 19 +++++++++++++++++++
>  5 files changed, 53 insertions(+), 4 deletions(-)
>
> diff --git a/branch.c b/branch.c
> index 28b81a7e02..9ed60081c1 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -5,6 +5,7 @@
>  #include "refs.h"
>  #include "refspec.h"
>  #include "remote.h"
> +#include "sequencer.h"
>  #include "commit.h"
>  #include "worktree.h"
>
> @@ -339,8 +340,10 @@ void create_branch(struct repository *r,
>
>  void remove_branch_state(struct repository *r)

This function is also called in git-am, git-rebase and git-checkout.
While the first two should not be affected, git-checkout can be
executed while we're in the middle of a cherry-pick or revert. I guess
that's ok because git-checkout is basically the same as git-reset in
this case?

>  {
> -       unlink(git_path_cherry_pick_head(r));
> -       unlink(git_path_revert_head(r));
> +       if (!unlink(git_path_cherry_pick_head(r)))
> +               sequencer_post_commit_cleanup();
> +       if (!unlink(git_path_revert_head(r)))
> +               sequencer_post_commit_cleanup();
>         unlink(git_path_merge_head(r));
>         unlink(git_path_merge_rr(r));
>         unlink(git_path_merge_msg(r));
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 2986553d5f..422b7d62a5 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1657,8 +1657,10 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>                 die("%s", err.buf);
>         }
>
> -       unlink(git_path_cherry_pick_head(the_repository));
> -       unlink(git_path_revert_head(the_repository));
> +       if (!unlink(git_path_cherry_pick_head(the_repository)))
> +               sequencer_post_commit_cleanup();
> +       if (!unlink(git_path_revert_head(the_repository)))
> +               sequencer_post_commit_cleanup();
>         unlink(git_path_merge_head(the_repository));
>         unlink(git_path_merge_msg(the_repository));
>         unlink(git_path_merge_mode(the_repository));
> @@ -1678,6 +1680,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>         if (amend && !no_post_rewrite) {
>                 commit_post_rewrite(the_repository, current_head, &oid);
>         }
> +
>         if (!quiet) {
>                 unsigned int flags = 0;
>
> diff --git a/sequencer.c b/sequencer.c
> index 0db410d590..028699209f 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2220,6 +2220,29 @@ static ssize_t strbuf_read_file_or_whine(struct strbuf *sb, const char *path)
>         return len;
>  }
>
> +void sequencer_post_commit_cleanup(void)
> +{
> +       struct replay_opts opts = REPLAY_OPTS_INIT;
> +       struct strbuf buf = STRBUF_INIT;
> +       const char *eol;
> +       const char *todo_path = git_path_todo_file();
> +
> +       if (strbuf_read_file(&buf, todo_path, 0) < 0) {
> +               if (errno == ENOENT) {
> +                       return;
> +               } else {
> +                       error_errno("unable to open '%s'", todo_path);

_() the string to make it translatable.

> +                       return;
> +               }
> +       }
> +       /* If there is only one line then we are done */
> +       eol = strchr(buf.buf, '\n');
> +       if (!eol || !eol[1])
> +               sequencer_remove_state(&opts);

Should we say something to let the user know cherry-pick/revert is
finished? (unless --quiet is specified)

> +
> +       strbuf_release(&buf);
> +}
> +
>  static int read_populate_todo(struct repository *r,
>                               struct todo_list *todo_list,
>                               struct replay_opts *opts)
-- 
Duy

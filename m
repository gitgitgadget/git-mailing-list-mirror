Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51968C433EF
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 23:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbiGAXTO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 19:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiGAXTN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 19:19:13 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019713F316
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 16:19:11 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id g26so6538372ejb.5
        for <git@vger.kernel.org>; Fri, 01 Jul 2022 16:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kM/QUWSF98hrNqxptYn9LXixOw/uycKw9/W7Z6IgJdM=;
        b=UPX9C4/+K0iOjHTMzIxoLwLEUMbsXhx9869QGLtfCCfC1LjJrvwMXYLup/mWjWU4ZX
         rJdpo69fBstgUl4Oe3lJYAb+emiu3eudZYivErr5c8PDmOKTqtihH6iYv0+u4emnnmQr
         KVS3B0PRXVas7h4GzXuL5y7+pCvHiNpKD9WrNUgnNbSmsS3WZnlVY3rfUY/XVe2qgQgN
         3wYx2S4o8VgM+atxqy/haT+bLY78eujwEQ3Q19rQRGCmVGqaOhDYuxzM6gXkzQVlVf1H
         E0JhQgWxPZl3xSQytcFN20my+8dBRxwZJAeVRp3Ouv2eO12u7CZQ+EEdla3SuBnaOSce
         o1Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kM/QUWSF98hrNqxptYn9LXixOw/uycKw9/W7Z6IgJdM=;
        b=I5l0+AIFQWHK/bVjvF05jfwN0W7Z86Q1KpCLR11ppqnClyTimfXuyNvbC8Y9U68q70
         FjLk5DO2clpZ8xrxa9muxN2/fvX227SGNX864FyPUWUJj0K+iPJQgIFIxgtxAGaQcu9y
         39ou5nuxQ1T/WSK5fPz1+IJxnZgB2E9LkMlj0VZRky2FVavIqwK81zmpBdlOZ1jWzaGj
         HsZuZpSTxrIGi4mkhfm6EvSDdoaA+mPFRkSZoQFUAp/SJSr/WYsOc0ga3X8JVUeN2jF8
         g2cdTmZwgQkAjL26y+xeSURg1+Q8UkNsiJ54okwQ1CKzDkW6fGroM1yZNIM/HiJa29Y8
         i+Qw==
X-Gm-Message-State: AJIora+encpMOylFielp/4GFMrEEvbxEVhwIHBu7hevaYryxbIUAxBeF
        g2G+zxhbUkvIL8b+SFZaZ1uxPFJWrN8hvASk3EY=
X-Google-Smtp-Source: AGRyM1u3v01SZL6mJqMztcifGa4Q+XYbw93m4n7L3/FSk0tahK1Rkn+dBCW7XVWOILu+Sk3yohD8PugCvdm1jy5KgEc=
X-Received: by 2002:a17:906:e98:b0:726:29c5:620a with SMTP id
 p24-20020a1709060e9800b0072629c5620amr16955928ejf.192.1656717550474; Fri, 01
 Jul 2022 16:19:10 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1247.v2.git.1654634569.gitgitgadget@gmail.com>
 <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com> <72e0481b643e98c5670eee0bf5c199c4fb693b16.1656422759.git.gitgitgadget@gmail.com>
In-Reply-To: <72e0481b643e98c5670eee0bf5c199c4fb693b16.1656422759.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 1 Jul 2022 16:18:59 -0700
Message-ID: <CABPp-BG++8LAwyH6P-QDj5Lu6-cevOBOjpdY7QsSdwiT0w9URA@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] rebase: update refs from 'update-ref' commands
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 28, 2022 at 6:26 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <derrickstolee@github.com>
>
> The previous change introduced the 'git rebase --update-refs' option
> which added 'update-ref <ref>' commands to the todo list of an
> interactive rebase.
>
> Teach Git to record the HEAD position when reaching these 'update-ref'
> commands. The ref/OID pair is stored in the
> $GIT_DIR/rebase-merge/update-refs file. A previous change parsed this
> file to avoid having other processes updating the refs in that file
> while the rebase is in progress.
>
> Not only do we update the file when the sequencer reaches these
> 'update-ref' commands, we then update the refs themselves at the end of
> the rebase sequence. If the rebase is aborted before this final step,
> then the refs are not updated.

Why update with each update-ref command?  Couldn't the values be
stored in memory and only written when we hit a conflict?

> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  sequencer.c                   | 114 +++++++++++++++++++++++++++++++++-
>  t/t3404-rebase-interactive.sh |  23 +++++++
>  2 files changed, 136 insertions(+), 1 deletion(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index 915d87a0336..4fd1c0b5bce 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -36,6 +36,7 @@
>  #include "rebase-interactive.h"
>  #include "reset.h"
>  #include "branch.h"
> +#include "log-tree.h"
>
>  #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
>
> @@ -148,6 +149,14 @@ static GIT_PATH_FUNC(rebase_path_squash_onto, "rebase-merge/squash-onto")
>   */
>  static GIT_PATH_FUNC(rebase_path_refs_to_delete, "rebase-merge/refs-to-delete")
>
> +/*
> + * The update-refs file stores a list of refs that will be updated at the end
> + * of the rebase sequence. The 'update-ref <ref>' commands in the todo file
> + * update the OIDs for the refs in this file, but the refs are not updated
> + * until the end of the rebase sequence.
> + */
> +static GIT_PATH_FUNC(rebase_path_update_refs, "rebase-merge/update-refs")
> +
>  /*
>   * The following files are written by git-rebase just after parsing the
>   * command-line.
> @@ -4058,11 +4067,110 @@ leave_merge:
>         return ret;
>  }
>
> -static int do_update_ref(struct repository *r, const char *ref_name)
> +static int write_update_refs_state(struct string_list *refs_to_oids)
> +{
> +       int result = 0;
> +       FILE *fp = NULL;
> +       struct string_list_item *item;
> +       char *path = xstrdup(rebase_path_update_refs());
> +
> +       if (safe_create_leading_directories(path)) {
> +               result = error(_("unable to create leading directories of %s"),
> +                              path);
> +               goto cleanup;
> +       }
> +
> +       fp = fopen(path, "w");
> +       if (!fp) {
> +               result = error_errno(_("could not open '%s' for writing"), path);
> +               goto cleanup;
> +       }
> +
> +       for_each_string_list_item(item, refs_to_oids)
> +               fprintf(fp, "%s\n%s\n", item->string, oid_to_hex(item->util));

Here you are storing the ref and the new oid to move it to.  Any
reason you don't store the previous oid for the branch?  In
particular, if someone hits a conflict, needs to resolve, and comes
back some time much later and these intermediate branches have since
moved on, should we actually update those branches?  (And, if we do,
should we at least give a warning?)

> +cleanup:
> +       if (fp)
> +               fclose(fp);
> +       return result;
> +}
> +
> +static int do_update_ref(struct repository *r, const char *refname)
>  {
> +       struct string_list_item *item;
> +       struct string_list list = STRING_LIST_INIT_DUP;
> +       int found = 0;
> +
> +       sequencer_get_update_refs_state(r->gitdir, &list);
> +
> +       for_each_string_list_item(item, &list) {
> +               if (!strcmp(item->string, refname)) {
> +                       struct object_id oid;
> +                       free(item->util);
> +                       found = 1;
> +
> +                       if (!read_ref("HEAD", &oid)) {
> +                               item->util = oiddup(&oid);
> +                               break;
> +                       }
> +               }
> +       }
> +
> +       if (!found) {
> +               struct object_id oid;
> +               item = string_list_append(&list, refname);
> +
> +               if (!read_ref("HEAD", &oid))
> +                       item->util = oiddup(&oid);
> +               else
> +                       item->util = oiddup(the_hash_algo->null_oid);

Seems a little unfortunate to not use a cached value from the latest
commit we picked (and wrote to HEAD) and instead need to re-read HEAD.
But, I guess sequencer is written to round-trip through files, so
maybe optimizing this here doesn't make sense given all the other
places in sequencer where we do lots of file reading and writing.

> +       }
> +
> +       write_update_refs_state(&list);
> +       string_list_clear(&list, 1);
>         return 0;
>  }
>
> +static int do_update_refs(struct repository *r)
> +{
> +       int res = 0;
> +       struct string_list_item *item;
> +       struct string_list refs_to_oids = STRING_LIST_INIT_DUP;
> +       struct ref_store *refs = get_main_ref_store(r);
> +
> +       sequencer_get_update_refs_state(r->gitdir, &refs_to_oids);
> +
> +       for_each_string_list_item(item, &refs_to_oids) {
> +               struct object_id *oid_to = item->util;
> +               struct object_id oid_from;
> +
> +               if (oideq(oid_to, the_hash_algo->null_oid)) {
> +                       /*
> +                        * Ref was not updated. User may have deleted the
> +                        * 'update-ref' step.
> +                        */
> +                       continue;
> +               }
> +
> +               if (read_ref(item->string, &oid_from)) {
> +                       /*
> +                        * The ref does not exist. The user probably
> +                        * inserted a new 'update-ref' step with a new
> +                        * branch name.
> +                        */
> +                       oidcpy(&oid_from, the_hash_algo->null_oid);
> +               }
> +
> +               res |= refs_update_ref(refs, "rewritten during rebase",
> +                               item->string,
> +                               oid_to, &oid_from,
> +                               0, UPDATE_REFS_MSG_ON_ERR);
> +       }
> +
> +       string_list_clear(&refs_to_oids, 1);
> +       return res;
> +}
> +
>  static int is_final_fixup(struct todo_list *todo_list)
>  {
>         int i = todo_list->current;
> @@ -4580,6 +4688,8 @@ cleanup_head_ref:
>                 strbuf_release(&head_ref);
>         }
>
> +       do_update_refs(r);
> +
>         /*
>          * Sequence of picks finished successfully; cleanup by
>          * removing the .git/sequencer directory
> @@ -5709,6 +5819,8 @@ static int todo_list_add_update_ref_commands(struct todo_list *todo_list)
>                 }
>         }
>
> +       write_update_refs_state(&ctx.refs_to_oids);
> +
>         string_list_clear(&ctx.refs_to_oids, 1);
>         free(todo_list->items);
>         todo_list->items = ctx.items;
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 3cd20733bc8..63a69bc073e 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1813,6 +1813,29 @@ test_expect_success '--update-refs adds commands with --rebase-merges' '
>         )
>  '
>
> +compare_two_refs () {
> +       git rev-parse $1 >expect &&
> +       git rev-parse $2 >actual &&
> +       test_cmp expect actual
> +}
> +
> +test_expect_success '--update-refs updates refs correctly' '
> +       git checkout -B update-refs no-conflict-branch &&
> +       git branch -f base HEAD~4 &&
> +       git branch -f first HEAD~3 &&
> +       git branch -f second HEAD~3 &&
> +       git branch -f third HEAD~1 &&
> +       test_commit extra2 fileX &&
> +       git commit --amend --fixup=L &&
> +
> +       git rebase -i --autosquash --update-refs primary &&
> +
> +       compare_two_refs HEAD~3 refs/heads/first &&
> +       compare_two_refs HEAD~3 refs/heads/second &&
> +       compare_two_refs HEAD~1 refs/heads/third &&
> +       compare_two_refs HEAD refs/heads/no-conflict-branch
> +'
> +
>  # This must be the last test in this file
>  test_expect_success '$EDITOR and friends are unchanged' '
>         test_editor_unchanged
> --
> gitgitgadget
>

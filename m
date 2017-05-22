Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E34A21FF30
	for <e@80x24.org>; Mon, 22 May 2017 05:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751484AbdEVF7g (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 01:59:36 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:38726 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751212AbdEVF7f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 01:59:35 -0400
Received: by mail-it0-f42.google.com with SMTP id r63so17338708itc.1
        for <git@vger.kernel.org>; Sun, 21 May 2017 22:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xnF5dVH4L/m57ch4yEv+3gKniiCLbczYq8FAROt5aJc=;
        b=DRQGK1mZVTsilR8wlWisFbCqxxWm/0acjYRODDyiSNYl8YcP1j7P51QEm2JBtQodYT
         Vt+dO521EzWlVMpxQLVJu2TIqNwm3Mx6hDDclSt6OYDbfbUpoMKR+nZsfCTV+qH5rg58
         6jhhYsZClUfL5yE5XO+mzMNuw43CNCldYBZmhQTOKM/ctzE+UQAB95u514CSHKfqt8bk
         0CzV022ZEkJQbMNQgSgsfoYljHr1lVNnZbYlGe1efGhljNkcALu41KsQUilwQYYdO7T2
         2CvaEDDEg9bGpJUQcBxFOHTP0RsKy4JIpaYXQEVr2+LJVAZcSGg5iMbdLkWV3y3eTGNB
         i2zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xnF5dVH4L/m57ch4yEv+3gKniiCLbczYq8FAROt5aJc=;
        b=T46anF+TfuRymgD0wjtsb37AsC/foX/3W6qLsQ5tGxs7C+SHesNV1IYBtgSkEhYmiN
         PWPiNa0dgPmChtGR5RrYl73rW71hoMmOcXhaSQCW/IPu3CCCtEUkfg2deDqOdwXZYj56
         LFOhUHhYE56YYPLLba31JC+kaZVl8pW3LPE0XM/lVt2JyDvVA31I2YDXsbnqOzZfKweE
         FtTGEAsQUYkNHfKdqWjPNzSOffyb1UxEdQpUUNHDnF1SwWav/lzRJv4c8KSEO3UeWRQ3
         SecHIQJ0lxIa6/gFs3OskDDThBHSsWTq+/BRGFbmnOLsVR+l0pm4+jxnO64/heudVfRj
         eq3A==
X-Gm-Message-State: AODbwcDGA5iB1j1YbdQdux/eE1R7j1gp8M0DOqqiMWE0r8srtjNFPoRR
        NTchdRxKR8wE9h9dpsWzMKRcQ7Zf0JlY
X-Received: by 10.36.254.68 with SMTP id w65mr21663345ith.51.1495432773908;
 Sun, 21 May 2017 22:59:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.150.90 with HTTP; Sun, 21 May 2017 22:58:53 -0700 (PDT)
In-Reply-To: <xmqqtw4do5tf.fsf@gitster.mtv.corp.google.com>
References: <20170518082154.28643-1-sxlijin@gmail.com> <20170516073423.25762-1-sxlijin@gmail.com>
 <20170518082154.28643-7-sxlijin@gmail.com> <xmqqtw4do5tf.fsf@gitster.mtv.corp.google.com>
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Mon, 22 May 2017 01:58:53 -0400
Message-ID: <CAJZjrdX9BnuxY3tmpswG+yEdDm1+AR8rc5wKGZyVCMp-jP218A@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] clean: teach clean -d to skip dirs containing
 ignored files
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 22, 2017 at 12:48 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Samuel Lijin <sxlijin@gmail.com> writes:
>
>> +     for (j = i = 0; i < dir.nr;) {
>> +             for (;
>> +                  j < dir.ignored_nr &&
>> +                    0 <= cmp_dir_entry(&dir.entries[i], &dir.ignored[j]);
>> +                  j++);
>> +
>> +             if ((j < dir.ignored_nr) &&
>> +                             check_dir_entry_contains(dir.entries[i], dir.ignored[j])) {
>> +                     /* skip any dir.entries which contains a dir.ignored */
>> +                     free(dir.entries[i]);
>> +                     dir.entries[i++] = NULL;
>> +             } else {
>> +                     /* prune the contents of a dir.entries which will be removed */
>> +                     struct dir_entry *ent = dir.entries[i++];
>> +                     for (;
>> +                          i < dir.nr &&
>> +                            check_dir_entry_contains(ent, dir.entries[i]);
>> +                          i++) {
>> +                             free(dir.entries[i]);
>> +                             dir.entries[i] = NULL;
>> +                     }
>> +             }
>> +     }
>
> The second loop in the else clause is a bit tricky, and the comment
> "which will be removed" is not all that helpful to explain why the
> loop is there.
>
> But I think the code is correct.  Here is how I understood it.
>
>     While looking at dir.entries[i], the code noticed that nothing
>     in that directory is ignored.  But entries in dir.entries[] that
>     come later may be contained in dir.entries[i] and we just want
>     to show the top-level untracked one (e.g. "a/" and "a/b/" were
>     in entries[], there is nothing in "a/", so naturally there is
>     nothing in "a/b/", but we do not want to bother showing
>     both---showing "a/" alone saying "the entire a/ is untracked" is
>     what we want).

Yep, that's the gist of it.

More specifically: the contents of untracked dirs have to be picked up
so that clean -d can distinguish between purely untracked dirs and
untracked dirs which also contain ignored files. In the case of a
purely untracked dir, clean -d can remove the dir itself, and should
just skip over all the dir's contents; in the case of a mixed
untracked dir, clean -d should not remove the dir itself, just the
untracked contents.

> We may want to have a test to ensure "a/b/" is indeed omitted in
> such a situation from the output, though.

Is there a reason to ensure specifically a/b/ is tested, or are the
current tests, which do cover the a/b (i.e. where a/b is a file, not
where a/b/ is a dir) case, insufficient for some reason?

> By the way, instead of putting NULL, it may be easier to follow if
> you used two pointers, src and dst, into dir.entries[], just like
> you did in your latest version of [PATCH 4/6].  That way, you do not
> have to change anything in the later loop that walks over elements
> in the dir.entries[] array.  It would also help the logic easier to
> follow if the above loop were its own helper function.

Agreed on the helper function. On the src-dst thing: I considered it,
but I figured another O(n) set of array moves was unnecessary. I guess
this is one of those cases where premature optimization doesn't make
sense?

> Putting them all together, here is what I came up with that can be
> squashed into your patch.  I am undecided myself if this is easier
> to follow than your version, but it seems to pass your test ;-)
>
> Thanks.
>
>  builtin/clean.c | 70 ++++++++++++++++++++++++++++++++++-----------------------
>  1 file changed, 42 insertions(+), 28 deletions(-)
>
> diff --git a/builtin/clean.c b/builtin/clean.c
> index dd3308a447..c8712e7ac8 100644
> --- a/builtin/clean.c
> +++ b/builtin/clean.c
> @@ -851,9 +851,49 @@ static void interactive_main_loop(void)
>         }
>  }
>
> +static void simplify_untracked(struct dir_struct *dir)
> +{
> +       int src, dst, ign;
> +
> +       for (src = dst = ign = 0; src < dir->nr; src++) {
> +               /*
> +                * Skip entries in ignored[] that cannot be inside
> +                * entries[src]
> +                */
> +               while (ign < dir->ignored_nr &&
> +                      0 <= cmp_dir_entry(&dir->entries[src], &dir->ignored[ign]))
> +                       ign++;
> +
> +               if (dir->ignored_nr <= ign ||
> +                   !check_dir_entry_contains(dir->entries[src], dir->ignored[ign])) {
> +                       /*
> +                        * entries[src] does not contain an ignored
> +                        * path -- we need to keep it.  But we do not
> +                        * want to show entries[] that are contained
> +                        * in entries[src].
> +                        */
> +                       struct dir_entry *ent = dir->entries[src++];
> +                       dir->entries[dst++] = ent;
> +                       while (src < dir->nr &&
> +                              check_dir_entry_contains(ent, dir->entries[src])) {
> +                               free(dir->entries[src++]);
> +                       }
> +                       /* compensate for the outer loop's loop control */
> +                       src--;
> +               } else {
> +                       /*
> +                        * entries[src] contains an ignored path --
> +                        * drop it.
> +                        */
> +                       free(dir->entries[src]);
> +               }
> +       }
> +       dir->nr = dst;
> +}
> +
>  int cmd_clean(int argc, const char **argv, const char *prefix)
>  {
> -       int i, j, res;
> +       int i, res;
>         int dry_run = 0, remove_directories = 0, quiet = 0, ignored = 0;
>         int ignored_only = 0, config_set = 0, errors = 0, gone = 1;
>         int rm_flags = REMOVE_DIR_KEEP_NESTED_GIT;
> @@ -928,30 +968,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
>                        prefix, argv);
>
>         fill_directory(&dir, &pathspec);
> -
> -       for (j = i = 0; i < dir.nr;) {
> -               for (;
> -                    j < dir.ignored_nr &&
> -                      0 <= cmp_dir_entry(&dir.entries[i], &dir.ignored[j]);
> -                    j++);
> -
> -               if ((j < dir.ignored_nr) &&
> -                               check_dir_entry_contains(dir.entries[i], dir.ignored[j])) {
> -                       /* skip any dir.entries which contains a dir.ignored */
> -                       free(dir.entries[i]);
> -                       dir.entries[i++] = NULL;
> -               } else {
> -                       /* prune the contents of a dir.entries which will be removed */
> -                       struct dir_entry *ent = dir.entries[i++];
> -                       for (;
> -                            i < dir.nr &&
> -                              check_dir_entry_contains(ent, dir.entries[i]);
> -                            i++) {
> -                               free(dir.entries[i]);
> -                               dir.entries[i] = NULL;
> -                       }
> -               }
> -       }
> +       simplify_untracked(&dir);
>
>         for (i = 0; i < dir.nr; i++) {
>                 struct dir_entry *ent = dir.entries[i];
> @@ -959,9 +976,6 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
>                 struct stat st;
>                 const char *rel;
>
> -               if (!ent)
> -                       continue;
> -
>                 if (!cache_name_is_other(ent->name, ent->len))
>                         continue;
>

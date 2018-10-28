Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71EDF1F453
	for <e@80x24.org>; Sun, 28 Oct 2018 21:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbeJ2Gm2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 02:42:28 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45849 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbeJ2Gm2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 02:42:28 -0400
Received: by mail-qk1-f195.google.com with SMTP id d135so2754653qkc.12
        for <git@vger.kernel.org>; Sun, 28 Oct 2018 14:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1RLcIhkMUtwp+6b1Bq1xOeTy9dSZUNqmZR6up6wdRCc=;
        b=rK3JgNOUGMfIa41uQWRSDuRrvVQoPsohppFBzWleSprBu+9nWOz5ZHspPvJIlem1RZ
         5R24a0XjN+i+nIgPFi4+c1ijpGnkHu1DTtmGWFTPzQoPLp+hee0GPeLvMTEYygK1hBtu
         46n5pgwQT3Cv3mnp1939Vb39TuA5Hweya8yw2nLEmuftElOTLSTTRbcQBRrLjKOHDdde
         4gzWxV2gAsh/un3xFPnhFKb7oq04VjuHTcNJxiqpZyNuXnFn5Vxw3XyLvdsNkOzc6JIL
         qOAS9AVIqifrJO3pty2K5s1t3ANyfqbhe43PtAiyV3cXTX0wwJXrR+m206nnwmPRcQuJ
         a4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1RLcIhkMUtwp+6b1Bq1xOeTy9dSZUNqmZR6up6wdRCc=;
        b=oMc2breB7fuasgtmjni/1JoiRcBddcOzJEe2e7j1fFvEHr4kL2+VJEd5ub3w2W0OIA
         snwYvyMQ5hgSEEnDsYocnSGx5woI2xJHsOcXGDzDXmpjQ89pGQ3oglyuhhpvftNXKVFm
         eZXuw8U1BuIQXgBirdCk9MUqBeg+GxlLKMZRFh5Yw0LcVBkQGf9in6gG8XpjrCaOD87N
         LhPfOtcnApeEGV9XeKACUFiSYOCWeh+C499zTbmzkpmbaxBaNUymMUfrvu1IPCPsa30e
         Td2K3vLmYjx3dXOwoZkyWvv30zP7rZP2HZTtZ1oCndgTrCcAZ9AoX3PTWP0f0Ubzce6+
         4VkQ==
X-Gm-Message-State: AGRZ1gLcEo7XAUkqkPlhwrZA14XnjdrnLlHvcN3QJi9QsK9zh/N50tEH
        mNnrNzXa0rKj3kB0YOQ7lSobtvZb8QcDOjIXZb0=
X-Google-Smtp-Source: AJdET5fZgehVvRCW+saqMSci6iPJiJ11earLJ5g0XZhx40YhGb7Mfq0FZ6to6que/+TmKIPLW2RpHfkxRzoTlRcv51I=
X-Received: by 2002:a37:5803:: with SMTP id m3-v6mr10550550qkb.81.1540763791609;
 Sun, 28 Oct 2018 14:56:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAC05386F1X7TsPr6kgkuLWEwsmdiQ4VKTF5RxaHvzpkwbmXPBw@mail.gmail.com>
 <20181025055142.38077-1-nbelakovski@gmail.com> <xmqq4ldajz05.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq4ldajz05.fsf@gitster-ct.c.googlers.com>
From:   Nickolai Belakovski <nbelakovski@gmail.com>
Date:   Sun, 28 Oct 2018 14:56:05 -0700
Message-ID: <CAC05385y3fCdG4fd2ADahoE0iT+a5KvEr846UCUCQZMOtzzYGg@mail.gmail.com>
Subject: Re: [PATCH] worktree: refactor lock_reason_valid and lock_reason to
 be more sensible
To:     Junio C Hamano <gitster@pobox.com>, sunshine@sunshineco.com
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This was meant to be a reply to
https://public-inbox.org/git/CAC05386F1X7TsPr6kgkuLWEwsmdiQ4VKTF5RxaHvzpkwbmXPBw@mail.gmail.com/T/#m8898c8f7c68e1ea234aca21cb2d7776b375c6f51,
please look there for some more context. I think it both did and
didn't get listed as a reply? In my mailbox I see two separate threads
but in public-inbox.org/git it looks like it correctly got labelled as
1 thread. This whole mailing list thing is new to me, thanks for
bearing with me as I figure it out :). Next time I'll make sure to
change the subject line on updated patches as PATCH v2 (that's the
convention, right?).

This is an improvement because it fixes an issue in which the fields
lock_reason and lock_reason_valid of the worktree struct were not
being populated. This is related to work I'm doing to add a worktree
atom to ref-filter.c.

I see your concerns about extra hits to the filesystem when calling
get_worktrees and about users interested in lock_reason having to make
extra calls. As regards hits to the filesystem, I could remove
is_locked from the worktree struct entirely. To address the second
concern, I could refactor worktree_locked_reason to return null if the
wt is not locked. I would still want to keep is_worktree_locked around
to provide a facility to check whether or not the worktree is locked
without having to go get the reason.

There's also been some concerns raised about caching. As I pointed out
in the other thread, the current use cases for this information die
upon accessing it, so caching is a moot point. For the use case of a
worktree atom, caching would be relevant, but it could be done within
ref-filter.c. Another option is to add the lock_reason back to the
worktree struct and have two functions for populating it:
get_worktrees_wo_lock_reason and get_worktrees_with_lock_reason. A bit
more verbose, but it makes it clear to the caller what they're getting
and what they're not getting. I might suggest starting with doing the
caching within ref-filter.c first, and if more use cases appear for
caching lock_reason we can consider the second option. It could also
be get_worktrees and get_worktrees_wo_lock_reason, though I think most
callers would be calling the latter name.

So, my proposal for driving this patch to completion would be to:
-remove is_locked from the worktree struct
-refactor worktree_locked_reason to return null if the wt is not locked
-refactor calls to is_locked within builtin/worktree.c to call either
the refactored worktree_locked_reason or is_worktree_locked

In addition to making the worktree code clearer, this patch fixes a
bug in which the current is_worktree_locked over-eagerly sets
lock_reason_valid. There are currently no consumers of
lock_reason_valid within master, but obviously we should fix this
before they appear :)

Thoughts?

On Wed, Oct 24, 2018 at 11:56 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> nbelakovski@gmail.com writes:
>
> > From: Nickolai Belakovski <nbelakovski@gmail.com>
> >
> > lock_reason_valid is renamed to is_locked and lock_reason is removed as
> > a field of the worktree struct. Lock reason can be obtained instead by a
> > standalone function.
> >
> > This is done in order to make the worktree struct more intuitive when it
> > is used elsewhere in the codebase.
>
> So a mere action of getting an in-core worktree instance now has to
> make an extra call to file_exists(), and in addition, the callers
> who want to learn why the worktree is locked, they need to open and
> read the contents of the file in addition?
>
> Why is that an improvement?
>
>
> >
> > Some unused variables are cleaned up as well.
> >
> > Signed-off-by: Nickolai Belakovski <nbelakovski@gmail.com>
> > ---
> >  builtin/worktree.c | 16 ++++++++--------
> >  worktree.c         | 55 ++++++++++++++++++++++++++++--------------------------
> >  worktree.h         |  8 +++-----
> >  3 files changed, 40 insertions(+), 39 deletions(-)
> >
> > diff --git a/builtin/worktree.c b/builtin/worktree.c
> > index 41e771439..844789a21 100644
> > --- a/builtin/worktree.c
> > +++ b/builtin/worktree.c
> > @@ -634,8 +634,8 @@ static int lock_worktree(int ac, const char **av, const char *prefix)
> >       if (is_main_worktree(wt))
> >               die(_("The main working tree cannot be locked or unlocked"));
> >
> > -     old_reason = is_worktree_locked(wt);
> > -     if (old_reason) {
> > +     if (wt->is_locked) {
> > +             old_reason = worktree_locked_reason(wt);
> >               if (*old_reason)
> >                       die(_("'%s' is already locked, reason: %s"),
> >                           av[0], old_reason);
> > @@ -666,7 +666,7 @@ static int unlock_worktree(int ac, const char **av, const char *prefix)
> >               die(_("'%s' is not a working tree"), av[0]);
> >       if (is_main_worktree(wt))
> >               die(_("The main working tree cannot be locked or unlocked"));
> > -     if (!is_worktree_locked(wt))
> > +     if (!wt->is_locked)
> >               die(_("'%s' is not locked"), av[0]);
> >       ret = unlink_or_warn(git_common_path("worktrees/%s/locked", wt->id));
> >       free_worktrees(worktrees);
> > @@ -734,8 +734,8 @@ static int move_worktree(int ac, const char **av, const char *prefix)
> >
> >       validate_no_submodules(wt);
> >
> > -     reason = is_worktree_locked(wt);
> > -     if (reason) {
> > +     if (wt->is_locked) {
> > +             reason = worktree_locked_reason(wt);
> >               if (*reason)
> >                       die(_("cannot move a locked working tree, lock reason: %s"),
> >                           reason);
> > @@ -860,11 +860,11 @@ static int remove_worktree(int ac, const char **av, const char *prefix)
> >               die(_("'%s' is not a working tree"), av[0]);
> >       if (is_main_worktree(wt))
> >               die(_("'%s' is a main working tree"), av[0]);
> > -     reason = is_worktree_locked(wt);
> > -     if (reason) {
> > +     if (wt->is_locked) {
> > +             reason = worktree_locked_reason(wt);
> >               if (*reason)
> >                       die(_("cannot remove a locked working tree, lock reason: %s"),
> > -                         reason);
> > +                             reason);
> >               die(_("cannot remove a locked working tree"));
> >       }
> >       if (validate_worktree(wt, &errmsg, WT_VALIDATE_WORKTREE_MISSING_OK))
> > diff --git a/worktree.c b/worktree.c
> > index 97cda5f97..a3082d19d 100644
> > --- a/worktree.c
> > +++ b/worktree.c
> > @@ -14,7 +14,6 @@ void free_worktrees(struct worktree **worktrees)
> >               free(worktrees[i]->path);
> >               free(worktrees[i]->id);
> >               free(worktrees[i]->head_ref);
> > -             free(worktrees[i]->lock_reason);
> >               free(worktrees[i]);
> >       }
> >       free (worktrees);
> > @@ -41,13 +40,29 @@ static void add_head_info(struct worktree *wt)
> >               wt->is_detached = 1;
> >  }
> >
> > +
> > +/**
> > + * Return 1 if the worktree is locked, 0 otherwise
> > + */
> > +static int is_worktree_locked(const struct worktree *wt)
> > +{
> > +     struct strbuf path = STRBUF_INIT;
> > +     int locked_file_exists;
> > +
> > +     assert(!is_main_worktree(wt));
> > +
> > +     strbuf_addstr(&path, worktree_git_path(wt, "locked"));
> > +     locked_file_exists = file_exists(path.buf);
> > +     strbuf_release(&path);
> > +     return locked_file_exists;
> > +}
> > +
> >  /**
> >   * get the main worktree
> >   */
> >  static struct worktree *get_main_worktree(void)
> >  {
> >       struct worktree *worktree = NULL;
> > -     struct strbuf path = STRBUF_INIT;
> >       struct strbuf worktree_path = STRBUF_INIT;
> >       int is_bare = 0;
> >
> > @@ -56,14 +71,11 @@ static struct worktree *get_main_worktree(void)
> >       if (is_bare)
> >               strbuf_strip_suffix(&worktree_path, "/.");
> >
> > -     strbuf_addf(&path, "%s/HEAD", get_git_common_dir());
> > -
> >       worktree = xcalloc(1, sizeof(*worktree));
> >       worktree->path = strbuf_detach(&worktree_path, NULL);
> >       worktree->is_bare = is_bare;
> >       add_head_info(worktree);
> >
> > -     strbuf_release(&path);
> >       strbuf_release(&worktree_path);
> >       return worktree;
> >  }
> > @@ -89,12 +101,10 @@ static struct worktree *get_linked_worktree(const char *id)
> >               strbuf_strip_suffix(&worktree_path, "/.");
> >       }
> >
> > -     strbuf_reset(&path);
> > -     strbuf_addf(&path, "%s/worktrees/%s/HEAD", get_git_common_dir(), id);
> > -
> >       worktree = xcalloc(1, sizeof(*worktree));
> >       worktree->path = strbuf_detach(&worktree_path, NULL);
> >       worktree->id = xstrdup(id);
> > +     worktree->is_locked = is_worktree_locked(worktree);
> >       add_head_info(worktree);
> >
> >  done:
> > @@ -231,27 +241,20 @@ int is_main_worktree(const struct worktree *wt)
> >       return !wt->id;
> >  }
> >
> > -const char *is_worktree_locked(struct worktree *wt)
> > +const char *worktree_locked_reason(const struct worktree *wt)
> >  {
> > -     assert(!is_main_worktree(wt));
> > +     struct strbuf path = STRBUF_INIT;
> > +     struct strbuf lock_reason = STRBUF_INIT;
> >
> > -     if (!wt->lock_reason_valid) {
> > -             struct strbuf path = STRBUF_INIT;
> > -
> > -             strbuf_addstr(&path, worktree_git_path(wt, "locked"));
> > -             if (file_exists(path.buf)) {
> > -                     struct strbuf lock_reason = STRBUF_INIT;
> > -                     if (strbuf_read_file(&lock_reason, path.buf, 0) < 0)
> > -                             die_errno(_("failed to read '%s'"), path.buf);
> > -                     strbuf_trim(&lock_reason);
> > -                     wt->lock_reason = strbuf_detach(&lock_reason, NULL);
> > -             } else
> > -                     wt->lock_reason = NULL;
> > -             wt->lock_reason_valid = 1;
> > -             strbuf_release(&path);
> > -     }
> > +     assert(!is_main_worktree(wt));
> > +     assert(wt->is_locked);
> >
> > -     return wt->lock_reason;
> > +     strbuf_addstr(&path, worktree_git_path(wt, "locked"));
> > +     if (strbuf_read_file(&lock_reason, path.buf, 0) < 0)
> > +             die_errno(_("failed to read '%s'"), path.buf);
> > +     strbuf_trim(&lock_reason);
> > +     strbuf_release(&path);
> > +     return strbuf_detach(&lock_reason, NULL);
> >  }
> >
> >  /* convenient wrapper to deal with NULL strbuf */
> > diff --git a/worktree.h b/worktree.h
> > index df3fc30f7..6717287e8 100644
> > --- a/worktree.h
> > +++ b/worktree.h
> > @@ -10,12 +10,11 @@ struct worktree {
> >       char *path;
> >       char *id;
> >       char *head_ref;         /* NULL if HEAD is broken or detached */
> > -     char *lock_reason;      /* internal use */
> >       struct object_id head_oid;
> >       int is_detached;
> >       int is_bare;
> >       int is_current;
> > -     int lock_reason_valid;
> > +     int is_locked;
> >  };
> >
> >  /* Functions for acting on the information about worktrees. */
> > @@ -57,10 +56,9 @@ extern struct worktree *find_worktree(struct worktree **list,
> >  extern int is_main_worktree(const struct worktree *wt);
> >
> >  /*
> > - * Return the reason string if the given worktree is locked or NULL
> > - * otherwise.
> > + * Return the reason string if the given worktree is locked or die
> >   */
> > -extern const char *is_worktree_locked(struct worktree *wt);
> > +extern const char *worktree_locked_reason(const struct worktree *wt);
> >
> >  #define WT_VALIDATE_WORKTREE_MISSING_OK (1 << 0)

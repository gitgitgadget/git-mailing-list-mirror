Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032B4C63777
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 08:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D49D24671
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 08:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWc+1MBM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgKQIjQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 03:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgKQIjP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 03:39:15 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFFCC0613CF
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 00:39:14 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id o25so21824273oie.5
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 00:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5kgS0kbNMufvbtLtWBukHzA1sUbJbZrgDSVy0qqTASY=;
        b=hWc+1MBMmpPHWe9EbMFrXcGGbc/mNh+4WD8GB/7sB1Tn3JVICxajJfzhFtDtd7pSru
         Wxb76Fkw1+PSI26n/FIlQmPywGRgknsiIlqY6K9pe5YEe0/WNq5H2H1gwCCmFID/ZSX4
         8Or8FCnTHZfc6Pm9FLSfq0rL5PxoA17rHToxEaJOJeKe0WxpB4VfD9FHdUoxLXhIzDPE
         0knyCujR6Ec8YG+emwB/7fEyJJmpDafuCQ5RQ1LNMsjxoiIBI1yzY3gbcTHwlqZyXAm+
         Kry39vMZpqMLnnMQ0pbJnO/smdYnjl/vShQHr6ZJ78w2O2Fv/CwC8u0+r6GAN79F4dPO
         omJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5kgS0kbNMufvbtLtWBukHzA1sUbJbZrgDSVy0qqTASY=;
        b=VpxjrYhbwC2nxbr1V+K3AjU3M0akWcGe1a6PNuIXla0QpGgdU7Akp2eyZZWltZsJZA
         3Ld3PB1jSc+EJemoDWFlyrxeWFj3lcbEdVpL+ueio9agIc7czwL7EPSnLm69FB+/68Aq
         kSfYPI5jhGzuN1nYtFZNg44xj8rn5jEp9Adr9pkPrWey+cCRlnjM6TsbxPkmKVMTkVb2
         DpzsDnqdQo2pW6vs3VEPt72aDco6nPONmHPz6Kk/DjEbicEDHnc6ckomVjSd8hVyKnGs
         7mL80nEsebrlJszhlbICAwctGcoIQNmTU06W313wu6WcunSb8QyAkw5XU2tXp/UHcC3d
         TOrw==
X-Gm-Message-State: AOAM530fwoAba+qQWOeqR7nq+zCh5mpSAq+qA78n1k3CTkNYvfJRLnub
        xv3jAOf1+WAQsVrV1YxT9FGTLOGGIR7QAU1bItQ=
X-Google-Smtp-Source: ABdhPJxBenE49rAHk6mbgldkC+wRP9hW8qRVntKbIUb6ckVRnV5IHNGfNhcY9zq5U7DOw/iiqguBTzOgRae368Q6Am0=
X-Received: by 2002:aca:49d5:: with SMTP id w204mr1781569oia.167.1605602353415;
 Tue, 17 Nov 2020 00:39:13 -0800 (PST)
MIME-Version: 1.0
References: <58f36a04-afa7-3cf3-ce0a-ad53004dd774@web.de> <20201117044923.3703483-1-newren@gmail.com>
 <20201117065304.GA41136@coredump.intra.peff.net>
In-Reply-To: <20201117065304.GA41136@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 17 Nov 2020 00:39:02 -0800
Message-ID: <CABPp-BGNws7mdnBL2j-hvh1fVwxNjJ1scynzUZtMWtEtJTdkDA@mail.gmail.com>
Subject: Re: [PATCH] chdir-notify: UNLEAK registrated callback entries
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 16, 2020 at 10:53 PM Jeff King <peff@peff.net> wrote:
>
> On Mon, Nov 16, 2020 at 08:49:23PM -0800, Elijah Newren wrote:
>
> > > Right, avoiding list.h like below lets Valgrind classify the memory a=
s
> > > "still reachable", without UNLEAK.  Not sure if it's worth it, though=
.
> > >
> > > Note my somewhat concerning knee-jerk reaction to write some macros. =
;)
> >
> > I've got a local patch that changes these to actually be freed as yet
> > another route we could go.  It's mixed with a few (half-baked)
> > revision-related memory cleanups that should be separated, and I'm
> > unsure if there are other places that would need a finalize_globals()
> > call too, but it's another approach to consider...
>
> Here are a few thoughts...
>
> > diff --git a/builtin/fast-rebase.c b/builtin/fast-rebase.c
> > index 19333ca42d..32cab36ad3 100644
> > --- a/builtin/fast-rebase.c
> > +++ b/builtin/fast-rebase.c
> > @@ -173,6 +173,8 @@ int cmd_fast_rebase(int argc, const char **argv, co=
nst char *prefix)
> >               last_commit =3D create_commit(result.tree, commit, last_c=
ommit);
> >       }
> >       fprintf(stderr, "\nDone.\n");
> > +     rev_info_free(&revs);
> > +     memset(&revs, 0, sizeof(revs));
>
> This one could easily be an UNLEAK(), since we're presumably exiting
> from cmd_fast_rebase() soon after. But I certainly don't mind a real
> cleanup.
>
> Probably rev_info_free() should leave the rev_info in a reasonable state
> (so callers don't have to re-zero it).
>
> > diff --git a/cache.h b/cache.h
> > index c0072d43b1..b9b543f75b 100644
> > --- a/cache.h
> > +++ b/cache.h
> > @@ -604,6 +604,9 @@ const char *setup_git_directory(void);
> >  char *prefix_path(const char *prefix, int len, const char *path);
> >  char *prefix_path_gently(const char *prefix, int len, int *remaining, =
const char *path);
> >
> > +/* Release resources related to global config. */
> > +void finalize_globals(void);
>
> Yuck. Remembering to put things in this, and remembering to call it in
> all of the right places seems ugly.
>
> If we want to go this route, then I think individual pieces of code
> could register their own atexit() handlers to clean up. But...
>
> > +void chdir_deregister_all(void)
> > +{
> > +     struct list_head *pos, *tmp;
> > +
> > +     if (list_empty(&chdir_notify_entries))
> > +             return;
> > +
> > +     list_for_each_safe(pos, tmp, &chdir_notify_entries) {
> > +             struct chdir_notify_entry *e =3D
> > +                     list_entry(pos, struct chdir_notify_entry, list);
> > +             free(e);
> > +     }
> > +     memset(&chdir_notify_entries, 0, sizeof(chdir_notify_entries));
> > +}
>
> I disagree that this is actually a leak. The memory is still referenced
> by the list, just like a ton of other global variables (e.g., quite a
> lot of config or environment variables that are loaded throughout a
> normal program).
>
> So my inclination is to leave referenced globals like this. If there are
> tools that are confused by our linked list structure, then we should
> adjust our tools (either using ASan, or turning off valgrind's "possibly
> lost" report).
>
> (My preference is to use ASan in general, because it's _so_ much
> faster. Running the whole suite under valgrind is pretty painful, and
> ideally we'd eventually hit a point where it was possible to run the
> whole suite with leak-checking enabled).

I'm aware of the differences between "definitely lossed" and "still
reachable".  And yes, the definitely lost are more important to clean
up.  But I'm not convinced that "still reachable" are always okay; I
think they sometimes point to latent bugs and other issues that might
manifest as leaks with slightly different workloads.  I also think
that sometimes these are easier to track down than some of the actual
leaks, but the work to free them and their associated structures will
naturally clear up some of the actual leaks.  Neither of those two
cases apply here, of course, because we've done the auditing to know
why these particular "possibly lost"/"still reachable" references
exist.  But if you have a lot of noise in the "possibly lost" and
"still reachable" categories, it makes it unlikely you'll want to go
through the remainder to find other useful signal.

All that said, I've been sitting on this and a bunch of other patches
for months, because I agree with some of your comments on the ugliness
of the code, and because when I started to go down the rabbit hole for
cleaning up rev_info I found it was not only ugly but also a very deep
hole...and it was measurably slowing down my fast-rebase testcases too
which was demotivating.


Running the whole testsuite under ASan sounds great, btw.

> > diff --git a/git.c b/git.c
> > index af84f11e69..4b04988909 100644
> > --- a/git.c
> > +++ b/git.c
> > @@ -358,6 +358,7 @@ static int handle_alias(int *argcp, const char ***a=
rgv)
> >                       trace2_cmd_name("_run_shell_alias_");
> >
> >                       ret =3D run_command(&child);
> > +                     finalize_globals();
> >                       if (ret >=3D 0)   /* normal exit */
> >                               exit(ret);
>
> I thought common-main.c might be a better place to put something like
> this, but any time we exit() it gets weird (of course, atexit() would
> take care of this).
>
> OTOH, if we call exit() then most things are still on the stack (or in
> globals), so we're not actually leaking those things. I think the root
> of this chdir-notify issue is not that we don't still have a handle to
> the memory, but that the linked list confuses valgrind.  But the same
> would be true if we were holding another linked list (or hashmap) in a
> stack variable, referenced via the heap, etc, and called exit().
>
> > +void rev_info_free(struct rev_info *revs)
> > +{
> > +     int i;
> > +
> > +     for (i =3D 0; i < revs->cmdline.nr; i++)
> > +             free((char*)revs->cmdline.rev[i].name);
> > +     free(revs->cmdline.rev);
> > +}
>
> I suspect there's quite a bit more needed here (Ren=C3=A9 already found a
> case where pathspecs needed to be freed). But I don't mind if we start
> small and add to it as leak-checking notices items.

Yeah, I had other patches that added on to it; I didn't have tests
quite passing so I #ifdef'd out some blocks while testing to return
some leaks but undo some of the breaks.  Anyway, I had something that
looked like

+void rev_info_free(struct rev_info *revs)
+{
+       int i;
+
+#if 0
+       if (revs->commits)
+               free_commit_list(revs->commits);
+#endif
+
+       object_array_clear(&revs->boundary_commits);
+
+       for (i =3D 0; i < revs->cmdline.nr; i++) {
+#if 0
+               /* This block causes double free for 'git fetch origin' */
+               struct object *obj =3D revs->cmdline.rev[i].item;
+               if (obj->type =3D=3D OBJ_COMMIT)
+                       free_commit_list(((struct commit *)obj)->parents);
+#endif
+               free((char*)revs->cmdline.rev[i].name);
+       }
+       free(revs->cmdline.rev);
+
+       clear_pathspec(&revs->prune_data);
+       clear_pathspec(&revs->pruning.pathspec);
+       if (revs->graph)
+               graph_free(revs->graph);
+       free(revs->graph);
+       clear_pathspec(&revs->diffopt.pathspec);
+
+       if (revs->reflog_info)
+               reflog_walk_free(&revs->reflog_info);
+
+       clear_decorations(&revs->children, 1);
+       clear_decorations(&revs->merge_simplification, 1);
+       clear_decorations(&revs->treesame, 1);
+       free_saved_parents(revs);
+       free(revs->saved_parents_slab);
+}

but, not only was it not passing tests, I knew there were other things
to free still that I hadn't gotten too.  Also, you'll note that a
number of functions listed above don't exist; I had to add them.


So yeah, trying to clean up rev_info will be a bit of work.  I'd be
happy to hand off what I do have if anyone is interested; I doubt I'll
get back to it soon.

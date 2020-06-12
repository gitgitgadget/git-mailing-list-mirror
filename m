Return-Path: <SRS0=soZh=7Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A65C433DF
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 19:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33117207ED
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 19:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kirb3IPo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgFLTZy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Jun 2020 15:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgFLTZe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jun 2020 15:25:34 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B83FC08C5C1
        for <git@vger.kernel.org>; Fri, 12 Jun 2020 12:25:34 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id x13so10936537wrv.4
        for <git@vger.kernel.org>; Fri, 12 Jun 2020 12:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Olix818027V1IcNPyeZRLiFMJmViclrWT5wIea+Xn10=;
        b=kirb3IPo9YGGb4ZG3f56e82kCXYkxOwKamdVo9ph8IlgfQCZEAtd+Brr51NhUiVwt1
         zafhCXwmb62Z+I7IoLH5tCKMYTw+K5sZRsWaqjYAWOtnAmrhL6ifEzPLJWe+9kNX8Eig
         niSkLI2XY0H4a9PizgUmYLmbRNzrV49DR3HYbYLVE/09mTjl+7lCoOhJ8PXk9XVto/T6
         bEI9MznuK3f/fUn4+Fl9QGGY0NR2huMdsuXT95XD2CQeze5AWyKd4RezVf08o/u1cbCz
         gSqi7P8ibaO3xv5RKOSiTtVFlH7ApDQrAlm2eOHq14iTG5R7nx68p/L/rGXKZY2yEr+z
         cOfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Olix818027V1IcNPyeZRLiFMJmViclrWT5wIea+Xn10=;
        b=qkXqpROSRn8wj8dGTb6zS7syePRquCgXmUs1ldIssl7Acf2/nAVWy4TbdQZiDyMiSu
         sQxjQztpNzWXx6jeKLyXd/gL6r5iA7o2/8fGk9XM3o7LyWgYzbSJzezbRw3FwhTrvfGh
         PKQzjqib8U9WFw5SGxmMLtvEUSXxY40S9itAO3pGr+VKqCMt10sivZmq5ay4LDsvt+oy
         WsskeAOWS5uaySXQ7ooXwEj653103RbtPeBq+6WHz5WP16Q2O1FbCRh1AsGuv/OrzqRc
         GQdcyD07iIGVkGTaZEzSJ1FVxqHoqbTT3kDsa1BGB/y5CdOj8t06N5c6Okqdo7nltY95
         /p2w==
X-Gm-Message-State: AOAM533Ut3JYvzOyYIJ1xaF0u337sIuLbBwPW9rD/p0ltkfvbYkLEwAs
        eYDq1hVvWVTrbEKqsVhRaDHz138lmJ2xTtkTpfI=
X-Google-Smtp-Source: ABdhPJxrZBTezGt28hlg539rJ89z+ehzckbyrvnZ9Ff/euHrTlN4EqpOtcyEwx+sDoE/T/1D3IlffGT34Cy5jdI7K2g=
X-Received: by 2002:adf:aa94:: with SMTP id h20mr15460483wrc.327.1591989932640;
 Fri, 12 Jun 2020 12:25:32 -0700 (PDT)
MIME-Version: 1.0
References: <pull.804.v3.git.git.1591888511.gitgitgadget@gmail.com>
 <pull.804.v4.git.git.1591978801.gitgitgadget@gmail.com> <4fa6fba33b329ce85f68470fb2545adf1bb06900.1591978801.git.gitgitgadget@gmail.com>
 <xmqq36702l1d.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq36702l1d.fsf@gitster.c.googlers.com>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Fri, 12 Jun 2020 12:25:21 -0700
Message-ID: <CAPx1Gvd8Ggt3OwxAcQY3NsxY=ypOk4S=8TdhjzsohKbbyWNGyQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] git diff: improve range handling
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ugh, forgot to tweak gmail reply to go to the mailing list.  Also
I typed in a wrong word ("commit" should be "comment").

Corrected reply:

On Fri, Jun 12, 2020 at 11:31 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Chris Torek via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > +struct symdiff {
> > +     struct bitmap *skip;
> > +     int warn;
> > +     const char *base, *left, *right;
> > +};
> > +
> > +/*
> > + * Check for symmetric-difference arguments, and if present, arrange
> > + * everything we need to know to handle them correctly.  As a bonus,
> > + * weed out all bogus range-based revision specifications, e.g.,
> > + * "git diff A..B C..D" or "git diff A..B C" get rejected.
> > + *
> > + * For an actual symmetric diff, *symdiff is set this way:
> > + *
> > + *  - its skip is non-NULL and marks *all* rev->pending.objects[i]
> > + *    indices that the caller should ignore (extra merge bases, of
> > + *    which there might be many, and A in A...B).  Note that the
> > + *    chosen merge base and right side are NOT marked.
> > + *  - warn is set if there are multiple merge bases.
> > + *  - base, left, and right point to the names to use in a
> > + *    warning about multiple merge bases.
> > + *
> > + * If there is no symmetric diff argument, sym->skip is NULL and
> > + * sym->warn is cleared.  The remaining fields are not set.
> > + */
>
> OK.
>
> > +static void symdiff_prepare(struct rev_info *rev, struct symdiff *sym)
> > +{
> > +     int i, is_symdiff = 0, basecount = 0, othercount = 0;
> > +     int lpos = -1, rpos = -1, basepos = -1;
> > +     struct bitmap *map = NULL;
> > +
> > +     /*
> > +      * Use the whence fields to find merge bases and left and
> > +      * right parts of symmetric difference, so that we do not
> > +      * depend on the order that revisions are parsed.  If there
> > +      * are any revs that aren't from these sources, we have a
> > +      * "git diff C A...B" or "git diff A...B C" case.  Or we
> > +      * could even get "git diff A...B C...E", for instance.
> > +      *
> > +      * If we don't have just one merge base, we pick one
> > +      * at random.
> > +      *
> > +      * NB: REV_CMD_LEFT, REV_CMD_RIGHT are also used for A..B,
> > +      * so we must check for SYMMETRIC_LEFT too.  The two arrays
> > +      * rev->pending.objects and rev->cmdline.rev are parallel.
> > +      */
> > +     for (i = 0; i < rev->cmdline.nr; i++) {
> > +             struct object *obj = rev->pending.objects[i].item;
> > +             switch (rev->cmdline.rev[i].whence) {
> > +             case REV_CMD_MERGE_BASE:
> > +                     if (basepos < 0)
> > +                             basepos = i;
> > +                     basecount++;
> > +                     break;          /* do mark all bases */
>
> We find and use the first found merge base (i.e. "pick at random" as
> promised in the comment before the function), but for warning, keep
> track of how many merge bases there are.
>
> > +             case REV_CMD_LEFT:
> > +                     if (lpos >= 0)
> > +                             usage(builtin_diff_usage);
>
> A range (either A..B or A...B) has already been seen, and we have
> another, which is now rejected.
>
> > +                     lpos = i;
> > +                     if (obj->flags & SYMMETRIC_LEFT) {
> > +                             is_symdiff = 1;
> > +                             break;  /* do mark A */
>
> Inside this switch statement, "continue" is a sign that the caller
> should use the rev, and "break" is a sign that the rev is to be
> ignored.  We obviously do not ignore "A" in ...
>
> > +                     }
> > +                     continue;
>
> ... "A..B" notation, so we "continue" here.
>
> > +             case REV_CMD_RIGHT:
> > +                     if (rpos >= 0)
> > +                             usage(builtin_diff_usage);
>
> Here is the same "we reject having two or more ranges".
>
> I actually suspect that this usage() would become dead code---we
> would already have died when we saw the matching left end of the
> second range (so this could become BUG(), even though usage() does
> not hurt).

Right - I considered it both ways and figured a second usage() was
simpler and straightforward, but I'm fine with either method.

> > +                     rpos = i;
> > +                     continue;       /* don't mark B */
>
> And of course, whether "A..B" or "A...B", B will be used as the
> "result" side of the diff, so won't be marked for skipping.
>
> > +             case REV_CMD_PARENTS_ONLY:
> > +             case REV_CMD_REF:
> > +             case REV_CMD_REV:
> > +                     othercount++;
> > +                     continue;
>
> I wonder if we want to use "default" instead of these three
> individual cases.  Pros and cons?
>
>  - If we forgot to list a whence REV_CMD_* here, it will be silently
>    marked to be skipped with this code.  With "default", it will be
>    counted to be diffed (which may trigger "giving too many revs to
>    be diffed" error from the diff machinery, which is good).
>
>  - With "default", when we add new type of whence to REV_CMD_* and
>    forget to adjust this code, it will be counted to be diffed.
>    With the current code, it will be skipped.
>
> We probably could get the best of the both words by keeping the
> above three for "counted in othercount and kept), and then add a
> default arm to the switch() that just says
>
>                 default:
>                         BUG("forgot to handle %d",
>                             rev->cmdline.rev[i].whence);

I'm fine with this as well.  I did it the way I did because at least some
compilers give a warning or error if you forgot an enum.  Using default
(or adding one) defeats this, but the BUG method is reasonable.

> That way, every time we add a new type of whence, we would be forced
> to think what should be done to them.
>
> > +             }
> > +             if (map == NULL)
> > +                     map = bitmap_new();
> > +             bitmap_set(map, i);
> > +     }
> > +
> > +     /*
> > +      * Forbid any additional revs for both A...B and A..B.
> > +      */
> > +     if (lpos >= 0 && othercount > 0)
> > +             usage(builtin_diff_usage);
>
> Meaning "git diff A..B C" is bad.  Reasonable.
>
> > +     if (!is_symdiff) {
> > +             bitmap_free(map);
>
> It is not wrong per-se to free it unconditionally, but wouldn't it
> be a bug if (map != NULL) at this point in the flow?

Yes, because the A in A...B will have been marked.  It didn't
seem worth a BUG() call though.

> The merge bases would only be stuffed in the revs when A...B is
> given, and we are not skipping anything involved in A..B or
> non-range revs.
>
> > +             sym->warn = 0;
> > +             sym->skip = NULL;
>
> Clearing these two fields are as promised to the callers in the
> comment above, which is good.
>
> > +             return;
> > +     }
> > +
> > +     sym->left = rev->pending.objects[lpos].name;
> > +     sym->right = rev->pending.objects[rpos].name;
> > +     sym->base = rev->pending.objects[basepos].name;
> > +     if (basecount == 0)
> > +             die(_("%s...%s: no merge base"), sym->left, sym->right);
>
> Good.
>
> > +     bitmap_unset(map, basepos);     /* unmark the base we want */
>
> Hmph.  You could
>
>         case REV_CMD_MERGE_BASE:
>                 basecount++;
>                 if (basepos < 0) {
>                         basepos = i;
>                         continue; /* keep this one */
>                 }
>                 break; /* skip all others */
>
> and lose this unset().  I do not think it makes too much of a
> difference, but it probably is easier to follow if we avoided this
> "do something and then come back to correct" pattern.

OK, I'll change it to do this in the re-roll.

> > +     sym->warn = basecount > 1;
> > +     sym->skip = map;
> > +}
> > +
> >  int cmd_diff(int argc, const char **argv, const char *prefix)
> >  {
> >       int i;
> > @@ -263,6 +366,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
> >       struct object_array_entry *blob[2];
> >       int nongit = 0, no_index = 0;
> >       int result = 0;
> > +     struct symdiff sdiff;
> >
> >       /*
> >        * We could get N tree-ish in the rev.pending_objects list.
> > @@ -382,6 +486,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
> >               }
> >       }
> >
> > +     symdiff_prepare(&rev, &sdiff);
> >       for (i = 0; i < rev.pending.nr; i++) {
> >               struct object_array_entry *entry = &rev.pending.objects[i];
> >               struct object *obj = entry->item;
> > @@ -396,6 +501,8 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
> >                       obj = &get_commit_tree(((struct commit *)obj))->object;
> >
> >               if (obj->type == OBJ_TREE) {
> > +                     if (sdiff.skip && bitmap_get(sdiff.skip, i))
> > +                             continue;
>
> By the way, I cannot shake this feeling that, given that
> rev.pending/cmdline.nr will not be an unreasonably large number, if
> it is overkill to use the bitmap here.  If I were writing this code,
> I would have made symdiff_prepare() to fill a separate object array
> by copying the elements to be used in the final "diff" out of the
> rev.pending array and updated this loop to iterate over that array.
>
> I am not saying that such an approach is better than the use of
> bitmap code here.  It just was a bit unexpected to see the bitmap
> code used for set of objects that is typically less than a dozen.

I am sure it is overkill -- but at the same time, it's already coded
and cheap enough to use that rolling our own separate array felt
worse.  I can add a comment (NOT COMMIT) if you like.

Thanks,

Chris

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D9CC4361B
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 16:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAF0022581
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 16:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730777AbgLOQ55 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 11:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729673AbgLOQ5q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 11:57:46 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07293C06179C
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 08:57:03 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id s75so24067079oih.1
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 08:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i2/mYkZZCwrvbA758SL0cCJLUE8f6c7MAGnWgThWLns=;
        b=pbVomRllGvkEpo64R4DUGHraBxd/hkoTIkEYRu3wR8c7aEq6eNm9p9RiBAyLBSlLnD
         hgWuySnCee+oeH9aI2BB0VIYeuHJq8ceSbdApCD7YdE22xnlK6kJECdZJyLUsM7rzH6V
         jzBa6oeY6NJyepG/SSm+kRGum0MXB6JNtuydNKaWQfnQ3Dnzh0iR+qlxhIuKfTrtLiAX
         KtVUDu1V6uzVFbYy/QMJ2QjOCXuKbC+qnzD4B+TVeQCmqa76p/WNtHgNnYH0FWgFVEgn
         XEC6z1lKH6ewkGpNEcIe2l/1Z+kMo7GEtAjiNpzuYlRURlxO5bn23rYltrHl/k6NxHYb
         5XEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i2/mYkZZCwrvbA758SL0cCJLUE8f6c7MAGnWgThWLns=;
        b=ioNLCLfg2+zPYacKiSo4JMLmzcvZGVDLVr04l+1q5ZozHJgspSO8qBXL7F+euofmrw
         B0P/fsapcEd3SueewhSiXNDSo3nx9k9GZlv1uTMbfmIjiYaHdMFeMGhkXFUy+y08QsWY
         es5YuqfNputWHQbX2rtFvm1wbcQ1QYIHXgb4WfyHhWKl5kjwgPzZ8ZEuOpCnRrgehNXk
         U8QCrecyGQx9Yg9G2KfmPBYZE+yKPBF1N+A5smm8NxEZrTBd8wF0U4gbvdwM7gpxwISB
         oYIvNRQACQ7JBus3zAGsuH4tuhQLKlJQCbZLd6csPPOzojFZl3C+npN4djL2rVA/FX3U
         TnWg==
X-Gm-Message-State: AOAM530udOGw4uA5d9VKZ6WnMxBX+ILABqg0QRVji8rn0kAwdC1DaiaR
        Hp27atNPibZu4bn22ZJdU2VvlGOL89/JS5hXt+E=
X-Google-Smtp-Source: ABdhPJzijx5aXWP4JmibTfTsgxHCovrBMrt5B0mK5Yao664LHbAqgBTKZ0L5iObR/2Ax83vHxyilhLmv5NtPwEU6ato=
X-Received: by 2002:aca:3151:: with SMTP id x78mr17444896oix.39.1608051422245;
 Tue, 15 Dec 2020 08:57:02 -0800 (PST)
MIME-Version: 1.0
References: <pull.812.git.1607542887.gitgitgadget@gmail.com>
 <pull.812.v2.git.1607962900.gitgitgadget@gmail.com> <edd610321a053b431def5b06bb2983c7f4a84547.1607962900.git.gitgitgadget@gmail.com>
 <48fc65a5-12ba-be67-2908-27a446b1f813@gmail.com>
In-Reply-To: <48fc65a5-12ba-be67-2908-27a446b1f813@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 15 Dec 2020 08:56:51 -0800
Message-ID: <CABPp-BHiwFgTT+y35WEo3v44y6Ypo49di1P6+6A9DaLMTFK7yg@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] merge-ort: add implementation of rename collisions
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 15, 2020 at 6:09 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 12/14/2020 11:21 AM, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > Implement rename/rename(2to1) and rename/add handling, i.e. a file is
> > renamed into a location where another file is added (with that other
> > file either being a plain add or itself coming from a rename).  Note
> > that rename collisions can also have a special case stacked on top: the
> > file being renamed on one side of history is deleted on the other
> > (yielding either a rename/add/delete conflict or perhaps a
> > rename/rename(2to1)/delete[/delete]) conflict.
> >
> > One thing to note here is that when there is a double rename, the code
> > in question only handles one of them at a time; a later iteration
> > through the loop will handle the other.  After they've both been
> > handled, process_entry()'s normal add/add code can handle the collision.
> >
> > This code replaces the following from merge-recurisve.c:
> >
> >   * all the 2to1 code in process_renames()
> >   * the RENAME_TWO_FILES_TO_ONE case of process_entry()
> >   * handle_rename_rename_2to1()
> >   * handle_rename_add()
> >
> > Also, there is some shared code from merge-recursive.c for multiple
> > different rename cases which we will no longer need for this case (or
> > other rename cases):
> >
> >   * handle_file_collision()
> >   * setup_rename_conflict_info()
> >
> > The consolidation of six separate codepaths into one is made possible
> > by a change in design: process_renames() tweaks the conflict_info
> > entries within opt->priv->paths such that process_entry() can then
> > handle all the non-rename conflict types (directory/file, modify/delete,
> > etc.) orthogonally.  This means we're much less likely to miss special
> > implementation of some kind of combination of conflict types (see
> > commits brought in by 66c62eaec6 ("Merge branch 'en/merge-tests'",
> > 2020-11-18), especially commit ef52778708 ("merge tests: expect improved
> > directory/file conflict handling in ort", 2020-10-26) for more details).
> > That, together with letting worktree/index updating be handled
> > orthogonally in the merge_switch_to_result() function, dramatically
> > simplifies the code for various special rename cases.
>
> I'm really happy that you broke out the cases earlier, and describe
> them so well in the message. It makes this hunk of code really easy
> to understand:
>
> > +                     const char *pathnames[3];
> > +                     struct version_info merged;
> > +
> > +                     struct conflict_info *base, *side1, *side2;
> > +                     unsigned clean;
> > +
> > +                     pathnames[0] = oldpath;
> > +                     pathnames[other_source_index] = oldpath;
> > +                     pathnames[target_index] = newpath;
> > +
> > +                     base = strmap_get(&opt->priv->paths, pathnames[0]);
> > +                     side1 = strmap_get(&opt->priv->paths, pathnames[1]);
> > +                     side2 = strmap_get(&opt->priv->paths, pathnames[2]);
> > +
> > +                     VERIFY_CI(base);
> > +                     VERIFY_CI(side1);
> > +                     VERIFY_CI(side2);
> > +
> > +                     clean = handle_content_merge(opt, pair->one->path,
> > +                                                  &base->stages[0],
> > +                                                  &side1->stages[1],
> > +                                                  &side2->stages[2],
> > +                                                  pathnames,
> > +                                                  1 + 2*opt->priv->call_depth,
>
> nit: " * "

Will fix.

> > +                                                  &merged);
> > +
> > +                     memcpy(&newinfo->stages[target_index], &merged,
> > +                            sizeof(merged));
> > +                     if (!clean) {
> > +                             path_msg(opt, newpath, 0,
> > +                                      _("CONFLICT (rename involved in "
> > +                                        "collision): rename of %s -> %s has "
> > +                                        "content conflicts AND collides "
> > +                                        "with another path; this may result "
> > +                                        "in nested conflict markers."),
> > +                                      oldpath, newpath);
>
> I was briefly taken aback by "AND collides with another path" wondering if
> that wording helps users understand the type of conflict here. But I can't
> think of anything better, so *shrug*.
>
> > +                     }
> >               } else if (collision && source_deleted) {
> > -                     /* rename/add/delete or rename/rename(2to1)/delete */
> > -                     die("Not yet implemented");
> > +                     /*
> > +                      * rename/add/delete or rename/rename(2to1)/delete:
> > +                      * since oldpath was deleted on the side that didn't
> > +                      * do the rename, there's not much of a content merge
> > +                      * we can do for the rename.  oldinfo->merged.is_null
> > +                      * was already set, so we just leave things as-is so
> > +                      * they look like an add/add conflict.
> > +                      */
> > +
> > +                     newinfo->path_conflict = 1;
> > +                     path_msg(opt, newpath, 0,
> > +                              _("CONFLICT (rename/delete): %s renamed "
> > +                                "to %s in %s, but deleted in %s."),
> > +                              oldpath, newpath, rename_branch, delete_branch);
>
> I think this branch is added in the wrong patch. My compiler is complaining
> that 'rename_branch' and 'delete_branch' are not declared (yet).

Whoops.  This used to be separate patches, with the second half coming
after one of the later patches in the series.  But in the commit
message seemed most natural to talk about "rename collisions" which
then means both types of conflicts here.  So I squashed them...and
broke the build.  I'll rearrange this one to come after the
rename/delete patch so that rename_branch and delete_branch will be
defined.

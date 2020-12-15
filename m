Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 614DFC4361B
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 17:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18B642224C
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 17:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725878AbgLORIg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 12:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbgLORI2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 12:08:28 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3092EC0617A6
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 09:07:48 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id d203so2923082oia.0
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 09:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2+s9eNOSG2ltflVGsd/E0g5V+dFNM+Rw3wW4v+pexBg=;
        b=FETPs7eL3yDvL48gkZWzinpsC/0DLE4XQyews27mvef+7Fr3jnz5YAXW0QN7BXMfNa
         XLv2vfsZg1mifRQSw6hlvsjKSXjSNg2sgtitgrOpm4QtLmAyu9OZ0hl9G2eIFaQ090bj
         pFX7nBryjKoUjOqAGunN9kEwPW+La3eaKsmKQQDPXqvt+aiDl9GRo7q6jk9SiySEpB00
         3H9RCV2fYCCFyRkYdhCU54aPaDDhx4fGNxGrYRFNbw7STaLXUeGyPZzr6jGcRBGYAFdX
         Ypsfk3CMjOnKLPDlRy/Oy9dXKO3xY7EUfRPYCgKRZL8CD3ARCAP+Bj0KLn/Lh8uDAT+u
         ZD9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2+s9eNOSG2ltflVGsd/E0g5V+dFNM+Rw3wW4v+pexBg=;
        b=h4ONDSeYHfcxhuMQ75LehHYkP+4LVtwJPR7TQTFJspbpJnxXoAbk1P9E1GbpteUA9T
         0EXg0pWJbCa3Gc2Gtbhe4F5ekTtX00JRtfD09x0eyZ2sag7DF5mGtBgvaqw4KsWH/nBX
         A6CpM/vKHELA6EEQIGNOMVbEY63k7xaM9vaWpfK3kaUQ3Z8fIYGbIkdHOBbY+PuzOqBd
         ewmTPLWagI1gqAo91Jzj8QtvZyQkJ9/4NRWA6JaYd62sfSLjlptwPCmoLpuSZHm+la0S
         GnvrQnkxrmqZ2DSWnPIw8Ms0ust7DN19Yo+kHbAHdiYg624zBmpCD2Wv4ZQ92mMZzB+/
         FsVA==
X-Gm-Message-State: AOAM530vkcC3jvpoMRc5c4jjHkuXu0Q7UnOFVBEV5WGx9g/Xof74ClaW
        3cEIXN6bnCkT1rJ92x+cRCDHqmm8GXrhoRO8LEY=
X-Google-Smtp-Source: ABdhPJxrOdZK71jtQQbtwBm57qgMGYmxRez4o7uZo1arA4ryG4LxF1n33GzQs40MjM+waRo1Nxu4NMa/mq7dDTlQw0M=
X-Received: by 2002:a05:6808:991:: with SMTP id a17mr21748297oic.167.1608052067473;
 Tue, 15 Dec 2020 09:07:47 -0800 (PST)
MIME-Version: 1.0
References: <pull.812.git.1607542887.gitgitgadget@gmail.com>
 <pull.812.v2.git.1607962900.gitgitgadget@gmail.com> <f017534243c967caa0137e6899f4e1c69ff02c2e.1607962900.git.gitgitgadget@gmail.com>
 <05f52d13-d9ec-226d-370a-140937b12e7a@gmail.com>
In-Reply-To: <05f52d13-d9ec-226d-370a-140937b12e7a@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 15 Dec 2020 09:07:36 -0800
Message-ID: <CABPp-BFbiszLAbWgF_qgHCxRgw4CBeiGnAHE8ErNYm4iAjiVXw@mail.gmail.com>
Subject: Re: [PATCH v2 09/11] merge-ort: add implementation of rename/delete conflicts
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 15, 2020 at 6:23 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 12/14/2020 11:21 AM, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > Implement rename/delete conflicts, i.e. one side renames a file and the
> > other deletes the file.  This code replaces the following from
> > merge-recurisve.c:
> >
> >   * the code relevant to RENAME_DELETE in process_renames()
> >   * the RENAME_DELETE case of process_entry()
> >   * handle_rename_delete()
> >
> > Also, there is some shared code from merge-recursive.c for multiple
> > different rename cases which we will no longer need for this case (or
> > other rename cases):
> >
> >   * handle_change_delete()
> >   * setup_rename_conflict_info()
> >
> > The consolidation of five separate codepaths into one is made possible
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
> >
> > To be fair, there is a _slight_ tweak to process_entry() here, because
> > rename/delete cases will also trigger the modify/delete codepath.
> > However, we only want a modify/delete message to be printed for a
> > rename/delete conflict if there is a content change in the renamed file
> > in addition to the rename.  So process_renames() and process_entry()
> > aren't quite fully orthogonal, but they are pretty close.
>
> Thanks for adding this warning about the change to process_entry().
>
> > @@ -657,6 +657,7 @@ static int process_renames(struct merge_options *opt,
> >               unsigned int old_sidemask;
> >               int target_index, other_source_index;
> >               int source_deleted, collision, type_changed;
> > +             const char *rename_branch = NULL, *delete_branch = NULL;
>
> Ah, here they are!
>
> > +             if (source_deleted) {
> > +                     if (target_index == 1) {
> > +                             rename_branch = opt->branch1;
> > +                             delete_branch = opt->branch2;
> > +                     } else {
> > +                             rename_branch = opt->branch2;
> > +                             delete_branch = opt->branch1;
> > +                     }
> >               }
> >
> >               assert(source_deleted || oldinfo->filemask & old_sidemask);
> > @@ -838,13 +847,26 @@ static int process_renames(struct merge_options *opt,
> >                                  "to %s in %s, but deleted in %s."),
> >                                oldpath, newpath, rename_branch, delete_branch);
>
> This context line is the previous use of rename_branch and delete_branch.
> Perhaps the declarations, initialization, and first-use here are worth
> their own patch?
>
> >               } else {
> > +                     /*
> > +                      * a few different cases...start by copying the
> > +                      * existing stage(s) from oldinfo over the newinfo
> > +                      * and update the pathname(s).
> > +                      */
> > +                     memcpy(&newinfo->stages[0], &oldinfo->stages[0],
> > +                            sizeof(newinfo->stages[0]));
> > +                     newinfo->filemask |= (1 << MERGE_BASE);
> > +                     newinfo->pathnames[0] = oldpath;
> >                       if (type_changed) {
> >                               /* rename vs. typechange */
> >                               die("Not yet implemented");
> >                       } else if (source_deleted) {
> >                               /* rename/delete */
> > +                             newinfo->path_conflict = 1;
> > +                             path_msg(opt, newpath, 0,
> > +                                      _("CONFLICT (rename/delete): %s renamed"
> > +                                        " to %s in %s, but deleted in %s."),
> > +                                      oldpath, newpath,
> > +                                      rename_branch, delete_branch);
>
> Since the primary purpose of rename_branch and delete_branch appears to
> be for these error messages, then likely the previous error message about
> a rename/delete should just be promoted into this patch instead of the
> previous.
>
> In fact, the error messages are the exact same, but with slightly different
> lines due to wrapping:
>
>                         path_msg(opt, newpath, 0,
>                                  _("CONFLICT (rename/delete): %s renamed "
>                                    "to %s in %s, but deleted in %s."),
>                                  oldpath, newpath, rename_branch, delete_branch);
>
> and
>
>                                 path_msg(opt, newpath, 0,
>                                          _("CONFLICT (rename/delete): %s renamed"
>                                            " to %s in %s, but deleted in %s."),
>                                          oldpath, newpath,
>                                          rename_branch, delete_branch);
>
> I wonder if there is a way to group these together? Perhaps the nested
> if/else if/else blocks could store a "conflict state" value that says
> which CONFLICT message to print after the complicated branching is done.
>
> Alternatively, this message appears to be written in the following case:
>
>         source_deleted && !type_changed
>
> your if/else if/else block could be rearranged as follows:
>
>         if (collision && !source_deleted)
>                 /* collision: rename/add or rename/rename(2to1) */
>         else if (!type_change && source_deleted)
>                 /* rename/delete or rename/add/delete or rename/rename(2to1)/delete */
>         else if (!collision)
>                 /* a few different cases */
>
> Of course, the thing I am missing is that copy of oldinfo->stages[0] into
> newinfo->stages[0] along with changes to the filemask and pathnames! That
> is likely why you need the two different markers, because the cases truly
> are different in that subtle way.

Yeah, there is that subtlety and another one -- the rename/add/delete
case will also later trigger the "add/add" conflict type within
process_entries() for this same path, whereas the rename/delete case
from this patch won't.  The combination is enough of a difference that
I'm worried that trying to make both types run through the same code
block might blur the differences and pose a landmine for future folks
coming to edit the code; it'd make it too easy to break one or the
other conflict type.

If the sharing was done a different way, namely saving the basic
message in some variable before either if-block and then both places
just pass that string to path_msg() instead of both having it typed
out, then that'd probably make sense, but then we're not really saving
much.

> >                               /* normal rename */
> >                               die("Not yet implemented");
> > @@ -1380,12 +1402,21 @@ static void process_entry(struct merge_options *opt,
> >               modify_branch = (side == 1) ? opt->branch1 : opt->branch2;
> >               delete_branch = (side == 1) ? opt->branch2 : opt->branch1;
> >
> > -             path_msg(opt, path, 0,
> > -                      _("CONFLICT (modify/delete): %s deleted in %s "
> > -                        "and modified in %s.  Version %s of %s left "
> > -                        "in tree."),
> > -                      path, delete_branch, modify_branch,
> > -                      modify_branch, path);
> > +             if (ci->path_conflict &&
> > +                 oideq(&ci->stages[0].oid, &ci->stages[side].oid)) {
> > +                     /*
> > +                      * This came from a rename/delete; no action to take,
> > +                      * but avoid printing "modify/delete" conflict notice
> > +                      * since the contents were not modified.
> > +                      */
> > +             } else {
> > +                     path_msg(opt, path, 0,
> > +                              _("CONFLICT (modify/delete): %s deleted in %s "
> > +                                "and modified in %s.  Version %s of %s left "
> > +                                "in tree."),
> > +                              path, delete_branch, modify_branch,
> > +                              modify_branch, path);
> > +             }
>
> Thanks,
> -Stolee

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60FE120248
	for <e@80x24.org>; Thu,  7 Mar 2019 04:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbfCGEOv (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Mar 2019 23:14:51 -0500
Received: from mail-vs1-f41.google.com ([209.85.217.41]:43324 "EHLO
        mail-vs1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfCGEOv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Mar 2019 23:14:51 -0500
Received: by mail-vs1-f41.google.com with SMTP id i15so3669757vsd.10
        for <git@vger.kernel.org>; Wed, 06 Mar 2019 20:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q0L86FpOZm+SfKjM0ypKtnamGmDugEIr5WXjZkKqIOQ=;
        b=TDWggiTEtrPKb1GVYj297RE8qBDZ/czHcTNlYSDOew5aYwTiTT1ohA5qeGn8DunmlS
         s5RTUyEfvmRsiQUmkzQwG+WATe3ioXdLoh53n/jPWuIpMpdMluu+kK3mtaqaAWNYlp3s
         cXjh91HurD1E450z5MQgOPkcTiVNK8drLAb8aEeRY9RnErn1wo9Z9pAYTY8XvMi4Y6Q6
         5j2q5vP430n7iwWwv6noJkeOqJyV8hXHWtjFpjyyDEGCGgRmxiVUWbAbj5ZdjJQQWgvf
         r+1K3a5Xu0YaUfoZZgL8ahtRcgbBfQ4u/BJRMsgLkTiSawYobYFoW0A4hbZXvQZckO/d
         ZcLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q0L86FpOZm+SfKjM0ypKtnamGmDugEIr5WXjZkKqIOQ=;
        b=n6Wz9VBVkljKJSh3Nql7/AF1Y1GdFxEi0o/kxGaXzswtpV5k5bDkxbuE5n2VHZr/mw
         rt55k5QdNYuOVTylIuE+omlF+TT4VjI+Uy5vhSGHZ8ST6LQQNWhowITwTMxNYPFBGygR
         EaQmEtf2fgO882JKa/GZoUywVqDslbAXQU2amrNGBc/nhFh5cTaNKbmnBdVJRHuRNSHg
         or0SBT6EicdjGFmyF2rvZkLuYgf+1DHaQL9ECbGMCQFEvMGz/WKPRSnYafahP6+ZaOHo
         AvU73y9NqIBWxOhjXznxgvkXOq6tOHzZaUwsYTEmOhE2hYH2tCx4yb5noLjZlE3D9OCk
         a96A==
X-Gm-Message-State: APjAAAVncTQBryYjMAiSk5dB7tvM0kTX4rUFM1Fo8q0yvIztYAB3oLVk
        NpJMH55/nTE7HiPmdIW0J1pfp7WiER1GyymtnTtQt+wl
X-Google-Smtp-Source: APXvYqyvnzJdSo23scHFY7+S/cDgJi+w/2N3DfM+SXw6GXkbMEHt81F+rDzAC3mIsLAyJdj24YDIn+YcLoDsJtnem7E=
X-Received: by 2002:a67:f8cc:: with SMTP id c12mr5777077vsp.136.1551932088882;
 Wed, 06 Mar 2019 20:14:48 -0800 (PST)
MIME-Version: 1.0
References: <xmqqimx03fo6.fsf@gitster-ct.c.googlers.com> <20190306002744.14418-1-newren@gmail.com>
 <xmqqh8cgr4tf.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqh8cgr4tf.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 6 Mar 2019 20:14:37 -0800
Message-ID: <CABPp-BF=GFgFRfgdG2rFK89x1tYrJO8TpECyv6BoTgz9q3Rb+g@mail.gmail.com>
Subject: Re: [BUG] All files in folder are moved when cherry-picking commit
 that moves fewer files
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Linus Nilsson <Linus.Nilsson@trimma.se>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 5, 2019 at 8:43 PM Junio C Hamano <gitster@pobox.com> wrote:
> Elijah Newren <newren@gmail.com> writes:
>
> > Note that there is also a third possibility here:
> >
> >   C) There are different answers depending on the context and content
> >      that cannot be determined by git, so this is a conflict.  Use a
> >      higher stage in the index to record the conflict and notify the
> >      user of the potential issue instead of silently selecting a
> >      resolution for them.
> >
> > Add an option for users to specify their preference for whether to use
> > directory rename detection, and default to (C).
>
> Yeah, (c) is the sanest default that can give the best of both
> worlds, I would have to say.

Great, sounds like we're in agreement on the high level objective.  :-)

> Sometimes the heuristics guess that the new one may want to go to
> the same place as all the neighbours, and other times the new one
> may want to stay.  By using stage #2 and stage #3 appropriately, the
> user can see where the final result wants to be in.  Because by
> definition there won't be any auto-resolvable content-level merge
> for such paths (after all, one side is adding it as a new file), I
> think the contents for these two higher-stage entries would actually
> be the same?

I'm not sure I'm following well enough to answer any your question(s),
so I'll instead ask a few of my own:
  * Are you referring to stage #2 and stage #3 of the old path or the
new path or one of each or both of each?
  * Would this be consistent with how normal renames behave?
and, as a partial answer to your question:
  * Does that also work with files renamed into the old directory
instead of just added?

I don't know if normal renames are similar enough to the directory
rename case in this particular area that it makes sense to compare,
but there was one specific thing that came to my mind that I wondered
about:  For normal renames, we only have index entries for the new
path rather than the old path even if there are content level merge
conflicts.  So, for example if a 'list_of_favorites.txt' was modified
on both sides of history and one side renames to
$SUBDIR/list_of_favorites.txt, then instead of having any entries in
the index for list_of_favorites.txt, we have three entries for
$SUBDIR/list_of_favorites.txt.  That makes it easier for users to
resolve (they can use a single git add and no git rm).

Note that as a special case for this rename, we could have $SUBDIR/ =
x/, because if the other side renamed x/ -> z/, then
list_of_favorites.txt should perhaps be transitively renamed to
z/list_of_favorites.txt.  Although this kind of thing is more rare
than just adding files to the old directory, this kind of case comes
up too, so there actually could be content-level merge for paths
affected by directory rename detection.  (Sidenote more for myself:
Transitively renamed paths feed through handle_rename_normal() instead
of handle_rename_via_dir(), so I need to add the new conflict/warning
messages to handle_rename_normal() too.)

> > +     if (mark_conflicted)
> > +             output(o, 1, _("CONFLICT (directory possibly renamed): %s "
> > +                            "added in %s, but that directory was renamed "
> > +                            "in %s suggesting it should perhaps be moved "
> > +                            "to %s."),
> > +                    pair->one->path, other_branch, rename_branch,
> > +                    dest->path);
>
> What confused the end user is that it is not always the case, and
> that is because the only thing we know at this point is that the
> other branch moved all the files in that directory in their branch
> to the other place, not that they "moved the directory".
>
> In other words, if "that directory was renamed" in this message were
> definitive and agreed with end-user perception, we won't be issuing
> this conflict with a label that says "possibly" renamed.
>
> Perhaps something along this line?
>
>         %(pair->one->path)s added in %(other_branch)s, but the other
>         branch %(rename_branch)s moved all the files in the same
>         directory to %(dirname(dest->path))s, so this file may also
>         want to move there, too.

That sounds better, thanks.  A follow-up question: We normally have
conflict messages of the form:
    CONFLICT(<summary>): <long description>
You've provided an improved long description, but do you have a
suggestion for the summary?  "path location"?  "directory possibly
renamed"?  Something else?

> >       if (!o->call_depth && would_lose_untracked(o, dest->path)) {
> > -             char *alt_path = unique_path(o, dest->path, rename_branch);
> > -
> > +             mark_conflicted = 1;
> > +             file_path = unique_path(o, dest->path, rename_branch);
> >               output(o, 1, _("Error: Refusing to lose untracked file at %s; "
> >                              "writing to %s instead."),
> > -                    dest->path, alt_path);
> > +                    dest->path, file_path);
> > +     }
> > +
> > +     if (mark_conflicted) {
> >               /*
> > -              * Write the file in worktree at alt_path, but not in the
> > -              * index.  Instead, write to dest->path for the index but
> > -              * only at the higher appropriate stage.
> > +              * Write the file in worktree at file_path.  In the index,
> > +              * only record the file at dest->path in the appropriate
> > +              * higher stage.
> >                */
> > -             if (update_file(o, 0, &dest->oid, dest->mode, alt_path))
> > +             if (update_file(o, 0, &dest->oid, dest->mode, file_path))
> >                       return -1;
> > +             if (update_stages(o, dest->path, NULL,
> > +                               rename_branch == o->branch1 ? dest : NULL,
> > +                               rename_branch == o->branch1 ? NULL : dest))
> > +                     return -1;
>
> This one does not issue "may want to stay here" comment of its own,
> so the earlier "CONFLICT (directory possibly renamed)" message would
> need to cover both of these two higher-stage entries.  I think the
> message mentions the two paths, so it would be good already.
>
> The earlier "CONFLICT (directory possibly renamed)" message may be
> sufficient to explain the situation, but I wonder if the user would
> need hints in resolving either of the two possible ways.  I do not
> know if it should be in the same message, or in the manpage update,
> but first let's make sure what we want the end users to understand.
> IIUC, the hint for resolving in favor of either would be to do these
> two commands?
>
>         git checkout --ours $path_the_user_wants_to_use
>         git rm --cached $the_other_path
>
> If the path the user wants to use matches what the branch being
> merged has, then replace "--ours" above with "--theirs".
>
> Would that be a good explanation?

Oh, good point; we may need additional documentation to address this,
though it would be nice if we could minimize it.  As far as the
particular solution, I think we should avoid checkout --ours, for a
few reasons:
  * 'checkout --ours' only reads from and does not update the index,
so it wouldn't resolve the conflict.
  * I think expecting users to figure out --ours vs. --theirs is
confusing, given that users perceive them as reversed in rebase vs
merge, and cherry-pick is somewhere inbetween.
  * In the case of a transitively renamed path (like
list_of_favorites.txt above), --ours might ignore content changes from
one side.

I would prefer to tell the user they can resolve the conflict with two
other commands.  I'm currently thinking of something like these two:
    git add $directory_renamed_path
    git mv $directory_renamed_path $original_path [&& git add $original_path ?]
This pair assumes we write the working tree and index entries for
$directory_renamed_path and leave $original_path empty in both the
working tree and index.  We could alternatively reverse that, with an
equivalent but swapped set of commands for resolution. We can't use
this exact set of commands today, as users would have to do a 'git
add' before a 'git mv'.  I think 'git mv' should be modified to allow
working with higher stage entries (possibly always preserving them?),
which has come up before[1].

[1] https://public-inbox.org/git/xmqqbmabcuhf.fsf@gitster-ct.c.googlers.com/

> Regarding the implementation (not the use of stages, but how
> "mark_conflicted" variable gets used), I am not sure if I agree that
> only choice (c) should give the hint.  Regardless of the settings,
> we know both paths this file may want to end up with, and I suspect
> that the alternative a/b/c you gave are how by default the tool
> automatically places the result, giving a chance to the end user to
> correct mistakes.  I wonder if it is possible to somehow show "the
> other possibilty" in the merge log even when choice (a) or (b) are
> in effect?  E.g. "path X/B moved to Y/B because the other side moved
> X/A to Y/A" when choice (b) is in use, and "path X/B kept there but
> the other side moved neighbouring A/X to Y/A" when choice (a) is in
> use.

I think it makes sense when (b) is in effect but I'm not sure about
(a).  To print such messages, we first have to try to detect renames
(which we currently don't do with (a) though we could change that),
and for the messages to be useful we should believe they are better
than a coin flip's chance of being right.  We use choice (a) with
git-am right now because the fake-ancestor-tree thing means we believe
any directory rename detection is likely to be wrong.

> Another thing that makes me wonder is if this should be treated
> similar to rerere.autoupdate; even when rerere kicks in to resolve
> otherwise conflicting tricky merge, without being explicitly allowed
> with the config, it does not register the resolution to the index at
> stage #0.  Either choices (a) that ignores neighbouring files'
> movement or (b) that follows the movement lets this tricky
> heuristics not just suggest the end result, but allows it to
> register the result at stage #0, which somehow feels too aggressive
> (which was what triggered my suggestion to go with (c)).  With that
> attitude, we may be able to get rid of choice (a) altogether, which
> may make things a tad simpler.  IOW, we assume the heuristics would
> suggest the right solution most of the time, just like we assume
> rerere gives a reasonable resolution most of the time, with a knob
> to accept the result blindly, together with hints to recover when
> heuristics makes mistakes.

I like that analogy.  I think that aligns well with my possible
conflict-resolution commands, and further answers the question about
whether to put the new path or the old path in the working tree and
index.

However, we do need some form of choice (a) for commands which can't
provide accurate tree information, such as git-am.

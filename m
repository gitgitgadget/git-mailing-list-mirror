Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC12DC433EF
	for <git@archiver.kernel.org>; Sun, 12 Jun 2022 06:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234557AbiFLG45 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jun 2022 02:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiFLG44 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Jun 2022 02:56:56 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F44A6473F
        for <git@vger.kernel.org>; Sat, 11 Jun 2022 23:56:54 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id s12so5487329ejx.3
        for <git@vger.kernel.org>; Sat, 11 Jun 2022 23:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9Cyic7WU5RaqGhDrbxd/+pDDkBmxjmzvyh45cBA+L9g=;
        b=ceoJm3EyPco9bGLy2E4/vWxQsX3BMRtipxZDRXM0R7Kpa50EnxxCgD7KQTuzGqnSAj
         pfcSjHRbmJaUkh1iJZSY4qbnaPgMViC1n7Uta4VGJKAJbnzKJCpPw7Cl5BW44UrAfp2g
         o7LciRZwWLu+s4zFNhz0UmXcAhyE50B4YVPg8aDLVeWMW3/QcgFMp513t79/U9q1X0W5
         Sq/l8yyIb0C9CNJwiQYMqY4k/bLZZFJlP+54gQ4QR28+eE1XW5mr1wOfkjhnP4H1Exf7
         wdicr1L+Y7jR/Nrg7z/EK0BZDhcUzpA3n5UVzAZYr9PA46G2eUEkdINLNixtTMEaLdTi
         5TTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9Cyic7WU5RaqGhDrbxd/+pDDkBmxjmzvyh45cBA+L9g=;
        b=uNbAh4yjbMQfwWPjQWrqmkz5PfYhOXvHuTzgIH4IyqJikqN/W6YjQ0ugKNIddC3r6v
         kB43tQfNTCU0Yk0YvhveRT7oVsQitYucsoRjNHUREJCl8WV76ziFwbgf4xVE90LMgF8u
         7g7vzLTAketyhdLQimvdxkFaIK0ryxwG8lSIKKEF+v7lfMgv8ZjSHfSqviuaJQy4gMIj
         OP6Wwjb9keIa3m8Ae+tqZsLQ16qkJqketPwWSmRkAJFelNn0pdFt1BfQVWnyoq6TFMCx
         A8+/9/V/vVSRjWx9+KG2b/mLGnmRo4mXQRivTr182JZQyuhoWY31wuW8zYDNgN7sIjoH
         y8fQ==
X-Gm-Message-State: AOAM533LS7+1C2pjvSYfq9yozsvpaTTuX84PFtKfvNMIjEPU60t7UtLQ
        8bzaVmhkhZSSgZj+SSm5sCIKg8jhrdW5ojGxUOw=
X-Google-Smtp-Source: ABdhPJwsX555Gv+Vh3VY8tO5xMlXx2LgG9GhsUbc9L6ZpHhzsV3cv2pQGmIGXLsHOooy5AIF7fTVHkYjUDC2sZ8Ytvc=
X-Received: by 2002:a17:907:97d4:b0:711:cf0c:c220 with SMTP id
 js20-20020a17090797d400b00711cf0cc220mr30744184ejc.269.1655017012107; Sat, 11
 Jun 2022 23:56:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220606235449.2890858-1-calvinwan@google.com>
 <20220610231152.2594428-1-calvinwan@google.com> <CABPp-BHe7wdd3LMYtZ83ZgapvUxzQYcK-3=sdMAD5Ozs4YmKyw@mail.gmail.com>
 <ed62e9ad-536f-3ab8-2972-17c7f8996617@gmail.com>
In-Reply-To: <ed62e9ad-536f-3ab8-2972-17c7f8996617@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 11 Jun 2022 23:56:40 -0700
Message-ID: <CABPp-BEmVJu1w+2ECwyPzWe8cSHqJZis6AP10OsKSoDJ2W7iqA@mail.gmail.com>
Subject: Re: [PATCH v2] submodule merge: update conflict error message
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Calvin Wan <calvinwan@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philippe,

On Sat, Jun 11, 2022 at 10:08 AM Philippe Blain
<levraiphilippeblain@gmail.com> wrote:
>
> Hi Calvin and Elijah,
>
> Le 2022-06-11 =C3=A0 00:53, Elijah Newren a =C3=A9crit :
> > On Fri, Jun 10, 2022 at 4:29 PM Calvin Wan <calvinwan@google.com> wrote=
:
> >>
> >> When attempting to do a non-fast-forward merge in a project with
> >> conflicts in the submodules, the merge fails and git prints the
> >> following error:
>
> I think we would want to be slightly more precise here, as
> "conflicts in the submodules" could be understood to mean:
>
> 1) conflicting submodule pointers in the superproject being merged
> 2) 1. + also content conflicts in the submodule merge
>
> Here we are just talking about 1.

Isn't that already addressed by Calvin's wording "recursive merging
with submodules is currently not supported..."?  Or are you concerned
that this wording will be separated from the short conflict line?

> Also, the merge does not automatically fail, it only fails if
> a fast-forward *of the submodule pointer* is not possible, which
> might be what you meant above; but to me "a non-fast-forward merge in a p=
roject
> with conflict in the submodules" read like the non-fast-forwardness being=
 talked about
> was in the superproject, not in the submodule(s).
>
> [message 0]
> >>
> >> Failed to merge submodule <submodules>
> >> CONFLICT (submodule):Merge conflict in <submodule>
> >> Automatic merge failed; fix conflicts and then commit the result.
>
>    Aside: the first <submodules> should be singular.
>
> This is indeed the output you get with the ort strategy if no existing me=
rge commit
> exist in the submodule repository that merges the submodule pointers reco=
rded
> in the superproject branches being merged. With the older "recursive" str=
ategy,
> this message is:
>
> [message 1]
> Failed to merge submodule sub (merge following commits not found)
> Auto-merging sub
> CONFLICT (submodule): Merge conflict in sub
> Automatic merge failed; fix conflicts and then commit the result
>
> c73cda76b1 (merge-ort: copy and adapt merge_submodule()
> from merge-recursive.c, 2021-01-01) does not mention why that error messa=
ge
> was changed, but perhaps it is just because it is slightly confusing
> to the user (they might not be expecting Git to look for an existing
> merge and so they don't know what merge the message is talking about).

The text in parentheses from merge-recursive.c didn't parse for me.
Perhaps if it instead read "(failed to find merge commit in submodule
to use as merge resolution)" or something like that then I might have
kept it.  As it was, I found it really hard to parse ("Why are there
no commits after the instruction to 'merge following commits'"?  Is
"merge" a noun or a verb as used in the parenthetical comment? etc.).
The text could have been improved, but a really easy way to improve it
was just to remove it altogether.  Removing it was an easy way to
improve it, so I did that.

Also, a little rant about merge_submodule()....that function
originally had multiple suboptimal error messages, used to write
directly to stdout instead of using the output() function to respect
verbosity, didn't internationalize messages, didn't consider
recursiveness in the resolution, has verbose output that only makes
sense when updating the working tree and index, etc.  It was quite a
mess.  Some of that got cleaned up in merge-recursive.c.  Some only
got cleaned up with the move to merge-ort.c.  Some of it sadly still
persists (as mentioned elsewhere in this email).

> Maybe something like "failed to find existing commit merging <hash1> and =
<hash2>"
> would be clearer...

Yes, that would be much clearer.  Can I tweak the suggestion to
"failed to find an existing commit in submodule merging <hash1> and
<hash2>"?

However, while it's work in a related area (merging of submodules), I
think this suggestion is separate from what Calvin is trying to fix
and doesn't need to hold up his patch.

> >>
> >> Git is left in a conflicted state, which requires the user to:
> >>  1. merge submodules
> >>  2. add submodules changes to the superproject
> >>  3. merge superproject
> >
> > I think we may need to tweak these steps a bit:
> >
> >    1. merge submodules OR update submodules to an already existing
> > commit that reflects the merge (i.e. as submodules they may well be
> > independently actively developed.  Someone may have already merged the
> > appropriate branch/commit and the already extant merges should be used
> > in preference to creating new ones.)
> >    2. <just as you said>
> >    3. FINISH merging the superproject (i.e. don't redo the merge)
> >
> > I might be off on step 1; I have only used submodules extremely
> > lightly and usually only for a limited time, so I'm not really sure
> > what the expected workflow is.  I could also imagine it potentially
> > being repository-dependent whether you would want to merge or select
> > an appropriate commit to update to.
>
> I agree with Elijah here, the submodule conflcit resolution might be to:
>
> 1) just choose one of the existing submodule commits on either side of
> the superproject branches being merged
> 2) choose an exisiting merge commit in the submodule repository (maybe af=
ter fetching it first)
> 3) create such a merge commit (what you are talking about here)
>
> I also agree that it is highly repository- and workflow-dependent what
> the "right" resolution is.
>
> Note that the code does try to find an existing merge commit in the submo=
dule
> repository, in this case the error message is different. If such a merge =
commit
> exists:
>
>     [message 2]
>     Failed to merge submodule sub, but a possible merge resolution exists=
:
>         aafcfa2 Merge branch 'sub-c' into sub-d
>
>
>     If this is correct simply add it to the index for example
>     by using:
>
>       git update-index --cacheinfo 160000 aafcfa2a62764282ab848d5d6bea86b=
a217c1b24 "sub"
>
>     which will accept this suggestion.
>
>     CONFLICT (submodule): Merge conflict in sub
>     Automatic merge failed; fix conflicts and then commit the result.
>
> if multiple merge exist:
>
>     [message 3]
>     Failed to merge submodule sub, but multiple possible merges exist:
>         2729a0c Merge branch 'sub-c' into ambiguous
>         aafcfa2 Merge branch 'sub-c' into sub-d
>
>     CONFLICT (submodule): Merge conflict in sub
>     Automatic merge failed; fix conflicts and then commit the result.
>
> Another aside, I really don't think we should instruct users to run
> plumbing like 'git update-index --cacheinfo' , they should just cd into
> the submodule and checkout the merge commit!

+1

> >
> >> These steps are non-obvious for newer submodule users to figure out
> >> based on the error message and neither `git submodule status` nor `git
> >> status` provide any useful pointers.
> >>
> >> Update error message to the following when attempting to do a
> >> non-fast-forward merge in a project with conflicts in the submodules.
> >
> > Make sense.
>
> I agree that more guidance is a very nice addition.
>
> Regarding 'git status' output, it is downright confusing, since it says:
>
> Unmerged paths:
>   (use "git add <file>..." to mark resolution)
>         both modified:   sub
>
> which is not at all what you want to do most of the time (that would
> just stage whatever the currently checked out commit in the submodule is
> at the moment!)

Sure, but this isn't anything special about submodules.  You don't
want to "git add $path" if you haven't resolved the conflicts in $path
first.  That's advice that is true regardless of whether it's a
regular text file that was present on both sides of the merge, in
which case there will be conflict markers to remind the user to
resolve conflicts first, or whether it's something else.  And there
are a lot of something elses without conflict markers: a submodule, a
binary file, a symlink, path from file/directory conflict, something
with conflicting modes, a file with any of a variety of rename-related
path conflicts, maybe others.

Perhaps you just want the advice changed to

    (use "git add <file>..." after resolving conflicts for the
specified path(s))

?  It's a bit of a mouthful, but I guess it addresses your concern.
It's another possible improvement that belongs outside Calvin's patch
so it can be discussed separately.  :-)

>> The error message is based off of what would happen when `merge
> >> --recurse-submodules` is eventually supported
> >>
> >> Failed to merge submodule <submodule>
> >> CONFLICT (submodule): Merge conflict in <submodule>
> >> Automatic merge failed; recursive merging with submodules is currently
> >> not supported. To manually complete the merge:
> >>  - go to submodule (<submodule>), and merge commit <commit>
> >>  - come back to superproject, and `git add <submodule>` to record the =
above merge
> >>  - resolve any other conflicts in the superproject
> >>  - commit the resulting index in the superproject
> >
> > Ah, I see you've fixed step 3 here; that's good.
> >
> > However, these steps miss out on the merge-or-update submodule
> > possibility...and since you mention these steps are potentially the
> > basis for some future work, I think it's worth calling that out again.
> > I'm slightly worried that the 'update' part of merge-or-update may
> > throw a wrench in the plans for `merge --recurse-submodules`.
> >
>
> Slightly off topic here, but for me the most important improvement that
> 'git merge --recurse-submodules' would bring is when there is *no submodu=
le
> conflicts*, i.e. one side fast-forwards the submodule and the other side
> does not touch it, since in that case the worktree of the submodule *is n=
ot updated*
> by the current code, which is one of the most confusing aspect of using s=
ubmodules
> for new users ("why is "git status" and "git diff" not clean if "git merg=
e"
> was fast-forward ?!?"), and the same is true (maybe more even so) for 'gi=
t rebase'.

Do you really mean "i.e." here or did you mean "e.g."?  I think the
example you give is just one where a submodule can be cleanly merged
and then doesn't get updated.  Another is when an already existing
submodule merge commit can be used as the merge resolution for the
submodule.  The merging code simply doesn't update the working tree
(or indexes) of submodules regardless of whether it updates the
submodule pointers.

Taking a quick glance, I think it might turn out to be trivial to fix
this in merge-ort.c.  I _think_ simply setting
   config_update_recurse_submodules =3D RECURSE_SUBMODULES_ON
in merge-ort.c:checkout() anywhere before the call to unpack_trees()
might be enough.  Want to try it?

The fix in merge-recursive is probably much more involved, and likely
not worth the effort (there's a related comment in the code in
update_file_flags() about this; look for "submodule").

> > (Also, continuing on the `merge --recurse-submodules` talent but
> > discussing a different aspect of it, I'm curious if you need to add
> > extra dirty-worktree/dirty-index checks for each submodule at the
> > start of a merge, whether you need to try to lock N indexes before
> > starting, and what other extra details are necessary.  But those are
> > probably questions to address whenever work on the future series to
> > implement this option is underway.)
> >
> >> Changes since v1:
> >>  - Removed advice to abort merge
> >>  - Error message updated to contain more commit/submodule information
> >>
> >> Signed-off-by: Calvin Wan <calvinwan@google.com>
> >>
> >> ---
> >>  builtin/merge.c            | 23 ++++++++++++++++++++++-
> >>  merge-ort.c                |  7 ++++++-
> >>  merge-recursive.c          |  7 ++++++-
> >>  merge-recursive.h          |  4 ++++
> >>  t/t6437-submodule-merge.sh |  5 ++++-
> >>  5 files changed, 42 insertions(+), 4 deletions(-)
> >
> > So you're modifying the "git merge" porcelain level (builtin/merge.c),
> > the two merges strategies, their common header, and adding some tests.
> > No other porcelains are modified...
> >
> >> diff --git a/builtin/merge.c b/builtin/merge.c
> >> index f178f5a3ee..7e2deea7fb 100644
> >> --- a/builtin/merge.c
> >> +++ b/builtin/merge.c
> >> @@ -88,6 +88,8 @@ static const char *sign_commit;
> >>  static int autostash;
> >>  static int no_verify;
> >>  static char *into_name;
> >> +static struct oid_array conflicted_submodule_oids =3D OID_ARRAY_INIT;
> >> +static struct string_list conflicted_submodule_paths =3D STRING_LIST_=
INIT_DUP;
> >>
> >>  static struct strategy all_strategy[] =3D {
> >>         { "recursive",  NO_TRIVIAL },
> >> @@ -734,6 +736,8 @@ static int try_merge_strategy(const char *strategy=
, struct commit_list *common,
> >>                 }
> >>
> >>                 init_merge_options(&o, the_repository);
> >> +               o.conflicted_submodule_oids =3D &conflicted_submodule_=
oids;
> >> +               o.conflicted_submodule_paths =3D &conflicted_submodule=
_paths;
> >>                 if (!strcmp(strategy, "subtree"))
> >>                         o.subtree_shift =3D "";
> >>
> >> @@ -973,8 +977,25 @@ static int suggest_conflicts(void)
> >>         strbuf_release(&msgbuf);
> >>         fclose(fp);
> >>         repo_rerere(the_repository, allow_rerere_auto);
> >> -       printf(_("Automatic merge failed; "
> >> +       if (conflicted_submodule_oids.nr > 0) {
> >> +               int i;
> >> +               printf(_("Automatic merge failed; recursive merging wi=
th submodules is currently\n"
> >> +                       "not supported. To manually complete the merge=
:\n"));
> >> +               for (i =3D 0; i < conflicted_submodule_oids.nr; i++) {
> >> +                       printf(_(" - go to submodule (%s), and merge c=
ommit %s\n"),
> >> +                               conflicted_submodule_paths.items[i].st=
ring,
> >> +                               oid_to_hex(&conflicted_submodule_oids.=
oid[i]));
> >> +               }
> >> +               printf(_(" - come back to superproject, and `git add")=
);
> >> +               for (i =3D 0; i < conflicted_submodule_paths.nr; i++)
> >> +                       printf(_(" %s"), conflicted_submodule_paths.it=
ems[i].string);
> >> +               printf(_("` to record the above merge \n"
> >> +               " - resolve any other conflicts in the superproject\n"
> >> +               " - commit the resulting index in the superproject\n")=
);
> >> +       } else {
> >> +               printf(_("Automatic merge failed; "
> >>                         "fix conflicts and then commit the result.\n")=
);
> >> +       }
> >>         return 1;
> >>  }
> >
> > This is kind of nice.  I was worried you were going to embed these
> > messages in the merge strategies, which could cause problems for other
> > users of the merge strategies such as the --remerge-diff options to
> > git log and git show (your new messages would be unwanted noise or
> > even cause confusion there), and to the merge-tree work.  In fact, a
> > current submodule-merging message (search for "--cacheinfo") that is
> > potentially similar to what you are adding here but which was added at
> > the merge strategy level already feels highly problematic to me.  I've
> > been considering nuking it from the codebase for some time because of
> > those issues, though I guess just moving it out elsewhere may also
> > work.
> >
>
> Yes, this is the message I copied above. I agree that if we can tweak thi=
s
> advice to instead mention 'git checkout' and add it to the message
> that Calvin is adding in this series, it would make for a really better
> UX.

This message shouldn't be tweaked; it should be expunged.  It does not
belong in the low-level code where it is.  Now, if someone wants to
move the message somewhere else so that it only is displayed when the
working tree and index are updated, and they want to tweak it at the
same time to avoid the ugly suggestion to use low-level plumbing,
that'd be great.  But neither of those things need to hold up Calvin's
series.  (I think you're providing lots of good points of what can be
improved, Philippe, I just want to be clear that I think they are
related but separate improvements.)


> > However, this implementation does have a drawback: these messages
> > won't appear for rebases, cherry-picks, reverts, attempted unstashing
> > (git stash apply/pop), or other actions unless you update the relevant
> > porcelains for those as well.
> >
> > A possible alternative here would be to move it to the level of
> > merge-recursive and merge-ort that is only called when the working
> > tree and index are updated.  For example, placing it in
> > merge_finalize() in merge-recursive.c and merge_switch_to_result() in
> > merge-ort.c -- next to the diff_warn_rename_limit() call in each case.
> > However, I'm also fine with keeping it at the porcelain level, it just
> > may need to be in a function that is called from several porcelains
> > that way.
>
> I think moving it to merge_finalize / merge_switch_to_result is indeed a
> good suggestion, then we might be improving the UX across the board and n=
ot just
> for 'git merge'.
>
> >
> >> diff --git a/merge-ort.c b/merge-ort.c
> >> index 0d3f42592f..c86ee11614 100644
> >> --- a/merge-ort.c
> >> +++ b/merge-ort.c
> >> @@ -3866,8 +3866,13 @@ static void process_entry(struct merge_options =
*opt,
> >>                         const char *reason =3D _("content");
> >>                         if (ci->filemask =3D=3D 6)
> >>                                 reason =3D _("add/add");
> >> -                       if (S_ISGITLINK(merged_file.mode))
> >> +                       if (S_ISGITLINK(merged_file.mode)) {
> >>                                 reason =3D _("submodule");
> >> +                               if (opt->conflicted_submodule_oids && =
opt->conflicted_submodule_paths) {
> >> +                                       oid_array_append(opt->conflict=
ed_submodule_oids, &merged_file.oid);
> >> +                                       string_list_append(opt->confli=
cted_submodule_paths, path);
> >> +                               }
> >> +                       }
> >>                         path_msg(opt, path, 0,
> >>                                  _("CONFLICT (%s): Merge conflict in %=
s"),
> >>                                  reason, path);
> >> diff --git a/merge-recursive.c b/merge-recursive.c
> >> index fd1bbde061..ff7cdbefe9 100644
> >> --- a/merge-recursive.c
> >> +++ b/merge-recursive.c
> >> @@ -3149,8 +3149,13 @@ static int handle_content_merge(struct merge_fi=
le_info *mfi,
> >>         }
> >>
> >>         if (!mfi->clean) {
> >> -               if (S_ISGITLINK(mfi->blob.mode))
> >> +               if (S_ISGITLINK(mfi->blob.mode)) {
> >>                         reason =3D _("submodule");
> >> +                       if (opt->conflicted_submodule_oids && opt->con=
flicted_submodule_paths) {
> >> +                               oid_array_append(opt->conflicted_submo=
dule_oids, &mfi->blob.oid);
> >> +                               string_list_append(opt->conflicted_sub=
module_paths, path);
> >> +                       }
> >> +               }
> >>                 output(opt, 1, _("CONFLICT (%s): Merge conflict in %s"=
),
> >>                                 reason, path);
> >>                 if (ci && !df_conflict_remains)
> >
> > Nice that the changes needed to both the ort and recursive strategies
> > are so localized.  :-)
> >
> >> diff --git a/merge-recursive.h b/merge-recursive.h
> >> index b88000e3c2..5d267e7a43 100644
> >> --- a/merge-recursive.h
> >> +++ b/merge-recursive.h
> >> @@ -51,6 +51,10 @@ struct merge_options {
> >>
> >>         /* internal fields used by the implementation */
> >>         struct merge_options_internal *priv;
> >> +
> >> +       /* fields that hold submodule conflict information */
> >> +       struct oid_array *conflicted_submodule_oids;
> >> +       struct string_list *conflicted_submodule_paths;
> >>  };
> >
> > Make sense.
> >
> >>  void init_merge_options(struct merge_options *opt, struct repository =
*repo);
> >> diff --git a/t/t6437-submodule-merge.sh b/t/t6437-submodule-merge.sh
> >> index 178413c22f..5b384dedc1 100755
> >> --- a/t/t6437-submodule-merge.sh
> >> +++ b/t/t6437-submodule-merge.sh
> >> @@ -141,6 +141,7 @@ test_expect_success 'merging should conflict for n=
on fast-forward' '
> >>                 test_must_fail git merge c 2> actual
> >>           fi &&
> >>          grep $(cat expect) actual > /dev/null &&
> >> +        test_i18ngrep "go to submodule (sub), and merge commit $(git =
-C sub rev-parse sub-b)" actual &&
> >>          git reset --hard)
> >>  '
> >>
>
> In this test, an existing merge does exist, and is suggested to the user =
with [message 2] above.
> So telling users to do a new merge in the submodule is maybe to what we w=
ant.
>
> >> @@ -167,6 +168,7 @@ test_expect_success 'merging should fail for ambig=
uous common parent' '
> >>          fi &&
> >>         grep $(cat expect1) actual > /dev/null &&
> >>         grep $(cat expect2) actual > /dev/null &&
> >> +       test_i18ngrep "go to submodule (sub), and merge commit $(git -=
C sub rev-parse sub-b)" actual &&
> >>         git reset --hard)
> >>  '
>
> Here, 2 existing merges exist, and they are presented to the users with [=
message 3] above.
> So again we might not want to tell users to do a new merge.
>
> >>
> >> @@ -205,7 +207,8 @@ test_expect_success 'merging should fail for chang=
es that are backwards' '
> >>         git commit -a -m "f" &&
> >>
> >>         git checkout -b test-backward e &&
> >> -       test_must_fail git merge f)
> >> +       test_must_fail git merge f >actual &&
> >> +       test_i18ngrep "go to submodule (sub), and merge commit $(git -=
C sub rev-parse sub-a)" actual)
> >
> > test_i18ngrep is apparently on the way out:
> >
> >     $ grep -B 3 ^test_i18ngrep t/test-lib-functions.sh
> >     # Wrapper for grep which used to be used for
> >     # GIT_TEST_GETTEXT_POISON=3Dfalse. Only here as a shim for other
> >     # in-flight changes. Should not be used and will be removed soon.
> >     test_i18ngrep () {
> >
> > I think you just want to use grep instead here for each of these hunks.
> >
>
> Here, one side regresses the submodule commit and the other side advances=
 it.
> In this case, I really think the right resolution is to choose one side o=
r
> the other, and not suggest to do a merge at all. So that means that we mi=
ght
> want to tweak the advice we give based on the type of submodule conflict.=
..
>
> Also, maybe we would want a new test that reproduces exactly the conditio=
ns of
> [message 1], i.e. no existing merge exists in the submodule.
>
> Thanks a lot for wanting to improve the submodule UX!
>
> Cheers,
>
> Philippe.

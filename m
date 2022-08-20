Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7173BC25B08
	for <git@archiver.kernel.org>; Sat, 20 Aug 2022 23:17:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbiHTXRV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Aug 2022 19:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbiHTXRT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Aug 2022 19:17:19 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95DB528E0A
        for <git@vger.kernel.org>; Sat, 20 Aug 2022 16:17:16 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id j1so5776722qvv.8
        for <git@vger.kernel.org>; Sat, 20 Aug 2022 16:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=p/Kqh9msUPUy6jHDpwTICj28OTmQaZr/mYilSFgDdi0=;
        b=bbdVZuRpaaP+oIpL3uJwD94QUOy6KwPTxUu+kqqLDhlbS9U817/1H0yvlavE8RlOEC
         WnCogRv2B9viGrC6cen9RXiEX8LzTyZgjxatHLguey43bWkQhUxRm5A9jAXfKCF3b9GW
         kOzeiuBqbybma/Hj1xqBjgAvZvYrdoIyDog7dnU1UPCMh6CgtVNTnIyH/c+na4CgiA8A
         4QADuz0qGR1x8gISHww6zEaPWxeDbGMjzFe/PCQjwJEG5DeOICb6gdh/BilNMc+a9bE0
         G/uyHsqXz34KU54CWJKeHv0JjUBwi5tyXBVpw/+oStMTmp24zGZjLHP9Ew7568YNZaSV
         MPEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=p/Kqh9msUPUy6jHDpwTICj28OTmQaZr/mYilSFgDdi0=;
        b=CMnfX27N4+NCRyrvtIATB+JbYEybRguLBJBGo42OVrHuezxZScUdDmsX67smal+QN/
         CE0tDr4gSjtL5NaJteYSt/tcdsbZgM6xP7xDzGco36HoecEkGaDekDpXg7ryWOlKt1Wl
         qHE9KXrTgubhGDodqyObl+BBhLjYPZimJtDRcEW6i1s4cDvvLRn4wms5QanCsbSBnSu4
         egfdGL4D/l4jKlxBC+/rFbYYWe1J1ZpGGmmCFlUivnb3vrsJNWZIr1Bh5Xzz9bpnUR9v
         IGRruMaKmiT0dAUFv/W4UMBv2g5ZggYvIbTpMBT5TVeloT85QQ8W8Sfhx6/VdM/2irtz
         mPag==
X-Gm-Message-State: ACgBeo3nsAOjLfGJMCQQylaaRVYA72hKlw/UdmtEOr+VkTchc69qSEGd
        Rb4ggTv9ptT4d5ysCEgrFWoI5wGNFFGctpSAEOMOJp39
X-Google-Smtp-Source: AA6agR7zIvfZ7CIPLpzSBFxqPiafOwq2ObhVgUUvTrcBWVC0hTQhclkkG15jUpM3s3SldXTgZ5Siv1L0wDzxNG0MW2g=
X-Received: by 2002:a05:6214:27e4:b0:476:be6a:91c1 with SMTP id
 jt4-20020a05621427e400b00476be6a91c1mr11038583qvb.39.1661037435369; Sat, 20
 Aug 2022 16:17:15 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1327.git.1660892256.gitgitgadget@gmail.com> <c6eb286b60808bc9e69ce9b09fe4389db15db492.1660892256.git.gitgitgadget@gmail.com>
In-Reply-To: <c6eb286b60808bc9e69ce9b09fe4389db15db492.1660892256.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 20 Aug 2022 16:17:04 -0700
Message-ID: <CABPp-BGPioxH2-2Pde8vAqFOOoW7WvCSf_fLzRWZB3uy=9Xc=g@mail.gmail.com>
Subject: Re: [PATCH 1/3] merge-tree -z: always show the original file name first
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Thu, Aug 18, 2022 at 11:57 PM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> When printing the messages in a machine-readable format (i.e. in `-z`
> mode), the intention is to support third-party software that wants to
> present the conflicts in a "pretty" way to human readers.
>
> To that end, `git merge-tree -z` prefixes the conflict messages by a
> variable-size list of paths and a conflict identifier. This list and
> this identifier are intended to be machine-parseable, the conflict
> message is sort of free-form and not intended to be parsed.
>
> Keeping in mind that the intended use case is to have third-party
> software use `git merge-tree` to perform worktree-less merges and then
> present the conflicts (if any) to human readers, it makes much more
> sense to show the original file names of the involved files instead of
> the ones we internally munged to allow for creating a tree object that
> contains entries for both sides of the conflict (which requires them to
> have different names).

I can see how this would be useful to you if it could be
achieved...well, assuming you replaced "instead of" with "in addition
to".  It'd be a huge undertaking to achieve, though; far beyond what
this series attempts.

I think your attempt here may be based on the presumption that any
hash in a higher stage in the index maps directly to the hash of some
<revision>:<filename> pair from one of the commits being merged.  That
assumption holds in simple cases, but does not hold generally.
merge-ort has a very strong "(at most) 3 stages" assumption for any
conflict, driven by the need to ultimately represent conflicts in the
index, which is pervasive in the code.  Trying to create such a direct
mapping between higher stage conflicts and <revision>:<filename> pairs
from the commits being merged would require breaking that assumption.
That would mean getting rid of many of the hardcoded array sizes of 3,
as well as modifying who knows how many portions of logic built around
this assumption.

Your attempt also seems to be based on the presumption that the
original value of "path" as passed to process_entry(), represents a
path from one of the two sides of history.  In simple cases, it does.
But the assumption does not generally hold.

Further...

> So let's mention the original file names prominently, as first item in
> that variable-size list of paths.

This is in conflict with the needs of other uses of merge-ort:
  * When the user is running an active merge with conflicts written to
the index and working tree, the filenames where the conflicts are
recorded may not match the original filenames, and the filenames where
things are recorded is more useful and thus primary.
  * For remerge-diff, the filename where the conflict would be placed
is important because that's where stuff ends up.  Any changes the user
made for the final merge is relative to that munged path, so that
munged path is the important bit, not the original path.

Adding additional paths to path_msg() to cover other paths relevant to
the conflict make sense, but the primary path really needs to be left
as-is for these other cases.

> Note: For the modify/delete conflict type, we used to mention _only_ the
> munged name in that path list. To allow for tools to read the tree
> object produced by `git merge-tree -z` into a Git index in order to
> resolve the conflicts, it is necessary to list not only the original
> name but _also_ the munged name so that the item with the munged file
> name can be removed from that Git index. Therefore, this patch teaches
> `git merge-tree` to show both the original _and_ the munged name in that
> list.

This makes sense.  Passing additional valid and relevant information
to callers of merge-tree seems beneficial.

> Also note: This patch changes the output of the remerge diff slightly:
> whereas before, we printed the notice about a file/directory conflict
> under the diff header mentioning the munged file name, we now print it
> under a separate diff header that mentions the original file name.
> That is the explanation why t4301 is touched by this patch.

Sounds problematic.

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  merge-ort.c                      | 14 +++++++-------
>  t/t4069-remerge-diff.sh          |  8 ++++----
>  t/t4301-merge-tree-write-tree.sh |  4 ++--
>  3 files changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/merge-ort.c b/merge-ort.c
> index 01f150ef3b5..211f6823e1d 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -3741,6 +3741,7 @@ static void process_entry(struct merge_options *opt,
>                           struct conflict_info *ci,
>                           struct directory_versions *dir_metadata)
>  {
> +       const char *orig_path = path;
>         int df_file_index = 0;
>
>         VERIFY_CI(ci);
> @@ -3787,7 +3788,6 @@ static void process_entry(struct merge_options *opt,
>                  */
>                 struct conflict_info *new_ci;
>                 const char *branch;
> -               const char *old_path = path;
>                 int i;
>
>                 assert(ci->merged.result.mode == S_IFDIR);

This looks like you are trying to make sure you always have the
"original" path available, meaning a path corresponding to a file from
one of the commits being merged.  This doesn't quite accomplish that,
though.  Some questions:

  * What about cases where "path" is a location that exists only in
the merge base?  (rename/rename(1to2) is an example where this will
come up)
  * What about cases where "path" is a location that does not exist
anywhere in history?  (directory renames yield such a result.  e.g.
side A renames olddir/ -> newdir/, and side B adds olddir/foo, then
"path" will be newdir/foo)

> @@ -3838,10 +3838,10 @@ static void process_entry(struct merge_options *opt,
>                 strmap_put(&opt->priv->paths, path, new_ci);
>
>                 path_msg(opt, CONFLICT_FILE_DIRECTORY, 0,
> -                        path, old_path, NULL, NULL,
> +                        orig_path, path, NULL, NULL,
>                          _("CONFLICT (file/directory): directory in the way "
>                            "of %s from %s; moving it to %s instead."),
> -                        old_path, branch, path);
> +                        orig_path, branch, path);
>                 /*
>                  * Zero out the filemask for the old ci.  At this point, ci
> @@ -3921,7 +3921,7 @@ static void process_entry(struct merge_options *opt,
>
>                         if (rename_a && rename_b) {
>                                 path_msg(opt, CONFLICT_DISTINCT_MODES, 0,
> -                                        path, a_path, b_path, NULL,
> +                                        orig_path, a_path, b_path, NULL,
>                                          _("CONFLICT (distinct types): %s had "
>                                            "different types on each side; "
>                                            "renamed both of them so each can "
> @@ -3929,7 +3929,7 @@ static void process_entry(struct merge_options *opt,
>                                          path);
>                         } else {
>                                 path_msg(opt, CONFLICT_DISTINCT_MODES, 0,
> -                                        path, rename_a ? a_path : b_path,
> +                                        orig_path, rename_a ? a_path : b_path,
>                                          NULL, NULL,
>                                          _("CONFLICT (distinct types): %s had "
>                                            "different types on each side; "

I think for both of these last two cases, path == orig_path, so you
haven't actually made an effective change here.

(And, as above, I want path to always be the primary_path passed to
path_msg() as other code was written with that assumption in mind.)

> @@ -4022,7 +4022,7 @@ static void process_entry(struct merge_options *opt,
>                         if (S_ISGITLINK(merged_file.mode))
>                                 reason = _("submodule");
>                         path_msg(opt, CONFLICT_CONTENTS, 0,
> -                                path, NULL, NULL, NULL,
> +                                orig_path, NULL, NULL, NULL,
>                                  _("CONFLICT (%s): Merge conflict in %s"),
>                                  reason, path);
>                 }

Here's another case where path == orig_path, so you haven't made an
effective change.  But this one highlights something interesting...

In addition to the fact that path/orig_path may be a location that
didn't exist on either side of history, there might actually be two
relevant paths from the two different sides of history which are
involved in the content merge, with neither of them being path or
orig_path.  Let me break it down, starting with a simpler two path
case:

If we have a standard rename, e.g. foo -> bar, and both sides modified
the file but did so in a conflicting manner, then we will end up in
this chunk of code.  The conflict info emitted by merge-tree -z which
is always of the form
  <number-of-paths>NUL<path1>NUL<path2>NUL<pathN>NUL<stable-short-type-description>NUL<message>NUL
will in this particular case be
   1<NUL>bar<NUL>Auto-merging<NUL>Auto-merging bar<newline><NUL>
   1<NUL>bar<NUL>CONFLICT (contents)<NUL>CONFLICT (content): Merge
conflict in bar<newline><NUL>
Neither of these messages has any mention of "foo", despite the fact
that "foo" was the name of the file in both the merge base and one
side, and "bar" was only the name of the file on one side.

Now, let's make it more interesting.  side A modifies foo, and renames
olddir/->newdir/.  side B modifies foo in a conflicting manner, and
renames foo->olddir/bar.  Our `merge-tree -z` conflict information
emitted will be of the form
   1<NUL>newdir/bar<NUL>Auto-merging<NUL>Auto-merging newdir/bar<newline><NUL>
   1<NUL>newdir/bar<NUL>CONFLICT (contents)<NUL>CONFLICT (content):
Merge conflict in newdir/bar<newline><NUL>
For this more interesting case, the only files that existed were "foo"
and "olddir/bar", neither of which are mentioned in the conflict info.
The conflict info only reports on "newdir/bar".

And for both of these examples, your patch doesn't change the existing
behavior at all since path == orig_path for this hunk of the patch.

> @@ -4067,7 +4067,7 @@ static void process_entry(struct merge_options *opt,
>                          */
>                 } else {
>                         path_msg(opt, CONFLICT_MODIFY_DELETE, 0,
> -                                path, NULL, NULL, NULL,
> +                                orig_path, path, NULL, NULL,
>                                  _("CONFLICT (modify/delete): %s deleted in %s "
>                                    "and modified in %s.  Version %s of %s left "
>                                    "in tree."),

Adding orig_path here after path would make sense, though it's still
incomplete.  For example if a path was modified and renamed on one
side, and deleted on the other, then we'd get to this hunk, and the
modify/delete would omit information about the other path.  Further,
directory renames could be at play, such that neither orig_path nor
path would correspond to a filename in either of the commits being
merged.

There are also other path_msg() calls that should probably be informed
of additional filenames due to simple renames: CONFLICT_CONTENTS (as
noted above), CONFLICT_BINARY, and INFO_AUTO_MERGING.

Going beyond simple renames, if you want "fully original" filenames,
then we'd probably have to audit nearly all the path_msg() calls for
when directory renames are possible, and modify the directory renaming
code to plumb the original name through to this layer.

And even if we do all that, then we still aren't matching what I think
you are expecting where every conflicted higher order entry we report
maps to a single <revision>:<filename> pairing.  We may have a higher
stage conflict entry that represents merged contents of three
different filecontents from three different filenames.  For example,
if someone has the following setup:

   Commit O: one file named "original"
   Commit A: modify original + rename to primordial
   Commit B: add file named primordial, modify original differently +
rename it to primary

where A & B both have O as a parent or ancestor, and O is the unique
merge base of A & B.  Now if we try to merge A & B, then the index
will have four higher order entries (using <mode> <hash>
<stage-number> <filename>, as we'd see from either `ls-files -u` style
output or from the first part of merge-tree -z output):

    100644 <hash of O:original> 1 original
    100644 <hash of auto-merge of O:original, A:primordial, &
B:primary> 3 primary
    100644 <hash of auto-merge of O:original, A:primordial, &
B:primary> 2 primordial
    100644 <hash of B:primordial> 3 primordial

Note that the two middle entries, despite having one name attached to
them, actually come from a merge of three different files.  Further,
that hash for those two entries will not have yet appeared as the
contents for any blob in any revision of history, and will in fact
represent a file with conflict markers (even if none of the original
files -- O:original, A:primodial, B:primary -- had any conflicts).
And, the version of "primodial" in the merge-result-tree would likely
have nested conflict markers, despite O being a unique merge base
(meaning we get nested conflict markers without merging merge bases).

Trying to have all the conflict output from merge-tree map to some
original file the user had from one of their sides of history is thus
a goal that merge-ort is nowhere close to satisfying.  I'm not even
sure it's tractable.

However, there is a much smaller scoped goal that we could easily
achieve: providing additional filename information in the path_msg()
calls, much like you start to do with the modify/delete case.

> diff --git a/t/t4069-remerge-diff.sh b/t/t4069-remerge-diff.sh
> index 35f94957fce..bc580a242ac 100755
> --- a/t/t4069-remerge-diff.sh
> +++ b/t/t4069-remerge-diff.sh
> @@ -131,11 +131,12 @@ test_expect_success 'setup non-content conflicts' '
>  test_expect_success 'remerge-diff with non-content conflicts' '
>         git log -1 --oneline resolution >tmp &&
>         cat <<-EOF >>tmp &&
> +       diff --git a/file_or_directory b/file_or_directory
> +       remerge CONFLICT (file/directory): directory in the way of file_or_directory from HASH (side1); moving it to file_or_directory~HASH (side1) instead.
>         diff --git a/file_or_directory~HASH (side1) b/wanted_content
>         similarity index 100%
>         rename from file_or_directory~HASH (side1)
>         rename to wanted_content
> -       remerge CONFLICT (file/directory): directory in the way of file_or_directory from HASH (side1); moving it to file_or_directory~HASH (side1) instead.
>         diff --git a/letters b/letters
>         remerge CONFLICT (rename/rename): letters renamed to letters_side1 in HASH (side1) and to letters_side2 in HASH (side2).
>         diff --git a/letters_side2 b/letters_side2
> @@ -168,7 +169,7 @@ test_expect_success 'remerge-diff with non-content conflicts' '
>  test_expect_success 'remerge-diff w/ diff-filter=U: all conflict headers, no diff content' '
>         git log -1 --oneline resolution >tmp &&
>         cat <<-EOF >>tmp &&
> -       diff --git a/file_or_directory~HASH (side1) b/file_or_directory~HASH (side1)
> +       diff --git a/file_or_directory b/file_or_directory
>         remerge CONFLICT (file/directory): directory in the way of file_or_directory from HASH (side1); moving it to file_or_directory~HASH (side1) instead.
>         diff --git a/letters b/letters
>         remerge CONFLICT (rename/rename): letters renamed to letters_side1 in HASH (side1) and to letters_side2 in HASH (side2).
> @@ -184,14 +185,13 @@ test_expect_success 'remerge-diff w/ diff-filter=U: all conflict headers, no dif
>         test_cmp expect actual
>  '
>
> -test_expect_success 'remerge-diff w/ diff-filter=R: relevant file + conflict header' '
> +test_expect_success 'remerge-diff w/ diff-filter=R: relevant file' '
>         git log -1 --oneline resolution >tmp &&
>         cat <<-EOF >>tmp &&
>         diff --git a/file_or_directory~HASH (side1) b/wanted_content
>         similarity index 100%
>         rename from file_or_directory~HASH (side1)
>         rename to wanted_content
> -       remerge CONFLICT (file/directory): directory in the way of file_or_directory from HASH (side1); moving it to file_or_directory~HASH (side1) instead.
>         EOF
>         # We still have some sha1 hashes above; rip them out so test works
>         # with sha256

All of these look like regressions to me; you discussed these in a
separate email so I'll go into detail in response to that one.

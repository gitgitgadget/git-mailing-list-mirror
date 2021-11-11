Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B250FC433EF
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 17:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E4F76112E
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 17:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234370AbhKKSAO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Nov 2021 13:00:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234012AbhKKSAM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Nov 2021 13:00:12 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAAECC061766
        for <git@vger.kernel.org>; Thu, 11 Nov 2021 09:57:22 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id w1so27398439edd.10
        for <git@vger.kernel.org>; Thu, 11 Nov 2021 09:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qoV4chcSrUChhsxbct3p1E7gUhScvO0MZiYGUsNnWaM=;
        b=DQpXMzBHQKx2IXQ0Gg5WoIMKdOTvvecf7a2wq8VTQxlcXf5o8GLkKfZ0ZxviA0YeBg
         z/DET3OWo71vJy5h9Jy4ZE6GgnD1pVUIe7Yps96R6OawFg9fWTPs3l6G77SLgXDvm82h
         SQT5ejsH80GRoSo+rrwPuAS5iuEmKBtspQ5xioL9yk3ibKYorajq+EBwxZ6bDGMailNk
         VMddIZMO1X3jGNROh4uATI+rQK5xS2/DbfoMAdqUe3MbyypBLNXo0Aw9gmvDFkziPLop
         0KHDZ0fQlxgCwQNWjRkMEluNz4mxjD7t3tax1PNBJ6rNSN0Yf7GGkgy4pDalxiUPcLbJ
         zpoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qoV4chcSrUChhsxbct3p1E7gUhScvO0MZiYGUsNnWaM=;
        b=I6z7qTs4DwTcRGJrUahC58km113ToXwbR8OP8fAb7JRjA6gvno3FaqHtf5wfe/aF8v
         Y9ssN4NuhM7kv0fOzJ4IKnOv6EMh8ldGtlKbm/PpDJdOEOJMP3XqUIlJe1oQN7f/jDbL
         +y/3wGg8/h9iJB8+usAimxw5LSWovwGK+bpXB0ko1Ey1aNM1PX6aXlSuPKKsCHrn1zzU
         BmAiNSJmVnPAQN8RmEbJkXUt4z+y6xs7lp9WZQw9PQSJQm2fTEslPamPcZmDbyWWNHc5
         YwRodd5UyY4nMhihd1XEDfT9HFw2ODnjpd96hCpDo0kmLuo0jL8wkTMihCb4RbIs6tao
         KOFg==
X-Gm-Message-State: AOAM533H3/SUSYloEeWSQi6p8/akkc0ElI8+6+rLY/TaM996B05C1XXn
        hmD48gJJWNvfmPh28X++qwaoP6Kqo5WqHNw5W5Wepad+cHk=
X-Google-Smtp-Source: ABdhPJxaSDr6mnBHcdSXA4czEWvoCJA4qXyLsdbuW6jRtK+hISOMpD5LsMRXjcft7jZCL6zo5F7CWOqxUkeC0dFEhMs=
X-Received: by 2002:a17:907:1c9d:: with SMTP id nb29mr12290611ejc.74.1636653440915;
 Thu, 11 Nov 2021 09:57:20 -0800 (PST)
MIME-Version: 1.0
References: <CAPMMpojsNQuHe9iSUGyu_q2M4VObjDPj4c0QrFPsHdYypQ3aog@mail.gmail.com>
In-Reply-To: <CAPMMpojsNQuHe9iSUGyu_q2M4VObjDPj4c0QrFPsHdYypQ3aog@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 11 Nov 2021 09:57:09 -0800
Message-ID: <CABPp-BFAf+-ULwtd7WowsN2KSeJ0s1ucZZ1QSRYg8J+wM9MrZw@mail.gmail.com>
Subject: Re: Unexpected conflict with ort merge strategy?
To:     Tao Klerks <tao@klerks.biz>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry for the late response...

On Tue, Oct 19, 2021 at 3:44 PM Tao Klerks <tao@klerks.biz> wrote:
>
> Hi folks,
>
> I just came across a situation where the ort merge strategy chooses a
> "worse" rename mapping than the recursive strategy - worse in the
> sense of having a lower similarity score, worse in the sense of having
> been a change in another commit (but I guess this is just a limitation
> of git merge? It doesn't look for renames "iteratively" through
> history when merging?), and finally worse in the sense of causing a
> merge conflict that, given the previous two points, is unnecessary and
> does not occur with recursive.
>
>
> I've prepared a reproduction script, attached. It's probably a little
> convoluted because I didn't know exactly what to look out for. This is
> an extreme simplification of a real-life incident:
>
> One file (folder1/firstfile.txt) is deleted independently in two
> branches, and another somewhat-similar file (folder2/secondfile.txt)
> is renamed (to folder2/secondfile_renamed.txt) and slightly modified
> in one of them (in another commit).
>
> When the branch with the rename gets merged in to the branch that just
> had the delete, "ort" sees the rename as having been of
> "folder1/firstfile.txt" to "folder2/secondfile_renamed.txt", despite
> this being of a lower similarity than the real rename that happened,
> and a conflict ensues.

Very interesting case; thanks for passing it along.  I thought Junio
had brought up this case while reviewing patches several months back
and we discussed it, but I can't find it right now.  The short answer
is that yes there's a difference in behavior, but no bug.  I'll
summarize and provide a 'TAKEAWAY' in the final paragraph, but there's
lots of nuance here that probably deserves explaining for the curious.

WARNING: lengthy details follow; skip to final paragraph of the whole
email if you want to skim


So, I'm assuming you're curious about why there's no bug despite a
difference in behavior.  So, let me explain (a) the crux of your
testcase -- what's happening and why, (b) similar-ish cases with
behavioral changes that were explicitly discussed and documented in
the past year (for BOTH merge-ort and merge-recursive), (c) some
similar cases not discussed and documented, and for which the
recursive backend gives a "worse" answer according to what you
suggested "worse" meant, and (d) some warning/advice for folks dealing
with multiple files/directories whose contents are quite similar.

=== (a) what's happening and why ===

In your testcase, you can drop all files other than
  * folder1/firstfile.txt
  * folder2/secondfile.txt
  * folder2/secondfile_renamed.txt
and any commits not touching those files can be dropped.  In simpler
terms, your testcase is:
  * Merge base: Has both folder1/firstfile.txt and folder2/secondfile.txt
  * feature branch: delete folder1/firstfile.txt
  * master branch: delete both folder1/firstfile.txt and
folder2/secondfile.txt, introduce folder2/secondfile_renamed.txt which
is very similar to both deleted files, but more so to the latter
If you're thinking my description of the master branch is funny (as
per your wording, you renamed folder2/secondfile.txt to
folder2/secondfile_renamed.txt), remember that git doesn't track
renames.

So, when git goes to merge, renames between the merge base say there
have been two files deleted and one new one added.  Since
folder2/secondfile.txt was unmodified in the feature branch, any
renames affecting it won't result in three-way content merges anyway,
and thus was removed from rename detection.  That only leaves
folder1/firstfile.txt and folder2/secondfile_renamed.txt left to even
compare, and since it only compares those two, it matches them up as a
rename.  That explains what is happening here, and why.

Note that this particular change came from my "Optimization batch 9"
in merge ort, and was the optimization that I think was more important
than all the others combined.

But some, seeing this case in isolation, might be thinking
"regression", so let's dive into more nuance...


=== (b) similar-ish cases discussed and documented explicitly in the
past year ===

We decided in "Optimization batch 7" to actually relax the "best
match" criteria.  Note that we changed the documentation in commit
07c9a7fcb5 ("gitdiffcore doc: mention new preliminary step for rename
detection", 2021-02-14) to include the following:

'''
So, for example, if a deleted
docs/ext.txt and an added docs/config/ext.txt are similar enough, they
will be marked as a rename and prevent an added docs/ext.md that may
be even more similar to the deleted docs/ext.txt from being considered
as the rename destination in the later step.
'''

This was related to some discussions we had around performance,
including the following statement I made at the time:

'''
We will give up "optimal" matches, but as long as what we provide are
"reasonable" matches I think that should suffice.  I personally
believe "reasonable" at O(N) cost trumps "optimal" at O(N^2).
'''

(It may also be worth noting that the optimization affecting your
testcase, from "batch 9", was one that often provides reasonable
renames at O(0) cost; O(0) is even more of an improvement over O(N^2)
than O(N) is.)

Somewhat interesting here is that this "Optimization batch 7" isn't
just new to merge-ort; it also affects merge-recursive.  So if we
changed your testcase as follows:
  * feature branch: make a small tweak to both folder1/firstfile.txt
and folder2/secondfile.txt
  * master branch: delete both folder1/firstfile.txt and
folder2/secondfile.txt, and introduce newfolder/firstfile.txt that is
more similar to folder2/secondfile.txt
then both merge-ort and merge-recursive today will match up the
folder1/firstfile.txt -> newfolder/firstfile.txt.  (Whereas a year
ago, it would have matched up folder2/secondfile.txt ->
newfolder/firstfile.txt).


But the nuance goes a bit further...

=== (c) some similar cases not discussed and documented, and for which
the recursive backend gives a "worse" answer by your explanation of
"worse" as being that it gives conflicts ===

If you modified your testcase slightly:
  * feature branch: modify folder1/firstfile.txt slightly
and as a reminder, the other branches were:
  * Merge base: Has both folder1/firstfile.txt and folder2/secondfile.txt
  * master branch: delete both folder1/firstfile.txt and
folder2/secondfile.txt, introduce folder2/secondfile_renamed.txt which
is very similar to both deleted files, but more so to the latter

Then merge-recursive will fail with conflicts while merge-ort will
succeed without any.

Is that better?  Worse?  For which backend?  Before you make your
call, let's consider the following slightly different case:
  * Merge base: Has files A & B (very similar, but not exact)
  * feature branch: Modify B, in an area where it differs from A
  * master branch: Copy A to C (while modifying it slightly in the
area it differs from B) in one commit, then delete B in another
commit.

From the point of view of "best matches", we would have "A was left
alone, B is modified slightly on one side and deleted on the other,
and C is a new file" so the result should be "the original A, the new
C from master, and a modify/delete conflict on B".  However,
merge-recursive and merge-ort will instead claim there was a B->C
rename and since they have conflicting content changes in the same
area, fill C with conflict markers from these "unrelated" files that
the user then has to separate.

So, should merge-ort and merge-recursive do copy detection in order to
get the "best" matches?  Practically speaking, doing so means not only
dropping the recent optimizations that sped up rename detection by a
few orders of magnitude, we're actually talking about taking the slow
version of merge-recursive from before this year and slowing it down a
few extra orders of magnitude in order to get copy detection -- making
it overall several orders of magnitude slower than today's merge-ort.

But maybe you still think this is a correctness issue, and performance
is irrelevant.  So let's go a little further in the nuance, so I can
demonstrate that "best matches" actually can give you demonstrably and
laughably wrong results:

=== (d) some warning/advice for folks dealing with multiple files
whose contents are quite similar (or even multiple directories of
files whose contents are quite similar) ===

During the testing of merge-ort, I dug through many repositories and
remerged all existing merges to see which might give different results
with merge-ort vs. Git v2.30's merge-recursive.  I did find some,
though they came from the basename-guided matching change (discussed
in my section (b) above) rather than the unmodified-one-on-side change
(the case you pointed out in your email).  However, every single one
of the examples I found came from an interesting type of situation: it
appears that a number of big projects sometimes make a complete copy
of some directory (a library, a driver, whatever), and keep them both.
Many times this might be to keep one stable, while making
modifications to the other copy to add new features or abilities.
It's also possible that there was an earlier rename involved before we
got the current two names as well.  So, with that in mind here's a
question: what do you do when cherry-picking new features added to an
older version of the code?  If we use your "highest percentage match"
as you mentioned earlier, we'll likely end up applying the
cherry-picked changes to the _stable_ files rather than the new
version, because the copy meant to be stable is more similar to the
older version.  That's likely the wrong target.  But it gets worse...

Some new feature is probably going to touch several files in the
relevant directory, not just one.  That raises the question of where
do the files each match individually?  I saw multiple examples where
the "best" match for individual files left half the files matching the
current stable version of the library/driver/whatever, and the other
half of the files matched against the new version of the
library/driver/whatever.  That means that porting those patches using
merge/cherry-pick/rebase/etc. is going to apply half the patches to
one copy and the other half of the patches to the other copy.  That
just cannot possibly be right.  merge-ort didn't fix this, it
basically just meant it'd sometimes choose a slightly different mix of
application targets, but still split them across the two copies.
Well, technically merge-ort is marginally better here because the
directory-rename-guided-optimizations in merge-ort means that it's
slightly more likely to apply all the changes to one directory than
merge-recursive is.  But only slightly.  So these are situations where
both algorithms are likely to provide results that users will almost
certainly classify as wrong (and maybe even as "extremely wrong").

If your repository is one where each file is pretty unique, then
rename detection seems to be a lot more reasonable and straightforward
to just run automatically.  But if you have multiple near copies of
the same file, and especially if you have multiple near copies of the
same directory, then relying on git's automatic rename detection
without double checking is a bad idea.  Git does a good job during a
merge of printing out which files it has detected as renames and
displaying which files have three-way content merges performed on
them, so I'd recommend looking at those a lot closer if you've got
multiple near copies of the same file or directories.

> Is ort supposed to choose the "best" rename choice, for a given set of
> trees, and failing to do so here? Or is this a case of recursive
> *accidentally* doing a better thing?

As noted above, neither the ort nor recursive strategies promise to
choose the "best" rename (by which I presume you mean closest match);
they both have situations where they'll pick a different one when
there are multiple choices.  Further, as shown above, finding the
optimal rename choice is an ill-posed problem space when dealing with
multiple near-copies of the same files or directories.  I would not
label either recursive's or ort's behavior as "correct" or "better"
for your testcase (nor as "incorrect" or "worse").  As to your last
question, while there have been cases in the past of the recursive
strategy accidentally getting good results in some cases (e.g. due to
serendipitous cancellation of different bugs for certain inputs),
there's no such accident in anything I've discussed here that I've
found; it's all a clear expected result of the algorithms in question.
I hope that this all answers your particular questions, but I think
there's a deeper point here that is important for people to generally
realize for this situation or others like it:


TAKEAWAY: Whenever you are dealing with multiple files or directories
that are near matches, the person doing merges/rebases/whatever really
does need to be responsible to pay close attention to any such
files/directories (and this is not new to merge-ort; it has always
been an issue with merge-recursive as well).

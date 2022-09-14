Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 303BCC6FA86
	for <git@archiver.kernel.org>; Wed, 14 Sep 2022 02:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiINCZN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Sep 2022 22:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiINCZI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2022 22:25:08 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A540558FD
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 19:25:04 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id r20so9506403qtn.12
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 19:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=lIFDtzJAQkvn4bvWXVx/DDF5MFqmwJV9DKAUjEYsKzE=;
        b=oqFLsR2johDOIl0e4Ms0A2XPlbKxbjT1Z0CqF7G0H1HN4h7yF0tn4OReghfzCi/SFm
         hyK2Bs/tWuzi4mzrF4ydwamASicNeWGTiP8vLCvPsXF8B+PP45r0i/1iiHv4QWMvsxfY
         599QeiOjqElUldYVSH5w7e8R3kKEp+NmN9uki2SEsQsuN4K690IF6ZGWKbap1R2gIwnm
         2GtjQ9yvLktdrpVujZIVmHdxpB7IbwwK3zu0fgR++r/GNboFf4eWxfQenhF6x84YovnC
         OUuLFgc9WBdmZfNDnllLLtxZ5aGqbX5XMFtUt2oZzca6Rvrk8TMrgxsGQcTajbJTaS9+
         sh0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=lIFDtzJAQkvn4bvWXVx/DDF5MFqmwJV9DKAUjEYsKzE=;
        b=qxYCOtFqXCsbqZ+eUwCzGZMaUQIOOhUtL4Fi+b3n8qzCOI5mPOpJSR7cxTudpmroyv
         icNZN5ItHD9eLB6/tm5zYK3VMiNhG25FoZW6Mua2GXos35bA/5JNbI/PbBmwkTN09D8v
         gP1b/xfGtozrBoSSYt5RAPEwm8G4tQDLO6352B6Mb6hXkvvA0gNF5VogL92WKEfHZu3B
         h28w5xEbUI2aNl4hta5jL3UA11MavmnAABRrnVZIQ7ca17MM1n5HKShLptfkHZ3K26NT
         GXmXpZx/lcBX6cYfh25zYchhtrkhbS3pzltBgL+r7VTGOJxdDBhWT6JW01vUQlTvmXfw
         Dhgw==
X-Gm-Message-State: ACgBeo2nkvobNGDJcu80zaAhE+qOPf1/IFFytYsphRFEBBEHEqjnBySP
        4HbIFIaT3/H9vUWXcA9VdPPVoOa89gd+TPqOatHxXcxuUyE=
X-Google-Smtp-Source: AA6agR54ffFdsuUvSpEjkmlcVVKIeUmPESH2rV5/M8uJtqPpEjZrkrci4H6PIjhFeBHW5YPEszr05xM2zTVfdKpYqjE=
X-Received: by 2002:ac8:5f09:0:b0:343:67b3:96f5 with SMTP id
 x9-20020ac85f09000000b0034367b396f5mr31354707qta.470.1663122302985; Tue, 13
 Sep 2022 19:25:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAMy9T_EN_Vz=y6R9H03HOh2o+SbENZtxH78HJuS4skQHHYpLVw@mail.gmail.com>
In-Reply-To: <CAMy9T_EN_Vz=y6R9H03HOh2o+SbENZtxH78HJuS4skQHHYpLVw@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 13 Sep 2022 19:24:52 -0700
Message-ID: <CABPp-BHTDpHdpC70YUWT9_E5iz-4HvwfJtwO0T1_VfNzWw48pw@mail.gmail.com>
Subject: Re: Beyond recursive merge
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Michael!

On Sun, Sep 11, 2022 at 9:10 PM Michael Haggerty <mhagger@alum.mit.edu> wro=
te:
>
> Hi!
>
> I haven't been around here lately, but that doesn't mean that I've stoppe=
d thinking about Git :-)
>
> I just published a blog post [1] in which I argue that recursive merge (a=
nd presumably merge-ort, which I think uses the same recursive algorithm)

I had a little trouble finding [1]; it appears to be
https://softwareswirl.blogspot.com/2022/09/beyond-three-way-merge.html
.

merge-ort and merge-recursive are indeed built on the same recursive
algorithm; `ort` even stands for `Ostensibly Recursive's Twin` due to
the intent to copy the high-level "recursive" design (and because I
thought `git merge -sort` looked amusing.)

> sometimes produces very questionable results,

I'll comment more on this later, but...

> and sometimes reports conflicts in cases that I think could be resolved a=
utomatically.
> For example, in the following situation, I argue that the correct merge r=
esult is "e", whereas recursive merge reports a conflict:
>
> ---a-------b---d---e          =E2=86=90 main
>     \       \     / \
>      \       \   /   \
>       \       \ /     \
>        \       =E2=8B=85       ?      =E2=86=90 desired merge commit
>         \     / \     /
>          \   /   \   /
>           \ /     \ /
>            c---c---f          =E2=86=90 branch
>
>
> If you are interested, please check out the blog post. I'll also be hangi=
ng around the Git Merge contributor's summit, in case anybody wants to talk=
 about the subject.

This is very interesting!  From the blog post, the rationale is
basically that the "f" on "branch" was created via a three-way merge
of {a,b,c}->f, therefore, since the virtual merge base also needs to
do a three-way merge of {a,b,c} there is no need to conflict because
that result is known to be f from elsewhere.  That means the outer
merge becomes a three-way merge of {f,f,e} which trivially resolves to
e.  That makes sense to me.

But, I came away from your blog post with a lot of questions, possibly
more than what I started with.  And a few comments...

=3D=3D=3D Questions =3D=3D=3D

1) Your statistics show there are a significant number of cases with
more than 2 merge bases (at least relative to the number of cases with
2 merge bases), but your algorithm is tied to there being exactly 2
merge bases.  You stated this limitation, but didn't state what should
be done for the other cases.  Fall back to a `recursive` merge?  You
did at least mention that you didn't know, wondering aloud whether
such merges could be composed.  But, I'm wondering too now.  :-)

2) You didn't explicitly state that your merge bases themselves need
to have a unique merge base, but it seems to me to be intrinsic to
your description.  What do you do if your merge bases have multiple
merge bases?  Fall back to merging the merge bases?  Find some other
way to make your algorithm recursive?  (And does recursiveness for
your algorithm even make sense given the heavy reliance on
change-then-revert in your problem descriptions?  I started getting
confused just thinking about it...)

3) Your description depended on your graph that you "simplified to the
bare minimum", namely:
---A-------B---D---F          =E2=86=90 main
    \       \     / \
     \       \   /   \
      \       \ /     \
       \       =E2=8B=85       ?      =E2=86=90 desired merge commit
        \     / \     /
         \   /   \   /
          \ /     \ /
           C---E---G          =E2=86=90 branch
I think this graph is actually simplified beyond the bare minimum.  In
particular, your descriptions rely on F and G both being the
cross-branch merge commits *and* being the final commit on their branch.
I think an improved minimum graph would be:
---A-------B---D---F---H          =E2=86=90 main
    \       \     /     \
     \       \   /       \
      \       \ /         \
       \       =E2=8B=85           ?      =E2=86=90 desired merge commit
        \     / \         /
         \   /   \       /
          \ /     \     /
           C---E---G---I          =E2=86=90 branch
Can your ideas be extended to handle these kinds of cases?  Would that
end up with a 9-way merge instead of a 7-way, or would you just fall
back to recursive merges when either F!=3DH or G!=3DI?

4) The above graph is oversimplified in another dimension.  In fact,
it took me a while to determine what {D,F} and {E,G} are for the
generic case.  From reading your post and the arguments, I work out
the following:
  * B and C are the two merge bases for the merge you are trying to resolve=
.
  * A is the unique merge base of B and C.
  * F is the "first" merge commit on "main" which includes C in its
history.  (By "first" I mean none of its ancestors include C).
  * G is the "first" merge commit on "branch" which includes B in its histo=
ry.
  * D is the parent of F which contains B in its history.
  * E is the parent of G which contains C in its history.
  * In my graph, H and I are the final commits on "main" and "branch",
respectively.
  * Other than (D,F) and (E,G), there could be many commits in "main"
and "branch" between any two points on the above graph
  * There are a few places where there could be zero commits between
points on the graph, resulting in any of the following commits being
dropped as redundant: D, E, H, I.
  * If any commits are dropped as redundant, the commit before it on
the same branch serves a second purpose.  (for example, if there is no
D, then B is F's first parent)
Above, you'll note some assumptions:
  * There are exactly 2 merge bases for the merge, namely B&C
  * There is exactly 1 merge base of B & C (namely A)
  * In your graph, you have assumed that H and I are not separate from F & =
G
  * There is a single "first" merge commit on "main" containing C.
  * There is a single "first" merge commit on "branch" containing B.
  * [I think] First parent history of F leads to B, and likewise for G
leading to C.
The first three of these assumptions were addressed previously, as my
first three questions.  The last I'll address in the next item.  For
now, I want to concentrate on the "first" merge commit assumption.
What do you do when there is more than one first merge commit on
either of the branches?  Would you pick one randomly or based on some
criteria (possibly getting different results based on which one you
picked?)  Would you try to merge them together to get a unique first
merge commit?  Would you just bail and use the current recursive
algorithm?

5) Above I mentioned a possible assumption that the first parent history
of F leads to B and likewise G leads to C.  Perhaps that isn't quite
the assumption, but you have drawn {A,B,F} as being part of the "main"
branch, and {A,C,G} as being part of the "branch" branch.  But that
choice seems arbitrary.  What if we instead considered {A,C,F} as part
of "main" and {A,B,G} as part of "branch" (swapping which branches B &
C are considered part of)?  Does your algorithm in some fashion depend
on the order of the parents in the F & G merge commits?  If not, how
is it decided which branch B and C are on?  If the user performed one
of the prior merge commits differently than you expect (perhaps the first
parent history leads to B for both of them), does it negate the
applicability of your algorithm?  Modify your algorithm results?  Or
is there some kind of symmetry that makes this not matter?  Even if
there is some kind of symmetry related to the merges, swapping
which branches include which merge base would lead to different
choices for D & E.  In particular, those commits would be required to
be whichever immediate parent of F or G contained the relevant merge
base in its history. Does changing D & E to accommodate the swap of B
& C change the merge results from your algorithm?  If so, does that
represent some kind of weird ill-posedness or directional dependence
of merge results?

Perhaps an example would help.  Let's use your example from the email
I'm responding to.  That example could either be reduced to
    a---b---d
    |   |   |
    c---=E2=8B=85---e
    |   |   |
    c---f---?
as you did in your blog OR if the merge-bases are discovered slightly
differently it could be reduced to
    a---b---b
    |   |   |
    c---=E2=8B=85---f
    |   |   |
   c---e---?
The former reduction appears resolvable using your earlier trick, but
the latter isn't resolvable because we didn't find the earlier
{a,b,c}->f 3-way merge, meaning I think it would result in a conflict.
Or does your
idea require that we find all previous merge commits in the history of
the two sides since the merge bases, and look carefully at conflict
resolutions involving the parents in each direction?  And do we need
to do this at the individual hunk level for all those merges and parents?

6) You did not address how to write out conflicts to text files in
your blog post.  If using the standard merge.conflictStyle=3Dmerge, then
there's no problem, we can just do the standard showing of the
endpoint differences.  But what about merge.conflictStyle=3Ddiff3?  Your
algorithm attempts to bypass the construction of a unique merge base,
so it's ill-defined what one would even write for diff3.  Would you attempt=
 to
create a merge base in such a case?  (And if you do, is that misleading sin=
ce
that merge-base isn't really part of the algorithm used to determine
how things should be merged?).  Alternatively, would there be a diff7
or diff9 variant only applicable in these special recursive merges
where you are applying your new rules?

7) The focus only on scalars left me wondering whether the algorithm
applied only at the entire-file level, or whether it applied to
individual patch hunks.  I had to re-read it before I caught it ("This
algorithm could be applied one hunk at a time.").  But does that mean
you want to extend xdiff to implement 9-way or even 7-way merges?
Would those even have reasonable hunk regions to investigate, or would
one of the many sides have some slight differences resulting in
unreasonably extended hunk sizes and frequently resulting in complex
9-way conflicts?  Maybe it wouldn't, but I'm more than a little
worried that your attempt to reduce unnecessary conflicts would have
the opposite effect in practice -- not only making conflicts more frequent
but perhaps even more complex too.  In part, this is because it is
known that diff3 will at times have larger context regions than when
only looking at two sides, so 9-way or even 7-way just seems likely to
exacerbate that problem.

8) I am very confused about your usage of "twice" in "But recursive
merge doesn't notice that that conflict has already been resolved by
the user (twice!) in the form of commits f and e".  As far as I can
tell, the {a,b,c} 3-way merge has only been resolved once, with the
result of f.  There was also an {a,d,c} 3-way merge that was resolved
to e, but that's a different merge.  Perhaps you were thinking of "d"
as "b" plus some changes in an area disjoint from what was changed in
c, but that makes no sense given that your blog post explicitly
mentioned you were merging scalars throughout the article.  So, I'm
quite confused about where you get your "twice" from.  Am I missing
something?


=3D=3D=3D Comments =3D=3D=3D

1) Regarding: "Moreover, when a multiple-merge-base merge fails, it
can fail in a most baffling way, with conflict markers nested inside
of other conflict markers, that is almost impossible to make sense out
of."

I don't disagree with this, but I have some comments/questions:

* I'm curious how much of this statement was due to experience from
the time when we didn't adjust the conflict marker length for inner
merges.
* This might be irrelevant to your blog post, but I'm curious if
there's an implicit assumption here that nested conflict markers only
happen when there are multiple merge bases (I've certainly seen other
Git developers assume such).  Nested conflict markers can also happen
with a unique merge base, though those cases are perhaps much more
rare.
* There is a potential way to avoid the nested conflict markers which are d=
ue to
recursive merges: XDL_MERGE_FAVOR_BASE
(https://lore.kernel.org/git/CABPp-BFPaHEUzJsBO1dyv+7DteZfJX=3DQfi2dLaYS5J3=
0VAVAcA@mail.gmail.com/).
I haven't gotten around to cleaning it up and submitting it. Replaying
merges will probably spur me to do so, though.

2) Regarding: "Also check whether there were diff hunks that didn't
conflict, but where users changed the automatic merge resolution"

--remerge-diff may come in handy!

3) Big picture: Much of the blog post seems to conflate recursive
merge issues with 3-way-content merge issues.  In particular, it
focuses on "change-then-revert" cases, which are an area where folks
tend to complain about 3-way-merge behavior.  Enough so that we
documented it specifically in git-merge(1) to point it out:
"""
       With the strategies that use 3-way merge (including the default, ort=
),
       if a change is made on both branches, but later reverted on one of t=
he
       branches, that change will be present in the merged result; some peo=
ple
       find this behavior confusing. It occurs because only the heads and t=
he
       merge base are considered when performing a merge, not the individua=
l
       commits. The merge algorithm therefore considers the reverted change=
 as
       no change at all, and substitutes the changed version instead.
"""
It appears in several cases that you are ultimately just arguing
against this behavior of 3-way merges, but hidden in a way that seems
to attribute it to recursiveness.  Some examples below, but first a
few comments:
* I think your arguments about surprising results often do not apply
to the recursive merge being performed, but to the non-recursive
merges performed previously which are inputs to the recursive merge.
* It's possible that I'm just confused about something with your
arguments, and the above conflation is merely unfortunate.  However,
I'm pretty sure at least one of us is confused by it.  Coming up with
examples that don't involve "change-then-revert" would really help
clear things up.
* I'm reminded of other attempts to "fix" change-then-revert, in a
negative way.  It seems to always be an attempt to say that merging
should depend not only on the end results of the branches we are
merging, but on the particular path by which the user arrived at those
end results.  While ignoring the path by which the user arrived at
their results (an intrinsic "feature" of three-way merges) does have
some downsides, I feel like attempting to pay
attention to that history ends up pushing us into deep complexity with
rough tradeoffs that feel like they'll be worse than the original
problem.  See, for example, [2] for another instance where this came
up.
* If "change-then-revert" really is the core problem you are trying to
solve, I do have a potential idea of interest in this area that I've
never floated before...though it'd be very expensive and would have to
be selected through a non-default option.  (Also, not sure it's
relevant, but I previously thought
about that option mostly in the context of non-recursive merges.)

[2] https://lore.kernel.org/git/CABPp-BF5S6QT6Hn-1wf6w67-ayWfX5WZLZqueNMMeq=
p1jtXirg@mail.gmail.com/


4) I disagree with some of the suggested alternative resolutions or
claims about unexpected results, in part because of the conflation
above.  Let me quote and respond to two examples:

4a)
"""
Change b made then reverted on one branch; kept on the other branch
[...]
    a---b---a       a---b---a
    |   |   |       |   |   |
    b---=E2=8B=85---b   =E2=86=92   b--(b)--b
    |   |   |       |   |   |
    b---b---?       b---b---b
[...]
There are two plausible narratives here:

Maybe change b was implemented then reverted on one branch, but then
it was independently implemented on the other branch, possibly for
another reason. In this case, it would be correct to keep b as the
merge resolution.

Maybe change b was cherry-picked from one branch to the other, then on
one branch it was discovered that the change was bad, so it was
reverted. In that case, one would want the revert back to a to be used
as the merge resolution.
"""

All the above arguments apply to the top part of that graph, whether
you meant to or not:
    a---b---a       a---b---a
    |       |       |       |
    b---=E2=8B=85---b   =E2=86=92   b---.---b
The arguments suggest you perhaps feel that the prior merge was wrong
and should not
have picked b.  If you had argued that, I'd understand, though I'd say
it's somewhat fundamental to 3-way merges[2].  And, actually, we don't
know that the merge algorithm picked b.  We have pluggable merge
backends, after all, and allow user-written ones, even ones not based
on 3-way merge.  The merge backend the user was using for that prior
merge could have
presented a conflict for all we know.  Whether they were presented
with a conflict, the user was given a chance to inspect the result,
run regression and integration tests, put it up for review, and decide
whether to publish it.  So, this result has been blessed by the user.
That merge may have been performed weeks or months ago, but
regardless, it is an input to the merge you are now running.  And I
don't see how to arrive at your conclusion on the current merge case
without treating that user-blessed result as either erroneous or just
outright disregarding it.  As such, I disagree with your claims about
this case.  I would have filed it in the category of cases where
recursive merge succeeds.

There's a further issue with this example as well: I'm curious whether
this example makes your blog less self-consistent.  In particular, the
idea I commented on at the beginning of this email about how previous
merge resolutions could be re-used for the merge base appears useful
here.  Looking at this example from that lens, there was already a
3-way merge of {a,b,b} resolved in favor of b (bottom middle merge
commit).  As such, shouldn't the virtual merge base, which is also an
{a,b,b} 3-way merge be resolved to b?  And shouldn't that result in a
3-way merge of {b,b,b} for the outer merge?  This logic came from your
"The example that motivated this study" section of your blog, and
unless I'm missing something, it appears to be in conflict with your
suggestion that the example here should result in a merge conflict.

4b)
"""
Same change made then reverted on both branches:

a---b---a       a---b---a
|   |   |       |   |   |
b---=E2=8B=85---b   =E2=86=92   b--(b)--b
|   |   |       |   |   |
a---b---?       a---b---b
In this case, arguably since change b was made then reverted on each
of the branches, then the user merges are not needed, and the final
result should be a. An alternative interpretation (which I think is
less persuasive) is that the pre-done merges in both cases favored
contents b over a, so the final result should also favor b. I think
that the result should either be a conflict or a, whereas recursive
merge gives b.
"""

To me, "user merges are not needed" translates to "user-blessed
results are wrong and/or can be ignored".  People inspected, tested, posted=
 for
review, and published those results.  Or at least had every
opportunity to.  So we clearly disagree here.  But I'm perhaps more
surprised by the other statement you made here, where you suggest that
even when the tips of both branches being merged exactly match each
other, that the merge result should cleanly be something else?  I have
a hard time thinking of something that I believe would confuse users
more about merges if this were to be implemented.


=3D=3D=3D Summary =3D=3D=3D

Anyway, among my many questions and few disagreements, it may well be
that I've just misunderstood various points.  Totally possible.
Regardless of whether I did, it was a very interesting read and a new
and refreshing take.  And even despite questions and some
disagreements, I agree that one of your examples seems legitimate and
very interesting.  I'm not sure exactly how or if it translates in
practice, but we'll probably have fun discussing this at the
contributor summit.

See you tomorrow!

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497E2C43334
	for <git@archiver.kernel.org>; Tue, 26 Jul 2022 03:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237558AbiGZDtw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 23:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237516AbiGZDtr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 23:49:47 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6A62A721
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 20:49:42 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id f14so10210194qkm.0
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 20:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MJrt0VIYOocCREMBo/m/lK0ltnI6pN94tkg34uCHl0c=;
        b=G1IqyJK+LhnvI+bJJ1zc9/OnFEQKsFb66azQ5cLgTIM+z68Ok+45GBx+AlSuyvnxjU
         gEv5KQ+Iy7oEx3DBa796OpoDS1OLxX7FXZTJlCr47bIZNApEi+Clm/XGkkCV/AjIzJhg
         YurfVc0zE3IlTMdgq/LUgz19NGA7GITGUMtcUWVXhLZbEYLOOVg5izrCdyooVkd7mG2Z
         d4ERmWylPBPbhlckjTetEFMv8+VqycJlcJ74jgjveop9L8LSG+16LPBsbeOT+q6Dv577
         UTUgvEAMmDtkNT/sRF/6GXoyIyS9daE3VYkX0Ld0nij1H1SQOelrh6IMCIBsD78ARB6L
         bknQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MJrt0VIYOocCREMBo/m/lK0ltnI6pN94tkg34uCHl0c=;
        b=MfKP6hQr8KulS6Q7hkisTmXc/2PNTbZ15b8iQsF1YvZ/xZCKe5lacpPlaBxPo9CUOo
         C2g8IrvKkLU0i+6SPENO4fW54zXHBHXEZkNGZSNPjG2TnTQLAfXi8i7EtrD9wnguwicz
         ZuUbAKPX0b4HeQjn41Zl0l3ZD70zOq/PEnUL8PLv4gBj2/v6KxqLAdmDFA3s6p2gm8Jo
         UEJD2Zs8RhvAyCdG95hhHCQigBAHlQf5gfNlYQTW2YjNkaiXMl9a+AJj5rQJAFVCQjwB
         5CjTUtCXwRSLEraUeaFM6k+nDKMNfHxiIP50GFuY0XBtT/GQL1HAwKkwutvYOyRSZ+u6
         UBRA==
X-Gm-Message-State: AJIora+TyMj0q3nRpf/DoW2mfPR3uhCn4cypRlodkRwFNIaCvpoRRtCe
        9CojxCTUnRGP3w/bm0TvTl6KYvBAg9xgT2gu5/J5j5Pbmksfyg==
X-Google-Smtp-Source: AGRyM1t/90sFOB/3BGche2mdSkT4lgEHdlpXQr14mZlTTVI+4/dfepgsxigiYN7sJwgZfuij95YtRASWFsX7OOFs+vw=
X-Received: by 2002:a05:620a:17a3:b0:6b5:fc1e:40e1 with SMTP id
 ay35-20020a05620a17a300b006b5fc1e40e1mr11257447qkb.227.1658807381333; Mon, 25
 Jul 2022 20:49:41 -0700 (PDT)
MIME-Version: 1.0
References: <bdbe9b7c1123f70c0b4325d778af1df8fea2bb1b.camel@that.guru>
 <220718.86ilnuw8jo.gmgdl@evledraar.gmail.com> <87a692e8vj.fsf@vps.thesusis.net>
 <CAE1pOi1pS76iXU8j=A54wPGHC7qofxrPDAO4uyy0d6yMxeQwvw@mail.gmail.com>
 <6426b5c3-0a09-f641-9876-3534b0abd96d@iee.email> <20220722203642.GD17705@kitsune.suse.cz>
 <CA+P7+xr+k35RXoGv-O96fsfOJ+sg65HrVvt-3JKYAzerA0TJRw@mail.gmail.com>
 <20220723070055.GE17705@kitsune.suse.cz> <CABPp-BEYQOtr6EZmi4emKRKNVXS3071Ud90jiLycdGXGG+YqgQ@mail.gmail.com>
 <CA+P7+xoygnvi8_8JjOSftahKZFC3bZBkzA-LQ8-xAp9fkV79pw@mail.gmail.com>
In-Reply-To: <CA+P7+xoygnvi8_8JjOSftahKZFC3bZBkzA-LQ8-xAp9fkV79pw@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 25 Jul 2022 20:49:30 -0700
Message-ID: <CABPp-BHWueqbFMpz4jMPK9G3xY5=jvWLELLQribU69CYD5DjKw@mail.gmail.com>
Subject: Re: Feature request: provide a persistent IDs on a commit
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
        Philip Oakley <philipoakley@iee.email>,
        Hilco Wijbenga <hilco.wijbenga@gmail.com>,
        Phillip Susi <phill@thesusis.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stephen Finucane <stephen@that.guru>,
        Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 25, 2022 at 2:47 PM Jacob Keller <jacob.keller@gmail.com> wrote=
:
>
> On Sat, Jul 23, 2022 at 10:23 PM Elijah Newren <newren@gmail.com> wrote:
> >
> > On Sat, Jul 23, 2022 at 12:44 AM Michal Such=C3=A1nek <msuchanek@suse.d=
e> wrote:
> > >
> > > On Fri, Jul 22, 2022 at 03:46:22PM -0700, Jacob Keller wrote:
> > > > On Fri, Jul 22, 2022 at 1:42 PM Michal Such=C3=A1nek <msuchanek@sus=
e.de> wrote:
> > > > >
> > > > > On Fri, Jul 22, 2022 at 09:08:56PM +0100, Philip Oakley wrote:
> > [...]
> > > > > > Part of the rename problem is that there can be many different =
routes to
> > > > > > the same result, and often the route used isn't the one 'specif=
ied' by
> > > > > > those who wish a complicated rename process to have happened 't=
heir
> > > > > > way', plus people forget to record what they actually did. Atte=
mpting to
> > > > > > capture what happened still results major gaps in the record.
> > > > >
> > > > > Doesn't git have rebase?
> > > > >
> > > > > It is not required that the rename is captured perfectly every ti=
me so
> > > > > long as it can be amended later.
> > > > >
> > > >
> > > > Rebase is typically reserved only to modify commits which are not y=
et
> > > > "permanent". Once a commit starts being referenced by many others i=
t
> > > > becomes more and more difficult to rebase it. Any rebase effectivel=
y
> > > > creates a new commit.
> > > >
> > > > There are multiple threads discussing renames and handling them in =
git
> > > > in the past which are worth re-reading, including at least
> > > >
> > > > https://public-inbox.org/git/Pine.LNX.4.58.0504141102430.7211@ppc97=
0.osdl.org/
> > > >
> > > > A fuller analysis here too:
> > > > https://public-inbox.org/git/Pine.LNX.4.64.0510221251330.10477@g5.o=
sdl.org/
> > > >
> > > > As mentioned above in this thread, depending on what context you ar=
e
> > > > using, a change to a commit could be many to many: i.e. a commit wh=
ich
> > > > splits into 2, or 3 commits merging into one, or 3 commits splittin=
g
> > > > apart and then becoming 2 commits. When that happens, what "change =
id"
> > > > do you use for each commit?
> > >
> > > Same as commit message and any trailers you might have - they are
> > > preserved, concatenated
> >
> > Exactly how are they concatenated?  Is that a user operation, or
> > something a Git command does automatically?  Which commands and which
> > circumstances?  If users do it, what's the UI for them to discover
> > what the fields are, for them to discover whether such a thing might
> > be needed or beneficial, and the UI for them to change these fields?
> > This sounds like a massive UX/UI issue that I don't have a clue how to
> > tackle (assuming I wanted to).
> >
> > > and can be regenerated.
> >
> > "can be".  But generally won't be even when it should be, right?
> >
> > Committer name/email/date basically don't even exist as far as many
> > Git users are concerned.  They aren't shown in the default log output
> > (which greatly saddens me), and even after attempting to educate users
> > for well over a decade now, I still routinely find developers who are
> > surprised that these things exist.
> >
> > Given that committer name/email/date aren't shown with --pretty=3Dfull
> > but with the lame option name --pretty=3Dfuller, I can't see why it'd
> > make any sense to show Change-Ids in the log output by default.
> >
> > But if it's not shown -- and by default -- then it doesn't exist for
> > many users.  And if it doesn't exist, users aren't going to fix it
> > when they need to.
> >
> > (Even if it were shown by default, it's not clear to me that users
> > would know when to fix it, or how to fix it, or even care to fix it
> > and instead view it as a pedantic requirement being foisted on them.)
> >
> > I think the "many-to-many issue" others have raised in this thread is
> > an important, big, and thorny problem.  I think it has the potential
> > to be a minefield of UX and a steady stream of bug reports.  And
> > seeing proponents of Change-Id just dismissing the issue makes me all
> > the more suspicious of the proposal in the first place.
>
> I do think there is some value in having a sort of generic id like
> change-id, but I do think we want to be careful about how exactly we
> handle it.
>
> As you say, if we hide it then users may not be aware of it, and if we
> make it visible users who don't care may be annoyed. I don't think we
> can fully automate it because of the nature of combining changes and
> splitting changes require humans to decide which change keeps which
> ID. Its not even clear when rebasing whether a split is going to
> happen. A combine operation is easier to detect in rebase
> (fixup/squash), but determining which id to keep is not. Would we even
> want to have support for "this commit merges two and is now one, but
> we keep both IDs because it really is both commits"? That gets messy
> pretty fast.
>
> Users such as gerrit already simply use the trailer with Change-id and
> manage to make it work by enforcing some constraints and assuming
> users will know what to do (because otherwise they fail to interact
> with gerrit servers).
>
> For cases where it helps, I think its very valuable. Being able to
> track revisions of a series or a patch is super useful. Getting
> external tooling like public-inbox, patchworks, etc to use this would
> also be useful. But I think we would want to sort out the situation a
> bit for how and when are they generated, when are they
> replaced/re-generated, how this interacts with mailing etc.
>
> Should rebase just always regenerate? that loses a lot of value. I
> guess squashing could offer users a choice of which to keep? Fixup
> would always keep the same one. And otherwise it becomes up to users
> to know when they need to copy from an old commit or refresh an
> existing commit... Thats pretty much what gerrit does these days, if a
> commit doesn't have the trailer it gets added, and if it does, its up
> to the user to know when to remove it or regenerate it... Since its a
> commit message trailer it gets sent implicitly through the mailing
> list unless removed.

Yes, I fully agree it needs to be spelled out a lot more.  And not
just obvious commands (everyone seems to focus on commit, cherry-pick,
and rebase), but what about e.g. `git merge --squash`?

Also, as far as value goes, I have an interesting story related to
Change-Ids (read the last sentence if you only want the summary):


<long story>

I have used Gerrit fairly heavily.  I maintained an instance for a few
hundred developers for several years (inheriting it from others), and
was responsible for various build & release stuff related to one of
the larger products tracked in it (an approximately
linux-kernel-sized) product.  I also attended a Gerrit conference or
two and submitted a few patches for Gerrit that were accepted.  So,
for context, I'm clearly not a Gerrit developer since I only submitted
a few patches, but I was the clear expert within my company on Gerrit.
So that's my background.

Some background on the (insane) project management of the time
(unrelated to Git or Gerrit or Change-Ids) is also important to
understand this story:  Years ago, this project had well over 100
active branches (!!).  And yes, branches were being aggressively
retired, but I still remember when we finally managed to get the count
under 200.  Each branch had important patches, and hundreds of patches
on these branches was not uncommon.  Yes, it was insane, and yes, I
and many others were really happy when we eventually reached the land
of sanity with just a few active branches (and all but the main one
only gets backport fixes).

One of the things I did to help us move in the direction towards
sanity was a "snowflake report" -- a report that would help people
determine which patches had not already been upstreamed (i.e. not
included in the main development branch of the same repository), and
which still needed to be.  (The terminology for the report was that
unique patches that weren't upstream were "snowflakes" which we were
trying to pick out of a "blizzard of commits").  Anyway, the immediate
impetus for this report was that after enough disasters from
forgetting to upstream important patches, people started asking around
about how to avoid another repeat.  I thought this was a trivial
question to answer at first, but...I was wrong.

Now, as I said before, this product was tracked in Gerrit.  Also,
direct pushing to bypass reviews was disabled (with _very_ rare
exceptions, that essentially didn't affect the quality of the report
mentioned below at all), and Change-Ids were required for all commits
pushed up for code reviews.  So, yes, people had the Gerrit-suggested
hook installed, and yes virtually all commits had Change-Ids.

So, what was implemented to answer "which patches in this branch have
been upstreamed (i.e. included in the main development branch)"?  A
variety of checks.  One of which was fully reliable:

    * "git cherry" to catch the "100% certainty cherry-picks" (only
caught maybe 5% of the upstreamed patches, but still useful).

And a bunch of other checks that were just heuristics:

    * (author name, author email, author date) triples matching
    * commit message exactly matching
    * "(cherry-picked from commit <HASH>)" footers from one commit
referring to another (or there being a transitive chain that wasn't
too long, or there being a transitive tree with a path between the
commits -- think for example of both commits being a cherry-pick of
the same thing)
    * patch-hunk-ids matching (instead of git-patch-id which computes
a patch-id for the overall patch, compute one for each hunk.  Then
look for other commits that have one of their patch hunks match. This
could result in a many-to-many relationship between downstream and
upstream patches)

We generated a report based on this (on a wiki so folks could edit and
add notes), with html links and such.  For each downstream commit, we
added links to all potential upstream commit(s) and included reasons
why each commit was thought to be a potential match.  Further, for any
potential upstream commit that might match (and which wasn't a 100%
certainty pick from "git cherry"), we also looked at which filename(s)
were modified in both commits and reported on the number of matching
and non-matching filename(s) between the pair in addition to the
number of matching and non-matching patch hunks.

Basically, it was a large amount of information to allow humans to
review how similar the commits were to help them determine if the
changes from the commit were already (partially or fully) included
upstream.

I got lots of requests to find as many links as possible, because with
unfortunately frequent regularity, a new report would be created for
some branch and dozens of teams of developers were being forced to
review the reports and sign off on every single patch and whether it
needed to be upstreamed, or even finish being upstreamed (and to do
the upstreaming work if so).  I got a fair number of comments and
questions on the reports as a result.

I'm glad we no longer need this report due to switching to a much more
sane testing/backporting/delivery/branching/etc. story, but years ago
this report was helpful.  Anyway...

A few surprises I found:
  * Patches could be partially upstreamed.  For example, someone
cherry-picked something from a newer version of upstream than their
current branch was based off of, then found and amended important
fixes into that commit.  So although the patch might appear to be
upstream (because the commit messages matched, the author
name/email/dates match, etc.), important fixes in it were not.
  * I was surprised by the number of cases that were not one-to-one
mappings.  One patch might be upstreamed via several patches on the
main branch.  Or parts of several patches may have been upstreamed as
one big combination commit upstream.  I knew theoretically there could
be some like this, and perhaps wasn't too surprised that there would
be at least one, but there were quite a few more than I expected.
  * One of the weirder cases I remember: Someone had created changes
by going into the Gerrit UI, picking an existing but obsolete/closed
code review, editing the code in ways that had absolutely nothing to
do with the original commit they started on (and perhaps on some other
branch?), and left the Change-Id around because it looked valid and
they didn't know what it meant anyway.  (Something about their laptop
being broken and being unable to edit code locally, so they just
edited "in the cloud" and let the automated regression tests verify
their changes; Gerrit either didn't have a way to start a new commit
at the time or the developer didn't find it, so they just edited
something else.)  I knew about it because I found weird pairs of
non-matching things and this developer left a note about it in their
edited commit message just in case anything weird happened.

But let me be more explicit about Change-Ids: we didn't use them at
all.  It came up multiple times as a question, but in my looking into
useful factors, to me they seemed to provide no extra value and I had
found multiple cases where they seemed to be misleading.  The purpose
of the report was to avoid more disasters from forgetting to backport
commits.  This report seems like the kind of thing that Change-Ids
were invented for, and we already had Change-Ids in all commits due to
using Gerrit, but from my exploration I didn't trust the Change-Ids to
provide net-positive value, so I simply didn't use them at all.

</long story>

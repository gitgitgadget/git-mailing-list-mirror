Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25468C433ED
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 21:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4C5E613AA
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 21:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbhDSVwv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 17:52:51 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61489 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbhDSVwv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 17:52:51 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B91F31253E8;
        Mon, 19 Apr 2021 17:52:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=DaSCLfGczfJR
        eraeG2Yi5zsidlk=; b=dLJvp9TRK1w5Qw6cP0XG9lbIhwUod2QJEcm4k1a1R75R
        zx7fp+Hc0K176oldiK/QWQEWLayQvTCPc96alXGjm/lEt2qOW/KmT0ptvmZ0JoMA
        0il4CA08YPKTbq7h31k4cv2IAyo5P1of2xkhXaZV5zQzfNdjy0V4nDzS3JyOn/c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=QzJRqS
        sJgcwtatRCYaEx0C8csM1mx6bWRw1hMG6a1uBa0+tD6oTBRAoDbylDo9OaMVPQjr
        wIxsVDzQp9xvclmEYNSGy8ZdrFKzIM7ECEgBqXvbvJpam2zMgI7MzVTotysQYfxJ
        JwilqYxnk7GnTa93exdqI46mKP37DETwRSJBU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B1C5F1253E7;
        Mon, 19 Apr 2021 17:52:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EF8CA1253E6;
        Mon, 19 Apr 2021 17:52:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Pain points in PRs [was: Re: RFC: Moving git-gui development to
 GitHub]
References: <20191023201310.thzpxyoeb3ta55dc@yadavpratyush.com>
        <CABPp-BEHy8c3raHwf9aFXvXN0smf_WwCcNiYxQBwh7W6An60qQ@mail.gmail.com>
        <86k18rbbyz.fsf@gmail.com>
        <CABPp-BG2SkH0GrRYpHLfp2Wey91ThwQoTgf9UmPa9f5Szn+v3Q@mail.gmail.com>
        <CAGr--=LKBq17XSLpe=uJbEPSfCp5Fpi_uw4d87DgJ8-S4Md0kQ@mail.gmail.com>
        <CABPp-BEcpasV4vBTm0uxQ4Vzm88MQAX-ArDG4e9QU8tEoNsZWw@mail.gmail.com>
        <20210419203327.GV2947267@szeder.dev>
Date:   Mon, 19 Apr 2021 14:52:16 -0700
In-Reply-To: <20210419203327.GV2947267@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message
        of "Mon, 19 Apr 2021 22:33:27 +0200")
Message-ID: <xmqqsg3m7xin.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 82960D42-A159-11EB-8313-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> On Wed, Nov 20, 2019 at 09:13:04AM -0800, Elijah Newren wrote:
>> > On Wed, Oct 30, 2019 at 7:21 AM Elijah Newren <newren@gmail.com> wro=
te:
>> > > Projects which switch to GitHub tend to have overall commit qualit=
y go
>> > > down IMO, because the system (a) makes it nearly impossible to rev=
iew
>> > > commit messages, so people eventually degrade to writing really ba=
d
>> > > ones,
>> > What do you mean here, exactly? In what way is it "nearly impossible=
"
>> > to review commit messages in GH?
>>=20
>> My lengthy rant wasn't good enough for you?  ;-)  Well, I'll try even
>> harder to bore everyone to death, then and extend my rant a bit...
>
> Thank you very much for taking the time and effort to write it up.
>
> It summarized some of my main gripes with PR-based collaboration on
> GitHub with such clarity that I would never been able to achive.
>
> (The recent "Pain points in Git's patch flow" thread reminded me that
> I saved this message and even marked it as important ages ago... but
> haven't gotten around to read it until now.
>
>   https://public-inbox.org/git/YHaIBvl6Mf7ztJB3@google.com/T/
> )

Interesting.

I recently had a similar experience with Gerrit, where a patch I
have seen quite a few times on Gerrit at $WORK had an embarrassing
syntactic issues I did not discover until it hit the public mailing
list.  It may be different from reviewer to reviewer, but at least
to me, e-mailed workflow forces me to apply the patch to my tree
before I can say anything non-trivially intelligent about it and
once applied to the tree, it actually let's me play with the code
(like, say, asking the compiler to give its opinion on it).

The experience I had with Gerrit at $WORK gave me side-to-side diff
with context with arbitrary on-demand width, even with per-word
differences highlighted, and it may be wonderful that I can get all
of these _without_ having to apply the patch myself, but what it
gave me stopped there.  There are a lot more things that need to
happen beyond looking at what changed in the context of the files
during a review, from grepping in the tree for functions and
variables used in the patch to see their uses in other parts of the
system that the patch does not touch, to make various trial merges
to different topics that are in flight, and Gerrit didn't help me an
iota, but still gave me a (false) impression that I _did_ review the
patch fully, when I only have scraped its surface, and the worst
part of the story was that the UI feld so nice that I didn't even
realize that I was doing a lot more shoddy job in reviewing than
what I usually do to e-mailed patches.


>> Reviewing is the process of providing feedback on proposed changes.
>> Code review tools and mechanisms typically provide ways to (a) see
>> proposed changes in isolation and (b) comment on individual lines and
>> preserve context (with the goal of later merging a group of commits
>> that implement something useful).
>>=20
>> git-format-patch and git-send-email combined with usage of email
>> clients that know how to quote previous emails and let you respond
>> inline are a natural way of achieving both (a) and (b).
>>=20
>> GUI tools can, of course, also achieve something similar by showing
>> proposed changes and allowing commenting on individual lines in
>> context.  GitHub fails pretty hard on both counts, particularly for
>> commit messages.  It guides people to an overall diff rather than to
>> the diffs inside individual commits and completely omits all commit
>> messages when you do so.  It does provide a way to access individual
>> commits and their diffs, though it makes it somewhat unnatural.  (It
>> at least isn't as awful as it used to be in years past, when any
>> comments on individual commits were completely lost and separated from
>> the PR.)  And even if you do "go against the grain" to comment on
>> individual commits, there is no provided mechanism for commenting on
>> the commit message itself.  Instead it has to be given as a general
>> comment on the overall set of changes, which then loses the context of
>> what you are commenting on unless you re-include and quote it
>> yourself.  That usually doesn't happen, so when you comment on four
>> commit messages in a review, you have four separate global comments
>> and someone attempting to respond to them doesn't get to see the
>> commit messages next to them, resulting in confusion.  Even if you do
>> re-include and quote the commit message bits you are commenting on,
>> the resulting comment isn't in any way tied to the commit in question
>> in the UI.
>>=20
>> So people who use GitHub for code review just don't bother.   They
>> write non-isolated commits and far from rarely use awful commit
>> messages.  Then they merge this abomination of history, or possibly
>> even worse, they squash merge it all to make it impossible for any
>> future readers to be able to dissect.
>>=20
>> Yeah, yeah, small features so that the review is smaller and easier.
>> That is important, yes, but it still conflates two things and thus
>> ruins reviews.  Each PR should implement something useful.  Commits
>> should be designed both for current and future reviewers to see a
>> clear path towards how that useful thing was implemented.  Sometimes
>> one commit is enough, but conflating the two necessarily either means
>> sometimes creating one-commit PRs that don't actually implement
>> anything useful, or a cognitive overload for code reviewers.  GitHub
>> simultaneously encourages bad behavior (bad commit messages since they
>> are designed to not be reviewable, non-isolated commits, fixup commits
>> that are never properly squashed, etc.) and penalizes good behavior
>> (folks who try to clean up their sequence of commits are met with
>> problems ranging from GitHub screwing up the topological ordering of a
>> linear commit history, to poor ability to see incremental changes
>> whenever rebasing happens, to reckless squash merging of all their
>> careful work into a single commit as something close to an act of war
>> against any future readers who want to dig into why certain changes
>> were made).  Yes, GitHub has gotten much better at code reviews; it's
>> merely abysmally awful these days as opposed to a complete joke as it
>> was in years past.  But it's still so bad that I have seen people try
>> to solve this by having a sequence of PRs per (small) feature they
>> want to implement, even though GitHub provides no way to denote
>> dependencies or ordering between PRs.
>>=20
>> You may think I've gone off on a bunch of tangents, but fundamentally
>> I believe that almost all of these other problems predominantly arise
>> as secondary and tertiary effects of not understanding that commit
>> messages should be a first class citizen of code review.
>>=20
>> Sure, you can claim all you want that it is entirely possible to
>> review commit messages within the GitHub UI and it's just extremely
>> inconvenient, yadda, yadda, but the truth of the matter is that people
>> everywhere struggle to even do code reviews at all, and when they do
>> they all too often turn into rubberstamp exercises or don't delve
>> deeply enough.  In that context, I believe my "nearly impossible"
>> wording is entirely warranted.  Using a tool that simultaneously
>> encourages bad behavior and penalizes good behavior will not so
>> surprisingly yield bad behavior.  GitHub PRs are such a tool, IMO.
>>=20
>> (To be fair, I'll note that GitHub has awesome code browsing, really
>> easy setup and administration of new repositories and organizations,
>> simple and reasonable and thus pretty nice code search, etc., etc.
>> I'm not saying GitHub is a bad tool, I actually think most of it is a
>> very excellent tool; I am just claiming that the PR section of it is
>> very bad.)
>>=20
>>=20
>> Elijah

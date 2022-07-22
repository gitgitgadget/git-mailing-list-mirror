Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 835C7C43334
	for <git@archiver.kernel.org>; Fri, 22 Jul 2022 23:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbiGVXZT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 19:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiGVXZS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 19:25:18 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F9F14037
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 16:25:16 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id g24so4598464qtu.2
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 16:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aJvRu8beo900uflJMRhHQMv9MwPCKqfCf1osMLJsa4k=;
        b=k9EuxW3U+AlrMZ8GPNcxajAxEZvf8eDLDai7ov1jfm/y5WvFgmIWSAVtXhvoL8o7Ps
         BWSFm7OfLyTHDb4yO4CZ6TUM+P2cXUxSZLYzYgzT2kIZpXlY4e3Rezb2YzpSH1R4fWKT
         LpZbsPYU7B0C+YO7KRHk02D+OjaOUgsxQ0YOce6gNs+HasERjztBn1zD4GMy9rn6UC7D
         +lMxphLncanaHr91tg0oG52GHRFdmVy9Qq76jLGTiecVvI34AP+RLHS/dnAPAEjglGRu
         2fqF2/UOy+eyE9CDLzO/FoF3cKTvHxO16vJ5UCWVXiLEmyZSN0+/2H/XydTjwOpLzN9X
         TY7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aJvRu8beo900uflJMRhHQMv9MwPCKqfCf1osMLJsa4k=;
        b=tYk1TlZ2toM76T9DfAydDRXBI2YhisWMOiw3rKEq9WWXUv6Vx/BntL9VyUEIE1dW/4
         /hc0n+rq79EaZ86b41LDFievpgKGnfq8vjwbWHOj3XKtDuQ+iuYgd0LK+Zop6uD9eocm
         w4cmvvIW5lP+2fNNV9rdWpRgl4u86cSA4DGD+zrKFJWBOjSD5XOMZ1e5MaF4FLAkEMfC
         Mbz4yYxlNJbpIyC2Up3irsdmsVsG26ZVgjImjiO2hgNRFirwAUtPf28/xoWG8z1hEESP
         8LkHXoHnUUeHmYGoJPKCDHtClFXl5JtdkVyMqJ56Iy+OugngqdpFV6gMkTYTqENG2SuL
         OVOQ==
X-Gm-Message-State: AJIora9ZBgbMbR3BbvtaSYaxknIGOfBWlMUsr324vtlTBr265eLkez/O
        Ii4j3ocjqtae1NqomzKV+eUSGHSTm0N6bu1sdbz+3riX75o=
X-Google-Smtp-Source: AGRyM1txPGRFza8+Xt9a/ih1MRqQKDhZ0fQpCzzsHVvjxsik4MIt5ogAzPBoz4cdRyPAdD4Dw2VsXzp9MK/leq5hOv8=
X-Received: by 2002:ac8:5c87:0:b0:31f:188e:b1f with SMTP id
 r7-20020ac85c87000000b0031f188e0b1fmr2271866qta.153.1658532315454; Fri, 22
 Jul 2022 16:25:15 -0700 (PDT)
MIME-Version: 1.0
References: <CABPp-BEK+SJh2uF=rrM-f1u9diMQJ7D3H0fJLdzWpyOww=ys+w@mail.gmail.com>
 <xmqqy1wmlbnn.fsf@gitster.g> <CABPp-BEqWX3Nr2HDxwS9d-_QjcKb_jS=fSjsP_Pbutw7-P5gbg@mail.gmail.com>
 <8315230c-f79c-8027-9711-6e21a4bc25c4@github.com>
In-Reply-To: <8315230c-f79c-8027-9711-6e21a4bc25c4@github.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 22 Jul 2022 16:25:04 -0700
Message-ID: <CABPp-BF+8aqysioP_e27Q9kJ02rE2SuSqXu+XphzKWnk5a_Q+A@mail.gmail.com>
Subject: Re: Question: How to find the commits in the ancestry path of seen
 down to _and_ including a given topic?
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 22, 2022 at 4:06 AM Derrick Stolee <derrickstolee@github.com> wrote:
>
> On 7/21/22 3:34 PM, Elijah Newren wrote:
> > On Thu, Jul 21, 2022 at 8:37 AM Junio C Hamano <gitster@pobox.com> wrote:
> >>
> >> Elijah Newren <newren@gmail.com> writes:
> >>
> >>> A simple question that I'm spinning out of [1]: How can I get `git
> >>> log` to show the commits in the ancestry path from seen, back to *and
> >>> including* a given topic (but not commits from unrelated topics)?
> >>
> >> Drawing of a sample history, please.
> >>
> >> I feel stupid asking this, but I do not think I even understand what
> >> the question is X-<.
> >>
> >> Commits that are ancestors of 'seen' and are descendants of the tip
> >> of the topic?
> >
> > What you said *plus* commits from the topic itself.  From this graph:
> >
> >     A---B---C---J---K <-- main
> >             |\       \
> >             | \       N---------------O---P---Q <-- seen
> >             |  \     /               /
> >             |   L---M  <-- topic    /
> >              \                     /
> >               D---E---F---G---H---I  <-- other_topic
> >
> > I want the commits L-Q.  If I run
>
> Here is the thing I misunderstood. "topic" is already in "seen", so
> a seen...topic won't work at all.
>
> This idea is complicated by the fact that you have a concrete idea
> of which commits are in "topic", but you really can't do that without
> a definition of what it's based on. $(git merge-base main topic)
> would get you C, but then there are multiple paths from Q to C that
> don't go through topic.
>
> You can pull out that "first" commit in topic with this:
>
>   git revlist -1 --reverse main..topic
>
> but it only works if topic is a linear branch off of a single point
> in the history of main.
>
> > The closest I seem to be able to get is
> >
> >    git log --ancestry-path topic~${commits_in_topic_minus_one}..seen
> >
> > which includes all commits I want except the first commit of the topic
> > branch.
>
> If you add --boundary, you should get that last commit as you want.

It is nice that there's a way to get at least the commits I want (and
which is more limited than "C..topic"), but unfortunately this adds 16
extraneous commits to the 36 I want:

    $ git log --oneline --ancestry-path --boundary
5b893f7d81~11..ac0248bfba | wc -l
    52

I guess what I really want is something like (made up syntax):

    git log --ancestry-path=${tip_of_topic} main..seen

and have that be translated as listing commits in main..seen which has
$tip_of_topic directly within its ancestry path somewhere along the
line (i.e. either (1) has $tip_of_topic as an ancestor, or (2) has
$tip_of_topic as a descendant, or (3) is $tip_of_topic).  Then I'd get
exactly the 36 commits I want.  It'd be backward compatible too, since
a plain `--ancestry-path` with no stuck argument could just default to
using the bottom commit(s) in the range, as it does now.

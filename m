Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB57C433EF
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 23:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376348AbiDTX5i (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 19:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240926AbiDTX5g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 19:57:36 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85ED3B9
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 16:54:48 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id b11so1200013uaq.2
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 16:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1JOyxjdqYFIMxfJ9CZzBwog20K9k1MxHrAgYNqK//6M=;
        b=a6QsT1kL9IuvOU91CpTPEqsNy5boJdpv/R9ptOv4yUpLV40d+6GM4VoM+JzBLGSnIF
         FJ2qqYns2szZ+CIQ286hEJLUYGzs/xNKAX9dQi2fj6EoAQmNWA2pC8mDbiiw82qNVKm0
         mEZyi9x1pYpBjSAh8ZEvGJtv0ePLkgfXmG8lj2BQG3HqbjMbSsgp9vvEZXhXa+YTAaB0
         YuHgGB68rTHDy/xa9F6NOWW4Bw5HRoOmNK1zksecGDJJb6I2jgOV+xbjaynu+A4nBPjn
         RyjZ7SBkgZlUHs65wWmph2ioDUKmYNp3DYHuCLz1VvJfzVhchQYpA40ru4zOE81j7eyb
         97RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1JOyxjdqYFIMxfJ9CZzBwog20K9k1MxHrAgYNqK//6M=;
        b=Yy9fqjaWKZXqoGNBQY9liEj5yek4oP9ZaVxNrGqU8o0xKCQcWXEPyr2mH2tVXIB2pr
         BjXQsrFfl3wos9v+VLDMcvTQAHJd3TJgsXlGEs+pxJEq7UA8axw+iKvbgHI54s6yFQVR
         wJ5huY009UtMjtAHjTuf58hs/KSS01wwYxWQL4s0oZzVUgBCu+SvIYdRlPh8MAkFwm3z
         cZ15OgtyfB3zH8q2ZjRHpbfikUaEWQ/1V4V8TYNYJJgUYuDoaa2nAlycEgPOpa0L3cJ4
         sKhvfMs9K18lVDnSUAoYCODbcVTWttFre632/HgsUkqIZNpjm3kfKBo3KrucZjxK1Jkg
         +9fA==
X-Gm-Message-State: AOAM530a03XGfUYkN8le3q5pbiB7k2PLKPjOUI6Pz2Y1t9Mp+zGUXIgd
        ONM8LI2JAOII6LBoQPA0kdZjwOHaiE6z/KAI+tE=
X-Google-Smtp-Source: ABdhPJx6Lf3/kG/DrhUw3Dy7fm4wKIbEZ7Y11KQnIH5q3vnBA/uY/2rGmO+vpkoBPIV0w3wD5Ya/GESR7m18cj/YTjw=
X-Received: by 2002:ab0:64c2:0:b0:35d:3e8e:a95b with SMTP id
 j2-20020ab064c2000000b0035d3e8ea95bmr6714558uaq.96.1650498887631; Wed, 20 Apr
 2022 16:54:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAPMMpojjs4sjKdN6DAJFSwERdjq9XQgi35CcqkXu7HijadHa1Q@mail.gmail.com>
 <f87a549f-540e-d0f3-470c-178c2fa141a5@iee.email> <xmqqczhe1jgp.fsf@gitster.g>
 <ba1ea459-5981-5972-36e6-913eb19c34b4@iee.email> <xmqq35iaz6n3.fsf@gitster.g>
 <CANiSa6hEJMWPyfZ_KqgHcKXhMdT7doTnxkK7GZzf-QBh6DhATg@mail.gmail.com> <xmqqsfq8s41v.fsf@gitster.g>
In-Reply-To: <xmqqsfq8s41v.fsf@gitster.g>
From:   Martin von Zweigbergk <martinvonz@gmail.com>
Date:   Wed, 20 Apr 2022 16:54:36 -0700
Message-ID: <CANiSa6iuFkyuc3DfQcSnmXdbHOXgc2HTp3SE9Segd=pV8WVV4Q@mail.gmail.com>
Subject: Re: Current state / standard advice for rebasing merges without
 information loss/re-entry?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philip Oakley <philipoakley@iee.email>,
        Tao Klerks <tao@klerks.biz>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 19, 2022 at 10:43 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Martin von Zweigbergk <martinvonz@gmail.com> writes:
>
> > On Tue, Apr 19, 2022 at 6:57 AM Junio C Hamano <gitster@pobox.com> wrote:
> >>
> >> Philip Oakley <philipoakley@iee.email> writes:
> >>
> >> > So, essentially, it's talking a small part of the rerere-train at each
> >> > step in the replay, so that it's more focussed.
> >>
> >> That reminds me of one topic.
> >
> > And it reminds me of a discussion about first-class conflicts vs
> > rerere I had recently [1] (Philip's email hasn't been delivered to me
> > yet). As I wrote there, I think most of rerere's use cases can be
> > fulfilled by first-class conflicts. I understand that it would be a
> > huge project (much more than appropriate for GSoC :)) to add such
> > support to Git. I just want to make sure the project is aware of the
> > idea.
> >
> > [1] https://github.com/martinvonz/jj/issues/175#issuecomment-1079831788
>
> I saw that before, but neither of these two "use cases" solve a
> problem relevant to what I have to do often.  It may be a case where
> you have a hammer while rerere is a screwdriver, perhaps?  Each is
> useful in its own ways and is good at different applications.

Yes, that's probably true. I understand that there are scenarios that
rerere helps with that first-class conflicts (at least the way I
implemented them) do not.

> Rebuilding of 'seen' multiple times every day may superficially be
> similar to "test merge" case you mention there, but the desired end
> result from keeping multiple topics in master..seen chain, and have
> selected ones (not necessarily in the order in 'master..seen')
> graduate while keeping others and rebuilding 'seen' with them never
> involves artificially linearlized history in the end, and that is an
> explicit goal---to avoid the last-minute rebasing to the upstream,
> which can introduce unnecessary bugs.
>
> When I merge topics from 'seen' to 'next', I first reorder the
> topics so that these topics that are planned to be merged to 'next'
> come directly on top of the tree that matches 'next' in the
> 'master..seen' chain, so that the exact state planned to be in
> 'next' in the next iteration appears in 'seen' and be tested.  The
> merge of these topics to 'next' happens in the next integration
> iteration after this preparatory step passes.  It is the same way
> when topics that have been cooking in 'next' are (first planned to
> and then actually) merged to 'master'.  There is no "final last
> minute" rebase involved.

Thanks for explaining it in such detail. I'm afraid I still don't
understand how it's related to first-class conflicts vs rerere (I've
read the text at least 5 times).

> Another thing that I didn't quite see in your "I see rebase as
> replaying the change between parent and child" is how different
> order of merging is handled.  It often happens that topic A and
> topic B have funny interactions, and the resolution rerere records
> when I first merge topic A to 'seen' and then topic B (at which time
> the conflict we are interested in happens) is later cleanly reused
> if topic B turns out to go first long before topic C graduates.
> When such a reordering happens, topic B will be merged first
> (without causing the conflict between topics A and B), then topic A
> is merged.  Dealing with such a reordering of topics was an explicit
> goal of 'rerere' and it works reasonably well, but it is no clear
> how [1] you cited above handles such a use case.

Good point! That's not a use case I had considered. To make sure I
understand you correctly, the reordering you're talking about is
something like the difference between the following two graphs
(children on top, not on the right).

  N
  |\
  M |
 /| |
X Y Z

  P
 /|
| O
| |\
X Y Z

The problem (for my tool) here is that commit N contains resolutions
for conflicts between X and Z *and* between Y and Z, so when the
merges are done in the opposite order, you'll want to put some of the
conflict resolutions from M in O and some in P. There are commands for
moving changes (including conflict resolutions) between commits, so
you could use that here, but rerere is way smoother since it's
automatic.

> The most importantly, at the philosophical level, in order to allow
> earlier mistakes to be corrected later, Git tries to avoid casting
> heuristic decisions in immutable objects when possible.
>
> Not recording "in this commit, parent and child trees rename path A
> to B, combine some contents of path C and D to create a new path E"
> and instead computing renames when we actually compare these two
> trees, is an example of the application of the philosophy.  It
> allows rename detection heuristics at the runtime to improve over
> time and a commit you made 5 years ago will be shown better with the
> improved rename detection logic.  We do avoid recomputing the same
> information over and over again by having long lived cache data
> structure like commit-graph, but they are left out of the central
> data structure and can be reproducible.
>
> Keeping the rerere database outside the commit object is another
> application of the same philosophy.  There needs a clear way to nuke
> an earlier recorded resolution that was faulty without having to
> rewrite the history, and having it outside the commit object is a
> must, and having database in .git/rr-cache/ is one possible
> implementation to achieve that goal.

I agree with all of that. I guess there's some implication about
first-class conflicts vs rerere here too? Is the concern that if you
leave some conflict unresolved for years, it might be that the tool
now could have actually resolved that conflict instead of marking it
as a conflict in a file? So by not being forced to redo the merge, you
are instead trying to resolve an auto-resolvable conflict. Yes, that
is a problem, but it seems very small. I'm probably missing a more
serious problem.

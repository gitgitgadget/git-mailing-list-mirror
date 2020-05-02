Return-Path: <SRS0=N0vB=6Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F032FC3A5A9
	for <git@archiver.kernel.org>; Sat,  2 May 2020 19:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8B922072E
	for <git@archiver.kernel.org>; Sat,  2 May 2020 19:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MeqQrXyj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbgEBTAu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 May 2020 15:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728450AbgEBTAu (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 2 May 2020 15:00:50 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF80FC061A0C
        for <git@vger.kernel.org>; Sat,  2 May 2020 12:00:49 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id t3so1507920otp.3
        for <git@vger.kernel.org>; Sat, 02 May 2020 12:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6uEcoQeJIFbaq2nswd+jy24t9pzO5pktowUfR6dsrZ4=;
        b=MeqQrXyj+RRv99d3OYDGqEsoY3X1DVVOx6ZRu7OROtdPRImI4wqgejvjD0XnOUTDfh
         zksxqQg2u/sdKk6UKHxgDudqXLS6lnjQSrXizuHhBosiB0FBF9SOBVXFR4oqlFALBUKX
         y+WdanvK932pm4rsKlMOqist+438R1BkRwBhHNtaodJqyYX15H/c3XhyQv1Pq6D81Jv8
         ERdlLM3IDjyVnO752kkfjEqNi4lG1bXomwVAveahNAQ3lgTbj5VevDsi9Nyj8ZwFE0ZG
         dTfGziYuL/RevKI9UR0/Bb9I3Q3jQ6HdaBn3usQ1I3ynlOO8O5TBikJOAy0QXFy3JtRO
         uEnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6uEcoQeJIFbaq2nswd+jy24t9pzO5pktowUfR6dsrZ4=;
        b=TkQIbGlPlm+17BlyfgD0mEM0CAiaCuFr05lnQI6tAKZqLzr3kmzyqoIC/gZ6oTjmN5
         H95i7EdgwBbQ/MUJX+LGyrE2U8ZrJW+LvSnmlAhxMBo2l4oblk3FCL5e0nMN1B4xC5m6
         JI0n1P/ZXX/OP3dvwj4Z6ltgP/hGxF27CuVAYJuFskkDbJv+lVRNDKg5tOOkXkUtOg0Q
         MA65EWoREAqGwqJPndxC3w9oVjZM5b4SU9d/m8QnSfVzydFP9gG5o9OGp0xNJSDbAbPP
         jGdbhbqwKMbkzYUFvzX4QvfyfT8KFA+LeF6G8FbF8fW9hp0jEKFwHslJuO8x5H4OW+j7
         GA8Q==
X-Gm-Message-State: AGi0PuYqtyAlto9wALxWZNYK3PsT5Koh4gG5rdGJ9qwbvHke4E3kX4FY
        gLZuNPnsV1Rcz10gPa70upDT5NUb7GDssfQA1vc=
X-Google-Smtp-Source: APiQypJ6lESB12z/4bl65jmGu9x7oBcxCvOKcfmhZB9klfsAw8ltK1poTQh29YKGL9r1knhjN+BX2LrVpT792g5NIxU=
X-Received: by 2002:a9d:2aa9:: with SMTP id e38mr8495365otb.162.1588446048748;
 Sat, 02 May 2020 12:00:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200429093811.8475-1-shouryashukla.oo@gmail.com>
 <20200429093811.8475-4-shouryashukla.oo@gmail.com> <CABPp-BFt_5-OyOw9YbYJhhu1P4CJLOi65wdyRckOY5_acRejGg@mail.gmail.com>
 <20200502065745.GD5582@konoha>
In-Reply-To: <20200502065745.GD5582@konoha>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 2 May 2020 12:00:36 -0700
Message-ID: <CABPp-BGrsw1V3gUWN40DTRCPBD5ZD5kvoqdjMuEJtJKCni09_w@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] gitfaq: fetching and pulling a repository
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Shourya,

On Fri, May 1, 2020 at 11:57 PM Shourya Shukla
<shouryashukla.oo@gmail.com> wrote:
>
> On 29/04 08:56, Elijah Newren wrote:
> > > +[[fetching-and-pulling]]
> > > +How do I know if I want to do a fetch or a pull?::
> > > +       A fetch brings in the latest changes made upstream (i.e., the
> > > +       remote repository we are working on). This allows us to inspect
> > > +       the changes made upstream and integrate all those changes (if
> > > +       and only if we want to) or only cherry pick certain changes.
> > > +       Fetching does not have any immediate effects on the local
> > > +       repository.
> >
> > Maybe change that last sentence to "Fetching does not modify the
> > current branch"?  The local repository certainly gets bigger, and the
> > remote tracking branches are updated as well as their reflogs, and it
> > might trigger a gc, all of which sound like immediate effects to me.
>
> I meant changes in terms of the user's code. Yep you are right, I need
> to be precise here.
>
> > > +
> > > +       A pull is a wrapper for a fetch and merge. This means that doing
> >
> > ...for a fetch and merge or a fetch and rebase.  This means...
> >
> > > +       a `git pull` will not only fetch the changes made upstream but
> > > +       integrate them as well with our local repository. The merge may
> >
> > ...with our current branch.  The merge or rebase...
> >
> > > +       go smoothly or have merge conflicts depending on the case. A pull
> > > +       does not allow you to review any changes made upstream but rather
> > > +       merge those changes on their own.
> >
> > I don't understand this last sentence.  You can definitely review
> > changes made upstream after a pull; e.g. git log @{u}@{1}..@{u}
>
> I meant that the pull will apply the changes right away and one does not
> get the chance to review what is being applied before it has been
> applied (something a fetch does). I need to be more clear here,
> understood.
>
> > > ++
> > > +This is the reason why it is sometimes advised to fetch the changes
> > > +first and then merge them accordingly because not every change might
> > > +be of utility to the user.
> >
> > I don't understand the purpose of this paragraph.
>
> I intended to emphasise the difference between a fetch and a pull; the
> fact that fetch just brings in the changes from the remote and doesnot
> apply them to our code/files right away, while a pull does so.

So, perhaps we can shorten all three paragraphs to something like the following?

A fetch stores a copy of the latest changes from the remote
repository, without modifying the working tree or current branch.  You
can then at your leisure inspect, merge, rebase on top of, or ignore
the upstream changes.  A pull consists of a fetch followed immediately
by either a merge or rebase.

> Also, a nit but, we are supposed to use 1 SP or 2 SP after a full
> stop(.)? In India we use 1 SP, is it different in other countries?

Ah, the never ending spacing debate...

There may be variation country-to-country, but I doubt it's country
specific.  It's more a raging debate based on the fact that "official"
rules have changed multiple times, old habits die hard, different
contexts exist for different audiences, and various other wrinkles.
("official" needs quotes because it's not clear who the authority on
publishing, writing, or style is.  There are multiple out there.  But
even if you pick a fairly commonly quoted authority, such as the
Chicago manual of style, they've had at least three different rules
for how much space to use after the full stop over time.)

If you use a typesetting program like LaTeX, the amount of space you
use in the source is irrelevant as the target will automatically be
generated with the right amount according to whatever ruleset is in
play (you just need to be careful to specify when periods are used in
abbreviations versus at ends of sentences).  But if you are using a
WYSIWYG document or a plain text document for both generation and
consumption of the information, then some kind of rule is needed.

Fixed width versus proportional fonts also matter.  The two space rule
arose in the age of typewriters, which came about during the era when
larger spaces between sentences was the typesetting rule, and was
translated into a two-space rule.  Many of the one-space rules and
rule changes arose among those assuming everything would be using
variable width fonts[1].  Unless you're crazy[2], source code remains
fixed width and emails on mailing lists like git@vger often are too
(whenever someone sends a table as part of a commit message or just in
discussion, attempting to read it in a proportional font is
impossible; gmail is atrocious and a crime against humanity here but
luckily I can just go over to lore.kernel.org/git to read the emails
in a fixed width font).

There does seem to be emerging consensus among many style guides
(which come from those that just outright assume that variable width
fonts are the only kind that exist anymore) that just one space should
be used, though it appears to be at least partially because one space
is easy for editors to enforce[3]. (Switching from two spaces to one
is a simple search and replace, whereas switching from one space to
two is really hard because you have to know whether a period ends an
abbreviation like "Dr." or ends a sentence.)  The emerging style rules
also exist despite a (recent-ish) study showing that two spaces
slightly aids reading speed[4].

Personally, I still remember using a single space after sentences, and
my dad standing over my shoulder and letting me know that it was WRONG
to do that and that sentences should be followed by two spaces.  25
years later, it's an ingrained habit.  But the fact that I spend most
of my time in an environment that most the style guides presume no
longer exists or is used (namely fixed width fonts, as found with
source code), means that I've got a good argument that the conventions
used back in the days of typewriters are the ones that are actually
correct within my context.  Plus there's actually a scientific study
that just conveniently happens to match my habit, so now I can claim
that I've been right all along these past 25 years; in the end, that's
all that really matters anyway.  ;-)

[1] https://slate.com/technology/2011/01/two-spaces-after-a-period-why-you-should-never-ever-do-it.html
[2] https://twitter.com/rob_pike/status/567476552187641856?lang=en
[3] https://cmosshoptalk.com/2020/03/24/one-space-or-two/
[4] https://link.springer.com/article/10.3758/s13414-018-1527-6

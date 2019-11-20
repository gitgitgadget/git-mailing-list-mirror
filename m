Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6185BC432C0
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 17:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27F50208A3
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 17:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YH1Dy8aE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbfKTRNT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 12:13:19 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:41613 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727754AbfKTRNT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 12:13:19 -0500
Received: by mail-ot1-f46.google.com with SMTP id 94so226893oty.8
        for <git@vger.kernel.org>; Wed, 20 Nov 2019 09:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7z6p1g+I7L07ja4AfCOY+fUarug5d+IW3j6URjGcPcM=;
        b=YH1Dy8aEo4YUVeduVaew83b695X4nT308/iyExGeXqoM9d2g3nTD5zEyKnW+Nyj7ql
         7G8P5X9dKELGIeW0of1qbBIArQDAUQ2W/AZXG8mXLBDX3YINfhVN5FrGodJcDsWpW640
         L/WFD9kQYd/4N66yYzj0YiQMJOGzSwBQfViId53P1Y7s+vIfPeRDL5aCrgfR+A6jqWfZ
         RPnPD9kq0K6yxnRfh181SunlwzC6gou5okzP355wjJ+PhInLoP3HX5/xMgtMq+JW5/kX
         77y8ssLGyu/paZPTr4XyYBGcCGb1fF8+jsYY6YmCIR4WQoesakVCDztMDWMr1gfF93IL
         Kiug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7z6p1g+I7L07ja4AfCOY+fUarug5d+IW3j6URjGcPcM=;
        b=p2UhxdaKBcO/S0Og7dHonWlnkzuIj2R9HPtv8qQFQzBeGoEDxN+cc9o3P3VJ+iQUcm
         Liu4m1pLwxBUb4RC4ONyDinz8oL+jgouDOr9j3xgyVxwtdc+zxhysYOgMfZdTah/eFMY
         o/2OsOnj0Po2OONdeEoRklGhwquZwOThNLSzPqT9yax6qos5jjlELZ2o6jJbhVvQm9fZ
         bcM36kJ0EG2v0LYQnpUB9/hZKygmrqdeKaUAkc7fZU2L0KjVzBIi5Yvey1IzDPHDDFbZ
         mvyZ+/vdbK8nCv+yyZ7CUS3HzqaEn08G4bGNJ/PrOo80ti1+iSkk78MDA3DybnCO0TNM
         +etg==
X-Gm-Message-State: APjAAAWfPMKjrAngBd6DSkTu1hTkk3dPBdlrUTMQliuA5ANbOhM2bSZz
        kJdITd8OHK2fi0AKXID5k38sHqWJ696f0C+LFGM=
X-Google-Smtp-Source: APXvYqz0XhZCHSXhdoRegqc6/XD/IHikSdYR9KkBsraMPtVnFk9stPg0RGE0yjBCpW+yhPVkfIl/2BptfAgXFlm0MK8=
X-Received: by 2002:a9d:6285:: with SMTP id x5mr2906070otk.267.1574269996070;
 Wed, 20 Nov 2019 09:13:16 -0800 (PST)
MIME-Version: 1.0
References: <20191023201310.thzpxyoeb3ta55dc@yadavpratyush.com>
 <CABPp-BEHy8c3raHwf9aFXvXN0smf_WwCcNiYxQBwh7W6An60qQ@mail.gmail.com>
 <86k18rbbyz.fsf@gmail.com> <CABPp-BG2SkH0GrRYpHLfp2Wey91ThwQoTgf9UmPa9f5Szn+v3Q@mail.gmail.com>
 <CAGr--=LKBq17XSLpe=uJbEPSfCp5Fpi_uw4d87DgJ8-S4Md0kQ@mail.gmail.com>
In-Reply-To: <CAGr--=LKBq17XSLpe=uJbEPSfCp5Fpi_uw4d87DgJ8-S4Md0kQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 20 Nov 2019 09:13:04 -0800
Message-ID: <CABPp-BEcpasV4vBTm0uxQ4Vzm88MQAX-ArDG4e9QU8tEoNsZWw@mail.gmail.com>
Subject: Re: RFC: Moving git-gui development to GitHub
To:     Birger Skogeng Pedersen <birger.sp@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 20, 2019 at 4:20 AM Birger Skogeng Pedersen
<birger.sp@gmail.com> wrote:
>
> Hei Elijah,
>
> On Wed, Oct 30, 2019 at 7:21 AM Elijah Newren <newren@gmail.com> wrote:
> > Projects which switch to GitHub tend to have overall commit quality go
> > down IMO, because the system (a) makes it nearly impossible to review
> > commit messages, so people eventually degrade to writing really bad
> > ones,
> What do you mean here, exactly? In what way is it "nearly impossible"
> to review commit messages in GH?

My lengthy rant wasn't good enough for you?  ;-)  Well, I'll try even
harder to bore everyone to death, then and extend my rant a bit...


Reviewing is the process of providing feedback on proposed changes.
Code review tools and mechanisms typically provide ways to (a) see
proposed changes in isolation and (b) comment on individual lines and
preserve context (with the goal of later merging a group of commits
that implement something useful).

git-format-patch and git-send-email combined with usage of email
clients that know how to quote previous emails and let you respond
inline are a natural way of achieving both (a) and (b).

GUI tools can, of course, also achieve something similar by showing
proposed changes and allowing commenting on individual lines in
context.  GitHub fails pretty hard on both counts, particularly for
commit messages.  It guides people to an overall diff rather than to
the diffs inside individual commits and completely omits all commit
messages when you do so.  It does provide a way to access individual
commits and their diffs, though it makes it somewhat unnatural.  (It
at least isn't as awful as it used to be in years past, when any
comments on individual commits were completely lost and separated from
the PR.)  And even if you do "go against the grain" to comment on
individual commits, there is no provided mechanism for commenting on
the commit message itself.  Instead it has to be given as a general
comment on the overall set of changes, which then loses the context of
what you are commenting on unless you re-include and quote it
yourself.  That usually doesn't happen, so when you comment on four
commit messages in a review, you have four separate global comments
and someone attempting to respond to them doesn't get to see the
commit messages next to them, resulting in confusion.  Even if you do
re-include and quote the commit message bits you are commenting on,
the resulting comment isn't in any way tied to the commit in question
in the UI.

So people who use GitHub for code review just don't bother.   They
write non-isolated commits and far from rarely use awful commit
messages.  Then they merge this abomination of history, or possibly
even worse, they squash merge it all to make it impossible for any
future readers to be able to dissect.

Yeah, yeah, small features so that the review is smaller and easier.
That is important, yes, but it still conflates two things and thus
ruins reviews.  Each PR should implement something useful.  Commits
should be designed both for current and future reviewers to see a
clear path towards how that useful thing was implemented.  Sometimes
one commit is enough, but conflating the two necessarily either means
sometimes creating one-commit PRs that don't actually implement
anything useful, or a cognitive overload for code reviewers.  GitHub
simultaneously encourages bad behavior (bad commit messages since they
are designed to not be reviewable, non-isolated commits, fixup commits
that are never properly squashed, etc.) and penalizes good behavior
(folks who try to clean up their sequence of commits are met with
problems ranging from GitHub screwing up the topological ordering of a
linear commit history, to poor ability to see incremental changes
whenever rebasing happens, to reckless squash merging of all their
careful work into a single commit as something close to an act of war
against any future readers who want to dig into why certain changes
were made).  Yes, GitHub has gotten much better at code reviews; it's
merely abysmally awful these days as opposed to a complete joke as it
was in years past.  But it's still so bad that I have seen people try
to solve this by having a sequence of PRs per (small) feature they
want to implement, even though GitHub provides no way to denote
dependencies or ordering between PRs.

You may think I've gone off on a bunch of tangents, but fundamentally
I believe that almost all of these other problems predominantly arise
as secondary and tertiary effects of not understanding that commit
messages should be a first class citizen of code review.

Sure, you can claim all you want that it is entirely possible to
review commit messages within the GitHub UI and it's just extremely
inconvenient, yadda, yadda, but the truth of the matter is that people
everywhere struggle to even do code reviews at all, and when they do
they all too often turn into rubberstamp exercises or don't delve
deeply enough.  In that context, I believe my "nearly impossible"
wording is entirely warranted.  Using a tool that simultaneously
encourages bad behavior and penalizes good behavior will not so
surprisingly yield bad behavior.  GitHub PRs are such a tool, IMO.

(To be fair, I'll note that GitHub has awesome code browsing, really
easy setup and administration of new repositories and organizations,
simple and reasonable and thus pretty nice code search, etc., etc.
I'm not saying GitHub is a bad tool, I actually think most of it is a
very excellent tool; I am just claiming that the PR section of it is
very bad.)


Elijah

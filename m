Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37D0C43611
	for <git@archiver.kernel.org>; Wed, 12 May 2021 23:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9657E613F6
	for <git@archiver.kernel.org>; Wed, 12 May 2021 23:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238784AbhELXZ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 19:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444104AbhELWx6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 18:53:58 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A55C061574
        for <git@vger.kernel.org>; Wed, 12 May 2021 15:52:48 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id d24so13388804ios.2
        for <git@vger.kernel.org>; Wed, 12 May 2021 15:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6WD5bMJzIlCXkedpR4j5ZgZdD3FyxULc20lDj0e8RHk=;
        b=X58kPx0bdDfYolodtzwwyodWGbmaGZzUE2WyGq2MVk3xvbletV4VwC9aoAyVqORHLP
         pXX7hKrwHvhksHiSyPuRdSpQk6Mk1bHj4xzxC9HPIh+5YhaE6pXGP53mu003wfkzHtjq
         tEr5xS7N59zDRq60lxx/nr5yUdBoedZptKgiNbNSx3Lj403nsnEZkaY1iPURCe/K9v/e
         tmqGslIzIBvf3iy79mn5OZim/KMgJZB6rFLoEjXdSsvPmwV4rW8I3iliIQ9b7m6tgW9K
         iyJzPYfWjnrwjUmvgZu2N2hDheIy7Reu470s6LWt9m1P3SouDjDyJD2vhpxfmPorDknI
         6rHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6WD5bMJzIlCXkedpR4j5ZgZdD3FyxULc20lDj0e8RHk=;
        b=IGhanSn3pawz5nrf3/IXTE3lVjvm56L5sPRg6ceVF6SjpJ5hpVPjMcbczviZdTRnjL
         ysSqBpjV2NKzqxPyrZegyIDMEGIvSmJ5rsGOpJ78jdFa/qFLARG8KJ0lCR9Yn1B6e+7f
         yLZciHhJP9UPbTxTlfJ42Qv4ZMXdlrePRjoeXMveJK2OHOGTRsSYaBcXJsoBfqmLRHqb
         5Ace/bzmyQ1vwpZfBhs1Mj/sluhgqa+6man7E1B8kcOhbTDX4XPXRiupyAtLcPHVPJ83
         2R+GCf0Na6peWx558NZm+h9gtFAk7OV6sLPSllVy5qyP42Ey7Ero3i/37BYeIActQJVG
         R+PA==
X-Gm-Message-State: AOAM530ix0zewrGJAFVoDzgM8ILBwMpUMay3CcLBCwpWjj+VPpX1M0CZ
        oIvYJkG16mQte0St3COgZKeiicpmoT9JBDbB+nEDlIKReIwq7A==
X-Google-Smtp-Source: ABdhPJx5aW5M8a9m1jyC58wwLLHazsN5lqyp25V/GdvVpphn1/w3grSGTGjOr4Ck37yi+K9e+xUh1n5lT8GWmltJ8yQ=
X-Received: by 2002:a02:bb0d:: with SMTP id y13mr34722575jan.124.1620859968355;
 Wed, 12 May 2021 15:52:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210406092440.GZ6564@kitsune.suse.cz> <CAD2i4DDr3Ftk6RE8cA74iSsJTpC9nEb=Cqvr79pF51BpcWEnsA@mail.gmail.com>
 <609ae224aa509_6064920851@natae.notmuch> <20210511202502.GM12700@kitsune.suse.cz>
 <CAD2i4DALKgw2wG6QGs-oQhAHnS3AG1j1BSq2bxjPojVOtw+WjA@mail.gmail.com>
 <609b4eea1088a_678ff208ba@natae.notmuch> <20210512040926.GN12700@kitsune.suse.cz>
 <609b63e48fd49_6d7da2086@natae.notmuch> <20210512064733.GP12700@kitsune.suse.cz>
 <CAD2i4DBF3Tvf62Zyh0XnNH=5ifTD2QQNL5Fx01UHMzoTn3OMVw@mail.gmail.com> <20210512170153.GE8544@kitsune.suse.cz>
In-Reply-To: <20210512170153.GE8544@kitsune.suse.cz>
From:   Varun Varada <varuncvarada@gmail.com>
Date:   Wed, 12 May 2021 17:52:37 -0500
Message-ID: <CAD2i4DB0Zt1snCS_iHZrRJ-woeY5eS-WpWpfdvWo2f5Mk5AY1w@mail.gmail.com>
Subject: Re: [PATCH] doc: replace jargon word "impact" with "effect"/"affect"
To:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 12 May 2021 at 12:01, Michal Such=C3=A1nek <msuchanek@suse.de> wrot=
e:
>
> On Wed, May 12, 2021 at 11:47:15AM -0500, Varun Varada wrote:
> > On Wed, 12 May 2021 at 01:47, Michal Such=C3=A1nek <msuchanek@suse.de> =
wrote:
> > >
> > > On Wed, May 12, 2021 at 12:13:08AM -0500, Felipe Contreras wrote:
> > > > Michal Such=C3=A1nek wrote:
> > > > > On Tue, May 11, 2021 at 10:43:38PM -0500, Felipe Contreras wrote:
> > > > > > It is a paradox called "the bikeshedding effect". When you cont=
ribute a
> > > > > > complex and convoluted change it's easier to get it in because =
few people
> > > > > > can object (as few people can understand it). But when you cont=
ribute a
> > > > > > change as simple as changing the color of something, then *ever=
yone* can
> > > > > > opine (literally).
> > > > >
> > > > > You forget that what you are doing right now is bikeshedding afte=
r the
> > > > > fact.
> > > >
> > > > Except that's not what I'm doing.
> > > >
> > > > > You can use 'affect' or 'impact' and it generally conveys the sam=
e
> > > > > meaning.
> > > >
> > > > That's clearly *your* opinion, but that's not my opinon.
> > > >
> > > > I'm not arguing between blue and red; I'm arguing between water-bas=
ed and
> > > > lead-based paint.
> > >
> > > No, you are not. There is no clear problem with 'impact', either.
> > >
> > > So if somebody comes along later and says that they find 'affect'
> > > confusing and impact should be used does that need to be accepted as
> > > well, back and forth ad nauseam?
> >
> > This is whataboutism and hypothetical. But even if one were to
> > disregard those facts, I'm willing to bet actual money that no one (at
> > least anyone with access to a dictionary or even a basic grasp of the
> > English language) would do this because "affect" has a universal
> > definition and is not in the realm of jargon in any dictionary or
> > style guide. The same cannot be said about "impact".
> >
> > >
> > > > The difference may not matter to you, but it matters to me.
> > > >
> > > > If it's bikeshedding to you, and it "gnerally conveys the same mean=
ing",
> > > > why are you arguing against?
> > >
> > > So if 'for' loops and 'while' loops generally convey the same meaning
> > > should we accept patches that replace some 'for' loops with 'while'
> > > lopps or vice versa?
> > >
> > > Surely not. There are different situations in which loops can be used=
,
> > > and different people find 'for' and 'while' loops clearer and and eas=
ier
> > > to understand in different situations. If you rewrite the piece of co=
de
> > > that includes a loop it might be worthwhile to change the loop type f=
or
> > > clarity, and at the time when the code is added or modified it is tim=
e
> > > to discuss which one is better, not after.
> > >
> > > On the other hand if you state the goal to not have redundant semicol=
ons
> > > then even if code with and without redundant semicolons is the same a=
nd
> > > in most cases it does not make any difference for human understanding
> > > either patches that just remove redundant semicolons work towards a
> > > specific goal. That makes them acceptable even if they are very minor
> > > because there is clear metric they improve which makes the inverse pa=
tch
> > > not acceptable.
> > >
> > > If you want to make the case for 'impact' in general being obscure or
> > > hard to understand you will have hard time doing so. There are
> > > dictionaries that recognize 'impact' as synonymous to 'affect' withou=
t
> > > any difference in degree. In the COCA corpus there is around 200k
> > > instances of 'effect', around 100k instances of 'affect', and around
> > > 100k instances of 'impact' which makes effect/affect about 3 times mo=
re
> > > frequent than 'impact'. That's not even an order of magnitude - clear=
ly
> > > not enough to claim it obscure. All of the words are within first 1k =
so
> > > arguably if you have intermediate knowledge of (US) English you shoul=
d
> > > be familiar with all three.
> > >
> > > However, there is a different corpus that is much more relevant for t=
he
> > > git project:
> > >
> > > =E2=9C=94 ~/git [master|=E2=80=A69]
> > > 06:35 $ git grep affect | wc -l
> > > 368
> > > =E2=9C=94 ~/git [master|=E2=80=A69]
> > > 06:41 $ git grep effect | wc -l
> > > 350
> > > =E2=9C=94 ~/git [master|=E2=80=A69]
> > > 06:42 $ git grep impact | wc -l
> > > 54
> > >
> > > There are only 54 instances of the word 'impact' in the git repositor=
y
> > > which make up only 7.5%. It is feasible to eliminate those 54 instanc=
es
> > > completely. In doing so you will make the git project use the same
> > > wording consistently which makes it arguably more approachable to
> > > non-native speakers with limited vocabulary. That states a clear metr=
ic
> > > that is improved by such patch which also makes the reverse patch not
> > > acceptable and prevents potential for infinite back-and-forth changin=
g
> > > from one synonym to the other.
> > >
> > > Bonus points if you add a test that prevents adding new instances of
> > > 'impact' in the future.
> >
> > So you're saying you're OK with getting rid of all instances of
> > "impact"? I'm for this, but insofar as I searched the code base, I
> > only found the ones I'm changing in my patch (save for a couple that,
> > as a previous reviewer mentioned, are included from other repos, so I
> > left those).
>
> Yes, I am not opposed to the change in principle. You just failed to
> provide any valid reason.
>
> Part of writing a patch is coming up with sound reasoning why the change
> is desirable and stating that clearly in the commit message.
>
> I don't know if this reasoning is acceptable to git maintainers but at
> least there is some real data it is based on.

It's useful to think of this commit via these perspectives:
1. Do you think "affect" and "impact" are synonymous? Fine; this
change doesn't affect (no pun intended) you.
2. Do you think "impact" is incorrectly used here? Great, because
that's what the commit is for.
3. Do you think neither of the above are relevant, but want to get rid
of the word "impact" completely from the Git repository specifically
because of its relatively seldom use? That's great as well, since this
commit conveniently also addresses all instances of the word within
the code base that are stable/controlled by the Git repo (i.e., not
directly imported from other code bases).

The advantage, fortunately, is that you can like any or all of these
reasons, and we don't have to agree on which ones are the most
important or relevant. The end result is the same: a less ambiguous
code base that makes everyone happy.

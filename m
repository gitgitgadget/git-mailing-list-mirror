Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE88C433DF
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 07:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73D7921924
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 07:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3OVUNdN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgFRHOG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Jun 2020 03:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbgFRHOF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jun 2020 03:14:05 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89AE9C06174E
        for <git@vger.kernel.org>; Thu, 18 Jun 2020 00:14:05 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id g7so3721759oti.13
        for <git@vger.kernel.org>; Thu, 18 Jun 2020 00:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yucPwN+byLnxc+7ID+Ii2h7QVC1DDkgl/VvdAyenbh8=;
        b=b3OVUNdNBAYOBxlUw21noFEqQldtjV2eitfcxKh35Q/fUEkaoXfDCNriv/+5bn/FsF
         dDV+GTIfWK0NoTNfAS90x/PgOGjHn7nWhxd3/ocJaK6OM9/Vvqs42Jaf7izqKojhSts8
         McbZdEaQlp662dOVTE6iSca9uUw53jKHlN+MU1MVlWQz+x5oJ1yXHqzWpIeyWuTeO6Bd
         iRakdRbQOphHSDWDr9n8XmQ57DrZf4vFyC5mJLjPZYlZ2d57KuTNeQ34jhn8/70apG9G
         J62Uq4rUrE7WLGLm0+BziQUtAzYXcI0YEZIGhHPo43EuNhHlwQiWM6OtZFEn98oJS1t+
         54pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yucPwN+byLnxc+7ID+Ii2h7QVC1DDkgl/VvdAyenbh8=;
        b=PAkkH7W8RbuKirlN3REjjma5rKYQ2zLnNHUjYyxZRSFjDeFCEki2nKCwRaG+0lvr2n
         P7lBGNgD+sbLvHY6ayNaAPNlZcmIOKEWDe0G+pswe0ykhdGDZVbaGEo1+OXr/X+CHLZd
         LEKQRzMwngBwWLd1h6CGEooQvEagu+q793LPXxfZ5dF//Veg2HZFSW1tOY4ZmxSZ8ON5
         Vh8oi0pGbpw7is9yEL2NpBidJMpsVZTD5N3NL955z+ZspQjruYuKuK4w0zUahRAJ5+5t
         zWtx3vDnE7oRtN4Ib+XxNtwfrTpaj7qLzRKByA2guL+HmiBaBsZsCZOrR8O3pyech+L0
         iZnA==
X-Gm-Message-State: AOAM532Dt4mtQVDA8kqIAdqbAHyrBCMdMN9mgWsuWpZLnU8g4MFi3BHZ
        Vej3mT2HEZTMhg07CoRomLPOISwdQD03H7UFi4Q=
X-Google-Smtp-Source: ABdhPJwkUrdx2uHdr7+Tp4mxKqbHYNvSiFq1BJRN/2ZQDK/3G5Yhf8OKLB/WIMLziFGMiJxtC7E9UyHriotM+pcOVkY=
X-Received: by 2002:a9d:7606:: with SMTP id k6mr2385884otl.316.1592464444753;
 Thu, 18 Jun 2020 00:14:04 -0700 (PDT)
MIME-Version: 1.0
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
 <pull.656.v2.git.1592225416.gitgitgadget@gmail.com> <ebd10f73cd73a8fca84d1862e5a4b7b62a549bcd.1592225416.git.gitgitgadget@gmail.com>
 <20200616125833.GE666057@coredump.intra.peff.net> <xmqqmu51v9qy.fsf@gitster.c.googlers.com>
 <20200617212333.GB2809@coredump.intra.peff.net> <CABPp-BETyMYm=5APqAA3D1JmkurDFNkKLDrcF4MUgEfqEuVKFA@mail.gmail.com>
 <xmqqzh90q414.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqzh90q414.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 18 Jun 2020 00:13:53 -0700
Message-ID: <CABPp-BHB_WQqvRBKyA3bGy0L8FZhnN2CL2jHepDBrkjUDNrE=Q@mail.gmail.com>
Subject: Re: [PATCH v2 01/12] fast-export: do anonymize the primary branch name
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Junio C Hamano via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Don Goodman-Wilson <don@goodman-wilson.com>,
        Derrick Stolee <stolee@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Matt Rogers <mattr94@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, Jun 17, 2020 at 11:30 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> >> That leaves us in the interim with a "fast-export --anonymize" that is a
> >> little harder to use (you have no way to know which branch was which).
> >
> > Why does fast-export special case on "master" rather than on HEAD?
> > Isn't it more relevant to know the active branch than what _might_
> > have been the initial branch?  It kind of feels like a bug to me that
> > HEAD isn't the special case construct.
>
> I am torn on that one.  Surely HEAD is often the branch that has our
> current attention.  It may well be what we are exporting and we may
> want to see the topology formed by other refs relative to it.
>
> On the other hand, the current branch may not necessarily be what we
> are exporting.  Historically a project has a single branch that is
> the focus of most users' attention when they talk about the general
> state of the project's progress, so it is understandable to expect
> that the topology may want to be seen relative to that one central
> line of development.

I'm trying to understand here, but I feel like I'm missing something.
Let me try to explain what I understand and hopefully you can figure
out what I'm not seeing...


Regardless of what is mainline and whether or not it is important,
users probably trigger their bug when a certain branch is checked out.
Their bug may also trigger on other branches, but it at least triggers
on one, and some bugs will only trigger on one branch.  It seems
logical to me that we would want to have the same branch checked out
(it's the one most likely to trigger the same issue), and thus
identifying the HEAD branch is generally important.  (Mainline may be
too, I'm merely asserting that HEAD is important at this point.)

If users trigger their bug by providing various revision
specifications on the command line that compare multiple branches or
something, then we're already in the situation of needing to know how
to map more than one reference to anonymized ones in order to be able
to replicate their issue.  However, knowing the mainline might not
even help in this case; we instead need to know the anonymized form of
the references they are using, whatever those are, and mainline is
only useful if it happens to be one of them.

So, I think HEAD is always useful.  Additional references would
sometimes be useful, but it's not clear to me that mainline is one of
those additional references.  Maybe I'm just being dense, and I
apologize if so, but under what circumstances does knowing the
mainline help with debugging a user issue where an anonymized
fast-export is provided?

> > (Speaking as someone whose company a number of years ago had most
> > their big repos and lots of little repos switch their main branch to
> > be named "develop", and in some of those repos deleted "master" but
> > didn't in others.  If I had needed some steps to reproduce a problem,
> > and hadn't been on the inside, any special casing from fast-export
> > would make more sense to me to apply to "develop" than to "master".)
>
> Yes, absolutely.  You either check "develop" out temporarily just to
> take anonymized export to make "develop" discoverable in the output,

That makes sense; if the bug triggers while they are on develop then
I'd expect them to be on develop when they export.  If it triggers on
some other branch, I'd expect them to stay on that other branch when
they export even if "develop" is the mainline.

> or you would have set core.primaryBranch to "develop" once sometime
> in the past to tell Git that "develop" is that special one, not
> "master", so you can take such an export from any branch.

This doesn't make sense to me.  The person who changed the primary
branch to "develop" for some repository did so years ago.  That
individual might not even still be at the company, and even if they
are, may well be working on a totally different project (and
repository) today.  Perhaps that individual set core.primaryBranch at
the time, but git-config settings aren't copied by fetch/clone/push,
so I don't see how this one helps at all.  We could tell all future
developers who clone any of these repositories that they also need to
set core.primaryBranch when they clone the repo, but that seems super
lame to me especially since the odds that any one of them will ever
need or benefit from it are approximately 0.  And yet, it'll be one of
these developers who joined the project long after the switchover who
runs into problems and provides fast-export dumps.


It feels like I'm probably just missing something obvious, but I
really don't see how the mainline is special here.  Please do point
out what I'm missing.

Thanks,
Elijah

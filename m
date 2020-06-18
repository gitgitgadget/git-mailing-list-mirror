Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E13C433E0
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 07:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 287CE207E8
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 07:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mU7jw0hN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbgFRHkv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Jun 2020 03:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727930AbgFRHku (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jun 2020 03:40:50 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C40C06174E
        for <git@vger.kernel.org>; Thu, 18 Jun 2020 00:40:49 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id g18so3671230qtu.13
        for <git@vger.kernel.org>; Thu, 18 Jun 2020 00:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TuaMD20pyCpQrqL0cYutJMZndNiwWO3z7l98gTOXqAU=;
        b=mU7jw0hNb18PX0LzNT+VYTswuoa0V9Y+OdOAKjivcPdoXKQoi+lFjSm0mwZTnINFEL
         Q8lAcrzSd+HuQs3cGs9xkpNlFEEuzeyjvF8Lc5fiO15DaQvk75iZcNL7zb57F+QzDJAh
         ijZoOpDEZ04+14vhvCjVgntMIm3IQhLmnQzksanXovJWfF+AQ3mpE5rBabLzS3qUJYsm
         8gqeF1p6TWWdVi0b0Y2wHD57y1y9G2rQlWo4aZU/dDT1F3Su4OAfOdSCnHWOYulDUGYS
         9UUY7agdGbup/3kvlXV/rotgW3JT8sPrx6Vp96CTPPL/l/M0rtCbrQ9aHp3iQan3cCoN
         Sh/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TuaMD20pyCpQrqL0cYutJMZndNiwWO3z7l98gTOXqAU=;
        b=VUSUDbkjAIRYja9k8VUCRqHRlhiwdmP9Ocq99HfE8fzaZDhlJogu5Lh1wlkxwFKj0q
         dNz39l2FT0K0G74F2NysTCuCjlENwC3c4q638L0Usd5GV8CI4fMULWbJC2NW6AtIZre8
         mqvmHn0s5s17m1rTKcoCn2qzTLljUf67+LaGOTXYOTkLP2iB/XV5vQufsMAXBEnoMV0C
         cZDled6C9MlJjnMtq6bRVZhKN9RgGoTk/Iy6Tkx0QzMovonPiTgfUB1PsqLtP1GvKEnS
         BqdJ645OcRxotnyzPGzZmmB8HkZesH7bpCfrAJv98O/5pb1AXdOJgx6hnYRTGBej3QCO
         WdqQ==
X-Gm-Message-State: AOAM533AtHehHNmgvzelZOi55Htq1iD4+rDaw4/nmE7TlgKnzX7Rwlnk
        EdI/EibPyeDzVB1gZVR5AXwOs6OBITiBt0GAXxQ=
X-Google-Smtp-Source: ABdhPJzPfUfrXYzhjSey9c67ijTS/rBrHJqR2pLVwX9dqQAzyJ27KC42uHqg6FQIuY19HfQDqEg0RGOVh6pDR1jqZho=
X-Received: by 2002:ac8:664a:: with SMTP id j10mr2930426qtp.85.1592466048736;
 Thu, 18 Jun 2020 00:40:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200614181906.u42tuny3eipvhd46@chatter.i7.local>
 <b82bdf57-840d-f9c2-0e42-95a93d9336b7@gmail.com> <CANgJU+WoGNKuvZHAtLAfNAUfFdoLWHiDis_rSV-AfT9WspmHgA@mail.gmail.com>
 <20200616074316.GA21462@kitsune.suse.cz> <CANgJU+XzD9Nnnu4qWExpOUBy+u1=23SRCQy-=6aAVFJAowkjYg@mail.gmail.com>
 <xmqq5zbpv53g.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq5zbpv53g.fsf@gitster.c.googlers.com>
From:   demerphq <demerphq@gmail.com>
Date:   Thu, 18 Jun 2020 09:40:37 +0200
Message-ID: <CANgJU+Ut+ANPHud1JQw1Wo+zb37_=EWx-vgap6FGC+T=-dzn4A@mail.gmail.com>
Subject: Re: Rename offensive terminology (master)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
        =?UTF-8?Q?S=C3=A9rgio_Augusto_Vianna?= <sergio.a.vianna@gmail.com>,
        konstantin@linuxfoundation.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Don Goodman-Wilson <don@goodman-wilson.com>,
        Git <git@vger.kernel.org>, newren@gmail.com,
        philipoakley@iee.email,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Simon Pieters <simon@bocoup.com>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 17 Jun 2020 at 21:56, Junio C Hamano <gitster@pobox.com> wrote:
>
> demerphq <demerphq@gmail.com> writes:
>
> > kind of confusion. Consider how this conversation goes for us:
> >
> > A: "No you need to fetch trunk from the remote, then you need to merge
> > it to your local trunk and then push it to the master trunk".
> > B: "Ok."
>
> Hmph, why isn't the last one "trunk trunk"?

What I described was someone pulling from a box they have code on
(which does not have access to the master repository) to the local
repo on their laptop so they can push it to the master repo.

We have a master repo at $work. We use a mixture of centralized and
decentralized dev models. To get your code into production it must hit
the master repository, and it must be in the trunk branch in the
master repository. I imagine this is a relatively common
configuration, and problem in a professional context. Eg, I might be
testing or debugging code on a node that is not allowed write access
to the master repo for security reasons, so I need to pull the code
from there to my local workstation and then push from there to the
master repository. And all too often our people don't use topic
branches for this stuff and just hack on their local copy of trunk. So
from my point of view what I said was absolutely correct.

> > Similarly when the perl project migrated to git we renamed "master" to
> > "blead" to reduce the possibility "master master" confusion.
>
> Or put it differently, "your local master?  remote master?  or the
> primary master?" would be a way to state the phrase A asked in the
> example without renaming the name for the primary branch to 'trunk'.

Well, "primary" is not a terrible replacement term for "master", but
it isn't ideal either, as it also suggests the existence of a usable
secondary, which isn't a correct mental model (for us). Personally I
would eschew "primary" when there isn't a "secondary".

> What I am trying to get at is, after changing the name that is given
> by default to the primary branch in a newly created repositories by
> "git init" to 'main' (which I am OK with, and it seems that the
> major projects and repository hosting services will be doing anyway
> with or without getting themselves in this discussion on this list),
> wouldn't we risk the same "master master" confusion caused by and to
> those newer users who learn 'main' is the word given to the primary
> thing?

Yeah I think it will still cause problems. If it was my call I would
not choose "main" either. Having said that I do think it is a bit
better than "master" however, as it leaves the term "master"
unambiguously about repositories, and it leaves the term "main"
unambiguously about branches.

Also I would argue it is more etymologically correct. I would argue
that the "master" branch in git terminology is NOT really the "master"
unless it is in the "master" repository. "master" in the content of
"master copy" implies "one" (it has to, what do you do if you have two
masters and they aren't the same!), but using it in a distributed
sense for a branch name doesn't imply one, it implies many, so it
really doesn't make a lot of sense.

> Wouldn't you teach your users to fetch 'main' from the remote, merge
> it to the local 'main' and then push it to the 'main' main?

Unfortunately we call our main repo "main.git", so for my workplace
"main" as a default branch name would be suboptimal. We chose "trunk"
because "main", "master", "primary" all have these double meanings. On
the other hand "trunk" is the standard word for the things that
branches grow out of, and in some trees, the branches even can merge
back into the trunk![1] Thus I find it weird it isn't perceived as the
"obvious" choice to solve this problem. That the bulk of the
population chose "main" suggests to me a lack of imagination more than
a reasoned and thought through decision.

Anyway, personally I would say "main" and "master" are both bad
choices for the default *branch* in a tool that is as workflow
agnostic as git is and seems to intend to be. It is relatively
unfriendly to scenarios where there is in fact a "main repo" or
"master repo" . Many people will in practice use git in a relatively
centralized way with at least one repo designated the "main" or
"master" repo for the project, and so you end up with two "master" or
two "main" things that are very different with very different
properties.

So yeah, I would say that "main" is slightly better than "master" but
is still suboptimal from a comprehension point of view, and it is
downright unhelpful for my $workplace (but I recognize that isn't a
problem you should be considering in this discussion.)

Thank you for your time and efforts in dealing with this subject.

cheers,
Yves
[1] https://www.reddit.com/r/mildlyinteresting/comments/25xkg2/a_tree_branch_grows_back_into_the_tree/

-- 
perl -Mre=debug -e "/just|another|perl|hacker/"

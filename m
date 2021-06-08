Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14698C47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 07:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBD7F6127A
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 07:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbhFHHTx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 03:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhFHHTu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 03:19:50 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328ADC061574
        for <git@vger.kernel.org>; Tue,  8 Jun 2021 00:17:46 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id d21so20650876oic.11
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 00:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=uoJYLIHHHjRUlcSWF2YViw14Az/2buBG2YospGQueX8=;
        b=ndO8wa7g6x/rz1znb5hdh21Q0uBBxhTdNs26jP3CIJT7afpz1+4hmShtLLGXcX0KyG
         XpYXfHTRoNAsIDFjKV7rDyBge0KapWnzeyJDof5eJFgvWDj4eAzE9nBzhC20onkWPwAD
         60tlxDVruxqllcZ5C6StbErd8P64OvO5bkBMeMtmh8mzVRQfG4UaGq/fHa6BGN7IGAsb
         54gryP56UB/0SnjDiQ52JyExRKEdhttxVA4qU9F9TUStxpP8aHjPdUpG26VAnrbGAzAP
         8iZSNmR2cI+pLsRiutlyAjvQdqR7cEazOwd9P9MT9Y/C08kZM3nAgPEeXSymKHtVg3cd
         gZQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=uoJYLIHHHjRUlcSWF2YViw14Az/2buBG2YospGQueX8=;
        b=uk3gk2uuYKwBrMVqrE859bWB/XWhNy7/1PihZI3hctZJ1GZMJF5u5q3jpeo/66r3HS
         gKt1tzzGn5qMiv68As1ApL1FL1czxirIIiJkIiuGnUnubdZeTQLiMdsRqIH0eQFqBpBu
         gpRKSWTxXVxQqHAk9gMYnuKnJb9Go0fEBWY5ibCnm/5nobK96prjnCSe1woqCcRZHea4
         j0VslCf+qf/EWLm0jImOTon/ZSmStJazknR8vK4hrODqyhUmUxaGidLVIrA4+7grYmzf
         E7kuUahzQcxCXGtZFhKZvbeDdRG8FAtpf9bFq0jx6N6SLFFzgnVrNnkih6icFZLi7QDU
         UkTQ==
X-Gm-Message-State: AOAM530vQh+JeVOqaCHZXwYkgF0Em7Q/vmmkGPVLjTk6itXg8X2M6FqG
        dt/eSEAybj2IuFFprhJkivI=
X-Google-Smtp-Source: ABdhPJzpVQzg+FtS5VvMmMPgY7CXGZs7vXtwxQU/Xe85KJmypxlO9Js7lOPtHFl/5gJ5o2u31QGQYw==
X-Received: by 2002:aca:1805:: with SMTP id h5mr1857741oih.166.1623136665525;
        Tue, 08 Jun 2021 00:17:45 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id s6sm2875055otk.71.2021.06.08.00.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 00:17:45 -0700 (PDT)
Date:   Tue, 08 Jun 2021 02:17:43 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Message-ID: <60bf1997b1a72_1a2ac520865@natae.notmuch>
In-Reply-To: <YL8KiiGXF8LdGmQ2@coredump.intra.peff.net>
References: <20210605011339.2202-1-felipe.contreras@gmail.com>
 <87czt059sn.fsf@evledraar.gmail.com>
 <YLv8NWL7WfBRkiGe@coredump.intra.peff.net>
 <60be41f6473e2_39c0a208f6@natae.notmuch>
 <YL8KiiGXF8LdGmQ2@coredump.intra.peff.net>
Subject: Re: [PATCH] branch: make -v useful
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Mon, Jun 07, 2021 at 10:57:42AM -0500, Felipe Contreras wrote:
> > Jeff King wrote:
> > > On Sat, Jun 05, 2021 at 10:18:14PM +0200, =C3=86var Arnfj=C3=B6r=C3=
=B0 Bjarmason wrote:

> > > > As for the proposal, I don't use "branch -v" all that much much, =
so I
> > > > don't have strong knee-jerk feelings on it, but just considering =
it now
> > > > I'd think that the current default is a fundamentally better
> > > > approximation of what most users would like as a default.
> > > > =

> > > > I.e. I think it's fair to say that to the extent that most users =
have
> > > > topic branches they're part of some pull-request workflow where t=
hey're
> > > > always tracking the one upstream they always care about, usually
> > > > origin/master.
> > > =

> > > I'm in the same boat. I don't use "branch -v" either, but showing t=
he
> > > upstream name wouldn't be at all helpful to me, since it they would=
 all
> > > just be "origin/master".
> > =

> > But this patch is not for you, it's for the majority of git users.
> =

> In the quoted text above, =C3=86var mentioned that many users will have=
 a
> pull-request workflow tracking one upstream.

A pull-request workflow tracks *two* upstreams.

Option 1: track the base:

  git checkout -b fix -t origin/master # like you, =C3=86var, and me

Option 2: track the branch you push to:

  git push --set-upstream github fix # like apparently most users

It's two different preferences for the same workflow.

> So no, I don't think it's just for me, but anybody with that workflow.
> =

> But of course i also mentioned other workflows, like...

No. The same workflow can have two very different upstreams.

> > > (This will vary based on workflow, but the
> > > other common workflow would probably just show "topic" being based =
on
> > > "origin/topic").
> > =

> > Based on what evidence?
> > =

> > As I showed in [1], all the top results when googling "upstream branc=
h"
> > show the upstream branch being used in the opposite way: it's set to =
the
> > place you push to:
> > =

> >   git push --set-upstream @ github/my-pull-request
> =

> That's exactly what I was talking about in the quoted text above.  If
> you use --set-upstream, then your local "topic" will track something
> like "origin/topic".

But it's not origin/topic. I'm not talking about
`git branch --set-upstream-to`, I'm talking `git *push* --set-upstream`.

Git is a distributed VCS, most people don't have commit access to the
original repository, therefore they push to their personal repository
(e.g. github fork).

So their upstream is not origin/topic, it's github-personal-repo/topic.

> > But even if that was implemented, the whole point of this patch is ab=
out
> > what the default value of branch.verboseFormat should be.
> =

> I'm saying that I find your proposed value for that default to be
> useless, and I suspect many other users will, too.

Explain how.

If most people use `git push --set-upstream`, their upstream is most
definitely not origin/master (nor origin/topic).

Even git itself recommends setting the upstream to where they push to:

  fatal: The current branch fix has no upstream branch.
  To push the current branch and set the remote as upstream, use

      git push --set-upstream origin fix

So they will get a benefit from seeing the upstream in `git branch -v`.

Would they not?

> > Do I need to produce a list of the top 10 Google results of
> > "git branch -v" vs. "git branch -vv", to show that most people don't
> > find the output of -v useful?
> > =

> > Or what kind of evidence would satisfy you?
> =

> Don't bother on my account. I have generally found that going more than=

> one round deep of discussion with you does not lead anywhere productive=
,
> and I don't intend to continue this thread.

If there's no evidence that will ever convince you otherwise, that means
you are not interested in actual real users, only in your idea of users.


For the people who are actually interested in what actual users do, I
ran a poll on reddit [1], and so far:

  15: The base branch (e.g. origin/master)
  15: The branch you push to (e.g. github/my-pull-request)

They are tied, 50% use the same upstream as you, 50% don't... For the
*same* workflow.

Cheers.

[1] https://www.reddit.com/r/git/comments/nuf3p5/where_do_you_point_your_=
upstream_branch_to/

-- =

Felipe Contreras=

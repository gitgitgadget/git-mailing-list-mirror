Return-Path: <SRS0=f6GY=4Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37CDC3F2CD
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 18:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A1592468E
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 18:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDCVosk+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbgB1S4r (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Feb 2020 13:56:47 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40286 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgB1S4r (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Feb 2020 13:56:47 -0500
Received: by mail-oi1-f194.google.com with SMTP id j80so1844308oih.7
        for <git@vger.kernel.org>; Fri, 28 Feb 2020 10:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C37ohnTqDhY6/DhIwJ+rxWBv21royjj7224elZEtUIc=;
        b=kDCVosk+IO2Ny2QCE7UdwV3miYyaY/vKajw4aqtN2TP8kQ6ilQPwMb6uDzxJdrNKei
         LXH1JctrjsTwEPj2SJzYGdId8mBw85VbsBsYm8w7reslqovfEWzHvVQagq2wFhqEiOKN
         ADM0zJSXfSwwHB/mFZZolSVJf0M/p4V2pv4f2dTqzW3cg0rn0eKgbsfvb1Ru8hs6I+vd
         /gfjoEX/xxkctOgZpaQTVhF9W+7vt9M8aHP0yYA9+7LNuoM+KmePDwT9+sj+WU3sUGJF
         da05db1THrKeDeSGOShoA/6kV/klwPSeadi/hGgpQ4rZKpgyZHcOPVl9UKVfOgXK4B4+
         fE9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C37ohnTqDhY6/DhIwJ+rxWBv21royjj7224elZEtUIc=;
        b=CVFBA9rAuNMs2OBv5JQXmsGgsH/hJ5Suq4yWiAcU631tdej+rLBYTJSTWlMF1fVnYY
         UuGa5DxtGk3vDefvm7cyWd5CRTQ8EVDXvofKYpb+vcxy4xaHvbpWcsZQkT2/hygHa+Q4
         rxo9+lnYOuK0Lg7MfuGLkkKV7Za5LXPZ3EJ8SUEd3yVgb54SvC8oquyvpqUO6g0JWoiv
         r5cBUgLlxXW3OgW3j/vXyGXqFEDLcVW9osWGqfJO6E8Yj3p1wlDMuAxXzqsKjVEbjmBb
         KT1mrVBkkE5xNWFP28dgBs4f68EoEc9DYoJK8vim+tF3dptFqhhn2nbI5LdxSREIK3Ap
         jiAQ==
X-Gm-Message-State: APjAAAUm2HVF3LNnpIjIY9v17+IjPSClyttoyc4X0l4avGAl5KanQNlW
        SgEZUTe4pfIYIJJie9/j8/zLRu1k1K4QjgG+jrozWQ==
X-Google-Smtp-Source: APXvYqz3Jn9gQLkjj0N7C0omS1NeDaKTk7WRS1QRV52c/w9r20IEB88MJRLJhymoPwjG4llxYoMYV0aJj0PMOQu/TpI=
X-Received: by 2002:aca:4e10:: with SMTP id c16mr4030881oib.6.1582916206209;
 Fri, 28 Feb 2020 10:56:46 -0800 (PST)
MIME-Version: 1.0
References: <CAHd499DC7pOB3kD7nAG79GrufKrV-8p4vSZ5ZEPQb5gdXrNakg@mail.gmail.com>
In-Reply-To: <CAHd499DC7pOB3kD7nAG79GrufKrV-8p4vSZ5ZEPQb5gdXrNakg@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 28 Feb 2020 10:56:34 -0800
Message-ID: <CABPp-BGrwNf9p6Ayu=A4CF9ydww8tQfvzFqFO1rNm-QG55yG6w@mail.gmail.com>
Subject: Re: Why does `pull.rebase` default to `false`?
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 28, 2020 at 10:17 AM Robert Dailey <rcdailey.lists@gmail.com> wrote:
>
> This is more of a question of practicality. Literally all of the team
> and project workflows I've experienced have demanded that `git pull`
> actually perform a rebase of your local commits, as opposed to
> introducing a merge commit. This means setting `pull.rebase` to
> `true`. I can't think of a practical, day-to-day use case for wanting
> merge commits after a pull. Since the subject commits of the rebase
> are always local, there's no harm to anything upstream since they
> haven't been pushed yet.
>
> I'm sure there are edge cases that explain why the default is `false`,
> but I'd argue that it is likely a case of the minority concerns
> becoming an inconvenience for the majority of users.
>
> Thanks in advance for any enlightenment!

The default of pull.rebase being false makes a lot of sense for Linus
or any of his lieutenants, or any one else in an integrator-like
workflow.

It could also be viewed as measuring authoritativeness of
repositories; if your current repository is more authoritative than
what you are pulling from (as is the case for Linus or his
lieutenants) then you will likely want pull.rebase to be false.  If it
is less authoritative (e.g. you have a central repository and you are
just a contributor), you may likely benefit from pull.rebase being
true.

I think pushing to central repositories is a far more common workflow
than being an integrator, but we should be careful about only
considering that.  For example, although at work we predominantly have
a push-to-central-repository workflow, we periodically have people
merging previously independent repos together (creating a monorepo
from separate repos).  This is often done with git pull
--allow-unrelated-histories.  If pull.rebase were to suddenly switch
to true, folks that built up knowledge about how to do these merges
would get some negative surprises.  Although
--allow-unrelated-histories was the first example to spring to my
mind, I suspect that whenever the user has merges in their history
that the other side doesn't, that a default switch of pull.rebase to
true could be a negative surprise.

There was a fairly similar history for push.default; for a long time
it defaulted to what we now call "matching" because it made sense for
the original workflow of integrator and lieutenants that git had been
designed for.  Then we discovered it was really bad for people who
pushed to centralized repositories instead, and invented new terms
(upstream, tracking, simple) and changed the default over time.

We may want to do something similar with pull.rebase (only let it
succeed if it's a fast-forward by default, otherwise require the user
to set pull.rebase first?), but I don't want to have to think through
the details or work on such a transition -- I'm just commenting with
some thoughts that might help you understand the current state.  And
others probably have more details than me.

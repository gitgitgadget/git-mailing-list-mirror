Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40460C2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 15:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BC12610A2
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 15:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbhFQPIs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 11:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbhFQPIr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 11:08:47 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE7CC061574
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 08:06:40 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id w23-20020a9d5a970000b02903d0ef989477so6412767oth.9
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 08:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QCIpEjfHHdCZLAaT7TwvwFi5Qf+xCklgX623pTjEiZc=;
        b=YQE5PJfzhVC3u+BsycSCeIjyfgoj0QkBkXknNJa3nodX3ur70V80OnDaSs81H6J6Yo
         Uwh6sxkcJBs5vN5dBjP+IqzPCB79+d9NkxEzAJ4FzH9zk1TypMH9l+dtVFCXWS8iHQbP
         oh132vThyYq/6RJMNfH1lCOZnwq99S1mDBeBDQN1vkYqZ0S8TePXXF8lCoKOSH/OIE32
         2jnqlocOOIqqXTDInimXVRAJZBWsT7+LvdNBrb8kcPzR/eXtm4cgKiEEAA6XFdzTT0Nk
         8vQ7tCA8Vxzk+e0oLrlkAonsgDrAxdxasmpFzqSBvL1z2CaJ0bSIW2d0cDTivyhL9/Nh
         wRnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QCIpEjfHHdCZLAaT7TwvwFi5Qf+xCklgX623pTjEiZc=;
        b=p2HEKCUEOYrdOkbwuJIAkGaaTUxUaV9IXwz0mQxeHZrwEn6xi2zxQkzIREJFu9xIK0
         HXsvJhzwFJQeHHPX0DUENpAGz7N1sD+XSs/yEzKwLbXCxUW9DKXkLQWmyPOoVgwgUDRn
         sh4275ekK8ao12KAmQ0Ej/5KEBLTY5rXjVmWGy0+WvzFe/4kyyYLo45JpqI8LyJ2Gnom
         ST9gFJ2e9sIdiEUJaN5LmOu60l+edK/JHtibrNN7QpjCSKmCbStL5OIt4cSE8oXWljMi
         2CqCGqycDOPgnwMexwnuoLtk290pagelxPM7u7qg9TdGqkqqS1f0zEwkIYG69/Trfk4e
         9lvg==
X-Gm-Message-State: AOAM530kzjk0BCFHgGvYp02L3BVwXOFwHwfxts9okfGJm3HpfLe84bC3
        1tqNlrBJ9aPkoxo+vxX2x1QkxA/7cYkBgp9CV5w=
X-Google-Smtp-Source: ABdhPJwLyV9Zo9f0h7yCMo6jwDuvSPjPjAgmOK4EcZYC4okrb61qeJP01KwDtpB9WdzbAlAFJP7yl6tG6WPgJ23OtQo=
X-Received: by 2002:a9d:1a8:: with SMTP id e37mr4809117ote.316.1623942399488;
 Thu, 17 Jun 2021 08:06:39 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqr1h1mc81.fsf@gitster.g> <CABPp-BG53Kd7MhzE3hdq5fjBQVV2Ew3skcUCAuTfM5daP2wmZA@mail.gmail.com>
 <60cb5a02f1b31_1259c2086f@natae.notmuch>
In-Reply-To: <60cb5a02f1b31_1259c2086f@natae.notmuch>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 17 Jun 2021 08:06:28 -0700
Message-ID: <CABPp-BE95Y0+d6yVQ0ZqRWnknqc3N1vL04VYoqy-7mvQckfuaQ@mail.gmail.com>
Subject: Re: Contributions which I feel are dangerous and/or deceptive (Was:
 Re: What's cooking in git.git (Jun 2021, #06; Thu, 17))
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 17, 2021 at 7:19 AM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> Elijah Newren wrote:
> > I hate doing this, but...
> >
> > On Wed, Jun 16, 2021 at 7:58 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > > * fc/pull-cleanups (2021-06-15) 3 commits
> > >  - pull: trivial whitespace style fix
> > >  - pull: trivial cleanup
> > >  - pull: cleanup autostash check
> > >
> > >  Code cleanup.
> > >
> > >  Will merge to 'next'.
...
> Do you see anything wrong with these particular patches?
...

Sorry for responding when I said I wouldn't but let me clarify my own email.

The *code* changes in fc/pull-cleanups are good, I said as much
previously.  The commit messages are also fine, except for the
misleading Reviewed-by claim that you still aren't addressing.  That
could be overlooked on its own.

Any other problematic patches or portions thereof of yours could
easily have been written off as mistakes and been no big deal.

My concern is primarily in how you *respond* to feedback.  I feel you
have displayed a callous disregard for what others find critical and
important, and appear to be unwilling or unable to adapt and work with
the community.  It was particularly your recent emails with Peff at
[1], [2], and [3] that have me deeply troubled.  Troubled enough that
I do not want my name used to endorse your changes, particularly when
I already pointed out that you have used my name in a false
endorsement of your patch and you have now responded to but not
corrected that problem (including again just now in this thread),
making it appear to me that this was no mistake.  I do not want such
false endorsements to occur again, and felt I needed to speak up to
make that happen.

[1] https://lore.kernel.org/git/60c647c1d9b5c_41f452089@natae.notmuch/
[2] https://lore.kernel.org/git/60c82a622ae66_e5292087f@natae.notmuch/
[3] https://lore.kernel.org/git/60c87fc6a87ba_e6332084f@natae.notmuch/

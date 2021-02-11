Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DED4C433DB
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 07:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31AC964E3C
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 07:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbhBKHhh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Feb 2021 02:37:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbhBKHh3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Feb 2021 02:37:29 -0500
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB331C061574
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 23:36:45 -0800 (PST)
Received: by mail-ua1-x92a.google.com with SMTP id d3so1446328uap.4
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 23:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GJmf9/DDFlN2g9zneonlY1AJe4MIwvJ0vdVD+ECFepE=;
        b=A/xIcN0HAnz1yFNXE2YDP0uCuecCq+M9+1OL4qj3ZSqKV+TLYTgtqH8SmTWB6S6WG/
         LNxfXJKXJ+wAExDaEPobw3AUhG/eXJhDLo8qZ4VkMLhV/wkh9Psl5O3Mj+8ybZXGwrsh
         F3+8p8O2UuPEKtNMYfDyHi66BimN/ypQVvT/EZQY4pJfWQAzu3UNrav+ehV2dcpE+7YO
         hJ/VOv5UWtNCldcW6sXkxc8uX3yXN6uf/AYP0h6n0mih5QaRJLrR5ByvvxXcz1wv8h5Q
         SabhBN8lGdNwCPsSjrWRLDXDxAUv+s6F0xuUI2Jx5OvLT3UaO1451gLvdz8T8FCcYPvT
         22SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GJmf9/DDFlN2g9zneonlY1AJe4MIwvJ0vdVD+ECFepE=;
        b=OEPkMZHRlylyv3IRbqOs4mh2lt1nn+Uc/wxGgeP/KmS1AEZbp73HRvYmSNWCoVjou8
         l9FkMf8+wmwhXoBKFxAbHGmlLXpDgKOoMaZ6UM640qREwR3XL2CmKNJPb8bKRX74uZTH
         00OIy9f36ABErAfGlA7E2y3zAOMHDGBdW4Fy+QJrO4eusblXdvA+dAhVv0j+5g645vNM
         qBUInIl6GhiHu6KiOzkaEeg9MIvMWEP6yWQVP68tv/LCC7pE+TW+J6SyoCkxqJpqIiBv
         bMeBYWzx+8e6Ns1fd5U9PdphCycm0YUDhSUm5n6Tdw3ghTKE0NZC7CukP8Hr/TzHTmo0
         1V5A==
X-Gm-Message-State: AOAM533zaNZtrpFb8mSBSKXMk+fgMISWtO4CChO38wlz6jKmWw0P9JvA
        z6UOJmizISS7/+ZRkhhtyI2ANQdSyhVWz0CI+wPYH+3PqGk=
X-Google-Smtp-Source: ABdhPJy6+cd8C+A3V4Ryy3q2kDxVM5MqC79erV0wVk6iqlYpXWfrXV/bFi+pS0p6BVM8v8R9g0nUC9SmW6hiVKb6x5c=
X-Received: by 2002:a9f:2628:: with SMTP id 37mr4095117uag.87.1613029004905;
 Wed, 10 Feb 2021 23:36:44 -0800 (PST)
MIME-Version: 1.0
References: <e7fde2369495f32c7aa88c7b6b74ebee1a1bed24.1613000292.git.martinvonz@google.com>
 <0bdc333b25aca1de82fea3a1f290fe30ee3ebf51.1613027889.git.martinvonz@google.com>
 <xmqq7dnfys5l.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq7dnfys5l.fsf@gitster.c.googlers.com>
From:   Martin von Zweigbergk <martinvonz@google.com>
Date:   Wed, 10 Feb 2021 21:36:33 -1000
Message-ID: <CAESOdVB7i9UJpsB91sedGKPiCxkc0XgC+T5SLP4qF==kaqhJtg@mail.gmail.com>
Subject: Re: [PATCH v2] docs: clarify that refs/notes/ do not keep the
 attached objects alive
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 10, 2021 at 9:34 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Martin von Zweigbergk <martinvonz@google.com> writes:
>
> > `git help gc` contains this snippet:
> >
> >   "[...] it will keep [..] objects referenced by the index,
> >   remote-tracking branches, notes saved by git notes under refs/notes/"
> >
> > I had interpreted that as saying that the objects that notes were
> > attached to are kept, but that is not the case. Let's clarify the
> > documentation by moving out the part about git notes to a separate
> > sentence.
> >
> > Signed-off-by: Martin von Zweigbergk <martinvonz@google.com>
> > ---
>
> This looks the same as the one in
> <e7fde2369495f32c7aa88c7b6b74ebee1a1bed24.1613000292.git.martinvonz@google.com>
>
> which was v1, except that this one has your sign-off.  Sent a wrong
> version?

Yes, sorry. I forgot the `-a` to `git commit --amend` (have been using
Mercurial for the last 5 years now). I'll send a v3.

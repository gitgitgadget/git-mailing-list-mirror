Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF4CC433F5
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 23:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8D1861881
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 23:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234241AbhJBXnw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Oct 2021 19:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234050AbhJBXns (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Oct 2021 19:43:48 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955A6C061714
        for <git@vger.kernel.org>; Sat,  2 Oct 2021 16:42:01 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id l7so25418581edq.3
        for <git@vger.kernel.org>; Sat, 02 Oct 2021 16:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VnwATb2m4Kw0uNpi19EaFdP57VofN9dqu8VhXJiUjXg=;
        b=Xb+6zqWJjSnzKLaiEKK1k2m7KwbhTgkHxb/k37uoBesrFGk92TmqXcFm33nO+21H0M
         VCh8HtUf7pVCs91i38Hr9FaGh944mRjy1CLVFoWjlzm/wBs44zG+ectUC8TM4czVl6Cd
         753kVzJIhv2CFks3i4jSK49tsRXibymiy8Vd3sV/56bAIvYIsCNY8YIE+wruxjl8yLoI
         AK39B6pLQQK0FnoYiX46Ez9ffg1b2Bg/bL9BBqspLqubHwY66SQpR45d90m4bt9HEA3p
         POZco6U/DXE7yE8gsIUk238WWCsSaZ56vp8h3+w7c7CmYU5QPdhsPhXwFqJptpK4Vyyt
         KkdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VnwATb2m4Kw0uNpi19EaFdP57VofN9dqu8VhXJiUjXg=;
        b=c5UKgMJQIjhaxyNOdrGAdaSFqizpMUTVgQrwpDSGD9mvXn3Qre6jGOnHNQCbb4Yc7b
         4C4v/p9pPeq0kAvADrb0PUU/Eyu5gu/cee2qUITR9Eke3PW9p4Kf6RWY26oOnXRVPvcF
         NPJrtejztpBdIChGELPXntib7TnhzAQAakp3O/+I+zANshn8tDdugcLgsUOO/a8ZIsBE
         etF7lYCeBYFb8zdTdgzNoHLg1pHGu9XfFUJsrT4Dk4YssWrmrZroIHNPzUK1plvXx5La
         UywdGnufvHscS3TjlmbqCxPZRigxe78uEQ9n23DCXS4nunc6JCHs+as7zAohqr46R8Rg
         nEew==
X-Gm-Message-State: AOAM533QYAF6d/qqH+iEySSXs8IztKGFBX200dktaVTFwMy1FqeU7XSv
        iJBlmX1OEH3BXroh2mCo1hGQ9hNqSvdohiopextkUVA+C8E=
X-Google-Smtp-Source: ABdhPJy/eFRkBUv2gvWycFBrm4oj9BtmvRiVA1lTXB7QGuaZY0KYcNi6Z1GlxqP4Dv1zYyJKldjeobBjgqoEbIpmHbY=
X-Received: by 2002:aa7:cfc4:: with SMTP id r4mr7198605edy.244.1633218120176;
 Sat, 02 Oct 2021 16:42:00 -0700 (PDT)
MIME-Version: 1.0
References: <20211002184407.117282-1-rybak.a.v@gmail.com> <20211002184407.117282-4-rybak.a.v@gmail.com>
 <CABPp-BGq27kdugX5JivX7uFLmCmHXCsRjqfaA1Q2PXHZ4hCznw@mail.gmail.com> <CAPUEspgC80_jMJ6Vy8G7YW0v9NXusGCSLzpeBgVZFXpPKJ7a7w@mail.gmail.com>
In-Reply-To: <CAPUEspgC80_jMJ6Vy8G7YW0v9NXusGCSLzpeBgVZFXpPKJ7a7w@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 2 Oct 2021 16:41:48 -0700
Message-ID: <CABPp-BHTHcK7T32zbcusT8vcv=j2-o_+8SEzkAJczU85r_LcEQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] difftool: add space after full stop in comments
To:     Carlo Arenas <carenas@gmail.com>
Cc:     Andrei Rybak <rybak.a.v@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 2, 2021 at 1:12 PM Carlo Arenas <carenas@gmail.com> wrote:
>
> On Sat, Oct 2, 2021 at 12:38 PM Elijah Newren <newren@gmail.com> wrote:
> >
> > On Sat, Oct 2, 2021 at 11:49 AM Andrei Rybak <rybak.a.v@gmail.com> wrote:
> > >
> > > These punctuation typos were found using:
> > >
> > >     git grep -P ' [a-z0-9A-Z-]+[.][A-Z][A-Za-z-]+ '
> >
> > While Junio has commented that two spaces after the full stop in
> > fixed-width source code viewing looks better, and I personally prefer
> > that style as well, I don't think these are worth "fixing".
>
> FWIW those are not adding a second space, but adding ANY space between
> a "." and beginning of the next sentence.

Oh!  I didn't look closely enough (I'll blame gmail's variable-width
font).  Thanks for correcting me.  Yes, if there's no space at all
between the full stop and the next character, then that makes it more
annoying.  So, ignore what I said earlier, I think this patch is good.

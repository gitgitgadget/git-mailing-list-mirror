Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4EDC433EF
	for <git@archiver.kernel.org>; Sat,  4 Jun 2022 00:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348946AbiFDAuv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 20:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347864AbiFDAut (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 20:50:49 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C081D0DD
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 17:50:49 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id s12so11650626ejx.3
        for <git@vger.kernel.org>; Fri, 03 Jun 2022 17:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/UuYtt8NvbI89CeMPhb2hiBizyejCCh6pzR6cr5MpQ0=;
        b=TmVnn4iovkS8zJ4nR4668UUaV2KRvAWL33BR6ETiqrsI5Xvan/3b0Dv/txp3lwt3/7
         dEYWSrehioDEoHKvcMNObkpAUtwKWENGGz1UE6KwC1OzluAOSIxGOPxHA5yY5s08oRiB
         XqPh+IpFg15QlCJro7Clt5g0bPxhDnX6+uEBlOpwyAB2cS8jKp1qtXHsPwIroswgIBDD
         DSYNy0vEHZy402Rsgc/tDNgK3y7kNHt9HdcRml6us8CghIzal6+Bp4GPCcoiEG/bf2K0
         OGBU8RxQGF+DMqNp6FCBR6ZghUmHFrYqyBYd+IHwUpQGBbF1QUHlMbIDqesdB3cNgN19
         PJiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/UuYtt8NvbI89CeMPhb2hiBizyejCCh6pzR6cr5MpQ0=;
        b=z1y3jCtF/addf4HOEN3emUcpaILhcHSEVwfH6Be3K8q+BCpKBc8bKl6aPigxfc4GNc
         z8h0jelIln9vpN2CJhYhS0Hvng+K8uaxyPgFP1CbPjqREnSn8YFkuSXgpVvHrALje6+g
         oe8OnlICONiO/E8mvQRkAIoTahR4CGUc6JgxVWZooS0FEKyNbnla7aWeOI6zyza6nKoe
         e/ycY7QZSxaZR+8fPnGJImTVeD0UNV1yxHFeSWhkD6+BxgD9AweCIK98u6yiRx1+yJ1a
         nqMyuGBXNeh1B0HnZ8mRwVO4+QiCUnnxqakrabV3L5/FAR/sJMxa3LkDSh3T9ge55hWa
         fheQ==
X-Gm-Message-State: AOAM533pKFBq5JU3sSo5g26wIMaK3uh7mCIKX6HGvoHKrN3KZ52SP/89
        68GzS3LflonAYdDpk7+YB4f5yIHuqtS9KGG0HepgvvVk0Oo=
X-Google-Smtp-Source: ABdhPJwQiIQblb5d+dyK0pxsmpTlywq/pFEwojzTRxxkzrCwzdnHWCfKhVHNXOnPO1XrNs0BhPnwdlawgAbW+WZM4Es=
X-Received: by 2002:a17:906:dc92:b0:710:452d:1b4c with SMTP id
 cs18-20020a170906dc9200b00710452d1b4cmr1997641ejc.219.1654303847486; Fri, 03
 Jun 2022 17:50:47 -0700 (PDT)
MIME-Version: 1.0
References: <a1830e79-9503-3fd9-8c50-a2856206e219@mnementh.co.uk>
 <48bcd99afbca4c73b938c3ed4e104c64@atlas-elektronik.com> <9df6c37e-4c43-7697-0562-c49d4fa5b38f@mnementh.co.uk>
In-Reply-To: <9df6c37e-4c43-7697-0562-c49d4fa5b38f@mnementh.co.uk>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Fri, 3 Jun 2022 17:50:36 -0700
Message-ID: <CAPx1GvcxtvowiLkmihZQX+8-=+5c-zJT3M7OmO_BxO4qqqAMyA@mail.gmail.com>
Subject: Re: AW: git log on bare repository fails if the default branch is not
 called master
To:     Ian Molton <git-ian@mnementh.co.uk>
Cc:     stefan.naewe@atlas-elektronik.com, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 3, 2022 at 2:49 PM Ian Molton <git-ian@mnementh.co.uk> wrote:
> Why does a bare repo even have a HEAD file?

All repositories (bare or not) *must* have a `HEAD` setting.  This
contains the name of the current branch, or, if the repository is
in detached-HEAD mode, the hash ID of the current commit.

In a new repository (bare or not), there are no commits, so there
cannot be a *current commit*. A branch name is also constrained to
contain a valid hash ID, and there are no valid hash IDs, so there
are no branch names.  Nonetheless you are still "on" some branch:
it's just an *unborn* (or "orphan") branch.

In this mode, making a commit causes the branch name to spring
into existence.  So if your new empty repository is "on" `master`,
the next `git commit` you run in that repository will create the
branch `master`. As it's a bare repository, you probably will
never run `git commit` there.

As Junio noted, the current branch is the branch name that a Git
repository "recommends" to another Git that is performing a `git
clone` operation.  This makes it the "default branch". Normally
we'd use `git switch` or `git checkout` to change the *current*
branch and thus change the default branch, but in a bare
repository, we cannot do this (at least not without supplying a
temporary working tree), so you must either use `git symbolic-ref`
or resort to direct writing to `.git/HEAD` to change the default
branch in the bare repo.

The new `init.defaultBranch` configuration setting controls the
name of the nonexistent branch you're on in a newly created
repository. Given your setup you may wish to configure yours to
be `main`.

Last, note that you can re-create this "we are now on a branch
that does not exist" status at any time you like (in an ordinary
non-bare repository) using `git switch` or `git checkout` with the
`--orphan` argument. (Watch out, there's a subtle difference
between these two commands: use `git status` to observe the
index state before committing.)

Chris

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 612281F453
	for <e@80x24.org>; Thu,  2 May 2019 13:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfEBNGZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 May 2019 09:06:25 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37933 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfEBNGZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 May 2019 09:06:25 -0400
Received: by mail-io1-f68.google.com with SMTP id y6so2045081ior.5
        for <git@vger.kernel.org>; Thu, 02 May 2019 06:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=j6YpKCunxVV400zb+fIE4Fic0C/XqC3bpQfojw0ZXq0=;
        b=uDyBnrvMKOBJ///BVDX7k0D9XkemnKmnOHn+3ceGHzNXGmWrkLYXAUCZXAxaKmD9ec
         5Xz8Tc9rS4dVgxTz5okHSHo8myO9XbNtLboC+DFYB+BmpT04tQL9eaRiHZt4itzzqrWF
         KUUGNbLuVvqn7jxHKnuCT7IBvKYJ4f3GTbvtfeUXtIaxqo44UYsmJAgbDqAIZ8/uJIvF
         NNHyXK6rir6I5DV5ltpzlSwyZBuvdIDVLEnA3E+JBPAnczBeGfkaBr7axLeF5gHabPNK
         s9krgPLuho1CHCsGZlfKVaSfr5FbqOMzFHDHm5Gvb14SlpeKZXNo7w4VKJkSsP1Kn3F5
         DTGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=j6YpKCunxVV400zb+fIE4Fic0C/XqC3bpQfojw0ZXq0=;
        b=UXD9WNb+hamM7Np5UizWN9X98rNlnDqtnY6npyt9FfC2iCLZmTil2HsJOPwePaukq/
         aMuUVY5DWvSvBa2m3jkw6qX9FAlYRuS8eA/IW8s5NEcTxxewecC5Oylk34IOGMQxBPtO
         iCoDAEI+NRYxDelj8axz7zKBykLCzC3uNcyHWJC8C3/InEWRnTL3V7EK605mHxczY7lV
         +zyGLyrXSMh4D9kH9OVnPot5d2PNzf/uShzd9SNiAcG2wd4Kerq9UKpBj6h1onVlF2Xu
         DURonG7VuZ+iJhq4OUeiMNie9PmOks9pr4b/Xw2E+qIgqyKJUqFigQJiQlEt9QD8zEDK
         l0uQ==
X-Gm-Message-State: APjAAAVk67fEda5YkIL95lrf35CtM3Dntesw5cOsU/mBYR+VKcUX2QZ9
        E5Jx290M11RuXEB8SQg35PZbGxx/Jl5OeSHtpAw=
X-Google-Smtp-Source: APXvYqz8F74DLi3fJm8psRMMYHymPDuHhdTgGsAHkqFw9Fugp7RJSMfMjxfx8GEoyg+5NJ5DUCZBPYQjRuvailgkOEI=
X-Received: by 2002:a5e:d702:: with SMTP id v2mr2052849iom.236.1556802384276;
 Thu, 02 May 2019 06:06:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAA2qrhBmbSe5R0xQPBZiRcz0MGG=JcF4BjxHqmyeTFNR19FKbg@mail.gmail.com>
 <CACsJy8CJ_PB+QKp-T-yTHNPYgjEEVN39QbnAu4kKzGGcEQ0ezA@mail.gmail.com> <87d0l1qat5.fsf@evledraar.gmail.com>
In-Reply-To: <87d0l1qat5.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 2 May 2019 20:05:57 +0700
Message-ID: <CACsJy8A67x5wtbTe9Zk6URLZOqMNUFaLuNyZSVdYkZ1Z3y=6+A@mail.gmail.com>
Subject: Re: "git branch -f" corrupt other worktree
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     frank kulow <kulow.f@googlemail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 2, 2019 at 7:51 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
>
> On Thu, May 02 2019, Duy Nguyen wrote:
>
> > On Thu, May 2, 2019 at 6:59 PM frank kulow <kulow.f@googlemail.com> wro=
te:
> >>
> >> git version 2.21.0.windows.1
> >>
> >> > /c/tmp/gt (Branch_702091a0)
> >> $ git worktree add ../wt master
> >> Preparing worktree (checking out 'master')
> >> HEAD is now at f534c32 4
> >>
> >> > /c/tmp/gt (Branch_702091a0)
> >> $ git branch -D master
> >> error: Cannot delete branch 'master' checked out at 'C:/tmp/wt'
> >>
> >> #but this is possible:
> >>
> >> > /c/tmp/gt (Branch_702091a0)
> >> $ git branch -f master HEAD
> >
> > I admit I didn't see this. But I don't know how far we would go
> > protecting other worktrees. You give --force and that usually means
> > "Yes I know what I'm doing, don't stop me". If --force rejects in this
> > case, what would be the real force, --force --force maybe, or fall
> > back to "git update-ref"?
> >
> >>
> >> #and the other worktree is now corrupted:
> >>
> >> > /c/tmp/wt (master)
> >> $ git status
> >> On branch master
> >> Changes to be committed:
> >>   (use "git reset HEAD <file>..." to unstage)
> >>
> >>         modified:   txt.txt
> >>         deleted:    txtb.txt
> >>
> >>
> >>
> >> greetings f.kulow
>
> Part of this is "doctor, it hurts when I stab my eye" :) but I wonder in
> general whether users are more likely to expect different worktrees to
> have different views of the refstore, since they way they're created is
> "I want just this branch over there".
>
> I.e. whether they want something closer to another directory with
> "alternates" pointing to the "main" repo, and whether that should be
> promoted to UI that's easier to set up than it is now.
>
> Or maybe something in-between, where they'd expect remote tracking refs
> to update for everything, but a worktree's "master" branch not to be
> touchable by a worktree on "topic".

I think it's a minefield to go with different views on refs. They can
already have per-worktree refs now. Granted it's long to type (e.g.
worktrees/foo/something) but it does help remind it's per-worktree.
And we can probably improve the ref resolution rules to resolve
"foo/something" (or "something" even) to worktrees/foo/something for
example. But going totally custom, I think it's hard to even manage as
a user.

With that said, I think we can technically support per-worktree refs
even outside worktrees/, or the whole refeference space per-worktree,
now. The difficulty will be coming up with some sane UI that can
handle that and not leave too many traps behind. I can't see that UI.
--=20
Duy

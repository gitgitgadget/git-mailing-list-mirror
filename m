Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE99C4743E
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 17:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9968061108
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 17:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233082AbhFHR6v (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 13:58:51 -0400
Received: from mail-pf1-f170.google.com ([209.85.210.170]:46915 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbhFHR6u (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 13:58:50 -0400
Received: by mail-pf1-f170.google.com with SMTP id u126so12321007pfu.13
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 10:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=todG88BXQKXWxxpctu/WD2iy3mt8VeYdv8xWSs7Ezrs=;
        b=nbQkfqRO/US73Xw3AgnYmQpKQa93FqBJwg8czYq1x+hNWgknYfl9GzQ1HXjx5GDb+o
         LF4WRBzqrrnYlgu+QgcAd8jmNb6y6oYW4TpQ8DZ5MVoXkfgFKb1RCKAAzQkxMtG3FMI3
         VTFaJ6mZmiNZrJUaX8GplK1b9nQjpq9IJto8uqtD/bmfCXhrV3SzI8ituZ7S0CvQcC+E
         mR+OaAmaWKUtSGc3W8Hxdc26al17pEVdkNqrJuys7l9j9s5TTYQtqSOcC6sYmXupYXxh
         a5R00uu0wCKDa8+XdH7vKmNI571X75A5+ms0xM7aV/GA+U+Ctkgv2EaWgewx17B+/dOd
         pbww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=todG88BXQKXWxxpctu/WD2iy3mt8VeYdv8xWSs7Ezrs=;
        b=uKKKEUDtbSo3D1nDyK7yj0W+xNubo/p90WEWlTlyKoJCg+3IdqAOhyTATr/peDxrJe
         gcZooy5kGXxrduoTSvToeL4PYNvJUjc4HT04EtyZ9gk+oaCvOYCSc5YhqNee6nA9DR56
         xIRVwI08xKuGh7cg8k76gqwvnG+DMXQZQMOB5g2sxKhRX5DC8pGov8V0eh8UmXCc1n7y
         6bMXNAlLsA5HIqlrHUCqCFA2pUXRtrJaJEYETQDQsRGOn3tUix6igKDIBdJ4AAd/HRjr
         Nxw7nSRzt7mK6GsiqxWzVmGHXg/euF4ZmCMNWGAPDaq5YbaT2cuRVElCPpvn3EELdKjH
         VyNA==
X-Gm-Message-State: AOAM531hmRkieXbn5Bd23s2CS2D0xt/m7ZHqHQiicWNLF4OlMzLMTIC6
        CZe2PK/zT5VsPebG4e+OZdmba8wSALsW3MNK3v4=
X-Google-Smtp-Source: ABdhPJz0ERc0n3P/AwMaROXDdeAP/0FYT5DtWIgABIndfcF4vJokWSfxYV/EQUMQB3Yo6InIU0WFDGDM6KLVB/mp+6M=
X-Received: by 2002:a62:1d0f:0:b029:2d5:3ec2:feb8 with SMTP id
 d15-20020a621d0f0000b02902d53ec2feb8mr1070599pfd.19.1623174942333; Tue, 08
 Jun 2021 10:55:42 -0700 (PDT)
MIME-Version: 1.0
References: <FC56DF49-CEC5-4C9F-BDE4-B0119558E4B2@gmail.com>
 <4a4a3d6f-7d06-ccdb-7d5a-4057c7549927@gmail.com> <CBC56A4C-2D47-4C96-9621-73BCB1119B90@gmail.com>
In-Reply-To: <CBC56A4C-2D47-4C96-9621-73BCB1119B90@gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Date:   Tue, 8 Jun 2021 23:25:31 +0530
Message-ID: <CA+ARAtpm9NHoyiW84tnuXwvh25_du3AQaan11Aciq0gz_8nSuQ@mail.gmail.com>
Subject: Re: [GSoC] My Git Dev Blog - Week 3
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Atharva,

On Tue, Jun 8, 2021 at 12:43 PM Atharva Raykar <raykar.ath@gmail.com> wrote=
:
>
> On 08-Jun-2021, at 00:25, Kaartic Sivaraam <kaartic.sivaraam@gmail.com> w=
rote:
> >
> >> My not-so-well-read guess: Some users want certain submodules
> >> active in one worktree, but not the other. For that, there
> >> presumably exists a per-worktree configuration, and the current
> >> implementation just assumes a configuration that applies to the
> >> full repo. Changing this is definitely a patch for some other time.
> >
> > I get to the same presumption. You could try exploring worktrees more t=
o
> > confirm as you point out. You could also try Cc-ing people who you thin=
k
> > would have an idea of this. 'git blame' could you here.
>
> Yes, I have actually been noting down these "leftover bits" as
> things to look into after my GSoC period.
>

Good idea.

> > > A painful merge
> >
> > You don't mention which branches you were trying to merge but
> > from the context I sort of figured out it was the
> > 'submodule-add-in-c-add-config-v2' and
> > 'submodule-add-in-c-add-clone-v3' branches in your repository: https://=
github.com/tfidfwastaken/git/
>
> That is correct. I felt like adding too many details like that
> might make it harder for someone to get the big picture about
> what happened at a later time (like one year from now).
>

That's fine. Just a suggestion, you could try balancing big-picture-view
and detailed-view by mentioning additional details like this in a footnote.

> > Also, which version of Git did you use to do the merge ?
>
> 2.31.1
>
> Since I'm now a Git developer, I should probably be running
> on a more bleeding edge version, but I have still not got
> around to it.
>

2.31.1 sounds very recent. But yeah, you could certainly try
writing a cron job of sorts that automatically fetches `next` daily,
builds and then installs it ;-)

> > I tried reproducing the merge and it's indeed interesting that
> > even '-Xpatience' didn't do the trick.
>
> Yeah. It looks deceptively straightforward for the human eye,
> not so much for algorithms. Most likely because both the
> patches have structurally very similar code, and many lines in
> between are identical.
>

Yeah. That's very likely the cause.

> >> I still wonder how non-Emacs users deal with situations like these.
> >
> > Git lets you invoke external merge tools which could help you resolve
> > merge conflicts in a easy way. See mergetool doc [1] to get an idea
> > about it. `git mergetool --tool-help` would give you a list of supporte=
d
> > tools. In your case, I happened to notice that P4Merge[2] does a good
> > job of properly resolving the conflict by itself.
> >
> > [1]: https://www.git-scm.com/docs/git-mergetool
> > [2]: https://www.perforce.com/products/helix-core-apps/merge-diff-tool-=
p4merge
>
> Thanks for the pointers. I currently use Ediff, which is what is
> the default mergetool that is invoked from Magit (the porcelain
> I use). Magit is great, Ediff not so much.
>
> > Speaking of resolving conflicts, there's also rerere [3] which should
> > save you from having to resolve the same conflict again and again.
>
> Yes. I had that enabled after learning about it from last week's
> discussion, that lead to it being the default in the next release.
>
> [https://lore.kernel.org/git/xmqqfsxvxjj2.fsf@gitster.g/]
>

That sounds like a good change.

> > [3]: https://www.git-scm.com/book/en/v2/Git-Tools-Rerere
> >
> >> So I=E2=80=99m glad there=E2=80=99s the reflog.
> >
> > Now that you've learned about and used reflog, I thought I'll let you
> > know about `git fsck --lost-found` [4] in case it might come in handy
> > someday ;-)
> >
> > [4]: https://git-scm.com/docs/git-fsck#Documentation/git-fsck.txt---los=
t-found
>
> Thanks for showing me this. Looks very useful. I hope I never
> need it ;-)
>

:-)

BTW, I should've mentioned this earlier. Feel free to Cc me
in any patch related to your submodule conversion project.
I'll try to take a look and review as and when I find time.

--=20
Sivaraam

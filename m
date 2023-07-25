Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A367EC001DE
	for <git@archiver.kernel.org>; Tue, 25 Jul 2023 20:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjGYU2X (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jul 2023 16:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjGYU2W (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2023 16:28:22 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52ECF10F7
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 13:28:21 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-521e046f6c7so551a12.1
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 13:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690316900; x=1690921700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DIlPiXe8D0EeVA+w9InBNsxZuv2R1dGlxwwleBFPtuU=;
        b=qhN1LgCJHFCsXmotIaGCO4VprC1rKDNIfblWyzethMaRp1Pt2E5wbfXuiFU7n+OTvu
         8ewOgMjUscbEunGBThBatuEmChlQnLy7pCbXKWdM5HG3jvq61APTtiH8G/26ZFCWyr2J
         XVOXS+iMjbcjMIOZNv2EDHDUA8jktyCLBAIlz54GU7OC11DQHe1J3GMOucLwmkEwMSCX
         bGLOwFvhKZ6KAxbZP9lU3DHQOqWHl0dJv4HzcadtOPusakjqjin/cahazM3R+UGDdgnU
         NPIvrs1ly+slBuEdGzf6tml/1WeIk9CVNexqKVinF75q2ycsLfacKH98BWKTrSr729E7
         SKXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690316900; x=1690921700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DIlPiXe8D0EeVA+w9InBNsxZuv2R1dGlxwwleBFPtuU=;
        b=bAZQpkz5PEpkZ0MRz15B1Q8UESFH546UYBZH91mNzzMn7RcnkunvjXhQIL3/SKNKDN
         hi//kmnQ0yV2zDPz0HyT8afvYII4KbqbgwLDTPcJMO4DxRv81Q8sCdbgFf3Klxev72GP
         V2sUOHF8ZNeRHuPl4WxrbwCRkSEvxIJZCxQa0W6L5fZt2c6Ja8wbtekfXlwyEmGfBu9O
         5XJtNToNVmePDpUnmBEL1aS/hePG8bb/cX0lLclxi53Y05O8+FvLmezkBFDxTu0xOxjg
         KUjJ783nFIHPtV6/tBXbGZ0HkPkC6IUzYHthnFXufN3CJKaNK5V1xFTbdkAGmahy3yZ/
         CoRw==
X-Gm-Message-State: ABy/qLaZyycID44X9WCgpvFFBGjSl9OO9VSVstsuDKzMiX7/YQ3wuZaB
        Qt8JNFbAZnR2bpf1VyhklFPyKRDDm+T6ii5ZndWE/+Tt1v389iZKkkEAYEBj
X-Google-Smtp-Source: APBJJlFPajtwO8efts8AHD0X7gdbQVfZTqrVWdDmx69oyou/bJyJDpI1I2fykt9wQR3My3VxehtyHfj/k02GPVjMv04=
X-Received: by 2002:a50:d55c:0:b0:51e:16c5:2004 with SMTP id
 f28-20020a50d55c000000b0051e16c52004mr166668edj.6.1690316899631; Tue, 25 Jul
 2023 13:28:19 -0700 (PDT)
MIME-Version: 1.0
References: <CABb0KFF1vqMLa5DLYd_c9sQeZbhkhQ=Q0bE7W41nmMFmNWB4tg@mail.gmail.com>
In-Reply-To: <CABb0KFF1vqMLa5DLYd_c9sQeZbhkhQ=Q0bE7W41nmMFmNWB4tg@mail.gmail.com>
From:   Emily Shaffer <nasamuffin@google.com>
Date:   Tue, 25 Jul 2023 13:28:08 -0700
Message-ID: <CAJoAoZnuLxyQ7ufUTrK4mBJ_4sQoyPCqJD9eeS8XfquWue1xQA@mail.gmail.com>
Subject: Re: includeIf not matching during `git rebase`
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 25, 2023 at 12:49=E2=80=AFPM Micha=C5=82 Miros=C5=82aw <emmir@g=
oogle.com> wrote:
>
> * What did you do before the bug happened? (Steps to reproduce your issue=
)
>
> With ~/.gitconfig having:
>
> [includeIf "onbranch:pr/"]
>         path =3D .gitconfig.for-upstream
>
> where the included config changes commit-msg hook,
>
> git checkout pr/zzz # has multiple commits over upstream
> git rebase -i
> > 'edit' first commit
> (modify it)
> git rebase --continue

Hm, I would guess this is why - in the middle of the rebase, the
branch ref doesn't move, it's only moved to the new tip when the
rebase is completed. However, it seems that we do have some knowledge
of which branch we are trying to rebase:

emilyshaffer@podkayne:~/git [libification-style|REBASE 3/4]$ git
branch | head -n1
* (no branch, rebasing libification-style)

It looks like to log that error, we're using a cached branch name (and
pick that up from wt_status_get_state and eventually
wt_status_check_rebase, which checks
.git/rebase-(merge|apply)/head-name).

However, when we check the current branch for includeif.onbranch
(config.c:include_by_branch()) we're using resolve_ref_unsafe("HEAD"),
which doesn't check the current rebase state the way that the
wt_status_* stuff does.

Does that mean that the config machinery should also be using
wt_status to determine which branch to use? The use case Micha=C5=82 is
describing sounds perfectly reasonable to me - is there reason to
think that doing conditional includes during a rebase based on "the
branch we were in the middle of rebasing" would negatively impact
someone's existing workflow?

 - Emily

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F5FC4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 08:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A51860F6F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 08:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236561AbhHDIev (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 04:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236354AbhHDIeu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 04:34:50 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A547C0613D5
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 01:34:37 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id a1so1496738ioa.12
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 01:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Hrt5cO0QHEfny3cBAOaIiUlW+yWJ5p2H5x2ceaGa/go=;
        b=Y20gCfatc4oHMb84HlG2jvCAHJPZiuxspQqc7ql8XTIqvo9Mp5gDrWYMw0nHFawtYm
         78ediS1NFAzkCr10I9iAHWjU2srGuzmoh1A4IR2G4xvxaCWjLoGXyJB568NZr/cLwZqS
         4SDVkkQxF+P/BKHmT2oki8+GE4ruflIIw8WJlk8eYAQ8wB2VpGZeg7R98iPNvg7rhbiF
         Id6gC5ufB6bD3IwOAvc41kfyjvDpxcwDnugJGuZacPGZh6S0I1UYYnIEwKPieNa+JcSZ
         g8HlnZJeve2wN2T/yvNf2XE3vRD0qbPVR1548aTU2ryDTkDdNrn4EhI0+g3YmxJi3elI
         jt6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Hrt5cO0QHEfny3cBAOaIiUlW+yWJ5p2H5x2ceaGa/go=;
        b=KnvhxC0Nt13im50xa91rOpy3/qk8q15H35/t4R1Z4Kli3pM/UzkNR/mGl3fg2paBs4
         yb1WKYIJbTtFyzaLG5t9pDaDw9cgIKcIrwVmluyKXeYby07NWDdA6a7uKvRtFhgkQltl
         n0tEDa9q029cru++E1L7SzYkLe02tGedKpfUX3iznjcM1qzdHn18W+zqcMz3rHYIzpxi
         XAncUIU3G5H1svI7tukyFo1DK0/V9Z+0W5ezzc0fy6qg9PyvY0/NPSe5D1B0vOgbThj7
         q9ikPnzW7kS+Az1R4a2sSdSMS1Un2FpYQFqthpiNdrSzyxEHP4saEAqG1tYUg3gKVbj3
         jt5A==
X-Gm-Message-State: AOAM533gseSTN1ooqUPF8VdnsfZPhzeKZY8SjaFBp/88eGW/YKqzpTO0
        16AYUXLkHoYlOmS9MObcoN3P1UOWacQWui9IZqE=
X-Google-Smtp-Source: ABdhPJw2trxnsCfKnr95hr/PTq/1e/7CVzZ601ZLdEfQHL9i53mUgcJxJtkqQbGiw3fHiVNWMgv3CWewGJ0DwjSIvtc=
X-Received: by 2002:a05:6638:974:: with SMTP id o20mr9822350jaj.10.1628066076846;
 Wed, 04 Aug 2021 01:34:36 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1010.git.1627714877.gitgitgadget@gmail.com>
 <pull.1010.v2.git.1627953383.gitgitgadget@gmail.com> <5d2fd55c580abc2057f2e6fe9f7d9c94748bf8de.1627953383.git.gitgitgadget@gmail.com>
 <xmqqa6lytat9.fsf@gitster.g>
In-Reply-To: <xmqqa6lytat9.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Wed, 4 Aug 2021 16:35:20 +0800
Message-ID: <CAOLTT8SkbNMcVocU9Lg3PfqTGHVEX8y27BMcP55HytfWH60w6g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] [GSOC] cherry-pick: fix bug when used with GIT_CHERRY_PICK_HELP
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Ramkumar Ramachandra <artagnon@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B48=E6=9C=884=E6=97=
=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=886:36=E5=86=99=E9=81=93=EF=BC=9A
>

> > GIT_CHERRY_PICK_HELP value in run_specific_rebase().
>
> "help realize the rebasing steps" did not tell us much on "how" the
> environment variable helps or what it is used for.  A sentence at
> this point, e.g.
>
>     The variable carries a custom help message to be shown when one
>     step of replaying an existing commit fails in conflict.
>
> may help.  And there is one leap in the logic flow here.
>
>     However, the code also removes CHERRY_PICK_HEAD pseudoref when
>     this environment variable exists, assuming that the presence of
>     it means the sequencer machinery and not end-user is doing the
>     cherry-picking.
>

Thanks, such a supplement is very good.

> Hmph, this is a bit troubling.  So has this been part of the
> "published" behaviour since d7e5c0cb (Introduce CHERRY_PICK_HEAD,
> 2011-02-19) that introduced this test, and there are people who are
> relying on it?  IOW, should the resolution to the original problem
> report have been "if it hurts, don't do it" (in other words, "setting
> GIT_CHERRY_PICK_HELP will remove CHERRY_PICK_HEAD, so if you do not
> want to get the latter removed, do not set the former")?
>

You mean that cherry_pick with GIT_CHERRY_PICK_HELP suppresses
CHERRY_PICK_HEAD is not even a bug?

It is reasonable for `git rebase -p` and  `git rebase -m` to delete
CHERRY_PICK_HEAD when a conflict occurs, but it is not necessarily
for git cherry-pick to delete it too. IOW, I suspect that instead of
letting users
not touch the trap here, it is better to remove the trap completely.

Thanks.
--
ZheNing Hu

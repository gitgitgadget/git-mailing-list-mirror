Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF7FC4338F
	for <git@archiver.kernel.org>; Sat, 21 Aug 2021 01:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 888F76115A
	for <git@archiver.kernel.org>; Sat, 21 Aug 2021 01:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbhHUBlR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 21:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbhHUBlQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 21:41:16 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F036FC061575
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 18:40:37 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id b7so14532025iob.4
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 18:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=b3ddLDpAJCc2Fj356e5BvvP4s+vZzxwaBPRbz15kEdI=;
        b=Cr2ZJpaNa7BgTEVSXZsQxLm11/1mhhREgJ3n6d69sTtKTKzjOhs1/Ve+W+hdtzFPpc
         UywEeZZyx2+Z2Tj/0joWc7E+JdhOXxW5cpK7+cPSavl4FKiKBUnAm8KOJkXKpEctl2Y3
         Z93badODCc8hoaB96qHKqOy9mXAahGynKk7XbEyCFZCbvEylELETauGPzb2FqDuxvHxW
         S1Zfzonula8Wq9USRG5Cf1yc5gaEDuAJNumx6g5xan3wXYBGR8PayIy6W88PhdZKq89a
         ewj62P2Usy1pNGZfNfQAI3wInbeJZ/Zc2M3e27oJ1j9BxJutXtZC9DMCxcuo+J19dZAm
         2XuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=b3ddLDpAJCc2Fj356e5BvvP4s+vZzxwaBPRbz15kEdI=;
        b=rIUm9AebHs7FoSKIggvygRBS2PcMkXHBds7l7CVa1JSGS1LB+xYZ+83JtcqkSZsxLc
         T5Ok+nEFHJqX4vukPxmqVEgb0ZPQpUO1UHEyo/o/yqaRzUHFUklJLjQAjOwwwKfBKBfu
         kNREqTXWDS6yAPQKlfud6G95UXoo3DzVnX3kOKpb2RGsk6IkC7LHLatDyEbM3EHogvhP
         BksyOTMJo7xpQDCBBg5VVCUozVCyusZOmDiKvxtMCbof4F53ouS52k8bGldTXSw9NpOG
         mRp+DjyjQGhI7uCOmppRfdo3WoRukVSRJ+qu+2pNJsRFrnpqWEc3E71hQRmzXf5UzXU9
         417w==
X-Gm-Message-State: AOAM5331H2ZFkozws8j0L5tc9zrdpjd4hfmcdWe5rYwuKhdATsegLsjb
        GqvxIfwOi7+tAjw2/B5WB92dsL2xgigYW0rva4E=
X-Google-Smtp-Source: ABdhPJw6v6P48MxxTCdMGiBbDG8E1V0pJtEnh2rkHL76xQLdNAQQP8xigvYpwBU5PcGNKIt7sQuL3GU70Ovw4tnasH8=
X-Received: by 2002:a05:6638:974:: with SMTP id o20mr20134169jaj.10.1629510037369;
 Fri, 20 Aug 2021 18:40:37 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1010.v5.git.1629075306706.gitgitgadget@gmail.com>
 <pull.1010.v6.git.1629352277151.gitgitgadget@gmail.com> <xmqqlf4x2weh.fsf@gitster.g>
In-Reply-To: <xmqqlf4x2weh.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sat, 21 Aug 2021 09:40:27 +0800
Message-ID: <CAOLTT8T3=GCvkdiXvO9wprXRoDJ58P_CZBjJ2YDQVHv_eCiXqw@mail.gmail.com>
Subject: Re: [PATCH v6] [GSOC] cherry-pick: use better advice message
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

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B48=E6=9C=8820=E6=97=
=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=881:10=E5=86=99=E9=81=93=EF=BC=9A
>
> > +             else if (opts->action =3D=3D REPLAY_PICK)
> > +                     advise(_("Resolve all conflicts manually, mark th=
em as resolved with\n"
>
> Do we need to say "manually"?  Dropping the word would make the
> message more concise.  Not repeating the word "resolve" by saying
> something like "after resolving the conflicts, mark them with ..."
> would probably be a much better phrasing, too.
>

Yeah. Note the $reslovemsg in git-rebase--preserve-merges.sh, I copied
it from here. Perhaps it is also worth modifying?

> > +                              "\"git add/rm <conflicted_files>\", then=
 run\n"
>
> <paths> (or <pathspec>) not <conflicted_files>; you can resolve many
> files in a directory and give the pathspec to match the directory to
> mark all the files in there as resolved.
>

Indeed so.

> > +                              "\"git cherry-pick --continue\".\n"
> > +                              "You can instead skip this commit: run \=
"git cherry-pick --skip\".\n"
>
> Inconsistent use of prose in the above and ": run" here.
>
>         You can instead skip this commit with "git cherry-pick --skip"
>
> > +             else if (opts->action =3D=3D REPLAY_REVERT)
>
> Likewise.
>
> Thanks.

Thanks.
--
ZheNing Hu

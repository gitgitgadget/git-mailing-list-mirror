Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D506C64EC7
	for <git@archiver.kernel.org>; Tue, 28 Feb 2023 14:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjB1ONa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Feb 2023 09:13:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjB1ON2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2023 09:13:28 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2095E22DF3
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 06:13:27 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-536c02eea4dso276631787b3.4
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 06:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pIvaCxpba8HtF7s5+NCKQb9jtos0GkvlDjTFJHVAtLY=;
        b=G+jQPn+r8uu4LCXGORLu4Swar1UG1Tkte9NmLR7aiai93wr9GTuL+l1ont7DVRbpmq
         m4aXTO79Obt/FwBKBSseP8j006gS4khqHsC8wEi19gYEfROrRKfCkV03X5Nz4C3VQNX/
         +VA4JakLfbFEWgsmGG+Hh+700IjL2RhjH0cd89uxJ6IZulGc/WSpYruegpM5UXPFoJOk
         ByvOwy0YL7AthJk9i40m1WK9KsZXuGl/giU4poFsj2mbFmXupNiqqyrH5FHX293TizaV
         W+lSAgRD8IhFbVRrgNNDOVISyk1MKeLQTmaKgB+9WX48uSVTW/NxJZB/noVZbu/hyeOn
         Qu0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pIvaCxpba8HtF7s5+NCKQb9jtos0GkvlDjTFJHVAtLY=;
        b=24b90vbxabBsJp+grRPGpH0Z/L8uKw3n2TxDSOuZlXKomSMQFOYKToZCuEIqI5Orq9
         EjUoQnUkuKwPDxivVH+uPsJzEcrsomskVJbQbDZnEbmQHl/o1hsVvytfwi2mj17fNyN8
         UGS2xaKG33VzN9kdUHH9Ezw7CCvHJHDyPuDiHgsW1yD1NgO0Xuq3p25M/g00Qws0kgDf
         xr5TaORvvoj9ePM6pYt1xIr+SN8A13xH7nlqqD/skbEDRROblJe2qCCHxI53PJRYtbGW
         eGArR/opIeh9qlTS4RLZ2rWiKXIXDKOT02m4/6dB2be5+LFmDBMZHBX7OxqY8zIS0RI7
         ioCQ==
X-Gm-Message-State: AO0yUKUC811FTU4oSUgJAM8dIUwDFEIZfe0W9MyqMaQx6EO8gnzt7JDD
        yX7gfNokiHOg9/e1YIPtlI9KodtHdM35Vnt42hB5KM+Px1w=
X-Google-Smtp-Source: AK7set9N8D8eSgQYWbr443ABLe/Lsdqbh3dPVDZNJcHVjPC7BEzDsA2MOHViWQj0HV3MhIPe/2FzE47zIE/H3O7fiyU=
X-Received: by 2002:a81:4523:0:b0:52e:ee55:a81e with SMTP id
 s35-20020a814523000000b0052eee55a81emr1737576ywa.7.1677593606241; Tue, 28 Feb
 2023 06:13:26 -0800 (PST)
MIME-Version: 1.0
References: <pull.1474.git.1675614276549.gitgitgadget@gmail.com>
 <CAMMLpeTPEoKVTbfc17w+Y9qn7jOGmQi_Ux0Y3sFW5QTgGWJ=SA@mail.gmail.com> <CAPMMpogFAR6cvcR8T5fx+AoytAJ7TsPpSeOjHNzW4Gmkuq7FLQ@mail.gmail.com>
In-Reply-To: <CAPMMpogFAR6cvcR8T5fx+AoytAJ7TsPpSeOjHNzW4Gmkuq7FLQ@mail.gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Tue, 28 Feb 2023 08:13:14 -0600
Message-ID: <CAMP44s1_Oy8GzoALnvQMJEVRkDB3EBmn4drTyY6T+9BatRpjUA@mail.gmail.com>
Subject: Re: [PATCH] pull: conflict hint pull.rebase suggestion should offer
 "merges" vs "true"
To:     Tao Klerks <tao@klerks.biz>
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 16, 2023 at 7:33=E2=80=AFAM Tao Klerks <tao@klerks.biz> wrote:
> On Thu, Feb 16, 2023 at 4:22 AM Alex Henrie <alexhenrie24@gmail.com> wrot=
e:

> > Now, this is not to say that there's no room for improvement. I like
> > the rebase=3Dmerges option and I wish everyone knew about it because
> > there are situations where it really is the best option. I suggest
> > leaving the existing text alone, but adding an additional paragraph,
> > something like:
> >
> > Note that --rebase or pull.rebase=3Dtrue will drop existing merge
> > commits and rebase all of the commits from all of the merged branches.
> > If you want to rebase but preserve existing merge commits, use
> > --rebase=3Dmerges or pull.rebase=3Dmerges instead.
>
> My primary motivation with this pull request is to reduce the
> incidences, out there in the world, of people copy-pasting "git config
> pull.rebase true" into their command-line, and causing themselves
> major headaches days or weeks later. The "--rebase=3Dinteractive" part
> is secondary (to my concerns), because it's much less copy-pastable.

That's because the whole approach to the pull.rebase configuration is
wrong. I explained why multiple times in countless discussions and git
developers did not listen.

What we need is a pull.mode configuration that is *orthogonal* to
pull.rebase, then everything just works.

For example, you could have this configuration.

    git config pull.mode merge
    git config pull.rebase merges

Then doing `git pull --rebase` would do a merges rebase.

This is not possible with the current approach, which I objected to.

Then there's no problem with telling the users to do pull.mode=3Drebase
(or whatever), since that doesn't override pull.rebase=3Dmerges.

I programmed and explained this precise interaction with rebase=3Dmerges
more than two years ago [1], but nobody listened. For an example of
how such configuration would look like, see the patches I just sent
[2].

Cheers.

[1] https://lore.kernel.org/git/20201218211026.1937168-14-felipe.contreras@=
gmail.com/
[2] https://lore.kernel.org/git/20230228140236.4175835-1-felipe.contreras@g=
mail.com/T/#t

--=20
Felipe Contreras

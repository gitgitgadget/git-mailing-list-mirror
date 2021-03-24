Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40AEAC433E0
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 04:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07BC4619E5
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 04:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235207AbhCXEn7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 00:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232680AbhCXEnf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 00:43:35 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46088C061763
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 21:43:35 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id g8-20020a9d6c480000b02901b65ca2432cso21817839otq.3
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 21:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zDygX9xmkDChXcXkT1GNNluaRaScPhmXgybbsR927Zc=;
        b=bNyfDl6mnKkCrXU8Bgg+CrJNRh9D5ErY6jJbO8GHKIxiM4Az6p6Tt4EM6Nr8LMOD0p
         kUZIdN6UMS0+zthnoRDIYlA5jZ94tKuE9NqkCw/DWMGuopzWFv26Grw7UlLBxb5nkw+r
         1G8Gws9q1GR4ybbFtu9zyHTGZ2q8EQ/s2bl8PGmoubdlPQBVArDIrZhm0M5H8IMK77Eo
         HhcV4mIs8zQRbgwyTiwHUlqptcSF3mcMO6QoDDE0ylXI3u10kux4NwoNksSL7+6f5JNP
         XWeu0JhkE0WcolK0wM9anAmDJhFUAbu28RMdoRq2pDaT4zshkEhWf/cIi9lp3QWaXXnv
         Js7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zDygX9xmkDChXcXkT1GNNluaRaScPhmXgybbsR927Zc=;
        b=p9M3QgOGuRHZ6uvUTejxshQ1NHPCvucssWwfIROluZEhdoE+PikxvmOaUUuJWnUKeN
         ymz/Q76yOJlAoybWceibngrlFr+erSo7kwOAjgdz6UtCC7kiEx0y+o6I4HDtYUi0wZvr
         5sgiv7VWbo8elSY0MGZk+5T/rwbCfM0tJWXpZ4R9FoBcuDICw/fXWgVjAD5TL0uZamiU
         J00/EjmZaF08tA+zuQJ0J5ZnY57WhmdNKCpAA48qZraCpaXOok1GAzTEjJhFoFO8CZC2
         KdSUMm65nEexIZlSUu/ekcl3Z9sJ3XcFt8VIVOr2oUnM/kFcAhJ9sqorKMAIlxPsGdNX
         VrKw==
X-Gm-Message-State: AOAM5334Th8zTolJm9OsP+WnBIFhN4h+NQw1uT3uoXVgB67M7zruVuGo
        rzJ3/STIELquzT73XcaxStbkvjU7A83AKDVD72y3LuRbJgWvQXfs
X-Google-Smtp-Source: ABdhPJyNGL5oTT7WXR3BqARGxl2TDlonSK5XW4eB05fmrrok7USzIguWN+XK2beIeFTkWd8uNmgas73ONvkM3oiuQT8=
X-Received: by 2002:a05:6830:8f:: with SMTP id a15mr1470949oto.299.1616561014647;
 Tue, 23 Mar 2021 21:43:34 -0700 (PDT)
MIME-Version: 1.0
References: <pull.885.v9.git.1616317225769.gitgitgadget@gmail.com>
 <pull.885.v10.git.1616497946427.gitgitgadget@gmail.com> <CAPig+cQJ6q21PB9rBuw13q-j-YAEKz5bmk7_+yXQtggqHzRRcw@mail.gmail.com>
In-Reply-To: <CAPig+cQJ6q21PB9rBuw13q-j-YAEKz5bmk7_+yXQtggqHzRRcw@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Wed, 24 Mar 2021 12:43:21 +0800
Message-ID: <CAOLTT8TUWF4nF31HDxRm40npJVzMvG6fewUDh5dhUoBDP0oEwQ@mail.gmail.com>
Subject: Re: [PATCH v10] format-patch: allow a non-integral version numbers
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=8824=
=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=8811:59=E5=86=99=E9=81=93=EF=BC=
=9A
>
> On Tue, Mar 23, 2021 at 7:12 AM ZheNing Hu via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > [...]
> > Allow `format-patch` to take such a non-integral iteration
> > number.
> > [...]
> > Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> > ---
> >     [GSOC] format-patch: allow a non-integral version numbers
> >     A rollback was performed again under Eric's suggestion.
>
> Thanks. I think this version addresses my previous review comments.
>
> I did not find anything to comment about in this version.

Eric, Thanks for all your comments and guidance! :)

--
ZheNing Hu

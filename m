Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD54FC07E99
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 19:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E1DC61961
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 19:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhGETl7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 15:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbhGETl6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 15:41:58 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDC3C061574
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 12:39:20 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id h5so8906003vsg.12
        for <git@vger.kernel.org>; Mon, 05 Jul 2021 12:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3BSExrnvNjvJ4rkmD+vArYnzINht7Bwj6gIw9z/KLb4=;
        b=t6mlNp/tIM1DSxEhdnZhZUQ5qyyz9pkFzOpl75Z+EhwY43Ye16BxUbQjpU6Wi3ge0U
         /DSk/HaSDAoDQy8Er5LluYgkNpQkAX1M5pbsWBvzOZwaEtQTfTPSA1zUXjEtfcglHuO6
         Z+30OwrRzQUl1T4XD7UQ+kvuyvfebo1yGbiNGRsB/6vrV/e/yBQhMWl5peQwvuI13WMm
         ZPwb6zGktyjBbcOokbbm+4SKpcGJHfeaBU+Fc1MQ80cgMIGZMsVkNhdb7uUOxESMiJr+
         hHvkMNw3+D3+4giFrb+MDm6GVxDwp76NDRsCBeoZlpNHK8VCyOmyMG9t7a/jjw2aS/rz
         fJpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3BSExrnvNjvJ4rkmD+vArYnzINht7Bwj6gIw9z/KLb4=;
        b=EFMGhLifTM5wAHK+PiOQe9FsrJrTOmR4vYn8yV7UKmKBGCCGo8glWME9evUW2kW9xe
         Flcj/i9fbQd/Mp20er1gcRO9pEFlcvPnDfta3pXcFXfZfPTEV+gqzoVUhZfqujqTBMTT
         vcDz5D56VOfi7j3TqsuaCf0GHR5+x+qv/NFoNZVqFDgsz31GeEZG7XdDMjKimpK/myX6
         58exqIaSQV64NS2Zwx0/55P8/RIvqmNmkWRIdXpRD3FZBOlPSnoV3Mh9Yhl3g/CbbqpO
         GTHuJy6MjlYklML765aCEg4zvcqfWm6YOfK2BwfV+kXauf0OqFdsNnayrhLPY1aI0GDK
         DxQA==
X-Gm-Message-State: AOAM533CYFfznYFVeOqwYbByO/Ywwjn5HrlconYG+7dixFSVVhoaTI8j
        JKqC+4PMM9uTKqVqqtmNCZfQ2jyRDaXPv8S3yb3ZjQ==
X-Google-Smtp-Source: ABdhPJyqfXyVdHkYSZcnmt24hRKZtJ4pMAjFc66UtM9YeJy0PWdVEGExkylogLIy7Ezyh1ttrBcxumWtypGyE9SlhpU=
X-Received: by 2002:a67:6992:: with SMTP id e140mr11317838vsc.2.1625513959617;
 Mon, 05 Jul 2021 12:39:19 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1012.git.git.1619710329.gitgitgadget@gmail.com>
 <pull.1012.v2.git.git.1623329868.gitgitgadget@gmail.com> <2a9ebe43deac3da9baf241ff1e494f8210c27981.1623329869.git.gitgitgadget@gmail.com>
 <8735sydvzs.fsf@evledraar.gmail.com> <CAFQ2z_OeO8ALHPv6JzL2UDWqEb6Um8e8nPYMWBH8mmaMvibMhQ@mail.gmail.com>
 <877di47e2j.fsf@evledraar.gmail.com>
In-Reply-To: <877di47e2j.fsf@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 5 Jul 2021 21:39:08 +0200
Message-ID: <CAFQ2z_MuZJ7FmaZ8pjb51dhSHuHYipesHn8hum3Af49qwiZL6Q@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] refs: explicitly propagate errno from refs_read_raw_ref
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 5, 2021 at 9:31 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
> > and the case you pointed out is the only one which inspects errno
> > after calling resolve_ref_unsafe (transitively through the grepped
> > functions.)
>
> Isn't the `errno =3D=3D EISDIR` in files_copy_or_rename_ref() another one=
?
> It's just after calling refs_read_ref_full().

no. It's handling the EISDIR for refs_delete_ref.

> > I'll take from this review that I should elide the part where errno is
> > cleared, and leave it to someone else to figure out a more holistic
> > strategy to error reporting.
>
> ...or if we don't clear errno introducing those sorts of subtle bugs
> when we use reftable instead of the files backend. I.e. no, we really
> should be clearing errno, if not in this series then in some other
> pre-reftable series.
>
> To not do so would be kicking this particular can down the road, and
> leaving those bugs for reftable users to find. Which given that I've
> found a few cases with no test coverage...

too late :-)

I've already kicked the can down the road by not clearing errno in the
current version of the series.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado

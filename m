Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193D2C433DB
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 09:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBAC364DB1
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 09:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhBEJqZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 04:46:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbhBEJnm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 04:43:42 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09E0C0613D6
        for <git@vger.kernel.org>; Fri,  5 Feb 2021 01:42:56 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id w124so6823106oia.6
        for <git@vger.kernel.org>; Fri, 05 Feb 2021 01:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SayrXfWZzRp+Xrzd1dWdPqi1qjfCovblBw+32zGYt+4=;
        b=XNunXoTlH21tNJ8JVPaxFVw9rCp4Ph7MP2IwA2Z0GPuM2AD+pDuwLcbqU8qjwn856x
         3rkkobZz4KxONGZyoWfjp0BJSz4rTrGmU03s2oBYckabDGQM6Gu8JSc1CeTQaXr+nvH+
         DepCIamyauH58YKG03ANSi+dRUhFStGdRO5VTEdv+QrbmuDsKOim1OShHVh/InF4ig3+
         HmVykONRVFLjVPXvjGOFB2uN9ABzYtd1V04Ii5bJqTWJcElWKHKkblX4YOLuuMDp9Ia9
         rcLQN7Ej6ghOO+hHaBA6oGkStmID0Vdk218ONvd/R5nhmvn55b1uwE7CDbqgwD1WpZjH
         CcTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SayrXfWZzRp+Xrzd1dWdPqi1qjfCovblBw+32zGYt+4=;
        b=GeRmpskvF/Ckc4t3MqgswXSHGljDIbsAkxfgT3AAb77K7np9gDpB8mmu8VlTKHfiIp
         RrKQmkie0ajdoYHr84JmIp9lbig9YNuEYGurYluMh6NqBgS6uUt2esBtaGEFfefbtMIa
         Rrr5otQPqGLH6Yz/elxmJPx0382pekgSyIa71Ri/Wsq2vZ/cNv5eugPyQPLAsq5p5olf
         w3U/xWbmesOT25rK9hLmwl0HaGnBqBCGJ2UJKIagVKf+Z0WZaT0yl7PcaIKDvSgSABE3
         2zDSluqc4eWK05zcbvYmWztaPk8/isZAxEGYN+A0P2MCoXgd5/xJwH0UJcCrXxNv+dJX
         R0YQ==
X-Gm-Message-State: AOAM530gBHDlygxVZzQIRduCxQ1PYEA9EjMjwnnls/iyj0IdpGg/DxjH
        WgD0boM0+gmre/DWQVSsDwJm5gVROM/D4JwTl1E=
X-Google-Smtp-Source: ABdhPJz47LbOx29/W24zR9idK6fqQ5azKxsrYvqsNw2Fm3xceAUr3F7RSU8Sg97nm9P6TPMO3TNUbiHVk8oOrvmUlDU=
X-Received: by 2002:aca:b255:: with SMTP id b82mr2435496oif.98.1612518175994;
 Fri, 05 Feb 2021 01:42:55 -0800 (PST)
MIME-Version: 1.0
References: <20210129182050.26143-1-charvi077@gmail.com> <20210204190507.26487-1-charvi077@gmail.com>
 <CAPig+cTj5erQ6GoikwU7aeJTH0+QCC2SqkSuZ_T=n0LVxf1pBQ@mail.gmail.com>
In-Reply-To: <CAPig+cTj5erQ6GoikwU7aeJTH0+QCC2SqkSuZ_T=n0LVxf1pBQ@mail.gmail.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Fri, 5 Feb 2021 15:12:44 +0530
Message-ID: <CAPSFM5f0Jk03tWCTerZP1JhcMHG4MXjVSZjPKm2uzQYc+cOwsw@mail.gmail.com>
Subject: Re: [PATCH v5 0/8][Outreachy] rebase -i: add options to fixup command
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, 5 Feb 2021 at 13:00, Eric Sunshine <sunshine@sunshineco.com> wrote:
[...]
> Thanks for working on this and re-rolling. Unfortunately, it seems
> that v4 already landed in Junio's `next` branch which means that he
> won't be replacing v4 wholesale as would have been the case if it was
> still in the `seen` branch. Once patches are in `next`, improvements
> are made by building changes atop them (incrementally) rather than
> replacing them. Whether or not it makes sense for you to spend time
> re-doing these patches as incremental changes is not clear. In fact...
>

Okay, I admit I was not aware of this, before.

> > The major change in this version is to remove the working of `fixup -C`
> > with amend! commit and will include in the another patch series, in order
> > to avoid the confusion. So there are following changes :
> > * removed the patch (rebase -i : teach --autosquash to work with amend!)
> > * updated the test script (t3437-*.sh), changed the test setup and removed
> >   two tests.
> >
> >   Earlier every test includes the commit message having subject starting
> >   with amend! So, now it includes a setup of different branch for testing
> >   fixup with options and also updated all the tests.
> >   Removed the test - "skip fixup -C removes amend! from message" and also
> >   "sequence of fixup, fixup -C & squash --signoff works" as I think it would
> >   be better to test this also in the branch with amend! commit with different
> >   author. (Will add these tests with amend! commit implementation)
>
> Despite these being nice cleanups to the standalone series, I'm not
> sure it's worth spending your time creating new patches to undo these
> from `next`. Removing them only to add them back later is not
> necessarily going to help "unconfuse" someone reading the commits in
> the permanent project history.
>

Yes, I was also thinking that let's not remove the working of `fixup -C` with
amend! commit as it's true that it is intended to work like that way.

> > * changed the flag type from enum todo_item_flags to unsigned
> > * Replaced fixup_-* with fixup-* in lib-rebase.sh
> > * fixup a small nit in Documentation
>
> These changes are still worthwhile and can easily be done
> incrementally atop what is already in next, I would think.
>

I agree, these fixes are required. So, I am not sure but now to do these
fixup shall I send another patch cleaning this patch series(v4) and rebase the
patch on the 'next' branch ? Is it the right way ?

Thanks and Regards,
Charvi

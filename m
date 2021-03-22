Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5A8C433E0
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 21:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C2EE619A9
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 21:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbhCVV4A (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Mar 2021 17:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbhCVVzf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Mar 2021 17:55:35 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD77C061756
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 14:55:33 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id k10so23783657ejg.0
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 14:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H/xYGtC+yEMMFApi5ZnBOvSowR6uTULVvAdvufBXUqw=;
        b=W+23tIvjzhhT89Rj7q+roFOhKrKWbjxtM/qdOXYWvm5ECqE0txAP85Mtp+EBtA7400
         sRjZ5vXK1s7JeOn5NZCBmHV7ReaXcvtVu4ZVXf/IBZ26iri/hnCZApgEzbvnxQ4JrHWf
         yizAA4BUZVStwdr6k1BVjBmZrbYOahQo7pk4+7DOpMxlVZ3Z+n0fuMKD0n7v9nhZskN7
         u8WGgXyarHMH94PrhwMoCZj9M9sI19qf0EE4brlduD7pNIoSuU2JKU1JSNSL1aMIFyEw
         8IUzhgXtbxdNYDnoLZ5dPfAqM+xEwFqCefSTfSTIN4lULOm1Xxly1qMWMMjoVteb28nR
         fD+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H/xYGtC+yEMMFApi5ZnBOvSowR6uTULVvAdvufBXUqw=;
        b=gHo8+zozjq4JP4R5VYWntBa6zSLcvcUoyu3VlgKG9e7j+aYySURdTEpMAdyWGHPJcy
         QIGYEn7dzrG1PyvpJTl8qRzPSHB3jmGj/tuT3fGqaqSH/sNgQMB+n4epk5sAb6bV/PmU
         YmLLVThwcjPsL+E95f2On5n5RFJLAytYfjM/Iii4X6lj98NZIypuFwhDrnysc5+Us5GB
         Gy1ULbnmuLwY1TgWrLVlUgbdLwZdDrLvAAQZgEGBjNTCahrvSkk1tpT11ug0GFQOFEtu
         14yk1hIsQXords8Q7zKe1aCEA2To21qkdOhKbitnX41HUVGTjD3jm3UbnoiqXfSMVBi9
         aSEw==
X-Gm-Message-State: AOAM530ZKCJl3mlX3+h+pRFOuLgqIQG2sLamhbTKPZHQ5OSClSCEWsrQ
        qKYjr//MbkwTEsUFhpNgqknxWavzktIv8KQUj9M=
X-Google-Smtp-Source: ABdhPJxLUC40dyGMv9W+iHZcX49D6CtFytpwSJx5Kw3qB0xiIGzp2lECLY5T8CBG3uhTBj/ZWc1VJ4IHuN+40K7+y/c=
X-Received: by 2002:a17:906:5acd:: with SMTP id x13mr1767784ejs.211.1616450131996;
 Mon, 22 Mar 2021 14:55:31 -0700 (PDT)
MIME-Version: 1.0
References: <pull.901.v12.git.1616247681211.gitgitgadget@gmail.com>
 <pull.901.v13.git.1616387093662.gitgitgadget@gmail.com> <CAP8UFD0rtX0m+fGcvGFtsFFKZ2LVyxHx8dptYFvM9kWnbxEwFA@mail.gmail.com>
 <CAOLTT8Ty5kabU6ivX946=FDWJ4SEXBzPinq2aG5t7Rp9jCCEPA@mail.gmail.com>
In-Reply-To: <CAOLTT8Ty5kabU6ivX946=FDWJ4SEXBzPinq2aG5t7Rp9jCCEPA@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 22 Mar 2021 22:55:20 +0100
Message-ID: <CAP8UFD275WiHC2sUJjsnLd1yonfMO-SVda=BZ6mMkgDxGs959g@mail.gmail.com>
Subject: Re: [PATCH v13] [GSOC] commit: add --trailer option
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 22, 2021 at 11:23 AM ZheNing Hu <adlternative@gmail.com> wrote:

> 2.
> `git interpret-trailers --in-place`  seem like work on git top-dir,
> If I am in a sub-dir `b` and I want to change a file such as `d.c`,
> then I must use `git interpret-trailers --in-place b/d.c` to add some
> trailers.

What happens without --in-place? Are the input files read correctly?

> I think the original intention of `--in-place` is to modify a file similar to
> "$COMMIT_MSG_FILE", so make it run at top-dir, but this is not reflected
> in the git documentation. This at least confuses people who use this
> option for the first time. Is it worth modifying? Or is there something
> wrong with the design of `--in-place`?

I haven't checked but there is perhaps a bug in
create_in_place_tempfile() in "trailer.c".

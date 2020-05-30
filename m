Return-Path: <SRS0=ERGy=7M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1EB7C433E0
	for <git@archiver.kernel.org>; Sat, 30 May 2020 19:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DFAD207D0
	for <git@archiver.kernel.org>; Sat, 30 May 2020 19:05:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gK3XglkQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbgE3TFG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 May 2020 15:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728998AbgE3TFF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 May 2020 15:05:05 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0FCC03E969
        for <git@vger.kernel.org>; Sat, 30 May 2020 12:05:05 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id w3so5449322qkb.6
        for <git@vger.kernel.org>; Sat, 30 May 2020 12:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=v8N4nzVwhBLzU0rqP1CdqLLiZcss4bntopXaf3uKUeg=;
        b=gK3XglkQER9OEiEXzZbdLMCBtqF2HCkcwOGYnL1V1ZGhWm2Ef3OiiGzeoFArfj2Hid
         0YcXP+0ExJkkEQrUL6yrFOvAjdcRhg6mMLfKXA4SOJPLAsxxkHMahUYhb2iMYqcEr76w
         uFmR5GFZ+4oTlem+PulSerhgorGJd67ZvCWNzJ6uKCuGaddh9ZQemZNCrcAxhPQKhDYz
         Rmo9FUHJk5OxL8/CZ4wEUhgSBXUt6P/1TqpCRhtmv29OQnhv0mMBL6lKBZlSk17bKFZ0
         rMcVjXi56kCXMeNiK7jva1QK1HkESZeayuVM4zvC+F0CBpxMHz12gA/UyMxcsSYp0yjc
         3/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=v8N4nzVwhBLzU0rqP1CdqLLiZcss4bntopXaf3uKUeg=;
        b=WuZo6uycAZP6pGe6gdAWzbG5Rc2ccgivdXXXrG/t9DyHBoXgsuJmaqKXyuW8YHxxTA
         3/O5pvPzEnonU3EvnQdjHvW94mMCZhe7XGyZz9JUbb3HXZL4Qf97mD9Kz9LPwRCaYBNZ
         w5fj9HsKZAcUlDnZu3K9xkl9nhlG+NYQVAmPdMMjGcuTX7sZBe958ylLriLULJsBFiQN
         bP59wSWYgFJzupi5vwaDdh7UQCKoAwOy5tvswNBXOdbCBlmajCtunnC11F0lSW4CZsYV
         Z+gGSSULzQSCzOiC7455yXL1oBlH4EWNAT2SNefkrthlyfQIdi8JybJC77GoEqyHkA3G
         nV/w==
X-Gm-Message-State: AOAM530XTSlWO93TDZ7EmTLeTq5AqlMZo2br9W5G/d9bqdCodDdBAVV/
        Wt+nuk9mUCKZlHyjEPtRVpCYj6ESK6EvyGA3OqPFLxw1
X-Google-Smtp-Source: ABdhPJy/3I7VHjBFwZb5xjm+e9sQUiUJaQF/+YQwyJBjnDJvWua07R/zVTP6ESxuyI45Pt+DIBR4AuQgt3WNDPyHZWM=
X-Received: by 2002:a05:620a:1525:: with SMTP id n5mr13201376qkk.328.1590865504806;
 Sat, 30 May 2020 12:05:04 -0700 (PDT)
MIME-Version: 1.0
References: <pull.614.v2.git.1589302254.gitgitgadget@gmail.com>
 <pull.614.v3.git.1590759624.gitgitgadget@gmail.com> <cdc53172b3f073095911fe9f7f5ff8ea6546013c.1590759624.git.gitgitgadget@gmail.com>
 <20200530134923.GB2151@danh.dev>
In-Reply-To: <20200530134923.GB2151@danh.dev>
From:   Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Date:   Sun, 31 May 2020 00:34:52 +0530
Message-ID: <CAKiG+9WxoffdtQPvVk=8nG+Q58VvrCd4T41bP3ef3wn+FV8h4A@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] cmake: support for testing git with ctest
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc:     Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 30, 2020 at 7:19 PM =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh
<congdanhqx@gmail.com> wrote:
>
> On 2020-05-29 13:40:20+0000, Sibi Siddharthan via GitGitGadget <gitgitgad=
get@gmail.com> wrote:
> > From: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
> >
> > This patch provides an alternate way to test git using ctest.
> > CTest ships with CMake, so there is no additional dependency being
> > introduced.
> >
> > To perform the tests with ctest do this after building:
> > ctest -j[number of jobs]
>
> Or we can just run: make test
> CMake will run: ctest itself.
>
> Ah, OK, that's not equivalence. make -j9 test doesn't work :/
>

No, it does not.
make test -> ctest --force-new-ctest-process.

> Anyway, there're test is failing in Linux with this CMake.
>
>         $git_repo/t/../build/bin-wrappers/git is not executable; using GI=
T_EXEC_PATH
>
> It looks like CMake Generator forgets "chmod +x bin-wrappers/git"
>

CMake does not support changing permissions of files easily.
You have to juggle them around to a temporary location and
change the permissions when you do `file(COPY ...)`.

Will look into this.

> > Test time =3D   1.11 sec
> >
> > NOTE: Testing only works when building in source for now.
>
> OK, so this maybe the pain point, let me build in source again.
> Hm, no, I still see the same problems.
> Worse, CMake overrides my current Makefile.
> Luckily, I don't have any changes in Makefile.
>

Please read the next PATCH, it supports out of source building and testing.

> > +endif()#BUILD_TESTING
>
> We can use:
>
>         endif(BUILD_TESTING)
>

The docs suggest that this way of endif() is for backwards compat only.
Not sure if I should change this, as CMake might remove this in the
future(very unlikely though).

Thank You,
Sibi Siddharthan

> --
> Danh

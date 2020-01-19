Return-Path: <SRS0=wBnH=3I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABF7C32771
	for <git@archiver.kernel.org>; Sun, 19 Jan 2020 00:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1DF52467C
	for <git@archiver.kernel.org>; Sun, 19 Jan 2020 00:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KG4m3Xhu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgASAVR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jan 2020 19:21:17 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:45209 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbgASAVR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jan 2020 19:21:17 -0500
Received: by mail-qv1-f67.google.com with SMTP id l14so12445956qvu.12
        for <git@vger.kernel.org>; Sat, 18 Jan 2020 16:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=dOxK2aocbZALRU0ZvXksaOIRUvmaFnIeUX1dq9R4Wpg=;
        b=KG4m3Xhu2lNTdx0ANTIewCOtIT/hMu3pbAlWuLFvvpUGUbA9ZOs5kh7UwH6we6z9hC
         fRwoWB+9nseSlxj+2t7I5xQOouHMvtPF9adFxzldXBt6RSv6DXdbd3sHyI7+sd70ZQqb
         KpYzXNtplz7JfC58g5Fx+5NvUly6rtI7mU8f6PIyoFxXUtcWjKNIPSyLxvzqE6LazjXW
         +zWHiidwt6pPaIdl0HQAmoZy2mst8JqdXD0gFSkHe671kY/A3QFoU99C1IhDt4yT6TWA
         4RfX/0wHKf9aWMM/qy2UEeC0S6p5txK0AbCc4R4nMRbDeBaI/DMC/hCn05mX5knKILi7
         ufSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=dOxK2aocbZALRU0ZvXksaOIRUvmaFnIeUX1dq9R4Wpg=;
        b=UDLTWER4USb9nxKIoY5CckfuFVHce1JrsvWVsEbI8qx1Qn62bXtXgGLI5mqi5At+2r
         FpNXJPH42yenlbcBvcFx+haRtefMkcUd0WdVo4t6L5aQkiz0kloHK6AGaO1HGH38hpTc
         Asd4vLH0TrkdNCHRWuT3tPMQrGE2wIKJeKAZhS982zO2PisIuxPEbgcj7ttSVh0aARaA
         1ZlZ0KtTb8kcXFO4W1Wk7iFdY5c/GPlUbEAZFpGcgNpksARhAOPaxFrMljUheBs8yRCn
         vmUSPZncQrTmW+1W9YL/4q/vbuF51Z+C0gGK2efcZsVJYIUGMdk8jai45aS/euiU4wzs
         Layg==
X-Gm-Message-State: APjAAAXJqG+8tw5Qq3ExPhPlZ72DTsXf5/jDmIoPU4a3DEBIh8ZC+hHE
        WCMZsASs/9KrpxgVeDQAue8=
X-Google-Smtp-Source: APXvYqwBDPSyW8HWmi8s/s6YO7WVUN1XFzm0YJBcPyhIqC5P/aq7qBGfmANO8BcMe5CK8K0livvHpA==
X-Received: by 2002:a0c:eac7:: with SMTP id y7mr14683886qvp.86.1579393276228;
        Sat, 18 Jan 2020 16:21:16 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id w60sm15133483qte.39.2020.01.18.16.21.14
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 18 Jan 2020 16:21:15 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 3/4] t2405: clarify test descriptions and simplify test
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <CAPig+cR82mrG=eiOMtyd3sAAqRRL2FD_VG2+W_j15uhWyx30gA@mail.gmail.com>
Date:   Sat, 18 Jan 2020 19:21:14 -0500
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6C3CA640-EA4F-4D24-BCE3-FCEBB818026C@gmail.com>
References: <pull.523.git.1579263809.gitgitgadget@gmail.com> <6e0e664026757315a337dead8079167f4fb29c4b.1579263809.git.gitgitgadget@gmail.com> <CAPig+cR82mrG=eiOMtyd3sAAqRRL2FD_VG2+W_j15uhWyx30gA@mail.gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,
> Le 17 janv. 2020 =C3=A0 08:56, Eric Sunshine <sunshine@sunshineco.com> =
a =C3=A9crit :
>=20
>> While at it, remove some unnecessary
>> leading directories such that all superproject worktrees are directly =
next to one
>> another in the trash directory.
>=20
> The unanswered questions which popped into my head when reading the
> "While at it..." include:
>=20
>    Why is it desirable for the worktrees to live in this new location
>    rather than their original locations?
I thought it was desirable because the leading directories don=E2=80=99t =
serve any purpose apart from carrying information about what they are =
testing, which the worktree directory itself can do instead of all of =
them being called "main".=20
>=20
>    Is it safe to relocate the worktrees like this without losing some
>    important aspect of the test?
After analyzing the test to see what was being tested, making the change =
and making sure the test behaved the same way, I concluded that it was.
>=20
>    Why were the worktrees located as they were originally? Was there
>    some hidden or not-so-obvious reason that we're overlooking? (I
>    guess this is really the same as question #2.)
I don=E2=80=99t think there was a reason. The worktrees directories were =
structured that way since the test was introduced in df56607dff =
(git-common-dir: make "modules/" per-working-directory directory, =
2014-11-30). Maybe one reason was for every superproject worktree to be =
in a directory called "main", just as every submodule is in a directory =
called "sub"=E2=80=A6

I can explain more this reasoning in the commit message if necessary.

Philippe.=

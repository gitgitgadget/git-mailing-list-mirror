Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909B4C4332F
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 17:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233773AbiKVRks (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 12:40:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbiKVRkr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 12:40:47 -0500
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44168220F8
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 09:40:46 -0800 (PST)
Received: by mail-pf1-f173.google.com with SMTP id y203so15028112pfb.4
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 09:40:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XR9BH3387DG+rzP737wTsyJdtpcn82qP0AWBaBD50zw=;
        b=GaDB5nk4e0sYG3BZiqH+seJCxxae8MIQ6aI0KzV+qwq6rGiCjN9ugUdO8LOKVfbZzs
         WoEb8gjhA1iBCpX4TSj6G9uK9vrS3xERFvYL6zA1DLgW2AWtXDBruVXyGm/1NxeIeLl4
         Z5UQ+KMRJBeHrzEBU13SPfORmzOD5/XZVu+x0RXnT4hDuGT4D4O27LlIlCtbC7YCemXc
         zVVJI7UMSKR3aiiibQ+o8SCxJ99S5T9ocVEJI+ZNvN9YWOESBP4GsXN44PsJeRJYmsw0
         hb0k4PbJCJaBbKBYnIDvMNTM/Pn2Op8Tb0KM8RY/kNFbJjfwvMAgbH7A24RxEhQJaS+O
         s49g==
X-Gm-Message-State: ANoB5plD+oF9AvLxplz1bQcIgN7REk3AlBhU54ma3sylkJrM6cAkGK4p
        dIyI0zxboWHDlDaf/ZSbhDyD+MexMz8nhGH5AfM=
X-Google-Smtp-Source: AA0mqf7EUpMtWWZtMgEK5Uwo/y1H5fkYurp7r2f6fr5T+xbLwRLAUQCJiCkwrhtU8A060dfSo5iHilo4l87mu0OorUA=
X-Received: by 2002:a63:d43:0:b0:477:66b9:341b with SMTP id
 3-20020a630d43000000b0047766b9341bmr4449029pgn.130.1669138845718; Tue, 22 Nov
 2022 09:40:45 -0800 (PST)
MIME-Version: 1.0
References: <pull.1384.v5.git.1668110679098.gitgitgadget@gmail.com>
 <pull.1384.v6.git.1668547188070.gitgitgadget@gmail.com> <CAPig+cRPQ7bmG6+U+oQGGUFiSiHoMMpMk8FDJ7GMJvwCXifa9g@mail.gmail.com>
 <CANaDLWJM1VRivm8VLqxg+w8K-+49E0km6AgOzWzN9X=TgzaEiA@mail.gmail.com>
 <CAPig+cQgu=i6pZTzoNYGZ_6X=DGdmwa=dPhSQVqD+eLCZCGJSg@mail.gmail.com>
 <CANaDLWJ+Suye98QKub9nfnknLEsyQ4PK1LxDkPmzGC_-hApkFw@mail.gmail.com> <CAPig+cTrpnVOW0Y2m5xtPhLudY=rPCn3qPQA0RSso7ueFytZbQ@mail.gmail.com>
In-Reply-To: <CAPig+cTrpnVOW0Y2m5xtPhLudY=rPCn3qPQA0RSso7ueFytZbQ@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 22 Nov 2022 12:40:33 -0500
Message-ID: <CAPig+cQF8vjGNUux-ZMBRxbEd3V0p27oLWZ7k2=mf40kAkWVeg@mail.gmail.com>
Subject: Re: [PATCH v6] status: long status advice adapted to recent capabilities
To:     Rudy Rigot <rudy.rigot@gmail.com>
Cc:     Rudy Rigot via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 22, 2022 at 12:18 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> This basically means taking your tests pretty much as
> you had them in v6, but with a little extra boilerplate. Something
> like this:
>
>     test_expect_success setup '
>         git init slowstatus &&
>         (
>             cd slowstatus &&
>             cat >.gitignore <<-\EOF &&
>             /actual
>             /expected
>             /out
>            EOF
>            git add .gitignore &&
>            git commit -m "Add .gitignore"
>         )
>     '

A minor additional comment if you do go this route and place the new
tests in an existing script...

Although "setup" was fine as a title in a standalone script, when
adding the new tests to an existing script, you'd probably want to
choose a more meaningful name. Perhaps "setup slow untracked-cache
status" or something.

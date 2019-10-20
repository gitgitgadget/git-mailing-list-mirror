Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A11E1F4C0
	for <e@80x24.org>; Sun, 20 Oct 2019 21:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfJTVXh (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Oct 2019 17:23:37 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53844 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbfJTVXh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Oct 2019 17:23:37 -0400
Received: by mail-wm1-f65.google.com with SMTP id i16so11076357wmd.3
        for <git@vger.kernel.org>; Sun, 20 Oct 2019 14:23:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9cEmbGctWj4DUJs7vmRCKdWp8qYlUCl50XGgzmkg+YA=;
        b=QUED5HP9Htec5UO+ptdnYnmGGiN28LtFkPknUhG5iUr4u2M55XJC5En9tweaTiGTXm
         P1bqKcSWsgUpnkD/l68Pz0cow8z0GwK2dHPv4jr+MibAQ0xR/hRtnXXlVY8jgpCU/1bG
         J6YaGrS7YFjYVxeyUvUmMKNBH1qr2N8Rl/yOdh0ewvW2oLI4JHsl2Ga5Jq/G8O/JJ1NJ
         r1kvkRpPOL6MPkwOY2TpE0I+PM5YaMx/ivXEcSCZ/y/INNAogsxiD4mawlsD0qF7y2ki
         HRqokgvhh1j3BKINzAzIphQtQdc6RWAGF4nEO4q7PRnQO4nyVf/WXT2O6fPb54GQ6U7X
         cyIg==
X-Gm-Message-State: APjAAAWh0gxIf27aIWfyp6ZeNvUuCrL1hxMTfPqXt3Y0mNX3ZTez8xb7
        /jJILzBQD/muQBZ8vYmmFJTALHYbSv4ikhLiga8=
X-Google-Smtp-Source: APXvYqzGk5bA/Z9SoZ1njKGt/AdgsjNv9f1GtuYIly0EOJ6bD2HuNDtVrHr1Ywe3xw/Z9Sd8HAWIcGphNUK9GcrdvmU=
X-Received: by 2002:a7b:cd86:: with SMTP id y6mr3116731wmj.101.1571606614192;
 Sun, 20 Oct 2019 14:23:34 -0700 (PDT)
MIME-Version: 1.0
References: <pull.410.git.1571603970.gitgitgadget@gmail.com> <e3343d174008a3fe21c159c197913ce749e21589.1571603970.git.gitgitgadget@gmail.com>
In-Reply-To: <e3343d174008a3fe21c159c197913ce749e21589.1571603970.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 20 Oct 2019 17:23:23 -0400
Message-ID: <CAPig+cRZ07OGB4kKO=fozh8fRnCLa0ZrxuUFD3By9c62DZe9BA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ci(visual-studio): actually run the tests in parallel
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 20, 2019 at 4:39 PM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> [...]
> During that transition, we needed to implement a new way to run the test
> suite in parallel, as Visual Studio users typically will only have a Git
> Bash available (which does not ship with `make` nore with support for

s/nore/nor/

> `prove`): we simply implemented a new test helper to run the test suite.
>
> This helper even knows how to run the tests in parallel, but due to a
> mistake on this developer's part, it was never turned on in the CI/PR
> builds. This results in 2x-3x longer run times of the test phase.
>
> Let's use the `--jobs=10` option to fix this.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

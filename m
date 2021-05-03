Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557B1C433B4
	for <git@archiver.kernel.org>; Mon,  3 May 2021 19:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2430A6101D
	for <git@archiver.kernel.org>; Mon,  3 May 2021 19:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbhECT13 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 15:27:29 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:40957 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhECT12 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 15:27:28 -0400
Received: by mail-ed1-f48.google.com with SMTP id c22so7659515edn.7
        for <git@vger.kernel.org>; Mon, 03 May 2021 12:26:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d6ZMAmeuu/EXf9bYKVPtcQ8Ul0AVriM8TspnARwzubc=;
        b=ezHuvgesWRVu3GH9oY719/9QafoTuNie/cgUTIvCsU9UOIQ1S8+/EGIT1C6FS24k2X
         St2KKmeU6Gn0OgehgWrIeV26+kyKX8GWmRIr3MQmj3lE3t5Ss2YEUblFmOOJGpb3AfXx
         7tWaDRaL/Pk+9s/oo31Fw/QawjL+l7kpOB+DW42IpaQiTsaPo0zEdVcPXX7v/qUpHW0g
         b4u6PEfC1pozJcNYlEtRLIThWDvHXqlPX6pbSF0CzttqxO2l7BtUwnpt7YHgebP9qsaC
         ghwosH+ACuJVs8FQKOX3smyyjZ+Gz3WsNIMuhkVlw48NBXpl9MjDUBQ965iK2+nZ5PpJ
         v+tA==
X-Gm-Message-State: AOAM532JcSV4HicoejmtG/l+LDqWcpBlTfZRUlMUGTG7D2dQCPInLf0y
        Y1mGm3G9iq+o8d1YU5CuKdiEmBaLSCAWXpCcT4w=
X-Google-Smtp-Source: ABdhPJwAyWW9hD1xlFCh4B7OCGzkhVyAhwwX8n5CNlCP1jB+pG4mOMWBcBhr+YVLLltr9dBjeOEyDwIq7prpLA2yQpA=
X-Received: by 2002:aa7:c7cc:: with SMTP id o12mr22183857eds.291.1620069994338;
 Mon, 03 May 2021 12:26:34 -0700 (PDT)
MIME-Version: 1.0
References: <pull.724.v3.git.1601902635.gitgitgadget@gmail.com>
 <pull.724.v4.git.1602782524.gitgitgadget@gmail.com> <dd9237927395ef69663ab376a2da74da4654c495.1602782524.git.gitgitgadget@gmail.com>
 <cda4f200-2400-e915-e995-36eea2a27c11@ahunt.org> <CAPig+cToeuq7S1176ze7kX9krjK1rGMOM-JDznF_Fr_qV09qWw@mail.gmail.com>
In-Reply-To: <CAPig+cToeuq7S1176ze7kX9krjK1rGMOM-JDznF_Fr_qV09qWw@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 3 May 2021 15:26:23 -0400
Message-ID: <CAPig+cT5m+DxcsNGkkVmYTaptt3-S4PV6MX7273kdXhM=_M4wg@mail.gmail.com>
Subject: Re: [PATCH v4 3/8] for-each-repo: run subcommands on configured repos
To:     Andrzej Hunt <andrzej@ahunt.org>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 3, 2021 at 1:01 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>     for (i = 0; !result && i < values->nr; i++) {
>         const char *d = chdir(values->items[i].string);
>         if (chdir(d))
>             die_errno(_("cannot chdir to '%s'"), d);
>         child.git_cmd = 1;
>         child.argv = argv;
>         result = run_command(&child);
>     }

Without the copy/paste error, the declaration of `d` would, of course, be:

    const char *d = values->items[i].string;

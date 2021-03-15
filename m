Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D88CFC433E0
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 22:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3FAB64F5E
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 22:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbhCOWvq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 18:51:46 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:47029 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbhCOWvc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 18:51:32 -0400
Received: by mail-ed1-f48.google.com with SMTP id h10so19236556edt.13
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 15:51:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L8O5e42ABfSCQqC1aN/gfiXKo+GV+52F/DMJVd5PTyw=;
        b=iS3QdPFg+qaJ4vf4BidAf+oiaqN+VEs7FhzA2O7iMHbI/qUo/myYfGG8/q3BCqaA+I
         HoB2ycMVwhysYaM6EFgNANUZJmW7BzlFcBdN/4iYHPZ/0TWLm6exHdbYC9ysZ+f6R+G7
         QIdKgwDnprEDhcWhXEUc02OD0IAE2w1/zguxgbA8duAVXw2ctZrx0gFT4LgIca/oMdV+
         v8TAasLU4ILj7TjDmXEFKFpyTR497upT5A20rStCPJqPf9lGQiqcWchW4sxyT3LNFRQM
         Hk0ZUyb46KlLs/QQrTOXT67VyFG83oqGkVcLQZBv91pFAIAy6tvzNkT00GE8ewB6UJVZ
         DF6w==
X-Gm-Message-State: AOAM530zoPlapGpKVqyyx/b79QSsaHpTFtoi8XFOTS0IYZqdKUxl6vsb
        rLVBtBjyVAQy8T3ZdhVVRvucLXTpJyR3WHuAQAfXP7+VMd8=
X-Google-Smtp-Source: ABdhPJwOl+awhKpq9ZAShiEMmEGZLQp8o3edR3Tn3q0V2QSIPoYUNDNc2BW5tXltm29kof1ouFLL/iVZNH2z8HkwXEY=
X-Received: by 2002:aa7:c551:: with SMTP id s17mr32767182edr.291.1615848691325;
 Mon, 15 Mar 2021 15:51:31 -0700 (PDT)
MIME-Version: 1.0
References: <pull.903.git.1615760258.gitgitgadget@gmail.com>
 <dda5b537a3f0706ebf933e2b2efd996267e9d9b1.1615760258.git.gitgitgadget@gmail.com>
 <CAPig+cT9aAPGzysqAz2OBrZP-7Ci+h+W5wFgnRm8bsde9K6zdw@mail.gmail.com> <CAN8Z4-VFekryNYczJBkFQpkLJngcHJ5JBH0tb5ObNsrc241uSw@mail.gmail.com>
In-Reply-To: <CAN8Z4-VFekryNYczJBkFQpkLJngcHJ5JBH0tb5ObNsrc241uSw@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 15 Mar 2021 18:51:20 -0400
Message-ID: <CAPig+cRzaQuu+GTdTky1vGyO9yCDHoQx2u9XXWm5HCfXAXDXwg@mail.gmail.com>
Subject: Re: [PATCH 2/3] fsmonitor: add assertion that fsmonitor is valid to check_removed
To:     Nipunn Koorapati <nipunn1313@gmail.com>
Cc:     Nipunn Koorapati via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Nipunn Koorapati <nipunn@dropbox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 15, 2021 at 6:01 PM Nipunn Koorapati <nipunn1313@gmail.com> wrote:
> > Unusual 4-space indentation rather than typical 1-tab.
>
> Thanks for identifying - will fix in the next patch series. Perhaps in
> a separate patch we could add a unit test that validates the codebase
> for such style?

My guess is that a test which complains about existing style
violations would not be particularly helpful since it's output likely
would be noisy due to existing style violations. (For the same reason,
we wouldn't want to complain about style violations in tests either
since existing test scripts are full of violations.) What is more
interesting than identifying existing violations is identifying
violations before they make it into the codebase. For instance, you
could run your patches through `checkpatch.pl`[1] before submitting
them.

[1]: https://github.com/torvalds/linux/blob/master/scripts/checkpatch.pl

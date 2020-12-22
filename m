Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AEB2C433DB
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 05:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B1AD23122
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 05:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbgLVFUP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Dec 2020 00:20:15 -0500
Received: from mail-ed1-f42.google.com ([209.85.208.42]:44914 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgLVFUO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Dec 2020 00:20:14 -0500
Received: by mail-ed1-f42.google.com with SMTP id p22so11714464edu.11
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 21:19:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bS3lnhUCwCiVaNO7m+J2XxXoK329z7OjRKl3VZfuMy4=;
        b=hA3lgydTHHayfMRFtjsQ1qDZBESK8ICkmaMP0DkKB6EggOn6ZhJ7xzB7NJl/nI1HNJ
         NClV5Ilt+g9IBx4udeoDRuz0g2KlWHV0T/IiXdb9hn0ivOZvQ0nzEPbZhk+ncJHCFfBi
         ttttelrJJ9p0eVeFIaATQs4NaeJ1ZSJT/cSREd9j0qamo3g1ye73y1wd6C0tIU0GUG7Y
         Q3Ep1VuRyZMvbm0bMKrTDpeRCOa9RebV9v8g5v3RVEny3xtc1Us9Z8dqKBT66/naX6VB
         zwjyoQosbydzwbNdVSMq+7oJZgS/pF8eGFToIQ1qHBn9HsLqq+NDbJkTb28ucTDkZ0xu
         pKPg==
X-Gm-Message-State: AOAM532lyswbTJi0o+su0fDFXLUdJwYGQqwgBY7aRhsoGS54zbSQ3mX6
        E69EsqPF29dacSTsjwksLsmKgaGnI5Dgcavo63YxNKwwsOE=
X-Google-Smtp-Source: ABdhPJwnTGEg1SEU9ZNCgUJNqW2qWY50p8jYXNg4lNYZVIO/BvjeyYOtpwmFHKqpNqN5o33QrE33ttGPa41xdWRSMFk=
X-Received: by 2002:a50:f0dc:: with SMTP id a28mr18996007edm.291.1608614372664;
 Mon, 21 Dec 2020 21:19:32 -0800 (PST)
MIME-Version: 1.0
References: <pull.820.v2.git.1608415117.gitgitgadget@gmail.com>
 <pull.820.v3.git.1608516320.gitgitgadget@gmail.com> <733c674bd1901c931a8917045eb72f661872f462.1608516320.git.gitgitgadget@gmail.com>
 <CAPig+cSaq4vTK7CtvxB2bd0=WTW+d=s0H2RMquyCEf+q0YVn2w@mail.gmail.com>
 <xmqqa6u7m1bu.fsf@gitster.c.googlers.com> <CAPig+cRqa9Y4mEdktdP3d2+PHWanKZ6q6tXfJXEAW9sqcVwHOw@mail.gmail.com>
 <CAN8Z4-UG-watOnJMYUe3KU4JHnmJTxvwKSZ3s2DtBg104PACaA@mail.gmail.com>
 <CAPig+cS4F5fhu-ej5ZVpzLR17AUhxzLRKVZxLuKaMCCk937C1A@mail.gmail.com> <CAN8Z4-WpNuqN=HxL4AQU_+zi4hGhkC18d3ZSOJGzbdkMPkYAMQ@mail.gmail.com>
In-Reply-To: <CAN8Z4-WpNuqN=HxL4AQU_+zi4hGhkC18d3ZSOJGzbdkMPkYAMQ@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 22 Dec 2020 00:19:21 -0500
Message-ID: <CAPig+cR1AUH6w8QBaumFwcbz+0LmzYdP61WtaENGHhSgts277A@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] test-lib-functions: handle --add in test_config
To:     Nipunn Koorapati <nipunn1313@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nipunn Koorapati via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Nipunn Koorapati <nipunn@dropbox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 21, 2020 at 9:25 PM Nipunn Koorapati <nipunn1313@gmail.com> wrote:
> That being said, I suspect anyone in the future poking around with
> this will have to sourcedive
> through test_config and test_unconfig to make sense of it.
>
> I'll switch it over to the test_unconfig option on the next reroll if requested.

Indeed, it's not entirely uncommon to have to dig into the test
functions when writing tests. My bigger concern was someone coming
along and thinking that the mixed use of test_config() and manual `git
config` in the same test was a mistake, and want to fix that mistake,
which would lead the person down the same rabbit hole. Explicit
cleanup via test_unconfig() and consistent use of `git config` within
the test, on the other hand, does not look accidental, so the reader
would be less likely to want to "fix the mistake". The comment you
added in the re-roll above the manual cleanup saves the reader the
trouble of having to dive into the implementation of test_config(),
which is a nice bonus.

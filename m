Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA3D8C5AC75
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 01:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235580AbiAZBPI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 20:15:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235581AbiAZBPH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jan 2022 20:15:07 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A5BC06173B
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 17:15:06 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id v70-20020a25c549000000b006130de5790aso45151702ybe.4
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 17:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KCO9Re8MwfOcf69Q0neQsnHXHuVp615W5lft+HieL+E=;
        b=E8d4fEtUhy0Uo6gZey7rXB/pWI1IN5BETV986jg0UUQxQUcokPfmQBQ3ALJvy5uCId
         5VAwNoaNJIaM6eiVEvhHHwnksS/JUlzKlLfTflK7cngEjhg8ZLw1Vjt1pcMnGPNSC7OX
         p3BQqkL0/baRTigCpZxfBznhjdDftSwvafTykmkWkq9gcYOgQN90DPmJluATrVjjn+YC
         22q5AtbqHch+/PDtqsvhpfOOBDOZOnKj9CxdzHS3B5e3qSGDXQu606Zn0UPD60IVK12A
         aI/fa2Pdjd3+/9vfRtbV30zoPfR1DtsJT3OTVdiAE/hg2ajanHxx/wDlnT1DbeEKXGaZ
         jyHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KCO9Re8MwfOcf69Q0neQsnHXHuVp615W5lft+HieL+E=;
        b=bLrlwk+C7MBXNJWlJvL9DwJAeQM3ZiK92Il2+AambNxfgoUDHraMUOZiFqtnodhNdo
         SZGJC/zkR6LbYxh2JIivWKhRbz831/UL/c9WdVVg0F3PFOG0NiV36l/Hypw8KHWNXVH9
         Eyp4R7s4j9ipSfwBfck5D5caDYO5qvMRNn8YzRP2v5Vd8dPTgIrsdbxS1pDySsgK/AhP
         Rp/nqJUh0D5WK7xkVcWsRVLWyDV5HfYW2Gvy21j2AUqt2Uy3tmjtcLEiX3f/v+K1u6jD
         3tQbqqKDLSMEUbPSpoguCBWRfryzc41591w4p46JkDph0iTs10tktQK72eGotYTKGdf3
         4AsQ==
X-Gm-Message-State: AOAM531Xj9ZeJvhsH0nQoTXjsqsjOTT6Mj7/PPt1k2Yrsyjbh3/xh9zL
        O23/bQr3r63AayXYRzg0sEheEQ51s/eMPQ==
X-Google-Smtp-Source: ABdhPJxuPZuLH2NQtK5KdskqwF7HyVrpPLJUq2EDtXLrGmr9lux/PlMe3vWYysmY89VoX/x0CPQfkt4Pm9hZ7w==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a25:7805:: with SMTP id
 t5mr33081165ybc.277.1643159706102; Tue, 25 Jan 2022 17:15:06 -0800 (PST)
Date:   Tue, 25 Jan 2022 17:15:04 -0800
In-Reply-To: <CABPp-BG2__OLFkOcJnH-V8SC3hrRRrB1zv+KEOiNfoQYB9Ehpw@mail.gmail.com>
Message-Id: <kl6l7dan1enb.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1140.v4.git.git.1638225434.gitgitgadget@gmail.com>
 <pull.1140.v5.git.git.1638340854.gitgitgadget@gmail.com> <f8efb7446c33f14631b088ac043aca8a403a3250.1638340854.git.gitgitgadget@gmail.com>
 <kl6lilu71rzl.fsf@chooglen-macbookpro.roam.corp.google.com>
 <CABPp-BFdD=f82QvQfokD346YT6aCQ=WwZ09S-a=BPXXj5_LZkg@mail.gmail.com>
 <CAPig+cT3Zqa2BLsZ3ZVPCj4-bW5eb35sWXV-mYLqA-dvzC8XJg@mail.gmail.com>
 <CAPig+cRCzUinKr0iQkDMK0Af4=47xKZJKphcuTRxt4BaxrYwfA@mail.gmail.com> <CABPp-BG2__OLFkOcJnH-V8SC3hrRRrB1zv+KEOiNfoQYB9Ehpw@mail.gmail.com>
Subject: Re: [Bug] Rebase from worktree subdir is broken (was Re: [PATCH v5
 07/11] rebase: do not attempt to remove startup_info->original_cwd)
From:   Glen Choo <chooglen@google.com>
To:     Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        "=?utf-8?Q?Ren?= =?utf-8?Q?=C3=A9?= Scharfe" <l.s.r@web.de>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Tue, Jan 25, 2022 at 4:39 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>>
>> On Tue, Jan 25, 2022 at 7:32 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>> > On Tue, Jan 25, 2022 at 6:59 PM Elijah Newren <newren@gmail.com> wrote:
>> > > On Tue, Jan 25, 2022 at 12:27 PM Glen Choo <chooglen@google.com> wrote:
>> > > > +test_expect_success 'rebase when inside worktree subdirectory' '
>> > > > +       git init main-wt &&
>> > > > +       (
>> > > > +               cd main-wt &&
>> > > > +               git commit --allow-empty -m "initial" &&
>> > > > +               # create commit with foo/bar/baz
>> > > > +               mkdir -p foo/bar &&
>> > > > +               touch foo/bar/baz &&
>> > > > +               git add foo/bar/baz &&
>> > > > +               git commit -m "add foo/bar/baz" &&
>> > > > +               # create commit with a/b/c
>> > > > +               mkdir -p a/b &&
>> > > > +               touch a/b/c &&
>> > > > +               git add a/b/c &&
>> > > > +               git commit -m "add a/b/c" &&
>> >
>> > This is entirely minor, but all the inner subshells in this test are
>> > superfluous. [...]
>>
>> One other minor comment: If the file's timestamp has no significance
>> to the test, then our style is to create the file with `>` rather than
>> `touch`, so:
>>
>>     ... &&
>>     >foo/bar/baz &&
>>     ...
>>     >a/b/c &&
>>     ...
>
> Ah, good point.  And while at it, we can replace the touch/add/commit
> sequence with a simple test_commit call.

Yes, thanks for pointing that out - I had copied my reproduction script
into the test case without paying enough attention.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A6051F404
	for <e@80x24.org>; Fri, 13 Apr 2018 00:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753118AbeDMAB2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Apr 2018 20:01:28 -0400
Received: from mail-vk0-f46.google.com ([209.85.213.46]:43101 "EHLO
        mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752604AbeDMAB1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Apr 2018 20:01:27 -0400
Received: by mail-vk0-f46.google.com with SMTP id v134so4358818vkd.10
        for <git@vger.kernel.org>; Thu, 12 Apr 2018 17:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NHLQ8sdl/a8urk2jaWG87VSzNuxjV3eQA07iRJ+/fxc=;
        b=SK10mYDtvjGqcNOSzexmxf9wnVrC7/RJwtTxfwnnpIJPjg9v7mKTnBoDxeMSE8+ZVe
         cwdjXIozaBpmU4s9FvRS4/1GYAQpBL0YxZmQmJxWBE/GujK65wHr3mAZ5Yn+NeG9ftkm
         41ObB0CfikH8kbE1qJlE/wZCP1FZ6DgT3l/K84wm6t9zbxC04XwVXPfjm/p4YGk5tnja
         i0sUTZ0brbJVi+ueIHHHsL1zkqjI+0hmAhrDileeq3dtgX12ui7gVfPKja0dN7yqaIlB
         uVt9hLwoPvwPDk1cT6E0vwMg0IKMvNy2ERuUc8ikU+B4sv3BjbRdCIUAz6kuiG430Szl
         oU+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NHLQ8sdl/a8urk2jaWG87VSzNuxjV3eQA07iRJ+/fxc=;
        b=Rh/E4TpvzrLYxSoafMtNxrYwtGG1CrSdPdF85cZWgu6Nfdt1RK/0wR12rN0VM/CQ4H
         tQlgVzjE7gItwuDLR6qhRaVFI4Qzw9xpe1ZgEsy9SeMvur8Vo0KyS1tOO9fN3RtGPaS9
         q6EyitSHqXwQF4OHunyj7Fo6H5Y2uTuKvmjpvc7kg19t/KkYP/tZW+iQ8mZRyAhiszYt
         7BDv/e6yGIDOjB++r88FVeJ2MdE780XWmCyXaMuhx56XVhWVewl2U8rTrVv8qGFF5dv8
         Y0M9isPZJHTPz+WJp9XfejrKu9HEBLBcEG4uTCpn+3WGAQKQgI30s+VHW4+6yL6UB7Kx
         ZYBA==
X-Gm-Message-State: ALQs6tBHCctj1ruZGdbn+x5KLNfrytirl0EF4ifIjE2gvNj+GdJZoQlw
        c11ySxeyR+Y4m2vBejQXbDW3E+qvY8Twip1cBDOXqQ==
X-Google-Smtp-Source: AIpwx49UrTa+D1FT06vBf1sx2j394QmwE5ck3iQoHeY3W597JaQB75XvzPloMFnAwaUj7XweuEiwgom5wVUPJModqoY=
X-Received: by 10.31.65.11 with SMTP id o11mr2168639vka.149.1523577686328;
 Thu, 12 Apr 2018 17:01:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.159.40.42 with HTTP; Thu, 12 Apr 2018 17:01:25 -0700 (PDT)
In-Reply-To: <CA+55aFzLZ3UkG5svqZwSnhNk75=fXJRkvU1m_RHBG54NOoaZPA@mail.gmail.com>
References: <CA+55aFzLZ3UkG5svqZwSnhNk75=fXJRkvU1m_RHBG54NOoaZPA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 12 Apr 2018 17:01:25 -0700
Message-ID: <CABPp-BEHNhv94z0qj0mt4GEtGurqErqzwdH7-PbL21zswkKL1A@mail.gmail.com>
Subject: Re: Optimizing writes to unchanged files during merges?
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 12, 2018 at 2:14 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> So I just had an interesting experience that has happened before too,
> but this time I decided to try to figure out *why* it happened.
>
<snip>
>     include/linux/mm.h
>
> and yeah, that rather core header file causes pretty much everything
> to be re-built.
>
> Now, the reason it was marked as changed is that the xfs branch _had_
> in fact changed it, but the changes were already upstream and got
> merged away. But the file still got written out (with the same
> contents it had before the merge), and 'make' obviously only looks at
> modification time, so make rebuilt everything.
<snip>

Wow, timing.  I've been looking at this independently -- it turns out
to be in the exact same code area involved in the breakage my recent
series caused.  The bug you are observing here will happen with
current git (going back about seven years, at which time it had
different bugs) whenever no rename is involved and the modifications
on the other branch are a subset of the changes made on HEAD's side.

My series (reverted yesterday morning) made this particular code break
in a new, totally different way.  This is a code path that would be
trivial to get right with Junio's suggested re-design of
merge-recursive[1], but the current design just makes this a bit of a
mess, thus resulting in various code changes over the years with
different breakages, each with its own curious flavor of
incorrectness.

Anyway, I'm writing a bunch of test cases, and will try to get a patch
(or patches) out soon.  Pretty busy this week, but I should definitely
have something out next week.

Elijah

[1] https://public-inbox.org/git/xmqqd147kpdm.fsf@gitster.mtv.corp.google.com/

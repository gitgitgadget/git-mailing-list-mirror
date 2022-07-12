Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A45C43334
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 22:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbiGLWUD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 18:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232944AbiGLWT6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 18:19:58 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9996633A0E
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 15:19:57 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31cac89d87cso79885007b3.18
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 15:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to;
        bh=3kUROQwCnZtZgceFpbp/fVl2SpLNKn/eBwJvek17l4k=;
        b=Zi2GgPfSYIUH/77nIzGMIl6n7V8uUROPb3Pg6tmTesQvDPKzfNgEFJV0T0MOf8Dvnt
         sU08cM7gO+IlHTb9AxLJ+ZQjwpsd/WhoufIrcx8p1zWRiMT+3SMXCxt9I6RXeeHz19zb
         sEV8OkjcYteEs3x8e4PEaR9Kn2VpmHfcyyo5+wFLzFlse34MSA/+GSZMEs3/i3m5EINT
         AaUAY1ja10F91i4baWXCHcE3Lbqh2qVKr1z7+oHaQ4R5ntVlBHTeOyQLEX3dc4Vi4DCL
         kqXYS2AsfIsfqLqAjkSRXN2WFUZmj9RAXdxmwnWbBFlFU5sMsdmnx4dw5pRdD8kLDFP5
         GI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=3kUROQwCnZtZgceFpbp/fVl2SpLNKn/eBwJvek17l4k=;
        b=Rae26aa67QTcqsCWjPilOT1ZgLVOs2MxCRP/DManHCnOl1bley947KKj818xOsTbTY
         TWMeokGjAsc5OEkZO8zqnWnr6gZwOTqsV2mda2Zj42Zo5CGUObAxY//8P1v5rKOgd7ZE
         AIqBRM7QsTkFaCTih8i9NJEJHntIigNKMttYOkdTULRGT+/tKiWAJEUJ9YVGtQiqndZ7
         O2aKEF42YvJ4EeZZpBB+92IEaKEd2OR94tRvP9/VOfXDrt9B/sdFejqkG8DTu7WzvZFp
         BKCQI4dzHPKRUYGoRv22bHybW9INWOHlYNQhhK2q6nVz7K9LLpgDrqyBoqM0FW1w3M0p
         cMYA==
X-Gm-Message-State: AJIora+/PtQcKGx/Rft7p+MqQTJupjYn5iODz1RZeo82PsuJgVrzOKNH
        6k3BEl3yQrsuwH6JOltkWdxWL26vcr5Xhw==
X-Google-Smtp-Source: AGRyM1vXPFqSmnTc3+QY23ye5Xibcaq9E/VXK14u+AgrHvZYwTWDNyTibv0Z6lCaO1+VYaeN8R6nDMzeAd8DHQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a81:6a42:0:b0:31c:d418:790 with SMTP id
 f63-20020a816a42000000b0031cd4180790mr644710ywc.26.1657664396911; Tue, 12 Jul
 2022 15:19:56 -0700 (PDT)
Date:   Tue, 12 Jul 2022 15:19:55 -0700
In-Reply-To: <xmqqo7xufee7.fsf@gitster.g>
Message-Id: <kl6lpmia55ys.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <xmqqo7xufee7.fsf@gitster.g>
Subject: gc/bare-repo-discovery (was Re: What's cooking in git.git (Jul 2022,
 #03; Mon, 11))
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Maintenance releases v2.37.1 and others have been tagged.  They are
> to address CVE-2022-29187, a vulnerability related to CVE-2022-24765
> that was fixed earlier.  Big thanks to Carlo Arenas and Johannes
> Schindelin for fixing the issue and helping the releases out.

\o/ thanks everyone!

> * gc/bare-repo-discovery (2022-07-07) 5 commits
>  - setup.c: create `discovery.bare`
>  - safe.directory: use git_protected_config()
>  - config: learn `git_protected_config()`
>  - Documentation: define protected configuration
>  - Documentation/git-config.txt: add SCOPES section
>
>  Introduce a discovery.barerepository configuration variable that
>  allows users to forbid discovery of bare repositories.
>
>  Will merge to 'next'?
>  source: <pull.1261.v7.git.git.1657234914.gitgitgadget@gmail.com>

I have a (hopefully final) reroll planned that takes your
documentation suggestions. I think it reads a lot better with those, so
thanks!

I also noted your distaste for the `discovery.*` namespace (fair
enough). To avoid a reroll-of-the-reroll, I was hoping that we could
agree on something on-list (thread here [1]) before I send out the next
version.

[1] https://lore.kernel.org/git/kl6lsfn656cw.fsf@chooglen-macbookpro.roam.corp.google.com

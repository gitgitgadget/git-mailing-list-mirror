Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24951C433EF
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 23:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbhK2XmQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 18:42:16 -0500
Received: from mail-pg1-f174.google.com ([209.85.215.174]:33750 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbhK2XmP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 18:42:15 -0500
Received: by mail-pg1-f174.google.com with SMTP id f125so4487153pgc.0
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 15:38:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cs5Rrbx3lKm294c+CT9Ekr+dSayN45xayy2ltOoLOcM=;
        b=3dnf3wNbVeSBSomvqmMZmMULOuivUBtcjKC202x7NQjcp7ELssvC4uiamRGqbWdIn5
         IWpbZCUIJUtnWqTrtIeqTyitM8tXMesXJ1i4vkBsVnywd1wO36iIobsGHCvOXTn7atEj
         TZuGUhGVCjE3iWnKBUqZDT6cLscygw0w/L/ffZX+x95Malk0JnnS9S9d+gMNZlKXZax/
         wY2QabcBs9tt+ypZA+jycPCNz0XSIPNlbJBu4EGGQptimRWrG6JOff9N2ht6I8XciaEw
         6mZX4EvYKSTSDe1Bqoh46xF0drUjB5Jv3uw2Hq5nC2Q8rzBkdEL0n3CXdYbrfFLOcJ+s
         lZyw==
X-Gm-Message-State: AOAM533aSgYkrDzOOl3V5aXnGdc8ZuI2zS7RqT3FlX1ekZpEeuwjt/RF
        fiFLVLfBijyksEVZe1u6UCUgF34UVoviys7l7I4=
X-Google-Smtp-Source: ABdhPJzXNEQmGh4+iUJUhziJcI4aevLG3CeKOyxAeWujmmuyzjs8/8DgtvQGRcjWM471MBVv0JmezHu3+66caYgXH3g=
X-Received: by 2002:a63:380e:: with SMTP id f14mr37088242pga.227.1638229137240;
 Mon, 29 Nov 2021 15:38:57 -0800 (PST)
MIME-Version: 1.0
References: <pull.1140.v3.git.git.1637966463.gitgitgadget@gmail.com> <pull.1140.v4.git.git.1638225434.gitgitgadget@gmail.com>
In-Reply-To: <pull.1140.v4.git.git.1638225434.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 29 Nov 2021 18:38:46 -0500
Message-ID: <CAPig+cToMeDdO2jnf18A8gPOZy_Jc=yN-uPTmBSuYJA6O+RMTA@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] Avoid removing the current working directory,
 even if it becomes empty
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Philip Oakley <philipoakley@iee.email>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 29, 2021 at 6:10 PM Elijah Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Changes since v3:
>  * fixed bashism
>      -+         if [[ $works == "success" ]]; then
>      ++         if test "$works" == "success"

This and any other instances in the series should be using POSIX `=`,
not Bash `==`.

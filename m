Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A8A21F461
	for <e@80x24.org>; Mon,  8 Jul 2019 20:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405050AbfGHUwb (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jul 2019 16:52:31 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46903 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732038AbfGHUwb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jul 2019 16:52:31 -0400
Received: by mail-pf1-f193.google.com with SMTP id c73so3504690pfb.13
        for <git@vger.kernel.org>; Mon, 08 Jul 2019 13:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QnG7XIwkdj3jaex5UE+vybzwtHY0wU++p6nPv8fvObs=;
        b=e0G3PKmeF5VtUFySlvh/AE65Wrw/tULOlRdRJq4EW0UIQUJUTBjmM4xBC7cI7DGIl9
         VRSYMnPSRWLNEK8yx4WhJUTdJ+ANVEGtyNq9lUAjT8HKdn1Gqm+kC9ZvcpSsE0yho0Ly
         c91Zlp0jZSBnjnY/JeQHrnOngQ2de+VF1cYS99T4xygjxTHRNDRzgvFEbma8Uw2xsStk
         A9s6WeDuut5ah2H33/bq6E6fvxdJhpA/jqu5Ci1Rrwpr1ogM2GxKChNJhRWN11ihrZGv
         6WvmDvCHO9l1+mq1/0IpSf9ITldHOr7Ltd8ODRYaY5/59A3HUDlinhVel0G+sI25wQWM
         IRAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QnG7XIwkdj3jaex5UE+vybzwtHY0wU++p6nPv8fvObs=;
        b=Dyhj950yCd3ggno/BHo1TRskLVLstY+MMHi+Q+mmptulscNpecqcz5PL7T5QEJCy64
         rr/TPV6j9JJ2izrlAnmpHj4WorHYITwBz8HoiZq2SgYLqWfybSUdTi8duK4KYRtXy4pL
         zqBZNhQwbB1zXvssOA658pwPR41iKujXjEfYUPrk84d0mYaoHwYnsCnEcO8eEnoFSfHg
         CQBgP37JDkIeXxvrb75FQTBdPR3kInqJQAvC1JuPeQ9U2cr/edDO1GowFvll+mBlMS8r
         uQ4TdEFZI2dUzlGTvZ25DMiN3qyRc/NbaVyeAnM76KGKFeulLTwRkqh+ctawFEpKCXLD
         Xb3A==
X-Gm-Message-State: APjAAAX73MjYztrjwVdsk0xizFivXVLtohvAP+AH9MG27ycuxNKmifyU
        epaFmZvYP1FpXJVFY/4vu8P7+FQed+WU6IjaQ/0=
X-Google-Smtp-Source: APXvYqxXE7XEuPQld7FtkQl6rJTSdwwx92Iq5L7gzv9hAwXwmVBl05LhA6lY4bIQA7hHOwWpgBtx0JK9p9xzuaW7gAs=
X-Received: by 2002:a17:90a:25af:: with SMTP id k44mr27698333pje.122.1562619150262;
 Mon, 08 Jul 2019 13:52:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190707000052.26057-1-eantoranz@gmail.com> <xmqqh87wxoza.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqh87wxoza.fsf@gitster-ct.c.googlers.com>
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
Date:   Mon, 8 Jul 2019 14:52:19 -0600
Message-ID: <CAOc6etbwHAAFSM-GwuD8BaC76EQNv+pQ5TgNCWN65DhNfV3KEw@mail.gmail.com>
Subject: Re: [PATCH v1] builtin/merge.c - cleanup of code in for-cycle that
 tests strategies
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 8, 2019 at 2:15 PM Junio C Hamano <gitster@pobox.com> wrote:
> In the body of the proposed commit log message, please finish each
> sentence with a full-stop.

Ok

>
> These bullets are all subjective, and do not add any value to what
> you already said in the second sentence.

Ok


>
> These are facts that readers can see for themselves and agree with.
>
> Something like...
>
>         The cmd_merge() function has a loop that tries different
>         merge strategies in turn, and stops when a strategy gets a
>         clean merge, while keeping the "best" conflicted merge so
>         far.
>
>         Make the loop easier to follow by moving the code around,
>         ensuring that there is only one "break" in the loop where
>         an automerge succeeds.  Also group the actions that are
>         performed after an automerge succeeds together to a single
>         location, outside and after the loop.
>
> perhaps?

I like it.

> > +                     int cnt = evaluate_result();
> This introduces -Wdeclaration-after-statement, doesn't it?

It does! Let me take care of it. (Didn't know about DEVELOPER
environment variable up until... 5 minutes ago?)

> Perhaps just declare the variable at the top of the for loop, next
> to where the local 'ret' is declared?

Yep, make sense

>
> Other than this single glitch, I think the code with this patch does
> become easier to follow.

Great!

Let me come back with v2 during the day.

Thanks!

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9391C1F453
	for <e@80x24.org>; Mon, 29 Oct 2018 06:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbeJ2P3y (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 11:29:54 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35537 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729186AbeJ2P3y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 11:29:54 -0400
Received: by mail-wr1-f68.google.com with SMTP id w5-v6so7351267wrt.2
        for <git@vger.kernel.org>; Sun, 28 Oct 2018 23:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=bCQ2vXEHObnna/QNynHuKszwzIlsiWRZ6asHiCj/0TI=;
        b=vcQAt+E23Q4nemAeN4qRq0KspQ5C6q/o2gGgO6PGrciZa1fVl+1fQv2tJk6SpfhBSg
         62zQBLVM1kNejUBDYmHvVf66+LZWLw7MYLDR/iTMpBcPS5Gp15qR+7+x/oOZmNJow+vU
         zhHbzjP6jXK+vB96SZLrQvxtD8nBlkJCB3+VKc9ng/Whv8avKxMFEF3VNvCWp3YCyhRn
         hRuA6es2bKlS/FyjI6pUqahSd1swN1OcSPc2r5ZLYnZpmeBHvtMcNNJp7S4xnM4GmwAj
         CQPsueNuYoH6Fn/ZZSJHLkZMz01sYKhGmPQnNwuKeybE+pvcKtFybW3RkCkUJHRpTDzo
         Ahdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=bCQ2vXEHObnna/QNynHuKszwzIlsiWRZ6asHiCj/0TI=;
        b=JNj5LFM6b8JTEJOOp0Jk6ky7IOeJcjcQoZc+DkmSRmt+qviGcqHeCiMeDL/2c4uz9J
         YwUtQEQoH/0yvGZyDsralakiUa0TiQx+juY7i5ACqJ8as8shgqwEPrAqwv2OI4A0NqIo
         B7cBjuunyIF6bfDwNACGABK+mgoPa4icUOQJrqppzae2CA70cfx9txKkcyqumPYIkauP
         t6MH2vDJh741n/oJHkzLLeF0C7Ozf9uFlPfU1ITXBawrKJQf8OHjtz9eyko/bUhU7FLG
         ONEipG3kZ5+bKefyb1mrCMWkKScZUYhMwRbPoh5p9L5MpKacjGuVIQ2vPHUbzcCGOj2J
         KpKg==
X-Gm-Message-State: AGRZ1gKsXTqfRm97f4lOisaKwVaoIOHtjjn/zonWo0knK3r0m5OfqBc2
        UpCWhj8e0jnwMkYTMBIhh3o=
X-Google-Smtp-Source: AJdET5esV4/KezXSMyZAnGvfGThqqzyrv1ek0USfSm5Th4qHmVyhDVw3VhsLslydzu+cytMO9AfeGA==
X-Received: by 2002:a5d:618a:: with SMTP id j10-v6mr14358002wru.300.1540795355120;
        Sun, 28 Oct 2018 23:42:35 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id t82-v6sm10601181wme.30.2018.10.28.23.42.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Oct 2018 23:42:33 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nickolai Belakovski <nbelakovski@gmail.com>
Cc:     sunshine@sunshineco.com, git@vger.kernel.org
Subject: Re: [PATCH] worktree: refactor lock_reason_valid and lock_reason to be more sensible
References: <CAC05386F1X7TsPr6kgkuLWEwsmdiQ4VKTF5RxaHvzpkwbmXPBw@mail.gmail.com>
        <20181025055142.38077-1-nbelakovski@gmail.com>
        <xmqq4ldajz05.fsf@gitster-ct.c.googlers.com>
        <CAC05385y3fCdG4fd2ADahoE0iT+a5KvEr846UCUCQZMOtzzYGg@mail.gmail.com>
        <xmqq36sp76kw.fsf@gitster-ct.c.googlers.com>
        <CAC05386YPtB5LmHFq3WrAaZ1vmZaBUdGr9hEbyR8KABzj+CzZQ@mail.gmail.com>
Date:   Mon, 29 Oct 2018 15:42:31 +0900
In-Reply-To: <CAC05386YPtB5LmHFq3WrAaZ1vmZaBUdGr9hEbyR8KABzj+CzZQ@mail.gmail.com>
        (Nickolai Belakovski's message of "Sun, 28 Oct 2018 22:43:35 -0700")
Message-ID: <xmqqbm7d45k8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nickolai Belakovski <nbelakovski@gmail.com> writes:

> Either way, I do see an issue with the current code that anybody who
> wants to know the lock status and/or lock reason of a worktree gets
> faced with a confusing, misleading, and opaque piece of code.

Sorry, I don't.  I do not mind a better documentation for
is_worktree_locked() without doing anything else.

I do not see any reason to remove fields, split the helper funciton
into two, drop the caching, etc., especially when the only
justification is "I am new to the codebase and find it confusing".


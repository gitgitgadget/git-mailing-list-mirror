Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4474B202DA
	for <e@80x24.org>; Tue,  7 Mar 2017 20:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756011AbdCGUlX (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 15:41:23 -0500
Received: from mail-pg0-f45.google.com ([74.125.83.45]:33474 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933263AbdCGUlB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 15:41:01 -0500
Received: by mail-pg0-f45.google.com with SMTP id 25so4545828pgy.0
        for <git@vger.kernel.org>; Tue, 07 Mar 2017 12:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ScMsP6SXQEJ17fZrxu29d5+qJcN0MR8OTZz34oK4J9U=;
        b=HTas+5dKzWIgF2cREx/wqa3Q4iBtSi2yAnNc1lgq7gsZuYY+8YOwfp9OD3GqMteqTs
         wiotaSMYlJPRz2hhCkE0HpVgzRCA/HAfRaq9M17Bl4mY9pmO4FZL4bP0+SWovnS0aiEp
         P48rgHj93/xfSe8p3n5sAG9NLoyZqnptE7mucPyAGwCcqP12wtTEAKFBtv0mH1tIcO0w
         ygD0vjIBcM1HPq4c50Kk7tDUY+qRJ+aOWC7Zldn78qo2/U3ffQeLGWjokmJjmZFXpWJZ
         5sAFfWE6TnKRpTeiz/BCUZUlU7VzWgOg99N3KOaAHsEeWrDLLT8k802vuEE1zGgJItpM
         I1UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ScMsP6SXQEJ17fZrxu29d5+qJcN0MR8OTZz34oK4J9U=;
        b=sDWZOqxQn3NjonKrcPtqlccS4e+7jl8fb/mXniwPoipJkg3//OpbW94hRDXmODtBHs
         bjnoNr6+wOY2zzl3sCIJzBmge8xl/kDGhMJ8BzZCKLaBOeKQN8lVbOsAzQ3JFS3qoTy8
         fWq9w6oX0fcmjvQEAH4G7yy9hPd5skMYSc8XpWfBy4oZNnrCABAj+WXEmyt7t4pSxWR4
         pOGEFU5tAaKJ6k1oNQGV9E7XKtQk6LEI3MgcHw03U02II+84J9PRAhIbmw90A4g9QsTM
         qAGqKhLWLaYvNwO9eBbE+fwJZ9q7wuB4en/gAeeE+xc0WHsyfJEZvDKhOVJfb/q03I2i
         tr0g==
X-Gm-Message-State: AMke39ndsX16CeYQtXs4ISltd8HrgJENtN5HDuwhP5T4DJ+eHhki60963LBI6P2fI3/DxG6cwCM7TMkDPnDT0ugd
X-Received: by 10.98.198.78 with SMTP id m75mr2563125pfg.160.1488919254929;
 Tue, 07 Mar 2017 12:40:54 -0800 (PST)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Tue, 7 Mar 2017 12:40:54 -0800 (PST)
In-Reply-To: <xmqq8toh7wqu.fsf@gitster.mtv.corp.google.com>
References: <CAGZ79kZv=LoP+nG0GVtU_Zi+_SX8_98AXFqzXNh=xM6ASy+=Gw@mail.gmail.com>
 <20170307034553.10770-1-sbeller@google.com> <xmqq8toh7wqu.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 7 Mar 2017 12:40:54 -0800
Message-ID: <CAGZ79kYMZk3sNNjWgp9acQG6z5Q5CnsJi+n7Bvr3EkfbSHasMA@mail.gmail.com>
Subject: Re: [RFC PATCH] rev-parse: add --show-superproject-working-tree
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Benjamin Fuchs <email@benjaminfuchs.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        ville.skytta@iki.fi
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 7, 2017 at 10:44 AM, Junio C Hamano <gitster@pobox.com> wrote:

> So perhaps your superproject_exists() helper can be eliminated

That is what I had originally, but I assumed a strict helper function
for "existence of the superproject" would be interesting in the future,
e.g. for get_superproject_git_dir, or on its own. There was an attempt
to have the shell prompt indicate if you are in a submodule,
which would not need to know the worktree or git dir of the
superproject, but only its existence.

> instead coded in get_superproject_working_tree() in place to do:
>
>         - xgetcwd() to get "/local/repo/super/sub/dir".

Did you mean .../super/dir/sub ?

If not and we run this command from a directory inside the
submodule, the usual prefix mechanics should go to the
root of the submodule, such that the ".." will be just enough
to break out of that submodule repo.

The interesting part is in the superproject, to see if we are
in a directory (and where the root of the superproject is).

>         - relative_path() to get "dir".

ok.

>         - ask "ls-{tree,files} --full-name HEAD dir" to get "160000"
>           and "sub/dir".

"ls-files --stage --full-name" to get
160000 ... dir/sub

>
>         - subtract "sub/dir" from the tail of the "/local/repo/super/sub/dir"
>           you got from xgetcwd() earlier.

makes sense.

>
>         - return the result.
>
> with a failure/unmet expectations (like not finding 160000) from any
> step returning an error, or something like that.

That seems better as we only need to spawn one process.

(This could also mean I am bad at reading our own man pages)

Thanks,
Stefan

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E4561F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 18:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732383AbeGJSXN (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 14:23:13 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53865 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732266AbeGJSXN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 14:23:13 -0400
Received: by mail-wm0-f65.google.com with SMTP id b188-v6so25616326wme.3
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 11:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=asYGmg7vsmqALYTEHR5KP9GJaOO23kSFOJKcgz7xw2w=;
        b=GONhtDHNXB+54vccTNRkF4fhKtPSQX8JQRjaM1wItXWjsB1FcLXxUxX6mIMEEQkHuJ
         pLRlKTDupbHm4zNLJZPPbTBEI0Hl6OFORQaGA9qpcNO2C3ol0qsWhnRLfC8DIzUqi/dC
         ermFccrg8RqbzRl074+t4z6tOxy+EKqj1nPbtPHKyhxRJY4VeY334txoMWpy7irjxktS
         P/zzzx8mlehuqGz2VtymA6YVibFOacNTBHOD2cp0TTZY4kq0+WthGURiso1KbuzcY6L2
         Qi18t6SQqa1HqvQMPTdD8lzSh8WCI5Oz4aR9txlU4J6fFpKMTN+jpMKB34mBU6bhLJpP
         KelA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=asYGmg7vsmqALYTEHR5KP9GJaOO23kSFOJKcgz7xw2w=;
        b=fr6tfag0tQjubMbnH9E7ykodjYcSDJOiw/4yenP+8RJpyYq7plzDwJsmVa9a7VhOOJ
         iChPS7gZ9ZPLTniMVqL1nAbLkZ4ynBX12aYgv9RoCMWR10IIfE2DkHesjORzAfj5h1h9
         zQZ2Wwsah1otg7o7PGO2EocDJTieDBbwo878+DosP5yj/QyA7sj4dtMjxA3aEXN9f2Jg
         tTwaNSW6ZS4yUNl23nTdn60Lo1PoEqJz58EusZAvghmweAI1n9MQkMzaJtXSMGDxiHAo
         tSAIhkQ9Y5xu3oB7Ro7qwz7DptCmnpaz2RqMESFPsc7uWIN+GWOMnYuY24HhAmw2NgHj
         Qj7w==
X-Gm-Message-State: AOUpUlFTA8aSolhQVL9rzeHkJKV1FmMx1GcECBtruG356OoeCRnb9VEm
        1Mqjq5JiebkBdhQAHwV7SDMwxM6x
X-Google-Smtp-Source: AAOMgpcLtCv/3fQaGyKfSc1ujrf+T65ZYjrl7fdKVXEW4X+YCfwnUFRSFVbcQpf/+xDfYccnLxKFSA==
X-Received: by 2002:a1c:b406:: with SMTP id d6-v6mr598845wmf.126.1531245407168;
        Tue, 10 Jul 2018 10:56:47 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id j77-v6sm22852311wmd.19.2018.07.10.10.56.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 10:56:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH v3 02/13] rebase--interactive: rewrite append_todo_help() in C
References: <20180702105717.26386-1-alban.gruin@gmail.com>
        <20180710121557.6698-1-alban.gruin@gmail.com>
        <20180710121557.6698-3-alban.gruin@gmail.com>
Date:   Tue, 10 Jul 2018 10:56:46 -0700
In-Reply-To: <20180710121557.6698-3-alban.gruin@gmail.com> (Alban Gruin's
        message of "Tue, 10 Jul 2018 14:15:46 +0200")
Message-ID: <xmqq36wr7z4x.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

> This rewrites append_todo_help() from shell to C. It also incorporates
> some parts of initiate_action() and complete_action() that also write
> help texts to the todo file.
>
> This also introduces the source file rebase-interactive.c. This file
> will contain functions necessary for interactive rebase that are too
> specific for the sequencer, and is part of libgit.a.
>
> Two flags are added to rebase--helper.c: one to call
> append_todo_help() (`--append-todo-help`), and another one to tell
> append_todo_help() to write the help text suited for the edit-todo
> mode (`--write-edit-todo`).
>
> Finally, append_todo_help() is removed from git-rebase--interactive.sh
> to use `rebase--helper --append-todo-help` instead.
>
> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> ---
> Unchanged from what have been queued on `pu` (ag/rebase-i-in-c), and
> from v2.

With something like '...except downcasing an error message "Could
not append..."', a comment like this is very much appreciated as it
helps readers who have read the previous round and remember what was
in there ;-)

> + ...
> +	if (get_missing_commit_check_level() == MISSING_COMMIT_CHECK_ERROR)
> +		msg = _("\nDo not remove any line. Use 'drop' "
> +			 "explicitly to remove a commit.\n");
> +	else
> +		msg = _("\nIf you remove a line here "
> +			 "THAT COMMIT WILL BE LOST.\n");
> +
> +	strbuf_add_commented_lines(&buf, msg, strlen(msg));

Nice use of strbuf_add_comment_lines() function ;-).


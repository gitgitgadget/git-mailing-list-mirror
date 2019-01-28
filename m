Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E837F1F453
	for <e@80x24.org>; Mon, 28 Jan 2019 18:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfA1SXo (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 13:23:44 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55847 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbfA1SXo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 13:23:44 -0500
Received: by mail-wm1-f66.google.com with SMTP id y139so14954654wmc.5
        for <git@vger.kernel.org>; Mon, 28 Jan 2019 10:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=7tDRvLM7STgCGad/zTsvXkjpndh0ybSa93ShPA6+yic=;
        b=RtCO4G2Je1Oa0U2E5xgMgkL8uijHzH3rNxmVQmxE+FOPCwhkRm5SKUHuwJdvMyclOv
         0swsxuYxr1H88SfEICe/BikT+/t2REK2enwXODZbFA0sr0PvGQ2Xjdsw8RXIGv5Tfx5e
         qlPAmIKFDDNGhO4qCh0IJM8D1/9LAi3Carpwvsjz4hpOkrNlFhIjAcW3jZX5XlvuEFzc
         Dr8YsF2ZydPs7Uws6OPHJG8n9louEi03BDokcJle3sZlTaERW4y2u7qFVNiCvgj+lm4E
         hxQpR0KVv7jWNdz6cgs1D4WXUqfuD9XW/UccQzG97wDx4+K++g7BLXB6EPO17Cue81RQ
         7M1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=7tDRvLM7STgCGad/zTsvXkjpndh0ybSa93ShPA6+yic=;
        b=T6grDV2txUunGnHcTWVGU2eqaWGHgGLaa0OmCyN8zVwxiupMggzuujVHIwzvnqctiH
         t4HiKxyV6CnYTkQempl0N7enSubRRVjlOG0TsF3mpw6WNDKWSXhw/TII/tA46R6vE5Yh
         s87y5UPjdFttnvLjzdJPKzbQ7O+qBDxPbkVYbcMqMhBTT8vBEJDMiWaHpLBhCUu0UMRe
         TnhvZVgijguqHYltqN8oKbtckWCRExXDLxZu4CujEEAxzBeewph7LAv6UrU/5chbJYB3
         mfJ5e6z6WtgZcn/bSE2rtQQnOYJkQ64aQoXQgPZk5mYDPWQg038HD7EsZqMU55GcUMsS
         UU+Q==
X-Gm-Message-State: AJcUukcUnIfXlaUjexTFvOt50JrQdQkbuBUM7utRPenRC0qmRlyqBJrp
        xacUqNePIUyJVpBcsBXdFR4=
X-Google-Smtp-Source: ALg8bN5AdsjOTbXdV45hkqtG1vWgLKTyF97pJ0UQBPdCOyiJCRPoMigAAMZE2I0fydGK+2QBucqylA==
X-Received: by 2002:a1c:760c:: with SMTP id r12mr16905058wmc.127.1548699821814;
        Mon, 28 Jan 2019 10:23:41 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a18sm140471481wrp.13.2019.01.28.10.23.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 10:23:41 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] rebase -x: sanity check command
References: <20190128102620.18222-1-phillip.wood@talktalk.net>
Date:   Mon, 28 Jan 2019 10:23:40 -0800
In-Reply-To: <20190128102620.18222-1-phillip.wood@talktalk.net> (Phillip
        Wood's message of "Mon, 28 Jan 2019 10:26:20 +0000")
Message-ID: <xmqqd0ogbpzn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> If the user gives an empty argument to --exec then the rebase starts to
> run before erroring out with
>
>   error: missing arguments for exec
>   error: invalid line 2: exec
>   You can fix this with 'git rebase --edit-todo' and then run 'git rebase --continue'.
>   Or you can abort the rebase with 'git rebase --abort'.

Hmph.  I do agree that the above makes an unfortunate end-user
experience, but I would sort-of imagine that it would even be nicer
for such an empty exec to behave as if it were "exec false" but with
less severe error message, i.e. a way for the user to say "I want to
break the sequence here and get an interactive session".  We may not
even need to add the "break" insn if we go that way and there is one
less thing for users to learn.  I dunno, but I tend to prefer giving
a useful and safe behaviour to interactive users other than erroring
out, when there _is_ such a safe behaviour that is obvious from the
situation, and I feel that an empty "exec" is such a case.

> Also check that the command does not contain any newlines as the
> todo-list format is unable to cope with multiline commands. Note that
> this changes the behavior, before this change one could do
>
> git rebase --exec='echo one
> exec echo two'

It is very good to check the input, regardless of what an empty
"exec" should do.

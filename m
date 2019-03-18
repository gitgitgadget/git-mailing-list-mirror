Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92FD120248
	for <e@80x24.org>; Mon, 18 Mar 2019 04:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfCRELQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 00:11:16 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45791 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbfCRELQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 00:11:16 -0400
Received: by mail-wr1-f67.google.com with SMTP id s15so27331wra.12
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 21:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=h5ik5UasNPdBWVJveQESSSTTO1F78pfH0peYGmqNi7M=;
        b=OqODs6LpxVqcPS2RAHayM2w7qZ3kXynWKCTJLy60B78dN+yLKTQXv3m4RxWEVASJtq
         4VWxgCYxMz6vDbsoURfqrNO5ogW92LpUCzkSFvo7qP1E1y+SfoqPXXuC5MdOQUrYLHPo
         3rQTFgBzDkw+oAAVEI723ApZTeVj0nTKCTcMvjQTNv0cANZskuFnUwB3dkyKcNQseYI4
         JRNM+CgaH/kwPutj0wZEY0j7CpWX4XowtgkORdgqh/Z3lRd//hOmAmUesUe+uK2LuKsh
         TXVvwtoFnY7wotmvn9NZZbPqc0iahBNkdYMsGaERExlVxbLu/OdKuybBP/fqsqYKn6K0
         cZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=h5ik5UasNPdBWVJveQESSSTTO1F78pfH0peYGmqNi7M=;
        b=X2euRJM/lqGbQWISuRYPfwOSnpqYQDUX4TYEBAOXVeP/nf0sRxu/smrkl8ciSiUXoj
         rTkwG2Lm2U2qUntWDAUGIwdayD3WcJ7QOBTuU+ElTrPj4eBxoqf7lje6FedQ55K9B4O9
         weHnqQAgAmiJyJBOQHJf5F/2zrK2FJ21KUN+Tcz3SkmMS8kqpHQpusFDdscaESHOGvOy
         ODazfKcHm8DxYDBZGGp+4Iy1Of/LTuoc/FnofV5Le5TIwURU1vhvSzTFMsZopCiMVuZW
         tZJrfu94aBIFdtXoPGpiJPsqNEF2pts+jY8TCrQkXUsZhPxT5QluF5ZspaPNvmmITvfT
         8m6g==
X-Gm-Message-State: APjAAAWdEcD3cZDzE1WoQivdnLN9O3HmQ6q10IJUdbXwe9hzpydW35OW
        d3IyetMuH9oSl4kqajk4xKU=
X-Google-Smtp-Source: APXvYqzECvrpIjW5mFuf4icjZkgjVvEJ5qO5W6A4QYuBq7FmQ2ylZ5YVlE31QiAEBYT4ADPY1Q0J8Q==
X-Received: by 2002:a5d:54c4:: with SMTP id x4mr4013626wrv.296.1552882274331;
        Sun, 17 Mar 2019 21:11:14 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id e12sm1828467wrt.94.2019.03.17.21.11.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Mar 2019 21:11:13 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Eckhard =?utf-8?Q?Maa=C3=9F?= <eckhard.s.maass@googlemail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Git List <git@vger.kernel.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 17/21] switch: no implicit dwim, use --guess to dwim
References: <20190208090401.14793-1-pclouds@gmail.com>
        <20190308095752.8574-1-pclouds@gmail.com>
        <20190308095752.8574-18-pclouds@gmail.com>
        <20190313183604.GA27503@esm>
        <CAPig+cQPMZhd-JSxD4Z6pL19qB1bFNu+EvPDh0vADpcaJ0tbqw@mail.gmail.com>
Date:   Mon, 18 Mar 2019 13:11:13 +0900
In-Reply-To: <CAPig+cQPMZhd-JSxD4Z6pL19qB1bFNu+EvPDh0vADpcaJ0tbqw@mail.gmail.com>
        (Eric Sunshine's message of "Fri, 15 Mar 2019 04:19:07 -0400")
Message-ID: <xmqqd0mo6cv2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> With git-checkout, it's very easy to accidentally get into a detached
> HEAD state, so it makes some sense to protect newcomers, by default,
> from that accident in git-switch. However, auto-creation of a new
> local branch is not, for a couple reasons, nearly so weighty a matter.
> First, in many cases it may be less likely to happen since it requires
> presence of a corresponding remote tracking branch. Second, it's
> intuitively easy to recover from it: when git-switch reports that it
> created a new branch, though perhaps surprising, the user would
> naturally know to look for a command to "delete a branch".
>
> And, unlike a detached HEAD, which newcomers may mistakenly believe
> lead to irretrievable loss of work, an unexpected branch creation
> carries no such penalty, perceived or real.

I suspect that it actually cuts both ways.  An auto-vivified local
branch 'foo' that happens to have the same name as 'origin/foo' is
still a different line of history UNLESS the user makes sure the
divergence is reconciled with "push" and "pull" (possibly configured
to "pull --rebase", but that is a secondary detail that depends on
the workflow).  Even when 'switch' reports that it created a new
branch, a newcomer would probably not realize that it is "new", and
different from the branch that the remote has.

>> So if it is deemed to be too confusing to dwim in this
>> case, could we add a hint suggesting the command? Something like:
>> "No suitable branch <foo> found, however there is a remote tracking
>> branch <origin/foo> that you can siwtch and create with `git switch
>> --guess foo`" (or maybe the one without guess)?
>
> That could be helpful if git-switch continues to make --no-guess the
> default, but making --guess the default (as it is in git-checkout)
> would likely be even better (for the reasons enumerated above).

I do not have a huge issue with making "--guess" the default, but
then the user may be entitled to help with an advice message when
the command, especially with the implicit "--guess", auto-vivifies a
new local branch based on a remote-tracking branch to stress that
this is a new branch and different from the history the remote side
has.

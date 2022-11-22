Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20AC6C4332F
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 04:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbiKVETt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 23:19:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbiKVETr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 23:19:47 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9389E12D10
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 20:19:41 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id c203so13233242pfc.11
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 20:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D7I8JxOVOHDbUt+XBc98WsjR+Ri6r1QzylcxoyM83f0=;
        b=OcZgveR23WqgM35tSrTi25ZthGYBwYBDmRa3Di5pE2JztzpoTHj2MbGq+T8bzRIuNf
         8xi/0fHzHW6KV/ZLpS2I7rhyoU+irCdJ1y3v0HJPd2/2DU8Y3bPOS6gu36PGXq3yUa32
         68fpgP27tb4FVBXzlF6R4hgzycmsM7gf5jFhlmcWMrFIXSgpOWNhpqQ0lrc70k7tyljd
         jC5H5gnxmz7z7yYwg4ZHTOTk6oONbbJS4Nr+frQPkqv+qUuHxPD/cQhJSEL4VzaTF5Bn
         bQIonwfwpXzIRPt9cTum3oFeQD9nMlu1U6bZ2F+61ik8tjY5lwIAbjJx00OsLjHq1YfO
         f0cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D7I8JxOVOHDbUt+XBc98WsjR+Ri6r1QzylcxoyM83f0=;
        b=QSvqAoP3dJim/MPwxBMj4hePXWsn6/FS8iQT+dPZZKj0+2DcojuSIbZjwwimB0kwyO
         u5usOjqxwvPAF38yWPpmXozRU97ex1i1dLTrMsRinOxUmxInOkjNYUYOBA0LC59V4aEH
         t12gjjlb1rqwN3ecJ2LBnDpv1Wn/XXwBRuDD7b/80kRSQEcZ6p0FI09QXWynisOlN4eC
         jxY9i7wRKwF0tmTJVNZfbGOe+ElQwJWcrFHS2I7Zmiwwomw8Q8uVH67MOl3Mw5ELHhtd
         zCQW17m0xloQHD9smgiWNcn0SWTi6el6OEqnh2GK/HgOzZAdcH7Jwb0HEUI6xXpzZtG3
         aM4Q==
X-Gm-Message-State: ANoB5plhf9H2gBINKZbymNEY1ol4f5vkXKm95GGr1Jhoj1ceK+huDSn4
        7K7wVY4lHhRaRXwjfRAF4ag=
X-Google-Smtp-Source: AA0mqf7/dHC2HaSLT47AFna9sfrJjoH7FO6xz61iZzKOq8sSdB6Cr1xhNNDiMzvHBpUm7jAKR9Xm2Q==
X-Received: by 2002:a05:6a00:cd5:b0:56d:7aaa:f1ea with SMTP id b21-20020a056a000cd500b0056d7aaaf1eamr3124458pfv.69.1669090780917;
        Mon, 21 Nov 2022 20:19:40 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id y15-20020aa79e0f000000b005672daedc8fsm9453336pfq.81.2022.11.21.20.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 20:19:40 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Git List <git@vger.kernel.org>,
        Kyle Zhao <kylezhao@tencent.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH] t5516: fail to run in verbose mode
References: <20221121134040.12260-1-worldhello.net@gmail.com>
Date:   Tue, 22 Nov 2022 13:19:39 +0900
In-Reply-To: <20221121134040.12260-1-worldhello.net@gmail.com> (Jiang Xin's
        message of "Mon, 21 Nov 2022 21:40:40 +0800")
Message-ID: <xmqqo7szsjs4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>
> The test case "push with config push.useBitmap" of t5516 was introduced
> in commit 82f67ee13f (send-pack.c: add config push.useBitmaps,
> 2022-06-17). It won't work in verbose mode, e.g.:
>
>     $ sh t5516-fetch-push.sh --run='1,115' -v
>
> This is because "git-push" will run in a tty in this case, and the

Right.  "-v" involves redirecting the stdout/stderr of the commands
being run in the test to stdout/stderr in the environment the tests
are run, so

    $ sh t5516-fetch-push.sh --run='1,115' -v >log 2>&1

would have succeeded correctly.  Forcing the behaviour with the
"--quiet" option is certainly a good way to gain stability.

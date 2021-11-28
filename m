Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E23C433F5
	for <git@archiver.kernel.org>; Sun, 28 Nov 2021 18:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358974AbhK1SLd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Nov 2021 13:11:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359061AbhK1SJc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Nov 2021 13:09:32 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01EB3C0617A2
        for <git@vger.kernel.org>; Sun, 28 Nov 2021 10:02:24 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id e3so62170169edu.4
        for <git@vger.kernel.org>; Sun, 28 Nov 2021 10:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=LVc25c7rCE9Bfv7Tx9b7X7GaeyrSRqXHMEj9HdsOj7M=;
        b=qXIn2CSR2YfERL9OCvhrc/Vwl2/wtj1Sa3hBFTQiOu4jiEyn5OSSFo7uctU7aPo+C/
         5ruWZ9BVp+658xP9/NixJYyEa7I92FoghI+368A5dTJNZVGRQo+9ZUlucND2RqH9avlt
         i/2swriG18t35N+JAWSP5ml70qGvXUFwHgJcQCazJI9Sfy4bOBUVBVSQIzLu1hbT7iae
         /oigfEKIdXwtZXPVtUV+YY4krlgLKv7jArkizcslCU+rCcTpKPEFzMwgQArSbC5SdaRs
         PpKrR6wFgDd1ZbB9PKMFddC6LA7tCdYTrKXYfcic0yChrWeP8XKwPZkfxQD9wxlU/vhG
         ZiIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=LVc25c7rCE9Bfv7Tx9b7X7GaeyrSRqXHMEj9HdsOj7M=;
        b=n+iVvmn+h2NMQDUp9wTNcmApEIuvZ1312jQJLFXGPER4QUsxxw8m+3r03Ehpj4ALDo
         gpWfNXXG6xRarDsLDnlPNw+Z39sPMBgxrRzrTB92SFyJC8Is5XPH9rY75XbrUHg7/s8y
         WmY/zCxJlnen3PGGCynjplmSdZ7j8vFhDN4NghrVVe+yDYc+4FQRsLqreRIRNK4K3thL
         qs5Xgp0QrqNPthpC+Wz6eK+3wBMUncxMQflBrsL3BzfMuwEBa81GcXp8jMKUfwRnlCP0
         +KMizyw99SpGexIjHCyBZF0JqUeUrz2j5dh3V3AqEHaFM4xG4VbPb9DSMr+nhzROAfaX
         Mc5g==
X-Gm-Message-State: AOAM5333P1uSX8/vH61rsgl+9O5so8UN0r8yVni/O1kjC5tZ805oJ1l7
        ayYs1DJsPoc78V6vp95xMcw=
X-Google-Smtp-Source: ABdhPJyxk1569WEDlkqi59wKkA4rk+ZgR0YQHc7cJPBI3vJihOBAjQ2LUHG+4S3B03FWFHxxGcllYw==
X-Received: by 2002:aa7:c946:: with SMTP id h6mr68072263edt.190.1638122542414;
        Sun, 28 Nov 2021 10:02:22 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id hg19sm6025113ejc.1.2021.11.28.10.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 10:02:21 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mrOVJ-000YDy-5k;
        Sun, 28 Nov 2021 19:02:21 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: Re* [PATCH 2/4] refs: trim newline from reflog message
Date:   Sun, 28 Nov 2021 18:50:15 +0100
References: <pull.1145.git.git.1637590855.gitgitgadget@gmail.com>
 <dfb639373234a6b8d5f9110380a66ffccbe0b1d6.1637590855.git.gitgitgadget@gmail.com>
 <xmqq35nnddw7.fsf@gitster.g>
 <CAFQ2z_PE7TMj=qfQVroK_gRfZk-xF9PKhk2yxqF-bB+2aA7eoQ@mail.gmail.com>
 <xmqqczmqajdk.fsf@gitster.g>
 <CAFQ2z_Mct+KBZ3vO6udwqeiHYA8od8CGH_w5BO5LaidP-AYDsg@mail.gmail.com>
 <xmqqzgpu7grv.fsf@gitster.g> <xmqqczmn71ru.fsf_-_@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <xmqqczmn71ru.fsf_-_@gitster.g>
Message-ID: <211128.86r1b0gnv6.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 26 2021, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> I think what deserves such a comment more is the prototype for
>> each_reflog_ent_fn describing what the parameters to that callback
>> function, to help the callers of the iterator what to expect.  That
>> is the end-user facing part.
>
> Perhaps something along this line.
>
> --- >8 ------ >8 ------ >8 ------ >8 ------ >8 ------ >8 ---
> Subject: [PATCH] refs: document callback for reflog-ent iterators
>
> refs_for_each_reflog_ent() and refs_for_each_reflog_ent_reverse()
> functions take a callback function that gets called with the details
> of each reflog entry.  Its parameters were not documented beyond
> their names.  Elaborate a bit on each of them.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  refs.h | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
>
> diff --git c/refs.h w/refs.h
> index 48970dfc7e..4fa97d77cf 100644
> --- c/refs.h
> +++ w/refs.h
> @@ -462,7 +462,27 @@ int delete_reflog(const char *refname);
>  
>  /*
>   * Callback to process a reflog entry found by the iteration functions (see
> - * below)
> + * below).
> + *
> + * The committer parameter is a single string, in the form
> + * "$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>" (without double quotes).
> + *
> + * The timestamp parameter gives the seconds since epoch when the reflog
> + * entry was created.
> + *
> + * The tz parameter is an up to 4 digits integer, whose absolute value
> + * gives the hour and minute offset from GMT (the lower 2 digits are
> + * minutes, the higher 2 digits are hours).  A negative tz means west of,
> + * and a positive tz means east of GMT.

The Line and Attu islands beg to differ :)

Nitpicking aside, perhaps these two pargaraphs would be better as simply
replaced by:

    Consult "Git internal format" in git-commit-tree(1) for
    details about the "<unix timestamp> <time zone offset>" format, and
    see show_one_reflog_ent() for the parsing function.

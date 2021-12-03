Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9937DC433EF
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 20:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357565AbhLCURm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 15:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353691AbhLCURk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 15:17:40 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4858BC061751
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 12:14:16 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id z5so16463005edd.3
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 12:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:date:user-agent:message-id
         :mime-version;
        bh=20/n8l02zTgm09S4CSxVb7FVOzTvo3hehueN8dBOUio=;
        b=L+acsjYYFxRVYxlQU6f9knHXwadZEFldeI4L8cg7zzGFpctJIXaFvXiFAAJ5/AVxrQ
         I8HFd5FT0/MYiW9t3WwCTccVyLfaQMa4EAnyxWxrYD1M3or9ZQFbeiMrPF6jrSIRSDTo
         IjM6RlDFS3qIjOHh+rp2OjVUsCNH3dKCsFQQ7vDf++R44n0PX/eJDbllklQYAG8WqIpu
         YIOIWI2GjERDcMIi/N0lEm3Qxsb9OmkoVKFZTnxHTvV5IhaMFXYPbZbiyWPdL4yYlNqz
         AdJjKNkU8zh4i6xkB/ZtCjqJZQynizKvezaI8OirzLrXwdiVqVNRYDNX+avi8QIONHBA
         tC0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:date:user-agent
         :message-id:mime-version;
        bh=20/n8l02zTgm09S4CSxVb7FVOzTvo3hehueN8dBOUio=;
        b=Zpj/JLNUOrBjcbP45HVbCKC8BIJU9EEaF6OCz0teNOhreGj28t43qoWmezQ9TsRQoe
         RBbbvpnnnym2m0RmD1OmFiWXqrq9szFI4RjnaSMQJghvvbxNzC15jLjyymUVYBYOWqwZ
         Y5htd0mjMFXF5lfMhzWIg4F5Av39yOPdQ1HZ9HjuPjoZbW7xoln+/9gMeYcaYatzb6WM
         KlhubFTAFRcCbJH79O/GAaDIIxUjnTyaaUoDZ67Vg8neSvIjL6EbYxTAMtyEJbA/8a6R
         Y+0fpzuwO809Dti3fPqvISsSbkdtQ9EkeqZdkQjbIm5ddQ/DBzqSqbjvorNI+mIGduti
         0jig==
X-Gm-Message-State: AOAM532bG6nLlWRKPEcnpdf01E0n3oBgJOBX85ygdDUQIIMRWYoykGZP
        cgTD5b0XnXnt5EweFaxor/bvsOqxCwOFNw==
X-Google-Smtp-Source: ABdhPJxZmDgz/EUOVi3AoeS0Kw7C8TI96EK2YVxUbVcvrReeicsq0qCBTR6wdgvuGQlRsMS37HyVrg==
X-Received: by 2002:a17:907:3f19:: with SMTP id hq25mr25266604ejc.225.1638562454497;
        Fri, 03 Dec 2021 12:14:14 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id sh33sm2647304ejc.56.2021.12.03.12.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 12:14:13 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mtEwf-000Igf-By;
        Fri, 03 Dec 2021 21:14:13 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: Large delays in mailing list delivery?
In-Reply-To: <CABPp-BF_xsOpQ6GSaWs9u9JcnPQT_OXP-gCsAuxPtMj-X1tgOg@mail.gmail.com>
Date:   Fri, 03 Dec 2021 21:02:48 +0100
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
Message-ID: <211203.86sfv9qwdm.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, 3 Dec 2021 11:52:58 -0800 Elijah Newren wrote:

> Are there some rather large delays in mailing list delivery these
> days?  Anyone know who to contact to investigate?  [*]

I've got E-Mail delays so large that I manually crafted In-Reply-To
etc. to reply to this :)

I'm 99% sure it's some weird thing at GMail, and nothing to do with
kernel.org.

When I've experienced delays (sometimes of half a day or more) both
https://public-inbox.org/git/ and https://lore.kernel.org/git/ have been
updated.

Konstantin Ryabitsev notes (and would be in a position to know) that
GMail throttles delivery (with an smtp 451 error?).

But the other day when Junio sent out a What's Cooking and I saw it on
lore, but it wasn't in my mailbox for some hours. That time I looked a
bi tinto it.

I went into the gmail UI and searched for rfc822msgid:$id, nothing. It
was neither there on IMAP or in the UI.

However when the E-Mail finally arrived I looked at the raw headers, and
all the "Received" headers (including GMail's own internal routing) were
within a couple of minutes of Junio having sent the mail (and in the
meantime it went through vger etc.).

So, I'm hazy on E-Mail infrastructure details these days (but worked no
it in a past life), but that really seems to me like GMail in fact got
the E-Mail, but it was just sitting in some local queue of theirs before
it got served to me.

Right now I can't see the mail I'm replying to in my inbox[1], but I can
report the full headers once it arrives if that helps.

1. A search for:
   rfc822msgid:CABPp-BF_xsOpQ6GSaWs9u9JcnPQT_OXP-gCsAuxPtMj-X1tgOg@mail.gmail.com

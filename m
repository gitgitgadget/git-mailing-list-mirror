Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ACDBC432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 06:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 237F360231
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 06:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236644AbhHaGjp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 02:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234268AbhHaGjp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 02:39:45 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CEFC061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 23:38:50 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id e7so15720757pgk.2
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 23:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KcAz1dNT18HCOeOJP6SxC+pWGBf2QUouqrjGwLKdYms=;
        b=f7/ZM1Ms6rs44G9GEA6gPuWwA96nD37Q78IrWQtHpeH1tCAkjxaCUlXg9GivnXGxpA
         WDC/0ybCHxL5G9VcFH2URC6Ej3QoHyzDXMw5iY+HmcTZe1QFSjT5AmG9UGeVjt55SiFl
         Z7XHVPerm5XSvTky3Prq+SALKGsfnR54JX3u4/g0UL8WsSnUPo1XRDssVN/9GSBD3OUV
         KzOyLZVLlDIX5o2K9PF/pphUkWll56EcclEj49HL1ARcZp+85y89x45yotCVa9tgcn2B
         TWgKR78KE+vJZj0RnMH0pW3ykS1NkolK87wb10+Aj97BPnBGQb6HyqZEnSKOWpb4mE8/
         duOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KcAz1dNT18HCOeOJP6SxC+pWGBf2QUouqrjGwLKdYms=;
        b=RXnTqvEt4quGyr3RPRmGHFx+cK4U7n5omDVO5aCybCieJYC7HTX0edBfQiB/j4608M
         k9czVbLyt2y2cWkMm/kKjrUTz5bZTg+oF20F7mYKnITWWE3kvLgBDLUS2sXBOw90Ba87
         puRB4WCmNo2qfZhul6DjWgR/KwRJfM3hP1qVs/I74/f3CJQDOvYK7DHj597o8KO5Ex0x
         so7LlpK/ofUzODL6jnzZR0oAnDZg3Zk7Nyf2I4DOmzsVeQ7LTZA0/XTToSDhJxA+wZh7
         1DB4o9mIS5o/3UlCaxLFyYhPRxTEoNIhHgyNMiHgDryQw2J7CMftEaWAW+zID6TNz127
         RRGQ==
X-Gm-Message-State: AOAM531KUGGn7xxUD3cKKfOXbnWqWZEOyEqJxxNRNsr4Xg+cJZFuRtcm
        fzDoVrr05Zwnb+gIWBPInJJDJ9L1ITtbSTIF8g==
X-Google-Smtp-Source: ABdhPJxpxDxqe7cwCqp/94D2Z+zRGdAyWd/A6h6Ywuy1Yl5Wv36kfMvN2ZrglLol5amX8QH8jUuyPfmmXqkd7ObfTQo=
X-Received: by 2002:a62:a20b:0:b0:3f8:f5db:3256 with SMTP id
 m11-20020a62a20b000000b003f8f5db3256mr16680069pff.10.1630391930142; Mon, 30
 Aug 2021 23:38:50 -0700 (PDT)
MIME-Version: 1.0
References: <CANXojcyWnFY60bXG6MDS9WAYkcFQHf+Oef0VREBkvgsuX9e=Kg@mail.gmail.com>
 <YS0tNoAa/0VQe1OW@coredump.intra.peff.net>
In-Reply-To: <YS0tNoAa/0VQe1OW@coredump.intra.peff.net>
From:   Stef Bon <stefbon@gmail.com>
Date:   Tue, 31 Aug 2021 08:38:39 +0200
Message-ID: <CANXojczR1hMrzz7t0P6AkqL3kjdk+NzBKyCQnm-9cWFbULifow@mail.gmail.com>
Subject: Re: Exec upload-pack on remote with what parameters to get direntries.
To:     Jeff King <peff@peff.net>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

thank you for the answer.

I understand that the core of git is to make people work together when
writing code.
To get a tree of the source files is not directly part of that, but
pure informational. That is also the intent of my fuse fs: provide the
user information about the source files.

Now I have a working ssh connection to the server, and open a channel
for running the upload-pack on the server using the exec channel
request:

https://datatracker.ietf.org/doc/html/rfc4254#section-6.5

So in my program I do not have to do something like:

ssh -x git@server "git-upload-pack 'simplegit-progit.git'"

It is only the sending of an exec message with the right command.
Via the SSH_MSG_CHANNEL_DATA message the server will return the
output. In my program I have to write a parser to get the
tree/direntries.

Now you suggest the git clone --depth 1 --filter=blob:none
--single-branch -b $branch
command. How does that look when writing it in lowlevel git messages
as described in

https://git-scm.com/book/en/v2/Git-Internals-Transfer-Protocols

?
I'm programming at this low level, so I have to write the messages to
send to the server myself.

And you mention the api github has for a git tree object. But git2 has
already the git_tree object?

Stef

My project  by the way is: https://github.com/stefbon/OSNS

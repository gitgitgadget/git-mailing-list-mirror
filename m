Return-Path: <SRS0=K77S=55=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E1AC2BB86
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 12:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCCBC2073E
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 12:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o9MJUG8b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbgDMMOu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Apr 2020 08:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728251AbgDMMOn (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Apr 2020 08:14:43 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BF7C03BC81
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 05:05:13 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id x11so8809287otp.6
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 05:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=mKiy1/2n8ZhtwoZJnCZdNCgyT3uHG6YpPLP0VoZ4Qo8=;
        b=o9MJUG8b8x8lJfWY+dLoEqUb48QZoY7WOpv2WmJ31doUT2GkEp0nt0xG+sT3fgFGfJ
         VIfY0qQ+0tNJBmkbmjXrg4VQ/zP5BHffXvs8+OL5VxhO+57qyZCJLmeX2/VfSN8oKDNz
         9rDAHaQXr3nVGi4c8HGnuFNBrzA715T0mOyJgw8YCRW1sD9B+lL7bNgqj5YikURBBtCU
         ciSTgNyKDwKYhtc5+xaD2dqShvY4Z+sxHRbwCTB8RMaXD/R/UWTG+Baf94+o+FyGqCTi
         pK/E3wMz+5EbncI61qF4jrGqwTG7o0TPPx/7IDKmrGsFPM10olb8LT3tLYhNmhtfAzXS
         ZdeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=mKiy1/2n8ZhtwoZJnCZdNCgyT3uHG6YpPLP0VoZ4Qo8=;
        b=rzNkdRItiw9RgWKOMJHVJq9WDvLOVcYuyH7H923m+2ZbScdPhLOE3FFLBz9p61/gHe
         juz7baA0CYHbea5h+heZiyMp59iHrx/DMqQxvIYXbZfKOjrOruyoe8fmKk8W+r0GZ62j
         nZt2IMZTIjL2cSpTq6dYUvRp1fxMCQkR7ep0bIWzI7C0u2Yj9u8WCY3vuZb93lOugu0k
         Xl0Kae2VfZeJ07f/Fm8RUtNxXIbo6FHH7I8E3na2ERPgfT2QPovdetrmjqja0mmLXOqc
         t79+xM01FCcpXeLUfwOk5/tM6otS7KdCJCSI0mEAUuqmNsn4rktc4aGxDI8W9ctwwq4R
         JsSQ==
X-Gm-Message-State: AGi0PubUNJFXDRU1rl77hsc6d6CSDoLQaXsF+blXcOjFkyB9gibiOcnH
        lMBuGGyeAka3hbkgAp7aiwY/4xiSR9m7ZzkZgcy3W2SF
X-Google-Smtp-Source: APiQypIcx1Ba2rY1joSslhaJQ1lU0JtudU0Ll7A2y0drJZm5rkPgvuEwrlFVPyb4QT/baLvzNyfPQfcciRkfQVGD32U=
X-Received: by 2002:a9d:6e09:: with SMTP id e9mr13560838otr.32.1586779511381;
 Mon, 13 Apr 2020 05:05:11 -0700 (PDT)
MIME-Version: 1.0
From:   Son Luong Ngoc <sluongng@gmail.com>
Date:   Mon, 13 Apr 2020 14:05:00 +0200
Message-ID: <CAL3xRKceuniEOq+PqN15FC4-mxsWJd4+e2fu1Ku9q_+8JmR9pw@mail.gmail.com>
Subject: Git pull stuck when Trace2 target set to Unix Stream Socket
To:     git@vger.kernel.org
Cc:     Jeff.Hostetler@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey folks,

I am trying to write a simple git trace2 event collector and I notice
that when git doing git pull with trace events being sent to a unix
stream socket, the entire operation halted.

Reproduce as follow:
```
cd git/git
git config trace2.eventTarget af_unix:stream:/tmp/git_trace.sock
git config trace2.eventBrief false
(rm /tmp/git_trace.sock | ) &&  nc -lkU /tmp/git_trace.sock

# In a different terminal
git pull # Pull stuck and never complete
```

This does not happen when you set eventBrief to true
```
git config trace2.eventBrief true
```

Worth to note that if eventTarget is a file instead of a socket,
everything works fine.

Cheers,
Son Luong.

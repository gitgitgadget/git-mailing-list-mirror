Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15C4B1FF40
	for <e@80x24.org>; Thu, 22 Dec 2016 04:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757826AbcLVExH (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Dec 2016 23:53:07 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:36038 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755385AbcLVExG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Dec 2016 23:53:06 -0500
Received: by mail-it0-f67.google.com with SMTP id n68so19646912itn.3
        for <git@vger.kernel.org>; Wed, 21 Dec 2016 20:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Utmh0alIjXJ+uRoLG+ceVPAQ5bxMhl91XvLzhxZpFhk=;
        b=EyQeB1ss1ciUHQVXOq6YcEtCrWAvqVND398RQF9hPkoDexpi+P+T8d0gTVEVaQH8I/
         v0bVCGI2n/XPuP/RpJMWFufdoGm0U+7oy8kHuv/P9WAE3V+O6dR40Ilo2iLOKjHnMaLr
         W25BDkNNe9rmfsrdTlBzU6bAr+MeH4rQdlE+q59LRhl3eAwKpLt0UfkovDcqMvMaiZde
         VsxpuUuGfGTJq7TFEDK8rjjlLR8fXjOU6z47E+G0Ynx9ij5giOUB/sIyKPzonX1fmlPR
         66SHx/htOZfsoRsGUOBU+CV/+AieIS1+B31CTOJp9PUykdY+jXG4Oe9WjWf05OcU5nkI
         cMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Utmh0alIjXJ+uRoLG+ceVPAQ5bxMhl91XvLzhxZpFhk=;
        b=AMt7CKcYFDWDTqsJ7h6wMJwf49LqX70HUEbj2NEwEHIgbP6ENa5AkECC9ynfx090D9
         ANRFL4HtqR0mEc/9biAr7kZMKBWLOFSIJkCB86IBjcgWB7rr820IdTc4Sv0JIBy6cB5G
         caJSh8ymH+uVsqU7CpUb4iGxtJhxpMzEF/f9/i/bCq0uTB3/ZuJqvJMiwIJMkjXvQmqQ
         c+qCRjArdRJgHCJ2YGOduiQaOd0a4ZADmhHWg75hUgHOXCujUZKWFjfba4MQ4Gr+x7KL
         vjpo1n6FIfm+5YyCesyj6QSPnXolOJtwXnOMt0kDUqYqPkFAoUhlldth7gcLjwWYzAOl
         YQtQ==
X-Gm-Message-State: AIkVDXKeEvXFkANt2QVPxYbjt3o71qXKj//sqLP0WCXtCjpTszqGBzKPDd7WIQnYgqrwEE4LMbDnrX7BUZCZlQ==
X-Received: by 10.36.213.4 with SMTP id a4mr11221725itg.0.1482382385189; Wed,
 21 Dec 2016 20:53:05 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.181.197 with HTTP; Wed, 21 Dec 2016 20:53:04 -0800 (PST)
From:   Paul Sbarra <sbarra.paul@gmail.com>
Date:   Wed, 21 Dec 2016 22:53:04 -0600
Message-ID: <CAGf+dShpkPvsC8wQN6mWmYeMZ3=i-ZOzDNSM1aa0rinKW6+-+g@mail.gmail.com>
Subject: builtin difftool parsing issue
To:     johannes.schindelin@gmx.de
Cc:     davvid@gmail.com, dennis@kaarsemaker.net, git@vger.kernel.org,
        gitster@pobox.com
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sadly, I haven't been able to figure out how to get the mbox file from
this tread into gmail, but wanted to report a parsing issue I've found
with the builtin difftool.

Original Patch:
https://public-inbox.org/git/ac91e4818cfb5c5af6b5874662dbeb61cde1f69d.1480019834.git.johannes.schindelin@gmx.de/#t

> + *status = *++p;
> + if (!status || p[1])
> + return error("unexpected trailer: '%s'", p);
> + return 0;

The p[1] null check assumes the status is only one character long, but
git-diff's raw output format shows that a numeric value can follow in
the copy-edit and rename-edit cases.

I'm looking forward to seeing the builtin difftool land.  I came across it
while investigating adding --submodule=diff (expanding on diff's
recent addition) support and this looks more promising then the perl
script.  Hopefully I will make some progress.  Any tips/pointers would
be greatly appreciated.

Thanks

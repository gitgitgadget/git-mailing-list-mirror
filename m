Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A7C420248
	for <e@80x24.org>; Tue,  2 Apr 2019 01:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbfDBBHq (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 21:07:46 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:38862 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfDBBHq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 21:07:46 -0400
Received: by mail-it1-f194.google.com with SMTP id f22so2430663ita.3
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 18:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OBYR6ViogUV8b5pNT6ff5rVwFhOD0kpDEk+U1ozZjS4=;
        b=n6Mw+pxveeuwu3ni5XTEpREw23UiPg6uzEB4A1Cs0M7EAOiT5wXkTm8FX7+1LCKbdJ
         lEA9nV6jzoGuuc2RmMcBNpcx+v6hCi4prWrswfPI6JKFInT5vNmIraXoA2KbZ/YSnHG6
         b5C4Snon+BePAxOHwsjlMdLOAd48pDT5cb5irtUr6whC+yHWMrFP4feLZvRATs7nJANd
         1/yojnGjrEfLD1SLbMfFdW7536HDx1T5+vw9HgSNOgYDOB9qCE/Jtbu5zC7XhDsgu8Vx
         26Wqr4tSuT1M2Wqv9iDezOwMJ5fKfHsODA34xrSE9EZC5YqDNemKxkQdiLnQZyyc+/jt
         N+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OBYR6ViogUV8b5pNT6ff5rVwFhOD0kpDEk+U1ozZjS4=;
        b=r8mXdOqiLmK7VtY60wGr8DzKLChq9FagCcr8NxlTwP/LDFoMNABcNxX2tP5rVuM7aX
         35MhdBZbesbnhdLuPhXBkLOSU2fUzwjQLLPHn1jhsl1Z1aATfdTpkT/DEjP9blEU47dU
         SpMgSJF1BGYeFZymqUoHoN/Ntd1/eY5lsUJj3G7mrZ7iCzUB2PGFUYWAkc1GpHx6c9VK
         +ASPHWrBn+1hH0G0X69fVLm8hJcE1L/MdTahiOFP5H7VMBHk4aKy5mmICQyZTVSOrF4R
         VqG80dpqZt79poFA03c23Z6qK7jbtmsaBkTydQlQyR+esyFz3Td0SIqtzk4Dgor4Cuj9
         La4g==
X-Gm-Message-State: APjAAAVOU6k+GC0yyskTm3F9NKiQwQs4pZmAZpazcJGVo7EJKmbLw6l3
        4RGHAtmiD37X9oNkzvDViwlrAWso+ZRcCLhJDeI=
X-Google-Smtp-Source: APXvYqzZA9jPcbqG4Fidn1ZI8fOgvdaRLSxe9qtxWGIofRvgAwPDq17uwkj8yDipqeDsuHMbY9SaQMyUQpyGth18Kus=
X-Received: by 2002:a24:5e06:: with SMTP id h6mr1883426itb.107.1554167265186;
 Mon, 01 Apr 2019 18:07:45 -0700 (PDT)
MIME-Version: 1.0
References: <CA+TurHgyUK5sfCKrK+3xY8AeOg0t66vEvFxX=JiA9wXww7eZXQ@mail.gmail.com>
 <20190402005245.4983-1-matheus.bernardino@usp.br>
In-Reply-To: <20190402005245.4983-1-matheus.bernardino@usp.br>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 2 Apr 2019 08:07:18 +0700
Message-ID: <CACsJy8BSDz1JO+w1N9w2W1zxY+EWTxiU6yB_V0eeOD--g-TzeA@mail.gmail.com>
Subject: Re: Make the git codebase thread-safe
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Zager <szager@chromium.org>,
        Stefan Zager <szager@google.com>,
        Zachary Turner <zturner@chromium.org>,
        "Robin H . Johnson" <robbat2@gentoo.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        David Kastrup <dak@gnu.org>, Alfredo Goldman <gold@ime.usp.br>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Elijah Newren <newren@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 2, 2019 at 7:52 AM Matheus Tavares
<matheus.bernardino@usp.br> wrote:
> I downloaded chromium to give it a try and got (on a machine with i7 and
> SSD, running Manjaro Linux):
>
> - 17s on blame for a file with long history[2]
> - 2m on blame for a huge file[3]
> - 15s on log for both [2] and [3]
> - 1s for git status
>
> It seems quite a lot, especially with SSD, IMO.

There have been a couple of optimizations that are probably still not
enabled by default because they only benefit large repos. So you may
want to check and turn them on before measuring anything:
commit-graph, pack bitmap, untracked cache or fsmonitor. All these
should be mentioned in 'git help config' (as starting point). Also
search "threads" in that man page because some commands may have multi
threads support but disabled by default for the same reason.

From your command list though, I think you might get the same results
(maybe with a bit faster 'git status') even with all optimizations on.
-- 
Duy

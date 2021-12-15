Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D276C433F5
	for <git@archiver.kernel.org>; Wed, 15 Dec 2021 03:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235598AbhLODPM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Dec 2021 22:15:12 -0500
Received: from mail-pl1-f172.google.com ([209.85.214.172]:37556 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbhLODPL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Dec 2021 22:15:11 -0500
Received: by mail-pl1-f172.google.com with SMTP id n8so15229893plf.4
        for <git@vger.kernel.org>; Tue, 14 Dec 2021 19:15:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xzCwwU7g+XWOm/FOCymrBBv9uGKhm9S4R7pkIfWyD+o=;
        b=4bo+kowMyogJRr4vzys3T5KR9vPG7lgnwC9X9FTF4w28/v5fCioVSqH+nA8nN5q20k
         O7CG6Tv6gSZQ0tPXt++los+Ga/VUr+ss96qRYo9ffKrx9Ho3N0klvC25IKjmLylYNTwQ
         j8vsr+ULr30SJR62owdr2weyCxXFIakt9u6SSFiSoM2n44ah1BmWCg1i9ZRvqV8Yk802
         CPRYv7dBxtIxZX1NmHn3nRhYXw10atMeGPGdAv03QKTu6gy/4qhTmlHtgQdTd5u5GY/v
         Zxq1woDIParu8txg0uv4/GT3rqZUY/HIwxSt0XhwvxsZgJKzHOj6BJcn5I96F3AopGPR
         UbOw==
X-Gm-Message-State: AOAM532oMlNGYn+vbzQXUEZwkKiiUN98ucNe/XHC9VyR+C94Flxepm0Z
        ZkLvJH79UWZlCuZ8RPBx8sAVWgeWajlFhDlE+LQ=
X-Google-Smtp-Source: ABdhPJywmlWVoMqSYP0cNpZ+Ij3uAIkLZiHy384+uYP3fv9z+knN3+8rXhYucbH/R7KMFwnCMPXhbiySm6HKzCCv3fg=
X-Received: by 2002:a17:903:1247:b0:143:b9b9:52a2 with SMTP id
 u7-20020a170903124700b00143b9b952a2mr9305643plh.35.1639538111283; Tue, 14 Dec
 2021 19:15:11 -0800 (PST)
MIME-Version: 1.0
References: <20211213063059.19424-1-sunshine@sunshineco.com> <CABPp-BFNEPkEaY-MT1Ot7EzHkW=7FHGbJxU=pr226M43BvHwTw@mail.gmail.com>
In-Reply-To: <CABPp-BFNEPkEaY-MT1Ot7EzHkW=7FHGbJxU=pr226M43BvHwTw@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 14 Dec 2021 22:15:00 -0500
Message-ID: <CAPig+cQrzA9Op=mAAWfuCyDmiFPFopX2KutOg4DHQm2bnPdvPQ@mail.gmail.com>
Subject: Re: [PATCH 00/15] generalize chainlint self-tests
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Fabian Stelzer <fs@gigacodes.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 14, 2021 at 7:00 PM Elijah Newren <newren@gmail.com> wrote:
> On Sun, Dec 12, 2021 at 10:31 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > Although the new chainlint implementation has been complete for several
> > months, I'm still working out how to organize its patch series. In the
> > meantime, _this_ patch series makes it possible for the new linter to
> > re-use the existing chainlint self-tests. It does so by cleansing the
> > self-test ".test" and ".expect" files of implementation details and
> > limitations specific to chainlint.sed.
>
> I read through the patches in this series, and didn't note any
> problems.  However, my knowledge of sed is just the basics.  Even in a
> few cases where regexes were all that were really involved, the
> regexes were lengthy enough that my eyes just glazed over.  So, my
> review is kind of superficial, but the preparatory patches certainly
> seem good to me, and the commit messages are well explained, and the
> non-sed changes are consistent with the described changes, and the
> easier sed stuff looked good.  It's clear you put a lot of care into
> carefully explaining and dividing up the patches in a nice and logical
> manner.

Thanks, Elijah, for reading through the series. I wasn't necessarily
expecting anyone to read the patches carefully, especially the
`sed`-specific changes[*] since it's such an out-of-the-way part of
the project, but it's nice to know that the time I put into organizing
the series and writing the commit messages wasn't wasted.

[*] With the comments stripped out, the entire chainlint.sed script
does quite a good job of emulating gobs of line-noise burped up by an
old dial-up modem, so it's no surprise your eyes glazed over.

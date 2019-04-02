Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E981B20248
	for <e@80x24.org>; Tue,  2 Apr 2019 11:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730100AbfDBLfb (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Apr 2019 07:35:31 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:35239 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbfDBLfb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Apr 2019 07:35:31 -0400
Received: by mail-it1-f193.google.com with SMTP id w15so4618542itc.0
        for <git@vger.kernel.org>; Tue, 02 Apr 2019 04:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ejw1wnxfwcBKjoWfD/+JWFY2zWZPk0BEdOv8pUGL9n4=;
        b=pb6Fs0JooACU98CWEE9gb9KsnyIOCbrIDVq53ohxtqYQQqcDVlO+HfCZb1Qid6OnGv
         W1GAF4Q1CiXxVpFHp2Jg9AsxxnNnARStQt7CQHHnit9c4OFjI2WqqTe4Qj7JO6NJE+56
         JEFW2Cd87VGRG646gqrefZgEG/vmXMC0U32+n9U5w5cliN8RgyEf/iKnxnxqcav/xnpl
         M2VtwkzXj5N1B6UH7gyZTVsIdHPdB8SWn54QH7k2vc+8mEOYObYdJOl5xMak7y/36FKz
         96Kl24Mcx1LIzXYwQ8c9MCOk1zRe2yPBbmefIMACxRrLQAOs1W8AmDN3DcF4zbAy0t67
         Qnaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ejw1wnxfwcBKjoWfD/+JWFY2zWZPk0BEdOv8pUGL9n4=;
        b=fDTEIhuxL4yso5+zpSuXPx5WEzr5ZbAehYJDdFpNU6MZr9JUvnmxJZGngvVuFk1tOO
         /mwa6tTTxVMcsQH17Pdu0MjkZCwDXB0KaDlWXjc4k+5NPBWv5YxFeAcFNjoe/TkUs7xI
         eiTv+iVZNwjiTi2cSdDKkrap9FXE71Mf78dmaBQXCN4haZP5fLbWOdJkZhBxsBpCXl6u
         npzfKqG3nGGNb1kFnjoJURwfF+8QSoWuIiYzHdWSBBuJ1ZEr8axBuYsufmb17/7uagjj
         /5K0irLrp5HkocsuUnmfGIGeX1Z3qwBc9xmKmvtUCFJ6KFKF/ZYcwMwiQKrfuBwHAwQs
         wTVA==
X-Gm-Message-State: APjAAAULR1MQdnPqpdNvc2inwZBgNsN4hzwuZ/2Cg79Vcl6RAsph/K+x
        Swyu4ec11hrzqdj4cWv3lFrAlU90h/BMUAL62Nw=
X-Google-Smtp-Source: APXvYqzlOKfs7XZUqeQDekGgEYynSbgE/kbX1CSyw9URZ8r7suhp96SR4g2hp/TdhRe4ZUK7CSe8LFjAJL3JRA8LKcg=
X-Received: by 2002:a24:5e06:: with SMTP id h6mr3331843itb.107.1554204930560;
 Tue, 02 Apr 2019 04:35:30 -0700 (PDT)
MIME-Version: 1.0
References: <CA+TurHgyUK5sfCKrK+3xY8AeOg0t66vEvFxX=JiA9wXww7eZXQ@mail.gmail.com>
 <20190402005245.4983-1-matheus.bernardino@usp.br> <CACsJy8BSDz1JO+w1N9w2W1zxY+EWTxiU6yB_V0eeOD--g-TzeA@mail.gmail.com>
 <87lg0s66nm.fsf@fencepost.gnu.org>
In-Reply-To: <87lg0s66nm.fsf@fencepost.gnu.org>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 2 Apr 2019 18:35:04 +0700
Message-ID: <CACsJy8BuJbxj5fHwTc+aogWcWGR_6A0CXS78-h0zi4rYLa0kXQ@mail.gmail.com>
Subject: Re: Make the git codebase thread-safe
To:     David Kastrup <dak@gnu.org>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Zager <szager@chromium.org>,
        Stefan Zager <szager@google.com>,
        Zachary Turner <zturner@chromium.org>,
        "Robin H . Johnson" <robbat2@gentoo.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Alfredo Goldman <gold@ime.usp.br>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Elijah Newren <newren@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 2, 2019 at 5:30 PM David Kastrup <dak@gnu.org> wrote:
>
> Duy Nguyen <pclouds@gmail.com> writes:
>
> > On Tue, Apr 2, 2019 at 7:52 AM Matheus Tavares
> > <matheus.bernardino@usp.br> wrote:
> >> I downloaded chromium to give it a try and got (on a machine with i7 and
> >> SSD, running Manjaro Linux):
> >>
> >> - 17s on blame for a file with long history[2]
> >> - 2m on blame for a huge file[3]
> >> - 15s on log for both [2] and [3]
> >> - 1s for git status
> >>
> >> It seems quite a lot, especially with SSD, IMO.
> >
> > There have been a couple of optimizations that are probably still not
> > enabled by default because they only benefit large repos.
>
> I've proposed a trivial change in 2014 that could have cut down typical
> blame times significantly but nobody was interested in testing and
> committing it, and it is conceivable that in limited-memory situations
> it might warrant some accounting/mitigation for weird histories (not
> that there isn't other code like that).

I didn't really read the patch (I don't know much about blame.c to
really contribute anything there). But a quick "git blame --show-stats
unpack-trees.c" shows this

Without the patch:

num read blob: 767
num get patch: 425
num commits: 343

With the patch:

num read blob: 419
num get patch: 425
num commits: 343

That's a nice reduction of blob reading. On a typical small file, the
actual time saving might be not much. But it could really help when
you blame a large file.

Perhaps you could resubmit it again for inclusion? (at least a
sign-off-by is missing then)

> Rebased/appended.
>
> --
> David Kastrup
-- 
Duy

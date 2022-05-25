Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03606C433EF
	for <git@archiver.kernel.org>; Wed, 25 May 2022 21:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343776AbiEYVPA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 17:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbiEYVO7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 17:14:59 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC426BA56A
        for <git@vger.kernel.org>; Wed, 25 May 2022 14:14:57 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id d198so17630302iof.12
        for <git@vger.kernel.org>; Wed, 25 May 2022 14:14:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cjC7KFQGgXGEOWwlj2xnh+cll7UIpO3ZRXVwnBXr6Cs=;
        b=nQhQMfquUC5vd2BPMlZ3Zx5cfEqLdNBS95JwnMhLbD5aS3oYss1EtYPg1/aTxwA/iy
         vqjn35//lSOnwcz/hlWa8q6Ajkp+W4ZLNliAVO1fwN36HR78Q564hL36VbVw24vR6+oI
         LuTnSeFaIhDoJVBcjFyz/EuqSWnBFHrobP1mgujhU215EJQVLIzKYr3x+W/YgejI+PCT
         3m6rklMtokibyu/Om0YRuTMohlef4yZWQAMloAywdjZBo4Qlu+63iCJnyazHs4wQJI98
         FD1xCzbuVtiHdMsxHZOlQOr6uqu4bgykeTs7fKLSvrMEYe4TJg5zX7BtsBn2gmwiw+7W
         B7bQ==
X-Gm-Message-State: AOAM530UPcpWd1BakcwLNvx6+r9RueurzgxNZHrI8C2ehAdu5mNIu7Lw
        BUmMOIr01Wq1FSBOM/S48SsIYxo2zwYVKGeuQGQW+yx57sU=
X-Google-Smtp-Source: ABdhPJwaZxmq8Uorx0+yyaRW4MWZGfwDMqQpRxSXJaRW20fFusbZdFuJZZlAyCGi9Y8nkfYA2+k/0iQX5f6U2tLdD5A=
X-Received: by 2002:a05:6638:1687:b0:330:b377:40a0 with SMTP id
 f7-20020a056638168700b00330b37740a0mr2106965jat.50.1653513297034; Wed, 25 May
 2022 14:14:57 -0700 (PDT)
MIME-Version: 1.0
References: <CACMKQb0Mz4zBoSX2CdXkeF51z_mh3had7359J=LmXGzJM1WYLg@mail.gmail.com>
In-Reply-To: <CACMKQb0Mz4zBoSX2CdXkeF51z_mh3had7359J=LmXGzJM1WYLg@mail.gmail.com>
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Wed, 25 May 2022 23:14:17 +0200
Message-ID: <CA+JQ7M_OmfJVJpnYc1h=L226nZqo0A=5USCEJAgrK2EKPRsW4w@mail.gmail.com>
Subject: Re: About GIT Internals
To:     Aman <amanmatreja@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 25, 2022 at 10:14 PM Aman <amanmatreja@gmail.com> wrote:
>
> And if I am being completely honest, I didn't understand most of it.

You are not alone, there are many that struggle with understanding how
git works internally.

> (I am a high school student, and really want to learn more about how
> all the great software and hardware around us work - which so many of
> us take for granted)

Perhaps not a good resource, depending on your familiarity with
computer science but
https://eagain.net/articles/git-for-computer-scientists/
is an article that is often recommended.

I think for me, the hardest part of understanding Git was the
difficulty conceptualizing it.
But at its core Git is very simple.

You can think of it as a folder of files that you can "save" (commit)
whenever you want.
Each time you "save" (commit), all files and folders are "copied" to
another folder (the local repository).
That means that if you ever want to look at a previous version of a
file, it's there.
For simplicity's sake you can think of this as being unchangeable.
Once a file is saved it's saved forever.

Just having a messy pile of every single version of a file is not useful,
so the rest of git consists of making this manageable.
For example by remembering who saved it, when and why (by making them
write a message when they save).

The main thing however is that Git orders saves.
This order is not necessarily one version after another, sorted by
when they were saved.
Instead, order is manually controlled by saving files in different
places (branches).
In its simplest form, a branch is several saves, one after another.

Because of how Git orders saves, I can work on files, save them and
give them to you.
You can keep working on those files and make your own saves.
But I don't have to wait for you to send your work back to me.
I can keep working on the same files and making my own saves.

When you're done you can put your saves in a "shared folder" (a remote
repository).
Later, when I'm done, I can get your saves and Git can help me figure
out which parts of the files that you changed that I didn't and copy
both of our work into new files (merging).

This is a bit of an oversimplification and Git allows users to do more
advanced things but the gist is basically this.

Return-Path: <SRS0=caIn=3X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01D4C35247
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 20:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EEC220721
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 20:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgBCUqI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Feb 2020 15:46:08 -0500
Received: from mail-lj1-f170.google.com ([209.85.208.170]:45722 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgBCUqI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Feb 2020 15:46:08 -0500
Received: by mail-lj1-f170.google.com with SMTP id f25so16105048ljg.12
        for <git@vger.kernel.org>; Mon, 03 Feb 2020 12:46:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=j6S6/QF37KD/M5N3/tbTfMlvFKVhGeMT+1e2Je5noTs=;
        b=Te8EQBPKNZSSBr0u0+0IF92D/vCOkDKoCQjM07jzmd+hHHxGHqw7ZGmzXURCvJBCiD
         JBlzIMwegrZsLOmkKYtui+LiWoGs8+tk4fewR5hbhqDkYGqXWZFzJEEgu9s0ygOhzGA2
         mJ+ofL7bR32SsF8FsquwELNKTbLtiwjYpVXwsUoafWkR8yUA6aSe+p1m6m7LK8D6yvQ5
         QYXwSc9LN/sHpW0XDD5OzoOM4aGxIOKInHqY4luIrm1QzASQOGjV4OZuI9JJnhusN6ZL
         OdHwZs+kJyAO+AMOiYEB3aLupXWk3GCyDKQsv0lYYMAOKK8nluhz1OnI1kC1l3W62onc
         Vt6w==
X-Gm-Message-State: APjAAAVrlse9bBU356uXpE3wOtLmZYBNoJRtSokpzzIAIn/D+86bBrTQ
        UPG0KrKeSLBOTCPRxx5Q441eAjgvsH67Z96VtGMZ0w==
X-Google-Smtp-Source: APXvYqzrSRgM4qp7V7uEt+YcuYHgTTeC/EiZtlRgVFHChqbA9U52OEZCIihqlGQWgcpg1R70rZUZd4W/5WuNlvVHQ68=
X-Received: by 2002:a2e:b0f5:: with SMTP id h21mr15644022ljl.9.1580762766215;
 Mon, 03 Feb 2020 12:46:06 -0800 (PST)
MIME-Version: 1.0
References: <CAG4-5WdTkFyCa_MqiRchR9GZgC_NEWdgobPfRfxYhTVqzVCCQw@mail.gmail.com>
In-Reply-To: <CAG4-5WdTkFyCa_MqiRchR9GZgC_NEWdgobPfRfxYhTVqzVCCQw@mail.gmail.com>
From:   masukomi <masukomi@masukomi.org>
Date:   Mon, 3 Feb 2020 15:45:54 -0500
Message-ID: <CAG4-5Weaby9OZ+ORMmHiukeG39vAber7PibUWPKKo0mnQ3nEgQ@mail.gmail.com>
Subject: Re: [bug] git-rev-parse sometimes appends subdirectories to result
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nevermind. False alarm.

There's a .git directory in the subdirectory src/tests

I _thought_ i had checked for that, but I dunno... apparently i didn't
check well.

It is working as expected.




- Kay Rhodes
https://masukomi.org

On Mon, Feb 3, 2020 at 3:14 PM masukomi <masukomi@masukomi.org> wrote:
>
> Expected behavior
>
> No matter what subdirectory of my repo I am in git rev-parse
> --show-toplevel will always return the same result
>
> Actual behavior
>
> Depending on what subdirectories you are in it will sometimes (not
> always) start appending those subdirectories to the path.
>
> Reproduction
>
> My git repo root is at
>
> /Users/masukomi/workspace/private_comments
>
> If i run git rev-parse --show-toplevel within that directory it
> returns the correct (identical) path.
> If i run it within /Users/masukomi/workspace/private_comments/src it
> returns the correct path (without the /src)
> If I run it within
> /Users/masukomi/workspace/private_comments/src/tests it suddenly
> starts returning
>
> /Users/masukomi/workspace/private_comments/src/tests
>
> Notes
>
> Git 2.25.0
> macOS 10.15.3
> installed via homebrew.
> no submodules present.
>
>
>
> - Kay Rhodes
> https://masukomi.org

Return-Path: <SRS0=QBG1=2L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F12C43603
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 03:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF0C42070C
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 03:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYF5bgr9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfLUDIt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 22:08:49 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:43461 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbfLUDIt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 22:08:49 -0500
Received: by mail-vs1-f67.google.com with SMTP id s16so5782506vsc.10
        for <git@vger.kernel.org>; Fri, 20 Dec 2019 19:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dsLlLtu3LMQatrkUdwuSlW1/QYNdG0tb+muhd6+blcQ=;
        b=hYF5bgr9GHJ6Eb7GqYy/ddd46+Nz326aYRmaj+aTa6WY2LFfut+VLKYHdiq7GRrbH3
         Z9C0FwN0KgpW+jVZIGiEBCdL2ItSBKvogrZzn32kWRXQ3PU9YeR6c+cf3Q2Gx3d/BrxB
         CSMJBjtJFzTMjjdvi9a1yD+mS5cDGkcqh+hc8W6b/PvPhIMtuLXmVWv+yGCA41Yp4SFT
         6H4fYcPXBzmKHlBjA6xT/13ykc+jGdC0i8Vj3uFSt5+1BDwLGM9dRkCAwwyTZK0gdY1p
         eJ8bMAstQX81zXHpOJHKJwmgoabGVuahtSoegeITs+kCRFksYGA6hOEIyiRt2IX7rIWa
         tq7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dsLlLtu3LMQatrkUdwuSlW1/QYNdG0tb+muhd6+blcQ=;
        b=Y1HeL3IOLjA2UqkK+4AQu5IwWXVP+sxCB6EUcvtjVQFTXWdsb+dTvurzBlnUqTtahf
         4EyhNVu6m9Jb4EujHLtQwWf2VDqpzNugOETGnh/ERUweSBEcBfK/AR6VVPA/X4NZM820
         7C7lll5j7OAGWoUtRp3Vm++xLqDTn/MntY8IGFk2mxKEGJOYXR+SHKwsZMBlLCrO3Rdq
         kreQL1hYjbpIE9IMJg85xVQtCs1catNs9NbTsMDVYplnUhiMsNavWdvwzFixS+zsY8Z+
         F1PDo0PrkiIWtYm53ENmAEgrpeSLxTw39+SC2GY0RCZzcdWFIhXfQOYDXoqJgpeD1yX+
         nmSw==
X-Gm-Message-State: APjAAAVKysaGTRLtidjGe5v6Sd6X0y4VKg3tMmNEcOp7vUBAKVPEEQmO
        nEM8X0w16s5hMr7l50cKveYN7Ce85vBN5luzoYeer6ujBLEGTg==
X-Google-Smtp-Source: APXvYqzRGobshUvOgXsLTBVnso6mN15khAXbrq4x+/o+usmrJHJjmzN2zu57tgrAv3Xts4dt19YvpHuPT7FuR83ajlU=
X-Received: by 2002:a67:e3b1:: with SMTP id j17mr5229415vsm.209.1576897728113;
 Fri, 20 Dec 2019 19:08:48 -0800 (PST)
MIME-Version: 1.0
References: <pull.478.git.1576631464.gitgitgadget@gmail.com>
 <ec699bb3e64c74e6e87a20bbb5efac12a13cb077.1576631464.git.gitgitgadget@gmail.com>
 <9a91caa0-72c3-3a38-3eb7-55a43537762e@iee.email> <03b001d5b601$09b950e0$1d2bf2a0$@gmail.com>
 <xmqqtv5wb3nm.fsf@gitster-ct.c.googlers.com> <CAOjrSZsiW-vxHKBqbEuBS6rpQ7m22wRp0UwGVVAJE2WE3bh-XQ@mail.gmail.com>
 <xmqqtv5u76ag.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqtv5u76ag.fsf@gitster-ct.c.googlers.com>
From:   Matt Rogers <mattr94@gmail.com>
Date:   Fri, 20 Dec 2019 22:08:35 -0500
Message-ID: <CAOjrSZvkT3TZwEvvnhRBVcuivhy46n8p9sV+3wZdvD=5f_cuRQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] config: allow user to know scope of config options
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philip Oakley <philipoakley@iee.email>,
        Matthew Rogers via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 20, 2019 at 9:37 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> I do not think origin and scope are orghogonal, though.  Can the
> same file appear as the source for different configuration var-value
> pair in two different scopes?

I meant orthogonal in two senses:

That given the current implementation you don't need to have both
options active at
the same time but can have them active at both times.

And that origin and scope correlate, but aren't necessarily
one-for-one.  For example, --show-origin lists in a known order, but it follows
includes and lists the origin as the included file.  so if you include a file
globally which has includeif "gitdir:..." directives then it can get hairy when
all your config files are structured like that.

Although, to be fair I doubt that that kind of situation is normal

>
> It is likely that you can _guess_ with high precision that given a
> pathname reported by --show-origin what scope it is in.  It on the
> other hand is not so trivial given a scope to guess which exact file
> a var-value pair came from, I would think.\

Normally yes, but things can get complicating depending on your
configuration/include situation.

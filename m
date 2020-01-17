Return-Path: <SRS0=B37d=3G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5711CC33CB1
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 12:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 230982083E
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 12:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="thrgqFZN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgAQMmu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jan 2020 07:42:50 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:44504 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbgAQMmt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jan 2020 07:42:49 -0500
Received: by mail-io1-f67.google.com with SMTP id b10so25791870iof.11
        for <git@vger.kernel.org>; Fri, 17 Jan 2020 04:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Zanag3wQ4Ju+zJoThITXURNX+Bh9VXSi5lInw5KHVPY=;
        b=thrgqFZNd6PD+NGXjJ60jstvXZOIk2ZzvckOOYMCyFIE+MwHl7IK6QwHSfmIOPrbMA
         EnhCiH7xdIXTUWXuFmM/SOZztrlmNg1Ik3c27k33YR1WlBZ4TJj0ykWcSWBgjkcAzRza
         mgxwC4ZQzxaZFQsA7txV4Yqpnk0doJy2CERPIdl8ndlBJ4PsjBuiZfndeXvM3T5LNCjC
         V+LouvzdnAxJQ8de3sm9DFncmnbo3r5l4QhaviubI/kl2C/fLhYavfG1u4kQUpu/hS/2
         xa7ln7PfR0vrhUYopqgG67yK5MkcbvWh7sDWyCqgcAmjXE2frI1ku3LX98G2BNDiw64V
         Hj5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Zanag3wQ4Ju+zJoThITXURNX+Bh9VXSi5lInw5KHVPY=;
        b=rwr/eKRpIbX/JHL+8RGhbeO380B+JptvPVBP1CPuoFeqCs7YjAYdJrfFAgjJaBa+kO
         5aIGK6ouxeJhXDwDmLuXadSlsLk21e00616V6lqCH2K85O8byxsoiXM8Bfwkv+KnOfJ0
         99bxT23FDT0gGVTq0LQIUiX6kWgfTwhJ1smMlS0c6YPfKkTtgQOzJqwvbC+KWxjbIhjx
         hEvIw0qfKBFsZQf3kmQhnCdOZ0xQ1lz35CI6HkGolUwclP2/ynDTx5jBaSbd8m6F6/Vk
         ARcW/qta7eKBPOeW4wsLfYV3rfyJs4t4cO6yDjCFgyojZfS+AK1ztyf2ssN42rKeIdIA
         /SLQ==
X-Gm-Message-State: APjAAAUM7lZh3wuZOIYpX+38vAmty3V6UEOGNh6rYArhszMEeyri54Fk
        3fqbbl8FLHsIKHfPRMJkxKJk4CEX8pPAyDmstEx2zQsbDFw=
X-Google-Smtp-Source: APXvYqyaoZyq/w237qmIcDwnuQ1JHc+lNjONCtREHepDfFMK5sBe1rZ0EqB6CqVTGfw2LpyybXBa1Pi7Sx5ImE7GJkA=
X-Received: by 2002:a5e:d616:: with SMTP id w22mr29603012iom.57.1579264968721;
 Fri, 17 Jan 2020 04:42:48 -0800 (PST)
MIME-Version: 1.0
References: <CAFFaXsyVy-fU5c7teDbVCTdUXFTK0GQ=Fse5wSi2vMifyZxS9A@mail.gmail.com>
 <xmqqk15rf21d.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqk15rf21d.fsf@gitster-ct.c.googlers.com>
From:   Nirmal Khedkar <nirmalhk7@gmail.com>
Date:   Fri, 17 Jan 2020 18:12:12 +0530
Message-ID: <CAFFaXsz9LEdegzxL8MhS+VfTs-wmWu+CGDjxjB4Xgj8+7nSHNQ@mail.gmail.com>
Subject: Re: Facing error in git-imap-send while compiling Git
To:     git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 17, 2020 at 4:21 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Nirmal Khedkar <nirmalhk7@gmail.com> writes:
>
> > Hey!
> > I've been facing this error everytime I run the Makefile:
> > -----
> > LINK git-imap-send
> > imap-send.o: In function `verify_hostname':
> > /git/imap-send.c:252: undefined reference to `sk_num'
>
> Perhaps the thread
>
>   https://lore.kernel.org/git/xmqqpnfv3tq4.fsf@gitster-ct.c.googlers.com
>
> may help?

It did, to the extent that I now know why I'm facing these errors out
of the blue.

I'm  not quite sure as to what am I supposed to do right now, should I
wait for Liam's patch to be merged,  or should I implement his fixes
locally or should I just downgrade my openssl?

Liam's PR (#516 on GitGitGadget [1]) haven't yet passed all build
checks and I guess its still a work in progress. Nevertheless I've
tried implementing his fixes to imap-send.c, and the make still fails.
Am I missing something here?

Thanks!
Regards,
Nirmal Khedkar

[1] https://github.com/gitgitgadget/git/pull/516

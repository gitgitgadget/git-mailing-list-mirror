Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284DAC2D0DB
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 21:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7AB720CC7
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 21:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMVCWBAv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbgAaVZS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 16:25:18 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36723 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbgAaVZS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 16:25:18 -0500
Received: by mail-pf1-f196.google.com with SMTP id 185so4000036pfv.3
        for <git@vger.kernel.org>; Fri, 31 Jan 2020 13:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n4XsBgkyT6A7c+v5x/ljWPeK3PsK2DXfCF3fFag94ts=;
        b=VMVCWBAvGRerYDvJGj4R4xtc63tFGciNicH0K30t8mJEuzJHU1X6u84aPgAIlyaAjG
         Ta0SFalGD9O3j4QjVPT9K58hhSdj6M8DDicSi5UNT/y16diguienrIlWpTynrcNQotyK
         zz8yAMFJg4NtgMqkjePfPF2hvm9hspHbgpGn20sBAvFbcKNM4PPGwcfpaVzzfLT6U6Aw
         TFnAjY4vbgaIo4JPlZ4OttpeulyedIYHwMp/i32kB94xKSgey33XRE9yAIdyhEaAu1+e
         IPVLrfsOmMEIg5KeHm4tNc6iqTMI6uI6sReJL32wAoUWMRsDoq4l88NgtBn4bXJeovXD
         uz3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n4XsBgkyT6A7c+v5x/ljWPeK3PsK2DXfCF3fFag94ts=;
        b=e/k8EOrFfRqHjozs4HpdVQDXOyEPWG6Egtc1zOXvQw+50MKNJUn9Yu0IGJu7hC2+o1
         I4r7NyevK3QvD0greWsmTC+OEadkxeBrZ5L2tuSPLJnPLuOhkpdQhFj8r39pnUZAlUGN
         Z5QhrtVe8o4C8eS5LW4lHqKTH6PKLUF1bIkOUCH/houovAQDwXEqBgQMEmCIclMcdmlH
         cmlw2xBC6zDWoJ2yROHYXDbHrCGcwRAmqSA8O9lu0v/H06kCziMN6KJVFg6WH8FRmK5e
         RggaqJsApsNca1enEV78vxX576c32XSLFACYJoXRbjjD8vxK8jDx2S4A84+qKgcc6iPe
         YgNw==
X-Gm-Message-State: APjAAAWn8RpRzgaWR2RP6KcgNwTqvc5CPwCIDyIhtRhgV5pBUXY6SUVR
        UnhELeITjmTsAvyOXW4W6RC1TJgwcOudg42TLfw=
X-Google-Smtp-Source: APXvYqx3nYvQ1w7vDJi5VZ/KFNqD0MKdFCcWDWyt7fbyCKSas2Ehp8yTDOCQOfwuJiVgIL525ygpOsTlNXdVDjLdMuY=
X-Received: by 2002:a63:4282:: with SMTP id p124mr11813065pga.155.1580505918091;
 Fri, 31 Jan 2020 13:25:18 -0800 (PST)
MIME-Version: 1.0
References: <20200124033436.81097-1-emilyshaffer@google.com> <20200124033436.81097-11-emilyshaffer@google.com>
In-Reply-To: <20200124033436.81097-11-emilyshaffer@google.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 31 Jan 2020 22:25:06 +0100
Message-ID: <CAN0heSo_Ois83gqNrHvNn2HSMMTXvKShxTb_RdG2qY6D7rnthA@mail.gmail.com>
Subject: Re: [PATCH v5 10/15] bugreport: add config values from safelist
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 24 Jan 2020 at 04:40, <emilyshaffer@google.com> wrote:
> Taking the build-time generated array and putting it into a set saves us
> time - since git_config_bugreport() is called for every option the user
> has configured, performing option lookup in constant time is a useful
> optimization.

I'm sympathetic to your sending out what you have to obtain comments,
knowing that it's not perfect. It would have saved me some time and
effort if I'd known that this was the case though. An "[RFC]" tag,
perhaps. Or at least tweaking the above part of this commit message to
say that this might be over-engineered, with a reference to [1].

[1] https://lore.kernel.org/git/20200124032905.GA37541@google.com/

> +       int safelist_len = sizeof(bugreport_config_safelist) / sizeof(const char *);

I was going to suggest ARRAY_SIZE, but then I realized there are some
outstanding questions around whether you need this stuff in the first
place. I'd be inclined to guess that the first version of this would be
"for each safelisted item, obtain it and include", ignoring any "a.*.b"
business. In which case you wouldn't really need this hashset stuff.


Martin

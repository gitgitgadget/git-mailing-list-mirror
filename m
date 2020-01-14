Return-Path: <SRS0=o1/V=3D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558B4C33C9E
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 21:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21DC224670
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 21:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNRchi4k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbgANVNX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jan 2020 16:13:23 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34997 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbgANVNW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jan 2020 16:13:22 -0500
Received: by mail-oi1-f194.google.com with SMTP id k4so13318483oik.2
        for <git@vger.kernel.org>; Tue, 14 Jan 2020 13:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UqyhfGmRmz80VE7ZWDWCMcIeR63uWVDXRrrdDRCbZ0A=;
        b=LNRchi4k4ryoglOI22zLT6tY2LFF1bZuWCbhAVtmOOHwnRfkKC7A3N1ngv5g5L6V+v
         nyjY/k4yphu4dnu8ZZVQmpr7GoowZsPBEEslWkBludRLzbYuwIT5AwUQ0Kref2tpcS1L
         KmqBkCzyXksxY4N1CN6s9mYPr7tRDQ4Zeg57VNRj7vZoDJsW3RWsE+VCg57o1OV1r+vO
         AecpRgQHtCIG+QZ3vtISDx1jX7oyj3PKJn50E3NkzA9gfchyVCBdctCMV3PAoAsZn52s
         OWY5siV+RowjixJxspkO44qOqAHeG+rID8c89KQv6uqSxkIUKXIT9FlcS2EqocadRrqQ
         yOwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UqyhfGmRmz80VE7ZWDWCMcIeR63uWVDXRrrdDRCbZ0A=;
        b=j/boHa1jhrxhIvjb0X2CE/b+Wh+7oibBk5KioADjiqCa3hJMSmmmiohi8PyNoSR/Bs
         Z7L/JKudfTw7m3CY2faqtfPr0JhuK1XTHKRtIzfvJqk9jeI+qlzUOzvEtomtzuiJx2nA
         A36rt8BE9GhGIfFnNhdAlwCgdysbXwfeIah0WZS9h31PKjnGY/z0T/RD8b9F3aIMy4EM
         n9JntmKTvBJZ7YYgmllznWZrA8lrWtLOlhMqwXghdJZhOrda+058mtjdqPP0AMxKRnwh
         3D4QgG+FgkuVxL1KzgKEhed0oQZZj0086T1nl89QdYZ/yDJUjFhqopqEMQmYUqoN/rsP
         m3Hw==
X-Gm-Message-State: APjAAAXn7MubUaHNj7H0qM1hcLBAwJumEP/dgSFCXcl7TnLeNz/Vb93O
        ANOxtT2b62gT4sel/W0oUZJsU4PE+5qJAuE3+Z4=
X-Google-Smtp-Source: APXvYqyaUfpCTJR5iP9AzApznfru5IN33+DLjD0gjhsN6zKU3YzwyRoaG/0+8413DpzuDsYuuGqs6uitQarCK3RkWoE=
X-Received: by 2002:aca:1b01:: with SMTP id b1mr17250064oib.6.1579036401735;
 Tue, 14 Jan 2020 13:13:21 -0800 (PST)
MIME-Version: 1.0
References: <pull.692.git.git.1579019532809.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.2001142203450.46@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2001142203450.46@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 14 Jan 2020 13:13:10 -0800
Message-ID: <CABPp-BEG-z4cQujWtvcfMPh8fDZeScbr=OLEW5FhXQKkFcjbWw@mail.gmail.com>
Subject: Re: [PATCH] dir: restructure in a way to avoid passing around a
 struct dirent
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Tue, Jan 14, 2020 at 1:07 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi,
>
>
> On Tue, 14 Jan 2020, Elijah Newren via GitGitGadget wrote:
>
> > Restructure the code slightly to avoid passing around a struct dirent
> > anywhere, which also enables us to avoid trying to manufacture one.
>
> Please note that due a bug (which has been fixed in the meantime, see
> https://github.com/gitgitgadget/gitgitgadget/pull/188 for details), this
> GitGitGadget mail is missing the line
>
>         From: Jeff King <peff@peff.net>

Thanks for the heads up.  Once Peff provides his Signed-off-by, I'll
add it to the patch and resubmit which will hopefully fix both the
from and the signed-off-by at the same time.

> The patch itself looks fine to me.
>
> Thanks,
> Dscho

Return-Path: <SRS0=DhGT=5Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1600FC43331
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 19:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7B0B206F5
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 19:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3wYYsrX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbgCaTiG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Mar 2020 15:38:06 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:38478 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgCaTiG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Mar 2020 15:38:06 -0400
Received: by mail-ua1-f65.google.com with SMTP id g10so2282233uae.5
        for <git@vger.kernel.org>; Tue, 31 Mar 2020 12:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/X4ujateRvcRsM8sfYklhorKxwxnsrFldDUj5YPuDfk=;
        b=m3wYYsrXFfI6tJMdxvPc5ImdqS26HvvA2f/BI4cPkiNQ6qHwH0A59jKQwILJD33Hxs
         hqePn2Wughernh91c0KKXnTNZCAmTG4kDuG7/ZW5xpsRNX8gB7OUmxBKEmZyz20rIopH
         Ns5xcBx85zlrEnmSO56XcRBW8XmyUv7zb96LIC1H1JUY8x5UGQUSlLM0oBbFw+GU6H1l
         hX7V8zskFlVxkHYTOrZGWqfRpYQckJH+OC31vKNW2bZEW1VO+JP7adzZQd1hmJMKyQRR
         GfPBVOHNaoUrgCxpfOS3jr+mJcn4j0D0rXACgbTudSYINgV/jgkvh2weeKqmm4w+J0s5
         ZRQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/X4ujateRvcRsM8sfYklhorKxwxnsrFldDUj5YPuDfk=;
        b=A8iZpLrwF4uFwfzbuu+Mol1aKsZnku+2bsO8+AP/roY0jZKPOAdwPyMmoZNxLslYlA
         uPW9x3ch49z1KJUEEKDyPUZbxvzCKS/di1IAIcBfdMb3kTxMNXcO6pOvWJ7Gua+HZHL5
         g7ZbaYCHe4rdPxMk5kY2VDOf6oBzUxgwgUF7Jqxs/fE69QlflEm2Bs0oPM7VSMdfoT//
         cepaEeY6EeHRzwrVznwfgLvBKQd+lPjMYL1vte+PRWba325gQSiTetBqupUGPxLrPyQj
         Bu3UzKtym9txBDAF1n50qMgBzHxRks+Qu+4jrGh/mcxp+aWDsz8gpJYrTVUc3N8X0IjB
         KHFQ==
X-Gm-Message-State: AGi0PuZsbGWhpYq2e1q2vdFhacFiEV604BnlMHpsAdkTg8TjfrxjVvuZ
        iWT59/A3BvdlyJsT6cy3xSu/KJXa3RfmeVx7100=
X-Google-Smtp-Source: APiQypIU40hVSL/TaS7It7yvk144Ncz4V/Hociw9wY9Q+zk6AgKtFdFS+3ZpwpfXLv4+e4RltqyFTn8SQDYm+EaXl2s=
X-Received: by 2002:ab0:18a8:: with SMTP id t40mr13852750uag.115.1585683483565;
 Tue, 31 Mar 2020 12:38:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200330115518.121528-1-sandals@crustytoothpaste.net>
In-Reply-To: <20200330115518.121528-1-sandals@crustytoothpaste.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 31 Mar 2020 21:37:52 +0200
Message-ID: <CAN0heSrjzgYdaKGwedXVR3Q+TMD4PHvJitWE6zxvU0fbabEu-g@mail.gmail.com>
Subject: Re: [PATCH v3 0/1] FAQ for common user questions
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 30 Mar 2020 at 13:57, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> Git is an enormously flexible and powerful piece of software, but many
> people find it confusing and hard to use.  This patch introduces a FAQ
> to address some common user questions and hopefully make it easier.
>
> Changes from v2:

This addresses all my comments from v2. (And I was unable to find
any new nits to be picky about!)

Really nice. Thanks a lot.

Martin

Return-Path: <SRS0=IU/p=Z2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26550C43603
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 16:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB93C206DB
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 16:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZUpJT6Mq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbfLDQWZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Dec 2019 11:22:25 -0500
Received: from mail-ot1-f49.google.com ([209.85.210.49]:37825 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbfLDQWY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Dec 2019 11:22:24 -0500
Received: by mail-ot1-f49.google.com with SMTP id k14so6855355otn.4
        for <git@vger.kernel.org>; Wed, 04 Dec 2019 08:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jjPOWE421ZYOenbWupOUB2gbvaiBjeo2whX2XtOZwzI=;
        b=ZUpJT6Mq0fdMZu2jnUtyBpHMtY7O2BpoJ2y6OhN2l+LL+OG3nFXFpuvopxxjg7KOjQ
         cC6GmxyF3gUzdDU2/xemrPHHmuckvznVnGE/izuRqP0hjo3XUELigyrylcGX4KW6pUmt
         IRYth9yD7k1hR6wfVaOgUoFxz5Ib2anrqzPLehUSKhnrB9usYk/QdKz7iWlnI6DS/f+v
         HYeSNvMjXquQfxdl1aeOnmiFjghDUjBF/ixjo3bl9ddKC0EImPxowkzs2a8hb3RXW+XR
         SkXaeENCy6S1SDDkPT5tkvAulfBG9jq0lHUs+nc1oyBxJ02RR5Jm8qO3NMljLag5mEcF
         Wzxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jjPOWE421ZYOenbWupOUB2gbvaiBjeo2whX2XtOZwzI=;
        b=rEo5tGTDCvNz3qV25irinAV9zOeN+ab6RXQBBuR5GKm1CJE6W303TtcKBDAYlCHgfJ
         c1CFyuWsbEnyqjS3a7riTyGuhHKS7KpCLVop6rvAarCvHFunG+oU1CRGvlh9zBkDtE4B
         zjRjfLsqyCvcIeWqkpOgSa3FVI74yHZ2iNYiR9mFH7Wk/jP9BKcDF7NjxhYmOXm/wNAv
         WSiBX+MA63CsQCvLguER0X4vLui3X55uwB8Aw7G77wsMk8+y3lGwGW4CiUfKzpGIzLgH
         OXxhbdOgI0Ye3D9W2YMp/ILqX88jytazFf57Ja7UJYEUu9aNtsMAwMeJxhOSq3De33hP
         xONw==
X-Gm-Message-State: APjAAAUlc8nL40MqB1HyCRmKE6dePt8iyjh78c8VV3x+T0PcrhS/OfGk
        v5miBIojhrIq7YeDbCiCDAyq8Hc3hdu2FdlWNUFNKhrv
X-Google-Smtp-Source: APXvYqwHP926FQfGmLI63LyrDqpen3QggiBSQ3w1SebtGWCcw/Ba8C80fU6Wl51OOjcsc1n/opxfVYTu34OYDZJYMJw=
X-Received: by 2002:a9d:6f07:: with SMTP id n7mr3030065otq.112.1575476543349;
 Wed, 04 Dec 2019 08:22:23 -0800 (PST)
MIME-Version: 1.0
References: <cover.1574820308.git.liu.denton@gmail.com> <cover.1574878089.git.liu.denton@gmail.com>
 <62c59c12e376dd73317a7e5d78275bca12875340.1574878089.git.liu.denton@gmail.com>
In-Reply-To: <62c59c12e376dd73317a7e5d78275bca12875340.1574878089.git.liu.denton@gmail.com>
From:   Christian Biesinger <cbiesinger@google.com>
Date:   Wed, 4 Dec 2019 10:21:44 -0600
Message-ID: <CAPTJ0XEZ9ydM-EkuJfarK6epChDLsj9tZsb_KxH8BMYmv-PB7g@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] rebase: fix format.useAutoBase breakage
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 27, 2019 at 12:13 PM Denton Liu <liu.denton@gmail.com> wrote:
>
> With `format.useAutoBase = true`, running rebase resulted in an
> error when an upstream wasn't set:

FWIW, this also failed for me when an upstream was set.

Christian

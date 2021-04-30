Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AAD0C433ED
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 19:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73ED56145A
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 19:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235302AbhD3UAp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Apr 2021 16:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234303AbhD3UAp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Apr 2021 16:00:45 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948B4C06174A
        for <git@vger.kernel.org>; Fri, 30 Apr 2021 12:59:55 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id k26-20020a4adfba0000b02901f992c7ec7bso2325461ook.13
        for <git@vger.kernel.org>; Fri, 30 Apr 2021 12:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XkpQ0s/7W//y8n7xn5soGZy2MM60EjGPrLn15b88I8E=;
        b=YY/VK4Si+BlRtcDajxUxTa+JDhb4QYmJpmZ+l89UFWot0+TYSraex/6pnMI6nbu46n
         SemTL0qjzJqB6lGb08d6b2gR0R9vva4jaTOXnw/oy40+yHHSYab/2Pxt+PusYjG8BxL1
         cIUmOKIPtBxppyL1NYAavoa9aqkTsVYBvVuqJu7t7ec8KoFIz5VbUuT67eS/ERGXNUm8
         lwUAay4gZrczGEeloqf/BPCf3QXQaTYPI8bCsufezheuO0inbb/ENlgTVJmg5PpbbFbF
         V6G0tTr+WNoOxL5G0j6MeEmyiieNOjeIKKgq+ObhmYmv2yUBAueeT6uVy2rdMGOZTnKp
         nq3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XkpQ0s/7W//y8n7xn5soGZy2MM60EjGPrLn15b88I8E=;
        b=gPwyQkrOqtOGqzL5+6+cwGyzw6a7ZlpP+CqZQr2Qsfbsly62muiff5HyLBjImvTAkK
         l3v2hIaHiPIgpgaCN+IRZ82n3lf2wwotiajklKD8WhnZbdilKDlZZB3hMKJUSahsMYhx
         HeA4wOmtCVNnaMNuzMPPb2FUI8jNMSNp3q/9VyiNcE2FB2DbEmnLEWOSnfU0X4b+nHDz
         NrotEY2S+rXvvEKVMyKPhH+MxuMPPMC+6j/uOmrk0hL3F6eHNJjrgMGgzIzOcl0itVMB
         85Ilr5AYGJWGLLuLntQk+GypxYK7CCUU4vJssytWG/DfC2jME8e4teP4+dr4OCXW+Lfd
         jvGA==
X-Gm-Message-State: AOAM532bYHrBlJcaxKTThoT9rpN4gaIoiiJXEAJMKIur0xMt0rKdur+o
        S9c111YD9IlPwP9pSDQGMrS6XPCJ47kxZt7ov+0=
X-Google-Smtp-Source: ABdhPJz+TwMnGRKzGzcCIBUDMuuUYT38NxnU2jtaDTY0nsDqxAUYeyCAr85DkGlRoPDXjw+RDSTlTpXPQCO7WTowN8A=
X-Received: by 2002:a4a:db95:: with SMTP id s21mr5895774oou.7.1619812794894;
 Fri, 30 Apr 2021 12:59:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210422002749.2413359-1-lukeshu@lukeshu.com> <20210423164118.693197-1-lukeshu@lukeshu.com>
 <20210423164118.693197-4-lukeshu@lukeshu.com> <xmqqfszbcazc.fsf@gitster.g> <87a6pfpnvt.wl-lukeshu@lukeshu.com>
In-Reply-To: <87a6pfpnvt.wl-lukeshu@lukeshu.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 30 Apr 2021 12:59:43 -0700
Message-ID: <CABPp-BGrYYO93V0-cNT_OOfeJpk1aHE39Nf1oLBYE-73Ly1QgQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] fast-export, fast-import: implement signed-commits
To:     Luke Shumaker <lukeshu@lukeshu.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Luke Shumaker <lukeshu@datawire.io>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 30, 2021 at 12:34 PM Luke Shumaker <lukeshu@lukeshu.com> wrote:
>
> On Tue, 27 Apr 2021 22:02:47 -0600,
> Junio C Hamano wrote:
> > Better yet, don't butcher the region of memory pointed by the
> > "message" variable the caller uses to keep reading from the
> > remainder of the commit object buffer with this and memmove()
> > below.  Perhaps have the caller pass a strbuf to fill in the
> > signature found by this helper as another parameter, and then return
> > a bool "Yes, I found a sig" as its return value?
>
> Stupid question: is there a better way to append a region of bytes to
> a strbuf than
>
>     strbuf_addf(&buf, "%.*s", (int)(str_end - str_beg), str);
>
> ?
>
> It seems weird to me to invoke the printf machinery for something so
> simple, but I don't see anything alternatives in strbuf.h.  Am I
> missing something?

I struggled to find it some time ago as well; I wonder if some
reorganization of strbuf.[ch] might make it more clear.

Anyway, strbuf_add() if you have the number of bytes already handy,
strbuf_addstr() if you don't have the number of bytes handy but the
string is NUL-delimited.

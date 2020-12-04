Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E426BC4361A
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 20:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BE0022CE3
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 20:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgLDU6B (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 15:58:01 -0500
Received: from mail-ej1-f65.google.com ([209.85.218.65]:45292 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgLDU6B (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 15:58:01 -0500
Received: by mail-ej1-f65.google.com with SMTP id qw4so10586796ejb.12
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 12:57:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TbFz5mwDhDORogVk6lKN1isbCWuvEt+vdKwi7fN9Ccw=;
        b=XA6snMyN+RrYJ/XR30udcISzmB6E+QPcYemdjg8sLYCpqEHOGWLD7QKon2VmoXLVt7
         KLi7QfKHSEcjSw8XAbzYqVNKR2z6UF0qwrYFy8fM/D1CnjvRyMCgJcgRYnqaM88YyV4o
         Oe1720sOGngJ4GpLaj9t4LVrx9QXruoIwatCKtCB5AeCS5hldJZjEV5xFDKuN2QRyq/5
         2GjnGuaiwcsZF3DAv87PfhwkGRzC2Rj/2z/o0T1f0IUxSFzK2nnEdS/eJZgAYp48BJOj
         7dvvLwVM3CrdniasTJJEE4a5+p/2aN13tOBQo3f3XPlpE2r9AxflfYaYTI1VyE8ZGnq0
         8SSA==
X-Gm-Message-State: AOAM533NjuQYbVjJx1jxji6gDP7Wf2lbNpJNhZ/rzTEC6a3TgN63nMGn
        RTWABQ2ThMZhKyc81dEgWSyxUQrdyQiPr5JmenQ=
X-Google-Smtp-Source: ABdhPJwqcdl8KCHTFaxlDw+/lsXNopAZFFWXUg78kkHw8fe0ws4pwXjEcs2mQb71V421XnGTfOckSL5a+1aXovT/JXQ=
X-Received: by 2002:a17:906:608:: with SMTP id s8mr8959152ejb.371.1607115439992;
 Fri, 04 Dec 2020 12:57:19 -0800 (PST)
MIME-Version: 1.0
References: <X8qEg/KiAQDugPC0@coredump.intra.peff.net> <X8qFo+GJJTbaPV58@coredump.intra.peff.net>
 <CAPig+cTLs5bkY=Pwg+4tT2KHfVHFjkrNTeS_ygGEwq0cOOJ9wQ@mail.gmail.com> <X8qfr2B0OfaySjPh@coredump.intra.peff.net>
In-Reply-To: <X8qfr2B0OfaySjPh@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 4 Dec 2020 15:57:09 -0500
Message-ID: <CAPig+cQms-VgBCWM_CpxkwAu4aQBVmqHkr4TPu9CR08w3RiLVw@mail.gmail.com>
Subject: Re: [PATCH 6/9] oid-array: provide a for-loop iterator
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 4, 2020 at 3:45 PM Jeff King <peff@peff.net> wrote:
> On Fri, Dec 04, 2020 at 02:18:45PM -0500, Eric Sunshine wrote:
> > Minor: I see that the example code sorts the array first -- which is
> > necessary, as explained in the commit message -- but I wonder if it is
> > worth calling out explicitly in the prose:
> >
> >     Find the next unique oid in the array after position `cur`.
> >     The array must be sorted for this to work. You can use
> >     this to iterate over unique elements like this:
>
> Thanks, that makes sense; I picked up your wording here.

It's probably not worth a re-roll just to update this comment, but if
you're re-rolling anyhow, the wording could be improved slightly:

    Find the next unique oid in the array after position `cur`.
    The array must be sorted for this to work. You can iterate
    over unique elements like this:

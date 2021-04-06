Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AD1C433ED
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 03:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A34FD611EE
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 03:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233639AbhDFDws (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Apr 2021 23:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238872AbhDFDws (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Apr 2021 23:52:48 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E579BC061574
        for <git@vger.kernel.org>; Mon,  5 Apr 2021 20:52:40 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id l4so19636833ejc.10
        for <git@vger.kernel.org>; Mon, 05 Apr 2021 20:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HwYnSnak3o/Uh3OBGWpG5ikUhu+VQqlNSoKM7/JIIu8=;
        b=b5a90JFxw3kuHNuBAl7EOQ8OLceice3s9zoyIclPR8QxBTEY3zekWMyEvfH4Acf0Wr
         Fqr/9fOrkdjAvwXsV7XnQmdS6irrgcVzTNGSTAKe8Ui6iwffUV69fJM1q9ovxFXg25Xu
         hpmQtmtPzmDBAJVgac+w47WqzBDGG9DWf+AgTQYYoPgp1h+PGyL3i2AV8Luk87YL6+ly
         E9m6T+61u2gPPx/2M0jbGeKJNmcseWI/4PLNXYuqHWcwlC/RBeO6w4AVRE6uKeCJKxY/
         iJOk9u1wvvX6VFVTqCfwvxHBjAntzo3RKY97oZMgoJ6w9vfxFkysF4wAZyUc1cT+bVXh
         S/cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HwYnSnak3o/Uh3OBGWpG5ikUhu+VQqlNSoKM7/JIIu8=;
        b=RNXCCZx29Wa4G7WZuWzm8yCEvYk0qDeSPMMxUMkWm2JufMaqV52FR0W6A0dlKO0v/W
         29m68Pqxf4NKK18b7dB0QC2Wet1jlEFa0tAh87x0EdLPZoxLH3mZe/WOoxRK4dZzjTE+
         c8Oi5buLMW6Tex75F87U4zi/iPpBxraKaNfg1y2rt3vVU78xDBG6I0Mmv5MmjAVvOBu1
         XUupN/RyZqophwo3zlWKp8A9E3tVrD98Nza1HuaYXPvwdTtJRcLyIRAjiPRHQxyKMT4c
         vyt+m50tgnBGk0c/ufcMU9oLgaJxasXcjR7oDRElwAyZvc+3HFC9mhinum2b0pqe+DC3
         /SgA==
X-Gm-Message-State: AOAM53268ARRqEMxiYCd5GQhmErTAN4/q4xY9Shpr4iLaClUdCv6fSsv
        Qj4a+2dPaO7Y5x/gdi4xCiCYWLRE4xEK6mJ29yV43Au6FTk2Kw==
X-Google-Smtp-Source: ABdhPJwnDUw1nXB6d9D1K1DfkF7+Zdm1DUepzqbn2OemZY4iOYJMMD6Fl1ngSNyb4TC3tFAMpozi6yn0VkxnJb+sX/E=
X-Received: by 2002:a17:906:4fcd:: with SMTP id i13mr20236604ejw.341.1617681159645;
 Mon, 05 Apr 2021 20:52:39 -0700 (PDT)
MIME-Version: 1.0
References: <pull.913.v5.git.1617185147.gitgitgadget@gmail.com>
 <pull.913.v6.git.1617369973328.gitgitgadget@gmail.com> <xmqqim544dl4.fsf@gitster.g>
 <CAP8UFD0AZWey045qK=9h8nVCVwK09s=t-=Z7OVBpvr4LAvSLUw@mail.gmail.com>
 <xmqq8s5x7ht1.fsf@gitster.g> <CAP8UFD17=BxHRkb7nmC8XsiGet+J=Adzqv4P6d9jzgnKXT9LJw@mail.gmail.com>
In-Reply-To: <CAP8UFD17=BxHRkb7nmC8XsiGet+J=Adzqv4P6d9jzgnKXT9LJw@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 6 Apr 2021 05:52:28 +0200
Message-ID: <CAP8UFD08Lagij6oqpOJkpbzMLRgQ08=mDfiyf1qXyD5VW6Ae7A@mail.gmail.com>
Subject: Re: [PATCH v6] [GSOC] trailer: add new trailer.<token>.cmd config option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 6, 2021 at 5:47 AM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Mon, Apr 5, 2021 at 1:26 AM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Christian Couder <christian.couder@gmail.com> writes:

> > > I would say it would behave as if:
> > >
> > > $ git interpret-trailers --trailer Foo= input-file
> >
> > Hmmm.  That means that the descrition in the original is quite
> > misleading, no?
>
> Yeah, I agree it is misleading and difficult to understand.
>
> > If it said
> >
> >         ... as if "--trailer" "<token>=<value>" arguments were given
> >         to "git interpret-trailers" command near the beginning of
> >         its command line
> >
> > then that may be closer description of the command line you are
> > forming, but as its written (with or without my attempt to clarify
> > above), it was impossible to infer that you are behaving as if
> > another --trailer option (with <token>=<value> as its value) was
> > given.
>
> I agree.

By the way it might be better to first have a patch that clarifies the
existing documentation of ".command", before the patch that adds
".cmd". This way the first patch that only clarifies the documentation
could be backported to maintenance branches of old releases.

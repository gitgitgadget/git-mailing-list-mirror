Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 020BCC433EF
	for <git@archiver.kernel.org>; Sun,  3 Apr 2022 13:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352718AbiDCN0m (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Apr 2022 09:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232486AbiDCN0k (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Apr 2022 09:26:40 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F11D32993
        for <git@vger.kernel.org>; Sun,  3 Apr 2022 06:24:47 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id z6so8379291iot.0
        for <git@vger.kernel.org>; Sun, 03 Apr 2022 06:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w/+xM37u/gVuIMOqQBAIDlrU47ch/EuiycjrPbdMcnY=;
        b=Rh3gltH4pW+oUiRDIYeQaOfSx4TJqLbZsTRuFPwxWhIBdmNVBkI9KSU6YPUTaOHW0y
         tX1OaXM4HE7GVvXM2TgaeyQhJxWu0ij8f1HpTa8p3RIQDwe5TCqWXIU98ddOj5OKEGm2
         U2dJSm6rIORxJBIktGKSq/adZ5mLCXydsFD/ZrN5oBv4oP3uomY8isVkNgltG8Ut7wug
         J3d6KdgmasiX3Dsu4vMhs2XAN7vemGbQ32qE3yiFFdD+igxZY4jP6zNTvkV5gGLNs1HC
         khO1yrWx2Qr66WLh5ZtiAewMeO6IjFkCEQsIeBVhIP2CoafNp+4JT54VNLyHhFAymayG
         HFYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w/+xM37u/gVuIMOqQBAIDlrU47ch/EuiycjrPbdMcnY=;
        b=k+4MmdjSXdVLcrgKkwszkarFntSocmaKKjZ1J7w11JHjZ0YfXEBLrXsRWfeQrDDRGc
         SwkMwsEPUuKLCX6FVmxwy7xR2Z5XFI6awqehGUSV464K5utxwuxc4D6ZqM5AR4laoZ5L
         xYj2dhNd9ZFCMbNqSDOuDVWoA5U+kfdpBX7pCc3P4rpDOFP8T0P0Oi7EY1dJ3arP7D0S
         qjh0zrp2FwA8nKbq3xFYSUkZpW7e25A4KwhytTF/GUynufv6He8hxSyG7nWTSAhaW42A
         nRT+toXLA0bOoHGi989PHRRCA3h5v6/19NaeUkiUx7dZG1xi1/CBSbOiIXTpd2bJkUxo
         gcSg==
X-Gm-Message-State: AOAM532caEEkJbZa84cZElo80nnaFzzRCFRo/YW73aFf+phRk+CMSfcE
        LWf08QnsullpRcaKFQ/fib83Oxm5cGDwGYW/We+XdpPumi5ahzRZ
X-Google-Smtp-Source: ABdhPJy3+N2zqKYDjU2J6w5TF7vqHBE+7/FCANyIUJ6iyW+LyiFhBC7FPCvYoy6fqkfsFoaBdohu0s+jqhNsm6Pu5Cw=
X-Received: by 2002:a05:6638:1924:b0:323:e821:b30f with SMTP id
 p36-20020a056638192400b00323e821b30fmr383104jal.279.1648992286306; Sun, 03
 Apr 2022 06:24:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220304130854.857746-1-a97410985new@gmail.com>
 <20220312164803.57909-1-a97410985new@gmail.com> <kl6lwngwqwm2.fsf@chooglen-macbookpro.roam.corp.google.com>
 <d8783660-1487-1899-19bf-10654801ea0a@kdbg.org> <kl6lee33xd5d.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqq1qz3dnqu.fsf@gitster.g> <kl6l8rtayk5o.fsf@chooglen-macbookpro.roam.corp.google.com>
In-Reply-To: <kl6l8rtayk5o.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   xing zhi jiang <a97410985new@gmail.com>
Date:   Sun, 3 Apr 2022 21:24:34 +0800
Message-ID: <CAN_FRNLyH4HB-1MbKGCDFingbaBTu4wmQoxUCrhEA0OhxHYkPg@mail.gmail.com>
Subject: Re: [GSoC][PATCH v2] Add a diff driver for JavaScript languages.
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 16 Mar 2022 at 05:34, Glen Choo <chooglen@google.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Glen Choo <chooglen@google.com> writes:
> >
> >> Interesting, I'll take note. I'm still personally not keen on supporting
> >> CommonJS-only patterns when we are purportedly trying to show diffs for
> >> JavaScript, but if we think this fits the style, I'm happy to oblige.
> >
> > The question is, with these patterns that are aware of CommonJS
> > convention, would your bog-standard-and-boring vanilla JS code be
> > detected incorrectly?  Becoming aware of popular conventions without
> > hurting others would be a good thing.
> >
> > And the "popular conventions" does not have to be limited to
> > CommonJS/Node.
>
> From the perspective of "'exports' is a special name", yes, we could
> detect vanilla JS code 'incorrectly' because, in vanilla JS, the names
> 'exports' or 'module.exports' are not special. So perhaps, one could
> imagine a browser-side script that deals with "imports" and "exports" as
> part of their business:
>
>   const exports = {
>     quantity: 1,
>     type: 'boxes',
>   };
>   exports.getQuantity = () => {
>     foo();
>   };
>
> This diff driver would mistakenly detect `exports.getQuantity = () =>
> {`.
>
> Although, the more I think about it, the spirit of this patch seems to
> be "we want to show headers whenever we think we are in a function", so
> we don't actually need to treat 'exports' or 'module.exports' specially
> at all, e.g. this case should also pass our diff driver tests:
>
>   const foo = {};
>   foo.RIGHT = () => {
>
>     ChangeMe();
>   };
>
> and if we do this, we will correctly handle 'exports' and
> 'module.exports' anyway by virtue of them being plain old JS objects.
The spirit of this patch is to show headers when we are in the
function body(which has a large code block). Because this can help
users understand the context.
And prevent mismatch non-related function. ex:
    function WRONG() {
        // ...
    }
    const foo = {};
    foo.RIGHT = () => {

      ChangeMe();
    };
if we don't match "foo.RIGHT = () => {". It may match the "function
WRONG() {". This would be very misleading.
So the v3 patch. I do not treat `exports` as a special keyword. And
can match the code like "foo.RIGHT = () => {".
The regex would be
"((module\\.)?[$_[:alpha:]][$_[:alnum:]]*\\.[$_[:alpha:]][$_[:alnum:]]*[\t
]*=[\t ]*(\\(.*\\)|[$_[:alpha:]][$_[:alnum:]]*)[\t ]*=>.*)"

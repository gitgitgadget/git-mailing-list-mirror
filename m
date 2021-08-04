Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93285C4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 00:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 633FF60295
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 00:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbhHDAjz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 20:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbhHDAjy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 20:39:54 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125AFC06175F
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 17:39:42 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id f20-20020a9d6c140000b02904bb9756274cso183702otq.6
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 17:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SqKtL3OEO/wYp2ZMTRRzO+Mn1JNINGjI0L54UAUqVJM=;
        b=dbY+Tj5vj5n2t7bUZvB9YvUhybzwr18NKfFssgFUi1aMtTGNOucGI53AzXih1fM8LE
         jp9Hff1fhFENjhmNMut+WEhkPgYqDAEgciDKTg13lr/6OKnh4GZbp23EnSps8V3+tvip
         37ke14IvY6FT5NwlQnysmjcEfWcj5yu+xFV8dSNnqHhyQp0sH2UiYw42UMBW1jpJw51G
         ktlnackeL5zbASQK/o/qWxl5vLr/+H9l54Nx/cKWZ8sHn43XB1wd3J9iQtdffn+crN24
         xy6rmU7sgw7a7uCn9oMdcu5eFKuJkUyGH1ilY5L/8HhgZi9RJMp71ChbCtTliSUKuMcG
         GMFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SqKtL3OEO/wYp2ZMTRRzO+Mn1JNINGjI0L54UAUqVJM=;
        b=peqwMQB/JZAtX3DxSNM848OdepwAaZ0CmSYscZZgW7PwdQt3v/gucL1MtWN7leV5s9
         /n41e8R7jnbcpm0rbxj7fSE3QeWPJCWZtUYDrJF9gTb4Elo78q0V10R9iPcixd0Uinnq
         nhnf6BCIYupHjFDAP1lcjLRLt8PF0IOtNXSSG+Dec0HB3vwZtArPH0nEsYCkKcP0xXxT
         /OCKwuUmmC7lMHmqa6+aaHUd0mek/1LUiPyoXd27DmyctY0FGUcDbVJ+e1WX2yL8dRaQ
         YlFSf+GO0nG71q5jIyBthCGOx6TGLbzFZaXKN9If1UfO/qdCyIN6pTd7g9JqSR7CxeC7
         7WGw==
X-Gm-Message-State: AOAM532nrTAFjDgY/M1cfMvNqYUEIfF02l+Ec/0FqXPB2TxwaYM9wHhP
        CXmhc1f4icNtpvfNSoxZnhc6/ObJbhjTwbyj5PI=
X-Google-Smtp-Source: ABdhPJxyXDtWzGMPB0UIE6ufSq7bAqERT9pZaHe9FecUlrMT2esQwh9c9ShoLNMyQRwYOe/kDWTu6q+ADJl1N4V6Qag=
X-Received: by 2002:a9d:448:: with SMTP id 66mr17311138otc.345.1628037581461;
 Tue, 03 Aug 2021 17:39:41 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1059.git.git.1628004920.gitgitgadget@gmail.com>
 <37a69fd2e0bdb7fba6b6c47c3edec0964165cb61.1628004920.git.gitgitgadget@gmail.com>
 <xmqq8s1irqu9.fsf@gitster.g>
In-Reply-To: <xmqq8s1irqu9.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 3 Aug 2021 18:39:30 -0600
Message-ID: <CABPp-BG_Ubg9-5PXXytRuCijDTgJbTab+e09YkzP20HiybZGqg@mail.gmail.com>
Subject: Re: [PATCH 09/10] Documentation: add coverage of the `ort` merge strategy
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 3, 2021 at 6:33 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> >  --merge::
> > -     Use merging strategies to rebase.  When the recursive (default) merge
> > -     strategy is used, this allows rebase to be aware of renames on the
> > -     upstream side.  This is the default.
> > +     Use merging strategies to rebase.  When either the `recursive`
> > +     (default) or `ort` merge strategy is used, this allows rebase
> > +     to be aware of renames on the upstream side.  This is the
> > +     default.
>
> The "this is the default" at the end is about --merge vs format-patch|am,
> so it should come near "Use merging strategies to rebase".
>
>     Use merging strategies to rebase (default).  Renames on the
>     upstream side is taken into account when the `recursive`
>     (default) or `ort` merge strategy is used.

We can simplify this to just:

    Use merging strategies to rebase (default).

because when git-am -3 was switched from `resolve` to `recursive` in
Dec 2006, it too gained the ability to handle renames and made the
rest of this description for --merge obsolete.

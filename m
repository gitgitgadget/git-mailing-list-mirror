Return-Path: <SRS0=GnTn=7I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E007C433DF
	for <git@archiver.kernel.org>; Tue, 26 May 2020 19:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65C042053B
	for <git@archiver.kernel.org>; Tue, 26 May 2020 19:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VnuMnm3M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392412AbgEZTTL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 May 2020 15:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392401AbgEZTTI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 May 2020 15:19:08 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C9FC03E96D
        for <git@vger.kernel.org>; Tue, 26 May 2020 12:19:07 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id e7so12461485vsm.6
        for <git@vger.kernel.org>; Tue, 26 May 2020 12:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/OX2Mj27IrTJ4TMgnaV3ld5lU3zjPjJdTD9qnx1OCUk=;
        b=VnuMnm3MBCC4iuincqLSDG/iZjGMTZ2iFHD+0w1znj9Si9uX0XzltvZnaPQDsYOzRZ
         z8s53yHDzBQr4WfSOyHiIYGRYbT+ZiH/dGPb/fSriLtdCtns8BUh1h68eOmneLD8kaxs
         SGy2MwtuCbQpXx/UIUZtoohQiQqdZhfwSCl+7ZNih0xgCkjS8xQZkGyxo8v/DP/WxVWi
         a9FfF6L7TuhAKFgSwEd6OGr5dtLkuYiTK5SYoBm7mpqFpPI5zKowty93GcFbokhot0rG
         KVz/6XsT9Ku12G0WOtuGo72UHZ3TwA8riQaprOTciO7+MWANUn0hOqRr49ormUjl2eWr
         CWsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/OX2Mj27IrTJ4TMgnaV3ld5lU3zjPjJdTD9qnx1OCUk=;
        b=GuPFnEl1XKO81aqJKuGR/6VLazZodQxVV+N3I7aNr5S4HHbcD3Eqd8vNH7zgvkHWBb
         DQk0XDY3Qh5nhrz6DZeE39XV5UGlI1FTHyhhcJR0/2PcTOuzwWeu2xjVmI7zqThkNT9R
         GhCi7cu3WQtwGpvfLKHU26H4RWKEoDELH6anJfEkk5mYGaOKJeRBlbbScYWvcSwIoNVh
         aisduKvWkzBZbtHProvJsANfsseUbJFquKn3KuOAZWIKoBxBiopeLJdjqINKy4CQCMe0
         Iaa3gxIOwDCoLCJ8iPXCqBZsGsJ6RzL4aKNgXFmEXt707fUnGvg78HlsDB/5RANO8Nqg
         PtLg==
X-Gm-Message-State: AOAM5321i2oJR39rvA5v3ssWlXB5yA7Qk7N7wYp4MZ81yQQnPGVJF5eq
        2UbwdaJX127B40/tqgOQFSbEtSJ0WNn75ASYPB0=
X-Google-Smtp-Source: ABdhPJxGYt3MF/W1Yy8FaOMyKQQrgIJjFeMY7fDzmUuTn/OSTZiJAvO7GNnW1wjFiD2mo5bDqCPrLF6JtJDjGzTAt4o=
X-Received: by 2002:a67:2f95:: with SMTP id v143mr2142199vsv.79.1590520746704;
 Tue, 26 May 2020 12:19:06 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqsgfx0z9k.fsf@gitster.c.googlers.com> <20200525170607.8000-1-martin.agren@gmail.com>
 <4a3797f8-5169-b016-b1c4-ce544f00b34b@gmail.com>
In-Reply-To: <4a3797f8-5169-b016-b1c4-ce544f00b34b@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 26 May 2020 21:18:55 +0200
Message-ID: <CAN0heSq3mv8OcFiESVhN_fZ=iChSAUQ_Js0g=bTsY5dMepkk9A@mail.gmail.com>
Subject: Re: [PATCH v2] rev-list-options.txt: start a list for `show-pulls`
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee,

On Tue, 26 May 2020 at 14:24, Derrick Stolee <stolee@gmail.com> wrote:
>
> On 5/25/2020 1:06 PM, Martin =C3=85gren wrote:
> > On Mon, 18 May 2020 at 22:22, Junio C Hamano <gitster@pobox.com> wrote:
> > @@ -671,10 +671,13 @@ important branch. Instead, the merge `N` was used=
 to merge `R` and `X`
> >  into the important branch. This commit may have information about why
> >  the change `X` came to override the changes from `A` and `B` in its
> >  commit message.
> > +
> > +--show-pulls::
> > +     In addition to the commits shown in the default history, show
> > +     each merge commit that is not TREESAME to its first parent but
> > +     is TREESAME to a later parent.
> >  +
> > -The `--show-pulls` option helps with both of these issues by adding mo=
re
>
> I like how you found a way to add the list item without needing to make a
> huge shift in the surrounding prose. LGTM.

Actually, I didn't see how to do it, but luckily, you did. [1] So I take
this to mean that even on re-reading your proposed text some time later,
you like it. ;-)

Martin

[1] https://lore.kernel.org/git/34870e5f-8e61-4af8-1050-43bfbe30d8f9@gmail.=
com/

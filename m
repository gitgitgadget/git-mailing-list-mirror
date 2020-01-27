Return-Path: <SRS0=ksp+=3Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 729B0C32771
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 06:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 353072071E
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 06:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="IBjoJYkc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725840AbgA0Gu3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jan 2020 01:50:29 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:46720 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbgA0Gu3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jan 2020 01:50:29 -0500
Received: by mail-ua1-f67.google.com with SMTP id l6so3031444uap.13
        for <git@vger.kernel.org>; Sun, 26 Jan 2020 22:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2KmLfgjOiPqTj/XQFxzIO5uyX+DpvrdK8V6PkK/ZUa4=;
        b=IBjoJYkcVX9hwlmN2KBIpkmJuJhJv3GL5fx6xoUmYxzMo8+3tw1U+OXR5fgbZZpq/Q
         7t8UtfPfX/tZ9cziW1T1frzTso3K7+uSIKampxEtIghFiKVWRvN/jXQm2uzW6WxA3Qjj
         C4NpoAl8e4zfFfXdlDqipZuToHHlKw0LAk3L0oCJYb46M90prVOvau4k6Ci1xHn1xdgz
         hu8nc8I6/ZQdPhHgBdQZU0qVBOwexJ9E41L9HgBocYff7nfCiEw/+eK+jGDxlkQeri+W
         +Sajl7PeY0lnVyZOI3FpLB/ZlHfUAkmAP78eY12I+guN7pJUFX9PpaWW+e5ql0Nk3Vb1
         OqCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2KmLfgjOiPqTj/XQFxzIO5uyX+DpvrdK8V6PkK/ZUa4=;
        b=rmpVguIDRpEyP8pjvra0BWCVUS1UBJ0DgKYiSwLOP0IcQTHcrUZRzKXGFQ5kWMw0J0
         kMazHzRTtvSii0Ai3r+Yt8vevW7WpPZ5Z2DOQxCivQptDyL4xCVN6S7m7pKScPfYy00Q
         hwoxqbgu4/e2Dk2NNg+t3JvfCYXQFB6Uqfjw/hx4jxVT+dZGIni9XV010pmthPXBYOmG
         YZ/LywIzIittbZR/JP0egxIFvwM07B86c7+5T9yTVmiZaHlbExy2SIsp+zJxNS39VIrr
         ufflceu34bbsw0l5eBsx8l9+8r2dTvoxSFahlecVRBK3pypfN3Wr0WRFlcBTWklqkqlb
         Hnuw==
X-Gm-Message-State: APjAAAUlNcSMCelYUL6NuPtjzNuX1e2MNGjOl5b8zPHH4xUMbWN235lr
        6x/tFIdmhYRu7qKvrH32RMSnMq5oiyTfxzQ3x5k=
X-Google-Smtp-Source: APXvYqz1dvtRbCitHxUGepYLxSViBRhnr2ji0SaJyT8pUBRRbH0oBJp6bnknl3wEc4/1w/lN4x5ACy1ddPJhisJ5Oz8=
X-Received: by 2002:ab0:60ba:: with SMTP id f26mr9009867uam.51.1580107828093;
 Sun, 26 Jan 2020 22:50:28 -0800 (PST)
MIME-Version: 1.0
References: <cover.1579857394.git.bert.wesarg@googlemail.com>
 <xmqq36c4zi0x.fsf@gitster-ct.c.googlers.com> <CAOjrSZtT0bX=hhH=OZdA80T_Thgn9drG66xcVMYjo7Q=5Cw_Bw@mail.gmail.com>
In-Reply-To: <CAOjrSZtT0bX=hhH=OZdA80T_Thgn9drG66xcVMYjo7Q=5Cw_Bw@mail.gmail.com>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Mon, 27 Jan 2020 07:50:16 +0100
Message-ID: <CAKPyHN0giHdGeeTRe6ZQL14d=1GkkC24Zu142gTuDAZhqtittQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] remote rename/remove: improve handling of
 configuration values
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Matt Rogers <mattr94@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio,

On Sat, Jan 25, 2020 at 1:39 AM Matt Rogers <mattr94@gmail.com> wrote:
>
> Yeah, I just resubmitted so you should be good to go

I can resend the rebased topic at any time. And as I don't see that
you picked up by latest re-roll (cover in
cover.1579857394.git.bert.wesarg@googlemail.com) in into
bw/remote-rename-update-config yet, I think it makes sense to do this
now.

Best,
Bert

>
> On Fri, Jan 24, 2020 at 4:10 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > All steps looked quite sensibly done.
> >
> > >  - patch 5 will be replaced by/rebased on Matthew's work in 'config: allow user to
> > >    know scope of config options', once 'config_scope_name' is available
> >
> > I expect that Matthew's topic would become solid enough after one
> > more reroll to name the function back to config_scope_name(); after
> > that, let's drop the step and instead fork this topic off of Matthew's
> > topic to queue the remaining patches on top.
> >
> > Thanks.
>
>
>
> --
> Matthew Rogers

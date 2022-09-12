Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2739BC6FA83
	for <git@archiver.kernel.org>; Mon, 12 Sep 2022 13:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiILNQP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Sep 2022 09:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiILNQM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2022 09:16:12 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA9C2ED4B
        for <git@vger.kernel.org>; Mon, 12 Sep 2022 06:16:11 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id s5so3136726uar.1
        for <git@vger.kernel.org>; Mon, 12 Sep 2022 06:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=9PcV3Ss898qeZZfG4XeimFrJ1+/jgAnGNsVW8EysZ/Q=;
        b=RfuP8/QaGCgc8ecfmoxp5zStBa+bYMEqJjhAz0pMCqrrlMhsQptdV58t1fOVkWwuxH
         bX3bA45LFxwjisvCmjJPQrl9isfxLLloutVvPsbhMfo4w1REPDnvdTpfcgeWMR1ul3Pp
         SUb+nC4YVKUciSVUJ+3y00/pS64Oez/ivNNz/giMfX7CK1jjfRdx5WALrNwAF+JrNWwh
         mE7a3QpLlteQpKd+ZCUoYKBpBI0lyHy+jv6ldrcWhvX+yRk8J1/Y1ryXh1XtAxS0MUQL
         NOMr8j362Kjn3/cSyuMoU6dS8rDbIPGkQyAugeiBXMDHM24mAK2j7dTRmOQm+yTKm0Ri
         Cmsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=9PcV3Ss898qeZZfG4XeimFrJ1+/jgAnGNsVW8EysZ/Q=;
        b=5ogJAJMMFibA6Vz3n+A4DHTytR5J3B5Nhh3NNFkKAnS8XVgDlgBoXuzWxQLPiaXTAW
         YCdM5xsVCzCTIAcN/yikpLgVPj2/rLX7ZOUhSh/9/YqZtAdiO1DBQoeoTdYdalt9GoLP
         E8z0UgMXhpdTIR3cINXXdMRrczBb+oS8M37mgjEU3v6GWp4zxrq3/4/2dZcSKUbHhraL
         cRr8MZ5q8VkYvrPgKd5Lt0l1IJ+KcUgVoAjilfSIaIESVV1HgKrkzEllBqXglCxeqyUV
         2iPaEP5st9WLy3AccuDjp4NdCUOeLjeJchj/N/3+LEiURj3qvzMWaoMHkgVDl02ampFn
         hfrQ==
X-Gm-Message-State: ACgBeo1c6xejul74SbvNgca+A6xg/R99One9WxJ3N6zxit+1N46LBLuk
        zuKKFyTlelSa0f/uDM5Sk1NE5xWmXT9MUSbtrg==
X-Google-Smtp-Source: AA6agR4QnO6EYdytlFY40zX5zw99wXKv9HVVcQgXrkgV8RFwwHOgpOmNGomfkF6q+XmyDi6Y5xHIFPF3eDDvCOE0CZM=
X-Received: by 2002:ab0:69d3:0:b0:3b3:ab36:a638 with SMTP id
 u19-20020ab069d3000000b003b3ab36a638mr7915792uaq.35.1662988570710; Mon, 12
 Sep 2022 06:16:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAP8UFD2uUFveiGDAbxObDOh_krmexuLe860Gu397e9KddH0UCg@mail.gmail.com>
 <CALOmtcVN8K59Zkv7XKM7w2zFCbdWKfKr=97-E3306nQHm4Zw=A@mail.gmail.com>
 <CAP8UFD1kinAwq7AL68QXqFR_dxkNFaTp2vP_DUU0KKqkbsXCDQ@mail.gmail.com>
 <CALOmtcWaQgrPTkRA6F8bL3Hp64cOxYrB4xHUa1WC+P34ZdFEbw@mail.gmail.com>
 <CAP8UFD1HGbbmJWB_TksGVLa-7nNBz5pdFi59Y7LP3EODF9Lztg@mail.gmail.com>
 <CALOmtcWFwfV11Vxf1xd_fC=HYGPNO1PtKT=E=-A104cGnAbv4g@mail.gmail.com>
 <CAP8UFD29NgffUBz0CMKyt901Z7Bj5osoBT-4Mfxfp0h_4Qo+Qw@mail.gmail.com>
 <CALOmtcWTw=bo=AqGBN8z9Hf602Peu9AVngwKUZZsCt0cr8jbDg@mail.gmail.com>
 <CAP8UFD3CppGBFeWjM32AmxNs=SsVcH+tyTC3VJNXb4V-=V9EXQ@mail.gmail.com>
 <CALOmtcWX0QZYXSH-_+RMwi804bgsC6aENJE8bmgv7+1NGT4Jng@mail.gmail.com> <YxvBBZkN6yxUquou@nand.local>
In-Reply-To: <YxvBBZkN6yxUquou@nand.local>
From:   Tapasweni Pathak <tapaswenipathak@gmail.com>
Date:   Mon, 12 Sep 2022 18:45:34 +0530
Message-ID: <CALOmtcWM7k+Ayd1rw2fVcXa0M5PkaStaZaod_a=uiOh9Vmft0A@mail.gmail.com>
Subject: Re: Unify ref-filter formats with other pretty formats: GSoC'22
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Hariom verma <hariom18599@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 10, 2022 at 4:11 AM Taylor Blau <me@ttaylorr.com> wrote:
>
> [-cc list]
>
> Hi Tapasweni,
>
> On Tue, May 31, 2022 at 09:54:24PM +0530, Tapasweni Pathak wrote:
> > I will update will a timeline in the next few weeks (June).
> >
> > Thank you for the information.
>
> Sorry that this has sat in my inbox for so long. Did you get around to
> updating this timeline? I was talking with Christian off-list, and it
> sounds like this could be a potentially good fit for Outreachy, though I
> am not sure of the specifics.

website one?

>
> Could you two work together to resurrect this project for Outreachy, if
> that is something that you both are interested in?
>
> Thanks,
> Taylor

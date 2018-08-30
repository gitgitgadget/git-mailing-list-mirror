Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 702371F404
	for <e@80x24.org>; Thu, 30 Aug 2018 13:25:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbeH3R1p (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 13:27:45 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:32854 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728722AbeH3R1p (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 13:27:45 -0400
Received: by mail-oi0-f68.google.com with SMTP id 8-v6so15396608oip.0
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 06:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RhF4moJJ4QbLumgwfHzZ+MI4lOk4QzJGspGF+xnv59Y=;
        b=Bk4zb+FCYwhC83T7/qc+hD66fuxCvh1UdifhYvhS9u6IS/ZVMVfEQCYIrSPvIanwmK
         +rXI/yacfMMFpL7XIrYWStto8opY+v69DaRyC1SmsNbom7Qtyv4PUVI0E7BfitTGL0ZG
         jHkCmvOTlOSXwxsj/zo7X+iHa4bW4muyn17kUOjnHuNs7hGzRrcdPKy0PiOFanRv11mt
         75r6NatFNU8NTg4Wm0S6LS7z2IDnMjEW2Lzwakrh5V2EImv8tysTt6qQqNBD/zeVsQGV
         ovDwrYPKVWf0UZ+eG5zHZzT2v6xRS7KmYMIqiRYdkZ4QYrpG160ZVx2RLdOy79hSIZZ2
         GhUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RhF4moJJ4QbLumgwfHzZ+MI4lOk4QzJGspGF+xnv59Y=;
        b=ju6RWPSHh6UGjjbFc0I3P2H6vxSZh9qI0n5DJPVB/JpM1HFVlGoA/zCtXyvHDXdLRY
         XJQ39perZyHJzPMPqEaQeFjRR/KU2YjOrR+0bG7Ycr1J3kX3LIMP+0v2y7nc8lFzi5ta
         Y15d4Qty+uivN5pJcY99/W7oGWglV+9DslmHdZdZYatsFj6UIph2UJ5BmdLYazPiRb6g
         GQUX8hnfLa7IuokNOtbLl9DnOkkNDt8+9s94H8dNWqRpX9iPkAZ2yLgbeZoqLUq8U10+
         cUj/Vi26+qdVRerOezFDO/uqYUyNmVwnsyiUraPC+rMONZk+MkOJzYI9xyo6NU5eyYby
         qxhg==
X-Gm-Message-State: APzg51DPSZufOTpd6Tb9zN6mcL6MaDi7YQB47Qlx2xCKU9xGnDrkjMDA
        YwLaacejLEenu4VWNiF8u9WMtMN0yxg7QM4dWnsaqw==
X-Google-Smtp-Source: ANB0VdaMOxzxtssf/1nldROKwyGI8xCCmyCYkcSTDRof0qsZlnOk60XUab0FWHANuF79+DQIE5bhz/6BVsdUxa2zfJI=
X-Received: by 2002:aca:3882:: with SMTP id f124-v6mr2607022oia.195.1535635536660;
 Thu, 30 Aug 2018 06:25:36 -0700 (PDT)
MIME-Version: 1.0
References: <20180829205857.77340-1-jannh@google.com> <20180830070548.GA15081@sigill.intra.peff.net>
In-Reply-To: <20180830070548.GA15081@sigill.intra.peff.net>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 30 Aug 2018 15:25:10 +0200
Message-ID: <CAG48ez1uK9AhmodAVH_hWuzLfVQh1=mp2=WQcUaNoEQ8nMHtpw@mail.gmail.com>
Subject: Re: [PATCH 0/5] handle corruption in patch-delta
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        pclouds@gmail.com, johannes.schindelin@gmx.de, nico@fluxnic.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 30, 2018 at 9:05 AM Jeff King <peff@peff.net> wrote:
>
> On Wed, Aug 29, 2018 at 10:58:55PM +0200, Jann Horn wrote:
>
> > If `cmd` is in the range [0x01,0x7f] and `cmd > top-data`, the
> > `memcpy(out, data, cmd)` can copy out-of-bounds data from after `delta_buf`
> > into `dst_buf`.
> >
> > This is not an exploitable bug because triggering the bug increments the
> > `data` pointer beyond `top`, causing the `data != top` sanity check after
> > the loop to trigger and discard the destination buffer - which means that
> > the result of the out-of-bounds read is never used for anything.
> >
> > Also, directly jump into the error handler instead of just breaking out of
> > the loop - otherwise, data corruption would be silently ignored if the
> > delta buffer ends with a command and the destination buffer is already
> > full.
>
> Based on my earlier observations, here's a replacement patch series I
> came up with. It has:
[...]
> I hope you don't mind me hacking up your patches a bit.

Not at all. I'm happy that I don't have to write a v2 series.

> Thanks again for your original report and patch.

Thanks for turning my patch into something decent so quickly!

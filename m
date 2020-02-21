Return-Path: <SRS0=3Brp=4J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2BFC35646
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 16:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E1552067D
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 16:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJuTotI/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbgBUQEA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Feb 2020 11:04:00 -0500
Received: from mail-ed1-f45.google.com ([209.85.208.45]:36360 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728130AbgBUQEA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Feb 2020 11:04:00 -0500
Received: by mail-ed1-f45.google.com with SMTP id j17so2976653edp.3
        for <git@vger.kernel.org>; Fri, 21 Feb 2020 08:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mqVuFoanZJ4thEYdUPULG6HtTpADOfEL4eR7NzIul0E=;
        b=BJuTotI/nlv3shIq+yweHlzaHazeLaUz9V1w2/f7Dkva/nNKZN728xAbbOIHq0ej1v
         2fPROPDDsMh451QQFi40qGq+VCtoPIlLerSPgIK2GUcc5dEI6ahJGYVbdS435BoMPjDY
         ttqp+17G9M4UFv+sriOcIZHha0U3S4whlyIH+zTHAPA74HheTwyQ19FJ4kDYLDoDMGg3
         SSCN+MBGXB9j+Gq2DPc+0boa+QLnQoHXmbl6/N9IR/cUg0/kowOsWXVACUN11ffUpLfj
         UNh5U0xE7+AjEJGCqbMlATY4UDy23f6Gg9aL9iNlFYqrcjSt/Wc9AY1VRt+DIY4o8HQ5
         cZVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mqVuFoanZJ4thEYdUPULG6HtTpADOfEL4eR7NzIul0E=;
        b=Rs0gK9uacVfBaapKpGERUOTiT1/NlR2WHXgBhEyRKwqKICwSfxE0ndcdqRRP0+6teu
         AdXFe+9nTxdw0lay8Zo5xS83zytg2bDX1XqKmbPXl/W3KyxeCQsInXCG6qSR0Fm9CQAW
         /VIH98CaFuoP+4++rscj6Owr8G5J0/uJzdd47dZli1h8/gija9b575dqyVYW30jGh/a3
         RhNt5FCW4q8lWSpOhbsExFLQR9rDddgESibbI2tfW1ReywkmydpvO29Uqv5eEt6E6VFy
         H5PBDXFJjR8DeVBAtv/mL9evYrWYnl12EdEBv9EgoCFMnpxa1MLxEX0t/AfwyvCzWjVv
         J8NA==
X-Gm-Message-State: APjAAAUXmPCf5vNL5l7BL13hFe7ekhxzErI2t1Y05uHHJ0251N80aTsw
        DavWuc47UEgHPkoWv+j0qheWqtPk4ymoQI0V73U=
X-Google-Smtp-Source: APXvYqwYQ/DgEJu0blLq/NtMEBgSY1koIB8K+5XX/zHO/nWzyH32jyBsxOXRXuwD56OCw/a3A/yYMBQf6Sb+NC0zJvU=
X-Received: by 2002:a05:6402:513:: with SMTP id m19mr34514674edv.387.1582301038636;
 Fri, 21 Feb 2020 08:03:58 -0800 (PST)
MIME-Version: 1.0
References: <20200122053455.GA51054@coredump.intra.peff.net>
 <CAP8UFD1-cswU0gSX3a2KqiExhYgY_qMZ6Sz7FHdxs7mrb_hh-w@mail.gmail.com>
 <CAP8UFD2_qmB1q9vhz=BJo3XG4jnLWDPhCVVb4gAh_pfKoGnZJQ@mail.gmail.com>
 <20200204163716.GA7308@coredump.intra.peff.net> <CAP8UFD3UewcZ3oid_SiUYuFEO49JTzaSigHDTP8OPs2yh6s6zA@mail.gmail.com>
 <CACg5j25_098i=rU++OB=YSbAFjCQdgUX7gP6D-9yo6F_A_yn0w@mail.gmail.com>
In-Reply-To: <CACg5j25_098i=rU++OB=YSbAFjCQdgUX7gP6D-9yo6F_A_yn0w@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 21 Feb 2020 17:03:47 +0100
Message-ID: <CAP8UFD1QbOK9g2oAhfTm2npoNF9Ay_HiAfFai9rJwZzc73cBbw@mail.gmail.com>
Subject: Re: GSoC and Outreachy Summer 2020?
To:     Heba Waly <heba.waly@gmail.com>
Cc:     Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Heba,

On Fri, Feb 21, 2020 at 2:44 PM Heba Waly <heba.waly@gmail.com> wrote:
>
> On Sun, Feb 16, 2020 at 11:39 PM Christian Couder
> <christian.couder@gmail.com> wrote:
> >
> > For some time I have been thinking about trying to get more former
> > GSoC students and Outreachy interns helping us with mentoring.
>
> Hi Christian,
>
> I'd be happy to co-mentor an Outreachy intern with an experienced
> mentor, hope I'm not too late.

Thank you for your interest in co-mentoring! It's very much appreciated!

I don't think you are late. It seems that February 25 at 4pm UTC is
the deadline for project submission.

> If so, please guide me on the steps required to get involved.

Earlier in this thread Dscho (Johannes Schindelin) said he would be ok
to mentor someone for Outreachy, so I think, if he is still
interested, he would be the best person to guide you on the steps
required to get involved, and perhaps he could co-mentor with you.

I am planning to mentor a GSoC student this Summer, not an Outreachy
intern, and I think it would simplify things for me if I am not
involved in both programs. But let's see what Dscho says.

Best,
Christian.

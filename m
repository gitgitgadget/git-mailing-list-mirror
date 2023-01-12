Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F93C61DB3
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 17:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235050AbjALRRl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 12:17:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239063AbjALRRF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 12:17:05 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF8981D62
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 08:49:55 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id p133so422386oig.8
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 08:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y2312G0Jar0JPUkTyz7GQnb9PmPlZbbiGfc4E5/oJaQ=;
        b=A87nMtV/+0X8vq3t3C0cNqwg3Wx8jNQK5b0QA/BBmiEUqmOzlwhyIbkcR/2BlCpsWf
         gf8TUVkg+7t6cJ5ivQLmkjtIFdR1ANHOyftHf8moAwl1I8mn/8sbWksR2b53zEgVhpYK
         qretfQbd+819EHJKRmhHlVBQiqMgAp3nXn17Hq8mqNlya2o8E0bLD6zyniWf6HmqF0GJ
         0SCbCarrhbJkbTL9xkGR7Abqd52aXIqULmIXeak7JuI9iBNhLVIcvzw1P/kzT8h2hX98
         zIRr2RWKrtJIZZWPihL3aOPxdS1FYdxliepDK6xL76K66mwUFz87FIPXZa/eRq+4ugQr
         OrgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y2312G0Jar0JPUkTyz7GQnb9PmPlZbbiGfc4E5/oJaQ=;
        b=INmPEE+QMiacwfsZZv9yoQhrT46W8zxKFZ6JAMKrO8hjXo9owsN8nL/Xm+we8rVCsF
         HMZ1PNggrDNT2FwuyeWXi+8ja1A0n+g7hgcO/oqOwKf73rqmmY/bz2Oc1Tw1Ny9JeQW/
         eFWc2e8OGoKznFmOHDfLhtrrHz+apTMebehoLVNpk60kICXRmYeMB5fVW4hVCDspdASE
         wFk6Eh259Kx6kfevp+k7CnqaHiKTq9t+F2PcxttS2zw3GJx7GBFh+ypWs0YK/fto3ePS
         1p8aYEgndNU7zGKKKv+uBGTumXqh8wxS5u/weIAW51+Iiw6qVD/YTCJyR/wba15KPU5+
         su/Q==
X-Gm-Message-State: AFqh2kr6bQA9J3varyCU5tx8Dg6Unl1mdLlaEJdLNWZ26mP6psKJi79w
        WJH/QNx8OnfqNKEsuGNNXe1AzybZkpnedW+EehL7ywb8sxY=
X-Google-Smtp-Source: AMrXdXvnyZ7EbojlcuvKxCnCTMHwcteyhKCK57c7UruHLaMVJ92hu2KECoC3/wCHaIQlLFCCJXAXx1u032kDZtkXZ/M=
X-Received: by 2002:a54:461a:0:b0:35b:c586:d978 with SMTP id
 p26-20020a54461a000000b0035bc586d978mr3967191oip.77.1673542130504; Thu, 12
 Jan 2023 08:48:50 -0800 (PST)
MIME-Version: 1.0
References: <7hfRSnKTRnT4uJh5Pok8U8gfLm_NXzCS6w_7_Rc9OH3a9Lv8hpjySZqxDglBFC-fTOdZHi-ODCihiEHlQD9nIhUmld5jYvRx_JvB0z2IAL0=@164.ooo>
 <CANgJU+V8VpM8sL=wmBnuTRzZzz-0hwzj6gP6tGhf5OhGv=K9Gg@mail.gmail.com> <230112.86bkn42iou.gmgdl@evledraar.gmail.com>
In-Reply-To: <230112.86bkn42iou.gmgdl@evledraar.gmail.com>
From:   Rudy Rigot <rudy.rigot@gmail.com>
Date:   Thu, 12 Jan 2023 10:48:39 -0600
Message-ID: <CANaDLWL0vpuyNdfW4zPUSvnyR_GukYr-=y35fiaCLXk+fyueig@mail.gmail.com>
Subject: Re: Request to remove Junio C Hamano as the Git Maintainer
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     demerphq <demerphq@gmail.com>, Filip Lipien <aaa@164.ooo>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oh, I know your email was not in response to mine =C3=86var, but I feel I
should clarify anyway.

We're glad that our data points about our internal adoption are
looking good about Git itself, but that is absolutely not to say that
there isn't a lot of room for improvement on Git's UX. I fully agree
with how =C3=86var put it. If anybody had in mind to do work to improve UX,
please don't read my previous message as meaning that such
improvements would be pointless.

I've been lurking through a number of threads of the mailing list for
the past few months, and it doesn't seem to me that UX-related patches
aren't getting attention, quite the opposite. That is a great thing,
because UX is hard to get right (particularly for powerful tools), and
obviously that kind of work doesn't have a finish line. I'd argue
those are some of the most interesting threads on here, and I hope
people feel reassured that they will be supported through those.

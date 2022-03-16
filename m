Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBDAC433EF
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 03:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344046AbiCPDUN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 23:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234584AbiCPDUM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 23:20:12 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38374C7BC
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 20:18:58 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id j3-20020a9d7683000000b005aeed94f4e9so616267otl.6
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 20:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q8SOkvwjVa1SjndYSMTBfJj4qzjb7G45CO0IO9HJUYw=;
        b=TP0RxvoQyCfEAA34eoGhjD/NHM5+PtKM2lOJRL7+1m0Te60w1bhDmmbb/c7IRe4a5f
         Ww/n4EGub+1TiouGr294LAA/r41L+nveAfaD8F/TM8Qd0HbGygeI8+G6HMWWc3Tclbfp
         5zLFYT/D4gNo9hHP37CcDC4ivFOjOS1dA6uWkNiYt1W8mysMV23R+oOUUhbjiYU+gNlr
         AD7YmJ6qp/wxsuaZibO2i8y/GsbPZV/00+4AY2yVn/++4iPMDHhG4u31Y+V4yaXFgVXZ
         Zl/yaXwxePQmu/SQrhWddXHjhBWySVmNPEExHwVqmGJPNGGJ2EliuoLLgwHk9k6ZgAzJ
         mgyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q8SOkvwjVa1SjndYSMTBfJj4qzjb7G45CO0IO9HJUYw=;
        b=wkxxxfsmt2g4LZyg+w6W/WaA6vdlldtNsfgFk90Uz0tsZ9nd9k2dynZB/lJUdV9X/S
         M+FuPqYuzIv6yn2PogaPc7Jvb9q7H1A9fNfWe54d++J7WVpTk8mIc4WK1+nqhyImdtfb
         aS+9pW45RpW9DfRvQq+8zDaKigQ+hw+JHB8hU7xZeazwwM23UbWlzYpagdOZQf193qrN
         5J0X99fQlghZbWYZsM1D83mgPIUzUamtDGoCe+cktNrkpOnplNhqoq/EDIPi5roqce0U
         05GQVzB5I8AwP28Yc99wCsCp/XuPCgek0SDamz1J+k8sPMgCZvE0HUn8fDgWMW49XwF+
         f/6Q==
X-Gm-Message-State: AOAM5324lK5oMxUdDkdp5go/+IUrOIFazo6FNXx7hrYRkbTYqpitvWKa
        jVtRZ1cVH8xfHIoAG6YPx9g5jgc5JIVr1nq4U8b1LyBGulo=
X-Google-Smtp-Source: ABdhPJydMsDD0PHU/I1foIs6Ed3ilurudczJFiJwTFVXoynusRnk77+VvponO/uKfaeEMPyCD9cE8ZR1U9zCauFKxDc=
X-Received: by 2002:a9d:162:0:b0:5b2:1c30:a1e6 with SMTP id
 89-20020a9d0162000000b005b21c30a1e6mr13296534otu.26.1647400738124; Tue, 15
 Mar 2022 20:18:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220315100145.214054-1-shaoxuan.yuan02@gmail.com>
 <20220315100145.214054-2-shaoxuan.yuan02@gmail.com> <1ab24e4b-1feb-e1bc-4ae4-c28a69f77e05@github.com>
In-Reply-To: <1ab24e4b-1feb-e1bc-4ae4-c28a69f77e05@github.com>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Date:   Wed, 16 Mar 2022 11:18:46 +0800
Message-ID: <CAJyCBOQXnKC9oGc5RDH-uRtc679RVnb-8bKAJ5QTpYnOc0D4Lw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] mv: integrate with sparse-index
To:     Victoria Dye <vdye@github.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 16, 2022 at 12:07 AM Victoria Dye <vdye@github.com> wrote:
>
> Shaoxuan Yuan wrote:
> > Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
> > ---
> >  builtin/mv.c                             |  3 +++
> >  t/t1092-sparse-checkout-compatibility.sh | 34 ++++++++++++++++++++++++
> >  2 files changed, 37 insertions(+)
> >
>
> Hi Shaoxuan!

Hi Victoria!

> Thanks for working on this, and I hope this helps!

Thanks for all the feedback, they are really helpful! I'm still researching and
experimenting with various documents and examples regarding your
feedback. And I will try to submit a more refined patch in less than a
few days :)

-- 
Thanks & Regards,
Shaoxuan

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771E6C433B4
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 17:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4366661184
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 17:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236684AbhDVR2j (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Apr 2021 13:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236459AbhDVR2i (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Apr 2021 13:28:38 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70BC2C06174A
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 10:28:03 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id 33so14408606uaa.7
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 10:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=t9JqXWPCu1XNJBQSL0sKyN0+mx+VD18e8/FNMTuhuJY=;
        b=iT6thAb2Sv8RG6I15Y+X9EjoIxI+XDsbXmOvlPnB77UyyEDEQzulAu9uu2TyK/BIG/
         7PmwFL58sAjxxX1fJ7IBxKwwrArCFc+IDKIuku0GHiX57O0OwQrnhW1xS0Pqpt/aduDG
         HH7s/Eeqo79K/y4z4PXuo60D7sCYfN1T39ZIQxZvtQw4P6erAwFXdTwckW2vgSMQAegU
         ChK6qUzT0BvLigIPI4i8NvQz3oXVU8cY8d0f1ODJsdTVNfYxRctDuFynZZgl7yYqFuXS
         tedKYpF/FsnCOxdANK+z937NxwLRtm3N3/gmrkn609lms0QOkJtxwPucmYBtU3n/+g5z
         AXNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=t9JqXWPCu1XNJBQSL0sKyN0+mx+VD18e8/FNMTuhuJY=;
        b=C104o9kJR/LuO2lU6RSW649uSrhdppHSfbmRzaLpQSva+ZhKi6U2cPLzweeI3XYG42
         lcQ/RUIL5o9D4UBrzNxJPh1LhuQrB3pGub3wjhfTJIaPu/gn226nhi49dw1v2+AlgNlv
         yXViRGbl3zWNiQ9SOgIyzpxzKYooLkJX5f2XLjxqWwsYZdsJaDEFxjbgh9Vrh1EGpJ41
         udkMcxsmB9tvSulz9u3s+jWfxrj3f+pYsqT9GBxbt+9zBnxbh3oQrPYFkLYqcSDcTP7f
         dtrYKnl6AWUTKqoOltbHV/ngsBrQkzPnPOBvD1sZeLMopBoocMYkjfZ4JS5kzCJ2BPlE
         TyFg==
X-Gm-Message-State: AOAM53114J/kIQdsHy/gnaJiLNW3FOeNCorgNWPanBYUDVGaKnRO3Tqo
        /jVL+1arWkJC9pf+ebUs7CmR0aXjsjuF9MKuG3tHQgvQgpRNwg==
X-Google-Smtp-Source: ABdhPJzxmFf8/4KzQq7jO4jBR04fMXyw6k+9MG7C+yKowq/sUoe8e8quaDKLjvzU0WsYtvp4H3pzM95d+qX9K89EzYw=
X-Received: by 2002:ab0:7216:: with SMTP id u22mr3930372uao.83.1619112482384;
 Thu, 22 Apr 2021 10:28:02 -0700 (PDT)
MIME-Version: 1.0
References: <pull.847.v6.git.git.1618255552.gitgitgadget@gmail.com>
 <pull.847.v7.git.git.1618832276.gitgitgadget@gmail.com> <9ae5ddff6aed48184d2a10c569e41441b9199f10.1618832277.git.gitgitgadget@gmail.com>
 <xmqqsg3k68vv.fsf@gitster.g>
In-Reply-To: <xmqqsg3k68vv.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Thu, 22 Apr 2021 19:27:51 +0200
Message-ID: <CAFQ2z_PTF=5wLKXmqzFkPiC3RTy-RtzCAtBHUSWekkgaKJekkw@mail.gmail.com>
Subject: Re: [PATCH v7 03/28] refs/debug: trace into reflog expiry too
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 20, 2021 at 9:42 PM Junio C Hamano <gitster@pobox.com> wrote:
> Nicely done.
>
> I as a reader of this patch do have to wonder, with the above very
> limited log message material, how useful did "debug_reflog_expire()"
> machinery used to be without any tracing.

It wasn't; that's why I'm changing it :-)

I noticed a test failure with reftable, and adding this function
showed me I was expiring the entries in the reverse order, so that

  git reflog delete branch@{1}

would remove one but oldest entry in the reflog.

> Not a problem with this patch at all, and certainly it does not have
> to be part of this series, but it feels very backwards, at least to
> me, to have the method should_prune in ref backends.  As a function
> to make a policy decision (e.g. "this has a timestamp older than X,
> so needs to be pruned", "the author of this change I do not like, so
> let's prune it ;-)"), it is more natural to have it as independent
> as possible from the individual backends, no?

the should_prune function is passed in into the ref backend as an
argument of type reflog_expiry_should_prune_fn to the
refs_reflog_expire() function.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado

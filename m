Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B440C2BB40
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 18:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0595122EBF
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 18:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbgLESnW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Dec 2020 13:43:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbgLEQy1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Dec 2020 11:54:27 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFA9C061A54
        for <git@vger.kernel.org>; Sat,  5 Dec 2020 04:07:20 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id a16so12633530ejj.5
        for <git@vger.kernel.org>; Sat, 05 Dec 2020 04:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oCRzzIPSnmfC9rMFovWRjNOH/Zu8Hq6y2ivDPGnAzhA=;
        b=uYs9IP5jy5pkKY5mEDtumlo9xsHnjIey/25wA/+N2OfA2BPp9kCS02wUlRVrU2bnJs
         9ip+qmAFVVCsNTOXt+yHrmRAwQ91QvlEwA7TAXDA1cf0mq9lpmntdqdWhrqgNo0jrQ3c
         xYE3xNzbdCGeEqQEKUmP0I7eiA4mVpV0zQkMT+0zUagP18iIVyZSgYkKT+oy2pdrE/S2
         I2BNSBlPL8dR2Ku8O39NyM2q5J/lmnjbIi/7hdkMUFGCV3wwt54MoxjOOuRVmveCQuNv
         RJjxn3JQi6xtXfxGojlBQyY8kKeqBebVfxV3uWXru2r+rpFMP6qgdt3hGs8qcDEhkHHN
         mxgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oCRzzIPSnmfC9rMFovWRjNOH/Zu8Hq6y2ivDPGnAzhA=;
        b=A7DZLTdQsF1yI70XahWnNiYGfCe/szXxY/1m7rGY/4beEgq4LGzIE4LtK/EnO1NXHB
         Ey6O//y1hoQJoZ/fikNxqTyw2jE9n5j62MpPo0JiHJlatPQ6eEn06UiqzfwGGHX2NnDe
         +rTP+cOPxwjIzDvqGRujwR44Qrj2iw29yEATghywoRKXtlv2QgSPSEV2sZZwhEw+GSLW
         eIQAR/ZmJFNpK8y4CCcGOKuTTxqOx8I6aYKuwQWPaqF3kMpeLXpHIY65JCg1rl0yHa5G
         WACkcbOoBzoxiKMuwxgDEGyz7RgQtJAVDTVEkw8VPi30ujlSeoHCC6q58G62q012LH5Y
         GaxQ==
X-Gm-Message-State: AOAM533sSPpZOdTOezmNVPCMwq1KS8/k6tjhg0J7DsMoF+mZaGPq/lTh
        N0X4oryfkPsEjPvTgObm/vu7wT8iDVqyq4eQPdo=
X-Google-Smtp-Source: ABdhPJz8glgxk9XsuQjhuCww5bTMQ1Ajhyb1N2jkIl85OkstWiyetYU/0jrVhMxF7RaEQwfKPEphqOaDoQucWiRdgPM=
X-Received: by 2002:a17:906:9a07:: with SMTP id ai7mr11358550ejc.216.1607170038945;
 Sat, 05 Dec 2020 04:07:18 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604521275.git.matheus.bernardino@usp.br> <aa1eb461f46d200f36b33c07ebc0a350829ab1f5.1604521275.git.matheus.bernardino@usp.br>
In-Reply-To: <aa1eb461f46d200f36b33c07ebc0a350829ab1f5.1604521275.git.matheus.bernardino@usp.br>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 5 Dec 2020 13:07:07 +0100
Message-ID: <CAP8UFD30JOhFxxSU=bVY9YfSHAjVJAKabLEv4x28JotOdj8xRA@mail.gmail.com>
Subject: Re: [PATCH v4 04/19] convert: add conv_attrs classification
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 4, 2020 at 9:33 PM Matheus Tavares
<matheus.bernardino@usp.br> wrote:
>
> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Create `enum conv_attrs_classification` to express the different ways
> that attributes are handled for a blob during checkout.

Micronit: the subject of the patch might want to be a bit more
explicit like "convert: add conv_attrs_classification enum". Otherwise
it could make one wonder if it is missing an underscore between
"conv_attrs" and "classification".

> This will be used in a later commit when deciding whether to add a file
> to the parallel or delayed queue during checkout. For now, we can also
> use it in get_stream_filter_ca() to simplify the function (as the
> classifying logic is the same).
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> [matheus.bernardino: use classification in get_stream_filter_ca()]

Maybe "Co-authored-by: Matheus Tavares <matheus.bernardino@usp.br>" instead?

> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>

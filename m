Return-Path: <SRS0=xqrk=6B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DF7C2BB1D
	for <git@archiver.kernel.org>; Fri, 17 Apr 2020 22:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D479214AF
	for <git@archiver.kernel.org>; Fri, 17 Apr 2020 22:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PIxn2Iqn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbgDQWNp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Apr 2020 18:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726284AbgDQWNp (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 17 Apr 2020 18:13:45 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B26C061A0C
        for <git@vger.kernel.org>; Fri, 17 Apr 2020 15:13:44 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id s9so2720666eju.1
        for <git@vger.kernel.org>; Fri, 17 Apr 2020 15:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8GZjnFyR0v3DOKhGYv8eFYwmTe+P3tg9BLv5rKhpUOY=;
        b=PIxn2Iqnd1+QY53j+bA/dgB3s3bKktFCwM8Hq3dsvcKOjuE75dfcgsF42xPRBjaLjM
         5oZtJ4AVezlRDqTDKDfr6Gs6f1bhmpC8CgYTv6wM67PahFhp6QjYvRqgveL/tXdAKwMD
         wG0G5c9fNA3+XVCUO2Hww+yTSIponx/5wzb4HcQgqZgYF+b74QxE/qETWj8vpNS6iSDt
         bC4BKOnAcHsjOWKV2FGRY7cx1Gec1qwOpKgMqXjBK/iRaHPEHCUA9hDonQzdJigMhF2c
         x4qt0aTkXT8fB8l5vTlwiCm7Yl2qkujOxxYB5fx8yJ81MBZSkMGCicAxAcyfYDcLX3yh
         KeGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8GZjnFyR0v3DOKhGYv8eFYwmTe+P3tg9BLv5rKhpUOY=;
        b=opUCCUXzwWY3ZyV5osH2XBp6yxqWdXQ42nYGmSgrndPrgmiNSDBgr78zrUWulp0Qwd
         OfdThBZl3Yd7j4xDZhE3iqwN3j8ttopiUBg6WXOjzoQ8x1pHnXgGI3+iQrrovClViwuD
         CCaKgUhEzR7xxigsEGjIRQQj2LqKk+IVy/kW1YlzN3DwtJVzsP8eIwESTImNh42HdIt5
         +Vm+v1UkcONYbPvI/SPGPCTNUvxLx1gBwOK7hwqJGTDQR+X1YS1OwMp0jdV++TIXJN/e
         MyKAp3CbGqenCTMxvsDUTKk/rzs+5QQ7KPHR6t7/NwgmTiMn/XmQQ2zjnNjuiCPJvSkV
         FtNA==
X-Gm-Message-State: AGi0PuZhhMeZXwVCJOFnLKLEla8Rcx+VVtc9lAlD6MB9AUoon9sKNOi7
        DEZ7GvfRjPgLUSzzLbT1cO9utN3+7mT1Dq0nh/s=
X-Google-Smtp-Source: APiQypJlZimh1z8N4rmf46cCjZJ5BX444JE83Jgvj7dL+G6Pbtsg82x5SsAQVXREebJiGGVF3/uyzHbqLzUGO9yYEgE=
X-Received: by 2002:a17:906:258a:: with SMTP id m10mr5361532ejb.255.1587161623563;
 Fri, 17 Apr 2020 15:13:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200416210456.19122-1-shouryashukla.oo@gmail.com> <20200416210456.19122-3-shouryashukla.oo@gmail.com>
In-Reply-To: <20200416210456.19122-3-shouryashukla.oo@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 18 Apr 2020 00:13:32 +0200
Message-ID: <CAP8UFD2c_QtS=KWY8rwqMOu1A-KLVE_3dfiCUopWT-W60gg8eA@mail.gmail.com>
Subject: Re: [PATCH 2/2] submodule: port subcommand 'set-url' from shell to C
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Heba Waly <heba.waly@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 16, 2020 at 11:05 PM Shourya Shukla
<shouryashukla.oo@gmail.com> wrote:

> -       git submodule--helper config submodule."$name".url "$url"
> -       git submodule--helper sync ${GIT_QUIET:+--quiet} "$name"
> +       git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper set-url ${GIT_QUIET:+--quiet} -- "$@"

Maybe I missed something but I see nothing in the C code that does
what the `git submodule--helper sync ...` call does. Maybe for now it
would work better if that call was kept after the the call to `git ...
submodule--helper set-url ...`

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C03C433EF
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 23:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiDVXdK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 19:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbiDVXci (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 19:32:38 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80572203DC9
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 16:13:27 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id w21so3541403uan.3
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 16:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=y9ZY4wR3aeigsgryYXHqWWeB8140K+aTkz7epAX/nUw=;
        b=Qrn4zwASlBGd6PPT6ReRbw2uZc0L8snt/OkQ0RmJMJWoBYnBwO7IStAYr3SvxnMsre
         asAH1Y90JaDf2hvRUKzoricjVScgBfQi1FXSldzdj2xSz0sdKUb6IDNmDjqcTuek5NuE
         Lpy0wytA+Mjjmw3QFvlgc1oW2G4repY0/zYXTM/ExwGaojx3kTFboseiE+jTklol+AoK
         je5EYi91z9eLF610gljWwE1j7Tn2GknoVXTxRFez80jfrtlQ5xkK/AhqM6ggsFfCHSbn
         HCqK7mWWxc/MVPQytevKtJGixdqAwXgo0ralzMvtcaOmrPNePEpb7sJNKFbTxueL9+lf
         OjiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=y9ZY4wR3aeigsgryYXHqWWeB8140K+aTkz7epAX/nUw=;
        b=wtg4QqqzcD1/PLhgnyDmuUGvqPGtBmU8ojynBS3UBYoZrv3XRcZJ6t9E21KUo8P/2o
         73D99VZf/C9xc8iospCtShLfCLXaMqlEJ1m8d8HsDIrU3deHLIkSB6ErBM0oOlztsB+x
         cMEm0upMIgh4/TTCjK/5XFFWc8dMKah8hdxz/+6GGppcRM79Md1hD4EozcPh6bCHbZNP
         kPJhkfmgZVCzREauEFbhRjCxRXBSVL+CAKdYy26rE5umapp+3d0RcBJd664L9YAPUBWR
         zojFBVSFz8GnkW21DwryMWdtnhNujJ1uHXNfeoE50UKA2mKnMT1sHvEskA+VP4LUZRQ1
         kHxg==
X-Gm-Message-State: AOAM531b64+iNdByUUWY5VsxLYESEvJ4V+a8pEF+rcDPbKg1qX8EzSa1
        JBcqU0nvxFIs44H2DGzr/96aa+xN7ukh6ewg6EEseNNEXq8=
X-Google-Smtp-Source: ABdhPJwaJu6lkMwZfffnrKy7lvyrMFqGDb1WxXZXfW/c1F5hEdMmT2UGat3ffS9eRbKgcL8hacEHdtYko61y0WIG/yE=
X-Received: by 2002:ab0:654e:0:b0:360:303f:46c7 with SMTP id
 x14-20020ab0654e000000b00360303f46c7mr2453836uap.6.1650669206539; Fri, 22 Apr
 2022 16:13:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220421225515.6316-1-carenas@gmail.com> <20220422013911.7646-1-carenas@gmail.com>
 <20220422013911.7646-2-carenas@gmail.com> <xmqqo80td5wj.fsf@gitster.g> <xmqq5yn069lq.fsf@gitster.g>
In-Reply-To: <xmqq5yn069lq.fsf@gitster.g>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Fri, 22 Apr 2022 16:13:15 -0700
Message-ID: <CAPUEspjGX4L-4T-93a2729SkB92TP500JYmEbKyrRFbv7moTXw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ci: make failure to find perforce more user friendly
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, sunshine@sunshineco.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 22, 2022 at 3:23 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> So, how about replacing it with something like this?

Agree 100%.

It would theoretically make the issue raised by =C3=86var of not knowing
when perforce was skipped slightly worse
but getting that fixed would seem like something that could be done in
a follow up.

I have to also admit, with all the on the fly changes to these same
files, it might be wiser to wait until later anyway.

Carlo

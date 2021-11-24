Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781E3C433EF
	for <git@archiver.kernel.org>; Wed, 24 Nov 2021 16:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348911AbhKXQen (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Nov 2021 11:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241140AbhKXQem (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Nov 2021 11:34:42 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BDFC061574
        for <git@vger.kernel.org>; Wed, 24 Nov 2021 08:31:32 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id e3so13087716edu.4
        for <git@vger.kernel.org>; Wed, 24 Nov 2021 08:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=LOe1pmHuMoOaFa5BN1LpBQajguiueAtnaEhHknYmhdk=;
        b=iV72nL87JXTletxNvSoT1pPdLp6yKJ72DQ8BJzcSx+j+CwtnGaCnn7bmJVL8Uf262Y
         QVs9WqS71kHxDpT7O7hVE+3OLpoJWcWjrfvYSHq5gNj4cxGK+WV8YdlC7BTp0ukPFHhO
         4f5RkG4oGgJjL1zYzaLOOhdtVRSqTvSWlNfhSe6Rqq77Tq6w2kPNbbUgxc8lwtSUhpsT
         abB5leomude2G3i3J1ffxJ98FAuzgWl4k4hK30/dEIbiaX9WrExo4+OyoNISoLT1VZyn
         aSnfJFkCxG38I6P7Rpxmh9i1eXoKbigL0Wnq7ibQXew0bu0+sSipiXFqzyxz4ISx30s6
         sgOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=LOe1pmHuMoOaFa5BN1LpBQajguiueAtnaEhHknYmhdk=;
        b=7ZF3MjDmpOwqwuhnV34moTiA4rAfxW0Gr9rOAgOsVehXs1x2BSoBODS5H83Z4KkSxB
         viCK4qEFsfvJT7l8Djcz74nHuJ+wtWxW8cvCfO1C4B6hERXVZ/1rdUDfQ4/1RzDdAFLn
         uYUf+S5PuhDfTesgaxirEq0jKFNFBgugWcyRNQXw13CSwLWT9Ac1UgX2RX+dQFHxCo/N
         x2LbGDxkZAsmsrdxTcJAdcf1Xvw46GxOzcQQETLR2QK7EXGaD4xHnjovf5MN+r8vxz6c
         zUaFs0XqrqHL5Aik9IGqx+j9ni7p39reADdq2V9LLoLWnxheFQPMQLcHyLm4Q4KFqZQ9
         6AAQ==
X-Gm-Message-State: AOAM533m1EZ0Gb6Yy940jHMY8e1o5S6x1QeYGOUB+94GdCiQrFMXZzoa
        aWCK/ULhtDE4eKNHAtVVsHtxVKgan+lhtAj6Wc0KzKdM
X-Google-Smtp-Source: ABdhPJyE3kr4uEEbKx07o2zSoTDKpS32dvlgWLqqfU1W+DjEDxPTQ8bQExwhrDmVYYfi8JZ/dZX4tej9aY6s3/fHDUc=
X-Received: by 2002:a05:6402:60c:: with SMTP id n12mr27221511edv.17.1637771490779;
 Wed, 24 Nov 2021 08:31:30 -0800 (PST)
MIME-Version: 1.0
From:   Martin von Zweigbergk <martinvonz@gmail.com>
Date:   Wed, 24 Nov 2021 08:31:19 -0800
Message-ID: <CANiSa6iNpm6--qHpUFYhPfSi+ounGttA8=TAsep18A-=iyoFEQ@mail.gmail.com>
Subject: Letting tools partially resolve conflicts in a file
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I've searched the list and not found anything about this topic, but I
figured I'd ask to be sure. The question is not specific to Git, but
this seems like a forum where it might have been brought up.

You could imagine having a merge tool that was specialized for some
purpose and only able to resolve a particular kind of conflict. An
example would be a tool that resolves conflicts in `#include` lines or
`import` lines. It could be useful to have such tools run as part of a
chain of merge tools, where the final merge tool is what users
normally have configured (such as `meld`, or the internal "attempt
merge, or leave conflict markers" tool).

Has this problem come up before?

Thanks

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E723AE748ED
	for <git@archiver.kernel.org>; Sun,  1 Oct 2023 15:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235152AbjJAPcU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Oct 2023 11:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbjJAPcT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2023 11:32:19 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BA2A4
        for <git@vger.kernel.org>; Sun,  1 Oct 2023 08:32:15 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-533edb5ac54so15996498a12.0
        for <git@vger.kernel.org>; Sun, 01 Oct 2023 08:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696174334; x=1696779134; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dlugHaKRDiE/fxePToVheWm1MbHnu50fQ3YATEYh6Hk=;
        b=S1EhbYBZK/Vapk+qLw/oMbEGLoWT4M7GDGgV97Iu5l8ec7pVtQx8wiWsK/cI3GVMhm
         AdQxkaITG9tX0+KHToQnc4cCD2PUT1bb2PvTCAz+nCLeKI8fAI0GZmBu9RW3MzJOC50B
         4dR7EM/8he8aua0wQHwj8JFEpjXEC0njwfAvi1JinCjK460/OPvnEQwRVAlN+lAEQeMp
         nBcpWK6MCEHJOPFKStSJB3WEmRXJ3JHKdpLpatTDAbBrA5fhYdmX/+JM5OGC5vjBymNo
         bz9qbhWCgZgeW2a8+7yuYVC6rN2VOhHK5mmhQU4yO/MouCkB+Tgq8rjNVOBAiUbcsCaJ
         gm+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696174334; x=1696779134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dlugHaKRDiE/fxePToVheWm1MbHnu50fQ3YATEYh6Hk=;
        b=oDYJw7E5ZD7I/CxEAiVdE+hdjseSuaQ/Buc9nCWzaYN9F6cDis5hH/vu4qNqrDEzC6
         A+7b5xKCFf0q+isG6c2pqCXINLrhNkpyrQY0IyM3/abAaZ7brOr4DI/Vx8D25RXh1VEL
         iNJHFtSCFpOXYfFGVaXhWMeY1yISYU+ihHOjMADNtoJyQV/nt14xR3If6Eo5+n06d6Ny
         44OMo4LzILl+oSszYgRgVeco/z5Ql3DQKaXys6FfYZzyf4a4zpR69bFsObZy5N3gJMid
         daG+xLqUnTbRa1EmdRCoZRuENtl+clH7bk4g5VRBx9x926ZPIDlDWUs+/AKzDgDxmcjH
         bncg==
X-Gm-Message-State: AOJu0YwQv8JBVUof6w1okpDBF1krabJvoTPKjzrzih9kKaTh2pmn4m67
        DI5jqSqr7ba8a2CuXyYFYEAXey7tWnfULBxSxcgBxuVA702L6w==
X-Google-Smtp-Source: AGHT+IFTLHTwUq2Gdz8osSAe9/Ou93r2lJqzgZSv2WSSZjmrjVyCp/VCDC/QEZh2RXTD69emlQuxDDnFTr/pWbiery8=
X-Received: by 2002:aa7:d910:0:b0:530:bea1:9e9c with SMTP id
 a16-20020aa7d910000000b00530bea19e9cmr6498280edr.41.1696174333530; Sun, 01
 Oct 2023 08:32:13 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 1 Oct 2023 17:32:01 +0200
Message-ID: <CAP8UFD2gCExE9J5wHnqr0yW5sayZ9ckvXo3KO76oCA+Peas27Q@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 103
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ronan Pigott <ronan@rjp.ie>, Adam Johnson <me@adamj.eu>,
        Bruno Brito <bruno@git-tower.com>,
        M Hickford <mirth.hickford@gmail.com>,
        =?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>,
        lwn@lwn.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 103rd edition of Git Rev News is now published:

  https://git.github.io/rev_news/2023/09/30/edition-103/

Thanks a lot to Adam Johnson, Bruno Brito, Mirth Hickford and =C5=A0t=C4=9B=
p=C3=A1n
N=C4=9Bmec who helped this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:

  https://github.com/git/git.github.io/issues/666

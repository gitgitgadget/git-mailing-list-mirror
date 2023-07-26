Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A882DEB64DD
	for <git@archiver.kernel.org>; Wed, 26 Jul 2023 02:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjGZCbu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jul 2023 22:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjGZCbt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2023 22:31:49 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6048A268E
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 19:31:47 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1b8a7734734so34312795ad.2
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 19:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690338707; x=1690943507;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VYmsP8+ezTgX5x2y9fj+V3jV9AUscnEboFO6MIsJe7Q=;
        b=0boRYlcjlCnW7hulJCuJwbAxO2dby8mq9Uk81qMLUfCrNTD6T3W2N44pH4Cc9Pls2n
         iw0GJ23GKs2edC5Ybri9AsHJibMqEGI6LcahR8HqCAJbKJs187zQfk7Z1IACLZVwK0yS
         5VRUCVcAIcl/r9HoVDCH/sizg2fcMexhuy1tsvtY15mgVPUbBksQD+KLe4ZKaTabhtsM
         HkgOTxY3kjDR23feJ2yGkJ4+odQVmGmDYGUG6+9yUhG1xLN7f11z6sKXB9Nh41ClHmpn
         k0jkBlb42tQFSi1LH3wv7ZS5Mr9e0njijjurzw3YmlTVPufOc2hYLzsuoLGa5WAsfv5o
         XcKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690338707; x=1690943507;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VYmsP8+ezTgX5x2y9fj+V3jV9AUscnEboFO6MIsJe7Q=;
        b=cD/os5XE+5DMVhzxo19fLwmtSyHXFdMhKFTdYkGjWwYTKtosvKCgDpziHZclOmZeGW
         F9jluyJzuv+xjY4U7dy40ZVrK6EVyyyDMYCyldNdzRaHUOmgd1SEu4KjbbWjcknhTP4C
         YbQZIHXLmfDKDalQOIqQAbO39G2+WTG0zDKWQ0I7KNF7zEc1FPJonaYnPlmiZB2ekuoK
         obth7WkQ5BFEkp1bRkr5uxTehzU3yW7+9vjhiWnKViTptnvnKl6uovMWun9uwd8WOnOL
         oXBAbXKBLUSCg82trLWq8z4rJfww0wiIwYB+efZw45DuycKpm/dxqZMS39uy6/GmA5tj
         8DJQ==
X-Gm-Message-State: ABy/qLaie3ud6Y9Jde3NiHQ4sEyxnFaPrybkzH8evBNj9+HLadX4Omlx
        +roLCAAoUIuwaeCRZ9I/7Kz46zfB0B0=
X-Google-Smtp-Source: APBJJlEqqVctkqKQ2sD0o4z6/NZMm+zZlpj+7KtaKcVZi1Ez6hBDrXlGvi831fXAEJTWV4ZO8z39l7/Aqtk=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a17:902:e74d:b0:1b8:5541:9d4d with SMTP id
 p13-20020a170902e74d00b001b855419d4dmr4816plf.6.1690338706943; Tue, 25 Jul
 2023 19:31:46 -0700 (PDT)
Date:   Tue, 25 Jul 2023 19:31:45 -0700
In-Reply-To: <owlyy1j3fo8d.fsf@fine.c.googlers.com>
Mime-Version: 1.0
References: <pull.1556.git.1688778359.gitgitgadget@gmail.com>
 <pull.1556.v2.git.1689314493.gitgitgadget@gmail.com> <5ec91d02b7ae767cc9b2395e1c0fa10e1424c0c5.1689314493.git.gitgitgadget@gmail.com>
 <xmqq5y6mpfhm.fsf@gitster.g> <owlyy1j3fo8d.fsf@fine.c.googlers.com>
Message-ID: <owlytttrflny.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v2 5/5] SubmittingPatches: simplify guidance for choosing
 a starting point
From:   Linus Arver <linusa@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Arver <linusa@google.com> writes:

>>  * An very old but still severe bug in tagged versions would want to
>>    be fixed ideally not on top of 'maint' but on top of the latest
>>    tagged version in the same maintenance track.  E.g. if the commit
>>    X introduced the bug, you may ask "git describe --contains X" the
>>    oldest version the commit appears in, say "v2.30.0-rc2-gXXXXXX".
>>    Then you would run "git checkout -b fix v2.30.9" to start the
>>    branch to fix it.
>
> In this example, are we using v2.30.9 as a starting point, not v2.30.0
> because v2.30.9 is the latest tagged version that is in 'maint'?

Answering my own question, I now see that there are branches named
`maint-2.30`, `maint-2.31`, etc. And `2.30.9` is the latest version in
the `maint-2.30` branch.

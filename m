Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F0E7EE14C3
	for <git@archiver.kernel.org>; Sun, 10 Sep 2023 03:20:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233924AbjIJDU4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Sep 2023 23:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjIJDUy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Sep 2023 23:20:54 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5857318F
        for <git@vger.kernel.org>; Sat,  9 Sep 2023 20:20:50 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1c3ae0043f0so693285ad.0
        for <git@vger.kernel.org>; Sat, 09 Sep 2023 20:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694316049; x=1694920849; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GSTjg3X5PNcxiwxPiLpo5zyJItdr/nO05xpfsRihthY=;
        b=cjmgpaf/593L36HxaiEvD27JSMW3l9Qxff2mzZH1hbg7HRua1EGlp6y1vYjsMigMQW
         7UPD3JKV0Wg8zO8FjcvVd1wmBpWVqiZedwanE8YV3BMsBnvWE/aV6ZALXFK21oX8t84v
         fm5S8wZXbnFKZOgJNBAlulxmJ8vrUWVF6/8rBx1yL2JmwDVG3UnqOcdP84GMN4Y+UCLW
         /HEJmv5NXrLlUqyBYzTlobhPeJJXO01oGdyJUQjaCt82SeIMkFnQnKyYiofbtkxSNT3I
         azFo8D8K9zVmqhCWKkMkptD035LfgGU5WznP5xS0QdM3LvMolBO0EaVOgT9OKAfkgoYE
         4A9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694316049; x=1694920849;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GSTjg3X5PNcxiwxPiLpo5zyJItdr/nO05xpfsRihthY=;
        b=DVNjB4c5gddle32DX96TUHwW0yLO/eCfJ6I9oRBEWJty06/h79OwAZirEeO85Fyigb
         4csFGbnxwKJcg5qAHTBHGjHKdWdaTL4GO8Lr+7kcqi+G8bHNeaX7FM1bQ6UcjU1tj4OW
         FRxZoSa68wE63GRpndTNvgsbMJxoXkeuCT6N2ULdeiJRU9Vrjhdmh+QhZ0UV3XebVlXD
         7oqFdSXGLlHatIqbo6KaKPjKCHcbl523qhvwVN6tMSMQI+aVmAFIEWCunGMDQ0sE5MTQ
         4Q1C6Alxv5GtQvzyOiL4njmtVmlAhfcJbWI+XUDSGRc5JA3Bh8eXXsUBYXJ9xf4vZAXE
         vD7A==
X-Gm-Message-State: AOJu0YwM5RNaGs+vzMHtsG8/35jRquzhgLBWJYclHkElTgV/FbRn4VgN
        KFRcmcGcS9sCMsBH+hx4zR0st49ooSk=
X-Google-Smtp-Source: AGHT+IFy9rlrCJh8xHkrXN1SY/hzLcF7pY0buHPKF/YENSaP4I5B9kqHvZPom8a3iENofgxdIy4CZT5UoN0=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a17:903:32c2:b0:1c2:2485:ad7 with SMTP id
 i2-20020a17090332c200b001c224850ad7mr2985858plr.4.1694316048883; Sat, 09 Sep
 2023 20:20:48 -0700 (PDT)
Date:   Sat, 09 Sep 2023 20:20:38 -0700
In-Reply-To: <owlyo7icl1g3.fsf@fine.c.googlers.com>
Mime-Version: 1.0
References: <20230602102533.876905-1-christian.couder@gmail.com>
 <20230907092521.733746-1-christian.couder@gmail.com> <20230907092521.733746-12-christian.couder@gmail.com>
 <owlyo7icl1g3.fsf@fine.c.googlers.com>
Message-ID: <owlyledelnnd.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v4 11/15] replay: use standard revision ranges
From:   Linus Arver <linusa@google.com>
To:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Toon Claes <toon@iotcl.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Arver <linusa@google.com> writes:

>> +update refs/heads/branch1 ${NEW_branch1_HASH} ${OLD_branch1_HASH}
>> +update refs/heads/branch2 ${NEW_branch2_HASH} ${OLD_branch2_HASH}
>> +update refs/heads/branch3 ${NEW_branch3_HASH} ${OLD_branch3_HASH}
>> +------------
>> +
>> +This will simultaneously rebase branch1, branch2, and branch3 -- all
>> +commits they have since base, playing them on top of origin/main.
>
> How about
>
>     This will rebase the commits in `branch1`, `branch2`, and `branch3`
>     (excluding those in `base`), preplaying them on top of `origin/main`.

Oops, I meant "replaying" not "preplaying". But also, perhaps the
following is simpler?

    This will replay the commits in `branch1`, `branch2`, and `branch3`
    (excluding those in `base`), on top of `origin/main`.

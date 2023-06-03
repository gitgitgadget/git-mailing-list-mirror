Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8E2C77B7A
	for <git@archiver.kernel.org>; Sat,  3 Jun 2023 08:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234821AbjFCITA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Jun 2023 04:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234621AbjFCIS6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Jun 2023 04:18:58 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A82E52
        for <git@vger.kernel.org>; Sat,  3 Jun 2023 01:18:55 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-514953b3aa6so3965794a12.1
        for <git@vger.kernel.org>; Sat, 03 Jun 2023 01:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=coup.net.nz; s=google; t=1685780334; x=1688372334;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4mFLHwgCcEXx5HZ2OxV3LZf4rXxbHz4KK1xJHIyud7Q=;
        b=X8F7/w198bo+fl/zDhl4Y1cxbfWwfEVHI0h+okxkFLbIyAgiYflSCUESn/vrVrG0xv
         4pXelwsFkJfm2W8UdgWxB1ohd2SgPLsYvaRu0kqH6Ol/3V4JQ3ydbHsXqqoCss+0H/eR
         UE2YxwoEYfKyeGRUVVpBJYa4rgbFQIjqLNLcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685780334; x=1688372334;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4mFLHwgCcEXx5HZ2OxV3LZf4rXxbHz4KK1xJHIyud7Q=;
        b=D2WdNn9+oiH3KsdYC+NTqg08c5pq4r55LsGn9tzkAPU/G+rzfMYQG6TSeqehXrN5qS
         P4lVPCILKHge4PY+kWlC8U3ZSXJnpvBt9yAfUkSoTaru2vuQUUU6SAE9fFfAAxwIredH
         7BqUQvR1Qz04vMu9Ar+SzazUMvn+juN7o2XQTgNg2zmL/ZSGiBflfpzJohhRst62k9Jz
         YPCeGq1XQC5FeBBPBYXnaMF9zRzKFc4Q7U1uFlE+lZRlZBcQ7jBJ85Y5I9rrCy6qFp6M
         lYWpXQT6c7D6ky6GrqC9Fou6Bkb3l/ZPASfWRlCQFdkMEZOi2DURpmV8etmqrWRZR/F/
         iQSA==
X-Gm-Message-State: AC+VfDxylhOq8MbuW42PmOTIuLLmWKaj+kJ1qRtHWVFLbgAGQ43yw2tM
        hY7+V/sW9k9C3lvFM43Kjssrf0jxrlFpmsWYAbNKna/WnLeFrbx27fU=
X-Google-Smtp-Source: ACHHUZ6NTf02hkO82kKtrA3ylRs7/KE+hZ9v2uxM9RVZFnT7jgWlaLy3FdtKOaQvNJ8JrNPN10UXceNXeN33yAfZCY4=
X-Received: by 2002:a05:6402:184d:b0:510:d0bc:e130 with SMTP id
 v13-20020a056402184d00b00510d0bce130mr3549638edy.33.1685780334076; Sat, 03
 Jun 2023 01:18:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAPMMpoiJ4cNcAR9gO5d-749N3YW-88p1gMnX8ySGgz84Mr9coA@mail.gmail.com>
In-Reply-To: <CAPMMpoiJ4cNcAR9gO5d-749N3YW-88p1gMnX8ySGgz84Mr9coA@mail.gmail.com>
From:   Robert Coup <robert@coup.net.nz>
Date:   Sat, 3 Jun 2023 09:18:43 +0100
Message-ID: <CACf-nVfUotaTYeCC9XMvnYYNhjX+EW89z7fhUX0Ok9TpsVTRTw@mail.gmail.com>
Subject: Re: "git fetch --refetch" and multiple (separate/orphan) branches
To:     Tao Klerks <tao@klerks.biz>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Tao

On Fri, 2 Jun 2023 at 22:23, Tao Klerks <tao@klerks.biz> wrote:

> What I believe is happening is that *if* there are refs to be updated
> (or new refs, presumably), *then* the objects returned to the client
> are only those required for those refs. If, on the other hand, there
> are no updated refs, then you get what is advertised in the doc: "all
> objects as a fresh clone would [...]".
>
> I've tested a couple of different scenarios and the behavior seems
> consistent with this explanation.

Do you have a repo & steps that could reproduce this easily? Otherwise
I can try and work up something.

> Is this a bug, or expected behavior that should be noted in the doc,
> or do we consider the multiple-independent-branches usecase to be
> edge-casey enough to be an easter egg for people like me?

At first glance it appears to be a bug.

Thanks,

Rob :)

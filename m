Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C34C433F5
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 13:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237517AbhLPN31 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 08:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbhLPN31 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 08:29:27 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308D7C061574
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 05:29:27 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id b187so35098931iof.11
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 05:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=CzsqyZk6i9pKarSUUY7i7j6QoIUjctSWCUPrkaQ1Mws=;
        b=k74xDPzdj9gOmNAewSpRVbY3TYrslfNFqdH0EBi8rKkskXIqncMonaY+yllQil5VUR
         6ImdnjwXXbQZ/MQwbk610EEpR1ka7yILo44bNOPrvcfTSdv0wx3CNobuBQpCAN5XyHhj
         eT5oxUdEx/UKMCOLSHkAvdkb16v23kXV8bgq/GQuADiOyKEt3JkONGTbgTLtIM9gIdBH
         Fxurq/d8ZmYorfS/4GcTi+oJdhmUhHB1arYKKRR4z3Zs+8qa0URj/KUaScrhNVOc14Zg
         EpFbBUKVcGpXjZGRtAC96O3zMweMw1lavcnSpGrQU+uDsJ0//xl6DAe05j+zilfbRv0f
         ZPnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=CzsqyZk6i9pKarSUUY7i7j6QoIUjctSWCUPrkaQ1Mws=;
        b=A8j+8Qobj+AS/iD4DvktQiJpMTLYdmfiyMmNFVtmh+pkM8J5VWfEfn7IDORalfaXe5
         SKilUKbzzouVESZpijaM+fEXshzx1dkxyuy0AkI+pt3lW9ofkq2b0W6N+d1HtjARscOp
         0ZJK+P8o5tVwbQC53n2O6OWNUM4BOn/dUpDd4psOioKHxWvWdouCMp1KbGQj/rnl7oTx
         S2fxnbZ/gJ4r9zBKSsJ1Qdw+qbenWsqHRBts1by93X43L5rNktxTPQ3clOkwpOatGdaH
         iDj/nUmqeqI/wYe++SkrQ0wy10VZef1XNU6OvHr7GIH76+IW26XndGg7v3EiBtqcC5EH
         FtQA==
X-Gm-Message-State: AOAM533W0OTXrDD+bmX8zN2keusPmgXtndqkj8OLgtT1/vv4am57UtIz
        NlmSk/gXqnGWWfUXHakTQu7OA65/UBNAgjzDzWWXe/0iT3gMjQ==
X-Google-Smtp-Source: ABdhPJzNqTNYKRSqY+1+nuntdm1WJLwDOIcr3FjlzWjXQ7aARjRpqrRM395inMuGONQ+PGlHI7hQneJubJBLBqF6A8E=
X-Received: by 2002:a05:6638:4101:: with SMTP id ay1mr9506485jab.235.1639661366505;
 Thu, 16 Dec 2021 05:29:26 -0800 (PST)
MIME-Version: 1.0
From:   Jasdeep Khalsa <jasdeepkhalsa1@gmail.com>
Date:   Thu, 16 Dec 2021 13:29:15 +0000
Message-ID: <CALtRjJ3bu1ub=407kt-aemfV6BU8CfPZJxLRG5WgTZBYWbaXCQ@mail.gmail.com>
Subject: Adding new/create & del/delete aliases into git
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi there Git Community!

I've been using the following aliases for a long time:

del or delete = branch -D
new or create = checkout -b

And I feel these are good candidates as an addition into the core git
API as they provide an easy way for new starters to understand the
creating and deleting of branches - which is arguably one of the most
common git operations.

In comparison, passing in flags for this purpose for new starters to
git, is both hard to remember and not easy or obvious to understand
what is going on.

From my understanding, these flags were also meant as a shortcut to do
a git branch && git checkout in one operation - effectively being
alias flags anyway.

So I wanted to reach out to find out what appetite there may be out
there to add/change these to be simpler for new starters to git :)

Thanks for considering my proposal and happy to discuss any thoughts!

Jasdeep

https://github.com/jasdeepkhalsa

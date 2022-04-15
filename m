Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987B0C433F5
	for <git@archiver.kernel.org>; Fri, 15 Apr 2022 10:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241048AbiDOKYn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 06:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbiDOKYl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 06:24:41 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD41BB939
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 03:22:12 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id z16so7010684pfh.3
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 03:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=fe4FH4/Ag0MQCaasEXtFS6YNtVqjWJDMA9dnJQt2lVE=;
        b=ckjoNYanfJ3jxnFg9qTXepS1gotXsvcPBlFvKFa1OQeOaz5FD9tHtsLpmG8ZiH7O1y
         3jNq3TT1mAszVcLhd2YcmkhYxH1VcPCW/yHwagjR5CW11cl12xa9uSx3Iwmvk19QS30c
         Dv0HYuXxeIuWBFWD/r/RpsaWpSw2XYFS+3q3GURkAlFUUNGgOG7fg6NAZLpp1GwoiaXC
         HeS0IBWQAAaDLeF33p5PKb4PgmUqn/CHEIfdbHCmbsYfqdJWEtEfm4P2TWC6ceK9qmTm
         4A4YY9Vo0RbdK0z2qwCdeI/WDwCQVAqfln29E9PRfSsjFc24C+Z1DUB77py5bGVgwwB8
         wT8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=fe4FH4/Ag0MQCaasEXtFS6YNtVqjWJDMA9dnJQt2lVE=;
        b=fRlLYZ+6I8SDIGYgkrFJ0L89M1vH5WW8HEkHFZ46TYK8kr8BM6gAZiykRuzywbq9i8
         xYBJkIr1Ty5iHwiCXSn4w3QkXQBMsEPuk7ajooweeJ82MWOZhIgbqykyb0c1QxcpDbBC
         pk+aAzKJEEJOEmSGD+ksp1Ee2kjre+dj6Fve6Ovlad4jGIzyvNHSaMfm9q6Gzi3cWg2w
         7IydtwJroLvs3uPPrEccHKc3SCJF7jC5D3/bwBsoG4/ENZSjhACoDGg5c7Xh9Xp1tsYt
         juBwso3Ra+hOo2OoyePxCwURGpkvpmAwGgrU+WVY7W3me0ldfQ0LhEGUThhxZLa8PdHz
         O8hw==
X-Gm-Message-State: AOAM531akgZGe9QuLhRxF2+zSZr9mKzTgF4g2iO9ebfDM3Y+4VQNqV0q
        VWagAG1di2MGb71D0BefpzOLp1eZhU3wRL1KGMBv4+oQJzU=
X-Google-Smtp-Source: ABdhPJyjeD2qgqJy6HVP7Wx3NvXPvOvHlErsR74TAZBEfGPvk7VHfZ5LKZUP7+LyTDLpFR8WO5TNKqdvyRaQ8dtnpMc=
X-Received: by 2002:aa7:8888:0:b0:505:a3e1:d246 with SMTP id
 z8-20020aa78888000000b00505a3e1d246mr8220187pfe.76.1650018131861; Fri, 15 Apr
 2022 03:22:11 -0700 (PDT)
MIME-Version: 1.0
From:   Danny Lin <danny0838@gmail.com>
Date:   Fri, 15 Apr 2022 18:21:54 +0800
Message-ID: <CAMbsUu7fqECH1b7-POot0mD4kwmT0pzAMJrXznSPgv9wfv1OwA@mail.gmail.com>
Subject: Arguments for git update-index --refresh
To:     git develop <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

According to the manual of git-update-index
(https://git-scm.com/docs/git-update-index), --ignore-submodules must
be passed before --refresh to take effect. However, a real test shows
that -q and --ignore-missing also don't take effect when passed after
--refresh. I wonder if --refresh must be passed after all other
arguments, and the documentation may need a revision. I also wonder
what is the reason that --refresh must be passed after, and can't we
make it more flexible?

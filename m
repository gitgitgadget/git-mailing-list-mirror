Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D97DC433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 10:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E798C6113E
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 10:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235632AbhIHKkc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 06:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbhIHKkb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 06:40:31 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FFAC061575
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 03:39:23 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id n27so3196779eja.5
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 03:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=HIAzTxUHDU9DkTr256RZCyYdcTjw7SSmOfCfoL56XIM=;
        b=faunvuxObbpYVNibtK9wRfJvQmPHfXgc6uRvmzm1iO5N7Q3B450iCPkCOIqrlEKiT5
         pyiCMLVryhVpWXpTy65q0FY9LoGFYsVGC3jtTf0SKUZmVGgNI71+KuiwtLpodAWlw6jA
         5tVI5nSIKiLwNnZE2pW58zpEO1J3dfcix1J7UZmUajqqgwsussqiEdVlvpeLEAh7k++j
         rh4e10XYTQYRd2MHeVkqjVIN17K/TH+alPP8L3zx3ouXefAs7u+f5aSSg0S1HxNGw97y
         BU39UbVasqOan8SMwCF0ZxT415edM7k67DL7fKnZEVEgM4IqhFz26nJVIsVxNtib/yf7
         xgpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=HIAzTxUHDU9DkTr256RZCyYdcTjw7SSmOfCfoL56XIM=;
        b=AzpskZO9ufyKxsLIki4Jk6TR8paZ6AvVW8p/hfKHXXf1Z9FlQlsdst3hmNX5a7SdH0
         9OG4gvzTZMQKpZ+sPb0eY4UeVCRAj2VvDOUaE3TAtq1gNRl61K3Ebu7Mvo/qnDAWtw+Y
         hMTl8oBZlCkc058K1dWuIpMa7za1Zs+fP/Y6tywzCh0U+GwjqU1uwBNIhADrrsB9aA6W
         MJmt+O/k+D6CkshmFteJ276lRVdZwG0+Mx2DtGl/JAqqqV5mi1v6deZDWNNK4WZUPaHM
         Oq3D3IXfPjXDiucrqm29FDQtEu8c8hO7ijR+97VCWhawzHdmuR6kUQ9bZ6nv7iGo4LdT
         iPvw==
X-Gm-Message-State: AOAM531TbM1/7CplqeVMbQVlJ63sGstiaSLXCVZ78sVItgRtLK+78qDF
        rXQbFsXzSYPKPH56HN+LIZQ7XDVFP+m7Ng==
X-Google-Smtp-Source: ABdhPJzyC+yRtifnWG49TbxYy2aKWIn0sOjuDlIyVnSlBEMTea1zNSYv8MK9yVTqD1x+75H/F9EYsg==
X-Received: by 2002:a17:906:7714:: with SMTP id q20mr3350370ejm.551.1631097562157;
        Wed, 08 Sep 2021 03:39:22 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id e7sm1044817edk.3.2021.09.08.03.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 03:39:21 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 02/11] t3407: use test_commit
Date:   Wed, 08 Sep 2021 12:39:01 +0200
References: <pull.1033.git.1631094563.gitgitgadget@gmail.com>
 <79b6dec910ecc9ceb61d03e3bbd9919ce457d78e.1631094563.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <79b6dec910ecc9ceb61d03e3bbd9919ce457d78e.1631094563.git.gitgitgadget@gmail.com>
Message-ID: <87mtonic6e.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 08 2021, Phillip Wood via GitGitGadget wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Simplify the setup by using test_commit. Note that this replaces the
> branch "pre-rebase" with a tag of the same name. "pre-rebase" is only
> used as a fixed reference point so it makes sense to use a tag rather
> than a branch.

FWIW you could use --no-tag to test_commit to keep the behavior, but
changing it here seems fine.

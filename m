Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3279FC11F65
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 17:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AE586146E
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 17:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbhF3RDI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Jun 2021 13:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhF3RDH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jun 2021 13:03:07 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3FCC061756
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 10:00:37 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id p22so6105161yba.7
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 10:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=nOUSsidm3nKnNZO2pFUdln0IRxO7xiTvCnAuAHdMY6Q=;
        b=ih3p6HA168WKfW56l7s1fuMizgyD6UrZ3dFEq7U3kcjPeXuZ+gFfhyTdsAMaE9lPsj
         5lEIKBCJPLk4fZiltsqaLqVtWUNEV5C8iSxPrxIiHtdhJQp/lcC9DdJp2VbkEncdYUyI
         w9tqB0RItDgLXvd9Nryl/l7JNbK0heIalFk4paM6htxdIvqJBoqcNTtCET+joBVXYOdJ
         sEmos6+megNuqCOWgVY8O1L1I0iWkzTjKW/3avVYBEtcTAWTkiaJS7bTRaY6hBQ61rqn
         BPRUoHu9F8ka5xRIXMA/XRf6cxEFXh24ZQ/PsENRKICi5EruQInKerIBaNHIOdy71Lg8
         vNvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=nOUSsidm3nKnNZO2pFUdln0IRxO7xiTvCnAuAHdMY6Q=;
        b=Tw1d79EGOta8gy3rHLPc9TGlKwfo7vKRvikDIH/R9q2biYUkIz3v5YL5Dm/fq36Mzq
         Jxi56bWPxKvG7BCfSMsMQ0oAQeXH8aoAMKFDoRCtY54IUmZdXbwMmw7PYFtTYCpGJLWe
         vDzNFSFdF0+CdAv+E00euNiu0/sRshcHZqYzEtuSaLEjAJRinf2rEprqllatbk1nNXML
         RyBNQn7zN3/p3oteRos0hTlbbbkvdFDBGG9Lt6gPH7U78daW0xRuDYW1FABMvrAMAUY0
         8/JHpCsiB2MC3PfVKxu+PaXXN2y9amzd6sFD6qs3bpz5EyK0I15XtAnWfHVFZojmt+J1
         +tHg==
X-Gm-Message-State: AOAM5339QvlqwWmh2ISHrx+cXCe8lG+NtvDmjL2Rn/3T3gwAShS/j3rb
        kuLOnQqEID1W7wv3k884L+VsBCuQFQuzYB72HBDRkqlofc6jtw==
X-Google-Smtp-Source: ABdhPJzZMQaxphovc+blelbrZLWnlyeKOgUVbD6K6Og7JrCJ+tY3MxMjXNFRHJPA4e+3wo5+JAHdOY45wEuYAcJm3kY=
X-Received: by 2002:a25:7a82:: with SMTP id v124mr22903896ybc.413.1625072435365;
 Wed, 30 Jun 2021 10:00:35 -0700 (PDT)
MIME-Version: 1.0
References: <CACPiFC++fG-WL8uvTkiydf3wD8TY6dStVpuLcKA9cX_EnwoHGA@mail.gmail.com>
In-Reply-To: <CACPiFC++fG-WL8uvTkiydf3wD8TY6dStVpuLcKA9cX_EnwoHGA@mail.gmail.com>
From:   Martin Langhoff <martin.langhoff@gmail.com>
Date:   Wed, 30 Jun 2021 13:00:24 -0400
Message-ID: <CACPiFCLzsiUjx-vm-dcd=0E8HezMWkErPyS==OQ7OhaXqR6CUA@mail.gmail.com>
Subject: Structured (ie: json) output for query commands?
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Git Gang,

I'm used to automating git by parsing stuff in Unix shell style. But
the golden days that gave us Perl are well behind us.

Before I write (unreliable, leaky, likely buggy) text parsing bits one
more time, has git grown formatted output? I'm aware of fmt and
friends, I'm thinking of something that handles escaping, nested data
structures, etc.

Something like "git shortlog --json".

Have there been discussions? Patches? (I don't spot anything in what's cooking).


m
-- 
 martin.langhoff@gmail.com
 - ask interesting questions  ~  http://linkedin.com/in/martinlanghoff
 - don't be distracted        ~  http://github.com/martin-langhoff
   by shiny stuff

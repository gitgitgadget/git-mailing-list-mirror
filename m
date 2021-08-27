Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_40,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2114BC432BE
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 11:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAE0860EAF
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 11:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245050AbhH0L5F (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 07:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244780AbhH0L5F (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 07:57:05 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56041C061757
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 04:56:16 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id a13so8090421iol.5
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 04:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=fKDxdx95Ww9D4GvrUE6cu7U8hkJU6pHmHXw0Wr9My8o=;
        b=SuLR8hQRklV0NhCVoYUciDySn/IcpTLOpB8VomRiQvckTV2k5i5PfLRlEDB5A3bZRl
         aiKI5ukqkd8Cfamv1UWxD67uokMKqP7mRTFifYDbtGP3CDKrRtXLUD48yTUvf5bhoVTP
         2faBVHqHm/3dvbN9gj6Y2Fea79ZkPQQx3XW7objpuAjOHMji1aFFrN42uBTMWTpVEuZJ
         A85zJzIp2vInigypnEvYUdqEH2s0wLD8acAftnFJzBuYXRpmZ1MARJ/X9c+T22r8UWrK
         iAS4Suy8oBHn6H5oNaVFByY+jYijgLBKI/hd/jl3cRpSGBEyLm41q+/AUttcDw5YUAt4
         lB0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=fKDxdx95Ww9D4GvrUE6cu7U8hkJU6pHmHXw0Wr9My8o=;
        b=TzyZJWYiYedNqNE07sb/3bkyNUvSz9TAkXlEHBMmX4E42Iq1ilb6msn0zkg2+EMqv5
         3v2cqpI3S+NeyjOTgb8vf4zNllw50SKZ0c/S+bH9i/MrHAMSX8REXw2yYU6wspebCPu1
         r/x0a06cqwf06nUDPWvnQn4rystX3iMiF6RFKx1FPeA3hrN/pCXODF1fonLvKC1FEnf/
         /65gRuBinNDnlR7XrGzTJ/TnrQBwRDeVBsbOLAU0TfmuYFQjBMuY/SUngON9vMmb028Y
         5uXrXY7N7hHp5BeUtgFbZOVSAA29RKX5/9bGygjJ0Gjn5h4HZ2KLkvImuSdWSiHkz/JB
         H5gQ==
X-Gm-Message-State: AOAM532OFSi3Cw5D/PpLRVp0McMqEUr86EOHzV5gzVVW0CHAxD9sssxN
        TTjuO5t+JKOpvuI1SH9YAWAFjMkhgJm6MRbdWY6IE9Wwf9r0Azjn3jw=
X-Google-Smtp-Source: ABdhPJxvDNM4ETcIQrQFsUk2Wmyxq2byLSU4v96NBQ4bMZVTKLJvVLRDIQGHPnk8bqmrH6Ac7X46hR+82qNVT3mVZlI=
X-Received: by 2002:a05:6602:25da:: with SMTP id d26mr7076094iop.106.1630065375628;
 Fri, 27 Aug 2021 04:56:15 -0700 (PDT)
MIME-Version: 1.0
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Fri, 27 Aug 2021 19:56:04 +0800
Message-ID: <CAOLTT8SvackzHLni_3NBM2Wxi4xBEUV1v-LjD9RhbXikjkr=qg@mail.gmail.com>
Subject: [GSOC] ref-filter code clean
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>, Hariom verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey,
Due to the existence of dummy ref_format in ref-filter will hinder some
subsequent improvements, I hope this patch [1] gets attention, thanks.

--
ZheNing Hu

[1] https://lore.kernel.org/git/pull.1025.git.1629882532.gitgitgadget@gmail.com/

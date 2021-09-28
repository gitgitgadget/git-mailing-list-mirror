Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1553C433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 16:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90C186127A
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 16:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240702AbhI1Qvt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 12:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbhI1Qvs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 12:51:48 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF9BC06161C
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 09:50:09 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id o1-20020a056902110100b005b69483a0b4so11974738ybu.0
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 09:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cbgQcui34gP8Z3Xlxlbn8ZCSE+IVJZH45cbw5gVfXKs=;
        b=YmByCUk/c9QyaQlM/72uLn7koJD2RRTAo2fFfhqmsJeDv3fuV+ANi6muxJssa7u+Lf
         KdvMQiCd9V9eYPYUHNBI73aKD4ErSv6Ip4EaznWus3L0sr1QcGOK5qZ8xZMGL5y5Kxle
         YIIh3e8OC6JNEviymwpsZOqbGNl/rAhl3Hk3Z5dV7RspgmIR+vzyJ+2hxTHs4ovuhTzb
         Tfo3zD16/AzMP5Wmn1N+KL3Nj9V+ZMMNQCqF7UpkNbbnmHiWLpCQ+c4ZMGSwiPh4dDvz
         ULMDKvm6YtwWFx4TGVdtcs/hSONCRX7LwAOndKjcM92DI0C7EadEW1pixTpYqHVdBtjM
         UfHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cbgQcui34gP8Z3Xlxlbn8ZCSE+IVJZH45cbw5gVfXKs=;
        b=4D9HddfcF550p3cKEcCEWVj9/Q8HmhSqcY1QAFmY6Niwhv/xRKElk5YeWJxLJMKS4P
         kGT4EiDaomup+ncvQzLZNa1WsJuY/Dq+uj8kfxUuqE2IGrGp8lBcffUwnmE3TE0pFNYq
         7L54rTsCvEZyTy41ZWaNstN1GFbi7SjgpF6rgM8+sg5+T1FIHmXIX0FptcWkI0n7q74b
         cQfP81Ha4pS2+ZbHjbMpQdntLxpuS3rvYLtXM/48SAih0/FFdhtOoJ0SYjNqChDkPKX8
         0DwqjYKQM9alobwKJouajJ67gPXPaT5yAyxS4DCoLkG8bqBpVP6SLgHV4gspOlu0ssdj
         FIOw==
X-Gm-Message-State: AOAM532iHhlZDXBw3KH67vgJZ/FecN+KGuUWnT9lNZt6MdSf+Ww/teyi
        tZtiAMx9a6WBFBmzLj4Br0GNjLJo6/LycFg0lHGr
X-Google-Smtp-Source: ABdhPJyDdDgCiwsia4C5LS8zgvFHqvr9cO2KPzCBAm/UdMeRQ4n/Cu/im9mDHTpo1K7pQt+cLob2weRKs8YgJjfuxi5p
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:4d41:: with SMTP id
 a62mr537955ybb.394.1632847808169; Tue, 28 Sep 2021 09:50:08 -0700 (PDT)
Date:   Tue, 28 Sep 2021 09:50:04 -0700
In-Reply-To: <CAPUEsphk9b0TpUDgW9qkG=ehKx+hPi5GNtqTP2o2MeL1VpHHPQ@mail.gmail.com>
Message-Id: <20210928165005.228922-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <CAPUEsphk9b0TpUDgW9qkG=ehKx+hPi5GNtqTP2o2MeL1VpHHPQ@mail.gmail.com>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: Re: [PATCH v3 2/3] win32: allow building with pedantic mode enabled
From:   Jonathan Tan <jonathantanmy@google.com>
To:     carenas@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, peff@peff.net,
        avarab@gmail.com, phillip.wood@dunelm.org.uk,
        sunshine@sunshineco.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Apologies; it is gone already in "seen" (and hopefully soon in "next")
> by merging js/win-lazyload-buildfix[1]

Ah, thanks for having fixed this.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC121C4332F
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 00:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbiLBAac (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 19:30:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbiLBAaL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 19:30:11 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DC9B0B74
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 16:25:28 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso6841458pjt.0
        for <git@vger.kernel.org>; Thu, 01 Dec 2022 16:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ecaTcrec3EkFTRI2UKqRRLjtwvJzVBD53azzNqTAD3s=;
        b=avqpDI4RvkiwqeFYt/xdbGb1MV1vWKhxdhK28XfbPUgJwIqK/WEry0h1yuoWf5fTo8
         hThjp0c3ludlZyNBYhS6CGr6NzApLGgTXZZF5FtN7gZSsJj7hcswH7zHapQn76F4QuQW
         zolAv80xN5cyTLUF/fD6HaQBncweRvvpyNnkIfVSCDVB4K/EFnt5O7Z5A+mHET3QoT9H
         Dx+zMfM/NUZfMtnPoLZ7HiJ2Nal5+VC4kIZNepVUAqelTuyI+JtoZw+YDBjXx+CDg0UD
         EJicS277jphdcUQHaet6YY5UEse6XCEqksjxSgH/jptEPHXHJHEAZwY/zWuRu9Hfe2ok
         IWcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ecaTcrec3EkFTRI2UKqRRLjtwvJzVBD53azzNqTAD3s=;
        b=QH8/QZAgQ/6/0+QSMtPblgXxopkHxCP9fPKKSLblFmGcQXSb1QperyFXQQ452J37HW
         IX7vol2Qsi6JMdUZwhVzAguPCchgUTyU8IwMD6SCuwbEwCRaqHJ7rmlp8ElbCMhe/ANt
         3J0XGw3QxxndORCpRnQD3+Bx+rtCZJHwpjfg5LLzKRdwDrjuBwTB9akCQpEMXO/Hgevu
         TX8VMt55HkJ3jvcUWSuH2Vj1QR/x4A4tYRyuH1EirYs1Y6ET4GQ33vhl3F4EnskHiot1
         gnaXh2kc36hCj1/Zai3S1+SXseI5A+BipblZXGocmkq1vcBoo6PuEOYrdmYxnzhNhDWz
         NTMg==
X-Gm-Message-State: ANoB5pkZYxlfTqvDOiViaTpIozYgJQbSvkFVlDBFtny3BKuL6O+OE9oV
        ZOmd4Sj1txBvNuSwwKa615M=
X-Google-Smtp-Source: AA0mqf6t/aS9slFx38IdiTqRI26VkciFBkCCxSyLUPBpy46lIo6Crvvt/JEfOvLz4HvOfWRau3JSGg==
X-Received: by 2002:a17:903:2112:b0:186:cf82:91d5 with SMTP id o18-20020a170903211200b00186cf8291d5mr63279047ple.87.1669940727892;
        Thu, 01 Dec 2022 16:25:27 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id d8-20020a170902cec800b001867fb4056asm4231211plg.32.2022.12.01.16.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 16:25:27 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org
Subject: Re: ds/bundle-uri-4 (was Re: What's cooking in git.git (Nov 2022,
 #07; Tue, 29))
References: <xmqqsfi22j67.fsf@gitster.g>
        <b223202b-0ae2-bdb5-e9d6-21a6321a9e31@github.com>
        <81dbae6e-b198-c056-5107-99c88ce77f94@github.com>
Date:   Fri, 02 Dec 2022 09:25:26 +0900
In-Reply-To: <81dbae6e-b198-c056-5107-99c88ce77f94@github.com> (Derrick
        Stolee's message of "Thu, 1 Dec 2022 10:06:50 -0500")
Message-ID: <xmqqedtir6rt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> I have discovered that the problem is due to the test variable
> GIT_TEST_PACKED_REFS_VERSION=2, so instead it's probably best
> to eject ds/packed-refs-v2 from 'seen' instead of ds/bundle-uri-4.

Thanks for digging.  I've shuffled the order of topics in 'seen'.

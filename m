Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C753DC433E7
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 09:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6276C2224A
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 09:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ufibu4dM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389023AbgJOJvn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 05:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389014AbgJOJvm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 05:51:42 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A84C061755
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 02:51:42 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id ev17so900824qvb.3
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 02:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=l7e0V0zCZIl51dSIxoAkqjtVLttAEjKLLkWY27feHJM=;
        b=ufibu4dMnksDZwpcLR+p8RAJwwqkt8RswDYLAvPTLev4LnIDDsLBRoWCoUxt2qm4aB
         f0fWKPwd1tSTHXXVQbB2it7f8fX5EBwTwO+UUeGkg8ncD7tSZCpXn6yRsB6FS6ASu6x3
         Vqk3WRU8o77rvcqWrTbKALmh6fV6mz+FIEG4rvaUB/IFU8AGaI17WeYdmecvHDHNiQbb
         v3JDKDVrDHQGTLv77QW4um20cH8kWqTJOseFanhwm3zK8loyMeMW0XflGByuRvkKF5Kh
         RfCi7y8402g5WNLQRmDJQ6XcOq0Ocp5tbhC3UhESPB5V0m1Gmp4Vq5IrfhOE0x38fLR9
         Q68A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=l7e0V0zCZIl51dSIxoAkqjtVLttAEjKLLkWY27feHJM=;
        b=ukbtmdzFqKhYjpKTNBDh5hSbk9AJIlWZ1Src0YB7vF+LJJCK0EOXcqrggtZTlCK4Pr
         0ivZn5CrL7o3g4vHQWdLD3OaGyfknouU4cLDXAE+PwwJJAD9nQyZuaYfYbtscbZG/5Y3
         0oZe9ahiegiP8oSPMy3j6W/q3crGtC3tP7VdrqlR2PGtzcqH0GOCDpOEhggwVJaIje2H
         6b7j4i2Jd0I2Ks6TD+KzS280Bdx3kiwG7xbcMM+/QFV6OFPbZrYPYp+FiHtGaWxKngW0
         FEjZcKOxSdlse/uSzpj0uwTC6o9xiKqpLenhqd6zSl0TvOy8udghAAhexjsdcFKMOkvq
         bsjA==
X-Gm-Message-State: AOAM532TcUzHcHzicftRNpSYGEV6jPuIq0YAS+igs/ibiwZczCil6L1d
        qwYNVg2HUdHzWvLc6GzFD+LupPqLs7Y=
X-Google-Smtp-Source: ABdhPJxHG3BTCG6QgTCgmMxC4XXOgx/O4Xl/tWI236CJlPf8FsBpmxAD9NrDFyW9wtM6SOJmZR+pyw==
X-Received: by 2002:ad4:42c6:: with SMTP id f6mr3507216qvr.21.1602755501438;
        Thu, 15 Oct 2020 02:51:41 -0700 (PDT)
Received: from [192.168.1.55] (c-174-56-144-2.hsd1.sc.comcast.net. [174.56.144.2])
        by smtp.gmail.com with ESMTPSA id a10sm955408qkc.79.2020.10.15.02.51.40
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2020 02:51:40 -0700 (PDT)
To:     git@vger.kernel.org
From:   Leam Hall <leamhall@gmail.com>
Subject: Branch Management questions
Message-ID: <595540a9-0000-8dcd-c555-3168d1b2d066@gmail.com>
Date:   Thu, 15 Oct 2020 05:51:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

1. Two developers.
   Dev A is working on Branch A, off a release_candidate branch.
   Dev B is working on Branch B, off the same release_candidate branch.
   Branches usually run 1-4 weeks.
   Dev A does some work that would help Branch B.
   How does Dev A get the Branch B work that is needed, in a
     way that does not confuse the merge process at the end
     of the release cycle?


2. One developer.
   Working on Branch P, realizes that a new functionality X is
     needed.
   X isn't specific to Branch P, but critical to it.
   What is the best way to deal with X, knowing that further work
     on X will need to be done?




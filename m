Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBF9ECAAD3
	for <git@archiver.kernel.org>; Thu,  8 Sep 2022 00:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiIHAED (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 20:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiIHAEB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 20:04:01 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE72DC2EA2
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 17:03:59 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d12so16156643plr.6
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 17:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date;
        bh=ajTFOu9opvb1FuGsWZ2PDUxSXrwhkuoLi0WxLG/WX0E=;
        b=GWcW0X7Xq9kEdh7uSTwsY0yTtLuZI++Cg9YFO2E2MwYeIxiRB3L9rTzNp7ZP2prpLd
         pE+irj/qdvpRK02IYLJpRbd7BDQy1hV6fwnbZZDJ0rImusAPd5+k3ST+N/kWbbNN2OQS
         nW9uqJ5OAbOSx+2cfepndzgVggpnBhlIRUX6M3yXDNfIMvllLPzni1dv9BMZeERWzSD+
         muTfbXq8ZjenYfVPTVmmFevGN+1lG6qpSu725vgqLDjsXn7o1TEttQtzj1cdyi+fjkZf
         LgqOQRPQOfLKwHLCv93Aykcm6IJbsSlb7prvF6mpIBechdWYgvBpyUWJ1J7UO+m7el2h
         Fl2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ajTFOu9opvb1FuGsWZ2PDUxSXrwhkuoLi0WxLG/WX0E=;
        b=4iKFufK2DnNnDJZGudY+Fy/qlAGSTLmoDkT3BONCkDKfZSOG3Q3XBIjPuB/fEjWX3h
         dQqC/VK7hochuOitWxeYF+v3L5WFK5Pj8/LVyhxNMBzjN+ip/M9VfTh5tBAxK6hm130G
         Wi5UeXHXzipulYjdOD218U5MVNs38VYpMbun2S/aW8ve9adzRj8xGxqF0ysQPzmbMAhQ
         EQXcb6ziMVq0w5tXFcv6s5E8SlIADyUCBOqc0ctxSt/aWMmmDeINhceceJTewGWkYywV
         3FwgFtQepetKs0LD+EjsYPbk/enPqeC1twydesLdOorSHxYVFTal+cj1hu+CmDAdFHvo
         AQ2A==
X-Gm-Message-State: ACgBeo3oqOw+gK9BH2atn7m1IjdKPb6w1eKy2c7AhlBid+XMtxT8fF2A
        KGWVU+KutgQ7KiGs9Cf5J8t2mNXTwjc=
X-Google-Smtp-Source: AA6agR4DPP9okeABwHCKeB/xhVPw5kAU0CPFoK84J6Xn90+nHp7fsp83B4YdlvxQh75+VPgAaq+EHw==
X-Received: by 2002:a17:90b:4b06:b0:1fb:29d0:7363 with SMTP id lx6-20020a17090b4b0600b001fb29d07363mr1071007pjb.12.1662595439400;
        Wed, 07 Sep 2022 17:03:59 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id 198-20020a6215cf000000b0053e6b092294sm2583405pfv.212.2022.09.07.17.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 17:03:58 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: Re* [PATCH] tests: replace mingw_test_cmp with a helper in C
References: <pull.1309.git.1659106382128.gitgitgadget@gmail.com>
        <xmqqwnbv7trp.fsf@gitster.g>
        <354qp59q-r4r3-1971-5o09-71q224911orp@tzk.qr>
        <b21d2b60-428f-58ec-28b6-3c617b9f2e45@web.de>
        <xmqq7d2fywvr.fsf@gitster.g> <xmqqlequsvt4.fsf_-_@gitster.g>
        <22402f5d-c463-acee-f57d-e507f23822ca@web.de>
Date:   Wed, 07 Sep 2022 17:03:58 -0700
In-Reply-To: <22402f5d-c463-acee-f57d-e507f23822ca@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Thu, 8 Sep 2022 00:39:53 +0200")
Message-ID: <xmqq4jxispe9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> This test passes even without the changes to diff-no-index.c above.
> Because diff.c::diff_fill_oid_info() sets an all-zero object ID for
> stdin on both sides, I guess, so the comparison is skipped even though
> the data is read already for the first dash and the data size of the
> second one is thus zero?

OK, that sounds like a happy accident ;-)

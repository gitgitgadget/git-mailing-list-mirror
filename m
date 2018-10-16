Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11E9D1F453
	for <e@80x24.org>; Tue, 16 Oct 2018 02:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbeJPJsj (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 05:48:39 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38628 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbeJPJsj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 05:48:39 -0400
Received: by mail-wr1-f66.google.com with SMTP id a13-v6so23490302wrt.5
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 19:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=rfDpXdd6wIIpRcTnBav/miTX2egig1oApuXC0Bu6l08=;
        b=H3ZvNru7d+sBSq4VkVQAhd5r7kJGH5CV5YsK6VuKH7wRygd5dVzcBfk7+XDEG+lsck
         noV5uc14HhM7s6JenxnWXWiYiQBnYBbKsLODPs0GQHKHcrkJUXiTOhUmgn2cuCR2fLc9
         wzEiEQEnp3//aVpaVwK5R+xlRzwg1aXcaJgQIVoq8Usb1+ZExbbWQ0OmemmAVW56Z0/Y
         SBsYi+lFQNQn+XRR1iMMLgPmRcv6YrFyolMUKe1GGPmsJ4JTvAdJx6cTUXMO+fWCR9Lf
         6HcCz0kKV+tphAtUtm/t7j+4DK1jyvySNvl5v4kI2SANFhdi2fD8wliPO5AfbZOk7bTe
         +MzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=rfDpXdd6wIIpRcTnBav/miTX2egig1oApuXC0Bu6l08=;
        b=N9/kQ2MutP0nhsbbedKCJ2p3E+ZLyKsxubryRtNo3/txb44umdT/NaQpqNVq6cn61m
         WxhDwyyRoLb6mDen/4OGq/h4oMaAJ78+BZpqMF+nWWNtzQMRTWckbMfKLv2Yzln/TZTc
         Xd5hTl+8tYtSgueopkdOBpibBWeL8cnuhondSgFocvBhXjhkXhMdynbJP1A0jRD4qih3
         PwQI9EU335YGpr52piWPo4TE7FXAw3roNyWY+qDH2uOIpQPy3YXYCNLBn9NlV5qo3Jn2
         9iQXq6d9lnzsNLENSGvmvwMUsspbgBOymgd5VL+GuMq4JFm86e7LOaAET+CLrlozGK80
         PFNA==
X-Gm-Message-State: ABuFfogVA46hLhd6FkweNXqjI7s0GwA/srTJ1D5HJ0BJGWvF8CjC3FVu
        63p6jPRWi3CHt8OgKKrr4os=
X-Google-Smtp-Source: ACcGV62Vg0SjeW2kx3vwYYzqQrk4bfKRfBq6OtqjBbi4OtBEuXMFNfqIUpX+pPDrKpQ5PAcHupGtRQ==
X-Received: by 2002:adf:cd8c:: with SMTP id q12-v6mr16921040wrj.171.1539655240953;
        Mon, 15 Oct 2018 19:00:40 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id k7-v6sm13451182wmf.22.2018.10.15.19.00.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 19:00:40 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 00/13] Base SHA-256 implementation
References: <20181015021900.1030041-1-sandals@crustytoothpaste.net>
Date:   Tue, 16 Oct 2018 11:00:39 +0900
Message-ID: <xmqqd0sa4pmg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I realize the increase to GIT_MAX_HEXSZ will result in an increase in
> memory usage, but we're going to need to do it at some point, and the
> sooner the code is in the codebase, the sooner people can play around
> with it and test it.

Thanks.

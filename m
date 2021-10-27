Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C95C433EF
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 13:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7553C60F0F
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 13:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235710AbhJ0Nay (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 09:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242146AbhJ0Nax (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 09:30:53 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7054CC061745
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 06:28:28 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 131-20020a1c0489000000b0032cca9883b5so4985067wme.0
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 06:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9g+YisL1AWwI4sDGK9QbgPnwxr2qu5wWAHHbu+l1rKY=;
        b=PFBoiPRgEhtTUD+MA34VlnGUQ+hJOEcXKm0ICr6d6BfHkjTLjvRpxjzNCvaBrBYnAv
         dHWim3+iyaSY/gq9oB0+gdBK2OXS8hxtVd0x07QK5N3dmrc9+gq5Eb3MKeM7EJmZnzhS
         fOKXQVNksftRkcDdh92qHbX08es0q0oOfBukQ8BDjQRBzfa6OV8BVGX5rGiKwDY1Q0WM
         JbEkgl0fTEYtlYn7msJPzfy5MjgR5xXHdNMt2esA6xLpbqtbqAUky5SuL9M2vjJF0fx3
         6QTqGQRLC8qfGlAbrcofv/ywMb3+uiwwTPQCCJcp4C1twcJr3p6ZTxpsjRBdJ6Y7fIpD
         RBtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9g+YisL1AWwI4sDGK9QbgPnwxr2qu5wWAHHbu+l1rKY=;
        b=kJCBQYL1l9sY8R9U+3PBpgF43MEujtbkYvf52zRvfnc+LnBFMHmcAFufdwx9V9e+Ye
         5Luz8JYrluCh4/KpySCG1qJs4BxCUg75EBTals9KzPnzbRktl6gbTeMn6mpbXIqHSKMp
         xJWn/WF/0AFuRQQqc0IsVHYSLYazzB8HLRywqg7ZHd82PbPn8tKfW1451qP9BwBk68LB
         N1gh0KBBKUay8hXvobg55UhdQswL6zQ3/3IfxHrE8ZqIm1vE2YeMwdEtX8yvzmTiAp1S
         xLka4dC0lldTXI45EcnxlCaYhgOw5XyQf1j/WKZmqpN+PXnC8KsKh8o6z3JHtfyvVRfh
         BUoQ==
X-Gm-Message-State: AOAM532cT4qIvQ2PPXsEqU63rxFv+NJG0nvkf1d2x+EJagnPvKJL/aYE
        kMNSLYFuhoWt40+xDS3EBT8=
X-Google-Smtp-Source: ABdhPJwe3gG17w2839i4N8haFPdjzyWnxXWchJUCvFOXg2rSUTkdRdT9d+VdVRjN11c1Z8ex2VHEmA==
X-Received: by 2002:a05:600c:1c21:: with SMTP id j33mr5632315wms.163.1635341307082;
        Wed, 27 Oct 2021 06:28:27 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.186])
        by smtp.gmail.com with ESMTPSA id t3sm3327536wma.38.2021.10.27.06.28.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Oct 2021 06:28:26 -0700 (PDT)
Message-ID: <d359c8a6-412f-98eb-8509-15267cdb0988@gmail.com>
Date:   Wed, 27 Oct 2021 14:28:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 00/15] diff --color-moved[-ws] speedups
Content-Language: en-GB-large
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.981.v2.git.1626777393.gitgitgadget@gmail.com>
 <pull.981.v3.git.1635336262.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.981.v3.git.1635336262.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/10/2021 13:04, Phillip Wood via GitGitGadget wrote:
 > [...]
>   * Patches 1-3 are new and fix an existing bug.

Sorry that should be "Patches 2-4"

>[...]
> The bug fix in patch 3 degrades the performance, but by the end of the
> series the timings are the same as V2 - see the range diff.

It is patch 4 that degrades the performance, not patch 3

Best Wishes

Phillip

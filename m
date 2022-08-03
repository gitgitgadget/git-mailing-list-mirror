Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D538C19F28
	for <git@archiver.kernel.org>; Wed,  3 Aug 2022 11:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234463AbiHCLuS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Aug 2022 07:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbiHCLuQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Aug 2022 07:50:16 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6C028D
        for <git@vger.kernel.org>; Wed,  3 Aug 2022 04:50:11 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id b133so16226496pfb.6
        for <git@vger.kernel.org>; Wed, 03 Aug 2022 04:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=TFEMgeTi/51bM0PaLqIEAMdBvWyFOcusBZjWc0jQ5rs=;
        b=MAEv/Pq9te3gP1KfDdOBFjkUYH2l7pysWT9lwH6nu49pl6oJjGFi45UNj0ie50p5cL
         wwMjrxeeRKlD8zAK1LO0fG3huIj5nq8XtDwbWJQdTAH92NeDocSqKRO6Yx40bIoEQt0r
         OtU0qUpg+rzhinH/b3zrHzO4UlYx4NX46pX+53iL18dFK3YyEyOXZm9fj4omLaHdRYKU
         +XhgQ7oP4V/k73hmwITId0Yg6MtYW1+evidNvpFnN8srxADxakAqo8M2mIbabm02xk8B
         Q3twtX1ejYAvfiVbDk3mNpwJBUowXkSSLtAfi6uaKpUUWlHQ5589zvh3YCBoHCEfU/zE
         EAVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TFEMgeTi/51bM0PaLqIEAMdBvWyFOcusBZjWc0jQ5rs=;
        b=cl2r8P2eOc8+vDAb3BYxPaG3ZPuoBBjzKV64fNCpxTwEVWK4OeGZD5s8n2guyvNlt8
         kwJYifKINmlF58ATTEv9IQ39zEBMHsseqYddiOdX2kegmjGoUhwL2Bo5E09rtvoXThQY
         ccHuDYbu2zV2f9q322xjquifTNAM6dgHx4nWMslSepOg3H4JNqPm4cXyh20hir7yHv0O
         PS6d31kwyAfzHzj0+0q9nCqU7QpK+4RuyKa10q/8LgKg9WtPPF1eAXbOYPCb01u/JoNX
         A9dVjY2Wn9Mykt0Y7pB2pxMUZMtfYeKZJ6lBwfRYKwDP3G+OXhf8u+Zdf2LEe7WXK/5H
         T/nw==
X-Gm-Message-State: AJIora9/rStd5QSuSscoY6lrAVHa6n2oCBYTrzwhu97m6xzddEKfzQZx
        6mjmLOQArV+Elp4NvoTmob8=
X-Google-Smtp-Source: AGRyM1v0RbI8/D+y8YeoDwnzwN+D1zb314gOn/8UQ4UyTW9k6TxBfhVhM82c7a+NTaXsCYs2vI4vmw==
X-Received: by 2002:a05:6a00:2347:b0:52a:cf39:59a5 with SMTP id j7-20020a056a00234700b0052acf3959a5mr24720193pfj.28.1659527411308;
        Wed, 03 Aug 2022 04:50:11 -0700 (PDT)
Received: from [127.0.0.1] ([45.138.210.17])
        by smtp.gmail.com with ESMTPSA id e5-20020a17090ada0500b001ef8780f873sm1369769pjv.39.2022.08.03.04.50.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 04:50:10 -0700 (PDT)
Message-ID: <9a568923-0b2c-8c41-e774-bcf8e6e9d9ea@gmail.com>
Date:   Wed, 3 Aug 2022 19:50:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 6/7] mv: from in-cone to out-of-cone
Content-Language: en-US
To:     Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org
Cc:     vdye@github.com, gitster@pobox.com
References: <20220719132809.409247-1-shaoxuan.yuan02@gmail.com>
 <20220719132809.409247-7-shaoxuan.yuan02@gmail.com>
 <d30a358e-c9f0-55fa-8c8b-37f0cb0d7eb3@github.com>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
In-Reply-To: <d30a358e-c9f0-55fa-8c8b-37f0cb0d7eb3@github.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/20/2022 2:14 AM, Derrick Stolee wrote:
 >> -        if ((mode & SPARSE) &&
 >> -            (path_in_sparse_checkout(dst, &the_index))) {
 >> -            int dst_pos;
 >> +        if (ignore_sparse &&
 >> +            core_apply_sparse_checkout &&
 >> +            core_sparse_checkout_cone) {
 >>
 >> -            dst_pos = cache_name_pos(dst, strlen(dst));
 >> -            active_cache[dst_pos]->ce_flags &= ~CE_SKIP_WORKTREE;
 >> +            /* from out-of-cone to in-cone */
 >> +            if ((mode & SPARSE) &&
 >> +                path_in_sparse_checkout(dst, &the_index)) {
 >> +                int dst_pos = cache_name_pos(dst, strlen(dst));
 >> +                struct cache_entry *dst_ce = active_cache[dst_pos];
 >>
 >> -            if (checkout_entry(active_cache[dst_pos], &state, NULL, 
NULL))
 >> -                die(_("cannot checkout %s"), 
active_cache[dst_pos]->name);
 >> +                dst_ce->ce_flags &= ~CE_SKIP_WORKTREE;
 >> +
 >> +                if (checkout_entry(dst_ce, &state, NULL, NULL))
 >> +                    die(_("cannot checkout %s"), dst_ce->name);
 >> +                continue;
 >> +            }
 >
 > Here, it helps to ignore whitespace changes. This out to in was already
 > handled by the existing implementation.

Yes, I think it would be better to let `diff` ignore the existing
implementation. Are you suggesting the `-w` (--ignore-all-space) option
of `diff`? I tried this option and it does not work. But another reason
is that there *are* some changes that are different from the original
out-to-in implementation, so even though it looks a bit messy, I think
it makes sense.

 >> +            /* from in-cone to out-of-cone */
 >> +            if ((dst_mode & SKIP_WORKTREE_DIR) &&
 >
 > This is disjoint from the other case (because of 
!path_in_sparse_checkout()),
 > so maybe we could short-circuit with an "else if" here? You could put 
your
 > comments about the in-to-out or out-to-in inside the if blocks.

I tried an else-if but it does clutter the code a bit. I think I'll
leave it as-is. Or do you mind show me a diff of your approach? To be
honest, this disjoint here looks logically cleaner to me.

--
Thanks,
Shaoxuan


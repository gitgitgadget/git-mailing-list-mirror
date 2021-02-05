Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA68C433E0
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 23:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3864C64FEF
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 23:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbhBEXCW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 18:02:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbhBELnL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 06:43:11 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB66C06178A
        for <git@vger.kernel.org>; Fri,  5 Feb 2021 03:42:27 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id a19so6550573qka.2
        for <git@vger.kernel.org>; Fri, 05 Feb 2021 03:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1ANRM/+3vdcmKx38BhEERTNcvz/Yf+KNcP+yuNNL3Hg=;
        b=pUIoOOXRn9fRCpIV2VpYw0QckfJJC8RG5+SMeR/JI6UdsjIpfEDbn9+2KZgZTmP7uk
         F2UhUChB6eLZ8HkTVjvslDWK+qEdaEUCMszapuKHt0UaG36qEsxzkf+ZKgBK1TXC6q8N
         LddInLjrz79kqtgiW0twOnxODyRxfyv84QHCOmz6+hBujzIesX8gALt+q6/F55hW2v/c
         SdHS+omKBzj3gDd7ODXgTp8/4Tx8fK125kk7DUg/5LKXRuSGYJ/lis36GLMhcdCVwIca
         WNACq4Nv4AKqeO50cLyzTCiaU2R4BFs76s2k8NwRC495LjhezVyRrCxOQ9k56MjBxPDx
         0PmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1ANRM/+3vdcmKx38BhEERTNcvz/Yf+KNcP+yuNNL3Hg=;
        b=bqjXz17ewwIvtv7koSULjN2StFkB02pN9P6BOhmcMfuARnq7Y2uI5Xdmx4SOlggdXU
         JCvJu1D46j+BMfdv9ytiTIo2qihtRi7CZ35kAwAEd1kTJ9s1qEnXcJXKIb/Pcgfj5QpG
         2LRI4yk3+Y0GoaYrFjys0CmU6NuPmnUcsXc0Xs14Jp8azBFM4CxWcKoiR/xHHpk9FvGS
         Eoyb7cMHU9G1n3l5MsWnItBh8mqOGsF4fWh1Utu0cGF+CWTQQ9Po5zRLZpFB/Dg8RCiY
         MDz9KTBq89mVxIciCB6w9mBN2NrG53XRGuRfO3RgwrmVSSqhcI87NrPHbh/H754NHxQO
         /UPA==
X-Gm-Message-State: AOAM531UgVrpk3H7VqzlFfagNELzOBpeWG+ipWFshnJVlze3/Qd4uZJY
        FpONtEvR7nbu0Hp9s3K+kt8=
X-Google-Smtp-Source: ABdhPJwunLBRJABGfSZmTD+KJY3v75UcztiVIkjHXkab9P++ZYWUs2DyTD8g7Bz6ajB1wjqoywWCLA==
X-Received: by 2002:a05:620a:13ae:: with SMTP id m14mr3701105qki.35.1612525346160;
        Fri, 05 Feb 2021 03:42:26 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:4dc9:c09:30f7:a417? ([2600:1700:e72:80a0:4dc9:c09:30f7:a417])
        by smtp.gmail.com with UTF8SMTPSA id n8sm7178110qta.61.2021.02.05.03.42.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Feb 2021 03:42:25 -0800 (PST)
Message-ID: <b00734a3-0a45-463b-55b2-ef8cbb19d76b@gmail.com>
Date:   Fri, 5 Feb 2021 06:42:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: [PATCH v2 09/17] midx: return success/failure in chunk write
 methods
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, l.s.r@web.de,
        szeder.dev@gmail.com, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.848.git.1611676886.gitgitgadget@gmail.com>
 <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
 <b3cc73c22567ed89e2537ffaaa04f82a436d9802.1611759716.git.gitgitgadget@gmail.com>
 <xmqqlfc34eyd.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqlfc34eyd.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/4/2021 5:59 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> In this step I see the same "f->total + f->offset" sprinkled in some
> places, but they will all go away in the "midx: use chunk-format API
> in write_midx_internal()" step, so it is not such a huge deal.

I'll move the ones that are introduced by this patch, but others
already exist that also get removed by a later patch. I won't
touch those until they are deleted.

Thanks,
-Stolee

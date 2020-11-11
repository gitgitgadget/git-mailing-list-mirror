Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD7E5C388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 20:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EA3D204EA
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 20:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cab+DQFJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbgKKU65 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 15:58:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgKKU65 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 15:58:57 -0500
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31B4C0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 12:58:56 -0800 (PST)
Received: by mail-oo1-xc42.google.com with SMTP id q28so774376oof.1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 12:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zSWpSd0p05pP3hS5qhACN8RfgRZOchBZ147Y+dEruCs=;
        b=cab+DQFJToOn9WqXAKmXe9SvJF2D4LEt57Euf6MJ4rkY0XFBc5Ny9YvxK0n7T565yo
         1D6uks0NJQX0REO72CDvqNLGspkf6sLWpqkaZ8s1ZkCewzsr7ojkGuMrJ4duPSi1iTQ2
         wa6XgEaU5yF2a9cfQaqCxuxH3rZHcRJ3m5yeatnbW8aR43q2mINItoA77u6B6ERc4H6Q
         fDcxcUEI/BEISBlkZQyGsyKbjKLNqgVaj3+UMdez3gKXllzZpxCwJruUSWqO2Wm4GoUJ
         txvyjUiBFd4g/IEqSfs1DulD05dUs1eAdwYldp51fVR8obeINvv1WouGrrp+qO2JXxsH
         7+kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zSWpSd0p05pP3hS5qhACN8RfgRZOchBZ147Y+dEruCs=;
        b=BUrZa8yKhqO+SFOyb3hL6IBqhkxKWCXxY2yhRjXD21q7nnfRCUvmggQIoR3Qs2cfRF
         6kMtCs8r1wAoorDCqGGHvaU8Um+WFTYrca7tIVcFoY0FQ8tGcBJdz0eVU/+ynFKLK14Y
         CMEdpRPkr2ENpzJObdZw+yKSHzAWXNXqUzV1OMc/FFgiU/+vasplvYSCFx6haf44sFde
         msR383tK/QxAlLPu4CRAsgjGGKy+67iI+PwWLpRXNFxY0MjbaZVnHAr5pBao9Feah7PX
         JYWuzVTytnV1CE3IXBlT02gCmOYx6PJRXb7IQtqwGdcFBDmmF39s/CX22S0wCkg/LOgK
         8JYA==
X-Gm-Message-State: AOAM532qMEIfLUqDuFN1E295di0NP7WbTjv+BYC8JMHkziB7D9u379xj
        aROlSPmNuofZTQUH+j2bNHA=
X-Google-Smtp-Source: ABdhPJzptZVhrcsWrYrgOCgMNYUtmBTO7/G/ZMIDPVMWVWahX/J9tph21IId5TLBdhUBYGsh+rraJg==
X-Received: by 2002:a4a:b188:: with SMTP id c8mr13282210ooo.61.1605128335899;
        Wed, 11 Nov 2020 12:58:55 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:c9d4:abc:8d:1568? ([2600:1700:e72:80a0:c9d4:abc:8d:1568])
        by smtp.gmail.com with UTF8SMTPSA id o29sm763332ote.7.2020.11.11.12.58.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2020 12:58:55 -0800 (PST)
Subject: Re: [PATCH 15/23] t5310: add branch-based checks
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <cover.1605123652.git.me@ttaylorr.com>
 <9ab4b94b3573346b31e710486799ab3d95bade8e.1605123653.git.me@ttaylorr.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <abf9273f-4795-5a48-c28b-15e68d40b910@gmail.com>
Date:   Wed, 11 Nov 2020 15:58:52 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <9ab4b94b3573346b31e710486799ab3d95bade8e.1605123653.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/11/2020 2:43 PM, Taylor Blau wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> The current rev-list tests that check the bitmap data only work on HEAD
> instead of multiple branches. Expand the test cases to handle both
> 'master' and 'other' branches.

Adding Johannes to CC since this likely will start colliding with his
default branch rename efforts.

> +rev_list_tests () {
> +	state=$1
> +
> +	for branch in "master" "other"
> +	do
> +		rev_list_tests_head
> +	done
> +}

Specifically, this is a _new_ instance of "master", but all the
other instances of "master" are likely being converted to "main"
in parallel. It would certainly be easier to convert this test
_after_ these changes are applied, but that's unlikely to happen
with the current schedule of things.

Thanks,
-Stolee



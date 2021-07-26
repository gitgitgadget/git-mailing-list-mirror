Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0828C4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 13:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D39B60F45
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 13:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234219AbhGZMUj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 08:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234072AbhGZMUi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 08:20:38 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6330AC061757
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 06:01:07 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d2so6905007qto.6
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 06:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=fMnT2KK5ZmQ/HrDH9JNap1jkXv4brJmA/5Kh5sIrnAM=;
        b=A2s9+ycZPH6vzLmLv+st03UZJgqgrlMryCVXeI2VruPX1kAGf4p87xGM6BCr1yCGHJ
         PJCq+PLL7ppPJLcBW2xh+ccVpaJQx2qVrRaGDt9TISVmkhuILwYmfJW5seM2P7XrQzyQ
         hDOACk/DAqD3aLuWy60tlxn2CbkEJefDZ/ymX5gBv6RYZIb25TurvPinYtnhmFUiqren
         GdedAOoPTZrIH830zame+iOldnNxXcvjvGhPh+V2ifL2z/1TbfnHEG0u5wCgczrPog6Y
         NX8SF4E2CuPFfp+xRZJjq/zXUSInNxlLzuakbl0ahnJiaTaHMgxQ3LdqC0cl8LBa3AG1
         rwfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fMnT2KK5ZmQ/HrDH9JNap1jkXv4brJmA/5Kh5sIrnAM=;
        b=oY+MsdiQ8QDBbIbBhFLpnAwrgYTq1w37zcAxyHnUBXSGyzBLt5Y11Gms08vYk1o6vy
         iLyE7WtnDuIsxhK/2QDS3J1AJlpQHm9u6hjpkowwEEK6VlQGQaSrNLY1sorChJafYEoX
         2TGwauDqVSkqJFvnHMF6wbc/OfD2L+ly1CK3bGYBS7/dXUHQR0tFREkCQeN9Z+J0A7E/
         8uixMKLAXHiRL8w7oC+wfR/e24Xq/5G8MV0wBB4RM6gQDyyWJ2SlI37xdbUID+lvYtGi
         LcZWXCAq7uap/BsiOOua6YsO8N2oXqCbiAIx/nD2tn/RQ/nJZnbjogxHImNWLvQQOamQ
         wQqg==
X-Gm-Message-State: AOAM532dyq8UWhA0/cTB4N07aZieci9+U3tbJXowY6X0b0XbLnQc/r0o
        G+pcpOtoDTeDF5RQF3+3Z2H5a4J8Qj33Ug==
X-Google-Smtp-Source: ABdhPJy84RYB1ZL1YLibSuvjvT4YrbYxEYuWIywZ86YnwXfz4XpvROmdBzTjPv2wpbq5RQjr2uOWgg==
X-Received: by 2002:a05:622a:1007:: with SMTP id d7mr14998693qte.158.1627304466193;
        Mon, 26 Jul 2021 06:01:06 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:8509:d58a:ff00:9b31? ([2600:1700:e72:80a0:8509:d58a:ff00:9b31])
        by smtp.gmail.com with ESMTPSA id d3sm14990078qtp.12.2021.07.26.06.01.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 06:01:05 -0700 (PDT)
Subject: Re: [PATCH 0/2] Another partial clone prefetch
To:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
References: <cover.1627066238.git.jonathantanmy@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <7f624239-907e-8e69-9419-a812efad9b9c@gmail.com>
Date:   Mon, 26 Jul 2021 09:01:04 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <cover.1627066238.git.jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/23/2021 2:52 PM, Jonathan Tan wrote:
> Here's another instance in which we need to prefetch in order to avoid
> fetching objects one by one. More information is in patch 2's commit
> message.

I know that Elijah and Junio already gave their reviews, but I'm here
to chime in that this is a good pair of patches. Thanks!

-Stolee

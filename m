Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D2EC433EF
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 14:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241616AbiCBOJq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 09:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242787AbiCBOJl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 09:09:41 -0500
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2173150D
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 06:08:40 -0800 (PST)
Received: by mail-oo1-xc29.google.com with SMTP id o7-20020a056820040700b003205d5eae6eso1475864oou.5
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 06:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=LeXHGVXuXdzhe8VklJrwi3zYGGa9gSOejYsukjsKTNU=;
        b=XpqYcjugsCh6uBgECdmECMCDjIiLsqPvDaIQFx+eUMz8grQOZl5wxCV3B1xBWDVDj8
         WpP7owOXV4XMGPNByVP8t8pKlKsw1h0OTl2rtWZNqswBcLINBG+FRYKncv5Cr5j15Ae6
         SPAHGIJPICpqPhxWPlKca/VhHBGCasOjJPqyggS+lRHWX8dOLOH52/srOljPmkdPneCD
         P0DadO/mfOev1hl1+m+CzF+NkK7JoI4vgrTZBiDdka9byFZIaft21Wq1JOrCFX+QCU0F
         d+AdxfNPs4I3ok8Ym4WBSPSTo/SavIc9kGUFowJqPL9BzSU9Xll7QrdesghBZTqDruhJ
         4ZoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LeXHGVXuXdzhe8VklJrwi3zYGGa9gSOejYsukjsKTNU=;
        b=iBYlDXVbRTabX4n0BGAxJHeZGDlrjs64MMRHnC8qTgtBe/taA+t+qn7v5ERTdP0LDl
         nfyVJezdB7uHU78xsOy/ASaU+VrW0/3yQAFQwxqxHM8X86DNHp5YLAsMm2OFs+xwP4Pr
         KtyFG6xcO4DcsA1ZCMTiYrllSlQW0LElB2bL5Ts0Kw8dWBRXvX517nZXD66m0derxyEs
         AHEtA5fq4NtPXrBhYqTPXjXPnMVQIhHYdiBjsmVr2US2nVXNv0Qu8VGfn7R+YRPweach
         +0SX1c3MNoMKtTnDTR6mK5aWHRNGQCqqzgzNNJWMwitkL2fqn33OzGwHdiJln1MD45Rf
         VzJw==
X-Gm-Message-State: AOAM5311JMSW2AQ438tjlXj2mGHMhdwEYVSmR/ECGyA4Hp4flExFS04N
        Szx8DEK5Z2L2PQeuH71jl27+
X-Google-Smtp-Source: ABdhPJz5p72m4+C1389gdcgqONWC1KQOapuvqB71K+e15mNbuGUUQtsW4t6WtSZZgitVk4+pPRv57A==
X-Received: by 2002:a05:6870:b3a8:b0:d9:a7d5:f00d with SMTP id w40-20020a056870b3a800b000d9a7d5f00dmr997402oap.38.1646230117383;
        Wed, 02 Mar 2022 06:08:37 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id i47-20020a9d172f000000b005aed7ea7b44sm7668297ota.73.2022.03.02.06.08.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 06:08:37 -0800 (PST)
Message-ID: <b584336f-460e-bfe7-2d61-6e253ec599e3@github.com>
Date:   Wed, 2 Mar 2022 09:08:36 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] merge-ort: exclude messages from inner merges by default
Content-Language: en-US
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
References: <pull.1167.git.1646194761463.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1167.git.1646194761463.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/1/2022 11:19 PM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> merge-recursive would only report messages from inner merges when the
> GIT_MERGE_VERBOSITY was set to 5.  Do the same for merge-ort.
> 
> Note that somewhat reverts 0d83d8240d ("merge-ort: mark conflict/warning
> messages from inner merges as omittable", 2022-02-02) based on two
> facts:

Makes sense.

> -	if (opt->record_conflict_msgs_as_headers && opt->priv->call_depth)
> -		return; /* Do not record inner merge issues in headers */
> +	if (opt->priv->call_depth && opt->verbosity < 5)
> +		return; /* Ignore messages from inner merges */
> +

Exactly matches your intentions. Excellent.

It might be nice to have a test that demonstrates this
verbosity, but I'm not going to block this patch on that.

Thanks,
-Stolee

